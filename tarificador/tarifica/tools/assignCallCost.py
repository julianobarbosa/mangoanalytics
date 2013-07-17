#!/usr/bin/env python2.7
import asteriskMySQLManager
from tarifica.models import *

class CallCostAssigner:
	destinationGroups = None
	bundles = None
	lastCall = None

	def assignBundleInfo(self):
		self.bundles = Bundle.objects.all()
	
	def assignDestinationGroupsInfo(self):
		self.destinationGroups = DestinationGroups.objects.all()

	def getNewAsteriskCalls(self):
		try:
			self.lastCall = Call.objects.order_by('id')[0:1].get()
		except DoesNotExist, e:
			self.lastCall = None
		
		am = AsteriskMySQLManager()
		am.connect('asteriskcdrdb')
		am.cursor.execute('')




if __name__ == '__main__':
	print 'running'