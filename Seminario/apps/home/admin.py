from django.contrib import admin
from Seminario.apps.home.models import PerfilUsuario ,Medico
from django.contrib.auth.models import User


class AdminPerfilUsuario(admin.ModelAdmin):
    list_display= ('user','tipo','dni','direccion','telefono','fecha_nacimiento')
    list_filter = ['fecha_nacimiento'] 
    search_fields = ['user__username','dni']

class AdminMedico(admin.ModelAdmin):
    list_display= ('user','matricula','cuit')
    
admin.site.register(PerfilUsuario, AdminPerfilUsuario)
admin.site.register(Medico, AdminMedico)

