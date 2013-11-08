#Views for providers

from __future__ import division
import datetime
from tarifica.tools.asteriskMySQLManager import AsteriskMySQLManager
from django.utils.timezone import utc
from django.shortcuts import render, get_object_or_404
from django.http import HttpResponseRedirect, HttpResponse, HttpResponseServerError
from tarifica.models import *
from tarifica import forms
from django.db import connection, transaction
from dateutil.relativedelta import *
import json
from csv import *
from django.contrib.auth.decorators import login_required

@login_required(login_url='tarifica:login')
def general(request, period_id="thisMonth"):
    #Syncing extensions, pinsets and trunks
    syncAsteriskInformation()

    # Required for getting this month's, last month's and custom start and end dates
    user_info = get_object_or_404(UserInformation, id = 1)
    today = datetime.datetime.now()
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
    providersData = []
    providersGraphs = []
    providersGraphsTicks = []
    ticksAssigned = False
    this_month_total_usage = 0
    total_trunks_month_usage = 0
    for p in providers:
        # Obtenemos los periodos de cobro:
        billingPeriods = getBillingPeriods(p)        
        graph_data = []
        for b in billingPeriods:
            if not ticksAssigned:
                providersGraphsTicks.append(b['date_start'].strftime('%b')+" - "+b['date_end'].strftime('%b'))

            averageMonthlyCost += b['total_cost']
            #Agregamos tambien la informacion pa las graphs
            graph_data.append(b['total_cost'])
        ticksAssigned = True

        providersGraphs.append({
            'provider_id': p.id,
            'provider_name': p.name,
            'data': graph_data
        })

        average_cost = averageMonthlyCost / len(billingPeriods)
        this_month_total_usage = getTrunkCurrentIntervalData(p, start_date, end_date)
        print this_month_total_usage
        #print this_month_total_usage
        total_trunks_month_usage += this_month_total_usage['total_cost']
        providersData.append({
            'provider': p, 
            'average_cost': average_cost,
            'this_month_total_usage' : this_month_total_usage,
            'next_month_end_date': p.period_end - 1
        })

    destinationInfo = getAllProvidersDestinationCDR(start_date, end_date)
    #print destinationInfo
    destinationGraph = []
    for d in destinationInfo:
        destinationGraph.append([d['destination_name'], d['total_cost']])

    return render(request, 'tarifica/trunks/trunks.html', {
        'user_info' : user_info,
        'form' : form,
        'custom' : custom,
        'last_month' : last_month,
        'total_trunks_month_usage' : total_trunks_month_usage,
        'providers' : providersData,
        'destinationGraph' : json.dumps(destinationGraph),
        'providersGraphs' : json.dumps(providersGraphs),
        'providersGraphsTicks' : json.dumps(providersGraphsTicks),
        'start_date': start_date + datetime.timedelta(days=1),
        'end_date': end_date - datetime.timedelta(days=1),
    })

@login_required(login_url='tarifica:login')
def getTrunk(request, provider_id, period_id="thisMonth"):
    #Syncing extensions, pinsets and trunks
    syncAsteriskInformation()

    user_info = get_object_or_404(UserInformation, id = 1)
    provider = get_object_or_404(Provider, id = provider_id)

    # Required for getting this month's, last month's and custom start and end dates
    today = datetime.datetime.now()
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

    cost_graph = []
    minutes_graph = []
    billing_period_cost = 0

    # Obtenemos los periodos de cobro:
    billingPeriods = getBillingPeriods(provider)        
    graph_data = []
    for b in billingPeriods:
        minutes = int(b['total_seconds'])
        cost = float(b['total_cost'])
        billing_period_cost += b['total_cost']
        cost_graph.append([
            b['date_start'].strftime('%b')+" - "+b['date_end'].strftime('%b'),
            cost 
        ])
        minutes_graph.append([
            b['date_start'].strftime('%b')+" - "+b['date_end'].strftime('%b'),
            minutes
        ])
    
    this_month_total_usage = getTrunkCurrentIntervalData(provider, start_date, end_date)
    average_monthly_cost = billing_period_cost / len(billingPeriods)

    destinationInfo = getProviderDestinationCDR(provider.id, start_date, end_date)
    destinationGraph = []
    for d in destinationInfo:
        destinationGraph.append([d['destination_name'], d['total_cost']])

    return render(request, 'tarifica/trunks/trunksGet.html', {
        'user_info' : user_info,
        'provider': provider,
        'form' : form,
        'custom' : custom,
        'last_month' : last_month,
        'average_monthly_cost': average_monthly_cost,
        'this_month_total_usage': this_month_total_usage,
        'period_id': period_id,
        'start_date': start_date.strftime("%Y-%m-%d"),
        'end_date': end_date.strftime("%Y-%m-%d"),
        'billingPeriods' : billingPeriods,
        'destinationGraph' : json.dumps(destinationGraph),
        'cost_graph' : json.dumps(cost_graph),
        'minutes_graph' : json.dumps(minutes_graph),
    })

