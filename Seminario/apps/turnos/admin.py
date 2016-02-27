from django.contrib import admin

from Seminario.apps.turnos.models import ObraSocial, Especialidad ,AfiliadosOS ,EspecialidadesMedicos, Agenda,DiaAtencion,Turno

class AdminObraSocial(admin.ModelAdmin):
    list_display= ('nombre','cuit','domicilio','telefono')
    search_fields = ['nombre']

class AdminAfiliadosOS(admin.ModelAdmin):
    list_display= ('afiliado','obrasocial','beneficiario','titular')
    list_filter = ['obrasocial']
    
    search_fields = ['afiliado__username','beneficiario'] 

class AdminEspecialidadesMedicos(admin.ModelAdmin):
    list_display= ('medico','especialidad','fecha_habilitacion','fecha_caducacion','estado')
    list_filter = ['especialidad']
    search_fields = ['medico__user__username']
     
class AdminAgenda(admin.ModelAdmin):
    list_display= ('prestador','dia','hora_inicial','estado')
    
class AdminTurno(admin.ModelAdmin):
    list_display= ('paciente','dia_atencion','hora_turno')
    list_filter = ['dia_atencion','paciente']
    search_fields = ['paciente__username','dia_atencion__medico__user__username']
class AdminDiaAtencion(admin.ModelAdmin):
    list_display= ('prestador','fecha','hora_inicial')
    
admin.site.register(ObraSocial,AdminObraSocial)
admin.site.register(Especialidad)
admin.site.register(AfiliadosOS, AdminAfiliadosOS)
admin.site.register(EspecialidadesMedicos,AdminEspecialidadesMedicos)
admin.site.register(Agenda, AdminAgenda)
admin.site.register(DiaAtencion, AdminDiaAtencion)
admin.site.register(Turno,AdminTurno)
