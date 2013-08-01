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

	def getAllConfiguredProviders(self):
		self.am.connect('nextor_tarificador')
		sql = "SELECT * from tarifica_provider WHERE is_configured = %s"
		self.am.cursor.execute(sql, (True,))
		return self.am.cursor.fetchall()
	
	def getAllDestinationGroupsFromProvider(self, provider_id):
		self.am.connect('nextor_tarificador')
		sql = "SELECT * from tarifica_destinationgroup JOIN tarifica_destinationname \
			ON tarifica_destinationgroup.destination_name_id = tarifica_destinationname.id \
			WHERE provider_id = %s"
		self.am.cursor.execute(sql, (provider_id,))
		return self.am.cursor.fetchall()

	def getTariffMode(self, tariffMode_id):
		self.am.connect('nextor_tarificador')
		sql = "SELECT * from tarifica_tariffmode WHERE id = %s"
		self.am.cursor.execute(sql, (tariffMode_id,))
		return self.am.cursor.fetchone()

	def getDailyAsteriskCalls(self, date):
		# Primero revisamos si es el día de corte.
		print "Script running on day "+getStartOfDay(date)+"."
		# Obtenemos las extensiones configuradas:
		extensions = self.am.getUserInformation()
		self.resetBundleUsage()
		self.am.connect('asteriskcdrdb')
		sql = "SELECT * from cdr WHERE callDate > %s AND callDate < %s AND lastapp = %s \
		AND disposition = %s"
		self.am.cursor.execute(sql, 
			(getStartOfDay(date), getEndOfDay(date), 'Dial', 'ANSWERED')
		)
		# Iteramos sobre las llamadas:
		totalOutgoingCalls = 0
		dailyCallDetail = []
		for row in self.am.cursor.fetchall():
			for ext in extensions:
				if row['src'] == ext['extension']:
					print "Outgoing call found, assigning cost..."
					totalOutgoingCalls += 1
					callCostInfo = self.assignCost(row)
					if callCostInfo:
						dailyCallDetail.append(callCostInfo)
					break
					
		print "----------------------------------------------------"
		print "Total outgoing calls processed:", totalOutgoingCalls
		self.saveCalls(dailyCallDetail)
		print "----------------------------------------------------"
		print "Total outgoing calls saved:", len(dailyCallDetail)

	def saveBundleUsage(self, bundle):
		self.am.connect('nextor_tarificador')
		sql = "UPDATE tarifica_bundle SET tarifica_bundle.usage = %s \
		WHERE tarifica_bundle.id = %s"
		self.am.cursor.execute(sql, (bundle['usage'], bundle['id']))

	def saveCalls(self, calls):
		self.am.connect('nextor_tarificador')
		sql = "INSERT INTO tarifica_call \
		(dialed_number, extension_number, duration, cost, date, destination_group_id, provider_id) \
		VALUES(%s, %s, %s, %s, %s, %s, %s)"
		self.am.cursor.executemany(sql, calls)
		return self.am.db.commit()

	def resetBundleUsage(self):
		print "Checking if bundle usage needs to be reset..."
		today = datetime.datetime.today()
		for provider in self.getAllConfiguredProviders():
			if provider['period_end'] == today.day:
				for bundle in self.getAllBundlesFromProvider(provider['id']):
					bundle['usage'] = 0
					try:
						self.saveBundleUsage(bundle)
						print "Bundle "+bundle['name']+" reset."
					except Exception, e:
						print "Error while saving bundle: ", e

	def assignCost(self, call):
		#Obtenemos la informacion necesaria:
		callInfoList = call['lastdata'].split('/')
		cost = 0
		provider_id = 0
		destination_group_id = 0
		dialedNoForProvider = call['dst']
		separated = []
		for a in callInfoList:
			separated = separated + a.split(',')
		try:
			dialedNoForProvider = separated[2]
		except IndexError:
			print "No dialed number present! Skipping..."
			return ()

		configuedProviders = self.getAllConfiguredProviders()
		if len(configuedProviders) == 0:
			print "No providers configured, ending..."
			return ()
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
				for d in destinations:
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
					if len(numberDialed) == len(d['matching_number']):
						# El numero marcado cae dentro de esta tarifa! Obtenemos los paquetes de la localidad
						print "Call number fits pattern for destination group", d['name']
						destination_group_id = d['id']
						bundles = self.getAllBundlesFromDestinationGroup(d['id'])
						if len(bundles) > 0:
							for b in bundles:
								if b['usage'] == b['amount']:
									print "Bundle",b['name'],"usage has reached its limit."
									continue
								else:
									print "Usage before: ", b['usage']
									if self.getTariffMode(b['tariff_mode_id'])['name'] == 'Sesión':
										b['usage'] -= 1
									else:
										#Redondeamos al minuto más cercano de la llamada
										b['usage'] = ceil(call['billsec'] / 60)
									print "Usage after: ", b['usage']
									#Guardamos los cambios
									self.saveBundleUsage(b)
						else:
							# No hay paquetes configurados, calculamos el costo con la tarifa base:
							print "No bundles configured for destination group", d['name']
							print "Billed minutes:",ceil(call['billsec'] / 60)
							cost = ceil(call['billsec'] / 60) * float(d['cost'])
							print "Calculated cost:", cost
					else:
						# No coincide la longitud del numero marcado con la longitud esperada de la localidad
						print "Call number does not fit pattern for destination group."
						continue
			else:
				print "No provider found for", provider
				return ()
		
		if destination_group_id == 0:
			return ()
			
		return (
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
			provider_id
		)

if __name__ == '__main__':
	week = datetime.datetime.now()
	week = week - datetime.timedelta(days=2)
	c = CallCostAssigner()
	c.getDailyAsteriskCalls(week)