#Views for providers

import datetime
from django.utils.timezone import utc
from django.shortcuts import render, get_object_or_404
from django.http import HttpResponseRedirect, HttpResponse
from tarifica import forms
from tarifica.tools.asteriskMySQLManager import AsteriskMySQLManager
from tarifica.models import *

def createDestinationGroup(request, provider_id):
    provider = get_object_or_404(Provider, id = provider_id)
    if request.method == 'POST': # If the form has been submitted...
        form = forms.createDestinationGroup(request.POST) # A form bound to the POST data
        if form.is_valid(): # All validation rules pass
            name = DestinationName.objects.get(id=form.cleaned_data['destination_name'])
            country = DestinationCountry.objects.get(id=form.cleaned_data['destination_country'])
            prefix = form.cleaned_data['prefix']
            matching_number = form.cleaned_data['matching_number']
            tariff_mode = TariffMode.objects.get(id=form.cleaned_data['tariff_mode'])
            cost = form.cleaned_data['cost']
            d = DestinationGroup(
            	provider=provider, 
            	destination_name=name, 
            	destination_country=country, 
            	prefix=prefix, 
            	matching_number=matching_number, 
            	cost=cost,
            	tariff_mode=tariff_mode
            )
            d.save()
            return HttpResponseRedirect('/tarifica/setup') # Redirect after POST
    else:
        form = forms.createDestinationGroup() # An unbound form

    return render(request, 'tarifica/destinationGroupCreate.html', {
        'form': form,
        'provider' : provider,
    })

def updateDestinationGroup(request, destination_group_id):
    pass

def getDestinationGroup(request, provider_id):
    pass

def deleteDestinationGroup(request, destination_group_id):
    destination_group = get_object_or_404(DestinationGroup, id = destination_group_id)
    destination_group.delete()
    return HttpResponseRedirect('/tarifica/setup')