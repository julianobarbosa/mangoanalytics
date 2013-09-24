Summary: Setuptools 1.1.6 packaged for Elastix 2.4
Name: elastix-python2.7-setuptools
Version: 1.1.6
Release: 1
License: GPL
Group: Applications/System
Source0: setuptools-1.1.6.tar.gz
BuildRoot: /home/rpm/%{name}-%{version}-root
BuildArch: i386
Autoreq: 0
#Prereq: elastix-python2.7.5-alternate-2.7.5-1
#Requires: elastix-python2.7.5-alternate-2.7.5-1

%description
Easy Install is a python module (easy_install) bundled with setuptools that lets you automatically download, build, install, and manage Python packages.

%prep

%setup -n setuptools-1.1.6

%install
rm -rf $RPM_BUILD_ROOT
mkdir -p /home/rpm/elastix-python2.7-setuptools-1.1.6-root/usr/local/lib/python2.7/site-packages/
python2.7 setup.py install --prefix=$RPM_BUILD_ROOT/usr/local

%post

%clean
rm -rf $RPM_BUILD_ROOT

%files
/usr/local/*

%changelog
* Sat Sep 22 2013 Alfonso Lizarraga Santos <alfonso@nextortelecom.com>
−
Initial version.


