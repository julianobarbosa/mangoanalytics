from django.core.management import setup_environ
from tarificador import settings
from tarifica.models import *

setup_environ(settings)

