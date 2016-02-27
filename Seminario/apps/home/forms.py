from django import forms
from django.contrib.auth.models import User
from Seminario.apps.home.models import PerfilUsuario
from Seminario.apps.tipos import *

from django.contrib.admin import widgets
from django.forms.extras.widgets import SelectDateWidget



class ContactForm(forms.Form):
    Email = forms.EmailField(widget = forms.TextInput()) 
    Titulo = forms.CharField(widget=forms.TextInput())
    Texto = forms.CharField(widget=forms.Textarea())


class LoginForm(forms.Form):
    username = forms.CharField(label='Usuario',widget=forms.TextInput())
    password = forms.CharField(label='Password',widget=forms.PasswordInput(render_value=False))
    
class RegisterForm(forms.Form):
    username = forms.CharField(label='Ingrese Nombre de Usuario',widget=forms.TextInput())
    email =  forms.CharField(label='Ingrese Correo Electronico', widget=forms.TextInput())
    dni = forms.CharField('Nro de Documento',widget=forms.TextInput())
    password_one =  forms.CharField(label='Password', widget= forms.PasswordInput(render_value=False))
    password_two =  forms.CharField(label='Confirmar Password', widget= forms.PasswordInput(render_value=False))
    
    def clean_username(self):
        username = self.cleaned_data['username']
        try:
            u = User.objects.get(username=username)
        except User.DoesNotExist:
            return username
        raise forms.ValidationError('Nombre de Usuario ya Existe')
    
    def clean_dni(self):
        dni= self.cleaned_data['dni']
        try:
            perfil= PerfilUsuario.objects.get(pk=dni)
        except PerfilUsuario.DoesNotExist:
            return dni
        raise forms.ValidationError('DNI ya registrado')
    def clean_email(self):
        email = self.cleaned_data['email']
        try:
            u = User.objects.get(email=email)
        except User.DoesNotExist:
            return email
        raise forms.ValidationError('E-mail ya Registrado')
    
    def clean_password_two(self):
        password_one= self.cleaned_data['password_one']
        password_two = self.cleaned_data['password_two']
        if password_one == password_two:
            pass
        else:
            raise forms.ValidationError('Password no Coincide')
        
   
        
class PerfilForm(forms.ModelForm):
    first_name = forms.CharField(label=(u'Nombre'), max_length=30)
    last_name = forms.CharField(label=(u'Apellido'), max_length=30)
    dni = forms.CharField('Nro de Documento' )
    tipo =   forms.ChoiceField( choices=TIPO_DOC)
    sexo = forms.ChoiceField(choices= SEXO_CHOICE)
    photo = forms.ImageField(required=False)
    telefono = forms.CharField(max_length=30)
    direccion = forms.CharField(max_length=60)
    #fecha_nacimiento = forms.DateField(widget= SelectDateWidget(years= range(1940,2010)) )
    fecha_nacimiento = forms.DateField( widget = forms.TextInput(attrs ={ 'id': 'datepicker'}))#, input_formats = ('%d-%m-%y' ))

    def __init__(self, *args, **kw):
        super(PerfilForm, self).__init__(*args, **kw)
      
        self.fields['first_name'].initial = self.instance.user.first_name
        self.fields['last_name'].initial = self.instance.user.last_name
        self.fields['dni'].initial = self.instance.user.perfilusuario.pk
        self.fields['tipo'].initial = self.instance.user.perfilusuario.tipo
        self.fields['sexo'].initial = self.instance.user.perfilusuario.sexo
        self.fields['telefono'].initial = self.instance.user.perfilusuario.telefono
        self.fields['direccion'].initial = self.instance.user.perfilusuario.direccion
        self.fields['fecha_nacimiento'].initial = self.instance.user.perfilusuario.fecha_nacimiento
        self.fields['photo'].initial = self.instance.user.perfilusuario.photo

        self.fields.keyOrder = [
            
            'first_name',
            'last_name',
            'dni',
            'tipo',
            'sexo',
            'telefono',
            'direccion',
            'fecha_nacimiento',
            'photo',
                       
            ]

    def save(self, *args, **kw):
        super(PerfilForm, self).save(*args, **kw)
        self.instance.user.first_name = self.cleaned_data.get('first_name')
        self.instance.user.last_name = self.cleaned_data.get('last_name')
        self.instance.user.save()
    

        
    class Meta:
        model = PerfilUsuario
        fields = ('first_name','last_name','dni','tipo','sexo','telefono','direccion','fecha_nacimiento','photo')
        

class ProfileForm(forms.ModelForm):
    sexo = forms.ChoiceField(choices= SEXO_CHOICE)
    photo = forms.ImageField(required=False)
    telefono = forms.CharField(max_length=30)
    direccion = forms.CharField(max_length=60)
    fecha_nacimiento = forms.DateField( widget = forms.TextInput(attrs ={ 'id': 'datepicker'}))#, input_formats = ('%d-%m-%y' ))

    class meta:
        model=PerfilUsuario
        fields = ('sexo','telefono','direccion','fecha_nacimiento','photo')
        #exclude = {'user',}
        
    
        