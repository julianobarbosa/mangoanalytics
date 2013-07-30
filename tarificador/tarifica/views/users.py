#Views for providers

import datetime
from django.utils.timezone import utc
from django.shortcuts import render, get_object_or_404
from django.http import HttpResponseRedirect, HttpResponse
from tarifica.tools.asteriskMySQLManager import AsteriskMySQLManager
from tarifica.models import *
from tarifica import forms

def generalUsersLastMonth(request):
    today = datetime.datetime.utcnow().replace(tzinfo=utc)
    timedelta = datetime.timedelta(day = 1)
    t = today - timedelta
    generalUsers




def generalUsers(request, period_id="actual"):
    from django.db import connection, transaction
    cursor = connection.cursor()
    today = datetime.datetime.utcnow().replace(tzinfo=utc)
    form = forms.getDate()
    y = 0
    m = 0
    d = 0
    last_month = False
    custom = False
    if period_id == "last":
        timedelta = datetime.timedelta(days = 1)
        t = datetime.datetime(year=today.year, month=today.month , day=1)- timedelta
        y = t.year
        m = t.month
        d = t.day
        last_month = True
        print y
    elif period_id == "custom":
        pass
    else:
        y = today.year
        m = today.month
        d = today.day
    end_date = datetime.date(year=y, month=m, day=d)
    start_date = datetime.date(year=y, month=m , day=1)
    cursor.execute('SELECT tarifica_userdailydetail.id, SUM(tarifica_userdailydetail.cost) AS cost, tarifica_extension.name, tarifica_extension.extension_number, tarifica_userdailydetail.extension_id AS extid \
        FROM tarifica_userdailydetail \
        LEFT JOIN tarifica_extension\
        ON tarifica_userdailydetail.extension_id = tarifica_extension.id \
        WHERE date > %s AND date < %s GROUP BY extension_id ORDER BY SUM(cost) DESC',
        [start_date,end_date])
    extensions = dictfetchall(cursor)[:5]
    cursor.execute('SELECT tarifica_userdailydetail.id, SUM(tarifica_userdailydetail.cost) AS cost, SUM(tarifica_userdailydetail.total_minutes) AS minutes\
        , tarifica_extension.name, tarifica_extension.extension_number, tarifica_userdailydetail.extension_id AS extid \
        FROM tarifica_userdailydetail \
        LEFT JOIN tarifica_extension\
        ON tarifica_userdailydetail.extension_id = tarifica_extension.id \
        WHERE date > %s AND date < %s GROUP BY extension_id ORDER BY SUM(cost) DESC',
        [start_date,end_date])
    all_users = dictfetchall(cursor)
    average = 0
    n = 0
    for cost in all_users:
        average += cost['cost']
        n += 1
    if n: average = average/n
    return render(request, 'tarifica/usersgeneral.html', {
              'extensions' : extensions,
              'all_users' : all_users,
              'average' : average,
              'last_month' : last_month,
              'custom' : custom,
              'form': form,
              })

def detailUsers(request, extension_id):
    pass

def analiticsUsers(request, extension_id):
    pass

def dictfetchall(cursor):
    desc = cursor.description
    return [
        dict(zip([col[0] for col in desc], row))
        for row in cursor.fetchall()
    ]