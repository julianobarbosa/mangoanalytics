#General views

import datetime
from django.utils.timezone import utc
from django.shortcuts import render, get_object_or_404, redirect
from django.http import HttpResponseRedirect, HttpResponse
from tarifica.tools.asteriskMySQLManager import AsteriskMySQLManager
from tarifica.models import *
from tarifica import forms
from django.db import connection, transaction
import json

def initial(request):
    user_info = get_object_or_404(UserInformation, id = 1)
    if request.method == 'POST': # If the form has been submitted...
        form = forms.getUserInfo(request.POST)
        if form.is_valid(): # All validation rules pass
            user_info.country = form.cleaned_data['country']
            user_info.bussiness_name = form.cleaned_data['bussiness_name']
            user_info.contact_first_name = form.cleaned_data['contact_first_name']
            user_info.contact_last_name = form.cleaned_data['contact_last_name']
            user_info.notification_email = form.cleaned_data['notification_email']
            user_info.currency_code = form.cleaned_data['currency_code']
            user_info.currency_symbol = form.cleaned_data['currency_symbol']
            user_info.first_time_user = False
            user_info.save()
            return HttpResponseRedirect('/wizard/start') # Redirect after POST
    else:
        form = forms.getUserInfo(initial={
            'country': user_info.country,
            'bussiness_name': user_info.bussiness_name,
            'contact_first_name': user_info.contact_first_name,
            'contact_last_name': user_info.contact_last_name,
            'notification_email': user_info.notification_email,
            'currency_code': user_info.currency_code,
            'currency_symbol': user_info.currency_symbol,
        })

    return render(request, 'tarifica/config/initial.html', {
        'form': form
    })

def config(request):
    user_info = UserInformation.objects.get(pk = 1)
    if request.method == 'POST': # If the form has been submitted...
        form = forms.getUserInfo(request.POST)
        if form.is_valid(): # All validation rules pass
            user_info.country = form.cleaned_data['country']
            user_info.bussiness_name = form.cleaned_data['bussiness_name']
            user_info.contact_first_name = form.cleaned_data['contact_first_name']
            user_info.contact_last_name = form.cleaned_data['contact_last_name']
            user_info.notification_email = form.cleaned_data['notification_email']
            user_info.currency_code = form.cleaned_data['currency_code']
            user_info.currency_symbol = form.cleaned_data['currency_symbol']
            user_info.save()
            return HttpResponseRedirect('/dashboard') # Redirect after POST
    else:
        form = forms.getUserInfo(initial={
            'country': user_info.country,
            'bussiness_name': user_info.bussiness_name,
            'contact_first_name': user_info.contact_first_name,
            'contact_last_name': user_info.contact_last_name,
            'notification_email': user_info.notification_email,
            'currency_code': user_info.currency_code,
            'currency_symbol': user_info.currency_symbol,
        })

    return render(request, 'tarifica/config/config.html', {
        'form': form
    })

def updateUser(request, option):
    user_info = UserInformation.objects.get(pk = 1)
    if option == "trunks_configured":
        user_info.trunks_configured = True
    elif option == "base_tariffs_configured":
        user_info.base_tariffs_configured = True
    elif option == "bundles_configured":
        user_info.bundles_configured = True

    user_info.save()
    return HttpResponseRedirect('/setup')