def getTrunkCDR(provider_id, start_date, end_date):
    cursor = connection.cursor()
    sql = "SELECT \
        SUM(tarifica_providerdailydetail.cost) as total_call_cost, \
        SUM(tarifica_providerdailydetail.total_calls) as total_calls, \
        SUM(tarifica_providerdailydetail.total_seconds) as total_seconds \
        FROM tarifica_providerdailydetail \
        WHERE tarifica_providerdailydetail.provider_id = %s \
        AND date >= %s AND date <= %s"
    cursor.execute(sql, (provider_id, start_date, end_date))
    result = dictfetchall(cursor)
    return result[0]

def getProviderDestinationCDR(provider_id, start_date, end_date):
    cursor = connection.cursor()
    sql = "SELECT \
        SUM(tarifica_providerdestinationdetail.cost) as total_cost, \
        tarifica_destinationname.name as destination_name \
        FROM tarifica_providerdestinationdetail \
        LEFT JOIN tarifica_destinationgroup ON \
        tarifica_providerdestinationdetail.destination_group_id = tarifica_destinationgroup.id \
        LEFT JOIN tarifica_destinationname ON \
        tarifica_destinationgroup.destination_name_id = tarifica_destinationname.id \
        WHERE tarifica_providerdestinationdetail.provider_id = %s \
        AND date >= %s AND date <= %s \
        GROUP BY tarifica_destinationname.id"
    cursor.execute(sql, (provider_id, start_date, end_date))
    return dictfetchall(cursor)

def getAllProvidersDestinationCDR(start_date, end_date):
    cursor = connection.cursor()
    sql = "SELECT \
        SUM(tarifica_providerdestinationdetail.cost) as total_cost, \
        tarifica_destinationname.name as destination_name \
        FROM tarifica_providerdestinationdetail \
        LEFT JOIN tarifica_destinationgroup ON \
        tarifica_providerdestinationdetail.destination_group_id = tarifica_destinationgroup.id \
        LEFT JOIN tarifica_destinationname ON \
        tarifica_destinationgroup.destination_name_id = tarifica_destinationname.id \
        WHERE date >= %s AND date <= %s \
        GROUP BY tarifica_destinationname.id"
    cursor.execute(sql, (start_date, end_date))
    return dictfetchall(cursor)

def getTrunkCurrentIntervalData(provider, start_date, end_date):
    cursor = connection.cursor()
    sql = "SELECT SUM(tarifica_providerdailydetail.cost) as total_call_cost, \
        SUM(tarifica_providerdailydetail.total_calls) as total_calls, \
        SUM(tarifica_providerdailydetail.total_seconds) as total_seconds, \
        tarifica_providerdailydetail.date as date \
        FROM tarifica_providerdailydetail \
        WHERE tarifica_providerdailydetail.provider_id = %s \
        AND date >= %s AND date <= %s"
    cursor.execute(sql, (provider.id, start_date, end_date))
    intervalData = dictfetchall(cursor)[0]
    intervalData.update(getProviderBundleCost(provider, start_date, end_date))
    if intervalData['total_call_cost'] is None:
        intervalData['total_call_cost'] = 0
    call_cost = intervalData['total_call_cost']
    if intervalData['total_bundle_cost'] is None:
        intervalData['total_bundle_cost'] = 0
    bundle_cost = intervalData['total_bundle_cost']
    intervalData.update({'monthly_cost': provider.monthly_cost })
    intervalData.update({'total_cost': call_cost + bundle_cost + provider.monthly_cost})
    return intervalData

