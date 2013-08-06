from django.db import models
from django_countries import CountryField

# Create your models here.
class PaymentType(models.Model):
    name = models.CharField(max_length = 255, default="Pospago")
    def __unicode__(self):
        return self.name

class TariffMode(models.Model):
    name = models.CharField(max_length = 255)
    def __unicode__(self):
        return self.name

class Provider(models.Model):
    asterisk_id = models.IntegerField()
    asterisk_name = models.CharField(max_length = 255)
    asterisk_channel_id = models.CharField(max_length=255)
    name = models.CharField(max_length = 255)
    monthly_cost = models.FloatField(default=0)
    provider_tech = models.CharField(max_length = 50, blank=True)
    payment_type = models.ForeignKey(PaymentType, blank=True, null=True)
    channels = models.IntegerField(blank=True, default=0)
    period_end = models.IntegerField(default=0)
    is_configured = models.BooleanField(default=False)
    def __unicode__(self):
        return self.asterisk_name

class DestinationName(models.Model):
    name = models.CharField(max_length = 255)
    def __unicode__(self):
        return self.name

class DestinationGroup(models.Model):
    provider = models.ForeignKey(Provider, blank=True, null=True)
    cost = models.FloatField()
    tariff_mode = models.ForeignKey(TariffMode, blank=True, null=True)
    prefix = models.CharField(max_length = 255, blank=True)
    notes = models.TextField(null=True, blank=True)
    destination_name = models.ForeignKey(DestinationName, blank=True, null=True)
    destination_country = CountryField()
    has_bundles = models.BooleanField(default=False)
    def __unicode__(self):
        return self.provider.name, '-', self.destination_name.name

class Bundle(models.Model):
    name = models.CharField(max_length = 255)
    destination_group = models.ForeignKey(DestinationGroup, blank=True, null=True)
    tariff_mode = models.ForeignKey(TariffMode, blank=True, null=True)
    cost = models.FloatField()
    usage = models.IntegerField(blank=True, null=True)
    amount = models.IntegerField()
    priority = models.IntegerField()

class Call(models.Model):
    dialed_number = models.CharField(max_length = 255)
    extension_number = models.CharField(max_length = 255)
    duration = models.IntegerField()
    cost = models.FloatField()
    date = models.DateTimeField()
    destination_group = models.ForeignKey(DestinationGroup, blank=True, null=True)
    provider = models.ForeignKey(Provider, blank=True, null=True)

class Extension(models.Model):
    extension_number = models.CharField(max_length = 255)
    name = models.CharField(max_length = 255)
    calls = models.ForeignKey(Call, blank=True, null=True)

class UserDailyDetail(models.Model):
    extension = models.ForeignKey(Extension, blank=True, null=True)
    total_calls = models.IntegerField()
    total_minutes = models.IntegerField()
    cost = models.FloatField()
    date = models.DateField()

class UserDestinationDetail(models.Model):
    extension = models.ForeignKey(Extension, blank=True, null=True)
    total_calls = models.IntegerField()
    total_minutes = models.IntegerField()
    cost = models.FloatField()
    destination_group = models.ForeignKey(DestinationGroup, blank=True, null=True)
    date = models.DateField()

class UserDestinationNumberDetail(models.Model):
    extension = models.ForeignKey(Extension, blank=True, null=True)
    total_calls = models.IntegerField()
    total_minutes = models.IntegerField()
    cost = models.FloatField()
    prefix = models.CharField(max_length = 255)
    number = models.CharField(max_length = 255)
    date = models.DateField()

class ProviderDailyDetail(models.Model):
    provider = models.ForeignKey(Provider, blank=True, null=True)
    cost = models.FloatField()
    total_calls = models.IntegerField()
    total_minutes = models.IntegerField()
    date = models.DateField()

class ProviderDestinationDetail(models.Model):
    provider = models.ForeignKey(Provider, blank=True, null=True)
    cost = models.FloatField()
    total_calls = models.IntegerField()
    total_minutes = models.IntegerField()
    destination_group = models.ForeignKey(DestinationGroup, blank=True, null=True)
    date = models.DateField()

class UserInformation(models.Model):
    first_time_user = models.BooleanField(default=True)
    first_import_started = models.DateTimeField(blank=True, null=True)
    is_first_import_finished = models.BooleanField(default=False)
    trunks_configured = models.BooleanField(default=False)
    base_tariffs_configured = models.BooleanField(default=False)
    bundles_configured = models.BooleanField(default=False)
    #country = CountryField()
    bussiness_name = models.CharField(max_length=255)
    contact_first_name = models.CharField(max_length=255)
    contact_last_name = models.CharField(max_length=255)
    notification_email = models.CharField(max_length=255)
    currency_code = models.CharField(max_length=10)
    currency_symbol = models.CharField(max_length=1)