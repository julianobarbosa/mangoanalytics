%define modname elastix-python2.7-virtualenv
Summary: Virtualenv 1.10.1 packaged for Elastix 2.4
Name: elastix-python2.7-virtualenv
Version: 1.10.1
Release: 1
License: MIT
Group: Applications/System
Source0: virtualenv-1.10.1.tar.gz
BuildRoot: %{_tmppath}/%{name}-%{version}-root
BuildArch: x86_64
Autoreq: 0 
PreReq: elastix-python2.7-setuptools-1.1.6-1
Requires: elastix-python2.7-setuptools-1.1.6-1

%description
Virtualenv, a tool to create isolated Python environments.

%prep

%clean

%install
mkdir -p /root/rpm/tmp/elastix-python2.7-virtualenv-1.10.1-root/usr/local/lib/python2.7/site-packages
easy_install-2.7 --prefix=$RPM_BUILD_ROOT/usr/local virtualenv==1.10.1

%pre

%post

%files
/usr/local/*

%changelog
* Mon Sep 9 2013 Alfonso Lizarraga <alfonso@nextortelecom.com>
−
Initial version.
