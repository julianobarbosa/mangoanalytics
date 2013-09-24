Summary: Python 2.7.5 packaged for Elastix 2.4
Name: elastix-python2.7.5-alternate
Version: 2.7.5
Release: 1
License: GPL
Group: Applications/System
Source0: Python-2.7.5.tar.bz2
BuildRoot: %{_tmppath}/%{name}-%{version}-root
BuildArch: x86_64
BuildRequires: zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel mysql-devel
Autoreq: 0

%description
Python Programming Language version 2.7.5, compiled for Elastix 2.4 on /usr/local.
This package is design to work alongside default Python 2.4 installation.

To use, just run 'python2.7' to enter the interactive console.

%prep

%setup -n Python-2.7.5

%install
rm -rf $RPM_BUILD_ROOT
./configure --prefix=/usr/local
make && make altinstall	DESTDIR=$RPM_BUILD_ROOT

%post

%clean
rm -rf $RPM_BUILD_ROOT

%files
/usr/local/*

%changelog
* Sat Sep 22 2013 Alfonso Lizarraga Santos <alfonso@nextortelecom.com>
−
Initial version.


