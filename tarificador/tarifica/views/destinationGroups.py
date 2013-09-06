#Views for providers

import datetime
from django.utils.timezone import utc
from django.shortcuts import render, get_object_or_404, get_list_or_404
from django.http import HttpResponseRedirect, HttpResponse
from tarifica import forms
from tarifica.tools.asteriskMySQLManager import AsteriskMySQLManager
from tarifica.models import *

def createDestinationGroup(request, provider_id):
    user_info = get_object_or_404(UserInformation, id = 1)
    provider = get_object_or_404(Provider, id = provider_id)
    destinations = DestinationGroup.objects.filter(provider_id = provider_id)
    if request.method == 'POST': # If the form has been submitted...
        form = forms.createDestinationGroup(request.POST) # A form bound to the POST data
        if form.is_valid(): # All validation rules pass
            d = DestinationGroup(
            	provider=provider, 
            	destination_name=DestinationName.objects.get(id=form.cleaned_data['destination_name']), 
            	destination_country=form.cleaned_data['destination_country'], 
                prefix=form.cleaned_data['prefix'], 
            	billing_interval=form.cleaned_data['billing_interval'], 
                minute_fee=form.cleaned_data['minute_fee'],
                connection_fee=form.cleaned_data['connection_fee'],
            	notes=form.cleaned_data['notes'],
            )
            d.save()
            return HttpResponseRedirect('/destinations/create/'+provider_id) # Redirect after POST
    else:
        form = forms.createDestinationGroup(initial=
        {
            'destination_country': user_info.country,
            'minute_fee': 0.00,
            'connection_fee': 0.00,
            'billing_interval': 60,
            'provider': provider.id,
        }) # An unbound form

    return render(request, 'tarifica/destinationGroups/destinationGroupCreate.html', {
        'form': form,
        'provider' : provider,
        'destinations' : destinations,
        'user_info': user_info
    })

def updateDestinationGroup(request, destination_group_id):
    user_info = get_object_or_404(UserInformation, id = 1)
    destination_group = get_object_or_404(DestinationGroup, id = destination_group_id)
    if request.method == 'POST': # If the form has been submitted...
        form = forms.createDestinationGroup(request.POST) # A form bound to the POST data
        if form.is_valid(): # All validation rules pass
            destination_group.destination_name = DestinationName.objects.get(id=form.cleaned_data['destination_name'])
            destination_group.destination_country = form.cleaned_data['destination_country']
            destination_group.prefix = form.cleaned_data['prefix']
            destination_group.minute_fee = form.cleaned_data['minute_fee']
            destination_group.connection_fee = form.cleaned_data['connection_fee']
            destination_group.billing_interval = form.cleaned_data['billing_interval']
            destination_group.notes = form.cleaned_data['notes']
            destination_group.save()
            return HttpResponseRedirect('/setup') # Redirect after POST
    else:
        form = forms.createDestinationGroup(initial={
            'destination_name': destination_group.destination_name,
            'destination_country': destination_group.destination_country,
            'prefix': destination_group.prefix,
            'notes': destination_group.notes,
            'minute_fee': destination_group.minute_fee,
            'connection_fee': destination_group.connection_fee,
            'billing_interval': destination_group.billing_interval,
            'provider': destination_group.provider.id,
        })

    return render(request, 'tarifica/destinationGroups/destinationGroupUpdate.html', {
        'form': form,
        'destination_group' : destination_group,
        'user_info': user_info
    })

def getDestinationGroup(request, provider_id):
    pass

def deleteDestinationGroup(request, destination_group_id):
    destination_group = get_object_or_404(DestinationGroup, id = destination_group_id)
    destination_group.delete()
    return HttpResponseRedirect('/setup')