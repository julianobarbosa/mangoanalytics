#Views for providers

import datetime
from django.utils.timezone import utc
from django.shortcuts import render, get_object_or_404
from django.http import HttpResponseRedirect, HttpResponse
from tarifica.tools.asteriskMySQLManager import AsteriskMySQLManager
from tarifica.models import *
from django.forms.formsets import formset_factory

def generalUsers(request, month=None, year=None, day=None):
    from django.db import connection, transaction
    cursor = connection.cursor()
    today = datetime.datetime.utcnow().replace(tzinfo=utc)
    y = 0
    m = 0
    d = 0
    if year:
        y = year
    else:
        y = today.year
    if month:
        m = month
    else:
        m = today.month
    if day:
        d = day
    else:
        d = today.day
    end_date = datetime.date(y, m, d)
    start_date = datetime.date(y, m , 1)
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
    average = average/n
    return render(request, 'tarifica/usersgeneral.html', {
              'extensions' : extensions,
              'all_users' : all_users,
              'average' : average,
              })

def detailUsers(request, extension_id):
    pass

def analiticsUsers(request, extension_id):
    pass