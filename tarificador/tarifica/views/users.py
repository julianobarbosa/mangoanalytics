#Views for providers

import datetime
from django.utils.timezone import utc
from django.shortcuts import render, get_object_or_404
from django.http import HttpResponseRedirect, HttpResponse
from tarifica.tools.asteriskMySQLManager import AsteriskMySQLManager
from tarifica.models import *
from tarifica import forms
from django.db import connection, transaction
import json


def generalUsers(request, period_id="thisMonth"):
    cursor = connection.cursor()
    today = datetime.datetime.utcnow().replace(tzinfo=utc)
    form = forms.getDate(initial=
        {'start_date': datetime.date(year = today.year, month=today.month , day=1),
         'end_date': datetime.date(year = today.year, month=today.month , day=today.day),
        })
    last_month = False
    custom = False
    timedelta = datetime.timedelta(days = 1)
    end_date = datetime.date(year=today.year, month=today.month, day=today.day) + timedelta
    start_date = datetime.date(year=today.year, month=today.month, day=1) - timedelta
    if period_id == "lastMonth":
        t = datetime.datetime(year=today.year, month=today.month , day=1)- timedelta
        last_month = True
        end_date = datetime.date(year=today.year, month=today.month, day=1)
        start_date = datetime.date(year=t.year, month=t.month, day=1) - timedelta
    elif period_id == "custom":
        if request.method == 'POST': # If the form has been submitted...
            form = forms.getDate(request.POST) # A form bound to the POST data
            if form.is_valid(): # All validation rules pass
                start_date = form.cleaned_data['start_date'] - timedelta
                end_date = form.cleaned_data['end_date'] + timedelta
        custom = True
    #print start_date.isoformat()
    #print end_date.isoformat()
    cursor.execute(
        'SELECT tarifica_userdailydetail.id, SUM(tarifica_userdailydetail.cost) AS cost, \
        tarifica_extension.name, tarifica_extension.extension_number, tarifica_userdailydetail.extension_id AS extid \
        FROM tarifica_userdailydetail LEFT JOIN tarifica_extension\
        ON tarifica_userdailydetail.extension_id = tarifica_extension.id \
        WHERE date > %s AND date < %s GROUP BY extension_id ORDER BY SUM(cost) DESC',
        [start_date,end_date])
    extensions = dictfetchall(cursor)[:5]
    #for e in extensions : print e['extension_number']
    cursor.execute(
        'SELECT tarifica_userdailydetail.id, SUM(tarifica_userdailydetail.cost) AS cost, \
        SUM(tarifica_userdailydetail.total_minutes) AS minutes, tarifica_extension.name, \
        tarifica_extension.extension_number, tarifica_userdailydetail.extension_id AS extid \
        FROM tarifica_userdailydetail LEFT JOIN tarifica_extension\
        ON tarifica_userdailydetail.extension_id = tarifica_extension.id \
        WHERE date > %s AND date < %s GROUP BY extension_id ORDER BY SUM(cost) DESC',
        [start_date,end_date])
    all_users = dictfetchall(cursor)
    #for a in all_users: print a
    average = 0
    n = 0
    for cost in all_users:
        average += cost['cost']
        n += 1
    if n: average = average/n

    thisMonth = 'July'
    lastMonth = 'June'
    lastTwoMonths = 'May'

    data = getBarChartInfo(cursor)

    return render(request, 'tarifica/generalUsers.html', {
        'extensions' : extensions,
        'all_users' : all_users,
        'average' : average,
        'last_month' : last_month,
        'custom' : custom,
        'form': form,
        'thisMonth': thisMonth,
        'lastMonth': lastMonth,
        'lastTwoMonths': lastTwoMonths,
        'data' : json.dumps(data),
    })

