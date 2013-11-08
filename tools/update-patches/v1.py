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

# 3 - Alter table user_info: allow longer currency names and codes.
currency_symbol = "ALTER TABLE "+dbName+".tarifica_userinformation MODIFY \
currency_symbol VARCHAR(10);"
currency_code = "ALTER TABLE "+dbName+".tarifica_userinformation MODIFY \
currency_code VARCHAR(20);"
try:
	db.query(currency_symbol)
	db.query(currency_code)

	print "Database updated to v1 successfully."
except Exception, e:
	print "Update database failed with message:", e