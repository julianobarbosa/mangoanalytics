#!/usr/bin/env python2.7
from asteriskMySQLManager import AsteriskMySQLManager
import datetime

class CallCostAssigner:
	destinationGroups = None
	am = None
	bundles = None
	cursor = None

	def __init__(self):
		self.am = AsteriskMySQLManager()

	def getBundles(self, destinationGroup_id):
		self.am.connect('nextor_tarificador')
		sql = "SELECT * from tarifica_bundles JOIN tarifica_destinationgroup \
			ON tarifica_bundles.destination_group_id = tarifica_destinationgroup.id  \
			WHERE tarifica_destinationgroup.id = %s"
		self.am.cursor.execute(sql, (destinationGroup_id))
		return self.am.cursor.fetchall()
	
	def getDestinationGroups(self):
		self.am.connect('nextor_tarificador')
		sql = "SELECT * from tarifica_destinationgroup"
		self.am.cursor.execute(sql)
		return self.am.cursor.fetchall()

	def getStartOfDay(self, date):
		return date.strftime('%Y-%m-%d')+" 00:00:00"

	def getEndOfDay(self, date):
		date = date + datetime.timedelta(days = 1)
		return date.strftime('%Y-%m-%d')+" 00:00:00"

	def getDailyAsteriskCalls(self, date):
		sql = "SELECT * from cdr where callDate > %s AND callDate < %s"
		self.am.cursor.execute(sql, (getStartOfDay(date), getEndOfDay(date)))
		# Iteramos sobre las llamadas:
		while True:
			entry = self.am.cursor.fetchone()
			print entry

if __name__ == '__main__':
	print 'running'