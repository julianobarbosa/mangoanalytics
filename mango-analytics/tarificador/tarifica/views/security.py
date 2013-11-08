#Views for bundles
from django.contrib.auth import logout, authenticate, login
from django.contrib import messages
from django.shortcuts import render
from django.http import HttpResponseRedirect
from tarifica import forms
from django.contrib.auth.models import User
import sqlite3
from datetime import datetime

def logout_view(request):
    logout(request)
    return HttpResponseRedirect('/login')

def login_view(request):
    #Updating and importing elastix user information to mango
    #Extracting user info from acl.db
    con = None
    try:
        con = sqlite3.connect('/var/www/db/acl.db')
        cursor = con.cursor()
        cursor.execute('SELECT * FROM acl_user')
        data = cursor.fetchall()
        now = datetime.now()
        for d in data:
            try: 
                existing_user = User.objects.get(username = d[1])
                existing_user.password = d[3]
                existing_user.last_login = datetime.now()
                existing_user.save()
            except Exception:
                #User does not exist yet
                new_user = User.objects.create_user(str(d[1]))
                new_user.is_superuser = 1
                new_user.is_active = 1
                new_user.password = d[3]
                new_user.email = 'admin@test.com'
                new_user.is_staff = 1
                new_user.date_joined = datetime.now()
                new_user.last_login = datetime.now()
                new_user.save()

    except Exception as e:
        print "Error while obtaining elastix' users",e

    if request.method == 'POST':
        form = forms.loginForm(request.POST)
        if form.is_valid(): # All validation rules pass
            username = form.cleaned_data['username']
            password = form.cleaned_data['password']
            user = authenticate(username=username, password=password)
            if user is not None:
                if user.is_active:
                    login(request, user)
                    return HttpResponseRedirect('/dashboard')
            else:
                # Return an 'invalid login' error message.
                messages.error(request, 'Username or password is invalid. Please try again.')
                return HttpResponseRedirect('/login')
    else:
        form = forms.loginForm()

    return render(request, 'tarifica/security/login.html', {
        'form': form,
    })