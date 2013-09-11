#Views for providers

import datetime
from django.utils.timezone import utc
from django.shortcuts import render, get_object_or_404
from django.http import HttpResponseRedirect, HttpResponse
from tarifica import forms
from tarifica.tools.asteriskMySQLManager import AsteriskMySQLManager
from tarifica.models import *
from django.forms.formsets import formset_factory
from tarifica.tools.referrer_check import referer_matches_re

@referer_matches_re('(index\.php\?menu=){1,1}')
def createProvider(request, asterisk_id):
    provider = get_object_or_404(Provider, asterisk_id = asterisk_id)

    if request.method == 'POST': # If the form has been submitted...
        form = forms.createProvider(request.POST) # A form bound to the POST data
        if form.is_valid(): # All validation rules pass
            provider.name = form.cleaned_data['name']
            provider.monthly_cost = form.cleaned_data['monthly_cost']
            provider.period_end = form.cleaned_data['period_end']
            provider.payment_type = PaymentType.objects.get(id=form.cleaned_data['payment_type'])
            provider.channels = form.cleaned_data['channels']
            provider.is_configured = True
            provider.save()
            return HttpResponseRedirect('/setup') # Redirect after POST
    else:
        form = forms.createProvider() # An unbound form

    return render(request, 'tarifica/providers/providerCreate.html', {
        'form': form,
        'provider': provider
    })

@referer_matches_re('(index\.php\?menu=){1,1}')
def getProvider(request, provider_id):
    user_info = get_object_or_404(UserInformation, id = 1)
    provider = get_object_or_404(Provider, id = provider_id)
    destination_groups = DestinationGroup.objects.filter(provider = provider)
    bundles = Bundle.objects.filter(destination_group__in = destination_groups)
    return render(request, 'tarifica/providers/providerGet.html', {
        'user_info': user_info,
        'provider': provider,
        'destination_groups': destination_groups,
        'bundles': bundles,
    })

@referer_matches_re('(index\.php\?menu=){1,1}')
def updateProvider(request, provider_id):
    provider = get_object_or_404(Provider, id = provider_id)

    if request.method == 'POST': # If the form has been submitted...
        form = forms.createProvider(request.POST) # A form bound to the POST data
        if form.is_valid(): # All validation rules pass
            provider.name = form.cleaned_data['name']
            provider.monthly_cost = form.cleaned_data['monthly_cost']
            provider.period_end = form.cleaned_data['period_end']
            provider.payment_type = PaymentType.objects.get(id=form.cleaned_data['payment_type'])
            provider.channels = form.cleaned_data['channels']
            provider.is_configured = True
            provider.save()
            return HttpResponseRedirect('/setup') # Redirect after POST
    else:
        form = forms.createProvider(initial=
        {'name': provider.name,
         'monthly_cost': provider.monthly_cost,
         'period_end': provider.period_end,
         'payment_type': provider.payment_type,
         'channels': provider.channels,
        }
        )# An unbound form

    return render(request, 'tarifica/providers/providerUpdate.html', {
        'form': form,
        'provider': provider
    })

@referer_matches_re('(index\.php\?menu=){1,1}')
def deleteProvider(request, provider_id):
    provider = get_object_or_404(Provider, id = provider_id)
    provider.delete()
    return HttpResponseRedirect('/setup')