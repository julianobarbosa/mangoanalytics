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
from dateutil.relativedelta import *
from math import ceil

def start(request):
    user_info = get_object_or_404(UserInformation, id = 1)
    return render(request, 'tarifica/wizard/start.html', {})

def testrun(request, default="none"):
    import subprocess
    import os

    start_date = datetime.date.today()
    start_date = start_date - relativedelta(months=6)

    if request.method == 'POST': 
        form = forms.getImportStartDate(request.POST) 
        if form.is_valid():
            start_date = form.cleaned_data['start_date']
            default = 'default'
    else:
        form = forms.getImportStartDate(initial={
            'start_date': start_date
        })

    current_directory = os.path.dirname(os.path.realpath(__file__))

    user_info = get_object_or_404(UserInformation, id = 1)
    user_info.test_run_in_progress = True
    user_info.save()

    importer_script_path = current_directory+"/../tools/"
    if default == 'default':
        try:
            p = subprocess.Popen([
                'python2.7', 
                importer_script_path+'importer.py', 
                start_date.strftime("%Y-%m-%d"), 
                '--testrun'
            ])
            # p = subprocess.check_output(['python2.7', importer_script_path+'importer.py', '--testrun'])
        except Exception, e:
            print "Error while dry running:",e
            p = None
        user_info.first_import_started = datetime.datetime.now()
        user_info.save()
        return HttpResponseRedirect('/wizard/checkTestRunStatus/show')

    return render(request, 'tarifica/wizard/testRun.html', {
        'form': form, 
        'start_date': start_date,
        'default': default
    })

def checkTestRunStatus(request, action="show"):
    user_info = get_object_or_404(UserInformation, id = 1)
    # By default, we import 6 month's worth of data, so we can check how many
    # days are between today and the last date imported.
    try:
        now = datetime.datetime.utcnow().replace(tzinfo=utc)
        lastCall = Call.objects.latest('date')
        lapsedTime = now - user_info.first_import_started
        lapsedSeconds = lapsedTime.total_seconds()
        lapsedMinutes = ceil(lapsedTime.total_seconds() / 60)

        endDateForProcessing = datetime.date(
            year = user_info.first_import_started.year,
            month = user_info.first_import_started.month,
            day = user_info.first_import_started.day
        )
        initialDateForProcessing = endDateForProcessing - datetime.timedelta(days = 141)

        daysToBeProcessed = 140
        processedDays = (lastCall.date.date() - initialDateForProcessing).days
        percentage_imported = ( processedDays / daysToBeProcessed ) * 100
        totalMinutes = ceil(( daysToBeProcessed * lapsedMinutes ) / processedDays)
        minutesRemaining = totalMinutes - lapsedMinutes
        
    except ObjectDoesNotExist, e:
        percentage_imported = 0
        lapsedMinutes = 0
        minutesRemaining = 'infinite'

    if action == 'update':
        # AJAX request to show info
        return render(request, 'tarifica/wizard/updateTestRunStatus.html', {
            'user_info': user_info,
            'percentage_imported': percentage_imported,
            'lapsedMinutes': lapsedMinutes,
            'minutesRemaining': minutesRemaining
        })

    return render(request, 'tarifica/wizard/checkTestRunStatus.html', {
        'user_info': user_info,
        'percentage_imported': percentage_imported,
        'lapsedMinutes': lapsedMinutes,
        'minutesRemaining': minutesRemaining
    })

def results(request):
    user_info = get_object_or_404(UserInformation, id = 1)
    user_info.is_first_import_finished = False
    user_info.save()

    import_results = ImportResults.objects.order_by('-id')[0]
    unconfigured_calls = UnconfiguredCall.objects.all()[:100]
    return render(request, 'tarifica/wizard/results.html', {
        'import_results': import_results,
        'unconfigured_calls': unconfigured_calls,
        'percentage_not_processed': (import_results.calls_not_saved / (import_results.calls_not_saved + import_results.calls_saved)) * 100
    })

def run(request, default="none"):
    import subprocess
    import os

    start_date = datetime.date.today()
    start_date = start_date - relativedelta(months=6)

    if request.method == 'POST': 
        form = forms.getImportStartDate(request.POST) 
        if form.is_valid():
            start_date = form.cleaned_data['start_date']
            default = 'default'
    else:
        form = forms.getImportStartDate(initial={
            'start_date': start_date
        })

    current_directory = os.path.dirname(os.path.realpath(__file__))

    user_info = get_object_or_404(UserInformation, id = 1)
    user_info.processing_in_progress = True
    user_info.save()
    importer_script_path = current_directory+"/../tools/"
    if default == 'default':
        try:
            p = subprocess.Popen([
                'python2.7', 
                importer_script_path+'importer.py',
                start_date.strftime("%Y-%m-%d")
            ])
            # p = subprocess.check_output(['python2.7', importer_script_path+'importer.py'])
        except Exception, e:
            print "Error while digesting:",e
            p = None
        user_info.first_import_started = datetime.datetime.now()
        user_info.is_first_import_finished = False
        user_info.save()
        return HttpResponseRedirect('/wizard/checkProcessingStatus/show')

    return render(request, 'tarifica/wizard/run.html', {
        'form': form, 
        'start_date': start_date,
        'default': default
    })

def checkProcessingStatus(request, action="show"):
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

    if action == 'update':
        # AJAX request to show info
        return render(request, 'tarifica/wizard/updateProcessingStatus.html', {
            'user_info': user_info,
            'percentage_imported': percentage_imported,
            'lapsedMinutes': lapsedMinutes,
            'minutesRemaining': minutesRemaining
        })

    return render(request, 'tarifica/wizard/checkProcessingStatus.html', {
        'user_info': user_info,
        'percentage_imported': percentage_imported,
        'lapsedMinutes': lapsedMinutes,
        'minutesRemaining': minutesRemaining
    })