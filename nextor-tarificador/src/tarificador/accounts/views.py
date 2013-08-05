# Create your views here.
from django.http import HttpResponse
from django.template import RequestContext, loader
from django.shortcuts import render
from django.contrib.auth import authenticate, login
from django.contrib.auth.decorators import login_required



def index(request):
	#template=loader.get_template('accounts/login.html')
	return render(request, 'accounts/login.html')


def log(request):
	username = request.POST['username']
	password = request.POST['password']
	user = authenticate(username=username, password=password)
	if user is not None:
		login(request,user)
		return render(request, 'accounts/logged.html')
	else:
		return render(request, 'accounts/notlogged.html')



@login_required(login_url='accounts/login')
def details(request):
	return HttpResponse("esta pagina solo la deben ver usuarios loggeados")


