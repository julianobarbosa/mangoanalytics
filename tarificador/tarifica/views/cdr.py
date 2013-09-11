from __future__ import division
import datetime
from django.utils.timezone import utc
from django.shortcuts import render, get_object_or_404, redirect
from django.http import HttpResponseRedirect, HttpResponse, HttpResponseServerError
from tarifica.tools.asteriskMySQLManager import AsteriskMySQLManager
from tarifica.models import *
from tarifica import forms
from django.core.serializers.json import DjangoJSONEncoder
from csv import *
from math import ceil
from django.db.models import Sum
from tarifica.tools.referrer_check import referer_matches_re

@referer_matches_re('(index\.php\?menu=){1,1}')
def general(request, page=1):
    user_info = get_object_or_404(UserInformation, id = 1)
    action = "show"
    calls = []
    limit = 100
    page = int(page) - 1    
    # Query:
    exclude_kwargs = {}
    filter_kwargs = {}

    if request.method == 'POST': # If the form has been submitted...
        form = forms.filterCDR(request.POST) # A form bound to the POST data
        if form.is_valid(): # All validation rules pass
            #Delete all existing filters 
            print 'Previous filters'
            print CDRFilter.objects.all()
            CDRFilter.objects.all().delete()
            print 'After deleting filters'
            print CDRFilter.objects.all()
            for possible_filter in form.cleaned_data:
                #If its the indicator of wether to show or download, ignore:
                if possible_filter == 'action':
                    action = form.cleaned_data[possible_filter]
                    continue
                #Checking if its a comparator
                if possible_filter.count('comparison') == 0:

                    field_name_val = possible_filter
                    extras_val = ''
                    if possible_filter == 'start_date' or possible_filter == 'end_date':
                        field_name_val = 'date'
                        if possible_filter == 'start_date':
                            extras_val = 'start'
                        if possible_filter == 'end_date':
                            extras_val = 'end'
                    if possible_filter == 'provider':
                        #Check that we don't try to filter by id 0 (not selected)
                        if form.cleaned_data[possible_filter] == '0':
                            print "Provider not selected"
                            continue
                        field_name_val = 'provider_id'
                    if possible_filter == 'destination_group':
                        field_name_val = 'destination_group__destination_name__name'

                    real_filter = CDRFilter()
                    real_filter.comparison = form.cleaned_data[possible_filter+'_comparison']
                    real_filter.field_name = field_name_val
                    real_filter.value = form.cleaned_data[possible_filter]

                    #Check start and end dates:
                    if possible_filter == 'start_date' or possible_filter == 'end_date':
                        if form.cleaned_data[possible_filter] is not None:
                            real_filter.value = form.cleaned_data[possible_filter].strftime("%Y-%m-%d")
                            if possible_filter == 'start_date':
                                real_filter.extras = 'start'
                            if possible_filter == 'end_date':
                                real_filter.extras = 'end'
                                        
                    #Check that we only save as filters the fields that have a valid value
                    if real_filter.value == '':
                        continue
                    if real_filter.value is None:
                        continue 

                    print "Field:", real_filter.field_name
                    print "Comparison:", real_filter.comparison
                    print "Value:", real_filter.value
                    real_filter.save()
                    print "Saved new filter"
        else:
            print "Not valid!"
            print form.errors
    else:
        start_date_value = ''
        start_date_comparison_value = ''
        end_date_value = ''
        end_date_comparison_value = ''
        dialed_number_value = ''
        dialed_number_comparison_value = ''
        extension_number_value = ''
        extension_number_comparison_value = ''
        pinset_number_value = ''
        pinset_number_comparison_value = ''
        duration_value = ''
        duration_comparison_value = ''
        cost_value = ''
        cost_comparison_value = ''
        destination_group_value = ''
        destination_group_comparison_value = ''
        provider_value = ''
        provider_comparison_value = ''

        for f in CDRFilter.objects.all():
            if f.field_name == 'date' and f.extras == 'start':
                start_date_value = datetime.datetime.strptime(f.value, "%Y-%m-%d")
                start_date_comparison_value = f.comparison
            if f.field_name == 'date' and f.extras == 'end':
                end_date_value = datetime.datetime.strptime(f.value, "%Y-%m-%d")
                end_date_comparison_value = f.comparison
            if f.field_name == 'dialed_number':
                dialed_number_value = f.value 
                dialed_number_comparison_value = f.comparison
            if f.field_name == 'extension_number':
                extension_number_value = f.value 
                extension_number_comparison_value = f.comparison
            if f.field_name == 'pinset_number':
                pinset_number_value = f.value
                pinset_number_comparison_value = f.comparison
            if f.field_name == 'duration':
                duration_value = f.value 
                duration_comparison_value = f.comparison
            if f.field_name == 'cost':
                cost_value = f.value 
                cost_comparison_value = f.comparison
            if f.field_name == 'destination_group__destination_name__name':
                destination_group_value = f.value 
                destination_group_comparison_value = f.comparison
            if f.field_name == 'provider__name':
                provider_value = f.value 
                provider_comparison_value = f.comparison

        form = forms.filterCDR(initial={
            'action': 'show',
            'start_date': start_date_value,
            'start_date_comparison': start_date_comparison_value,
            'end_date': end_date_value,
            'end_date_comparison': end_date_comparison_value,
            'dialed_number': dialed_number_value,
            'dialed_number_comparison': dialed_number_comparison_value,
            'extension_number': extension_number_value,
            'extension_number_comparison': extension_number_comparison_value,
            'pinset_number': pinset_number_value,
            'pinset_number_comparison': pinset_number_comparison_value,
            'duration': duration_value,
            'duration_comparison': duration_comparison_value,
            'cost': cost_value,
            'cost_comparison': cost_comparison_value,
            'destination_group': destination_group_value,
            'destination_group_comparison': destination_group_comparison_value,
            'provider': provider_value,
            'provider_comparison': provider_comparison_value,
        }) # An unbound form

    #Gettings saved filters
    filters = CDRFilter.objects.all()
    for f in filters:
        if f.comparison == 'exclude':
            exclude_kwargs.update(
                {'{0}__{1}'.format(f.field_name, 'exact'): f.value}
            )
        else:
            filter_kwargs.update(
                {'{0}__{1}'.format(f.field_name, f.comparison): f.value}
            )

    if action == "download":
        calls = Call.objects.filter(**filter_kwargs).exclude(**exclude_kwargs)
        call_info = calls.values()
        for call in call_info:
            call['provider_id'] = Provider.objects.get(id=call['provider_id']).name
            call['destination_group_id'] = DestinationGroup.objects.get(id=call['destination_group_id']).destination_name.name

        file_path = '/tmp/'
        file_name = 'custom_cdr.csv'

        header = {
            'date': 'Date',
            'dialed_number': 'Dialed Number',
            'extension_number': 'Extension Number',
            'pinset_number': 'Pinset Number',
            'provider_id': 'Provider',
            'destination_group_id': 'Destination',
            'duration': 'Minutes',
            'cost': 'Cost',
        }
        field_names = [
            'date',
            'dialed_number',
            'extension_number',
            'pinset_number',
            'provider_id',
            'destination_group_id',
            'duration',
            'cost',
        ]
        try:
            f = open(file_path + file_name, 'w+')
            writer = DictWriter(f, fieldnames = field_names, extrasaction='ignore')
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
    else:
        items = Call.objects.filter(**filter_kwargs).exclude(**exclude_kwargs).count()
        calls = Call.objects.filter(**filter_kwargs).exclude(**exclude_kwargs)[page*limit:page*limit + limit]
        total_seconds = Call.objects.filter(**filter_kwargs).exclude(**exclude_kwargs).aggregate(Sum('duration'))
        total_cost = Call.objects.filter(**filter_kwargs).exclude(**exclude_kwargs).aggregate(Sum('cost'))

    pages_number = int(ceil(items/limit))
    previousPage = page - 1
    if previousPage < 1:
        previousPage = 1

    nextPage = page + 1
    if nextPage > pages_number:
        nextPage = pages_number

    if total_seconds['duration__sum'] is None:
        total_seconds['duration__sum'] = 0

    if total_cost['cost__sum'] is None:
        total_cost['cost__sum'] = 0

    return render(request, 'tarifica/general/cdr.html', {
        'user_info' : user_info,
        'calls' : calls,
        'form': form,
        'items': items,
        'page': page + 1,
        'pages': range(1, pages_number+1)[:10],
        'limit': limit,
        'previousPage': previousPage,
        'nextPage': nextPage,
        'pages_number': pages_number,
        'total_minutes': total_seconds['duration__sum'] / 60,
        'total_cost': total_cost['cost__sum'],
    })

def dictfetchall(cursor):
    desc = cursor.description
    return [
        dict(zip([col[0] for col in desc], row))
        for row in cursor.fetchall()
    ]