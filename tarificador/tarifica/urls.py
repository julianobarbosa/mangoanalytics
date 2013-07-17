from django.conf.urls import patterns, url
from tarifica import views

urlpatterns = patterns('',
                       url(r'setuptroncales$', views.setupAddProviderInfo, name = 'Agregar informacion de troncal'),
                       url(r'setuptarifabase$', views.setupAddBaseTariffs, name = 'Agregar las tarifas base'),
                       url(r'setuppaquetes$', views.setupAddBundles, name = 'Agregar paquetes'),
                       url(r'thanks$', views.thanks, name = 'gracias'),
                       url(r'contact$',views.thanks, name = 'contacto'),
                       url(r'dashboardtroncales$', views.dashboardTrunks, name = 'Dashboard Troncales')
)