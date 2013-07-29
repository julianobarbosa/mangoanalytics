#Views for providers

import datetime
from django.utils.timezone import utc
from django.shortcuts import render, get_object_or_404
from django.http import HttpResponseRedirect, HttpResponse
from tarifica.tools.asteriskMySQLManager import AsteriskMySQLManager
from tarifica.models import *
from django.forms.formsets import formset_factory

def createProvider(self, asterisk_id):
    pass

def updateProvider(self, provider_id):
    pass

def deleteProvider(self, provider_id):
    pass