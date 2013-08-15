# -*- coding: utf-8 -*-

#!/usr/bin/env python2.7
from __future__ import division
from asteriskMySQLManager import AsteriskMySQLManager
import datetime
import string
from math import ceil

def getStartOfDay(date):
	return date.strftime('%Y-%m-%d')+" 00:00:00"

def getEndOfDay(date):
	date = date + datetime.timedelta(days = 1)
	return date.strftime('%Y-%m-%d')+" 00:00:00"

class CallCostAssigner:
	am = None

	def __init__(self):
		self.am = AsteriskMySQLManager()

	def getAllBundlesFromDestinationGroup(self, destination_group_id):
		self.am.connect('nextor_tarificador')
		sql = "SELECT * from tarifica_bundle \
			WHERE destination_group_id = %s \
			ORDER BY priority ASC"
		self.am.cursor.execute(sql, (destination_group_id,))
		return self.am.cursor.fetchall()

	def getActiveBundlesFromProvider(self, provider_id):
		self.am.connect('nextor_tarificador')
		sql = "SELECT * from tarifica_bundle \
			LEFT JOIN tarifica_destinationgroup \
			ON tarifica_bundle.destination_group_id = tarifica_destinationgroup.id \
			WHERE tarifica_destinationgroup.provider_id = %s AND \
			tarifica_bundle.is_active = %s"
		self.am.cursor.execute(sql, (provider_id, True))
		return self.am.cursor.fetchall()

	def getAllConfiguredProviders(self):
		self.am.connect('nextor_tarificador')
		sql = "SELECT * from tarifica_provider WHERE is_configured = %s"
		self.am.cursor.execute(sql, (True,))
		return self.am.cursor.fetchall()
	
	def getAllDestinationGroupsFromProvider(self, provider_id):
		self.am.connect('nextor_tarificador')
		sql = "SELECT * from tarifica_destinationgroup JOIN tarifica_destinationname \
			ON tarifica_destinationgroup.destination_name_id = tarifica_destinationname.id \
			WHERE provider_id = %s \
			ORDER BY CHAR_LENGTH(tarifica_destinationgroup.prefix) DESC"
		self.am.cursor.execute(sql, (provider_id,))
		return self.am.cursor.fetchall()

	def getTariffMode(self, tariffMode_id):
		self.am.connect('nextor_tarificador')
		sql = "SELECT * from tarifica_tariffmode WHERE id = %s"
		self.am.cursor.execute(sql, (tariffMode_id,))
		return self.am.cursor.fetchone()

	def getDailyAsteriskCalls(self, date, dryrun = False):
		"""
			Gets calls from specified date and saves them with their cost. 
			If dryrun is set to True, then the calls that could not be 
			assigned a cost are the only ones saved.
		"""
		# Primero revisamos si es el día de corte.
		self.checkBundles()
		print "Script running on day "+getStartOfDay(date)+"."
		# Obtenemos las extensiones configuradas:
		extensions = self.am.getUserInformation()
		self.am.connect('asteriskcdrdb')
		sql = "SELECT * from cdr WHERE callDate > %s AND callDate < %s AND lastapp = %s \
		AND disposition = %s"
		self.am.cursor.execute(sql, 
			(getStartOfDay(date), getEndOfDay(date), 'Dial', 'ANSWERED')
		)
		# Iteramos sobre las llamadas:
		totalOutgoingCalls = 0
		dailyCallDetail = []
		unsavedDailyCallDetail = []
		totalCallsFound = 0
		for row in self.am.cursor.fetchall():
			totalCallsFound += 1
			outgoing = True
			for ext in extensions:
				if row['dst'] == ext['extension']:
					outgoing = False

			if outgoing:	
				print "Outgoing call found, assigning cost..."
				totalOutgoingCalls += 1
				callCostInfo = self.assignCost(row)
				if callCostInfo['save']:
					dailyCallDetail.append(callCostInfo['callInfo'])
				else:
					unsavedDailyCallDetail.append(callCostInfo['callInfo'])
					
		print "----------------------------------------------------"
		print "Total calls found:", totalCallsFound
		print "----------------------------------------------------"
		self.saveCalls(dailyCallDetail)
		print "Total outgoing calls configured:", len(dailyCallDetail)
		print "----------------------------------------------------"
		self.saveUnconfiguredCalls(unsavedDailyCallDetail)
		print "Total outgoing calls not configured:", len(unsavedDailyCallDetail)
		return {
			'total_calls_not_saved': len(unsavedDailyCallDetail),
			'total_calls_saved': len(dailyCallDetail),
		}

	def checkBundles(self):
		today=datetime.datetime.today()
		for provider in self.getAllConfiguredProviders():
			if provider['period_end'] == today.day:
				print "End date of provider", provider['name']
				for bundle in self.getActiveBundlesFromProvider(provider['id']):
					bundle['usage'] = 0
					self.saveBundleUsage(bundle['id'], 0)
					print "Bundle "+bundle['name']+" reset."

	def saveBundleUsage(self, bundle_id, usage):
		self.am.connect('nextor_tarificador')
		sql = "UPDATE tarifica_bundle SET tarifica_bundle.usage = %s \
		WHERE tarifica_bundle.id = %s"
		self.am.cursor.execute(sql, (usage, bundle_id))

	def deactivateBundle(self, bundle):
		self.am.connect('nextor_tarificador')
		sql = "UPDATE tarifica_bundle SET tarifica_bundle.is_active = %s \
		WHERE tarifica_bundle.id = %s"
		self.am.cursor.execute(sql, (False, bundle['id']))

	def saveCalls(self, calls):
		self.am.connect('nextor_tarificador')
		sql = "INSERT INTO tarifica_call \
		(dialed_number, extension_number, duration, cost, date, \
		destination_group_id, provider_id, asterisk_unique_id) \
		VALUES(%s, %s, %s, %s, %s, %s, %s, %s)"
		self.am.cursor.executemany(sql, calls)
		return self.am.db.commit()

	def saveUnconfiguredCalls(self, calls):
		self.am.connect('nextor_tarificador')
		sql = "INSERT INTO tarifica_unconfiguredcall \
		(dialed_number, extension_number, duration, provider, date, asterisk_unique_id) \
		VALUES(%s, %s, %s, %s, %s, %s)"
		self.am.cursor.executemany(sql, calls)
		return self.am.db.commit()

	def assignCost(self, call):
		#Obtenemos la informacion necesaria:
		callInfoList = call['lastdata'].split('/')
		cost = 0
		provider_id = 0
		destination_group_id = 0
		save = False
		dialedNoForProvider = call['dst']
		separated = []
		for a in callInfoList:
			separated = separated + a.split(',')
		try:
			dialedNoForProvider = separated[2]
		except IndexError:
			print "No dialed number present! Skipping..."

		configuedProviders = self.getAllConfiguredProviders()
		if len(configuedProviders) == 0:
			print "No providers configured, ending..."
		for prov in configuedProviders:
			# Extraemos la troncal por la cual se fue la llamada:
			try:
				provider = callInfoList[1]
			except IndexError:
				print "No trunk information present, skipping..."
				break

			if provider.count(prov['asterisk_channel_id']) > 0:
				print "Provider found:",prov['name']
				provider_id = prov['id']

				destinations = self.getAllDestinationGroupsFromProvider(prov['id'])
				if len(destinations) == 0:
					print "No destination groups configured: cannot proceed."
					continue
				
				costAssigned = False
				for d in destinations:
					if costAssigned:
						break

					print "Trying to fit into destination group",d['name']
					try:
						pos = dialedNoForProvider.index(d['prefix'])
						print "Call prefix fits into destination group",d['name']
					except ValueError, e:
						pos = None
					if pos is None or pos != 0:
						continue

					# Se encontro el prefijo!
					numberDialed = dialedNoForProvider[pos + len(d['prefix']):]
					print "Number called according to trunk:",numberDialed
					destination_group_id = d['id']
					bundles = self.getAllBundlesFromDestinationGroup(d['id'])
					appliedToBundle = False
					if len(bundles) > 0:
						for b in bundles:
							#Si ya se aplicó, salimos
							if appliedToBundle:
								break

							#Si el paquete no está activo, salimos:
							if not b['is_active']:
								break

							if b['usage'] is None:
								b['usage'] = 0
							#Si el bundle actual ya se agotó, seguimos
							if b['usage'] == b['amount']:
								print "Bundle",b['name'],"usage has reached its limit."
								continue
							#Si no, agregamos la llamada al uso del bundle
							elif b['usage'] < b['amount']:
								print "Usage before: ", b['usage']
								if self.getTariffMode(b['tariff_mode_id'])['name'] == 'Session':
									b['usage'] += 1
								else:
									#Redondeamos al minuto más cercano de la llamada
									b['usage'] += ceil(call['billsec'] / 60)
								print "Usage after: ", b['usage']
								#Guardamos los cambios
								self.saveBundleUsage(b['id'], b['usage'])
								appliedToBundle = True
								costAssigned = True
								save = True
							else:
								print "Bundle",b['name'],"has overstepped its limits!"

					if not appliedToBundle:
						# Y no se aplicó a ninguno, por tanto 
						# calculamos el costo con la tarifa base:
						print "Billing with base tariff..."
						print "Base tariff bills by interval of",d['billing_interval'],"seconds."
						print "Call Duration:",call['billsec']
						intervals = ceil(call['billsec'] / d['billing_interval'])
						print "Billed intervals:",intervals
						per_second_tariff = float(d['minute_fee']) / 60
						per_interval_tariff = per_second_tariff * d['billing_interval']
						print "Tariff per interval:",per_interval_tariff
						cost = ( intervals * per_interval_tariff ) + float(d['connection_fee'])
						print "Calculated cost:", cost
						save = True
						costAssigned = True
			
		if save:
			return {
				'callInfo':
				(
					dialedNoForProvider, 
					call['src'], 
					ceil(call['billsec'] / 60), 
					cost, 
					datetime.datetime(
						year=call['calldate'].year, 
						month=call['calldate'].month, 
						day=call['calldate'].day,
						hour=call['calldate'].hour,
						minute=call['calldate'].minute,
						second=call['calldate'].second
					),
					destination_group_id,
					provider_id,
					call['uniqueid']
				),
				'save': True
			}	
		else:
			return {
				'callInfo':
				(
					call['dst'], 
					call['src'], 
					ceil(call['billsec'] / 60),
					callInfoList[1],
					datetime.datetime(
						year=call['calldate'].year, 
						month=call['calldate'].month, 
						day=call['calldate'].day,
						hour=call['calldate'].hour,
						minute=call['calldate'].minute,
						second=call['calldate'].second
					),
					call['uniqueid']
				),
				'save': False
			}

if __name__ == '__main__':
	week = datetime.datetime.now()
	week = week - datetime.timedelta(days=1)
	c = CallCostAssigner()
	c.getDailyAsteriskCalls(week)