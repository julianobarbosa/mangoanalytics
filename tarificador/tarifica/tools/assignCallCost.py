# -*- coding: utf-8 -*-

#!/usr/bin/env python2.7
from __future__ import division
from asteriskMySQLManager import AsteriskMySQLManager
import datetime
import string
from math import ceil,floor

class CallCostAssigner:
	am = None

	def __init__(self):
		self.am = AsteriskMySQLManager()

	def getProviderBundlesForDestination(self, provider_id, destinationGroup_id):
		self.am.connect('nextor_tarificador')
		sql = "SELECT * from tarifica_bundles JOIN tarifica_destinationgroup \
			ON tarifica_bundles.destination_group_id = tarifica_destinationgroup.id  \
			WHERE tarifica_destinationgroup.provider_id = %s AND tarifica_destinationgroup.id = %s \
			ORDER BY tarifica_bundles.priority ASC"
		self.am.cursor.execute(sql, (provider_id, destinationGroup_id))
		return self.am.cursor.fetchall()

	def getAllBundlesFromProvider(self, provider_id):
		self.am.connect('nextor_tarificador')
		sql = "SELECT * from tarifica_bundles JOIN tarifica_provider \
			ON tarifica_bundles.provider_id = tarifica_provider.id  \
			WHERE tarifica_provider.id = %s"
		self.am.cursor.execute(sql, (provider_id,))
		return self.am.cursor.fetchall()

	def getAllConfiguredProviders(self):
		self.am.connect('nextor_tarificador')
		sql = "SELECT * from tarifica_provider WHERE is_configured = %s"
		self.am.cursor.execute(sql, (True,))
		return self.am.cursor.fetchall()
	
	def getDestinationGroupsFromProvider(self, provider_id):
		self.am.connect('nextor_tarificador')
		sql = "SELECT * from tarifica_destinationgroup WHERE provider_id = %s"
		self.am.cursor.execute(sql, (provider_id,))
		return self.am.cursor.fetchall()

	def getBaseTariff(self, destinationGroup_id):
		self.am.connect('nextor_tarificador')
		sql = "SELECT * from tarifica_basetariff WHERE destination_group_id = %s"
		self.am.cursor.execute(sql, (destinationGroup_id,))
		return self.am.cursor.fetchone()

	def getTariffMode(self, tariffMode_id):
		self.am.connect('nextor_tarificador')
		sql = "SELECT * from tarifica_tariffmode WHERE id = %s"
		self.am.cursor.execute(sql, (tariffMode_id,))
		return self.am.cursor.fetchone()

	def getStartOfDay(self, date):
		return date.strftime('%Y-%m-%d')+" 00:00:00"

	def getEndOfDay(self, date):
		date = date + datetime.timedelta(days = 1)
		return date.strftime('%Y-%m-%d')+" 00:00:00"

	def getDailyAsteriskCalls(self, date):
		# Primero revisamos si es el día de corte.
		print "Script running on day "+self.getStartOfDay(date)+"."
		# Obtenemos las extensiones configuradas:
		extensions = self.am.getUserInformation()
		self.resetBundleUsage()
		self.am.connect('asteriskcdrdb')
		sql = "SELECT * from cdr WHERE callDate > %s AND callDate < %s AND lastapp = %s \
		AND disposition = %s"
		self.am.cursor.execute(sql, 
			(self.getStartOfDay(date), self.getEndOfDay(date), 'Dial', 'ANSWERED')
		)
		# Iteramos sobre las llamadas:
		totalOutgoingCalls = 0
		dailyCallDetail = []
		for row in self.am.cursor.fetchall():
			for ext in extensions:
				if row['src'] == ext['extension']:
					print "Outgoing call found, assigning cost..."
					totalOutgoingCalls += 1
					dailyCallDetail.append(self.assignCost(row))
					break
					
		print self.saveCalls(dailyCallDetail)
		print "----------------------------------------------------"
		print "Total outgoing calls processed:", totalOutgoingCalls

	def saveBundleUsage(self, bundle):
		self.am.connect('nextor_tarificador')
		sql = "UPDATE tarifica_bundles SET tarifica_bundles.usage = %s \
		WHERE tarifica_bundles.id = %s"
		self.am.cursor.execute(sql, (bundle['usage'], bundle['id']))

	def saveCalls(self, calls):
		self.am.connect('nextor_tarificador')
		sql = "INSERT INTO tarifica_calls(dialed_number, extension_number, duration, cost, date) \
		VALUES(%s, %s, %s, %s, %s)"
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
		configuedProviders = self.getAllConfiguredProviders()
		callInfoList = call['lastdata'].split('/')
		cost = 0
		dialedNoForProvider = call['dst']
		separated = []
		for a in callInfoList:
			separated = separated + a.split(',')
		try:
			dialedNoForProvider = separated[2]
		except IndexError:
			print "No dialed number present! Skipping..."
			return False

		for prov in configuedProviders:
			# Extraemos la troncal por la cual se fue la llamada:
			try:
				provider = callInfoList[1]
			except IndexError:
				print "No trunk information present, skipping..."
				break

			if provider.count(prov['asterisk_channel_id']) > 0:
				print "Provider found:",prov['name']

				destinations = self.getDestinationGroupsFromProvider(prov['id'])
				if len(destinations) == 0:
					print "No Destination Groups configured: cannot proceed."
					continue
				for d in destinations:
					print "Trying to fit into destination",d['name']
					try:
						pos = dialedNoForProvider.index(d['prefix'])
						print "Call prefix fits into destination group",d['name']
					except ValueError, e:
						pos = None
					if pos is None:
						continue

					# Se encontro el prefijo!
					numberDialed = dialedNoForProvider[pos + len(d['prefix']):]
					print "Number called according to trunk:",numberDialed
					if len(numberDialed) == len(d['matching_number']):
						# El numero marcado cae dentro de esta localidad! Obtenemos los paquetes de la localidad
						print "Call number fits pattern for destination group", d['name']
						bundles = self.getProviderBundlesForDestination(prov['id'], d['id'])
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
							tariff = self.getBaseTariff(d['id'])
							if len(tariff) > 0:
								print "Billed minutes:",ceil(call['billsec'] / 60)
								cost = ceil(call['billsec'] / 60) * tariff['cost']
								print "Calculated cost:", cost
							else:
								print "No base tariffs configured: cannot proceed."
								continue
					else:
						# No coincide la longitud del numero marcado con la longitud esperada de la localidad
						continue
		
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
			)
		)

if __name__ == '__main__':
	week = datetime.datetime.now()
	week = week - datetime.timedelta(days=30)
	c = CallCostAssigner()
	c.getDailyAsteriskCalls(week)