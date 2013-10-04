%define modname mangoanalytics
Summary: mango
Name: %{modname}
Version: 1.0.2
Release: 1
License: GPLv2
Group: Applications/System
Source0: mango-analytics.tar.gz
BuildRoot: %{_tmppath}/%{name}-%{version}-root
BuildArch: noarch
BuildRequires: mysql-devel
#Requires: mysql-devel, elastix-python2.7-virtualenv >= 1.10.1-1
#PreReq: mysql-devel, elastix-python2.7-virtualenv >= 1.10.1-1
Autoreq: 0 

%description
Mango Analytics, a cost reporting tool for Elastix PBX, by NEXTOR Telecom Mexico.

%prep

%setup -n mango-analytics

%clean
rm -rf $RPM_BUILD_ROOT

%install
mkdir -p $RPM_BUILD_ROOT/opt/NEXTOR/tarificador/django-tarificador
cp -R tarificador $RPM_BUILD_ROOT/opt/NEXTOR/tarificador/django-tarificador/tarificador
cp -R tools $RPM_BUILD_ROOT/opt/NEXTOR/tarificador/django-tarificador/tools
cp README.md $RPM_BUILD_ROOT/opt/NEXTOR/tarificador/django-tarificador/

mkdir -p $RPM_BUILD_ROOT/var/www/html
cp -u mangoanalytics_wrapper.php $RPM_BUILD_ROOT/var/www/html/

%pre

%post

/usr/local/bin/virtualenv /opt/NEXTOR/tarificador

#yum -y install mysql-devel

mkdir -p /var/log/mangoanalytics

elastix-menumerge /opt/NEXTOR/tarificador/django-tarificador/tarificador/elastix/elastix_menu.xml

source /opt/NEXTOR/tarificador/bin/activate && pip install /opt/NEXTOR/tarificador/django-tarificador/tools/six-1.4.1.tar.gz

source /opt/NEXTOR/tarificador/bin/activate && pip install /opt/NEXTOR/tarificador/django-tarificador/tools/Django-1.5.4.tar.gz

source /opt/NEXTOR/tarificador/bin/activate && pip install /opt/NEXTOR/tarificador/django-tarificador/tools/MySQL-python-1.2.4.zip

source /opt/NEXTOR/tarificador/bin/activate && pip install /opt/NEXTOR/tarificador/django-tarificador/tools/python-dateutil-2.1.tar.gz

source /opt/NEXTOR/tarificador/bin/activate && pip install /opt/NEXTOR/tarificador/django-tarificador/tools/Envelopes-0.3.tar.gz

source /opt/NEXTOR/tarificador/bin/activate && pip install /opt/NEXTOR/tarificador/django-tarificador/tools/django-wsgiserver-0.8.0rc1.tar.gz

source /opt/NEXTOR/tarificador/bin/activate && python /opt/NEXTOR/tarificador/django-tarificador/tools/initialMySQLSetup.py

source /opt/NEXTOR/tarificador/bin/activate && python /opt/NEXTOR/tarificador/django-tarificador/tarificador/manage.py syncdb --noinput
source /opt/NEXTOR/tarificador/bin/activate && python /opt/NEXTOR/tarificador/django-tarificador/tarificador/manage.py collectstatic --noinput

source /opt/NEXTOR/tarificador/bin/activate && python /opt/NEXTOR/tarificador/django-tarificador/tarificador/manage.py runwsgiserver port=8123 daemonize=true pidfile=/var/run/django-cpwsgi.pid host=0.0.0.0 workdir=/opt/NEXTOR/tarificador/django-tarificador/tarificador server_user=asterisk server_group=asterisk

echo "source /opt/NEXTOR/tarificador/bin/activate && python /opt/NEXTOR/tarificador/django-tarificador/tarificador/manage.py runwsgiserver port=8123 daemonize=true pidfile=/var/run/django-cpwsgi.pid host=0.0.0.0 workdir=/opt/NEXTOR/tarificador/django-tarificador/tarificador server_user=asterisk server_group=asterisk
" >> /etc/rc.d/rc.local
echo "0 2 * * * source /opt/NEXTOR/tarificador/bin/activate && python /opt/NEXTOR/tarificador/django-tarificador/tarificador/tarifica/tools/dailyImporter.py > /var/log/mangoanalytics/daily.log" >> /var/spool/cron/root

echo "Install finished."

%preun
if [ $1 -eq 0 ] ; then # Validation for desinstall this rpm
	echo "Delete example menus"
	elastix-menuremove "%{modname}"
fi

%files
/opt/*
/var/www/html/*

%changelog
* Mon Sep 9 2013 Alfonso Lizarraga <alfonso@nextortelecom.com>
−
Initial version.
