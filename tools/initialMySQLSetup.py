#!/usr/bin/env python2.7
import MySQLdb

def getMySQLPassword():
	elastixConf = open('/etc/elastix.conf', 'r')
	while True:
		line = elastixConf.readline()
		if not line: 
			break
		if 'mysqlrootpwd' in line:
			line.strip('\n')
			return line.split('=')[1]

# 1 - Obtain mysql root password:
rootPass = getMySQLPassword()
print rootPass

dbName = 'nextor_tarificador'
dbUser = 'nxt_tarificador'
dbPass = 'k4590NAEUI'

# 2 - Connect to mysql:
db = MySQLdb.connect(host='localhost',user='root',
	passwd=rootPass,db='mysql')
cursor = db.cursor

# 3 - Create database:
createDBSQL = 'CREATE DATABASE %s'
cursor.execute(createDBSQL, (dbName,))

# 4 - Create user:
createUserSQL = "CREATE USER %s@'localhost' IDENTIFIED BY %s"
cursor.execute(createUserSQL, (dbUser, dbPass))

# 5 - Assign privileges for own db
assignPriv = "GRANT ALL PRIVILEGES ON %s.* TO %s@'localhost'"
cursor.execute(assignPriv, (dbName, dbUser))

# 6 - Assign privileges for asterisk main db
asteriskPriv = "GRANT SELECT ON asterisk.* TO %s@'localhost'"
cursor.execute(asteriskPriv, (dbUser,))

# 6 - Assign privileges for asterisk cdr db
asteriskPriv = "GRANT SELECT ON asteriskcdrdb.* TO %s@'localhost'"
cursor.execute(asteriskPriv, (dbUser,))