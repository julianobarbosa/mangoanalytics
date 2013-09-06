#coding=UTF-8
from django import forms
from django.utils.timezone import utc
import datetime
from tarifica.django_countries.countries import COUNTRIES
from tarifica.models import PaymentType, TariffMode, DestinationGroup, DestinationName, Provider

class createProvider(forms.Form):
    name = forms.CharField(label = 'Nombre', error_messages={'required':'Please input a name for this trunk.'})
    monthly_cost = forms.FloatField(label = 'Renta Mensual', error_messages={
                                    'required':'Please input the monthly fee charged by your provider for this trunk.',
                                    'invalid':'Please input a valid number.'
                                    })
    period_end = forms.IntegerField(label = 'Dia de Corte', max_value=31, min_value=1, error_messages={
                                    'required':'Please input the day when each billing period ends.',
                                    'invalid':'Please input a valid number.',
                                    'max_value':'Please input a number between 1 and 31.',
                                    'min_value':'Please input a number between 1 and 31.'})
    payment_type = forms.ChoiceField(choices = [(e.id, e.name) for e in PaymentType.objects.all()], label = 'Modalidad de Pago')
    channels = forms.IntegerField(label = 'Canales', error_messages={'required':u'Please input the number of channels available for this trunk.'})


class createDestinationGroup(forms.Form):
    destination_name = forms.ChoiceField(choices = [(e.id, e.name) for e in DestinationName.objects.all()], label = 'Localidad')
    destination_country = forms.ChoiceField(choices = [(e[0], e[1]) for e in COUNTRIES], label = 'Country',
        error_messages={
            'required':'Please select a valid country option.'
            }
        )
    prefix = forms.CharField(max_length = 255, label = 'Prefijo', required = False)
    notes = forms.CharField(label = u'Notas', required = False)
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
    provider = forms.CharField(widget=forms.HiddenInput())

    def clean(self):
        cleaned_data = super(createDestinationGroup, self).clean()
        provider = cleaned_data.get("provider")
        prefix = cleaned_data.get("prefix")

        try:
            provider = Provider.objects.get(id = provider)
        except Exception:
            raise forms.ValidationError("No provider selected for this form!")

        destination_groups = DestinationGroup.objects.filter(provider=provider)
        for d in destination_groups:
            if d.prefix == prefix:
                msg = u"There can't be tariffs with the same prefix."
                self._errors["prefix"] = self.error_class([msg])
                # These fields are no longer valid. Remove them from the
                # cleaned data.
                del cleaned_data["prefix"]

        # Always return the full collection of cleaned data.
        return cleaned_data

class createBundle(forms.Form):
    name = forms.CharField(max_length = 255, label = 'Nombre de Paquete', error_messages={'required':u'Please input a name for this bundle.'})
    tariff_mode = forms.ChoiceField(choices = [(e.id, e.name) for e in TariffMode.objects.all()], label = 'Modo')
    cost = forms.FloatField(label = 'Costo', error_messages={
                            'required':u"Please input this bundle's cost.",
                            'invalid':'Please input a valid number.'},
                            widget=forms.TextInput(attrs={'class':'input-small'}))
    amount = forms.IntegerField(error_messages={
                            'required':u'Please input the amount of minutes/sessions this bundle includes.',
                            'invalid':'Please input a valid number.'})
    priority = forms.IntegerField(error_messages={
                            'required':u"Please input a number indicating the priority of this bundle. That is, which bundle should be applied first, in case two or more match the call's destination",
                            'invalid':'Please input a valid number.'})
    start_date = forms.DateField(error_messages={
        'required':'Please input a start date.',
        'invalid':'Please input a valid date.'
    })
    end_date = forms.DateField(error_messages={
        'required':'Please input a start date.',
        'invalid':'Please input a valid date.'
    })

    #def clean_start_date(self):
        #data = self.cleaned_data['start_date']
        #today = datetime.datetime.now()
        #today = today - datetime.timedelta(days=1)
        #if data < today.date():
            #print "Date is !"
            #raise forms.ValidationError("Start date must be equal or later than today.")

        # Always return the cleaned data, whether you have changed it or
        # not.
        #return data

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
                            'required':u'Please input a start date.'})
    end_date = forms.DateField(label = 'Fecha final', error_messages={
                            'required':u'Please input an end date.'})

