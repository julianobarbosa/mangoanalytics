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
    user_info = get_object_or_404(UserInformation, id = 1)
    today = datetime.datetime.utcnow().replace(tzinfo=utc)
    form = forms.getDate(initial=
        {'start_date': datetime.date(year = today.year, month=today.month , day=1),
         'end_date': datetime.date(year = today.year, month=today.month , day=today.day),
        }
    )
    timedelta = datetime.timedelta(days = 1)
    custom = False
    last_month = False
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

    providers = Provider.objects.filter(is_configured = True)
    averageMonthlyCost = 0
    totalTrunksCost = 0
    providersData = []
    monthUsage = 0
    thisBillingPeriod = 0
    for p in providers:
        bundlesCost = getBundlesCost(p.id)
        if bundlesCost[0]['cost'] is None:
            bundlesCost[0]['cost'] = 0
        billingPeriods = getBillingPeriods(p)
        thisBillingPeriod = billingPeriods[0]['data'][0]['total_cost']
        if thisBillingPeriod is None :
            thisBillingPeriod = 0
        thisBillingPeriod += bundlesCost[0]['cost']
        total_cost = 0
        current_interval_cost = getTrunkCurrentIntervalCost(p.id, start_date, end_date)[0]['total_cost']
        if current_interval_cost is None:
            current_interval_cost = 0
        if bundlesCost[0]['cost'] is None:
            bundlesCost[0]['cost'] = 0
        total_cost = bundlesCost[0]['cost'] + current_interval_cost
        for b in billingPeriods:
            if b['data'][0]['total_cost'] is not None:
                averageMonthlyCost += b['data'][0]['total_cost']
            average_cost = averageMonthlyCost / len(billingPeriods)
        totalTrunksCost = totalTrunksCost + total_cost
        providersData.append({
            'provider': p, 
            'total_cost': total_cost, 
            'average_cost': average_cost,
            'thisBillingPeriod' : thisBillingPeriod,
            'current_interval_cost' : current_interval_cost,
            'bundlesCost' : bundlesCost[0]['cost'],
        })

    return render(request, 'tarifica/trunks/trunks.html', {
        'user_info' : user_info,
        'providers' : providersData,
        'form' : form,
        'totalTrunksCost' : totalTrunksCost,
        'custom' : custom,
        'last_month' : last_month,
    })


def getTrunk(request, trunk_id, period_id="thisMonth"):
    user_info = get_object_or_404(UserInformation, id = 1)
    provider = get_object_or_404(Provider, id = trunk_id)

    # Required for getting this month's, last month's and custom start and end dates
    today = datetime.datetime.utcnow().replace(tzinfo=utc)
    form = forms.getDate(initial=
        {'start_date': datetime.date(year = today.year, month=today.month , day=1),
         'end_date': datetime.date(year = today.year, month=today.month , day=today.day),
        }
    )
    timedelta = datetime.timedelta(days = 1)
    custom = False
    last_month = False
    end_date = datetime.date(year=today.year, month=today.month, day=today.day) + timedelta
    start_date = datetime.date(year=today.year, month=today.month, day=1)
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

    bundlesCost = getBundlesCost(provider.id)
    total_cost = 0
    current_interval_cost = getTrunkCurrentIntervalCost(provider.id, start_date, end_date)[0]['total_cost']
    if current_interval_cost is None:
        current_interval_cost = 0
    if bundlesCost[0]['cost'] is None:
        bundlesCost[0]['cost'] = 0
    total_cost = bundlesCost[0]['cost'] + current_interval_cost
    averageMonthlyCost = 0
    currentPeriodCost = 0
    billingPeriods = getBillingPeriods(provider)
    thisBillingPeriod = billingPeriods[0]['data'][0]['total_cost']
    if thisBillingPeriod is None :
        thisBillingPeriod = 0
    thisBillingPeriod += bundlesCost[0]['cost']
    for b in billingPeriods:
        if b['data'][0]['total_cost'] is not None:
            averageMonthlyCost += b['data'][0]['total_cost']
    averageMonthlyCost = averageMonthlyCost / len(billingPeriods)

    calls = getTrunkCalls(provider.id, start_date, end_date)
    currentPeriodCost = getTrunkCurrentIntervalCost(provider.id, start_date, end_date)

    return render(request, 'tarifica/trunks/trunksGet.html', {
        'user_info' : user_info,
        'provider' : provider,
        'billingPeriods': billingPeriods,
        'calls': calls,
        'period_id': period_id,
        'averageMonthlyCost': averageMonthlyCost,
        'currentPeriodCost': currentPeriodCost[0]['total_cost'],
        'total_cost' : total_cost,
        'thisBillingPeriod' : thisBillingPeriod,
        'custom' : custom,
        'last_month' : last_month,
        'form' : form
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
        AND date > %s AND date < %s ORDER BY date"
    cursor.execute(sql, (provider_id, start_date, end_date))
    return dictfetchall(cursor)


def getBundlesCost(provider_id):
    cursor = connection.cursor()
    sql = "SELECT SUM(tarifica_bundle.cost) as cost \
        FROM tarifica_bundle \
        LEFT JOIN tarifica_destinationgroup \
        ON tarifica_bundle.destination_group_id = tarifica_destinationgroup.id \
        WHERE tarifica_destinationgroup.provider_id = %s "
    cursor.execute(sql, (provider_id))
    return dictfetchall(cursor)

def downloadTrunkCDR(request, trunk_id, period_id):
    pass