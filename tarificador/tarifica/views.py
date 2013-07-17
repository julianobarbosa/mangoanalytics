# Create your views here.


from django.shortcuts import render
from django.http import HttpResponseRedirect, HttpResponse
from tarifica.forms import AddProviderInfo, AddBaseTariffs, AddBundles
from tools.asteriskMySQLManager import AsteriskMySQLManager
from tarifica import models


#cambiar la funcion para que reciba un provider y se le agrege la informacion
def setupAddProviderInfo(request, name):
    if request.method == 'POST': # If the form has been submitted...
        form = AddProviderInfo(request.POST) # A form bound to the POST data
        if form.is_valid(): # All validation rules pass
            name = form.cleaned_data['name']
            monthly_cost = form.cleaned_data['monthly_cost']
            period_end = form.cleaned_data['period_end']
            payment_type = form.cleaned_data['payment_type']
            channels = form.cleaned_data['channels']
            p = Provider(name, monthly_cost, payment_type, channels)
            p.save()
            return HttpResponseRedirect('tarifica/thanks') # Redirect after POST
    else:
        form = AddProviderInfo() # An unbound form

    return render(request, 'tarifica/setupprovider.html', {
        'form': form,
    })



def setupAddBaseTariffs(request):
    if request.method == 'POST': # If the form has been submitted...
        form = AddBaseTariffs(request.POST) # A form bound to the POST data
        if form.is_valid(): # All validation rules pass
            name = form.cleaned_data['destination_group']
            prefix = form.cleaned_data['prefix']
            matching_number = form.cleaned_data['matching_number']
            tariff_mode = form.cleaned_data['tariff_mode']
            cost = form.cleaned_data['cost']
            d = DestinationGroup(name, prefix, matching_number)
            d.save()
            b = BaseTariff(cost, tariff_mode, d)
            b.save()
            return HttpResponseRedirect('tarifica/thanks') # Redirect after POST
    else:
        form = AddBaseTariffs() # An unbound form

    return render(request, 'tarifica/setupbasetariffs.html', {
        'form': form,
    })



def setupAddBundles(request):
    if request.method == 'POST': # If the form has been submitted...
        form = AddBundles(request.POST) # A form bound to the POST data
        if form.is_valid(): # All validation rules pass
            name = form.cleaned_data['name']
            destination_group = form.cleaned_data['destination_group']
            tariff_mode = form.cleaned_data['period_end']
            cost = form.cleaned_data['cost']
            b = Bundle(name, destination_group, tariff_mode, cost)
            b.save()
            return HttpResponseRedirect('tarifica/thanks') # Redirect after POST
    else:
        form = AddBundles() # An unbound form

    return render(request, 'tarifica/setupbundles.html', {
        'form': form,
    })


def dashboardTrunks(request):
    a_mysql_m = AsteriskMySQLManager()
    trunks = a_mysql_m.getTrunkInformation()
    for x in trunks:
        try:
            e = Provider.get(asterisk_id = x[0])
        except Provider.DoesNotExist:
            p = Provider(asterisk_id = x[0], asterisk_name = x[1])
        except Provider.MultipleObjectsReturned:
            print "troncales repetidas!"
    providers_not_configured = Provider.objects.filter(is_configured=True)
    providers_configured = Provider.objects.filter(is_configured=False)
    return render(request, 'tarifica/dashboardtroncales.html', {
                  'not_configured' : providers_not_configured,
                  'configured' : providers_configured,
                  })



def thanks(request):
    return HttpResponse("jaja")