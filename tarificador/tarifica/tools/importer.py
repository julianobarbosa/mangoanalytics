# -*- coding: utf-8 -*-

#!/usr/bin/env python2.7
from asteriskMySQLManager import AsteriskMySQLManager
from datetime import datetime, timedelta, date
from assignCallCost import CallCostAssigner
from digester import Digester
import subprocess
import sys
import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText

def saveImportFinishStatus():
    am = AsteriskMySQLManager()
    am.connect('nextor_tarificador')
    sql = "UPDATE tarifica_userinformation \
        SET tarifica_userinformation.is_first_import_finished = %s"
    print am.cursor.execute(sql, (True,))
    print am.db.commit()

def saveImportResults(calls_saved, calls_not_saved):
    am = AsteriskMySQLManager()
    am.connect('nextor_tarificador')
    sql = "INSERT INTO tarifica_importresults(calls_saved, calls_not_saved) \
        VALUES(%s, %s)"
    am.cursor.execute(sql, (calls_saved, calls_not_saved))
    return am.db.commit()
        
# This file processes two month's worth of data, using assignCallCost and Digester
# We go two months back... back in time!

today = date.today()
six_months_back = today - timedelta(days = 140) # One more just if
cca = CallCostAssigner()
dig = Digester()
calls_saved = 0
calls_not_saved = 0
while six_months_back != today:
    print "Digesting data from", six_months_back.strftime('%Y-%m-%d')
    
    # Assign call costs to selected day
    result = cca.getDailyAsteriskCalls(six_months_back)
    calls_saved += result['total_calls_saved']
    calls_not_saved += result['total_calls_not_saved']
    
    if sys.argv[1] == '--testrun':
        print "Call cost assigned, not saving (--testrun)."    
    else:    
        dig.saveUserDailyDetail(six_months_back)
        dig.saveUserDestinationDetail(six_months_back)
        dig.saveUserDestinationNumberDetail(six_months_back)
        dig.saveProviderDailyDetail(six_months_back)
        dig.saveProviderDestinationDetail(six_months_back)

    six_months_back = six_months_back + timedelta(days = 1)

saveImportFinishStatus()
if sys.argv[1] == '--testrun':
    saveImportResults(calls_saved, calls_not_saved)
    print "----------------------------------------"
    print "Testrun finished."    
else:
    print "----------------------------------------"
    print "Import status set as finished."