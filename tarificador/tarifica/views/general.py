#General views

import datetime
from django.utils.timezone import utc
from django.template import RequestContext, loader
from django.shortcuts import render, get_object_or_404, redirect
from django.http import HttpResponseRedirect, HttpResponse
from tarifica.tools.asteriskMySQLManager import AsteriskMySQLManager
from tarifica.models import *
from tarifica import forms
from django.db import connection, transaction
from tarifica.django_countries.fields import Country
import json
from tarifica.views.trunks import getBillingPeriods, dictfetchall
from dateutil.relativedelta import *
from tarifica.tools.elastix_session import elastix_user_is_authorized

@elastix_user_is_authorized()
def setup(request, provider_id = 0):
    import urlparse
    referer = request.META.get('HTTP_REFERER', None)
    print "referer",referer
    referer_netloc = urlparse.urlparse(referer).netloc
    print "referer_netlock",referer_netloc
    user_info = get_object_or_404(UserInformation, id = 1)
    #Import users, trunks and pinsets at first use...
    a_mysql_m = AsteriskMySQLManager()
    users = a_mysql_m.getUserInformation()
    for u in users:
        if u['extension']:
            try:
                e = Extension.objects.get(extension_number = u['extension'])
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
        print x
        if x['trunkid']:
            try:
                e = Provider.objects.get(asterisk_id = x['trunkid'])
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

    if user_info.first_time_user:
        return HttpResponseRedirect('/wizard/start') # Redirect after POST

    providers_not_configured = Provider.objects.filter(is_configured=False).order_by('asterisk_name')
    providers_configured = Provider.objects.filter(is_configured=True).order_by('name')
    bundles = Bundle.objects.all().order_by('name')
    locales = DestinationGroup.objects.all()
    return render(request, 'tarifica/general/setup.html', {
        'not_configured' : providers_not_configured,
        'configured' : providers_configured,
        'bundles' : bundles,
        'locales' : locales,
        'user_info' : user_info,
    })

