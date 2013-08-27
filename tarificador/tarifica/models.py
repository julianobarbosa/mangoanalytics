from django.db import models
from tarifica.django_countries.fields import CountryField

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
    prefix = models.CharField(max_length = 255, blank=True, default="")
    notes = models.TextField(null=True, blank=True)
    connection_fee = models.FloatField()
    minute_fee = models.FloatField(default=60)
    billing_interval = models.IntegerField()
    destination_name = models.ForeignKey(DestinationName, blank=True, null=True)
    destination_country = CountryField(max_length = 6)
    has_bundles = models.BooleanField(default=False)
    def __unicode__(self):
        return self.provider.name+'-'+self.destination_name.name

class Bundle(models.Model):
    name = models.CharField(max_length = 255)
    destination_group = models.ForeignKey(DestinationGroup, blank=True, null=True)
    tariff_mode = models.ForeignKey(TariffMode, blank=True, null=True)
    cost = models.FloatField()
    usage = models.IntegerField(blank=True, null=True)
    amount = models.IntegerField()
    priority = models.IntegerField()
    is_active = models.BooleanField(default=True)
    start_date = models.DateField()
    end_date = models.DateField()

class Call(models.Model):
    dialed_number = models.CharField(max_length = 255)
    extension_number = models.CharField(max_length = 255)
    pinset_number = models.CharField(max_length = 255)
    asterisk_unique_id = models.CharField(max_length = 255)
    duration = models.IntegerField()
    cost = models.FloatField()
    date = models.DateTimeField()
    destination_group = models.ForeignKey(DestinationGroup, blank=True, null=True)
    provider = models.ForeignKey(Provider, blank=True, null=True)

class Pinset(models.Model):
    pinset_number = models.CharField(max_length = 255)

class Extension(models.Model):
    extension_number = models.CharField(max_length = 255)
    name = models.CharField(max_length = 255)

class UserDailyDetail(models.Model):
    extension = models.ForeignKey(Extension, blank=True, null=True)
    total_calls = models.IntegerField()
    total_seconds = models.IntegerField()
    cost = models.FloatField()
    date = models.DateField()

class UserDestinationDetail(models.Model):
    extension = models.ForeignKey(Extension, blank=True, null=True)
    total_calls = models.IntegerField()
    total_seconds = models.IntegerField()
    cost = models.FloatField()
    destination_group = models.ForeignKey(DestinationGroup, blank=True, null=True)
    date = models.DateField()

class UserDestinationNumberDetail(models.Model):
    extension = models.ForeignKey(Extension, blank=True, null=True)
    total_calls = models.IntegerField()
    total_seconds = models.IntegerField()
    cost = models.FloatField()
    prefix = models.CharField(max_length = 255)
    number = models.CharField(max_length = 255)
    date = models.DateField()

class ProviderDailyDetail(models.Model):
    provider = models.ForeignKey(Provider, blank=True, null=True)
    cost = models.FloatField()
    total_calls = models.IntegerField()
    total_seconds = models.IntegerField()
    date = models.DateField()

class ProviderDestinationDetail(models.Model):
    provider = models.ForeignKey(Provider, blank=True, null=True)
    cost = models.FloatField()
    total_calls = models.IntegerField()
    total_seconds = models.IntegerField()
    destination_group = models.ForeignKey(DestinationGroup, blank=True, null=True)
    date = models.DateField()

class PinsetDailyDetail(models.Model):
    pinset = models.ForeignKey(Pinset, blank=True, null=True)
    total_calls = models.IntegerField()
    total_seconds = models.IntegerField()
    cost = models.FloatField()
    date = models.DateField()

class PinsetDestinationDetail(models.Model):
    pinset = models.ForeignKey(Pinset, blank=True, null=True)
    total_calls = models.IntegerField()
    total_seconds = models.IntegerField()
    cost = models.FloatField()
    destination_group = models.ForeignKey(DestinationGroup, blank=True, null=True)
    date = models.DateField()

class PinsetDestinationNumberDetail(models.Model):
    pinset = models.ForeignKey(Pinset, blank=True, null=True)
    total_calls = models.IntegerField()
    total_seconds = models.IntegerField()
    cost = models.FloatField()
    prefix = models.CharField(max_length = 255)
    number = models.CharField(max_length = 255)
    date = models.DateField()

class UserInformation(models.Model):
    first_time_user = models.BooleanField(default=True)
    first_import_started = models.DateTimeField(blank=True, null=True)
    is_first_import_finished = models.BooleanField(default=False)
    test_run_in_progress = models.BooleanField(default=False)
    processing_in_progress = models.BooleanField(default=False)
    trunks_configured = models.BooleanField(default=False)
    base_tariffs_configured = models.BooleanField(default=False)
    bundles_configured = models.BooleanField(default=False)
    country = CountryField(max_length = 6)
    bussiness_name = models.CharField(max_length=255)
    contact_first_name = models.CharField(max_length=255)
    contact_last_name = models.CharField(max_length=255)
    notification_email = models.CharField(max_length=255)
    currency_code = models.CharField(max_length=10)
    currency_symbol = models.CharField(max_length=1)

class UnconfiguredCall(models.Model):
    dialed_number = models.CharField(max_length = 255)
    extension_number = models.CharField(max_length = 255)
    pinset_number = models.CharField(max_length = 255)
    asterisk_unique_id = models.CharField(max_length = 255)
    duration = models.IntegerField()
    provider = models.CharField(max_length = 255)
    date = models.DateTimeField()

class ImportResults(models.Model):
    calls_saved = models.IntegerField()
    calls_not_saved = models.IntegerField()

class CDRFilter(models.Model):
    comparison = models.CharField(max_length=10)
    field_name = models.CharField(max_length=50)
    value = models.CharField(max_length=255)
    extras = models.CharField(max_length=10, null=True, blank=True)