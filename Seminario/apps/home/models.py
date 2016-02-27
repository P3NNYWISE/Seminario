from django.db import models
from django.contrib.auth.models import User

from django.core.urlresolvers import reverse

SEXO_CHOICE = (
                   ('M','Masculino'),
                   ('F','Femenino'),
                   )
TIPO_DOC = (
            ('DNI','DNI'),
            ('CI','Cedula de Identidad'),
            ('LE','Libreta de Enrolamiento'),
            ('LC','Libreta Civica'),
            )



class PerfilUsuario(models.Model):
    """Perfil de usuarios del sistemas
    """
    
    def url(self,filename):
        ruta= 'MultimediaData/Users/%s/%s'%(self.user.username,filename)
        return ruta    
    
    user = models.OneToOneField(User, verbose_name='Usuario')
    dni = models.CharField('Nro de Documento',max_length = 20 , primary_key =True)    
    tipo =   models.CharField(max_length=5, default='-', choices=TIPO_DOC, null = True)
    sexo = models.CharField(max_length=1, default='-', choices=SEXO_CHOICE, null = True)
    photo = models.ImageField(upload_to=url,null=True ,blank=True, default='MultimediaData/Users/anonimo.jpg')
    telefono = models.CharField(max_length=30, null = True)
    direccion = models.CharField(max_length=60 , null = True)
    fecha_nacimiento = models.DateField( null = True)
    
    
    def __unicode__(self):
        return self.user.get_full_name()#self.user.username
    
    def get_absolute_url(self):
        return reverse('vista_perfil', kwargs={'id_paciente':int(self.user.id)} )
    
 
class Medico(models.Model):
    
    user = models.OneToOneField(User, verbose_name='Usuario')    
    matricula= models.CharField(max_length = 20, primary_key= True)
    cuit= models.CharField(max_length = 20)
    estado = models.BooleanField(default=True)
    
    def __unicode__(self):
        return self.user.get_full_name()
    
    
    def get_absolute_url(self):
        return reverse('vista_medicos_detalle', kwargs={'pk':int(self.matricula)} )
