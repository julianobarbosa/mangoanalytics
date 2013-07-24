from django.contrib import admin
from tarifica.models import Provider, PaymentType, TariffMode, BaseTariff, DestinationGroup, ProviderDailyDetail

admin.site.register(Provider)
admin.site.register(PaymentType)
admin.site.register(TariffMode)
admin.site.register(BaseTariff)
admin.site.register(DestinationGroup)
admin.site.register(ProviderDailyDetail)
