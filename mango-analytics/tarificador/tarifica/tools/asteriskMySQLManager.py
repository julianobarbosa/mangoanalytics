#!/usr/bin/env python2.7

#Licensed to NZXT TELECOMUNICACIONES DE MEXICO SA CV (Nextor Telecom) 
#under GPL V3 license agreement.  

#See the NOTICE file distributed with this work for additional information
#regarding copyright ownership.  The Nextor Telecom licenses this file
#to you under the GPL V3 License, (the "License"); 
#you may not use this file except in compliance
#with the License.  You may obtain a copy of the License at

#http://opensource.org/licenses/GPL-3.0

#Unless required by applicable law or agreed to in writing,
#software distributed under the License is distributed on an
#"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
#KIND, either express or implied.  See the License for the
#specific language governing permissions and limitations
#under the License.

#Nextor Telecom Mexico development team dev@nextortelecom.com

import MySQLdb
import MySQLdb.cursors
from datetime import *

class AsteriskMySQLManager:
	dbUser = 'root'
	dbHost = 'localhost'
	dbName = 'asterisk'
	dbPass = None
	cursor = None
	db = None

	def getMySQLPassword(self):
		elastixConf = open('/etc/elastix.conf', 'r')
		while True:
			line = elastixConf.readline()
			if not line: 
				break
			if 'mysqlrootpwd' in line:
				line.strip('\n')
				self.dbPass = line.split('=')[1].strip('\n')

	def connect(self, database):
		self.getMySQLPassword()
		self.db = MySQLdb.connect(host=self.dbHost,user=self.dbUser,
                  passwd=self.dbPass,db=database,cursorclass=MySQLdb.cursors.DictCursor)
		self.cursor = self.db.cursor()
		return True

	def getTrunkInformation(self):
		self.connect(self.dbName)
		self.cursor.execute('SELECT trunkid,name,tech,channelid from trunks where disabled = %s', ('off',))
		return self.cursor.fetchall()

	def getUserInformation(self):
		self.connect(self.dbName)
		self.cursor.execute('SELECT extension,name from users')
		return self.cursor.fetchall()

	def getPinsetInformation(self):
		self.connect(self.dbName)
		self.cursor.execute('SELECT passwords from pinsets')
		passwords = self.cursor.fetchall()
		passwordsData = []
		for p in passwords:
			res = p['passwords'].split("\n")
			for r in res:
				if r in passwordsData:
					continue
				else:
					passwordsData.extend(res)
		return passwordsData

def testDates():
	am = AsteriskMySQLManager()
	today = datetime.today()
	t = datetime(year=today.year, month=today.month, day=1) - timedelta(days=1)
	month_start = datetime(year=t.year, month=t.month, day=1)
	month_end = datetime(year=today.year, month=today.month, day=1)
	am.connect('asteriskcdrdb')
	am.cursor.execute('SELECT calldate from asteriskcdrdb.cdr \
		WHERE calldate > %s AND calldate < %s \
		ORDER BY calldate ASC LIMIT 10 ', (month_start, month_end))
	return am.cursor.fetchall()

if __name__ == '__main__':
	print "running!"