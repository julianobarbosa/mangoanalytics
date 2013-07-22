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

	def getAllBundles(self):
		self.am.connect('nextor_tarificador')
		sql = "SELECT * from tarifica_bundles"
		self.am.cursor.execute(sql,))
		return self.am.cursor.fetchall()
	
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
		self.am.connect('asteriskcdrdb')
		sql = "SELECT * from cdr where callDate > %s AND callDate < %s AND lastapp = %s AND disposition = %s"
		self.am.cursor.execute(sql, (self.getStartOfDay(date), self.getEndOfDay(date), 'Dial', 'ANSWERED'))
		# Iteramos sobre las llamadas:
		while True:
			entry = self.am.cursor.fetchone()
			if entry is None:
				break
			print entry

	def resetBundleUsage(self):
		for bundle in self.getAllBundles():
			today = datetime.datetime.today()
			if bundle.

	def assignCost(self, call):
		destinationGroups = self.getDestinationGroups()
		for d in destinationGroups:
			try:
				pos = call['dst'].index(d['prefix'])
				# Se encontro el prefijo!
				numberDialed = call['dst'][pos + len(d['prefix']):]
				if len(numberDialed) == len(d['matching_number']):
					# El numero marcado cae dentro de esta localidad! Obtenemos los paquetes de la localidad
					bundles = self.getBundles(d['id'])
					assignedToBundle = False
					for b in bundles:
						if b['usage'] == b['amount']:
							continue
						else:
							if self.getTariffMode(b['tariff_mode_id'])['name'] == 'Sesión':
								b['usage'] -= 1
							else:
								#Redondeamos al minuto más cercano de la llamada
								b['usage'] = ceil(call['billsec'] / 60)
								print b
							assignedToBundle = True
					#Una vez hechos los cálculos, le damos el costo:
					if not assignedToBundle:
						tariff = self.getBaseTariff(d['id'])
						call['cost'] = ceil(call['billsec'] / 60) * tariff['cost']

				else:
					pass
			except:
				pass

if __name__ == '__main__':
	week = datetime.datetime.now()
	print week
	week = week - datetime.timedelta(days=7)
	print week
	c = CallCostAssigner()
	c.getDailyAsteriskCalls(week)