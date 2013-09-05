source /opt/NEXTOR/tarificador/bin/activate
python ./tools/initialMySQLSetup.py

mkdir /opt/NEXTOR/tarificador/django-tarificador
cp -R tarificador /opt/NEXTOR/tarificador/django-tarificador/tarificador
python /opt/NEXTOR/tarificador/django-tarificador/tarificador/manage.py syncdb --noinput
python /opt/NEXTOR/tarificador/django-tarificador/tarificador/manage.py collectstatic
python /opt/NEXTOR/tarificador/django-tarificador/tarificador/serve.py > /dev/null &

#Adding cron job...
echo "0 2 * * * source /opt/NEXTOR/tarificador/bin/activate && python /opt/NEXTOR/tarificador/django-tarificador/tarificador/tarifica/tools/importer.py > /dev/null" >> /var/spool/cron/root
echo "Install finished."