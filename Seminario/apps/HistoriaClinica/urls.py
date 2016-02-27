from django.conf.urls.defaults import patterns,url

from .views import AntecedenteFisioAgregar , AntecedenteFisioUpdate,AntecedentePatoAgregar ,AntecedentePatoUpdate ,AntecedentePerinatalesAgregar,AntecedentePerinatalesUpdate ,Cie10Listar ,ConsultasListar,ConsultasArchivo ,ConsultasAnualArchivo ,ConsultaView ,ConsultaAgregar ,HceListar ,Cie10Agregar ,Cie10Editar ,Cie10Delete ,LaboratorioArchivo ,LaboratorioView ,LaboratorioAgregar ,LaboratorioEditar ,ConsultaEditar, LaboratorioDelete ,ConsultaDelete ,PracticasArchivo,PracticaView,PracticaAgregar ,PracticaEditar ,PracticaDelete ,PracticaCreateView ,PracticaTerminar ,RecetasArchivo ,RecetaView ,RecetaRegistrarView ,RecetaEditar ,RecetaDelete ,Consultas_X_OS ,Consultas_X_OS_PDF ,Practicas_X_OS ,Rank_Practicas_X_OS ,VademecumListar ,VademecumAgregar ,VademecumEditar ,VademecumDeshabilitar ,InosListar ,InosAgregar ,InosEditar ,InosDeshabilitar ,Rank_Diagnosticos ,Rank_Usuarios
#from Seminario.apps.HistoriaClinica.reportes import Consultas_X_OS_PDF

