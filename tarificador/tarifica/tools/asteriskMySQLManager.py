#!/usr/bin/env python2.7
import MySQLdb

class AsteriskMySQLManager:
	dbUser = 'root'
	dbHost = 'localhost'
	dbName = 'asterisk'
	dbPass = None
	cursor = None

	def getMySQLPassword(self):
		elastixConf = open('/etc/elastix.conf', 'r')
		while True:
			line = elastixConf.readline()
			if not line: 
				break
			if 'mysqlrootpwd' in line:
				line.strip('\n')
				self.dbPass = line.split('=')[1].strip('\n')

	def connect(self):
		self.getMySQLPassword()
		self.db = MySQLdb.connect(host=self.dbHost,user=self.dbUser,
                  passwd=self.dbPass,db=self.dbName)
		self.cursor = db.cursor()
		return True

	def getTrunkInformation(self):
		if self.cursor is None:
			self.connect()
		self.cursor.execute('SELECT trunkid,name from trunks where disabled = %s', ('off',))
		return c.fetchall():

	def getUserInformation(self):
		if self.cursor is None:
			self.connect()
		self.cursor.execute('SELECT extension,name from users')
		return c.fetchall():

if __name__ == '__main__':
	print 'running'