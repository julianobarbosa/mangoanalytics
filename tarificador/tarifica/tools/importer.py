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
        SET tarifica_userinformation.is_first_import_finished = %s \
        WHERE tarifica_userinformation.id = %s "
    am.cursor.execute(sql, (True, 1))
    return am.db.commit()
        
# This file processes two month's worth of data, using assignCallCost and Digester
# We go two months back... back in time!

today = date.today()
six_months_back = today - timedelta(days = 140) # One more just if
cca = CallCostAssigner()
dig = Digester()
while six_months_back != today:
    print "Digesting data from", six_months_back.strftime('%Y-%m-%d')
    # Assign call costs to selected day
    cca.getDailyAsteriskCalls(six_months_back)
    dig.saveUserDailyDetail(six_months_back)
    dig.saveUserDestinationDetail(six_months_back)
    dig.saveUserDestinationNumberDetail(six_months_back)
    dig.saveProviderDailyDetail(six_months_back)
    dig.saveProviderDestinationDetail(six_months_back)

    six_months_back = six_months_back + timedelta(days = 1)
print "----------------------------------------"
saveImportFinishStatus()
print "Import status set as finished."