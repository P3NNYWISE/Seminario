from django import forms
from django.forms.models import inlineformset_factory

from Seminario.apps.HistoriaClinica.models import HistoriaClinica ,ExamenFisico,HabitosToxicos , Fisiologicos,Patologicos,Perinatales,ConsultaMedica ,Cie10 ,Laboratorio,PracticaMedica ,PracticaDetalle ,Receta,RecetaDetalle,Inos
from Seminario.apps.turnos.models import   AfiliadosOS
from Seminario.apps.tipos import *

from datetime import date

#Consultas complejas
from django.db.models import Q
#Admin Widget
from django.contrib.admin.widgets import FilteredSelectMultiple
from django.shortcuts import render_to_response



class HistoriaClinicaForm(forms.ModelForm):
    class Meta:
        model= HistoriaClinica
        exclude ={'paciente','fecha_creacion','prestador'} 

class ExamenFisicoForm(forms.ModelForm):
    class Meta:
        model= ExamenFisico
        exclude ={'historia_clinica','fecha_examen',}

class HabitosToxicosForm(forms.ModelForm):
    class Meta:
        model= HabitosToxicos
        exclude ={'historia_clinica','fecha',}
        
class FisiologicosForm(forms.ModelForm):
    class Meta:
        model= Fisiologicos
        exclude ={'historia_clinica','fecha'}
        
class PatologicosForm(forms.ModelForm):
    class Meta:
        model= Patologicos
        exclude ={'historia_clinica','fecha'}
        
class PerinatalesForm(forms.ModelForm):
    class Meta:
        model= Perinatales
        exclude ={'historia_clinica','fecha'}
             
class ConsultaForm(forms.ModelForm):
    motivos_consulta=forms.CharField(widget = forms.Textarea(attrs={'rows':'2','cols':'50'} ))
    #sintomas=forms.CharField(widget = forms.Textarea(attrs={'rows':'2','cols':'50'} ) )
    #terapeutica=forms.CharField(widget = forms.Textarea(attrs={'rows':'2','cols':'50'} ))
    #observaciones=forms.CharField(widget = forms.Textarea(attrs={'rows':'2','cols':'50'} ))
    
    diagnosticos = forms.ModelMultipleChoiceField(Cie10.objects.all(), widget= FilteredSelectMultiple("Cie10",False))
    
    def __init__(self, *args , **kwargs):
        super(ConsultaForm,self).__init__(*args,**kwargs)
        self.fields['sintomas'].widget.attrs['rows'] = 2
        self.fields['terapeutica'].widget.attrs['rows'] = 2
        self.fields['observaciones'].widget.attrs['rows'] = 2
        
        
    
    """
    class media:
        css = {
            'all':('/media/css/widgets.css',),
        }
        # jsi18n is required by the widget
        js = ('/media/js/jsi18n/',)
"""
    class Meta:
        model= ConsultaMedica    
        exclude ={'historia_clinica','prestador','fecha','os_consulta','estado'}
        #exclude ={'historia_clinica','prestador','fecha'}
    
class LaboratorioForm(forms.ModelForm):
    class Meta:
        model =  Laboratorio
        exclude ={'historia_clinica','prestador','fecha'}

    def __init__(self, *args , **kwargs):
        super(LaboratorioForm,self).__init__(*args,**kwargs)
        self.fields['analisis'].queryset =  Inos.objects.filter(capitulo__tipo ='ANC')


class PracticaForm(forms.ModelForm):
    
    #resultados=forms.CharField(widget = forms.Textarea(attrs={'rows':'2','cols':'50'} ))
    #observaciones=forms.CharField(widget = forms.Textarea(attrs={'rows':'2','cols':'50'} ))
    
    def __init__(self, *args , **kwargs):
        super( PracticaForm,self).__init__(*args,**kwargs)
        self.fields['resultados'].widget.attrs['rows'] = 4
        self.fields['observaciones'].widget.attrs['rows'] = 2
        
    
    
    class Meta:
        model =  PracticaMedica
        exclude ={'historia_clinica','prestador','fecha','practicas','efector','fecha_modificado','estado', 'os_prescripcion'}
        #exclude ={'historia_clinica','fecha','practicas',}



PracticaFormSet = inlineformset_factory(PracticaMedica,PracticaDetalle , extra = 1)

class RealizacionPracticaForm(forms.ModelForm):
    
    #resultados=forms.CharField(widget = forms.Textarea(attrs={'rows':'2','cols':'50'} ))
    #observaciones=forms.CharField(widget = forms.Textarea(attrs={'rows':'2','cols':'50'} ))
    
    def __init__(self, *args , **kwargs):
        super( RealizacionPracticaForm,self).__init__(*args,**kwargs)
        self.fields['resultados'].widget.attrs['rows'] = 4
        self.fields['observaciones'].widget.attrs['rows'] = 2
        
    
    
    class Meta:
        model =  PracticaMedica
        exclude ={'historia_clinica','prestador','efector','fecha','practicas','fecha_modificado','os_prescripcion'}
        #exclude ={'historia_clinica','fecha','practicas',}


class RecetaForm(forms.ModelForm):
    
    #resultados=forms.CharField(widget = forms.Textarea(attrs={'rows':'2','cols':'50'} ))
    #observaciones=forms.CharField(widget = forms.Textarea(attrs={'rows':'2','cols':'50'} ))
    
    def __init__(self, *args , **kwargs):
        super( RecetaForm,self).__init__(*args,**kwargs)
        self.fields['observaciones'].widget.attrs['rows'] = 4
        #self.fields['observaciones'].widget.attrs['rows'] = 2
        
    
    
    class Meta:
        model =  Receta
        exclude ={'historia_clinica','prestador','fecha','medicamentos','estado', 'os_receta'}
        #exclude ={'historia_clinica','fecha','practicas',}



MedicamentoFormSet = inlineformset_factory(Receta,RecetaDetalle , extra = 1)



"""         
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
        
class AgendaForm(forms.ModelForm):
    class Meta:
        model= Agenda
        exclude ={'estado',}
    
    def clean_dia(self):
        validar_dia = self.cleaned_data['dia']
        prestador = self.cleaned_data['prestador']
        try:
            t = Agenda.objects.get(Q(dia=validar_dia) & Q(prestador=prestador) & Q(estado=False))
        except Agenda.DoesNotExist:
            return validar_dia
        raise forms.ValidationError('Dia ya cargado')
"""            

