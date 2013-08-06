# Initial configuration views
from __future__ import division
import datetime
from django.utils.timezone import utc
from django.shortcuts import render, get_object_or_404
from django.http import HttpResponseRedirect, HttpResponse
from django.core.exceptions import ObjectDoesNotExist
from tarifica.tools.asteriskMySQLManager import AsteriskMySQLManager
from tarifica.models import *
from tarifica import forms
from math import ceil

def step1(request):
    user_info = get_object_or_404(UserInformation, id = 1)

    if request.method == 'POST': # If the form has been submitted...
        form = forms.getUserInfo()
        if form.is_valid(): # All validation rules pass
            user_info.country_code = form.cleaned_data['country_code']
            user_info.bussiness_name = form.cleaned_data['bussiness_name']
            user_info.contact_first_name = form.cleaned_data['contact_first_name']
            user_info.contact_last_name = form.cleaned_data['contact_last_name']
            user_info.notification_email = form.cleaned_data['notification_email']
            user_info.currency_code = form.cleaned_data['currency_code']
            user_info.currency_symbol = form.cleaned_data['currency_symbol']
            user_info.first_time_user = False
            user_info.save()
            return HttpResponseRedirect('/start/step2') # Redirect after POST
        else:
            print "wasn't valid"
    else:
        form = forms.getUserInfo(initial={
            'country_code': user_info.country_code,
            'bussiness_name': user_info.bussiness_name,
            'contact_first_name': user_info.contact_first_name,
            'contact_last_name': user_info.contact_last_name,
            'notification_email': user_info.notification_email,
            'currency_code': user_info.currency_code,
            'currency_symbol': user_info.currency_symbol,
        })

    return render(request, 'tarifica/start/step1.html', {
        'form': form
    })

def step2(request):
    user_info = get_object_or_404(UserInformation, id = 1)
    if request.method == 'POST': # If the form has been submitted...
        form = forms.getNotificationEmail()
        if form.is_valid(): # All validation rules pass
            user_info.notification_email = form.cleaned_data['email']
            user_info.first_import_started = datetime.datetime.now()
            user_info.save()

            return HttpResponseRedirect('/start/step2') # Redirect after POST
    else:
        form = forms.getNotificationEmail(initial = {
            'email': user_info.notification_email
        })

    return render(request, 'tarifica/start/step2.html', {
        'form': form
    })

def step3(request):
    user_info = get_object_or_404(UserInformation, id = 1)
    return render(request, 'tarifica/start/step3.html', {})

def step4(request):
    import subprocess
    import os
    current_directory = os.path.dirname(os.path.realpath(__file__))

    user_info = get_object_or_404(UserInformation, id = 1)
    importer_script_path = current_directory+"/../tools/"
    try:
        # p = subprocess.Popen(['python2.7', importer_script_path+'importer.py', user_info.notification_email])
        p = subprocess.check_output(['python2.7', importer_script_path+'importer.py', user_info.notification_email])
    except Exception, e:
        print "Error while digesting:",e
        p = None
    user_info.first_import_started = datetime.datetime.now()
    user_info.save()
    return render(request, 'tarifica/start/step4.html', {'p': p, 'cd': importer_script_path })

def checkProcessingStatus(request):
    user_info = get_object_or_404(UserInformation, id = 1)
    # By default, we import 6 month's worth of data, so we can check how many
    # days are between today and the last date imported.
    try:
        now = datetime.datetime.utcnow().replace(tzinfo=utc)
        lastProviderDailyDetail = ProviderDailyDetail.objects.latest('date')
        lapsedTime = now - user_info.first_import_started
        lapsedSeconds = lapsedTime.total_seconds()
        lapsedMinutes = lapsedTime.total_seconds() / 60

        endDateForProcessing = datetime.date(
            year = user_info.first_import_started.year,
            month = user_info.first_import_started.month,
            day = user_info.first_import_started.day
        )
        initialDateForProcessing = endDateForProcessing - datetime.timedelta(days = 141)

        daysToBeProcessed = 140
        processedDays = (lastProviderDailyDetail.date - initialDateForProcessing).days
        percentage_imported = ( processedDays / daysToBeProcessed ) * 100
        totalMinutes = ( daysToBeProcessed * lapsedMinutes ) / processedDays
        minutesRemaining = totalMinutes - lapsedMinutes
        
    except ObjectDoesNotExist, e:
        percentage_imported = 0
        lapsedMinutes = 0
        minutesRemaining = 'infinite'

    return render(request, 'tarifica/start/checkProcessingStatus.html', {
        'user_info': user_info,
        'percentage_imported': percentage_imported,
        'lapsedMinutes': lapsedMinutes,
        'minutesRemaining': minutesRemaining
    })