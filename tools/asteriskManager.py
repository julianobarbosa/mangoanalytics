#!/usr/bin/env python2.7

class AsteriskManager:
	def getMySQLPassword(self):
		elastixConf = open('/etc/elastix.conf', 'r')
		while True:
			line = elastixConf.readline()
			if not line: 
				break
			print line
		pass

	def getTrunkInformation(self):
		
		pass

	def getUserInformation(self):
		pass

