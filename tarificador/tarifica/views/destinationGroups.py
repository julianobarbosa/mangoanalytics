#Views for providers

import datetime
from django.utils.timezone import utc
from django.shortcuts import render, get_object_or_404, get_list_or_404
from django.http import HttpResponseRedirect, HttpResponse
from tarifica import forms
from tarifica.tools.asteriskMySQLManager import AsteriskMySQLManager
from tarifica.models import *

def createDestinationGroup(request, provider_id):
    provider = get_object_or_404(Provider, id = provider_id)
    destinations = DestinationGroup.objects.filter(provider_id = provider_id)
    if request.method == 'POST': # If the form has been submitted...
        form = forms.createDestinationGroup(request.POST) # A form bound to the POST data
        if form.is_valid(): # All validation rules pass
            name = DestinationName.objects.get(id=form.cleaned_data['destination_name'])
            country = form.cleaned_data['destination_country']
            prefix = form.cleaned_data['prefix']
            tariff_mode = TariffMode.objects.get(id=form.cleaned_data['tariff_mode'])
            cost = form.cleaned_data['cost']
            d = DestinationGroup(
            	provider=provider, 
            	destination_name=name, 
            	destination_country=country, 
            	prefix=prefix, 
            	cost=cost,
            	tariff_mode=tariff_mode
            )
            d.save()
            return HttpResponseRedirect('/destinations/create/'+provider_id) # Redirect after POST
    else:
        form = forms.createDestinationGroup() # An unbound form

    return render(request, 'tarifica/destinationGroupCreate.html', {
        'form': form,
        'provider' : provider,
        'destinations' : destinations
    })

def updateDestinationGroup(request, destination_group_id):
    destination_group = get_object_or_404(DestinationGroup, id = destination_group_id)
    if request.method == 'POST': # If the form has been submitted...
        form = forms.createDestinationGroup(request.POST) # A form bound to the POST data
        if form.is_valid(): # All validation rules pass
            name = DestinationName.objects.get(id=form.cleaned_data['destination_name'])
            country = form.cleaned_data['destination_country']
            prefix = form.cleaned_data['prefix']
            tariff_mode = TariffMode.objects.get(id=form.cleaned_data['tariff_mode'])
            cost = form.cleaned_data['cost']
            d = DestinationGroup(
                provider=provider, 
                destination_name=name, 
                destination_country=country, 
                prefix=prefix, 
                cost=cost,
                tariff_mode=tariff_mode
            )
            d.save()
            return HttpResponseRedirect('/setup') # Redirect after POST
    else:
        form = forms.createDestinationGroup(initial=
        {'destination_name': destination_group.destination_name,
         'destination_country': destination_group.destination_country,
         'prefix': destination_group.prefix,
         'tariff_mode': destination_group.tariff_mode,
         'notes': destination_group.notes,
         'cost': destination_group.cost,
        })

    return render(request, 'tarifica/destinationGroupUpdate.html', {
        'form': form,
        'destination_group' : destination_group,
    })

def getDestinationGroup(request, provider_id):
    pass

def deleteDestinationGroup(request, destination_group_id):
    destination_group = get_object_or_404(DestinationGroup, id = destination_group_id)
    destination_group.delete()
    return HttpResponseRedirect('/setup')