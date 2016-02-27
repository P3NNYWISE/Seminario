from django.conf.urls import patterns, include, url
import settings

# Uncomment the next two lines to enable the admin:
from django.contrib import admin
admin.autodiscover()

urlpatterns = patterns('',
    # Examples:
    # url(r'^$', 'Seminario.views.home', name='home'),
    # url(r'^Seminario/', include('Seminario.foo.urls')),
    #Mis apps
    url(r'^',include('Seminario.apps.home.urls')),
    url(r'^',include('Seminario.apps.turnos.urls')),
    url(r'^',include('Seminario.apps.HistoriaClinica.urls')),
    # Uncomment the admin/doc line below to enable admin documentation:
    url(r'^admin/doc/', include('django.contrib.admindocs.urls')),

    # Uncomment the next line to enable the admin:
    url(r'^admin/', include(admin.site.urls)),
    
    url(r'^media/(?P<path>.*)$','django.views.static.serve',{'document_root': settings.MEDIA_ROOT}),
    #url(r'^media/js/jsi18n/$', 'django.views.i18n.javascript_catalog'),
)
