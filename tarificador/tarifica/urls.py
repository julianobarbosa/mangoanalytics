from django.conf.urls import patterns, url
from tarifica import views

urlpatterns = patterns('',
   url(r'^setup)$', views.setupAddProviderInfo, name = 'setup'),

   url(r'^providers/create/(?P<asterisk_id>\d+)$', views.createProvider, name = 'providers_create'),
   url(r'^providers/update/(?P<provider_id>\d+)$', views.updateProvider, name = 'providers_update'),
   url(r'^providers/delete/(?P<provider_id>\d+)$', views.deleteProvider, name = 'providers_delete'),
   url(r'^providers/(?P<provider_id>\d+)$', views.getProvider, name = 'providers_get'),
   
   url(r'^destinations/create/(?P<provider_id>\d+)$', views.createDestinationGroup, name = 'destinations_create'),
   url(r'^destinations/update/(?P<destination_group_id>\d+)$', views.updateDestinationGroup, name = 'destinations_update'),
   url(r'^destinations/provider/(?P<provider_id>\d+)$', views.getDestinationGroup, name = 'destinations_provider_get'),
   url(r'^destinations/delete/(?P<destination_group_id>\d+)$', views.deleteDestinationGroup, name = 'destinations_delete'),
   
   url(r'^bundles/create/(?P<destination_group_id>\d+)$', views.createBundle, name = 'bundles_create'),
   url(r'^bundles/update/(?P<bundle_id>\d+)$', views.updateBundle, name = 'bundles_update'),
   url(r'^bundles/provider/(?P<provider_id>\d+)$', views.getBundle, name = 'bundles_provider_get'),
   url(r'^bundles/delete/(?P<bundle_id>\d+)$', views.deleteBundle, name = 'bundles_delete'),

   url(r'^trunks$', views.trunks, name = 'trunks'),

   url(r'^realtime$', views.realtime, name = 'realtime'),

   url(r'^dashboard$', views.dashboard, name = 'dashboard'),

   url(r'^users/general$', views.generalUsers, name = 'users_general'),
   url(r'^users/detail/(?P<extension_id>\d+$)', views.detailUsers, name = 'users_detail'),
   url(r'^users/analitics/(?P<extension_id>\d+$)', views.analiticsUsers, name = 'users_analitics'),
)