from django.conf.urls import patterns, url
from tarifica import views

urlpatterns = patterns('',
   url(r'^setuptroncales/(?P<name>\w+)$', views.setupAddProviderInfo, name = 'Agregar informacion de troncal'),
   url(r'^setuptarifabase/(?P<name>\w+)$', views.setupAddBaseTariffs, name = 'Agregar las tarifas base'),
   url(r'^setuppaquetes/(?P<name>\w+)$', views.setupAddBundles, name = 'Agregar paquetes'),
   url(r'^thanks$', views.thanks, name = 'gracias'),
   url(r'^contact$',views.thanks, name = 'contacto'),
   url(r'^dashboardtroncales$', views.dashboardTrunks, name = 'Dashboard Troncales')
)