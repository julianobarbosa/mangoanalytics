#!/usr/bin/env python2.7
import _mysql
import sqlite3
from datetime import datetime

def getMySQLPassword():
	elastixConf = open('/etc/elastix.conf', 'r')
	while True:
		line = elastixConf.readline()
		if not line: 
			break
		if 'mysqlrootpwd' in line:
			line.strip('\n')
			return line.split('=')[1].strip('\n')

# 1 - Obtain mysql root password:
rootPass = getMySQLPassword()

dbName = 'nextor_tarificador'
dbUser = 'nxt_tarificador'
dbPass = 'k4590NAEUI'

# 2 - Connect to mysql:
db = _mysql.connect(host='localhost',user='root',
	passwd=rootPass)

# 3 - Extract users from elastix's sqlite
con = None
try:
	con = sqlite3.connect('/var/www/db/acl.db')
	cursor = con.cursor()
	cursor.execute('SELECT * FROM acl_user')
	data = cursor.fetchall()
	for d in data:
		now = datetime.now()
		try:
			insertSQL = "insert into nextor_tarificador.auth_user(\
				password, is_superuser, username, \
				email, is_staff, is_active, date_joined) values(\
				'"+d[3]+"', 1, '"+ d[1] +"', 'admin@test.com',\
				 1, 1, '"+now.strftime('%Y-%m-%d %H:%M:%S')+"')"
			db.query(insertSQL)
		except Exception as e:
			print "Error while inserting user",e

	print """All operations finished successfully"""

except Exception as e:
	print "Error while obtaining elastix' users",e