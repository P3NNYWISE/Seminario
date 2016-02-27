from django.conf.urls.defaults import patterns,url

from Seminario.apps.turnos.views import OsAgregar , OsListar , OsView ,OsUpdate ,OsDelete ,AfiliacionListar ,AfiliacionAgregar ,AfiliacionView ,AfiliacionUpdate,AfiliacionDelete ,EspecialidadListar ,EspecialidadView ,EspecialidadAgregar ,EspecialidadUpdate ,EspecialidadDelete ,EspecialidadesMedicosAgregar ,EspecialidadesMedicoUpdate ,AgendaListar ,AgendaAgregar ,AgendaEditar ,AgendaDelete ,ConsultaReservaListar ,TurnoCancelar

urlpatterns = patterns('Seminario.apps.turnos.views',

 #   url(r'^productos/page/(?P<pagina>.*)/$','productos_view',name='vista_productos'),
    url(r'^turnos/listado_especialidades/page/(?P<pagina>.*)/$','listar_especialidades_view',name='vista_turnos_especialidades'),
    
    
    url(r'^turnos/listado/(?P<id_esp>\d+)/page/(?P<pagina>\d+)/$','listar_medicos_view',name='vista_medicos'),
    #AGenda
    #url(r'^turnos/agenda/(?P<id_esp_med>\d+)/page/(?P<pagina>\d+)/$','agenda_medicos_view',name='vista_agenda'),
    #url(r'^turnos/agenda/agregar/(?P<id_esp_med>\d+)/$','agregar_agenda_view',name='vista_agenda_agregar'),
    #url(r'^turnos/agenda/editar/(?P<id_agenda>\d+)/$','edit_agenda_view',name='vista_editar_agenda'),
    
    url(r'^turnos/agenda/(?P<id_esp_med>\d+)/$',AgendaListar.as_view() ,name='vista_agenda'),
    url(r'^turnos/agenda/agregar/(?P<id_esp_med>\d+)/$', AgendaAgregar.as_view(),name='vista_agenda_agregar'),
    url(r'^turnos/agenda/editar/(?P<pk>\d+)/$', AgendaEditar.as_view(),name='vista_editar_agenda'),
    url(r'^turnos/agenda/delete/(?P<pk>.*)/$', AgendaDelete.as_view(), name='vista_agenda_delete'),
    url(r'^turnos/agenda/atencion/(?P<id_esp_med>\d+)/(?P<id_agenda>.*)/$','agregar_atencion_agenda_view',name='vista_atencion_agenda'),
    #Turnos
    url(r'^turnos/atencion/(?P<id_esp_med>\d+)/$','agregar_atencion_view',name='vista_atencion'),
    #Solicitud    
    url(r'^turnos/solicitud/(?P<id_esp_med>\d+)/$','solicitud_turnos_view',name='vista_turnos'),
    url(r'^turnos/consulta/reserva/$',ConsultaReservaListar.as_view(),name='vista_turnos_reservas'),
    
    
    url(r'^turnos/reserva/(?P<id_turno>\d+)/$','reservar_turno_view',name='vista_reserva_turnos'),
    url(r'^turnos/anular/(?P<id_turno>\d+)/$','anular_turno_view',name='vista_anular_turnos'),
    url(r'^turno/cancelar/(?P<pk>.*)/$', TurnoCancelar.as_view(), name='vista_turno_cancelar'),
    #Consulta
    url(r'^turnos/consulta/(?P<id_esp_med>\d+)/$','consulta_turnos_view',name='vista_turnos_consulta'),
    #Calendario - AJax Eventos
    url(r'^turnos/calendario/(?P<id_esp_med>\d+)/$','CalendarEvents',name='vista_calendar_eventos'),
    
    #PDF
    url(r'^turnos/pdf/(?P<id_turnos>\d+)/$','turnos_pdf_view',name='vista_pdf_turnos'),
    url(r'^turnos/comprobante/pdf/(?P<id_turno>\d+)/$','turnos_comprobantes_pdf',name='vista_pdf_turno_comprobante'),
    
    
    
    #Vista Basadas en clasess
    #OBra social

    url(r'^os/listado/$',OsListar.as_view() ,name='vista_obrasociales'),



    ##url(r'^listado-os/page/(?P<pagina>.*)/$',listar_os.as_view() ,name='vista_obrasociales'),

    ##url(r'^listado-os/page/(?P<pagina>.*)/$','listar_os_view',name='vista_obrasociales'),
    ##url(r'^os/agregar/$','agregar_os_view',name='vista_os_agregar'),

    
    url(r'^os/agregar/$',OsAgregar.as_view(),name='vista_os_agregar'),




    url(r'^os/detalle/(?P<pk>.*)/$',OsView.as_view(),name='vista_os'),







    url(r'^os/update/(?P<pk>.*)/$', OsUpdate.as_view(), name='vista_os_update'),
    url(r'^os/delete/(?P<pk>.*)/$', OsDelete.as_view(), name='vista_os_delete'),
    
    #Afiliados
    url(r'^afiliacion/listado/(?P<pk>.*)/$',AfiliacionListar.as_view() ,name='vista_afiliacion'),
    url(r'^afiliacion/agregar/(?P<pk>.*)/$',AfiliacionAgregar.as_view(),name='vista_afiliacion_agregar'),
    url(r'^afiliacion/detalle/(?P<pk>.*)/$',AfiliacionView.as_view(),name='vista_afiliacion_detalle'),
    url(r'^afiliacion/update/(?P<pk>.*)/$', AfiliacionUpdate.as_view(), name='vista_afiliacion_update'),
    url(r'^afiliacion/delete/(?P<pk>.*)/$', AfiliacionDelete.as_view(), name='vista_afiliacion_delete'),
    
    #Especialidad
    url(r'^especialidad/listado/$',EspecialidadListar.as_view() ,name='vista_especialidades'),
    url(r'^especialidad/detalle/(?P<pk>.*)/$', EspecialidadView.as_view(),name='vista_especialidad'),
    url(r'^especialidad/agregar/$', EspecialidadAgregar.as_view(),name='vista_especialidad_agregar'),
    url(r'^especialidad/update/(?P<pk>.*)/$', EspecialidadUpdate.as_view(), name='vista_especialidad_update'),
    url(r'^especialidad/delete/(?P<pk>.*)/$', EspecialidadDelete.as_view(), name='vista_especialidad_delete'),
   #Especialidades Medicos
    url(r'^especialidad-medico/agregar/(?P<pk>.*)/$', EspecialidadesMedicosAgregar.as_view(),name='vista_especialidades_medico_agregar'),
    url(r'^especialidad-medico/update/(?P<pk>.*)/$', EspecialidadesMedicoUpdate.as_view(), name='vista_especialidades_medico_update'),


)