@elastix_user_is_authorized()
def realtime(request, action="show"):
    import subprocess, re
    user_info = get_object_or_404(UserInformation, id = 1)
    today = datetime.datetime.today()

    try:
        process = subprocess.check_output(["asterisk","-rx core show channels verbose"])
        lines = process.split('\n')[0:-4]
    except Exception as e:
        lines = []
        "There was a problem getting asterisk call information..."

    #There's trouble here... the thing is, these columns may contain space-separated words.
    #So, we need to know the extension of the column (Name+whitespace)
    #And check, before splitting by spaces, if we should do so, based on if the spaces that 
    #would be separated plus the column contents equal de column width.

    #We know the column names don't have spaces in them:
    if len(lines) > 0:
        rege = re.compile("(\w+ +)")
        columns = []
        end_pos = len(lines[0])
        start_pos = 0
        i = 0
        #Saving each column and its length:
        while True:
            col = rege.search(lines[0], start_pos, end_pos)
            if not col: 
                break
            start_pos = col.end()
            columns.append({
                'name': col.group(0).strip(' '), 
                'length': len(col.group(0)), 
            })
            i += 1

        i = 0
        data_row_columns = []

        #Starting with the data columns only
        for line in lines[1:]:
            data_row = {}
            #Now, having how long are the columns, we can slice each line by each column width
            #And after stripping it of ending newlines, we have our data!
            start = 0
            end = 0
            for c in columns:
                end = end + c['length']
                data_row.update({
                    c['name']: line[start:end].strip(' ')
                })
                start += c['length']
            data_row_columns.append(data_row)
    else:
        data_row_columns = []

    graphData = []
    data = []
    for d in data_row_columns:
        print d
        #We first check if it is an outgoing call:
        if d['Application'] == 'Dial':
            configured_extensions = Extension.objects.all()
            extension_list = [ e.extension_number for e in configured_extensions ]
            #if d['CallerID'] in extension_list:
                #This call went out from an extension and is outgoing...
                #Now, we get the dialed number...
            try:
                call_data = d['Data'].split('/')
                print call_data
            except Exception as e:
                print "Could not parse call data, so it must not be a call",e
                continue

            try:
                provider = Provider.objects.get(asterisk_name = call_data[1])
            except Exception as e: 
                "Could not find provider with name",call_data[1]
                continue

            d.update( { 'provider': provider } )
            d.update( { 'dialed_number': call_data[2].split(',')[0] })
            if d['dialed_number'] not in extension_list:
                #Now we're sure its an outgoing call...
                #Calculating start time
                try:
                    t1 = datetime.datetime.strptime(d['Duration'], "%H:%M:%S")
                    #print t1
                    timedelta = datetime.timedelta(hours=t1.hour, minutes=t1.minute, seconds=t1.second)
                    t = today - timedelta
                    #print t
                    d.update( { 'call_start': t.time().strftime("%H:%M:%S") } )
                except Exception as e:
                    print "Error while calculating start time",e
                    continue
                #Obtaining destination group
                destination_groups = DestinationGroup.objects.filter(provider = provider).order_by('-prefix')
                #print destination_groups
                destination_group_name = 'Unknown'
                destination_country_name = 'Unknown'
                destination_country_flag = ''
                for dest in destination_groups:
                    try:
                        pos = d['dialed_number'].index(dest.prefix)
                    except ValueError,e :
                        pos = None
                    if pos == 0:
                        destination_group_name = dest.destination_name.name
                        destination_country_name = dest.destination_country.name
                        destination_country_flag = dest.destination_country.flag
                        break
                    else:
                        continue

                d.update( { 'destination_group_name': destination_group_name })
                d.update( { 'destination_country_name': destination_country_name })
                d.update( { 'destination_country_flag': destination_country_flag })

                accountedFor = False
                for g in graphData:
                    if g[0] == d['destination_group_name']:
                        accountedFor = True
                        g[1] += 1
                if not accountedFor:
                    graphData.append([d['destination_group_name'], 1])
                #If all went well, we add this call to the list
                data.append(d)
            else:
                print "Called number in extension list, hence its not an outgoing call."
            #else:
                #print "Caller not in extension list, so it cannot be an outgoing call."
        else:
            print "Not a dial application."

    if action == "update":
        template = loader.get_template('tarifica/general/updateRealtime.html')
        htmlData = template.render(RequestContext(request, {
            'user_info' : user_info,
            'data' : data,
        }))
        return HttpResponse(json.dumps({
            'htmlData': htmlData,
            'graphData' : json.dumps(graphData),
        }))

    return render(request, 'tarifica/general/realtime.html', {
        'user_info' : user_info,
        'data' : data,
        'graphData' : json.dumps(graphData),
    })


