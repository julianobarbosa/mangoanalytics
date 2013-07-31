from django.conf.urls import patterns, url
from tarifica.views import bundles, destinationGroups, general, providers, trunks, users, start

urlpatterns = patterns('',
   url(r'^setup$', general.setup, name = 'setup'),

   url(r'^providers/create/(?P<asterisk_id>\d+)$', providers.createProvider, name = 'providers_create'),
   url(r'^providers/update/(?P<provider_id>\d+)$', providers.updateProvider, name = 'providers_update'),
   url(r'^providers/delete/(?P<provider_id>\d+)$', providers.deleteProvider, name = 'providers_delete'),
   url(r'^providers/(?P<provider_id>\d+)$', providers.getProvider, name = 'providers_get'),
   
   url(r'^destinations/create/(?P<provider_id>\d+)$', destinationGroups.createDestinationGroup, name = 'destinations_create'),
   url(r'^destinations/update/(?P<destination_group_id>\d+)$', destinationGroups.updateDestinationGroup, name = 'destinations_update'),
   url(r'^destinations/delete/(?P<destination_group_id>\d+)$', destinationGroups.deleteDestinationGroup, name = 'destinations_delete'),
   
   url(r'^bundles/create/(?P<destination_group_id>\d+)$', bundles.createBundle, name = 'bundles_create'),
   url(r'^bundles/update/(?P<bundle_id>\d+)$', bundles.updateBundle, name = 'bundles_update'),
   url(r'^bundles/delete/(?P<bundle_id>\d+)$', bundles.deleteBundle, name = 'bundles_delete'),

   url(r'^trunks$', trunks.general, name = 'trunks'),
   url(r'^trunks/(?P<period_id>\w+)$', trunks.general, name = 'trunks'),
   url(r'^trunks/get/(?P<trunk_id>\d+)$', trunks.getTrunk, name = 'trunks_get'),
   url(r'^trunks/get/(?P<trunk_id>\d+)/(?P<period_id>\w+)$', trunks.getTrunk, name = 'trunks_get'),
   url(r'^trunks/download/(?P<trunk_id>\d+)/(?P<period_id>\w+)$', trunks.downloadTrunkCDR, name = 'trunks_download_cdr'),

   url(r'^realtime$', general.realtime, name = 'realtime'),

   url(r'^dashboard$', general.dashboard, name = 'dashboard'),

   url(r'^users/general$', users.generalUsers, name = 'users_general'),
   url(r'^users/general/(?P<period_id>\w+)$', users.generalUsers, name = 'users_general_period'),
   url(r'^users/detail/(?P<extension_id>\d+)$', users.detailUsers, name = 'users_detail'),
   url(r'^users/detail/(?P<extension_id>\d+)/(?P<period_id>\w+)$', users.detailUsers, name = 'users_detail_period'),
   url(r'^users/analytics/(?P<extension_id>\d+)$', users.analyticsUsers, name = 'users_analytics'),
   url(r'^users/analytics/(?P<extension_id>\d+)/(?P<period_id>\w+)$', users.analyticsUsers, name = 'users_analytics_period'),

   url(r'^start/step1$', start.step1, name = "start_step1"),
   url(r'^start/step2$', start.step2, name = "start_step2"),
   url(r'^start/step3$', start.step3, name = "start_step3"),
   url(r'^start/check_processing_status$', start.checkProcessingStatus, name = "check_processing_status")
)