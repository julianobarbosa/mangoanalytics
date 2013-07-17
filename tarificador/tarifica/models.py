from django.db import models

# Create your models here.


class PaymentType(models.Model):
    name = models.CharField(max_length = 255, default="Pospago")


class DestinationGroup(models.Model):
    name = models.CharField(max_length = 255)
    prefix = models.CharField(max_length = 255, blank=True)
    matching_number = models.CharField(max_length = 255, blank=True)


class TariffMode(models.Model):
    name = models.CharField(max_length = 255)
    def __unicode__(self):
        return self.name


class BaseTariff(models.Model):
    cost = models.FloatField()
    mode = models.ForeignKey(TariffMode, blank=True, null=True)
    destination_group = models.ForeignKey(DestinationGroup, blank=True, null=True)


class Bundles(models.Model):
    name = models.CharField(max_length = 255)
    destination_group = models.ForeignKey(DestinationGroup, blank=True, null=True)
    tariff_mode = models.ForeignKey(TariffMode, blank=True, null=True)
    cost = models.FloatField()
    usage = models.IntegerField()
    amount = models.IntegerField()




class Provider(models.Model):
    asterisk_id = models.CharField(max_length = 255)
    asterisk_name = models.CharField(max_length = 255)
    name = models.CharField(max_length = 255)
    monthly_cost = models.FloatField(default=0)
    provider_type = models.CharField(max_length = 50, blank=True)
    payment_type = models.ForeignKey(PaymentType, blank=True, null=True)
    channels = models.IntegerField(blank=True, default=0)
    base_tariff = models.ForeignKey(BaseTariff, blank=True, null=True)
    bundles = models.ForeignKey(Bundles, blank=True, null=True)
    destination_group = models.ForeignKey(DestinationGroup, blank=True, null=True)
    period_end = models.IntegerField(default=0)
    is_configured = models.BooleanField(default=False)
    has_bundles = models.BooleanField(default=False)
    def __unicode__(self):
        return self.asterisk_name


class Calls(models.Model):
    dialed_number = models.IntegerField()
    origin_number = models.IntegerField()
    duration = models.FloatField()
    cost = models.FloatField()
    date = models.DateTimeField()



class Extension(models.Model):
    extension_number = models.IntegerField()
    name = models.CharField(max_length = 255)
    calls = models.ForeignKey(Calls, blank=True, null=True)


class UserDailyDetail(models.Model):
    extension = models.ForeignKey(Extension, blank=True, null=True)
    total_calls = models.IntegerField()
    total_minutes = models.FloatField()
    cost = models.FloatField()
    date = models.DateTimeField()


class UserDestinationDetail(models.Model):
    extension = models.ForeignKey(Extension, blank=True, null=True)
    total_calls = models.IntegerField()
    total_minutes = models.FloatField()
    cost = models.FloatField()
    destination_group = models.ForeignKey(DestinationGroup, blank=True, null=True)


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
    date = models.DateTimeField()


class ProviderDestinationDetail(models.Model):
    provider = models.ForeignKey(Provider, blank=True, null=True)
    cost = models.FloatField()
    total_calls = models.IntegerField()
    total_minutes = models.FloatField()
    destination_group = models.ForeignKey(DestinationGroup, blank=True, null=True)




