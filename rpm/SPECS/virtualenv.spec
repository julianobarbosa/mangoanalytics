%define modname elastix-python2.7-virtualenv
Summary: Virtualenv 1.10.1 packaged for Elastix 2.4
Name: elastix-python2.7-virtualenv
Version: 1.10.1
Release: 1
License: MIT
Group: Applications/System
Source0: virtualenv-1.10.1.tar.gz
BuildRoot: %{_tmppath}/%{name}-%{version}-root
BuildArch: i386
Autoreq: 0 
#PreReq: elastix-python2.7-distribute
#Requires: elastix-python2.7-distribute

%description
Virtualenv, a tool to create isolated Python environments.

%prep

%clean

%install
easy_install-2.7 --install-dir=$RPM_BUILD_ROOT/usr/local/bin virtualenv
#rm -rf /usr/local/lib/python2.7/site-packages/site.pyc
#rm -rf /usr/local/lib/python2.7/site-packages/site.pyo
#rm -rf $RPM_BUILD_ROOT/usr/local/lib/python2.7/site-packages/site.pyc

%pre
rm -rf /usr/local/lib/python2.7/site-packages/site.pyc
rm -rf /usr/local/lib/python2.7/site-packages/site.pyo

%post

%files
/usr/local/bin/*

%changelog
* Mon Sep 9 2013 Alfonso Lizarraga <alfonso@nextortelecom.com>
−
Initial version.
