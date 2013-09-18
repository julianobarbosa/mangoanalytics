# #!/usr/bin/env bash

# #Installing development tools
# yum groupinstall -y "Development tools" 
# yum install -y zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel mysql-devel git
    
# #Installing Python 2.7.5 on Elastix 2.4
# wget http://python.org/ftp/python/2.7.5/Python-2.7.5.tar.bz2
# tar xf Python-2.7.5.tar.bz2
# cd Python-2.7.5
# ./configure --prefix=/usr/local
# make && make altinstall

# #Installing Distribute
# wget http://pypi.python.org/packages/source/d/distribute/distribute-0.6.49.tar.gz --no-check-certificate
# tar xf distribute-0.6.49.tar.gz
# cd distribute-0.6.49
# python2.7 setup.py install

# #Installing virtualenv and pip
# easy_install-2.7 virtualenv

# #Creating virtualenv directory and installation paths
# mkdir /opt/NEXTOR
# virtualenv /opt/NEXTOR/tarificador
# source /opt/NEXTOR/tarificador/bin/activate

# #Installing django
# pip install django==1.5.1 MySQL-python==1.2.4 python-dateutil==2.1 cherrypy==3.2.4 envelopes==0.3 six==1.3.0 python-daemon==1.6
# source /opt/NEXTOR/tarificador/bin/activate && python tools/initialMySQLSetup.py

# mkdir -p /var/log/mangoanalytics
# touch /var/log/mangoanalytics/server.log 
# touch /var/log/mangoanalytics/error.log
# touch /var/log/mangoanalytics/daily.log

# mkdir /opt/NEXTOR/tarificador/django-tarificador

# cp -R tarificador /opt/NEXTOR/tarificador/django-tarificador/tarificador
# cp -u mangoanalytics_wrapper.php /var/www/h1tml/
# source /opt/NEXTOR/tarificador/bin/activate && python /opt/NEXTOR/tarificador/django-tarificador/tarificador/manage.py syncdb --noinput
# source /opt/NEXTOR/tarificador/bin/activate && python /opt/NEXTOR/tarificador/django-tarificador/tarificador/manage.py collectstatic --noinput
# source /opt/NEXTOR/tarificador/bin/activate && python /opt/NEXTOR/tarificador/django-tarificador/tarificador/serve.py > /var/log/mangoanalytics/server.log &2> /var/log/mangoanalytics/error.log &

# #Adding cron job...
# echo "source /opt/NEXTOR/tarificador/bin/activate && python /opt/NEXTOR/tarificador/django-tarificador/tarificador/serve.py start" >> /etc/rc.d/rc.local
# echo "0 2 * * * source /opt/NEXTOR/tarificador/bin/activate && python /opt/NEXTOR/tarificador/django-tarificador/tarificador/tarifica/tools/dailyImporter.py > /var/log/mangoanalytics/daily.log" >> /var/spool/cron/root
# echo "Install finished."

#New stuff: install python2.7, distribute and virtualenv rpms.
rpm -ivh --replacepkgs tarificador/RPM/python27-1.0.1-1.noarch.rpm
rpm -ivh --replacepkgs --replacefiles tarificador/RPM/distribute-0.6.49-1.noarch.rpm
rpm -ivh --replacepkgs --replacefiles tarificador/RPM/virtualenv-1.0.2-1.noarch.rpm