class getUserInfo(forms.Form):
    bussiness_name = forms.CharField(max_length = 255, error_messages={
                    'required':u'Please input a name for your company.'},
                    widget=forms.TextInput(attrs={'class':'input-xlarge'}))
    contact_first_name = forms.CharField(max_length = 255, error_messages={
                    'required':u'Please input your first name.'})
    contact_last_name = forms.CharField(max_length = 255, error_messages={
                    'required':u'Please input your last name'})
    notification_email = forms.EmailField(label = 'Email', error_messages={
                        'required':u'Please input your e-mail address.',
                        'invalid':u'Please input a valid e-mail address.'})
    country = forms.ChoiceField(choices = [(e[0], e[1]) for e in COUNTRIES], label = 'Country')
    currency_code = forms.CharField(max_length = 10, error_messages={
                    'required':u"Please input your currency's code."},
                    widget=forms.TextInput(attrs={'class':'input-mini'}))
    currency_symbol = forms.CharField(max_length = 1, error_messages={
                    'required':u"Please input your currency's symbol."},
                    widget=forms.TextInput(attrs={'class':'input-mini'}))

class getFirstUserInfo(forms.Form):
    bussiness_name = forms.CharField(max_length = 255, error_messages={
                    'required':u'Please input a name for your company.'},
                    widget=forms.TextInput(attrs={'class':'input-xlarge'}))
    contact_first_name = forms.CharField(max_length = 255, error_messages={
                    'required':u'Please input your first name.'})
    contact_last_name = forms.CharField(max_length = 255, error_messages={
                    'required':u'Please input your last name'})
    notification_email = forms.EmailField(label = 'Email', error_messages={
                        'required':u'Please input your e-mail address.',
                        'invalid':u'Please input a valid e-mail address.'})
    country = forms.ChoiceField(choices = [(e[0], e[1]) for e in COUNTRIES], label = 'Country')
    currency_code = forms.CharField(max_length = 10, error_messages={
                    'required':u"Please input your currency's code."},
                    widget=forms.TextInput(attrs={'class':'input-mini'}))
    currency_symbol = forms.CharField(max_length = 1, error_messages={
                    'required':u"Please input your currency's symbol."},
                    widget=forms.TextInput(attrs={'class':'input-mini'}))
    accepted_privacy_policy = forms.BooleanField(required=True, error_messages={
                    'required':u"You need to accept Mango Anaytics' privacy policy before continuing."})

class loginForm(forms.Form):
    email = forms.CharField(max_length = 255, error_messages={
                    'required':u'Please provide your email address.'})
    password = forms.CharField(max_length = 255, error_messages={
                    'required':u'Please provide a password.'})

class filterCDR(forms.Form):
    comparison_choices = [
        ('exact', '='),
        ('contains', 'has'),
        ('exclude', '!='),
        ('gt', '>'),
        ('lt', '<'),
    ]

    provider_choices = [('0','')]
    existing_providers = Provider.objects.filter(is_configured = True)
    print existing_providers
    print len(existing_providers)
    if len(existing_providers) > 0:
        for e in existing_providers:
            provider_choices.append((e.id, e.name))

    action = forms.CharField(required=True, 
        widget=forms.HiddenInput())
    start_date = forms.DateField(label = 'Fecha inicial', required=False, 
        widget=forms.TextInput(attrs={'class':'input-medium'}))
    start_date_comparison = forms.ChoiceField(choices = comparison_choices[3:], required=False,
        widget=forms.Select(attrs={'class':'span2'}))
    end_date = forms.DateField(label = 'Fecha final', required=False, 
        widget=forms.TextInput(attrs={'class':'input-medium'}))
    end_date_comparison = forms.ChoiceField(choices = comparison_choices[3:], required=False,
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
    provider = forms.ChoiceField(choices = provider_choices, required=False,
        widget=forms.Select(attrs={'class':'input-medium'}))
    provider_comparison = forms.ChoiceField(choices = comparison_choices[0:3], required=False,
        widget=forms.Select(attrs={'class':'span2'}))
    destination_group = forms.CharField(max_length = 255, required=False, 
        widget=forms.TextInput(attrs={'class':'input-medium'}))
    destination_group_comparison = forms.ChoiceField(choices = comparison_choices[0:3], required=False,
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