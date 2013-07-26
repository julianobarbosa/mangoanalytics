from django.db import models

# Create your models here.
class PaymentType(models.Model):
    name = models.CharField(max_length = 255, default="Pospago")

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
    provider_type = models.CharField(max_length = 50, blank=True)
    payment_type = models.ForeignKey(PaymentType, blank=True, null=True)
    channels = models.IntegerField(blank=True, default=0)
    period_end = models.IntegerField(default=0)
    is_configured = models.BooleanField(default=False)
    has_bundles = models.BooleanField(default=False)
    def __unicode__(self):
        return self.asterisk_name

class DestinationGroup(models.Model):
    name = models.CharField(max_length = 255)

class Bundles(models.Model):
    name = models.CharField(max_length = 255)
    provider = models.ForeignKey(Provider, blank=True, null=True)
    destination_group = models.ForeignKey(DestinationGroup, blank=True, null=True)
    tariff_mode = models.ForeignKey(TariffMode, blank=True, null=True)
    cost = models.FloatField()
    usage = models.IntegerField(blank=True, null=True)
    amount = models.IntegerField()
    priority = models.IntegerField()

class BaseTariff(models.Model):
    provider = models.ForeignKey(Provider, blank=True, null=True)
    cost = models.FloatField()
    mode = models.ForeignKey(TariffMode, blank=True, null=True)
    prefix = models.CharField(max_length = 255, blank=True)
    matching_number = models.CharField(max_length = 255, blank=True)
    destination_group = models.ForeignKey(DestinationGroup, blank=True, null=True)

class Calls(models.Model):
    dialed_number = models.CharField(max_length = 255)
    extension_number = models.CharField(max_length = 255)
    duration = models.FloatField()
    cost = models.FloatField()
    date = models.DateField()
    destination_group = models.ForeignKey(DestinationGroup, blank=True, null=True)

class Extension(models.Model):
    extension_number = models.CharField(max_length = 255)
    name = models.CharField(max_length = 255)
    calls = models.ForeignKey(Calls, blank=True, null=True)

class UserDailyDetail(models.Model):
    extension = models.ForeignKey(Extension, blank=True, null=True)
    total_calls = models.IntegerField()
    total_minutes = models.FloatField()
    cost = models.FloatField()
    date = models.DateField()

class UserDestinationDetail(models.Model):
    extension = models.ForeignKey(Extension, blank=True, null=True)
    total_calls = models.IntegerField()
    total_minutes = models.FloatField()
    cost = models.FloatField()
    destination_group = models.ForeignKey(DestinationGroup, blank=True, null=True)
    date = models.DateField()

class UserDestinationNumberDetail(models.Model):
    extension = models.ForeignKey(Extension, blank=True, null=True)
    total_calls = models.IntegerField()
    total_minutes = models.FloatField()
    cost = models.FloatField()
    prefix = models.CharField(max_length = 255)
    number = models.IntegerField()

class ProviderDailyDetail(models.Model):
    provider = models.ForeignKey(Provider, blank=True, null=True)
    cost = models.FloatField()
    total_calls = models.IntegerField()
    total_minutes = models.FloatField()
    date = models.DateField()

class ProviderDestinationDetail(models.Model):
    provider = models.ForeignKey(Provider, blank=True, null=True)
    cost = models.FloatField()
    total_calls = models.IntegerField()
    total_minutes = models.FloatField()
    destination_group = models.ForeignKey(DestinationGroup, blank=True, null=True)
    date = models.DateField()

class UserInformation(models.Model):
    first_time_user = models.BooleanField(default=True)