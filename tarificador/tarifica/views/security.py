#Views for bundles
from django.contrib.auth import logout, authenticate, login
from django.contrib import messages
from django.shortcuts import render
from django.http import HttpResponseRedirect
from tarifica import forms

def logout_view(request):
    logout(request)
    return HttpResponseRedirect('/login')

def login_view(request):
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