Summary: Virtualenv 1.10.1 packaged for Elastix 2.4
Name: elastix-python2.7-virtualenv
Version: 1.10.1
Release: 1
License: MIT
Group: Applications/System
Source0: virtualenv-1.10.1.tar.gz
BuildRoot: /home/rpm/%{name}-%{version}-root
BuildArch: x86_64
Autoreq: 0

%description
virtualenv is a tool to create isolated Python environments.

%prep

%install
rm -rf $RPM_BUILD_ROOT
mkdir -p /home/rpm/elastix-python2.7-virtualenv-1.10.1-root/usr/local/lib/python2.7/site-packages
easy_install-2.7 --prefix=$RPM_BUILD_ROOT/usr/local virtualenv==1.10.1

%post

%clean
rm -rf $RPM_BUILD_ROOT

%files
/usr/local/*

%changelog
* Sat Sep 22 2013 Alfonso Lizarraga Santos <alfonso@nextortelecom.com>
−
Initial version.