def getBillingPeriods(provider):
    today = datetime.datetime.now()
    startCurrentBillingPeriod = datetime.date(
        year = today.year,
        month = today.month,
        day = provider.period_end
    )
    endCurrentBillingPeriod = startCurrentBillingPeriod + relativedelta(months=1) - relativedelta(days=1)
    
    billingPeriodData = {
        'date_start': startCurrentBillingPeriod,
        'date_end': endCurrentBillingPeriod,
    }

    billingPeriodData.update(getTrunkCDR(provider.id, startCurrentBillingPeriod, endCurrentBillingPeriod))
    billingPeriodData.update(getProviderBundleCost(provider, startCurrentBillingPeriod, endCurrentBillingPeriod))

    if billingPeriodData['total_call_cost'] is None:
        billingPeriodData['total_call_cost'] = 0
    if billingPeriodData['total_seconds'] is None:
        billingPeriodData['total_seconds'] = 0
    if billingPeriodData['total_calls'] is None:
        billingPeriodData['total_calls'] = 0

    billingPeriodData.update({'monthly_cost': provider.monthly_cost})
    billingPeriodData.update({'total_cost': billingPeriodData['total_call_cost'] + billingPeriodData['total_bundle_cost'] + billingPeriodData['monthly_cost']})

    billingPeriods = []
    billingPeriods.append(billingPeriodData)
    months = 5
    while True:
        if months == 0:
            break
        endCurrentBillingPeriod = startCurrentBillingPeriod - relativedelta(days=1)
        startCurrentBillingPeriod = startCurrentBillingPeriod - relativedelta(months=1)

        billingPeriodData = {
            'date_start': startCurrentBillingPeriod,
            'date_end': endCurrentBillingPeriod
        }
        billingPeriodData.update(getTrunkCDR(provider.id, startCurrentBillingPeriod, endCurrentBillingPeriod))
        billingPeriodData.update(getProviderBundleCost(provider, startCurrentBillingPeriod, endCurrentBillingPeriod))
        # Adding bundle costs to each month
        if billingPeriodData['total_call_cost'] is None:
            billingPeriodData['total_call_cost'] = 0
        if billingPeriodData['total_seconds'] is None:
            billingPeriodData['total_seconds'] = 0
        if billingPeriodData['total_calls'] is None:
            billingPeriodData['total_calls'] = 0

        billingPeriodData.update({'monthly_cost': provider.monthly_cost})
        billingPeriodData.update({'total_cost': billingPeriodData['total_call_cost'] + billingPeriodData['total_bundle_cost'] + billingPeriodData['monthly_cost']})
        
        billingPeriods.append(billingPeriodData)
        months -= 1
    return billingPeriods

def getTrunkCalls(provider_id, start_date, end_date):
    cursor = connection.cursor()
    sql = "SELECT tarifica_call.date, \
        tarifica_call.dialed_number, \
        tarifica_call.duration, \
        tarifica_call.cost, \
        tarifica_call.extension_number, \
        tarifica_destinationname.name as destination_name, \
        tarifica_provider.name as provider_name \
        FROM tarifica_call \
        LEFT JOIN tarifica_destinationgroup \
        ON tarifica_call.destination_group_id = tarifica_destinationgroup.id \
        LEFT JOIN tarifica_destinationname \
        ON tarifica_destinationgroup.destination_name_id = tarifica_destinationname.id \
        LEFT JOIN tarifica_provider \
        ON tarifica_call.provider_id = tarifica_provider.id \
        WHERE tarifica_call.provider_id = %s \
        AND date > %s AND date < %s ORDER BY date"
    cursor.execute(sql, (provider_id, start_date+" 23:59:59", end_date+" 00:00:00"))
    return dictfetchall(cursor)

