#!/usr/bin/env python2.7
import _mysql

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
print rootPass

dbName = 'nextor_tarificador'
dbUser = 'nxt_tarificador'
dbPass = 'k4590NAEUI'

# 2 - Connect to mysql:
db = _mysql.connect(host='localhost',user='root',
	passwd=rootPass)

# 3 - Create database:
createDBSQL = "CREATE DATABASE "+dbName
db.query(createDBSQL)

# 4 - Create user:
createUserSQL = "CREATE USER '"+dbUser+"'@'localhost' IDENTIFIED BY '"+dbPass+"'"
db.query(createUserSQL)

# 5 - Assign privileges for own db
assignPriv = "GRANT ALL PRIVILEGES ON "+dbName+".* TO '"+dbUser+"'@'localhost'"
db.query(assignPriv)

# 6 - Assign privileges for asterisk main db
asteriskPriv = "GRANT SELECT ON asterisk.* TO '"+dbUser+"'@'localhost'"
db.query(asteriskPriv)

# 6 - Assign privileges for asterisk cdr db
asteriskPriv = "GRANT SELECT ON asteriskcdrdb.* TO '"+dbUser+"'@'localhost'"
db.query(asteriskPriv)

print """All operations finished successfully"""