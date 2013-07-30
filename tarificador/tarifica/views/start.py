# Initial configuration views
import datetime
from django.shortcuts import render, get_object_or_404
from django.http import HttpResponseRedirect, HttpResponse
from django.core.exceptions import ObjectDoesNotExist
from tarifica.tools.asteriskMySQLManager import AsteriskMySQLManager
from tarifica.models import *
from tarifica import forms
from math import ceil

def step1(request):
    return render(request, 'tarifica/start/step1.html', {})

def step2(request):
    if request.method == 'POST': # If the form has been submitted...
        form = forms.getNotificationEmail()
        if form.is_valid(): # All validation rules pass
            user_info = UserInformation.objects.get(pk = 1)
            user_info.notification_email = form.cleaned_data['email']
            user_info.first_import_started = datetime.datetime.now()
            user_info.save()

            # Start processing call data:
            # callDataStart()
            return HttpResponseRedirect('/start/step3') # Redirect after POST
    else:
        form = forms.getNotificationEmail()

    return render(request, 'tarifica/start/step2.html', {
        'form': form
    })

def step3(request):
    return render(request, 'tarifica/start/step3.html', {})

def checkProcessingStatus(request):
    user_info = get_object_or_404(UserInformation, id = 1)
    # By default, we import 2 month's worth of data, so we can check how many
    # days are between today and the last date imported.
    try:
        lastProviderDailyDetail = ProviderDailyDetail.objects.latest('date')
        lapsedTime = user_info.first_import_started - datetime.datetime.now()
        lapsedMinutes = ceil(lapsedTime.seconds / 60)

        startDate = user_info.first_import_started
        initialDateForProcessing = datetime.datetime(
            year = startDate.year,
            month = startDate.month,
            day = 1,
            hours = 0,
            minutes = 0,
            seconds = 0
        )
        endDateForProcessing = datetime.datetime(
            year = startDate.year,
            month = startDate.month + 2,
            day = 1,
            hours = 0,
            minutes = 0,
            seconds = 0
        )
        processedDays = (lastProviderDailyDetail.date - initialDateForProcessing).days
        daysToBeProcessed = (endDateForProcessing - initialDateForProcessing).days
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