def getProviderBundleCost(provider, start_date, end_date):
    bundle_costs = 0
    destinations = DestinationGroup.objects.filter(provider = provider)
    for d in destinations:
        bundles = Bundle.objects.filter(destination_group = d)
        for bundle in bundles:
            if ( bundle.start_date <= start_date or 
                (bundle.start_date >= start_date and bundle.start_date <= end_date) and
                bundle.end_date >= end_date):
                #Aplica a este periodo
                bundle_costs += bundle.cost
            else:
                print "Bundle", bundle.name, "not in range."
    return {'total_bundle_cost': bundle_costs}

@login_required(login_url='tarifica:login')
def downloadTrunkCDR(request, provider_id, start_date, end_date):
    file_path = '/tmp/'
    file_name = 'trunk_cdr.csv'

    provider = get_object_or_404(Provider, id = provider_id)
    timedelta = datetime.timedelta(days = 1)
    try:
        start_date = start_date
        end_date = end_date
    except Exception as e:
        print "Error while parsing dates:",e
        return HttpResponseServerError('Error while saving .csv')

    call_info = getTrunkCalls(provider_id, start_date, end_date)
    header = {
        'date': 'Date',
        'dialed_number': 'Dialed Number',
        'extension_number': 'Extension Number',
        'duration': 'Minutes',
        'cost': 'Cost',
        'destination_name': 'Destination',
        'provider_name': 'Provider'
    }
    field_names = [
        'date',
        'dialed_number',
        'extension_number',
        'duration',
        'cost',
        'destination_name',
        'provider_name'
    ]
    try:
        f = open(file_path + file_name, 'w+')
        writer = DictWriter(f, fieldnames = field_names)
        writer.writerow(header)
        writer.writerows(call_info)
        f.seek(0)
    except Exception as e:
        print "Error while writing file:",e
        return HttpResponseServerError('Error while saving .csv:')

    response = HttpResponse(f.read(), content_type='application/csv')
    response['Content-Disposition'] = 'attachment; filename="'+file_name+'"'
    f.close()
    return response

def dictfetchall(cursor):
    desc = cursor.description
    return [
        dict(zip([col[0] for col in desc], row))
        for row in cursor.fetchall()
    ]

def syncAsteriskInformation():
    a_mysql_m = AsteriskMySQLManager()
    users = a_mysql_m.getUserInformation()
    for u in users:
        if u['extension']:
            if u['name'] == "": u['name'] = u['extension']
            try:
                e = Extension.objects.get(extension_number = u['extension'])
                e.name = u['name']
                e.save()
            except Extension.DoesNotExist:
                e = Extension(
                    name = u['name'],
                    extension_number = u['extension'],
                    )
                e.save()
            except Extension.MultipleObjectsReturned:
                print "extensiones repetidas!"
    pinsets = a_mysql_m.getPinsetInformation()
    # Revisamos que haya pinsets configurados
    if len(pinsets) > 0:
        for u in pinsets:
            try:
                e = Pinset.objects.get(pinset_number = u)
            except Pinset.DoesNotExist:
                e = Pinset(pinset_number = u)
                e.save()
            except Pinset.MultipleObjectsReturned:
                print "pinsets repetidos!"
    trunks = a_mysql_m.getTrunkInformation()
    for x in trunks:
        if x['trunkid']:
            if x['name'] == "": x['name'] = x['channelid']
            try:
                e = Provider.objects.get(asterisk_id = x['trunkid'])
                e.asterisk_name = x['name']
                e.provider_tech = x['tech']
                e.asterisk_channel_id = x['channelid'],
                e.name = x['name']
            except Provider.DoesNotExist:
                if x['name'] == '': x['name'] = 'Unnamed Trunk' #AQUI ESTA LO QUE SE LE AGREGA A LOS QUE NO TIENEN NOMBREE!!!!!!!!!!!
                p = Provider(
                    asterisk_id = x['trunkid'],
                    asterisk_name = x['name'],
                    name = x['name'],
                    provider_tech = x['tech'],
                    asterisk_channel_id = x['channelid'],
                    is_configured = False
                    )
                p.save()
            except Provider.MultipleObjectsReturned:
                print "troncales repetidas!"

    print "Information synced with asterisk database."