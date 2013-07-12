#!/usr/bin/env bash

#Installing Python 2.7.5 on Elastix 1.6
wget http://python.org/ftp/python/2.7.5/Python-2.7.5.tar.bz2
tar xf Python-2.7.5.tar.bz2
cd Python-2.7.5
./configure --prefix=/usr/local
make && make altinstall

#Installing Distribute
wget http://pypi.python.org/packages/source/d/distribute/distribute-0.6.35.tar.gz
tar xf distribute-0.6.35.tar.gz
cd distribute-0.6.35
python2.7 setup.py install

#Installing virtualenv and pip
easy_install virtualenv pip

#Creating virtualenv directory and installation paths
mkdir /opt/NEXTOR/tarificador && /opt/NEXTOR/tarificador
virtualenv env
source env/bin/activate

#Installing django
pip install django
