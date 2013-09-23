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

dbName = 'nextor_tarificador'
dbUser = 'nxt_tarificador'
dbPass = 'k4590NAEUI'

# 2 - Connect to mysql:
db = _mysql.connect(host='localhost',user='root',
	passwd=rootPass)

# 3 - Drop database:
dropDBSQL = "DROP DATABASE "+dbName
try:
	db.query(dropDBSQL)
except Exception, e:
	print "Drop database failed with message:", e

# 4 - Create database:
createDBSQL = "CREATE DATABASE "+dbName
try:
	db.query(createDBSQL)
except Exception, e:
	print "Create database failed with message:", e

# 5 - Create user:
dropUserSQL = "DROP USER '"+dbUser+"'@'localhost'"
try:
	db.query(dropUserSQL)
except Exception, e:
	print "Drop user failed with message:", e

# 5 - Flush Privileges:
flushprivSQL = "FLUSH PRIVILEGES"
try:
	db.query(flushprivSQL)
except Exception, e:
	print "Flush Privileges failed with message:", e

# 6 - Create user:
createUserSQL = "CREATE USER '"+dbUser+"'@'localhost' IDENTIFIED BY '"+dbPass+"'"
try:
	db.query(createUserSQL)
except Exception, e:
	print "Create user failed with message:", e

# 7 - Assign privileges for own db
assignPriv = "GRANT ALL PRIVILEGES ON "+dbName+".* TO '"+dbUser+"'@'localhost'"
try:
	db.query(assignPriv)
except Exception, e:
	print "Grant privileges on ",dbName,"failed with message:", e

# 8 - Assign privileges for asterisk main db
asteriskPriv = "GRANT SELECT ON asterisk.* TO '"+dbUser+"'@'localhost'"
try:
	db.query(asteriskPriv)
except Exception, e:
	print "Grant select on asterisk failed with message:", e

# 9 - Assign privileges for asterisk cdr db
asteriskPriv = "GRANT SELECT ON asteriskcdrdb.* TO '"+dbUser+"'@'localhost'"
try:
	db.query(asteriskPriv)
except Exception, e:
	print "Grant select in asteriskcdrdb failed with message:", e

print """All operations finished successfully"""