urlpatterns = patterns('Seminario.apps.HistoriaClinica.views',
    #url(r'^historia-clinica/(?P<id_paciente>\d+)/$','historia_clinica_view',name='vista_hce'),
#HCE
    url(r'^hce/$',HceListar.as_view(),name='vista_hce_listado'),
    url(r'^hce/(?P<id_paciente>.*)/$','hce_view',name='vista_hce'),
    url(r'^historia-clinica/agregar/(?P<id_paciente>\d+)/$','historia_clinica_view',name='vista_agregar_hce'),
    url(r'^historia-clinica/editar/(?P<id_hce>\d+)/$','edit_historia_clinica_view',name='vista_editar_hce'),

#Examen Fisico
    url(r'^historia-clinica/examen-fisico/agregar/(?P<id_hce>\d+)/$','examen_fisico_view',name='vista_examen'),
    url(r'^historia-clinica/examen-fisico/editar/(?P<id_examen>\d+)/$','edit_examen_fisico_view',name='vista_editar_examen'),
#Antecedentes    
    url(r'^historia-clinica/antecedentes/habitos-toxicos/agregar/(?P<id_hce>\d+)/$','antecedentes_view',name='vista_antecedentes'),
    
    url(r'^historia-clinica/antecedentes/habitos-toxicos/editar/(?P<id_hab_tox>\d+)/$','edit_habitos_toxicos_view',name='vista_editar_habitos'),
    
    url(r'^historia-clinica/antecedentes/fisiologicos/agregar/(?P<id_hce>\d+)/$',AntecedenteFisioAgregar.as_view() ,name='vista_agregar_fisiologicas'),
    
    url(r'^historia-clinica/antecedentes/fisiologicos/editar/(?P<pk>\d+)/$',AntecedenteFisioUpdate.as_view(),name='vista_editar_fisiologicas'),
    
    url(r'^historia-clinica/antecedentes/patologicos/agregar/(?P<id_hce>\d+)/$',AntecedentePatoAgregar.as_view() ,name='vista_agregar_patologicas'),
    
    url(r'^historia-clinica/antecedentes/patologicos/editar/(?P<pk>\d+)/$',AntecedentePatoUpdate.as_view(),name='vista_editar_patologicas'),


    url(r'^historia-clinica/antecedentes/perinatales/agregar/(?P<id_hce>\d+)/$',AntecedentePerinatalesAgregar.as_view() ,name='vista_agregar_perinatales'),    
    url(r'^historia-clinica/antecedentes/perinatales/editar/(?P<pk>\d+)/$',AntecedentePerinatalesUpdate.as_view() ,name='vista_editar_perinatales'),
    
#Cie110
    url(r'^cie10/listado/$',Cie10Listar.as_view() ,name='vista_cie10'),
    url(r'^cie10/agregar/$', Cie10Agregar.as_view(),name='vista_cie10_agregar'),
    url(r'^cie10/editar/(?P<pk>.*)/$', Cie10Editar.as_view(),name='vista_cie10_editar'),
    url(r'^cie10/delete/(?P<pk>.*)/$', Cie10Delete.as_view(), name='vista_cie10_delete'),
# Consultas
    #url(r'^consultas/listado/$',ConsultasListar.as_view() ,name='vista_consultas'),
    #url(r'^consultas/listado/(?P<id_hce>\d+)/$',ConsultasListar.as_view() ,name='vista_consultas'),
    url(r'^consultas/listado/(?P<id_hce>\d+)/$',ConsultasArchivo.as_view() ,name='vista_consultas'),
    #url(r'^consultas/listado/(?P<year>\d+)/$',ConsultasAnualArchivo.as_view() ,name='vista_consultas'),
    url(r'^consultas/detalle/(?P<pk>.*)/$',ConsultaView.as_view(),name='vista_consulta'),
    url(r'^consultas/agregar/(?P<id_hce>\d+)/$',ConsultaAgregar.as_view(),name='vista_consulta_agregar'),
    url(r'^consultas/editar/(?P<pk>.*)/$', ConsultaEditar.as_view(),name='vista_consulta_editar'),
    url(r'^consultas/delete/(?P<pk>.*)/$', ConsultaDelete.as_view(), name='vista_consulta_delete'),
    #url(r'^consultas/agregar/$',ConsultaAgregar,name='vista_consulta_agregar'),
    
#Laboratorios
    url(r'^laboratorio/listado/(?P<id_hce>\d+)/$', LaboratorioArchivo.as_view() ,name='vista_laboratorio'),
    url(r'^laboratorio/detalle/(?P<pk>.*)/$', LaboratorioView.as_view(),name='vista_laboratorio_detalle'),
    url(r'^laboratorio/agregar/(?P<id_hce>\d+)/$', LaboratorioAgregar.as_view(),name='vista_laboratorio_agregar'),
    url(r'^laboratorio/editar/(?P<pk>.*)/$', LaboratorioEditar.as_view(),name='vista_laboratorio_editar'),
    url(r'^laboratorio/delete/(?P<pk>.*)/$', LaboratorioDelete.as_view(), name='vista_laboratorio_delete'),
#Practicas Medicas
    url(r'^practicas/listado/(?P<id_hce>\d+)/$', PracticasArchivo.as_view() ,name='vista_practicas'),
    url(r'^practicas/detalle/(?P<pk>.*)/$', PracticaView.as_view(),name='vista_practica_detalle'),
    url(r'^practicas/agregar/(?P<id_hce>\d+)/$', PracticaAgregar.as_view(),name='vista_practica_agregar'),
    url(r'^practicas/editar/(?P<pk>.*)/$', PracticaEditar.as_view(),name='vista_practica_editar'),
    url(r'^practicas/delete/(?P<pk>.*)/$', PracticaDelete.as_view(), name='vista_practica_delete'),
    url(r'^practicas/terminar/(?P<pk>.*)/$', PracticaTerminar.as_view(), name='vista_practica_terminar'),
#Registrar Presc + Detalles    
    url(r'^practicas/registrar/(?P<id_hce>\d+)/$', PracticaCreateView.as_view() ,name='vista_practica_registrar'),
    
#Vademcum ABM
    url(r'^vademecum/listado/$',VademecumListar.as_view() ,name='vista_vademecum'),
    url(r'^vademecum/agregar/$', VademecumAgregar.as_view(),name='vista_vademecum_agregar'),
    url(r'^vademecum/editar/(?P<pk>.*)/$', VademecumEditar.as_view(),name='vista_vademecum_editar'),
    url(r'^vademecum/deshabilitar/(?P<pk>.*)/$', VademecumDeshabilitar.as_view(), name='vista_vademecum_deshabilitar'),
#INOS
    url(r'^inos/listado/$',InosListar.as_view() ,name='vista_inos'),
    url(r'^inos/agregar/$', InosAgregar.as_view(),name='vista_inos_agregar'),
    url(r'^inos/editar/(?P<pk>.*)/$', InosEditar.as_view(),name='vista_inos_editar'),
    url(r'^inos/deshabilitar/(?P<pk>.*)/$', InosDeshabilitar.as_view(), name='vista_inos_deshabilitar'),
    
    #Recetas
    url(r'^recetas/listado/(?P<id_hce>\d+)/$', RecetasArchivo.as_view() ,name='vista_recetas'),
    url(r'^recetas/detalle/(?P<pk>.*)/$', RecetaView.as_view(),name='vista_receta_detalle'),
    url(r'^recetas/registrar/(?P<id_hce>\d+)/$', RecetaRegistrarView.as_view() ,name='vista_receta_registrar'),
    url(r'^recetas/editar/(?P<pk>.*)/$', RecetaEditar.as_view(),name='vista_receta_editar'),
    url(r'^recetas/delete/(?P<pk>.*)/$', RecetaDelete.as_view(), name='vista_receta_delete'),
    # Reportes
    url(r'^reportes/os/consultas/(?P<id_os>\d+)/$',Consultas_X_OS.as_view() ,name='vista_reportes_consultas_X_OS'),
    url(r'^reportes/os/consultas/pdf/$',"Consultas_X_OS_PDF",name='vista_PDF_consultas_X_OS'),
    url(r'^reportes/os/practicas/(?P<id_os>\d+)/$',Practicas_X_OS.as_view() ,name='vista_reportes_practicas_X_OS'),
    url(r'^reportes/os/practicas/pdf/$',"Practicas_X_OS_PDF",name='vista_PDF_practicas_X_OS'),
    # Ranking
    url(r'^reportes/os/practicas/rank/$',Rank_Practicas_X_OS.as_view() ,name='vista_reportes_rank_practicas_OS'),
    url(r'^reportes/os/practicas/rank/pdf/$',"Rank_Practicas_X_OS_PDF",name='vista_PDF_rank_practicas_X_OS'),
    url(r'^reportes/diagnosticos/rank/$',Rank_Diagnosticos.as_view() ,name='vista_reportes_rank_diagnosticos'),
    url(r'^reportes/usuarios/rank/$',Rank_Usuarios.as_view() ,name='vista_reportes_usuarios'),
    ###
    
)





