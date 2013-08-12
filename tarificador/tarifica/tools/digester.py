# -*- coding: utf-8 -*-

#!/usr/bin/env python2.7
from __future__ import division
from asteriskMySQLManager import AsteriskMySQLManager
from assignCallCost import CallCostAssigner
from assignCallCost import getStartOfDay, getEndOfDay
import datetime
from dateutil.relativedelta import *

class Digester:
	am = None

	def __init__(self):
		self.am = AsteriskMySQLManager()

	def getUserDailyDetail(self, day):
		callDetail = []	
		self.am.connect('nextor_tarificador')
		sql = "SELECT SUM(tarifica_call.cost) as cost, \
			SUM(tarifica_call.duration) as total_minutes, \
			COUNT(tarifica_call.id) as total_calls, \
			tarifica_extension.id as extension_number, \
			tarifica_call.date as date \
			FROM tarifica_call JOIN tarifica_extension \
			ON tarifica_call.extension_number = tarifica_extension.extension_number \
			WHERE date > %s AND date < %s \
			GROUP BY extension_number"
		self.am.cursor.execute(sql, (getStartOfDay(day), getEndOfDay(day)))
		for row in self.am.cursor.fetchall():
			d = (
				row['extension_number'],
				row['total_calls'],
				row['total_minutes'],
				row['cost'],
				row['date']
			)
			print d
			callDetail.append(d)
		return callDetail

	def saveUserDailyDetail(self, day):
		callData = self.getUserDailyDetail(day)
		self.am.connect('nextor_tarificador')
		sql = "INSERT INTO tarifica_userdailydetail \
		(extension_id, total_calls, total_minutes, cost, date) \
		VALUES(%s, %s, %s, %s, %s)"
		totalRowsSaved = self.am.cursor.executemany(sql, callData)
		self.am.db.commit()
		print "----------------------------------------"
		print "User Daily Detail saved:", totalRowsSaved

	def getUserDestinationDetail(self, day):
		callDetail = []	
		self.am.connect('nextor_tarificador')
		sql = "SELECT SUM(tarifica_call.cost) as cost, \
			SUM(tarifica_call.duration) as total_minutes, \
			COUNT(tarifica_call.id) as total_calls, \
			tarifica_call.date as date, \
			tarifica_extension.id as extension_number, \
			tarifica_call.destination_group_id as destination_group_id \
			FROM tarifica_call \
			LEFT JOIN tarifica_extension ON \
			tarifica_call.extension_number = tarifica_extension.extension_number \
			WHERE date > %s AND date < %s \
			GROUP BY tarifica_call.extension_number, tarifica_call.destination_group_id"
		self.am.cursor.execute(sql, (getStartOfDay(day), getEndOfDay(day)))
		for row in self.am.cursor.fetchall():
			callDetail.append((
				row['extension_number'],
				row['total_calls'],
				row['total_minutes'],
				row['cost'],
				row['destination_group_id'],
				row['date']
			))
		return callDetail

	def saveUserDestinationDetail(self, day):
		callData = self.getUserDestinationDetail(day)
		self.am.connect('nextor_tarificador')
		sql = "INSERT INTO tarifica_userdestinationdetail \
		(extension_id, total_calls, total_minutes, cost, destination_group_id, date) \
		VALUES(%s, %s, %s, %s, %s, %s)"
		totalRowsSaved = self.am.cursor.executemany(sql, callData)
		self.am.db.commit()
		print "----------------------------------------"
		print "User Destination Detail saved:", totalRowsSaved

	def getUserDestinationNumberDetail(self, day):
		callDetail = []	
		self.am.connect('nextor_tarificador')
		sql = "SELECT SUM(tarifica_call.cost) as cost, \
			SUM(tarifica_call.duration) as total_minutes, \
			COUNT(tarifica_call.id) as total_calls, \
			tarifica_call.dialed_number as dialed_number, \
			tarifica_extension.id as extension_number, \
			DATE(tarifica_call.date) as date, \
			tarifica_destinationgroup.prefix as prefix \
			FROM tarifica_call LEFT JOIN tarifica_extension \
			ON tarifica_call.extension_number = tarifica_extension.extension_number \
			LEFT JOIN tarifica_destinationgroup \
			ON tarifica_call.destination_group_id = tarifica_destinationgroup.id \
			WHERE date > %s AND date < %s \
			GROUP BY tarifica_call.dialed_number"
		self.am.cursor.execute(sql, (getStartOfDay(day), getEndOfDay(day)))
		for row in self.am.cursor.fetchall():
			callDetail.append((
				row['extension_number'],
				row['total_calls'],
				row['total_minutes'],
				row['cost'],
				row['prefix'],
				row['dialed_number'],
				row['date']
			))
		return callDetail

	def saveUserDestinationNumberDetail(self, day):
		callData = self.getUserDestinationNumberDetail(day)
		self.am.connect('nextor_tarificador')
		sql = "INSERT INTO tarifica_userdestinationnumberdetail \
		(extension_id, total_calls, total_minutes, cost, prefix, number, date) \
		VALUES(%s, %s, %s, %s, %s, %s, %s)"
		totalRowsSaved = self.am.cursor.executemany(sql, callData)
		self.am.db.commit()
		print "----------------------------------------"
		print "User Destination Number Detail saved:", totalRowsSaved

	# -----------------TRUNKS---------------------
	def getProviderDailyDetail(self, day):
		callDetail = []	
		self.am.connect('nextor_tarificador')
		sql = "SELECT SUM(tarifica_call.cost) as cost, \
			SUM(tarifica_call.duration) as total_minutes, \
			COUNT(tarifica_call.id) as total_calls, \
			tarifica_call.date as date, \
			tarifica_destinationgroup.provider_id as provider \
			FROM tarifica_call JOIN tarifica_destinationgroup \
			ON tarifica_call.destination_group_id = tarifica_destinationgroup.id \
			WHERE date > %s AND date < %s \
			GROUP BY tarifica_destinationgroup.provider_id"
		self.am.cursor.execute(sql, (getStartOfDay(day), getEndOfDay(day)))
		for row in self.am.cursor.fetchall():
			callDetail.append((
				row['provider'],
				row['cost'],
				row['total_calls'],
				row['total_minutes'],
				row['date']
			))
		return callDetail

	def saveProviderDailyDetail(self, day):
		callData = self.getProviderDailyDetail(day)
		self.am.connect('nextor_tarificador')
		sql = "INSERT INTO tarifica_providerdailydetail \
		(provider_id, cost, total_calls, total_minutes, date) \
		VALUES(%s, %s, %s, %s, %s)"
		totalRowsSaved = self.am.cursor.executemany(sql, callData)
		self.am.db.commit()
		print "----------------------------------------"
		print "Provider Daily Detail saved:", totalRowsSaved

	def getProviderDestinationDetail(self, day):
		callDetail = []	
		self.am.connect('nextor_tarificador')
		sql = "SELECT SUM(tarifica_call.cost) as cost, \
			SUM(tarifica_call.duration) as total_minutes, \
			COUNT(tarifica_call.id) as total_calls, \
			tarifica_call.date as date, \
			tarifica_call.destination_group_id as destination_group_id, \
			tarifica_destinationgroup.provider_id as provider \
			FROM tarifica_call JOIN tarifica_destinationgroup \
			ON tarifica_call.destination_group_id = tarifica_destinationgroup.id \
			WHERE date > %s AND date < %s \
			GROUP BY tarifica_call.destination_group_id"
		self.am.cursor.execute(sql, (getStartOfDay(day), getEndOfDay(day)))
		for row in self.am.cursor.fetchall():
			callDetail.append((
				row['provider'],
				row['cost'],
				row['total_calls'],
				row['total_minutes'],
				row['destination_group_id'],
				row['date']
			))
		return callDetail

	def saveProviderDestinationDetail(self, day):
		callData = self.getProviderDestinationDetail(day)
		self.am.connect('nextor_tarificador')
		sql = "INSERT INTO tarifica_providerdestinationdetail \
		(provider_id, cost, total_calls, total_minutes, destination_group_id, date) \
		VALUES(%s, %s, %s, %s, %s, %s)"
		totalRowsSaved = self.am.cursor.executemany(sql, callData)
		self.am.db.commit()
		print "----------------------------------------"
		print "Provider Destination Detail saved:", totalRowsSaved

	def saveProviderMonthlyCost(self, today=datetime.datetime.today()):
		cca = CallCostAssigner()
		for provider in cca.getAllConfiguredProviders():
			if provider['period_end'] == today.day:
				print "End date of provider", provider['name']
				# Definimos inicio y fin:
				# Inicio: today - 1 month
				start_date = today - relativedelta(months=1)
				# Fin: today - 1 day
				end_date = today - datetime.timedelta(days=1)
				# Obtenemos totales:
				callDetail = []	
				self.am.connect('nextor_tarificador')
				sql = "SELECT SUM(tarifica_providerdailydetail.cost) as call_cost, \
					SUM(tarifica_providerdailydetail.total_minutes) as total_minutes, \
					SUM(tarifica_providerdailydetail.total_calls) as total_calls \
					FROM tarifica_providerdailydetail \
					WHERE tarifica_providerdailydetail.provider_id = %s \
					AND date > %s AND date < %s"
				self.am.cursor.execute(sql, (provider['id'], start_date, end_date))
				data = self.am.cursor.fetchall()[0]
				print data

				# Revisamos paquetes y reseteamos:
				bundle_cost = 0
				for bundle in cca.getActiveBundlesFromProvider(provider['id']):
					# Revisamos que aún aplique el paquete:
					if bundle['start_date'] <= today:
						# El paquete ya comenzó a aplicarse (aplica a este periodo)
						if bundle['end_date'] > today:
							#... y no termina hoy
							bundle['usage'] = 0
							cca.saveBundleUsage(bundle)
							bundle_cost += bundle['cost']
							print "Bundle "+bundle['name']+" reset."
						else:
							#Ya acabo el paquete, ya no se contabiliza y se desactiva
							self.am.deactivateBundle(bundle)
					else:
						print "Bundle must not be applied yet."

				if data['call_cost'] is None:
					data['call_cost'] = 0
				if data['total_calls'] is None:
					data['total_calls'] = 0
				if data['total_minutes'] is None:
					data['total_minutes'] = 0

				sql = "INSERT INTO tarifica_providermonthlydetail \
				(provider_id, call_cost, bundle_cost, total_calls, total_minutes, date_start, date_end) \
				VALUES(%s, %s, %s, %s, %s, %s, %s)"
				args = (
					provider['id'],
					data['call_cost'],
					bundle_cost,
					data['total_calls'],
					data['total_minutes'],
					start_date,
					end_date
				)
				totalRowsSaved = self.am.cursor.execute(sql, args)
				self.am.db.commit()
				print "----------------------------------------"
				print "Provider Monthly Detail saved:", totalRowsSaved


if __name__ == '__main__':
	week = datetime.datetime.now()
	week = week + datetime.timedelta(days=0)
	print week
	d = Digester()
	today = datetime.today()
	today = today + datetime.timedelta(days=0)
	d.saveProviderMonthlyCost(today)
	#d.saveUserDailyDetail(week)
	#d.saveUserDestinationDetail(week)
	#d.saveUserDestinationNumberDetail(week)
	#d.saveProviderDailyDetail(week)
	#d.saveProviderDestinationDetail(week)