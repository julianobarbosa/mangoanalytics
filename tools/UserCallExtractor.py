#!/usr/bin/env python2.7
import MySQLdb
import AsteriskMySQLManager

class CallInformationExtracter:
	def getDailyCallInformation(self):
		am = AsteriskMySQLManager()
		am.connect()
		am.cursor.execute('SELECT * FROM calls \
			')

	def getDailyDestinationInformation(self):
		pass