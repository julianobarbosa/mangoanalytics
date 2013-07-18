#!/usr/bin/env python2.7
import asteriskMySQLManager
from tarifica.models import *
import datetime
from django.utils import timezone

class CallCostAssigner:
	destinationGroups = None
	bundles = None

	def assignBundleInfo(self):
		self.bundles = Bundle.objects.all()
	
	def assignDestinationGroupsInfo(self):
		self.destinationGroups = DestinationGroups.objects.all()

	def getStartOfDay(self, date):
		return date.strftime('%Y-%m-%d')+" 00:00:00"

	def getEndOfDay(self, date):
		date = date + datetime.timedelta(days = 1)
		return date.strftime('%Y-%m-%d')+" 00:00:00"

	def getDailyAsteriskCalls(self, date):
		am = AsteriskMySQLManager()
		am.connect('asteriskcdrdb')
		sql = "SELECT * from cdr where callDate > %s AND callDate < %s"
		am.cursor.execute(sql, (getStartOfDay(date), getEndOfDay(date)))
		# Iteramos sobre las llamadas:
		while True:
			entry = am.cursor.fetchone()


if __name__ == '__main__':
	print 'running'