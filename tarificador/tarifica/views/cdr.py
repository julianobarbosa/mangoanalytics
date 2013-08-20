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
            filters = []
            action = form.cleaned_data['action']
            start_date = form.cleaned_data['start_date']
            start_date_comparison = form.cleaned_data['start_date_comparison']
            if start_date is not None:
                start_date = start_date.strftime("%Y-%m-%d 00:00:00")
                filters.append({'field_name': 'date', 'comparison': start_date_comparison, 'value': start_date})
            end_date = form.cleaned_data['end_date']
            end_date_comparison = form.cleaned_data['end_date_comparison']
            if end_date is not None:
                end_date = end_date.strftime("%Y-%m-%d 00:00:00")
                filters.append({'field_name': 'date', 'comparison': end_date_comparison, 'value': end_date})
            dialed_number = form.cleaned_data['dialed_number']
            dialed_number_comparison = form.cleaned_data['dialed_number_comparison']
            if dialed_number != '':
                filters.append({'field_name': 'dialed_number', 'comparison': dialed_number_comparison, 'value': dialed_number})
            extension_number = form.cleaned_data['extension_number']
            extension_number_comparison = form.cleaned_data['extension_number_comparison']
            if extension_number != '':
                filters.append({'field_name': 'extension_number', 'comparison': extension_number_comparison, 'value': extension_number})
            pinset_number = form.cleaned_data['pinset_number']
            pinset_number_comparison = form.cleaned_data['pinset_number_comparison']
            if pinset_number != '':
                filters.append({'field_name': 'pinset_number', 'comparison': pinset_number_comparison, 'value': pinset_number})
            provider = form.cleaned_data['provider']
            field_name = 'provider__name'
            provider_comparison = form.cleaned_data['provider_comparison']
            if provider != '':
                filters.append({'field_name': field_name, 'comparison': provider_comparison, 'value': provider})
            destination_group = form.cleaned_data['destination_group']
            field_name = 'destination_group__destination_name__name'
            destination_group_comparison = form.cleaned_data['destination_group_comparison']
            if destination_group != '':
                filters.append({'field_name': field_name, 'comparison': destination_group_comparison, 'value': destination_group})
            duration = form.cleaned_data['duration']
            duration_comparison = form.cleaned_data['duration_comparison']
            if duration != '':
                filters.append({'field_name': 'duration', 'comparison': duration_comparison, 'value': duration})
            cost = form.cleaned_data['cost']
            cost_comparison = form.cleaned_data['cost_comparison']
            if cost != '':
                filters.append({'field_name': 'cost', 'comparison': cost_comparison, 'value': cost})

            for f in filters:
                if f['comparison'] == 'exclude':
                    exclude_kwargs.update(
                        {'{0}__{1}'.format(f['field_name'], 'exact'): f['value']}
                    )
                else:
                    filter_kwargs.update(
                        {'{0}__{1}'.format(f['field_name'], f['comparison']): f['value']}
                    )
    else:
        print "NOT POST"
        form = forms.filterCDR(initial={
            'action': 'show'
        }) # An unbound form

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
        calls = Call.objects.filter(**filter_kwargs).exclude(**exclude_kwargs)[page:limit]

    pages_number = int(ceil(items/limit))
    previousPage = page - 1
    if previousPage < 1:
        previousPage = 1

    nextPage = page + 1
    if nextPage > pages_number:
        nextPage = pages_number

    return render(request, 'tarifica/general/cdr.html', {
        'user_info' : user_info,
        'calls' : calls,
        'form': form,
        'items': items,
        'page': page + 1,
        'pages': range(1, pages_number+1),
        'limit': limit,
        'previousPage': previousPage,
        'nextPage': nextPage,
        'pages_number': pages_number
    })

def dictfetchall(cursor):
    desc = cursor.description
    return [
        dict(zip([col[0] for col in desc], row))
        for row in cursor.fetchall()
    ]