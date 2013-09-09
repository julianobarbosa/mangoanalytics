#Views for bundles

from django.utils.timezone import utc
import datetime
from django.shortcuts import render, get_object_or_404
from django.http import HttpResponseRedirect, HttpResponse
from tarifica import forms
from tarifica.tools.asteriskMySQLManager import AsteriskMySQLManager
from tarifica.models import *
from dateutil.relativedelta import *

def createBundle(request, destination_group_id):
    user_info = get_object_or_404(UserInformation, id = 1)
    destination_group = get_object_or_404(DestinationGroup, id=destination_group_id)
    provider = destination_group.provider
    start_date = datetime.datetime.now()
    start_date = datetime.datetime(year=start_date.year, month=start_date.month, day=provider.period_end)
    end_date = start_date + relativedelta(years=2)
    if request.method == 'POST': # If the form has been submitted...
        form = forms.createBundle(request.POST) # A form bound to the POST data
        if form.is_valid(): # All validation rules pass
            name = form.cleaned_data['name']
            tariff_mode = TariffMode.objects.get(id=form.cleaned_data['tariff_mode'])
            cost = form.cleaned_data['cost']
            amount = form.cleaned_data['amount']
            start_date = form.cleaned_data['start_date']
            end_date = form.cleaned_data['end_date']
            priority = form.cleaned_data['priority']
            destination_group.has_bundles=True
            destination_group.save()
            b = Bundle(
                priority = priority,
                name=name,
                destination_group=destination_group,
                tariff_mode=tariff_mode,
                cost=cost,
                amount=amount,
                start_date=start_date,
                end_date=end_date
                )
            b.save()
            return HttpResponseRedirect('/setup') # Redirect after POST
    else:
        form = forms.createBundle(initial={
            'start_date': start_date,
            'end_date': end_date
        }) # An unbound form

    return render(request, 'tarifica/bundles/bundleCreate.html', {
        'start_date': start_date,
        'end_date': end_date,
        'form': form,
        'destination_group': destination_group,
        'user_info': user_info
    })

def updateBundle(request, bundle_id):
    user_info = get_object_or_404(UserInformation, id = 1)
    b = get_object_or_404(Bundle, id = bundle_id)
    if request.method == 'POST': # If the form has been submitted...
        form = forms.updateBundle(request.POST) # A form bound to the POST data
        if form.is_valid(): # All validation rules pass
            b.name = form.cleaned_data['name']
            b.tariff_mode = TariffMode.objects.get(id=form.cleaned_data['tariff_mode'])
            b.cost = form.cleaned_data['cost']
            b.amount = form.cleaned_data['amount']
            b.priority = form.cleaned_data['priority']
            b.save()
            return HttpResponseRedirect('/setup') # Redirect after POST
    else:
        form = forms.updateBundle(initial=
        {'name': b.name,
         'destination_group': b.destination_group,
         'tariff_mode': b.tariff_mode,
         'cost': b.cost,
         'amount': b.amount,
         'priority': b.priority,
        }) # An unbound form

    return render(request, 'tarifica/bundles/bundleUpdate.html', {
        'form': form,
        'bundle' : b,
        'user_info': user_info
    })

def deleteBundle(request, bundle_id):
    bundle = get_object_or_404(Bundle, id = bundle_id)
    bundle.delete()
    return HttpResponseRedirect('/setup')