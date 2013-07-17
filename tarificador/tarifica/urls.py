from django.conf.urls import patterns, url
from tarifica import views

urlpatterns = patterns('',
   url(r'^setuptroncales/(?P<asterisk_id>\d+)$', views.setupAddProviderInfo, name = 'setuptroncales'),
   url(r'^setuptarifabase/(?P<asterisk_id>\d+)$', views.setupAddBaseTariffs, name = 'setuptarifabase'),
   url(r'^setuppaquetes/(?P<asterisk_id>\d+)$', views.setupAddBundles, name = 'setuppaquetes'),
   url(r'^thanks$', views.thanks, name = 'gracias'),
   url(r'^contact$',views.thanks, name = 'contacto'),
   url(r'^dashboardtroncales$', views.dashboardTrunks, name = 'dashboardtroncales')
)