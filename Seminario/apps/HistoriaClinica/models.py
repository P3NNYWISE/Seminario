from django.db import models

from django.contrib.auth.models import User
from Seminario.apps.turnos.models import  EspecialidadesMedicos , AfiliadosOS

from django.core.urlresolvers import reverse

from Seminario.apps.tipos import *

from datetime import date, datetime 


# Create your models here.

class HistoriaClinica(models.Model):    
    paciente  = models.OneToOneField(User, verbose_name='Paciente')
    fecha_creacion = models.DateField()
    prestador = models.ForeignKey( EspecialidadesMedicos, verbose_name='Prestador')
        #fecha_nacimiento = models.DateTimeField('Fecha Nacimiento')
    lugar_nacimiento = models.CharField('Lugar Nacimiento', max_length=60)        
    
    estado_civil = models.CharField('Estado Civil', max_length=1, default='-', choices=ESTADO_CIVIL_CHOICE)
    ocupacion = models.CharField(max_length=30)
    religion = models.CharField(max_length=30)
    
    padre = models.CharField('Padre', max_length=120)
    madre = models.CharField('Madre', max_length=120)
    grupo_sanguineo = models.CharField('Grupo Sanguineo', max_length=3, default='--', choices=GRUPO_SANGUINEO_CHOICE)
    motivo_consulta = models.TextField('Motivo de Consulta')
    antecedentes_enfermedad_actual = models.TextField('Antecedentes de Enfermedad Actual ', blank=True)

    def __unicode__(self):
        return "%s | %s "%(self.id,self.paciente.get_full_name())
    class Meta:
        verbose_name_plural = 'Historias Clinicas'

class HabitosToxicos(models.Model):
    
    historia_clinica = models.ForeignKey(HistoriaClinica)
    fecha = models.DateTimeField()#fecha q se realizo el examem

    alcohol = models.BooleanField() 
    tabaco = models.BooleanField()
    drogas = models.BooleanField()
    infuciones = models.BooleanField()
    observaciones = models.TextField('Observaciones')

    def __unicode__(self):
        return "%s | %s "%(self.historia_clinica,self.fecha)
    def get_alcohol(self):
        if self.alcohol :
            return 'Si'
        else:
            return 'No'
    def get_tabaco(self):
        if self.tabaco :
            return 'Si'
        else:
            return 'No'
    def get_drogas(self):
        if self.drogas :
            return 'Si'
        else:
            return 'No'
    def get_infuciones(self):
        if self.infuciones :
            return 'Si'
        else:
            return 'No'
    class Meta:
        verbose_name_plural = 'Habitos Toxicos'
    
class Fisiologicos(models.Model):
    
    historia_clinica = models.ForeignKey(HistoriaClinica)
    fecha = models.DateTimeField()#fecha q se realizo el examem

    alimentacion = models.CharField(max_length=30) 
    dipsia = models.CharField(max_length=30)
    diuresis = models.CharField(max_length=30)
    catarsis = models.CharField(max_length=30)
    sommia = models.CharField(max_length=30)
    observaciones = models.TextField('Observaciones')
    
    def get_absolute_url(self):
        return reverse('vista_hce', kwargs={'id_paciente':int(self.historia_clinica.paciente.id)} )
    
    
    class Meta:
        verbose_name_plural = 'Antecedentes Fisiologicos'

class Patologicos(models.Model):
    
    historia_clinica = models.ForeignKey(HistoriaClinica)
    fecha = models.DateTimeField()#fecha q se realizo el examem

    infancia = models.CharField(max_length=30) 
    adulto = models.CharField(max_length=30)
    
    DBT = models.BooleanField()
    HTA = models.BooleanField()
    TBC = models.BooleanField()
    gemelar = models.BooleanField()
    otras = models.BooleanField()
    especificacion = models.CharField(max_length=30)
    quirurgicos = models.CharField(max_length=30)
    catarsis = models.CharField(max_length=30)
    traumatologicos = models.CharField(max_length=30)
    alergicos = models.TextField('Observaciones')
    
    def get_DBT(self):
        if self.DBT :
            return 'Si'
        else:
            return 'No'
    
    def get_HTA(self):
        if self.HTA :
            return 'Si'
        else:
            return 'No'
    def get_TBC(self):
        if self.TBC :
            return 'Si'
        else:
            return 'No'
    
    def get_gemelar(self):
        if self.gemelar :
            return 'Si'
        else:
            return 'No'
        
    def get_otras(self):
        if self.otras :
            return 'Si'
        else:
            return 'No'
    
    def get_absolute_url(self):
        return reverse('vista_hce', kwargs={'id_paciente':int(self.historia_clinica.paciente.id)} )
    
    class Meta:
        verbose_name_plural = 'Antecedentes Patologicos'

