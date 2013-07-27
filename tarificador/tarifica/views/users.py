#Views for providers

import datetime
from django.utils.timezone import utc
from django.shortcuts import render, get_object_or_404
from django.http import HttpResponseRedirect, HttpResponse
from tarifica.forms import AddProviderInfo, AddBaseTariffs, AddBundles
from tools.asteriskMySQLManager import AsteriskMySQLManager
from tarifica.models import *
from django.forms.formsets import formset_factory

def generalUsers(request):
    pass

def detailUsers(request, extension_id):
    pass

def analiticsUsers(request, extension_id):
    pass