def detailUsers(request, extension_id, period_id="thisMonth"):
    Ext = get_object_or_404(Extension, id = extension_id)
    cursor = connection.cursor()
    today = datetime.datetime.utcnow().replace(tzinfo=utc)
    form = forms.getDate(initial=
        {'start_date': datetime.date(year = today.year, month=today.month , day=1),
         'end_date': datetime.date(year = today.year, month=today.month , day=today.day),
        })
    last_month = False
    custom = False
    timedelta = datetime.timedelta(days = 1)
    end_date = datetime.date(year=today.year, month=today.month, day=today.day) + timedelta
    start_date = datetime.date(year=today.year, month=today.month, day=1) - timedelta
    if period_id == "lastMonth":
        t = datetime.datetime(year=today.year, month=today.month , day=1)- timedelta
        last_month = True
        end_date = datetime.date(year=today.year, month=today.month, day=1)
        start_date = datetime.date(year=t.year, month=t.month, day=1) - timedelta
    elif period_id == "custom":
        if request.method == 'POST': # If the form has been submitted...
            form = forms.getDate(request.POST) # A form bound to the POST data
            if form.is_valid(): # All validation rules pass
                start_date = form.cleaned_data['start_date'] - timedelta
                end_date = form.cleaned_data['end_date'] + timedelta
        custom = True
    print start_date.isoformat()
    print end_date.isoformat()
    cursor.execute('SELECT tarifica_userdestinationdetail.id, SUM(tarifica_userdestinationdetail.cost) AS cost,\
        tarifica_destinationgroup.id AS destid, tarifica_destinationname.name AS destname \
        FROM tarifica_userdestinationdetail LEFT JOIN tarifica_destinationgroup \
        ON tarifica_userdestinationdetail.destination_group_id = tarifica_destinationgroup.id \
        LEFT JOIN tarifica_destinationname ON tarifica_destinationgroup.destination_name_id = tarifica_destinationname.id \
        WHERE date > %s AND date < %s AND extension_id = %s GROUP BY destination_group_id \
        ORDER BY cost DESC',
        [start_date,end_date, Ext.id])
    destinations = dictfetchall(cursor)
    for d in destinations: print d
    cursor.execute('SELECT tarifica_call.id, tarifica_call.cost, tarifica_call.dialed_number, tarifica_call.duration,\
        tarifica_destinationname.name, tarifica_destinationcountry.name , tarifica_call.date AS dat,\
        tarifica_call.date AS time FROM tarifica_call LEFT JOIN tarifica_destinationgroup\
        ON tarifica_call.destination_group_id = tarifica_destinationgroup.id \
        LEFT JOIN tarifica_destinationname ON tarifica_destinationgroup.destination_name_id = tarifica_destinationname.id \
        LEFT JOIN tarifica_destinationcountry ON tarifica_destinationgroup.destination_country_id = tarifica_destinationcountry.id \
        WHERE date > %s AND date < %s AND extension_number = %s',
        [start_date,end_date, Ext.extension_number])
    all_calls = dictfetchall(cursor)
    average = 0
    n = 0
    for cost in all_calls:
        average += cost['cost']
        n += 1
        cost['dat'] = cost['dat'].strftime('%d %B %Y')
        cost['time'] = cost['time'].strftime('%H:%M:%S')
    if n: average = average/n
    data = getBarChartInfo(cursor)
    return render(request, 'tarifica/detailUsers.html', {
              'destinations' : destinations,
              'all_calls' : all_calls,
              'average' : average,
              'last_month' : last_month,
              'custom' : custom,
              'form': form,
              'extension' : Ext,
              'data' : json.dumps(data),
              })


def analyticsUsers(request, extension_id, period_id="thisMonth"):
    Ext = get_object_or_404(Extension, id = extension_id)
    cursor = connection.cursor()
    today = datetime.datetime.utcnow().replace(tzinfo=utc)
    form = forms.getDate(initial=
        {'start_date': datetime.date(year = today.year, month=today.month , day=1),
         'end_date': datetime.date(year = today.year, month=today.month , day=today.day),
        })
    last_month = False
    custom = False
    timedelta = datetime.timedelta(days = 1)
    end_date = datetime.date(year=today.year, month=today.month, day=today.day) + timedelta
    start_date = datetime.date(year=today.year, month=today.month, day=1) - timedelta
    start_date_year = datetime.date(year=today.year, month=1, day=1) - timedelta
    end_date_year = datetime.date(year=today.year, month=today.month, day=today.day) + timedelta
    if period_id == "lastMonth":
        t = datetime.datetime(year=today.year, month=today.month , day=1)- timedelta
        last_month = True
        end_date = datetime.date(year=today.year, month=today.month, day=1)
        start_date = datetime.date(year=t.year, month=t.month, day=1) - timedelta
    elif period_id == "custom":
        if request.method == 'POST': # If the form has been submitted...
            form = forms.getDate(request.POST) # A form bound to the POST data
            if form.is_valid(): # All validation rules pass
                start_date = form.cleaned_data['start_date'] - timedelta
                end_date = form.cleaned_data['end_date'] + timedelta
        custom = True
    print start_date.isoformat()
    print end_date.isoformat()
    sql = "SELECT tarifica_call.id,\
        SUM(tarifica_call.cost) AS cost,\
        tarifica_call.dialed_number,\
        SUM(tarifica_call.duration) AS duration \
        FROM tarifica_call\
        WHERE date > %s AND date < %s AND extension_number = %s \
        GROUP BY dialed_number ORDER BY SUM(cost) DESC"
    cursor.execute(sql,[start_date_year,end_date_year, Ext.extension_number])
    top_calls = dictfetchall(cursor)[:10]
    cursor.execute('SELECT tarifica_call.id, tarifica_call.cost, tarifica_call.dialed_number,\
        tarifica_destinationname.name, tarifica_destinationcountry.name , tarifica_call.date AS dat,\
        tarifica_call.date AS time FROM tarifica_call LEFT JOIN tarifica_destinationgroup\
        ON tarifica_call.destination_group_id = tarifica_destinationgroup.id \
        LEFT JOIN tarifica_destinationname ON tarifica_destinationgroup.destination_name_id = tarifica_destinationname.id \
        LEFT JOIN tarifica_destinationcountry ON tarifica_destinationgroup.destination_country_id = tarifica_destinationcountry.id \
        WHERE date > %s AND date < %s AND extension_number = %s',
        [start_date,end_date, Ext.extension_number])
    all_calls = dictfetchall(cursor)
    return render(request, 'tarifica/analyticsUsers.html', {
              'all_calls' : all_calls,
              'top_calls' : top_calls,
              'last_month' : last_month,
              'custom' : custom,
              'form': form,
              'extension' : Ext,
              })

