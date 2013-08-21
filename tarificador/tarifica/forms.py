#coding=UTF-8
from django import forms
from django.utils.timezone import utc
import datetime
from tarifica.django_countries.countries import COUNTRIES
from tarifica.models import PaymentType, TariffMode, DestinationGroup, DestinationName

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
    destination_country = forms.ChoiceField(choices = [(e[0], e[1]) for e in COUNTRIES], label = 'Country',
        error_messages={
            'required':'Please select a valid country option'
            }
        )
    prefix = forms.CharField(max_length = 255, label = 'Prefijo', required = False)
    notes = forms.CharField(label = u'Notas', required = False, widget = forms.Textarea)
    minute_fee = forms.FloatField(label = 'Minute Fee', error_messages={
                            'required':'Please input a minute fee',
                            'invalid':'Please input a valid number'}, 
                            widget=forms.TextInput(attrs={'class':'input-small'}))
    connection_fee = forms.FloatField(label = 'Connection Fee', error_messages={
                            'required':'Please input a connection fee',
                            'invalid':'Please input a valid number'}, 
                            widget=forms.TextInput(attrs={'class':'input-small'}))
    billing_interval = forms.IntegerField(label = 'Block', error_messages={
                            'required':'Please input a valid block type.',
                            'invalid':'Please input a valid integer number.'}, 
                            widget=forms.TextInput(attrs={'class':'input-small'}))

class createBundle(forms.Form):
    name = forms.CharField(max_length = 255, label = 'Nombre de Paquete', error_messages={'required':u'Por favor proporciona el nombre del paquete'})
    tariff_mode = forms.ChoiceField(choices = [(e.id, e.name) for e in TariffMode.objects.all()], label = 'Modo')
    cost = forms.FloatField(label = 'Costo', error_messages={
                            'required':u'Por favor proporciona el costo del paquete',
                            'invalid':'Por favor proporciona un número válido'},
                            widget=forms.TextInput(attrs={'class':'input-small'}))
    amount = forms.IntegerField(error_messages={
                            'required':u'Por favor proporciona la cantidad de minutos/sesiones',
                            'invalid':'Por favor proporciona un entero válido'})
    priority = forms.IntegerField(error_messages={
                            'required':u'Por favor proporciona la prioridad del paquete en cuestión',
                            'invalid':'Por favor proporciona un entero válido'})
    start_date = forms.DateField(error_messages={
        'required':'Please input a start date.',
        'invalid':'Please input a valid date.'
    })
    end_date = forms.DateField(error_messages={
        'required':'Please input a start date.',
        'invalid':'Please input a valid date.'
    })

    def clean_start_date(self):
        data = self.cleaned_data['start_date']
        today = datetime.datetime.utcnow().replace(tzinfo=utc)
        today = today - datetime.timedelta(days=1)
        if data < today.date():
            print "Not valid!"
            #raise forms.ValidationError("Start date must be equal or later than today.")

        # Always return the cleaned data, whether you have changed it or
        # not.
        return data

    def clean_end_date(self):
        data = self.cleaned_data['end_date']
        try:
            start = self.cleaned_data['start_date']
        except Exception, e:
            raise forms.ValidationError("Start date must be valid to validate end date.")
        if data < start:
            raise forms.ValidationError("End date must be later than selected start date.")

        return data

class getDate(forms.Form):
    start_date = forms.DateField(label = 'Fecha inicial', error_messages={
                            'required':u'Por favor proporciona una fecha inicial'})
    end_date = forms.DateField(label = 'Fecha final', error_messages={
                            'required':u'Por favor proporciona una fecha final'})

