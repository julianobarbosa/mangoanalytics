# -*- coding: utf-8 -*-

#!/usr/bin/env python2.7
from __future__ import division
from asteriskMySQLManager import AsteriskMySQLManager
import datetime

class Digester:
	am = None

	def __init__(self):
		self.am = AsteriskMySQLManager()

	def getUserDailyDetail(self, day):
		self.am.connect('nextor_tarificador')
		sql = "SELECT SUM(cost) as cost, SUM(duration) as total_minutes, \
			COUNT(id) as total_calls, extension_number as extension_number \
			FROM tarifica_calls \
			WHERE date > %s AND date < %s \
			GROUP BY extension_number"
		return self.am.cursor.execute(sql, (self.am.getStartOfDay(day), self.am.getEndOfDay(day)))

	def getUserDestinationDetail(self):
		pass

	def getUserDestinationNumberDetail(self):
		pass

	def getProviderDailyDetail(self):
		pass

	def getProviderDestinationDetail(self):
		pass
