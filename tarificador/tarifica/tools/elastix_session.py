from django.core.exceptions import PermissionDenied
from tarifica.models import ElastixUser
from datetime import *

def elastix_user_is_authorized():
    """
    Decorator for views that checks that an elastix user has been set
    in mangoanalytics database and has the correct permissions. 
    Failure raises a PermissionDenied exception.
    """
    def _dec(view_func):
        def elastix_user_set(request, *args, **kwargs):
            try:
                user = ElastixUser.objects.get(id = 1)
            except Exception as e:
                raise PermissionDenied()
            now = datetime.now()
            login_time = now - user.first_login
            print login_time
            #Dos horas de validez...
            if login_time.total_seconds > 7200:
                raise PermissionDenied()    
            if user.permissions:
                return view_func(request, *args, **kwargs)
            raise PermissionDenied()
        elastix_user_set.__doc__ = view_func.__doc__
        elastix_user_set.__dict__ = view_func.__dict__        
        return elastix_user_set
    return _dec