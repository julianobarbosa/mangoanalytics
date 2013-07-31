#Views for providers

import datetime
from django.utils.timezone import utc
from django.shortcuts import render, get_object_or_404
from django.http import HttpResponseRedirect, HttpResponse
from tarifica.models import *
from tarifica import forms
from django.db import connection, transaction
from tarifica.views.general import dictfetchall

def general(request):
    providers = Provider.objects.filter(is_configured = True)
    return render(request, 'tarifica/trunks.html', {
        'providers' : providers,
    })
    
def getTrunk(request, trunk_id, period_id="thisMonth"):
    provider = get_object_or_404(Provider, id = trunk_id)

    # Required for getting this month's, last month's and custom start and end dates
    today = datetime.datetime.utcnow().replace(tzinfo=utc)
    form = forms.getDate(initial=
        {'start_date': datetime.date(year = today.year, month=today.month , day=1),
         'end_date': datetime.date(year = today.year, month=today.month , day=today.day),
        }
    )
    end_date = datetime.date(year=today.year, month=today.month, day=today.day)
    start_date = datetime.date(year=today.year, month=today.month, day=1)
    if period_id == "lastMonth":
        timedelta = datetime.timedelta(days = 1)
        t = datetime.datetime(year=today.year, month=today.month , day=1)- timedelta
        end_date = datetime.date(year=t.year, month=t.month, day=t.day)
        start_date = datetime.date(year=t.year, month=t.month, day=1)
    elif period_id == "custom":
        if request.method == 'POST': # If the form has been submitted...
            form = forms.getDate(request.POST) # A form bound to the POST data
            if form.is_valid(): # All validation rules pass
                start_date = form.cleaned_data['start_date']
                end_date = form.cleaned_data['end_date']

    averageMonthlyCost = 0
    currentPeriodCost = 0
    
    currentBillingPeriod = datetime.date(
        year = today.year,
        month = today.month,
        day = provider.period_end
    )
    startCurrentBillingPeriod = datetime.date(
        year = currentBillingPeriod.year, 
        month = currentBillingPeriod.month - 1,
        day = currentBillingPeriod.day
    )
    endCurrentBillingPeriod = currentBillingPeriod

    print "start: "
    print startCurrentBillingPeriod
    print "end: "
    print endCurrentBillingPeriod
    
    billingPeriodData = {
        'date_start': startCurrentBillingPeriod,
        'date_end': endCurrentBillingPeriod,
        'data': getTrunkCDR(provider.id, startCurrentBillingPeriod, endCurrentBillingPeriod)
    }

    billingPeriods = []
    billingPeriods.append(billingPeriodData)
    print billingPeriods

    calls = getTrunkCalls(provider.id, start_date, end_date)

    return render(request, 'tarifica/trunksGet.html', {
        'provider' : provider,
        'billingPeriods': billingPeriods,
        'calls': calls,
        'period_id': period_id
    })

def getTrunkCDR(provider_id, start_date, end_date):
    cursor = connection.cursor()
    sql = "SELECT \
        SUM(tarifica_providerdailydetail.cost), \
        SUM(tarifica_providerdailydetail.total_calls), \
        SUM(tarifica_providerdailydetail.total_minutes) \
        FROM tarifica_providerdailydetail \
        WHERE tarifica_providerdailydetail.provider_id = %s \
        AND date > %s AND date < %s"
    cursor.execute(sql, (provider_id, start_date, end_date))
    return cursor.fetchone()

def getTrunkCalls(provider_id, start_date, end_date):
    cursor = connection.cursor()
    sql = "SELECT tarifica_call.date, \
        tarifica_call.dialed_number, \
        tarifica_call.duration, \
        tarifica_call.cost, \
        tarifica_call.extension_number, \
        tarifica_destinationname.name \
        FROM tarifica_call \
        LEFT JOIN tarifica_destinationgroup \
        ON tarifica_call.destination_group_id = tarifica_destinationgroup.id \
        LEFT JOIN tarifica_destinationname \
        ON tarifica_destinationgroup.destination_name_id = tarifica_destinationname.id \
        WHERE tarifica_call.provider_id = %s \
        AND date > %s AND date < %s"
    cursor.execute(sql, (provider_id, start_date, end_date))
    return dictfetchall(cursor)

def downloadTrunkCDR(request, trunk_id, period_id):
    pass