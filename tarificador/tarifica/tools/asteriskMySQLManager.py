#!/usr/bin/env python2.7
import MySQLdb
import MySQLdb.cursors

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
		if self.cursor is None:
			self.connect(self.dbName)
		self.cursor.execute('SELECT trunkid,name,tech,channelid from trunks where disabled = %s', ('off',))
		return self.cursor.fetchall()

	def getUserInformation(self):
		if self.cursor is None:
			self.connect(self.dbName)
		self.cursor.execute('SELECT extension,name from users')
		return self.cursor.fetchall()

if __name__ == '__main__':
	print 'running'