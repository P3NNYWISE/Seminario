from django.db import models

from django.core.urlresolvers import reverse
from django.contrib.auth.models import User
from Seminario.apps.home.models import Medico

from Seminario.apps.tipos import *

class ObraSocial(models.Model):
    cuit     = models.CharField(max_length = 20, primary_key= True)
    nombre   = models.CharField(max_length = 30)
    domicilio      = models.CharField(max_length=60)
    telefono   = models.CharField(max_length=30)
    estado = models.BooleanField(default = True)
    
    def __unicode__(self):
        return self.nombre   

    def get_absolute_url(self):
        return reverse('vista_os', kwargs={'pk':int(self.cuit)} )
        
    class Meta:
        verbose_name_plural = 'Obra Sociales'
        
    
        
class AfiliadosOS(models.Model):
    """Afiliados por Pacientes"""
    afiliado     =   models.ForeignKey(User)
    obrasocial   =   models.ForeignKey(ObraSocial)
    beneficiario =   models.CharField('Nro de Beneficiario', max_length=20)
    titular      =   models.CharField('Nro del Titular' ,max_length=20)
    estado = models.BooleanField(default=True)
    
    def __unicode__(self):
        return "%s | %s"% (self.afiliado.username,self.obrasocial.nombre)
    
    def get_absolute_url(self):
        return reverse('vista_afiliacion_detalle', kwargs={'pk':int(self.id)} )
    
    class Meta:
        verbose_name_plural = 'Afiliados OS'
        unique_together = ('afiliado','obrasocial')
        
    
class Especialidad(models.Model):
    nombre  = models.CharField(max_length = 30)
    estado = models.BooleanField(default = True)
    def __unicode__(self):
        return self.nombre
    class Meta:
        verbose_name_plural = 'Especialidades'
    def get_absolute_url(self):
        return reverse('vista_especialidad', kwargs={'pk':int(self.id)} )
    
    
class EspecialidadesMedicos(models.Model):
    medico = models.ForeignKey(Medico)
    especialidad = models.ForeignKey(Especialidad)
    fecha_habilitacion = models.DateField()
    fecha_caducacion = models.DateField(blank=True)
    estado = models.BooleanField(default=True)
    def __unicode__(self):
        return "%s - %s"%(self.medico.user.get_full_name(), self.especialidad)
    class Meta:
        verbose_name_plural = 'Especialidades Medicos'
        unique_together = ('medico','especialidad')
    
    def get_estado(self):
        if self.estado :
            return 'Activo'
        else:
            return 'No Activo'
    def get_absolute_url(self):
        return reverse('vista_medicos_detalle', kwargs={'pk':int(self.medico.matricula)} )
    
##############################
class Agenda(models.Model):
    #medico = models.ForeignKey(Medico)
    prestador = models.ForeignKey(EspecialidadesMedicos)
    #dia = models.CharField(max_length=3, default='-', choices=DIA_CHOICES)
    dia = models.IntegerField(choices=DIA_CHOICES)
    dia_nombre =models.CharField(max_length=10)
    hora_inicial= models.TimeField()
    hora_final = models.TimeField()
    duracion = models.IntegerField(default=15)
    cant_turnos = models.IntegerField(null=True , blank = True)
    estado = models.BooleanField(default = True)
    

    
    def __unicode__(self):
        #return "%s %s %s"%(self.prestador,self.dia,self.hora_inicial)
        return "%s | %s | %s"%(self.prestador.medico.user.username , self.dia , self.hora_inicial)
    
    def get_absolute_url(self):
        return reverse('vista_agenda', kwargs={'id_esp_med':int(self.prestador.id)} )
    
  
    
    class Meta:
        verbose_name_plural = 'Agendas'
        unique_together = ('prestador','dia','hora_inicial')

class DiaAtencion(models.Model):
    #agenda = models.ForeignKey(Agenda)
    #medico = models.ForeignKey(Medico)
    prestador = models.ForeignKey(EspecialidadesMedicos)
    fecha = models.DateField()
    hora_inicial= models.TimeField()
    observacion = models.CharField(max_length=30, blank = True)
    #estado = models.BooleanField(default=True)
    def __unicode__(self):
        return "%s | %s "%(self.id , self.fecha)
    class Meta:        
        verbose_name_plural = 'Dia Atenciones'
        unique_together = ('prestador','fecha','hora_inicial')
    
class Turno(models.Model):
    paciente = models.ForeignKey(User, blank= True, null = True, default = None)
    #afiliacion = models.ForeignKey(AfiliadosOS)
    dia_atencion = models.ForeignKey(DiaAtencion)
    hora_turno = models.TimeField()
    fecha_creacion= models.DateField(blank=True,null= True)
    observacion = models.TextField(max_length=120 , blank = True)
    sede = models.CharField(max_length=30 , null= True)
    def __unicode__(self):
        return "%s | %s "%(self.dia_atencion , self.hora_turno)

    def get_paciente_name(self):
        if self.paciente:
            return self.paciente.get_full_name()
        else:
            return ''