from django.contrib import admin
from Seminario.apps.HistoriaClinica.models import HistoriaClinica , ConsultaMedica ,ExamenFisico ,HabitosToxicos , Fisiologicos , Patologicos ,Cie10 , Laboratorio , PracticaMedica
from Seminario.apps.HistoriaClinica.models import CapitulosInos, Inos ,PracticaDetalle ,Vademecum , Receta, RecetaDetalle


class AdminHistoriaClinica(admin.ModelAdmin):
    list_display= ('id','paciente','fecha_creacion','lugar_nacimiento','estado_civil','ocupacion','religion',)
    #list_filter = ['fecha_nacimiento'] 
    search_fields = ['paciente__username','id']

class AdminConsultaMedica(admin.ModelAdmin):
    list_display= ('historia_clinica','prestador','fecha',)
    #list_filter = ['fecha_nacimiento'] 
    search_fields = ['historia_clinica__paciente__username','historia_clinica__id','historia_clinica__paciente__last_name']
    
class AdminExamenFisico(admin.ModelAdmin):
    list_display= ('historia_clinica','fecha_examen',)
    #list_filter = ['fecha_nacimiento'] 
    search_fields = ['historia_clinica__paciente__username','historia_clinica__id','historia_clinica__paciente__last_name']

class AdminHabitosToxicos(admin.ModelAdmin):
    list_display= ('historia_clinica','fecha',)
    #list_filter = ['fecha_nacimiento'] 
    search_fields = ['historia_clinica__paciente__username','historia_clinica__id','historia_clinica__paciente__last_name']

class AdminFisiologicos(admin.ModelAdmin):
    list_display= ('historia_clinica','fecha',)
    #list_filter = ['fecha_nacimiento'] 
    search_fields = ['historia_clinica__paciente__username','historia_clinica__id','historia_clinica__paciente__last_name']
class AdminPatologicos(admin.ModelAdmin):
    list_display= ('historia_clinica','fecha',)
    #list_filter = ['fecha_nacimiento'] 
    search_fields = ['historia_clinica__paciente__username','historia_clinica__id','historia_clinica__paciente__last_name']
    
    
class AdminCie10(admin.ModelAdmin):
    list_display= ('codigo','descripcion',)
    #list_filter = ['fecha_nacimiento'] 
    #search_fields = ['historia_clinica__paciente__username','historia_clinica__id','historia_clinica__paciente__last_name']


class AdminLaboratorio(admin.ModelAdmin):
    list_display= ('historia_clinica','fecha',)
  
class PracticaInline(admin.TabularInline):
    model = PracticaMedica.practicas.through
    verbose_name= u'Practica'
    verbose_name_plural= u'Practicas'  
    
class  AdminPracticaMedica(admin.ModelAdmin):
    model= PracticaMedica
    
    exclude = ('practicas',)
    inlines =(PracticaInline,)
    
    ### M2M dos columnas
    #filter_horizontal= ('productos',)

    

class medicamentoInline(admin.TabularInline):
    model = Receta.medicamentos.through
    verbose_name= u'Medicamento'
    verbose_name_plural= u'Medicamentos'  
    
class  AdminReceta(admin.ModelAdmin):
    model= Receta
    
    exclude = ('medicamentos',)
    inlines =(medicamentoInline,)
    
    ### M2M dos columnas
    #filter_horizontal= ('productos',)

    
    







admin.site.register(HistoriaClinica, AdminHistoriaClinica)
admin.site.register(ConsultaMedica, AdminConsultaMedica)
admin.site.register(ExamenFisico, AdminExamenFisico)
admin.site.register(HabitosToxicos, AdminHabitosToxicos)
admin.site.register(Fisiologicos, AdminFisiologicos)
admin.site.register(Patologicos, AdminPatologicos)
admin.site.register(Cie10, AdminCie10)
admin.site.register(Laboratorio, AdminLaboratorio)

admin.site.register(CapitulosInos)
admin.site.register(Inos)
admin.site.register(PracticaMedica, AdminPracticaMedica)
admin.site.register(PracticaDetalle)
admin.site.register(Vademecum)
admin.site.register(Receta, AdminReceta)
admin.site.register(RecetaDetalle)