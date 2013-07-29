# -*- coding: utf-8 -*-

#!/usr/bin/env python2.7
from __future__ import division
from asteriskMySQLManager import AsteriskMySQLManager
from assignCallCost import getStartOfDay, getEndOfDay
import datetime

class Digester:
	am = None

	def __init__(self):
		self.am = AsteriskMySQLManager()

	def getUserDailyDetail(self, day):
		self.am.connect('nextor_tarificador')
		sql = "SELECT SUM(cost) as cost, SUM(duration) as total_minutes, \
			COUNT(id) as total_calls, extension_number as extension_number \
			FROM tarifica_call \
			WHERE date > %s AND date < %s \
			GROUP BY extension_number"
		sql = "SELECT * FROM tarifica_call WHERE date > %s AND date < %s"
		self.am.cursor.execute(sql, (getStartOfDay(day), getEndOfDay(day)))
		return self.am.cursor.fetchall()

	def getUserDestinationDetail(self, day):
		self.am.connect('nextor_tarificador')
		sql = "SELECT SUM(cost) as cost, SUM(duration) as total_minutes, \
			COUNT(id) as total_calls, extension_number as extension_number \
			FROM tarifica_call \
			WHERE date > %s AND date < %s \
			GROUP BY extension_number"
		return self.am.cursor.execute(sql, (getStartOfDay(day), getEndOfDay(day)))

	def getUserDestinationNumberDetail(self, day):
		self.am.connect('nextor_tarificador')
		sql = "SELECT SUM(cost) as cost, SUM(duration) as total_minutes, \
			COUNT(id) as total_calls, extension_number as extension_number \
			FROM tarifica_call \
			WHERE date > %s AND date < %s \
			GROUP BY extension_number"
		return self.am.cursor.execute(sql, (getStartOfDay(day), getEndOfDay(day)))

	def getProviderDailyDetail(self, day):
		self.am.connect('nextor_tarificador')
		sql = "SELECT SUM(cost) as cost, SUM(duration) as total_minutes, \
			COUNT(id) as total_calls, extension_number as extension_number \
			FROM tarifica_call \
			WHERE date > %s AND date < %s \
			GROUP BY extension_number"
		return self.am.cursor.execute(sql, (getStartOfDay(day), getEndOfDay(day)))

	def getProviderDestinationDetail(self, day):
		self.am.connect('nextor_tarificador')
		sql = "SELECT SUM(cost) as cost, SUM(duration) as total_minutes, \
			COUNT(id) as total_calls, extension_number as extension_number \
			FROM tarifica_call \
			WHERE date > %s AND date < %s \
			GROUP BY extension_number"
		return self.am.cursor.execute(sql, (getStartOfDay(day), getEndOfDay(day)))

if __name__ == '__main__':
	week = datetime.datetime.now()
	week = week - datetime.timedelta(days=31)
	print week
	d = Digester()
	detail = d.getUserDailyDetail(week)
	print detail

