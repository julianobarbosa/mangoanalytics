# -*- coding: utf-8 -*-

#Licensed to NZXT TELECOMUNICACIONES DE MEXICO SA CV (Nextor Telecom) 
#under GPL V3 license agreement.  
#
#See the NOTICE file distributed with this work for additional information
#regarding copyright ownership. Nextor Telecom licenses this file
#to you under the GPL V3 License, (the "License"); 
#you may not use this file except in compliance
#with the License.  You may obtain a copy of the License at
#
#http://opensource.org/licenses/GPL-3.0
#
#Unless required by applicable law or agreed to in writing,
#software distributed under the License is distributed on an
#"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
#KIND, either express or implied.  See the License for the
#specific language governing permissions and limitations
#under the License.
#
#Nextor Telecom Mexico Dev-Ops dev@nextortelecom.com
#
#Alfonso Lizarraga Santos, Aug-2013
#Luis Alfredo Lizarraga Santos, Aug-2013

#!/usr/bin/env python2.7
from __future__ import division
from asteriskMySQLManager import AsteriskMySQLManager
import datetime
import string
from dateutil.relativedelta import *
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

	def getBundlesFromProvider(self, provider_id):
		self.am.connect('nextor_tarificador')
		sql = "SELECT * from tarifica_bundle \
			LEFT JOIN tarifica_destinationgroup \
			ON tarifica_bundle.destination_group_id = tarifica_destinationgroup.id \
			WHERE tarifica_destinationgroup.provider_id = %s"
		self.am.cursor.execute(sql, (provider_id,))
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
		self.resetBundles()
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

	def resetBundles(self):
		today=datetime.datetime.today()
		for provider in self.getAllConfiguredProviders():
			# We get all bundles and check if they should be reset, based on their dates
			for bundle in self.getBundlesFromProvider(provider['id']):
				if provider['period_end'] == today.day:
					print "End date of provider", provider['name']
					bundle['usage'] = 0
					self.saveBundleUsage(bundle['id'], 0)
					print "Bundle "+bundle['name']+" reset."
				#Checking that bundles have indeed been reset:

	def saveBundleUsage(self, bundle_id, usage):
		self.am.connect('nextor_tarificador')
		sql = "UPDATE tarifica_bundle SET tarifica_bundle.usage = %s \
		WHERE tarifica_bundle.id = %s"
		print self.am.cursor.execute(sql, (usage, bundle_id))
		print self.am.db.commit()
		sql = "SELECT * FROM tarifica_bundle WHERE tarifica_bundle.id = %s"
		self.am.cursor.execute(sql, (bundle_id,))
		bundle = self.am.cursor.fetchone()
		print "Bundle",bundle['name'],"usage is now",bundle['usage']

	def saveCalls(self, calls):
		self.am.connect('nextor_tarificador')
		sql = "INSERT INTO tarifica_call \
		(dialed_number, extension_number, pinset_number, duration, cost, date, \
		destination_group_id, provider_id, asterisk_unique_id) \
		VALUES(%s, %s, %s, %s, %s, %s, %s, %s, %s)"
		self.am.cursor.executemany(sql, calls)
		return self.am.db.commit()

	def saveUnconfiguredCalls(self, calls):
		self.am.connect('nextor_tarificador')
		sql = "INSERT INTO tarifica_unconfiguredcall \
		(dialed_number, extension_number, pinset_number, duration, provider, date, asterisk_unique_id) \
		VALUES(%s, %s, %s, %s, %s, %s, %s)"
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
			if len(a.split(',')) == 1:
				#No fue, hay que separar con pipes
				separated = separated + a.split('|')
			else:
				separated = separated + a.split(',')
		try:
			dialedNoForProvider = separated[2]
		except IndexError:
			print "No dialed number present! Skipping..."
		print "Call from", call['src'],"with pinset", call['accountcode']

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
					try:
						pos = dialedNoForProvider.index(d['prefix'])
						print "Call prefix fits into destination group",d['name']
					except ValueError, e:
						pos = None
					if pos is None or pos != 0:
						continue

					# Se encontro el prefijo!
					numberDialed = dialedNoForProvider[pos + len(d['prefix']):]
					# print "Number called according to trunk:",numberDialed
					destination_group_id = d['id']
					bundles = self.getAllBundlesFromDestinationGroup(d['id'])
					appliedToBundle = False
					if len(bundles) > 0:
						for b in bundles:
							#Si ya se aplicó, salimos
							if appliedToBundle:
								print "Already has been applied to a bundle"
								break

							# La llamada debe estar dentro de un billing period del proveedor
							# Si además en ese billing period hay un paquete que lo abarque,
							# Entonces se aplica.

							today = datetime.datetime.today()
							provider_period_start = datetime.date(
								year=today.year, month=today.month, day=prov['period_end']
							)
							if provider_period_start > call['calldate'].date():
								#Entonces el periodo es el anterior:
								provider_period_end = provider_period_start - relativedelta(days=1)
								provider_period_start = provider_period_start - relativedelta(months=1)
							else:
								provider_period_end = provider_period_start + relativedelta(months=1)
								provider_period_end = provider_period_end - relativedelta(days=1)
							#Now that we have which billing period the call falls into, we check that
							#Bundle should start before or the same day of provider's billing period
							if b['start_date'] <= provider_period_start:
								#Bundle should end after or the same day of provider's billing period
								if b['end_date'] >= provider_period_end:
								
									if b['usage'] is None:
										b['usage'] = 0
									#Si el bundle actual ya se agotó, seguimos
									if b['usage'] == b['amount']:
										print "Bundle",b['name'],"usage has reached its limit."
										continue

									#Si no, agregamos la llamada al uso del bundle
									print "Billing with bundle",b['name']
									usage = b['usage']
									print "Usage before: ", usage
									if self.getTariffMode(b['tariff_mode_id'])['name'] == 'Session':
										usage += 1
									else:
										#Redondeamos al minuto más cercano de la llamada
										usage += ceil(call['billsec'] / 60)
									print "Usage after: ", usage

									if b['usage'] < b['amount']:
										#Si no se pasa del límite del paquete, la guardamos...
										self.saveBundleUsage(b['id'], usage)
										appliedToBundle = True
										costAssigned = True
										save = True
										print "Call applied to bundle",b['name']
									else:
										print "Not applied to bundle because it would surpass the amount set."
								else:
									print "End Date of Bundle is less than the end of billing period!"
							else:
								print "Start Date of Bundle is less than the end of billing period!"

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
			print "Saving call..."
			return {
				'callInfo':
				(
					dialedNoForProvider, 
					call['src'], 
					call['accountcode'],
					call['billsec'], 
					cost, 
					call['calldate'],
					destination_group_id,
					provider_id,
					call['uniqueid']
				),
				'save': True
			}	
		else:
			print "Saving unconfigured call..."
			return {
				'callInfo':
				(
					call['dst'], 
					call['src'], 
					call['accountcode'], 
					call['billsec'], 
					callInfoList[1],
					call['calldate'],
					call['uniqueid']
				),
				'save': False
			}

if __name__ == '__main__':
	week = datetime.datetime.now()
	week = week - datetime.timedelta(days=10)
	c = CallCostAssigner()
	c.getDailyAsteriskCalls(week)