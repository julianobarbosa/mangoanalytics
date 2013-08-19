from django.conf.urls import patterns, url
from tarifica.views import bundles, destinationGroups, general, providers, trunks, users, wizard, config, pinsets

urlpatterns = patterns('',
   url(r'^$', general.setup, name = 'setup'),
   url(r'^setup$', general.setup, name = 'setup'),
   
   url(r'^config$', config.config, name = 'config'),
   url(r'^config/initial$', config.initial, name = "config_initial"),
   url(r'^config/update/(?P<option>\w+)$', config.updateUser, name = 'config_update_user'),

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
   url(r'^trunks/(?P<period_id>\w+)$', trunks.general, name = 'trunks_period'),
   url(r'^trunks/get/(?P<provider_id>\d+)$', trunks.getTrunk, name = 'trunks_get'),
   url(r'^trunks/get/(?P<provider_id>\d+)/(?P<period_id>\w+)$', trunks.getTrunk, name = 'trunks_get_period'),
   url(r'^trunks/download/(?P<provider_id>\d+)/(?P<start_date>[A-Za-z0-9_\-]+)/(?P<end_date>[A-Za-z0-9_\-]+)$', trunks.downloadTrunkCDR, name = 'trunks_download_cdr'),

   url(r'^realtime$', general.realtime, name = 'realtime'),

   url(r'^dashboard$', general.dashboard, name = 'dashboard'),

   url(r'^users/general$', users.generalUsers, name = 'users_general'),
   url(r'^users/general/(?P<period_id>\w+)$', users.generalUsers, name = 'users_general_period'),
   url(r'^users/detail/(?P<extension_id>\d+)$', users.detailUsers, name = 'users_detail'),
   url(r'^users/detail/(?P<extension_id>\d+)/(?P<period_id>\w+)$', users.detailUsers, name = 'users_detail_period'),
   url(r'^users/analytics/(?P<extension_id>\d+)$', users.analyticsUsers, name = 'users_analytics'),
   url(r'^users/analytics/(?P<extension_id>\d+)/(?P<period_id>\w+)$', users.analyticsUsers, name = 'users_analytics_period'),

   url(r'^wizard/start$', wizard.start, name = "wizard_start"),
   url(r'^wizard/testRun$', wizard.testrun, name = "wizard_test_run"),
   url(r'^wizard/checkTestRunStatus$', wizard.checkTestRunStatus, name = "wizard_check_test_run_status"),
   url(r'^wizard/results$', wizard.results, name = "wizard_results"),
   url(r'^wizard/run$', wizard.run, name = "wizard_run"),
   url(r'^wizard/checkProcessingStatus$', wizard.checkProcessingStatus, name = "wizard_check_processing_status"),

   url(r'^pinsets/general$', pinsets.generalPinsets, name = 'pinsets_general'),
   url(r'^pinsets/general/(?P<period_id>\w+)$', pinsets.generalPinsets, name = 'pinsets_general_period'),
   url(r'^pinsets/detail/(?P<extension_id>\d+)$',pinsets.detailPinsets, name = 'pinsets_detail'),
   url(r'^pinsets/detail/(?P<extension_id>\d+)/(?P<period_id>\w+)$', pinsets.detailPinsets, name = 'pinsets_detail_period'),
   url(r'^pinsets/analytics/(?P<extension_id>\d+)$', pinsets.analyticsPinsets, name = 'pinsets_analytics'),
   url(r'^pinsets/analytics/(?P<extension_id>\d+)/(?P<period_id>\w+)$', pinsets.analyticsPinsets, name = 'pinsets_analytics_period'),
)