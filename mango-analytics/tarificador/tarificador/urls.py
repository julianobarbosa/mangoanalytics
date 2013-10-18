from django.conf.urls import patterns, include, url

# Uncomment the next two lines to enable the admin:
from django.contrib import admin
admin.autodiscover()

urlpatterns = patterns('',
    # Examples:
    # url(r'^$', 'tarificador.views.home', name='home'),
    # url(r'^tarificador/', include('tarificador.foo.urls')),

    # Uncomment the admin/doc line below to enable admin documentation:
    # url(r'^admin/doc/', include('django.contrib.admindocs.urls')),

    # Uncomment the next line to enable the admin:
    # url(r'^accounts/', include('accounts.urls',namespace="accounts")),
    url(r'^', include('tarifica.urls',namespace="tarifica")),
    url(r'^users/', include(admin.site.urls)),
)
