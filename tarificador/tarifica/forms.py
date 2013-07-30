#coding=UTF-8
from django import forms
from tarifica.models import PaymentType, TariffMode, DestinationGroup, DestinationName, DestinationCountry

class createProvider(forms.Form):
    name = forms.CharField(label = 'Nombre', error_messages={'required':'Por favor proporciona un nombre para el Troncal'})
    monthly_cost = forms.FloatField(label = 'Renta Mensual', error_messages={
                                    'required':'Por favor proporciona la renta mensual del Troncal seleccionado',
                                    'invalid':'Por favor proporciona un número válido'
                                    })
    period_end = forms.IntegerField(label = 'Dia de Corte', max_value=31, min_value=1, error_messages={
                                    'required':'Por favor proporciona el día de corte del Troncal',
                                    'invalid':'Por favor proporciona un número válido',
                                    'max_value':'Por favor proporcione un número entre 1 y 31',
                                    'min_value':'Por favor proporcione un número entre 1 y 31'})
    payment_type = forms.ChoiceField(choices = [(e.id, e.name) for e in PaymentType.objects.all()], label = 'Modalidad de Pago')
    channels = forms.IntegerField(label = 'Canales', error_messages={'required':u'Por favor proporciona el número de canales'})


class createDestinationGroup(forms.Form):
    destination_name = forms.ChoiceField(choices = [(e.id, e.name) for e in DestinationName.objects.all()], label = 'Localidad')
    destination_country = forms.ChoiceField(choices = [(e.id, e.name) for e in DestinationCountry.objects.all()], label = 'País', required = False)
    prefix = forms.CharField(max_length = 255, label = 'Prefijo', error_messages={'required':u'Por favor proporciona un prefijo'})
    matching_number = forms.CharField(max_length = 255, label = u'Cantidad de dígitos:', error_messages={'required':u'Por favor proporciona una cadena'})
    tariff_mode = forms.ChoiceField(choices = [(e.id, e.name) for e in TariffMode.objects.all()], label = 'Modo')
    notes = forms.CharField(label = u'Notas', required = False, widget = forms.Textarea)
    cost = forms.FloatField(label = 'Costo', error_messages={
                            'required':'Por favor proporciona el costo',
                            'invalid':'Por favor proporciona un número válido'})


class createBundle(forms.Form):
    name = forms.CharField(max_length = 255, label = 'Nombre de Paquete', error_messages={'required':u'Por favor proporciona el nombre del paquete'})
    tariff_mode = forms.ChoiceField(choices = [(e.id, e.name) for e in TariffMode.objects.all()], label = 'Modo')
    cost = forms.FloatField(label = 'Costo', error_messages={
                            'required':u'Por favor proporciona el costo del paquete',
                            'invalid':'Por favor proporciona un número válido'})
    amount = forms.IntegerField(error_messages={
                            'required':u'Por favor proporciona la cantidad de minutos/sesiones',
                            'invalid':'Por favor proporciona un entero válido'})
    priority = forms.IntegerField(error_messages={
                            'required':u'Por favor proporciona la prioridad del paquete en cuestión',
                            'invalid':'Por favor proporciona un entero válido'})


class getDate(forms.Form):
    start_date = forms.DateField(label = 'Fecha inicial', error_messages={
                            'required':u'Por favor proporciona una fecha inicial'})
    end_date = forms.DateField(label = 'Fecha final', error_messages={
                            'required':u'Por favor proporciona una fecha final'})