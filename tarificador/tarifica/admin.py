from django.contrib import admin
from tarifica.models import *

admin.site.register(Provider)
admin.site.register(PaymentType)
admin.site.register(TariffMode)
admin.site.register(DestinationGroup)
admin.site.register(DestinationName)
admin.site.register(DestinationCountry)
admin.site.register(ProviderDailyDetail)
admin.site.register(ProviderDestinationDetail)
admin.site.register(UserDailyDetail)
