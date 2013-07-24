# -*- coding: utf-8 -*-

#!/usr/bin/env python2.7
from asteriskMySQLManager import AsteriskMySQLManager
import datetime
import string
from math import ceil

class CallCostAssigner:
	am = None

	def __init__(self):
		self.am = AsteriskMySQLManager()

	def getBundles(self, destinationGroup_id):
		self.am.connect('nextor_tarificador')
		sql = "SELECT * from tarifica_bundles JOIN tarifica_destinationgroup \
			ON tarifica_bundles.destination_group_id = tarifica_destinationgroup.id  \
			WHERE tarifica_destinationgroup.id = %s \
			ORDER BY tarifica_bundles.priority ASC"
		self.am.cursor.execute(sql, (destinationGroup_id))
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
		pass
	
	def getDestinationGroups(self):
		self.am.connect('nextor_tarificador')
		sql = "SELECT * from tarifica_destinationgroup"
		self.am.cursor.execute(sql)
		return self.am.cursor.fetchone()

	def getBaseTariff(self, destinationGroup_id):
		self.am.connect('nextor_tarificador')
		sql = "SELECT * from tarifica_basetariff WHERE destination_group_id = %s"
		self.am.cursor.execute(sql, (destinationGroup_id,))
		return self.am.cursor.fetchone()

	def getTariffMode(self, tariffMode_id):
		self.am.connect('nextor_tarificador')
		sql = "SELECT * from tarifica_tariffmode WHERE id = %s"
		self.am.cursor.execute(sql, (tariffMode_id,))
		return self.am.cursor.fetchall()

	def getStartOfDay(self, date):
		return date.strftime('%Y-%m-%d')+" 00:00:00"

	def getEndOfDay(self, date):
		date = date + datetime.timedelta(days = 1)
		return date.strftime('%Y-%m-%d')+" 00:00:00"

	def getDailyAsteriskCalls(self, date):
		# Primero revisamos si es el día de corte.
		print "Script running on day "+self.getStartOfDay(date)+"."
		self.resetBundleUsage()
		print "Getting calls."
		self.am.connect('asteriskcdrdb')
		sql = "SELECT * from cdr where callDate > %s AND callDate < %s AND lastapp = %s AND disposition = %s"
		self.am.cursor.execute(sql, (self.getStartOfDay(date), self.getEndOfDay(date), 'Dial', 'ANSWERED'))
		# Iteramos sobre las llamadas:
		while True:
			entry = self.am.cursor.fetchone()
			if entry is None:
				break
			self.assignCost(entry)

	def saveBundleUsage(bundle):
		self.am.connect('nextor_tarificador')
		sql = "UPDATE tarifica_bundles SET usage = %s WHERE id = %s"
		self.am.cursor.execute(sql, (bundle['usage'], bundle['id']))

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
		print "Assigning cost to calls..."
		#Obtenemos la informacion necesaria:
		callInfo = call['dstchannel']
		print callInfo.split('/')
		
		# Extraemos la troncal por la cual se fue la llamada:
		destinations = self.getDestinationGroups()
		if len(destinations) == 0:
			print "No Destination Groups configured: cannot proceed."
			return False


		for d in self.getDestinationGroups():
			try:
				pos = call['dst'].index(d['prefix'])
			except ValueError, e:
				pos = None
			if pos is None:
				continue

			# Se encontro el prefijo!
			numberDialed = call['dst'][pos + len(d['prefix']):]
			if len(numberDialed) == len(d['matching_number']):
				# El numero marcado cae dentro de esta localidad! Obtenemos los paquetes de la localidad
				bundles = self.getBundles(d['id'])
				if len(bundles) > 0:
					for b in bundles:
						if b['usage'] == b['amount']:
							continue
						else:
							print "Usage before: ", b
							if self.getTariffMode(b['tariff_mode_id'])['name'] == 'Sesión':
								b['usage'] -= 1
							else:
								#Redondeamos al minuto más cercano de la llamada
								b['usage'] = ceil(call['billsec'] / 60)
							print "Usage after: ", b
				else:
					# No hay paquetes configurados, calculamos el costo con la tarifa base:
					tariff = self.getBaseTariff(d['id'])
					if len(tariff) > 0:
						cost = ceil(call['billsec'] / 60) * tariff['cost']
						print cost
					else:
						print "No base tariffs configured: cannot proceed."
						continue
			else:
				# No coincide la longitud del numero marcado con la longitud esperada de la localidad
				continue

if __name__ == '__main__':
	week = datetime.datetime.now()
	week = week - datetime.timedelta(days=14)
	c = CallCostAssigner()
	c.getDailyAsteriskCalls(week)