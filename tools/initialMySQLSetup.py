#!/usr/bin/env python2.7
import MySQLdb
import AsteriskMySQLManager

class CallInformationExtracter:
	def getDailyCallInformation(self):
		am = AsteriskMySQLManager()
		am.connect()
		am.cursor.execute('SELECT SUM(real_duration), extension, uniqueId, date \
			FROM calls \
			WHERE status = %s AND action = %s AND date < %s AND date > %s \
			GROUP BY extension', ('ANSWERED', 'Dial', 'tomorrow', 'yesterday'))

	def getDailyDestinationInformation(self):
		pass