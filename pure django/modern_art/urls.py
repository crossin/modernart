from django.conf.urls.defaults import *
from django.views.generic.simple import direct_to_template
from views import *;
import settings

# Uncomment the next two lines to enable the admin:
# from django.contrib import admin
# admin.autodiscover()

urlpatterns = patterns('',
    # Example:
    # (r'^modern_art/', include('modern_art.foo.urls')),

    # Uncomment the admin/doc line below and add 'django.contrib.admindocs' 
    # to INSTALLED_APPS to enable admin documentation:
    # (r'^admin/doc/', include('django.contrib.admindocs.urls')),

    # Uncomment the next line to enable the admin:
    # (r'^admin/(.*)', admin.site.root),
     #'',
    url(r'^service/deal/', deal, {'template': 'deal.html'}, name='deal'),
    url(r'^service/repurchase/', repurchase, {'template': 'repurchase.html'}, name='purchase'),
    url(r'^service/login/', login, {'template': 'login.html'}, name='login'),
	url(r'^crossdomain.xml', crossdomain, {'template': 'crossdomain.xml'}, name='crossdomain'),
    (r'^service/test/', 'service.test.testGateway'),
    (r'^service/game/', 'user_logic.game.gameGateway'),
    (r'^media/(?P<path>.*)$', 'django.views.static.serve', {'document_root': settings.MEDIA_ROOT ,'show_indexes': True}),
)