class getUserInfo(forms.Form):
    bussiness_name = forms.CharField(max_length = 255, error_messages={
                    'required':u'Por favor proporciona el nombre de tu empresa'})
    contact_first_name = forms.CharField(max_length = 255, error_messages={
                    'required':u'Por favor proporciona el primer nombre del contacto'})
    contact_last_name = forms.CharField(max_length = 255, error_messages={
                    'required':u'Por favor proporciona el segundo nombre del contacto'})
    notification_email = forms.EmailField(label = 'Email', error_messages={
                        'required':u'Por favor proporciona un correo electrónico.',
                        'invalid':u'Por favor proporciona un correo electrónico válido.'})
    country = forms.ChoiceField(choices = [(e[0], e[1]) for e in COUNTRIES], label = 'Country')
    currency_code = forms.CharField(max_length = 10, error_messages={
                    'required':u'Por favor proporciona el código del tipo de moneda'})
    currency_symbol = forms.CharField(max_length = 1, error_messages={
                    'required':u'Por favor proporciona el símbolo del tipo de moneda'})

class loginForm(forms.Form):
    email = forms.CharField(max_length = 255, error_messages={
                    'required':u'Por favor proporciona tu correo'})
    password = forms.CharField(max_length = 255, error_messages={
                    'required':u'Por favor proporciona una contraseña'})

class filterCDR(forms.Form):
    comparison_choices = [
        ('exact', '='),
        ('gt', '>'),
        ('lt', '<'),
        ('exclude', '!=')
    ]
    action = forms.CharField(required=True, 
        widget=forms.HiddenInput())
    start_date = forms.DateField(label = 'Fecha inicial', required=False, 
        widget=forms.TextInput(attrs={'class':'input-medium'}))
    start_date_comparison = forms.ChoiceField(choices = comparison_choices[1:], required=False,
        widget=forms.Select(attrs={'class':'span2'}))
    end_date = forms.DateField(label = 'Fecha final', required=False, 
        widget=forms.TextInput(attrs={'class':'input-medium'}))
    end_date_comparison = forms.ChoiceField(choices = comparison_choices[1:], required=False,
        widget=forms.Select(attrs={'class':'span2'}))
    dialed_number = forms.CharField(max_length = 255, required=False, 
        widget=forms.TextInput(attrs={'class':'input-medium'}))
    dialed_number_comparison = forms.ChoiceField(choices = comparison_choices, required=False,
        widget=forms.Select(attrs={'class':'span2'}))
    extension_number = forms.CharField(max_length = 255, required=False, 
        widget=forms.TextInput(attrs={'class':'input-medium'}))
    extension_number_comparison = forms.ChoiceField(choices = comparison_choices, required=False,
        widget=forms.Select(attrs={'class':'span2'}))
    pinset_number = forms.CharField(max_length = 255, required=False, 
        widget=forms.TextInput(attrs={'class':'input-medium'}))
    pinset_number_comparison = forms.ChoiceField(choices = comparison_choices, required=False,
        widget=forms.Select(attrs={'class':'span2'}))
    provider = forms.CharField(max_length = 255, required=False, 
        widget=forms.TextInput(attrs={'class':'input-medium'}))
    provider_comparison = forms.ChoiceField(choices = comparison_choices, required=False,
        widget=forms.Select(attrs={'class':'span2'}))
    destination_group = forms.CharField(max_length = 255, required=False, 
        widget=forms.TextInput(attrs={'class':'input-medium'}))
    destination_group_comparison = forms.ChoiceField(choices = comparison_choices, required=False,
        widget=forms.Select(attrs={'class':'span2'}))
    duration = forms.CharField(max_length = 255, required=False, 
        widget=forms.TextInput(attrs={'class':'input-medium'}))
    duration_comparison = forms.ChoiceField(choices = comparison_choices, required=False,
        widget=forms.Select(attrs={'class':'span2'}))
    cost = forms.CharField(max_length = 255, required=False, 
        widget=forms.TextInput(attrs={'class':'input-medium'}))
    cost_comparison = forms.ChoiceField(choices = comparison_choices, required=False,
        widget=forms.Select(attrs={'class':'span2'}))

class getImportStartDate(forms.Form):
    start_date = forms.DateField(label = 'Fecha inicial', error_messages={
                'required':u'Please select a valid date.'})