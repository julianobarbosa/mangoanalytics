# -*- coding: utf-8 -*-

#!/usr/bin/env python2.7
from asteriskMySQLManager import AsteriskMySQLManager
from datetime import datetime, timedelta, date
from assignCallCost import CallCostAssigner
from digester import Digester
import subprocess
import sys

def saveImportFinishStatus():
    am = AsteriskMySQLManager()
    am.connect('nextor_tarificador')
    sql = "UPDATE tarifica_userinformation \
        SET tarifica_userinformation.is_first_import_finished = %s, \
        tarifica_userinformation.test_run_in_progress = %s, \
        tarifica_userinformation.processing_in_progress = %s"
    am.cursor.execute(sql, (True, False, False))
    am.db.commit()
    return am.db.close()

def saveImportResults(calls_saved, calls_not_saved):
    am = AsteriskMySQLManager()
    am.connect('nextor_tarificador')
    sql = "INSERT INTO tarifica_importresults(calls_saved, calls_not_saved) \
        VALUES(%s, %s)"
    am.cursor.execute(sql, (calls_saved, calls_not_saved))
    am.db.commit()
    return am.db.close()

def deleteAllCalls():
    am = AsteriskMySQLManager()
    am.connect('nextor_tarificador')
    sql = "DELETE FROM tarifica_call"
    am.cursor.execute(sql, ())
    am.db.commit()
    return am.db.close()
        
def deleteAllUnconfiguredCalls():
    am = AsteriskMySQLManager()
    am.connect('nextor_tarificador')
    sql = "DELETE FROM tarifica_unconfiguredcall"
    am.cursor.execute(sql, ())
    am.db.commit()
    return am.db.close()

def deleteLastImportResults():
    am = AsteriskMySQLManager()
    am.connect('nextor_tarificador')
    sql = "DELETE FROM tarifica_importresults"
    am.cursor.execute(sql, ())
    am.db.commit()
    return am.db.close()

def deleteAllUserDailyDetail():
    am = AsteriskMySQLManager()
    am.connect('nextor_tarificador')
    sql = "DELETE FROM tarifica_userdailydetail"
    am.cursor.execute(sql, ())
    am.db.commit()
    return am.db.close()

def deleteAllUserDestinationDetail():
    am = AsteriskMySQLManager()
    am.connect('nextor_tarificador')
    sql = "DELETE FROM tarifica_userdestinationdetail"
    am.cursor.execute(sql, ())
    am.db.commit()
    return am.db.close()

def deleteAllUserDestinationNumberDetail():
    am = AsteriskMySQLManager()
    am.connect('nextor_tarificador')
    sql = "DELETE FROM tarifica_userdestinationnumberdetail"
    am.cursor.execute(sql, ())
    am.db.commit()
    return am.db.close()

def deleteAllProviderDailyDetail():
    am = AsteriskMySQLManager()
    am.connect('nextor_tarificador')
    sql = "DELETE FROM tarifica_providerdailydetail"
    am.cursor.execute(sql, ())
    am.db.commit()
    return am.db.close()

def deleteAllProviderDestinationDetail():
    am = AsteriskMySQLManager()
    am.connect('nextor_tarificador')
    sql = "DELETE FROM tarifica_providerdestinationdetail"
    am.cursor.execute(sql, ())
    am.db.commit()
    return am.db.close()

def deleteAllPinsetDailyDetail():
    am = AsteriskMySQLManager()
    am.connect('nextor_tarificador')
    sql = "DELETE FROM tarifica_pinsetdailydetail"
    am.cursor.execute(sql, ())
    am.db.commit()
    return am.db.close()

def deleteAllPinsetDestinationDetail():
    am = AsteriskMySQLManager()
    am.connect('nextor_tarificador')
    sql = "DELETE FROM tarifica_pinsetdestinationdetail"
    am.cursor.execute(sql, ())
    am.db.commit()
    return am.db.close()

def deleteAllPinsetDestinationNumberDetail():
    am = AsteriskMySQLManager()
    am.connect('nextor_tarificador')
    sql = "DELETE FROM tarifica_pinsetdestinationnumberdetail"
    am.cursor.execute(sql, ())
    am.db.commit()
    return am.db.close()

# This file processes from january first's worth of data, using assignCallCost and Digester
# We go six months back... back in time!

today = date.today()
start = date(year = today.year, month=1, day=1)
cca = CallCostAssigner()
dig = Digester()
calls_saved = 0
calls_not_saved = 0
testRun = False

if len(sys.argv) > 1:
    if sys.argv[1] != '':
        #We try to create a new date
        start = datetime.strptime(sys.argv[1], "%Y-%m-%d").date()
        print start

if len(sys.argv) > 2:
    if sys.argv[2] == '--testrun':
        testRun = True

#Comenzamos borrando tooooodo
if testRun:
        deleteAllUnconfiguredCalls()
        deleteLastImportResults()
else:   
    deleteAllCalls()
    deleteAllUnconfiguredCalls()
    deleteAllUserDailyDetail()
    deleteAllUserDestinationDetail()
    deleteAllUserDestinationNumberDetail()
    deleteAllProviderDailyDetail()
    deleteAllProviderDestinationDetail()
    deleteAllPinsetDailyDetail()
    deleteAllPinsetDestinationDetail()
    deleteAllPinsetDestinationNumberDetail()
print "Deleted all previous data."

while start != today:
    print "Digesting data from", start.strftime('%Y-%m-%d')

    # Assign call costs to selected day
    result = cca.getDailyAsteriskCalls(start)
    calls_saved += result['total_calls_saved']
    calls_not_saved += result['total_calls_not_saved']
    
    if not testRun:    
        dig.saveUserDailyDetail(start)
        dig.saveUserDestinationDetail(start)
        dig.saveUserDestinationNumberDetail(start)
        dig.saveProviderDailyDetail(start)
        dig.saveProviderDestinationDetail(start)
        dig.savePinsetDailyDetail(start)
        dig.savePinsetDestinationDetail(start)
        dig.savePinsetDestinationNumberDetail(start)

    start = start + timedelta(days = 1)

saveImportFinishStatus()
if testRun:
    saveImportResults(calls_saved, calls_not_saved)
    print "----------------------------------------"
    print "Testrun finished."
else:
    print "----------------------------------------"
    print "Import status set as finished."