def dashboard(request):
    user_info = get_object_or_404(UserInformation, id = 1)
    today = datetime.datetime.now()
    timedelta = datetime.timedelta(days=1)
    start_date = (datetime.datetime(year=today.year, month=today.month, day=1) - timedelta)
    end_date = (datetime.datetime(year=today.year, month=today.month, day=today.day) + timedelta)
    cursor = connection.cursor()
    provider_daily_costs = []
    total_cost = 0
    providers = Provider.objects.filter(is_configured=True)
    billing_periods_graph = []
    monthly_graph = []
    monthly_graph_ticks = []
    ticks = []
    ticksAssigned = False
    for prov in providers:
        detail = ProviderDailyDetail.objects.filter(date__range=(start_date,end_date)).filter(provider = prov)
        provider_total_cost = 0
        for e in detail:
            provider_total_cost = e.cost + provider_total_cost
        provider_daily_costs.append((prov,provider_total_cost))
        total_cost += provider_total_cost

        provider_data = getBillingPeriods(prov)
        cost_data = []
        for p in provider_data:
            cost_data.append(p['total_cost'])

            if not ticksAssigned:
                ticks.append(p['date_start'].strftime('%b')+" - "+p['date_end'].strftime('%b'))
            
        ticksAssigned = True

        billing_periods_graph.append({
            'provider': prov.name, 
            'cost': cost_data
        })

        #Monthly graph
        monthly_graph.append({'name': prov.name, 'data': [], 'monthly_cost': prov.monthly_cost })

    sql = "SELECT tarifica_providerdailydetail.id, \
        SUM(tarifica_providerdailydetail.cost) AS cost, \
        tarifica_provider.name AS name \
        FROM tarifica_providerdailydetail \
        LEFT JOIN tarifica_provider \
        ON tarifica_providerdailydetail.provider_id = tarifica_provider.id \
        WHERE date >= %s AND date <= %s \
        GROUP BY tarifica_providerdailydetail.provider_id"

    start_date = datetime.datetime(year=today.year, month=today.month, day=1)
    #End of the month
    end_date = start_date + relativedelta(months=1) - datetime.timedelta(days=1)
    
    for x in xrange(0,6):
        monthly_graph_ticks.append(start_date.strftime("%b"))
        cursor.execute(sql, (start_date, end_date))
        monthly_call_data = dictfetchall(cursor)

        for prov in monthly_graph:
            cost = prov['monthly_cost']
            if monthly_call_data == []:
                prov['data'].append(cost)
            else:
                for m_data in monthly_call_data:
                    if m_data['name'] == prov['name']:
                        prov['data'].append(m_data['cost'] + cost)

        end_date = start_date - datetime.timedelta(days=1)
        start_date -= relativedelta(months=1)

    last_7_days = today - datetime.timedelta(days=7)
    sql = "SELECT tarifica_providerdestinationdetail.id, \
        SUM(tarifica_providerdestinationdetail.cost) AS cost, \
        tarifica_destinationname.name as destination_name, \
        tarifica_destinationgroup.destination_country as country_name \
        FROM tarifica_providerdestinationdetail \
        LEFT JOIN tarifica_destinationgroup \
        ON tarifica_providerdestinationdetail.destination_group_id = tarifica_destinationgroup.id \
        LEFT JOIN tarifica_destinationname \
        ON tarifica_destinationname.id = tarifica_destinationgroup.destination_name_id \
        WHERE date > %s AND date < %s \
        GROUP BY tarifica_destinationname.name \
        ORDER BY SUM(tarifica_providerdestinationdetail.cost) DESC"
    cursor.execute(sql, (last_7_days, today))
    locales = dictfetchall(cursor)[:5]
    sql = 'SELECT tarifica_userdailydetail.id, \
        SUM(tarifica_userdailydetail.cost) AS cost, \
        tarifica_extension.name, \
        tarifica_extension.extension_number \
        FROM tarifica_userdailydetail \
        LEFT JOIN tarifica_extension \
        ON tarifica_userdailydetail.extension_id = tarifica_extension.id \
        WHERE date > %s AND date < %s \
        GROUP BY tarifica_userdailydetail.extension_id ORDER BY SUM(cost) DESC'
    cursor.execute(sql, (last_7_days, today))
    extensions = dictfetchall(cursor)[:5]

    for locale in locales:
        locale['country'] = Country(code=locale['country_name'])

    #Information for graph
    return render(request, 'tarifica/general/dashboard.html', {
        'user_info' : user_info,
        'total_cost' : total_cost,
        'provider_daily_costs' : provider_daily_costs,
        'locales' : locales,
        'extensions' : extensions,
        'billing_periods_graph': json.dumps(billing_periods_graph),
        'monthly_graph': json.dumps(monthly_graph),
        'monthly_graph_ticks': json.dumps(monthly_graph_ticks),
        'ticks': json.dumps(ticks),
    })

@elastix_user_is_authorized()
def privacy(request):
    return render(request, 'tarifica/general/privacy.html', {})

@elastix_user_is_authorized()
def manual(request):
    return render(request, 'tarifica/general/manual.html', {})



def dictfetchall(cursor):
    desc = cursor.description
    return [
        dict(zip([col[0] for col in desc], row))
        for row in cursor.fetchall()
    ]