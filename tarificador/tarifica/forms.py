from django import forms
from tarifica.models import PaymentType

class AddProviderInfo(forms.Form):
    provider = forms.ChoiceField(choices = , label = 'Selecciona Troncal')
    name = forms.CharField(label = 'Nombre', error_messages={'required':'Por favor proporciona un nombre para el Troncal'})
    monthly_cost = forms.FloatField(label = 'Renta Mensual', error_messages={'required':u'Por favor proporciona la renta mensual del Troncal seleccionado'})
    period_end = forms.IntegerField(label = 'Dia de Corte', max_value=31, min_value=0, error_messages={'required':u'Por favor proporciona el día de corte del Troncal', 'invalid':u'Por favor proporciona un número válido'})
    payment_type = forms.ChoiceField(choices = [(e, e.name) for e in PaymentType.objects.all()], label = 'Modalidad de Pago')
    channels = forms.IntegerField(label = 'Canales', error_messages={'required':u'Por favor proporciona un número válido'})


class AddBaseTariffs(forms.Form):
    destination_group = forms.CharField(max_length = 255, label = 'Localidad')
    prefix = forms.CharField(max_length = 255, label = 'Prefijo')
    matching_number = forms.CharField(max_length = 255, label = 'Expresion Regular')
    #tariff_mode = forms.ChoiceField(choices = [(e, e.name) for e in TariffMode.objects.all()], label = 'Modo')
    cost = forms.FloatField(label = 'Costo')


class AddBundles(forms.Form):
    name = forms.CharField(max_length = 255, label = 'Nombre de Paquete')
    #destination_group = forms.ChoiceField(choices = [(e, e.name) for e in DestinationGroup.objects.all()], label = 'Localidad')
    #tariff_mode = forms.ChoiceField(choices = [(e, e.name) for e in TariffMode.objects.all()], label = 'Modo')
    cost = forms.FloatField(label = 'Costo')


