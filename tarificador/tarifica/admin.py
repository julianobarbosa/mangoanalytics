from django.contrib import admin
from tarifica.models import Provider, PaymentType, TariffMode

admin.site.register(Provider)
admin.site.register(PaymentType)
admin.site.register(TariffMode)
