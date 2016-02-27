from django import forms

from Seminario.apps.turnos.models import DiaAtencion , Turno , Agenda , ObraSocial , AfiliadosOS ,EspecialidadesMedicos
from Seminario.apps.tipos import *

from datetime import date

#Consultas complejas
from django.db.models import Q


class SolicitudForm(forms.Form):
    nombre =      forms.CharField(widget= forms.TextInput())
    especialidad = forms.CharField(widget= forms.TextInput())
    fecha = forms.DateField()
    def clean(self):
        return self.cleaned_data
    
         
class AtencionForm(forms.ModelForm):
    #fecha = forms.DateField( widget = forms.TextInput(attrs ={ 'id': 'datepicker'}))
    class Meta:
        model= DiaAtencion    
        exclude ={'fecha',} 
    #def clean_fecha(self):
        #aux = self.cleaned_data['fecha'].split(' ')
        #aux1 = aux[1].split('-')
        #return date(int(aux1[2]),int(aux1[1]),int(aux1[1]))               
        
    def clean(self):
        return self.cleaned_data        
    
class TurnosForm(forms.ModelForm):
    class Meta:
        model = Turno
        
class AgendaEditarForm(forms.ModelForm):
    class Meta:
        model= Agenda
        exclude ={'dia_nombre',}
        widgets = {'prestador': forms.HiddenInput}
        
        
        
class AgendaForm(forms.ModelForm):
    class Meta:
        model= Agenda
        exclude ={'dia_nombre',}
        widgets = {'prestador': forms.HiddenInput}
        
    def clean(self):
        cleaned_data = super(AgendaForm,self).clean()
        validar_dia = cleaned_data['dia']
        inicio = cleaned_data['hora_inicial']
        prestador = cleaned_data['prestador']
        fin = self.cleaned_data['hora_final']
        
        if inicio > fin :
            raise forms.ValidationError('Hora final Invalida')
                    
        if  Agenda.objects.filter(Q(dia=validar_dia) & Q(prestador=prestador) & Q(hora_final__range=( inicio,fin) )):
            raise forms.ValidationError('Rango de Hora Invalida')
            
        return cleaned_data
    

"""                
    def clean_hora_inicial(self):
        validar_dia = self.cleaned_data['dia']
        inicio = self.cleaned_data['hora_inicial']
        prestador = self.cleaned_data['prestador']
        #fin = self.cleaned_data['hora_final']
        print Agenda.objects.filter(Q(dia=validar_dia) & Q(prestador=prestador) & Q(hora_final__gte= inicio ))
        if  Agenda.objects.filter(Q(dia=validar_dia) & Q(prestador=prestador) & Q(hora_final__gte= inicio )):
            raise forms.ValidationError('Hora Inicial Invalida')
            
        else:
            return inicio
            
    def clean_hora_final(self):
        inicio = self.cleaned_data['hora_inicial']
        fin = self.cleaned_data['hora_final']
        if inicio < fin :
            return fin
        else:
            raise forms.ValidationError('Hora final Invalida')
        
"""     
"""    
    def clean_dia(self):
        validar_dia = self.cleaned_data['dia']
        prestador = self.cleaned_data['prestador']
        try:
            t = Agenda.objects.get(Q(dia=validar_dia) & Q(prestador=prestador) & Q(estado=False))
        except Agenda.DoesNotExist:      
            return validar_dia
        raise forms.ValidationError('Dia ya cargado')
""" 


         
class OsForm(forms.ModelForm):
    class Meta:
        model= ObraSocial
        
        
class AfiliacionForm(forms.ModelForm):
    class Meta:
        model = AfiliadosOS
        exclude = {'afiliado'}
        """
    def clean_obrasocial(self):
        validar_afiliado = self.cleaned_data['afiliado']
        validar_obrasocial = self.cleaned_data['obrasocial']
        try:
            a = AfiliadosOS.objects.get(Q(afiliado=validar_afiliado) & Q(obrasocial=validar_obrasocial) )
        except AfiliadosOS.DoesNotExist:
            return validar_obrasocial
        raise forms.ValidationError('Obra Social Repetida')
        
        """
class EspecialidadesMedicosForm(forms.ModelForm):
    class Meta:
        model = EspecialidadesMedicos
        exclude = {'medico','fecha_habilitacion'}        
