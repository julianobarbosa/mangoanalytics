from django.core.exceptions import PermissionDenied

def referer_matches_hostname(*netlocs):
    """
    Decorator for views that checks that if the request's HTTP_REFERER matches
    the supplied string. Failure raises a PermissionDenied exception. If
    multiple arguments are supplied the decorator will try to match any of
    them.
    """
    def _dec(view_func):
        def _check_referer(request, *args, **kwargs):
            import urlparse
            referer = request.META.get('HTTP_REFERER', '')
            print "referer",referer
            referer_netloc = urlparse.urlparse(referer).netloc
            print "referer_netlock",referer_netloc
            if referer_netloc in netlocs:
                return view_func(request, *args, **kwargs)
            raise PermissionDenied(referer)
        _check_referer.__doc__ = view_func.__doc__
        _check_referer.__dict__ = view_func.__dict__        
        return _check_referer
    return _dec

def referer_matches_re(regex):
    """
    Decorator for views that checks that if the request's HTTP_REFERER matches
    the supplied regex pattern. Failure raises a PermissionDenied exception.
    """
    import re
    regex = re.compile(regex)
    def _dec(view_func):
        def _check_referer(request, *args, **kwargs):
            referer = request.META.get('HTTP_REFERER', '')
            if regex.match(referer):
                return view_func(request, *args, **kwargs)
            raise PermissionDenied()
        _check_referer.__doc__ = view_func.__doc__
        _check_referer.__dict__ = view_func.__dict__        
        return _check_referer
    return _dec

from django.contrib.sites.models import Site
local_referer_only = referer_matches_hostname(str(Site.objects.get_current()))
## Same, but using referer_matches_re:
# regex = r'^https?://%s/.*' % Site.objects.get_current()
# local_referer_only = referer_matches_re(regex)
local_referer_only.__doc__ = (
    """
    Decorator for views that checks that if the request's HTTP_REFERER matches
    the current site. If not, a PermissionDenied exception is raised.
    """
)