def dictfetchall(cursor):
    desc = cursor.description
    return [
        dict(zip([col[0] for col in desc], row))
        for row in cursor.fetchall()
    ]

def getBarChartInfo(cursor):
    today = datetime.datetime.utcnow().replace(tzinfo=utc)
    timedelta = datetime.timedelta(days = 1)
    t1 = datetime.datetime(year=today.year, month = today.month, day=1) - timedelta
    t2 = datetime.datetime(year=t1.year, month = t1.month, day=1) - timedelta
    data = []
    aux = []
    aux.append("This Month")
    aux.append(getMonthName(t1.month))
    aux.append(getMonthName(t2.month))
    data.append(aux)
    #print aux
    aux = []
    end_date = datetime.date(year=today.year, month=today.month, day=today.day) + timedelta
    start_date = datetime.date(year=today.year, month=today.month, day=1) - timedelta
    cursor.execute(
        'SELECT tarifica_extension.name , tarifica_extension.id\
        FROM tarifica_extension\
         ORDER BY id')
    users = dictfetchall(cursor)
    for u in users: aux.append(u['name'])
    data.append(aux)
    aux = []
    cursor.execute(
        'SELECT tarifica_userdailydetail.id, SUM(tarifica_userdailydetail.cost) AS cost, \
        tarifica_extension.name, tarifica_extension.id AS extid \
        FROM tarifica_userdailydetail LEFT JOIN tarifica_extension\
        ON tarifica_userdailydetail.extension_id = tarifica_extension.id \
        WHERE date > %s AND date < %s GROUP BY extension_id ORDER BY extension_id DESC',
        [start_date,end_date])
    users = dictfetchall(cursor)
    for n in data[1]: aux.append(0)
    for u in users:
        aux[u['extid']-1] = u['cost']
    data.append(aux)
    #print aux
    aux = []
    end_date = datetime.date(year=today.year, month=today.month, day=1)
    start_date = datetime.date(year=t1.year, month=t1.month, day=1) - timedelta
    cursor.execute(
        'SELECT tarifica_userdailydetail.id, SUM(tarifica_userdailydetail.cost) AS cost, \
        tarifica_extension.name, tarifica_extension.id AS extid\
        FROM tarifica_userdailydetail LEFT JOIN tarifica_extension\
        ON tarifica_userdailydetail.extension_id = tarifica_extension.id \
        WHERE date > %s AND date < %s GROUP BY extension_id ORDER BY SUM(cost) DESC',
        [start_date,end_date])
    users = dictfetchall(cursor)
    #print users
    for n in data[1]: aux.append(0)
    for u in users:
        aux[u['extid']-1] = u['cost']
    data.append(aux)
    #print aux
    aux = []
    end_date = datetime.date(year=t1.year, month=t1.month, day=1)
    start_date = datetime.date(year=t2.year, month=t2.month, day=1) - timedelta
    cursor.execute(
        'SELECT tarifica_userdailydetail.id, SUM(tarifica_userdailydetail.cost) AS cost, \
        tarifica_extension.name, tarifica_extension.id AS extid \
        FROM tarifica_userdailydetail LEFT JOIN tarifica_extension\
        ON tarifica_userdailydetail.extension_id = tarifica_extension.id \
        WHERE date > %s AND date < %s GROUP BY extension_id ORDER BY SUM(cost) DESC',
        [start_date,end_date])
    users = dictfetchall(cursor)
    for n in data[1]: aux.append(0)
    for u in users:
        aux[u['extid']-1] = u['cost']
    data.append(aux)
    return data





def getMonthName(n):
    if n == 1:
        return "January"
    if n == 2:
        return "February"
    if n == 3:
        return "March"
    if n == 4:
        return "April"
    if n == 5:
        return "May"
    if n == 6:
        return "June"
    if n == 7:
        return "July"
    if n == 8:
        return "August"
    if n == 9:
        return "September"
    if n == 10:
        return "October"
    if n == 11:
        return "November"
    if n == 12:
        return "December"
    return "Not a month"