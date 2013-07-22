# Create your views here.


from django.shortcuts import render, get_object_or_404
from django.http import HttpResponseRedirect, HttpResponse
from tarifica.forms import AddProviderInfo, AddBaseTariffs, AddBundles
from tools.asteriskMySQLManager import AsteriskMySQLManager
from tarifica.models import Provider, DestinationGroup, BaseTariff, PaymentType, Bundles, TariffMode
from django.forms.formsets import formset_factory


#cambiar la funcion para que reciba un provider y se le agrege la informacion
def setupAddProviderInfo(request, asterisk_id):
    provider = get_object_or_404(Provider, asterisk_id = asterisk_id)

    if request.method == 'POST': # If the form has been submitted...
        form = AddProviderInfo(request.POST) # A form bound to the POST data
        if form.is_valid(): # All validation rules pass
            provider.name = form.cleaned_data['name']
            provider.monthly_cost = form.cleaned_data['monthly_cost']
            provider.period_end = form.cleaned_data['period_end']
            provider.payment_type = PaymentType.objects.get(id=form.cleaned_data['payment_type'])
            provider.channels = form.cleaned_data['channels']
            provider.is_configured = True
            provider.save()
            return HttpResponseRedirect('/tarifica/dashboardtroncales') # Redirect after POST
    else:
        form = AddProviderInfo() # An unbound form

    return render(request, 'tarifica/setupprovider.html', {
        'form': form,
        'provider': provider
    })



def setupAddBaseTariffs(request, asterisk_id):
    provider = get_object_or_404(Provider, asterisk_id = asterisk_id)
    if request.method == 'POST': # If the form has been submitted...
        form = AddBaseTariffs(request.POST) # A form bound to the POST data
        if form.is_valid(): # All validation rules pass
            name = form.cleaned_data['destination_group']
            prefix = form.cleaned_data['prefix']
            matching_number = form.cleaned_data['matching_number']
            tariff_mode = TariffMode.objects.get(id=form.cleaned_data['tariff_mode'])
            print tariff_mode.name 
            cost = form.cleaned_data['cost']
            d = DestinationGroup(provider=provider, name=name, prefix=prefix, matching_number=matching_number)
            d.save()
            b = BaseTariff(provider=provider, cost=cost, mode=tariff_mode, destination_group=d)
            b.save()
            return HttpResponseRedirect('/tarifica/dashboardtroncales') # Redirect after POST
    else:
        form = AddBaseTariffs() # An unbound form

    return render(request, 'tarifica/setupbasetariffs.html', {
        'form': form,
        'provider' : provider,
    })



def setupAddBundles(request, id):
    provider = get_object_or_404(Provider, id = id)
    base = BaseTariff.objects.all()
    if request.method == 'POST': # If the form has been submitted...
        form = AddBundles(request.POST) # A form bound to the POST data
        if form.is_valid(): # All validation rules pass
            name = form.cleaned_data['name']
            destination_group = DestinationGroup.objects.get(id=form.cleaned_data['destination_group'])
            tariff_mode = TariffMode.objects.get(id=form.cleaned_data['tariff_mode'])
            cost = form.cleaned_data['cost']
            amount = form.cleaned_data['amount']
            provider.has_bundles=True
            provider.save()
            priority = form.cleaned_data['priority']
            b = Bundles(priority = priority, name=name, provider=provider, destination_group=destination_group, tariff_mode=tariff_mode, cost=cost, amount=amount)
            b.save()
            return HttpResponseRedirect('/tarifica/dashboardtroncales') # Redirect after POST
    else:
        form = AddBundles() # An unbound form

    return render(request, 'tarifica/setupbundles.html', {
        'form': form,
        'base' : base,
        'provider' : provider,
    })


def dashboardTrunks(request):
    a_mysql_m = AsteriskMySQLManager()
    trunks = a_mysql_m.getTrunkInformation()
    for x in trunks:
        print x['trunkid']
        if x['trunkid']:
            try:
                e = Provider.objects.get(asterisk_id = x['trunkid'])
            except Provider.DoesNotExist:
                p = Provider(asterisk_id = x['trunkid'], asterisk_name = x['name'], provider_type = x['tech'])
                p.save()
            except Provider.MultipleObjectsReturned:
                print "troncales repetidas!"
    providers_not_configured = Provider.objects.filter(is_configured=False).order_by('asterisk_name')
    providers_configured = Provider.objects.filter(is_configured=True).order_by('name')
    bundles = Bundles.objects.all().order_by('name')
    locales = BaseTariff.objects.all()
    return render(request, 'tarifica/dashboardtroncales.html', {
                  'not_configured' : providers_not_configured,
                  'configured' : providers_configured,
                  'bundles' : bundles,
                  'locales' : locales,
                  })




def deleteProvider(request, id):
    provider = get_object_or_404(Provider, id = id)
    provider.delete()
    return HttpResponseRedirect('/tarifica/dashboardtroncales')


def deleteBundle(request, id):
    bundle = get_object_or_404(Bundles, id = id)
    bundle.delete()
    return HttpResponseRedirect('/tarifica/dashboardtroncales')



def setupChangeProviderInfo(request, id):
    provider = get_object_or_404(Provider, id = id)

    if request.method == 'POST': # If the form has been submitted...
        form = AddProviderInfo(request.POST) # A form bound to the POST data
        if form.is_valid(): # All validation rules pass
            provider.name = form.cleaned_data['name']
            provider.monthly_cost = form.cleaned_data['monthly_cost']
            provider.period_end = form.cleaned_data['period_end']
            provider.payment_type = PaymentType.objects.get(id=form.cleaned_data['payment_type'])
            provider.channels = form.cleaned_data['channels']
            provider.is_configured = True
            provider.save()
            return HttpResponseRedirect('/tarifica/dashboardtroncales') # Redirect after POST
    else:
        form = AddProviderInfo(initial=
        {'name': provider.name,
         'monthly_cost': provider.monthly_cost,
         'period_end': provider.period_end,
         'payment_type': provider.payment_type,
         'channels': provider.channels,
        }
        )# An unbound form

    return render(request, 'tarifica/setupchangeprovider.html', {
        'form': form,
        'provider': provider
    })




def setupChangeBundles(request, id):
    b = get_object_or_404(Bundles, id = id)
    if request.method == 'POST': # If the form has been submitted...
        form = AddBundles(request.POST) # A form bound to the POST data
        if form.is_valid(): # All validation rules pass
            b.name = form.cleaned_data['name']
            b.destination_group = DestinationGroup.objects.get(id=form.cleaned_data['destination_group'])
            b.tariff_mode = TariffMode.objects.get(id=form.cleaned_data['tariff_mode'])
            b.cost = form.cleaned_data['cost']
            b.amount = form.cleaned_data['amount']
            b.priority = form.cleaned_data['priority']
            b.save()
            return HttpResponseRedirect('/tarifica/dashboardtroncales') # Redirect after POST
    else:
        form = AddBundles(initial=
        {'name': b.name,
         'destination_group': b.destination_group,
         'tariff_mode': b.tariff_mode,
         'cost': b.cost,
         'amount': b.amount,
         'priority': b.priority,
        }) # An unbound form

    return render(request, 'tarifica/setupchangebundles.html', {
        'form': form,
        'b' : b,
    })






def thanks(request):
    return HttpResponse("jaja")