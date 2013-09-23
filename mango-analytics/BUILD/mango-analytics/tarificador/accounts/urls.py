from django.conf.urls import patterns, url

from accounts import views

urlpatterns = patterns('',
	url(r'login$', views.index, name='login'),
	url(r'login/log$', views.log, name='log'),
	url(r'login/logged/lo$', views.details, name='lo'),
)