class Perinatales(models.Model):
    """
        Referentes al nacimiento
    """
    historia_clinica = models.ForeignKey(HistoriaClinica)
    fecha =  models.DateTimeField(default= datetime.now )
    embarazo_nro = models.IntegerField('Embarazo Nro')
    duracion_embarazo = models.IntegerField('Duracion/Semanas') #en semanas
    controles = models.BooleanField('Controles Durante Embarazo')
    parto_normal = models.BooleanField('Parto Normal')
    peso = models.FloatField('Peso al Nacer') #peso al nacer
    talla = models.FloatField('Talla')
    patologias = models.BooleanField('Presento Patologias al Nacer')
    atencion_medica = models.BooleanField('Requirio Atencion Medica')
    otros_datos = models.TextField('Otros Datos de Relevancia o Informacion Adicional') 

    def get_controles(self):
        if self.controles :
            return 'Si'
        else:
            return 'No'
        
    def get_parto_normal(self):
        if self.parto_normal :
            return 'Si'
        else:
            return 'No'
    def get_patologias(self):
        if self.patologias :
            return 'Si'
        else:
            return 'No'
    def get_atencion_medica(self):
        if self.atencion_medica :
            return 'Si'
        else:
            return 'No'

    def __unicode__(self):
        return "%s | %s "%(self.historia_clinica,self.fecha_examen)
    class Meta:
        verbose_name_plural = 'Antecedentes Perinatales'
        
    def get_absolute_url(self):
        return reverse('vista_hce', kwargs={'id_paciente':int(self.historia_clinica.paciente.id)} ) 


class ExamenFisico(models.Model):

    historia_clinica = models.ForeignKey(HistoriaClinica)
    fecha_examen = models.DateTimeField(default= datetime.now )
    impresion_general = models.TextField()
    #signos vitales    
    pres_art_sist = models.IntegerField("Presion Arterial Sistolica")
    pres_art_diast = models.IntegerField("Presion Arterial Dastolica")
    frec_respiratoria = models.IntegerField("Frecuencia Respiratoria")
    temp_corporal = models.FloatField("Temperatura Corporal")
    pulso = models.IntegerField("Pulso")
    
    peso_medio = models.FloatField()
    altura_media = models.FloatField()
    peso = models.FloatField()
    altura = models.FloatField()
    talla = models.CharField(max_length=30)
    bmi = models.FloatField("Indice de Masa Corporal")
    
    def __unicode__(self):
        return "%s | %s "%(self.historia_clinica,self.fecha_examen)
    class Meta:
        verbose_name_plural = 'Examenes Fisicos' 



class Cie10(models.Model):
    codigo = models.CharField(max_length=4,primary_key =  True)
    descripcion = models.CharField(max_length=20)
    estado = models.BooleanField(default = True)
    
    def get_estado(self):
        if self.estado:
            return "Activo"
        else:
            return "Deshabilitado"
    
    
    
    def __unicode__(self):
        return "%s - %s"%(self.codigo ,self.descripcion)
    
class CapitulosInos(models.Model):
    tipo = models.CharField('Tipo Practica Medica', max_length=3,default='-', choices=TIPOS_PRACTICAS_CHOICES)
    nro_capitulo = models.CharField(max_length=4 , primary_key =  True)    
    nombre_capitulo = models.CharField(max_length=30)
    
    def __unicode__(self):
        return "%s -%s %s "%(self.get_tipo_display() ,self.nombre_capitulo,self.nro_capitulo)
        
    class Meta:
        verbose_name_plural = 'Capitulos INOS'
        unique_together = ('tipo','nro_capitulo')    

class Inos(models.Model):
    
    capitulo = models.ForeignKey( CapitulosInos, verbose_name='Capitulos Inos')
    codigo = models.CharField(max_length=6)
    descripcion = models.CharField(max_length=30)
    estado = models.BooleanField(default = True)
    
    def get_estado(self):
        if self.estado:
            return "Activo"
        else:
            return "Deshabilitado"
            
    

    

    def __unicode__(self):
        return "%s . %s %s"%(self.capitulo ,self.codigo,self.descripcion)
        
    class Meta:
        verbose_name_plural = 'INOS'
        unique_together = ('capitulo','codigo')    

    

class ConsultaMedica(models.Model):
    historia_clinica = models.ForeignKey(HistoriaClinica)
    prestador = models.ForeignKey( EspecialidadesMedicos, verbose_name='Prestador')
    os_consulta = models.ForeignKey( AfiliadosOS, verbose_name='Obra Social')
    fecha = models.DateTimeField()
    motivos_consulta= models.TextField('Motivos de Consulta',max_length=100)
    sintomas = models.TextField(max_length=100 ,blank=True)
    #diagnosticos= models.TextField(max_length=100, null=True)
    diagnosticos= models.ManyToManyField(Cie10, null = True ,blank=True)
    terapeutica=models.TextField(max_length=  100 ,   blank=True, null=True)
    observaciones = models.TextField(max_length=100,blank=True)
    estado = models.BooleanField(default = True)
    
    
    def __unicode__(self):
        return "%s | %s "%(self.historia_clinica,self.fecha)
    
    def get_absolute_url(self):
        return reverse('vista_consulta', kwargs={'pk':int(self.id)} )
    
    class Meta:
        verbose_name_plural = 'Consultas Medicas'
        
