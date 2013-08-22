# -*- coding: utf-8 -*-

#!/usr/bin/env python2.7
from asteriskMySQLManager import AsteriskMySQLManager
from datetime import datetime, timedelta, date
from assignCallCost import CallCostAssigner
from digester import Digester

def updateTrunkInformation():
    #Get existing information:
    am = AsteriskMySQLManager()
    am.connect('nextor_tarificador');
    sql = "SELECT * from tarifica_provider"
    am.cursor.execute(sql)
    existing_providers = am.cursor.fetchall()

    #Get current providers on asterisk's db
    todays_providers = am.getTrunkInformation()
    new_providers = []
    for today_p in todays_providers:
        existing = False
        for ex_p in existing_providers:
            if today_p['trunkid'] == ex_p['asterisk_id']:
                #Same provider, we just update its name:
                if today_p['name'] != ex_p['asterisk_name']:
                    print "Provider", ex_p['name'],'(saved as',ex_p['asterisk_name'],') has changed. New name is',today_p['name']
                    ex_p['asterisk_name'] = today_p['name']
                existing = True
        if not existing:
            #Didn't exist before, so we create one:
            new_provider = (
                today_p['trunkid'],
                today_p['name'],
                today_p['name'],
                today_p['tech'],
                today_p['channelid'],
            )
            new_providers.append(new_provider)
            print "New provider found:", today_p['name']
    #Now, we update all previously existing providers and save the new ones
    am.connect('nextor_tarificador');
    for ex_p in existing_providers:
        sql = "UPDATE tarifica_provider \
            SET asterisk_name = %s \
            WHERE id = %s"
        am.cursor.execute(sql, (ex_p['asterisk_name'], ex_p['id']))
        print "Provider", ex_p['name'], "updated."

    sql = "INSERT INTO tarifica_provider \
    (asterisk_id, asterisk_name, name, provider_tech, asterisk_channel_id) \
    VALUES(%s, %s, %s, %s, %s)"
    totalRowsSaved = am.cursor.executemany(sql, new_providers)
    am.db.commit()
    print "----------------------------------------"
    print totalRowsSaved, "new providers saved."

def updateUserInformation():
    #Get existing information:
    am = AsteriskMySQLManager()
    am.connect('nextor_tarificador');
    sql = "SELECT * from tarifica_extension"
    am.cursor.execute(sql)
    existing_users = am.cursor.fetchall()

    #Get current providers on asterisk's db
    todays_users = am.getUserInformation()
    new_users = []
    for today_u in todays_users:
        existing = False
        for ex_u in existing_users:
            if today_u['extension'] == ex_u['extension_number']:
                #Same user, we just update its name:
                if today_u['name'] != ex_u['name']:
                    print "User", ex_u['name'],'has changed. New name is',today_u['name']
                    ex_u['name'] = today_u['name']
                existing = True
        if not existing:
            #Didn't exist before, so we create one:
            new_user = (
                today_u['extension'],
                today_u['name'],
            )
            new_users.append(new_user)
            print "New user", today_u['name'], "found with extension", today_u['extension']

    #Now, we update all previously existing users and save the new ones
    am.connect('nextor_tarificador');
    for ex_u in existing_users:
        sql = "UPDATE tarifica_extension \
            SET name = %s \
            WHERE id = %s"
        am.cursor.execute(sql, (ex_u['name'], ex_u['id']))
        print "Extension", ex_u['name'], "updated."

    sql = "INSERT INTO tarifica_extension \
    (extension_number, name) \
    VALUES(%s, %s)"
    totalRowsSaved = am.cursor.executemany(sql, new_users)
    am.db.commit()
    print "----------------------------------------"
    print totalRowsSaved, "new extensions saved."

def updatePinsetInformation():
    #Get existing information:
    am = AsteriskMySQLManager()
    am.connect('nextor_tarificador');
    sql = "SELECT * from tarifica_pinset"
    am.cursor.execute(sql)
    existing_pinsets = am.cursor.fetchall()

    #Get current providers on asterisk's db
    todays_pinsets = am.getPinsetInformation()
    print todays_pinsets
    new_pinsets = []
    for today_u in todays_pinsets:
        existing = False
        for ex_u in existing_pinsets:
            if today_u == ex_u['pinset_number']:
                existing = True
        if not existing:
            #Didn't exist before, so we create one:
            new_pinset = (
                today_u,
            )
            new_pinsets.append(new_pinset)
            print "New pinset", today_u, "found."

    #Now, we update all previously existing pinsets and save the new ones
    am.connect('nextor_tarificador');
    sql = "INSERT INTO tarifica_pinset \
    (pinset_number) VALUES(%s)"
    totalRowsSaved = am.cursor.executemany(sql, new_pinsets)
    am.db.commit()
    print "----------------------------------------"
    print totalRowsSaved, "new pinsets saved."

if __name__ == "__main__":
    today = date.today()
    start = today - timedelta(days=0)

    cca = CallCostAssigner()
    dig = Digester()

    print "Digesting data from", start.strftime('%Y-%m-%d')

    #First we update all information on django's db:
    print "Updating Trunk Information..."
    updateTrunkInformation()
    print "Updating User Information..."
    updateUserInformation()
    print "Updating Pinset Information..."
    updatePinsetInformation()

    print "----------------------------------------------"
    print "Assigning costs..."

    result = cca.getDailyAsteriskCalls(start)
    print "Calls Saved:",result['total_calls_saved']
    print "Calls Not Saved:" ,result['total_calls_not_saved']

    dig.saveUserDailyDetail(start)
    dig.saveUserDestinationDetail(start)
    dig.saveUserDestinationNumberDetail(start)
    dig.saveProviderDailyDetail(start)
    dig.saveProviderDestinationDetail(start)
    dig.savePinsetDailyDetail(start)
    dig.savePinsetDestinationDetail(start)
    dig.savePinsetDestinationNumberDetail(start)

    print "----------------------------------------------"
    print "Digestion finished."
