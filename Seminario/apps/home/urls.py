from django.conf.urls.defaults import patterns,url

from .views import UserUpdate
from .views import MedicosListar , MedicosAgregar , MedicosView ,MedicosUpdate ,MedicosDelete ,PerfilUpdate ,MedicosPrincipal ,PacientesListar

urlpatterns = patterns('Seminario.apps.home.views',
    url(r'^$','index_view',name='vista_principal'),
    
    url(r'^about/$','about_view',name='vista_about'),
    url(r'^contacto/$','contacto_view',name='vista_contacto'),
    
    url(r'^login/$','login_view',name='vista_login'),
    url(r'^logout/$','logout_view',name='vista_logout'),
    # users y perfiles
    url(r'^registro/$','register_view',name='vista_registro'),
    url(r'^user/registro/$','register_byuser_view',name='vista_registro_user'),
    url(r'^editar/$','editar_perfil_view',name='vista_editar_perfil'),
    url(r'^update/perfil/(?P<pk>.*)/$',UserUpdate.as_view() ,name='vista_user_update'),    
    url(r'^perfil/(?P<id_paciente>.*)/$','perfil_view',name='vista_perfil'),
    url(r'^registro/perfil/(?P<pk>.*)/$', PerfilUpdate.as_view(), name='vista_perfil_update'),
    
    
    #Vistas Administradores
    #url(r'^listado-pacientes/page/(?P<pagina>.*)/$','listar_pacientes_view',name='vista_'), 
    url(r'^pacientes/listado/$',PacientesListar.as_view() ,name='vista_pacientes'),                                         
    #Medicos ABM    
    url(r'^medicos/listado/$',MedicosListar.as_view() ,name='vista_medicos'),
    url(r'^medicos/principal/$',MedicosPrincipal ,name='vista_medicos_principal'),
    
    url(r'^medicos/detalle/(?P<pk>.*)/$',MedicosView.as_view(),name='vista_medicos_detalle'),
    url(r'^medicos/agregar/$',MedicosAgregar.as_view(),name='vista_medicos_agregar'),
    url(r'^medicos/update/(?P<pk>.*)/$', MedicosUpdate.as_view(), name='vista_medicos_update'),
    url(r'^medicos/delete/(?P<pk>.*)/$', MedicosDelete.as_view(), name='vista_medicos_delete'),
    
)                                                                                                                                                                                                                                                                                                                                                                                                                                 