"""
class Diagnostico(models.Model):
    consulta = models.ForeignKey(ConsultaMedica)
    cie10 = models.ForeignKey(Cie10)
    
    def __unicode__(self):
        return "%s | %s"%(self.consulta,self.cie10)

    class Meta:
        verbose_name_plural = 'Diagnosticos'
        unique_together = ('consulta','cie10')
"""
"""boorar"""
class Laboratorio(models.Model):
    historia_clinica = models.ForeignKey(HistoriaClinica)
    prestador = models.ForeignKey( EspecialidadesMedicos, verbose_name='Prestador')
    fecha = models.DateTimeField()
    #analisis =  models.CharField(max_length=20)
    analisis =  models.ForeignKey(Inos)

    resultados = models.TextField(max_length=100)
    
    def get_absolute_url(self):
        return reverse('vista_laboratorio_detalle', kwargs={'pk':int(self.id)} )
  
  
 
 
class PracticaMedica(models.Model):
    #Agregar    resultados  observaciones null=true , Estado , Fecha_modif, prestador realizacion
    historia_clinica = models.ForeignKey(HistoriaClinica)
    prestador = models.ForeignKey( EspecialidadesMedicos, verbose_name='Prestador', related_name='prestador')
    os_prescripcion = models.ForeignKey( AfiliadosOS, verbose_name='Obra Social')
    fecha = models.DateTimeField(default= datetime.now)
    #nombre_practica= models.TextField('Practica Medica',max_length=100)
    practicas =  models.ManyToManyField(Inos , through = 'PracticaDetalle')
    efector = models.ForeignKey( EspecialidadesMedicos, verbose_name='Efector', related_name='efector' ,null=True , blank=True)
    estado = models.CharField('Estado Prescripcion', max_length=10,default='Pendiente', choices= TIPOS_ESTADOS_PRACTICAS)    
    fecha_modificado = models.DateTimeField(null=True, blank=True)
    resultados=models.TextField(max_length=100 , null=True , blank=True)
    observaciones = models.TextField(max_length=100,null= True , blank=True)
    
    
    def __unicode__(self):
        return "%s-%s "%(self.id , self.historia_clinica.paciente)
    
    def get_absolute_url(self):
        return reverse('vista_practica_detalle', kwargs={'pk':int(self.id)} )
    
    class Meta:
        verbose_name_plural = 'Prescripcion Practicas Medicas'   
    def get_estado(self):
        return "%s"%(self.get_estado_display())
    
class PracticaDetalle(models.Model):
    #agrandar indicaciones  agregar EStado= Realizado
    practica_medica= models.ForeignKey(PracticaMedica)
    practica=models.ForeignKey(Inos)#nombre mas corto?
    indicaciones= models.CharField(max_length = 100)
    
    
    def __unicode__(self):
        return "%s-%s "%(self.practica_medica , self.id)
    
    class Meta:
        verbose_name_plural = 'PracticasDetalles'
        unique_together = ('practica_medica','practica')
    
class Vademecum(models.Model):
    monodroga= models.CharField(max_length = 30)
    nombre_comercial= models.CharField(max_length = 30)
    #posologia= models.CharField(max_length = 10)
    presentacion =  models.CharField(max_length = 50)
    estado = models.BooleanField(default = True)
    
    def get_estado(self):
        if self.estado :
            return 'Habilitado'
        else:
            return 'Deshabilitado'
    
    
    def __unicode__(self):
        return "%s %s"%(self.nombre_comercial,self.presentacion)
    class Meta:
        verbose_name_plural = 'Vademecums' 
        
class Receta(models.Model):
    historia_clinica = models.ForeignKey(HistoriaClinica)
    prestador = models.ForeignKey( EspecialidadesMedicos, verbose_name='Prestador')
    os_receta = models.ForeignKey( AfiliadosOS, verbose_name='Obra Social')
    fecha = models.DateTimeField(default= datetime.now)
    medicamentos =  models.ManyToManyField(Vademecum , through = 'RecetaDetalle')
    estado = models.CharField('Estado Receta', max_length=10,default='Activo', choices= TIPOS_ESTADOS_RECETA)        
    observaciones = models.TextField(max_length=100,null= True , blank=True)
    
    def __unicode__(self):
        return "%s-%s "%(self.id,self.historia_clinica.paciente)
    
    def get_absolute_url(self):
        return reverse('vista_receta_detalle', kwargs={'pk':int(self.id)} )
    
    class Meta:
        verbose_name_plural = 'Recetas de Medicamentos'   
    def get_estado(self):
        return "%s"%(self.get_estado_display())
    
class RecetaDetalle(models.Model):
    #agrandar indicaciones  agregar EStado= Realizado
    receta= models.ForeignKey(Receta)
    medicacion=models.ForeignKey(Vademecum)#nombre mas corto?
    indicaciones= models.CharField(max_length = 100)
    
    
    def __unicode__(self):
        return "%s-%s "%(self.id ,self.receta )
    
    class Meta:
        verbose_name_plural = 'Receta Detalles'
        unique_together = ('receta','medicacion')
        
