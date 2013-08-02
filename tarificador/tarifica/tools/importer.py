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

# me == my email address
# you == recipient's email address
me = "nextortarificador@localhost"
you = sys.argv[1]

# Create message container - the correct MIME type is multipart/alternative.
msg = MIMEMultipart('alternative')
msg['Subject'] = "Cost calculations finished."
msg['From'] = me
msg['To'] = you

# Create the body of the message (a plain-text and an HTML version).
text = "Hi!\nHow are you?\nHere is the link you wanted:\nhttp://www.python.org"
html = """\
<html>
  <head></head>
  <body>
    <p>Hi!<br>
       How are you?<br>
       Here is the <a href="http://www.python.org">link</a> you wanted.
    </p>
  </body>
</html>
"""

# Record the MIME types of both parts - text/plain and text/html.
part1 = MIMEText(text, 'plain')
part2 = MIMEText(html, 'html')

# Attach parts into message container.
# According to RFC 2046, the last part of a multipart message, in this case
# the HTML message, is best and preferred.
msg.attach(part1)
msg.attach(part2)

# Send the message via local SMTP server.
s = smtplib.SMTP('localhost')
# sendmail function takes 3 arguments: sender's address, recipient's address
# and message to send - here it is sent as one string.
s.sendmail(me, you, msg.as_string())
s.quit()
print "Import finished, sending email to", sys.argv[1]