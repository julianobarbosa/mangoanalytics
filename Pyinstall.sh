#!/usr/bin/env bash

#Installing development tools
yum groupinstall -y "Development tools" 
yum install -y zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel mysql-devel git
    
#Installing Python 2.7.5 on Elastix 2.4
wget http://python.org/ftp/python/2.7.5/Python-2.7.5.tar.bz2
tar xf Python-2.7.5.tar.bz2
cd Python-2.7.5
./configure --prefix=/usr/local
make && make altinstall

#Installing Distribute
wget http://pypi.python.org/packages/source/d/distribute/distribute-0.6.49.tar.gz --no-check-certificate
tar xf distribute-0.6.49.tar.gz
cd distribute-0.6.49
python2.7 setup.py install

#Installing virtualenv and pip
easy_install-2.7 virtualenv

#Creating virtualenv directory and installation paths
mkdir /opt/NEXTOR
virtualenv /opt/NEXTOR/tarificador
source /opt/NEXTOR/tarificador/bin/activate

#Installing django
pip install django MySQL-python
python tools/initialMySQLSetup.py

mkdir /opt/NEXTOR/tarificador/django-tarificador
cp -R src/* /opt/NEXTOR/tarificador/django-tarificador/
python /opt/NEXTOR/tarificador/django-tarificador/tarificador/manage.py syncdb --noinput
python /opt/NEXTOR/tarificador/django-tarificador/tarificador/manage.py runserver 0.0.0.0:8000