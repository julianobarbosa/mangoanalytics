#Views for providers

from __future__ import division
import datetime
from django.utils.timezone import utc
from django.shortcuts import render, get_object_or_404
from django.http import HttpResponseRedirect, HttpResponse
from tarifica.models import *
from tarifica import forms
from django.db import connection, transaction
from tarifica.views.general import dictfetchall

def general(request, period_id="thisMonth"):
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

    providers = Provider.objects.filter(is_configured = True)
    averageMonthlyCost = 0
    totalTrunksCost = 0
    providersData = []
    for p in providers:
        bundlesCost = getBundlesCost(p.id)
        billingPeriods = getBillingPeriods(p)
        total_cost = getTrunkCurrentIntervalCost(p.id, start_date, end_date)[0]['total_cost'] + bundlesCost
        for b in billingPeriods:
            if b['data'][0]['total_cost'] is not None:
                averageMonthlyCost += b['data'][0]['total_cost']
            average_cost = averageMonthlyCost / len(billingPeriods)
        totalTrunksCost = totalTrunksCost + total_cost
        providersData.append({
            'provider': p, 
            'total_cost': total_cost, 
            'average_cost': average_cost
        })

    return render(request, 'tarifica/troncalesgeneral.html', {
        'providers' : providersData,
        'form' : form,
        'totalTrunksCost' : totalTrunksCost
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
    billingPeriods = getBillingPeriods(provider)
    
    for b in billingPeriods:
        if b['data'][0]['total_cost'] is not None:
            averageMonthlyCost += b['data'][0]['total_cost']
    averageMonthlyCost = averageMonthlyCost / len(billingPeriods)

    calls = getTrunkCalls(provider.id, start_date, end_date)
    currentPeriodCost = getTrunkCurrentIntervalCost(provider.id, start_date, end_date)

    return render(request, 'tarifica/trunksGet.html', {
        'provider' : provider,
        'billingPeriods': billingPeriods,
        'calls': calls,
        'period_id': period_id,
        'averageMonthlyCost': averageMonthlyCost,
        'currentPeriodCost': currentPeriodCost[0]['total_cost']
    })

def getTrunkCDR(provider_id, start_date, end_date):
    cursor = connection.cursor()
    sql = "SELECT \
        SUM(tarifica_providerdailydetail.cost) as total_cost, \
        SUM(tarifica_providerdailydetail.total_calls) as total_calls, \
        SUM(tarifica_providerdailydetail.total_minutes) as total_minutes \
        FROM tarifica_providerdailydetail \
        WHERE tarifica_providerdailydetail.provider_id = %s \
        AND date > %s AND date < %s"
    cursor.execute(sql, (provider_id, start_date, end_date))
    return dictfetchall(cursor)

def getTrunkCurrentIntervalCost(provider_id, start_date, end_date):
    cursor = connection.cursor()
    sql = "SELECT SUM(tarifica_providerdailydetail.cost) as total_cost \
        FROM tarifica_providerdailydetail \
        WHERE tarifica_providerdailydetail.provider_id = %s \
        AND date > %s AND date < %s"
    cursor.execute(sql, (provider_id, start_date, end_date))
    return dictfetchall(cursor)

def getBillingPeriods(provider):
    today = datetime.datetime.utcnow().replace(tzinfo=utc)
    endCurrentBillingPeriod = datetime.date(
        year = today.year,
        month = today.month,
        day = provider.period_end
    )
    startCurrentBillingPeriod = datetime.date(
        year = endCurrentBillingPeriod.year, 
        month = endCurrentBillingPeriod.month - 1,
        day = endCurrentBillingPeriod.day
    )
    
    billingPeriodData = {
        'date_start': startCurrentBillingPeriod,
        'date_end': endCurrentBillingPeriod,
        'data': getTrunkCDR(provider.id, startCurrentBillingPeriod, endCurrentBillingPeriod)
    }

    billingPeriods = []
    billingPeriods.append(billingPeriodData)
    while True:
        if startCurrentBillingPeriod.month == 1:
            break
        endCurrentBillingPeriod = startCurrentBillingPeriod        
        startCurrentBillingPeriod = datetime.date(
            year = startCurrentBillingPeriod.year, 
            month = startCurrentBillingPeriod.month - 1,
            day = startCurrentBillingPeriod.day
        )

        billingPeriodData = {
            'date_start': startCurrentBillingPeriod,
            'date_end': endCurrentBillingPeriod,
            'data': getTrunkCDR(provider.id, startCurrentBillingPeriod, endCurrentBillingPeriod)
        }
        billingPeriods.append(billingPeriodData)
    return billingPeriods

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


def getBundlesCost(provider_id):
    cursor = connection.cursor()
    sql = "SELECT SUM(tarifica_bundle.cost) as cost , tarifica_bundle.id \
        FROM tarifica_destinationgroup \
        LEFT JOIN tarifica_bundle.destination_group_id = tarifica_destinationgroup.id \
        WHERE tarifica_destinationgroup.provider_id = %s "
    cursor.execute(sql, (provider_id))
    return dictfetchall(cursor)



def downloadTrunkCDR(request, trunk_id, period_id):
    pass