# Create your views here.
from django.shortcuts import render_to_response
from django.template import RequestContext


#Formularios
from Seminario.apps.home.forms import ContactForm , LoginForm , RegisterForm , UserForm
from Seminario.apps.home.models import PerfilUsuario 
#Autenticacion
from django.contrib.auth import login , logout, authenticate
from django.contrib.auth.models import User
from django.http import HttpResponseRedirect
from django.contrib.auth.decorators import login_required

#Correos
from django.core.mail import EmailMultiAlternatives #Envio Correo HTML

import django

ADMIN_MAIL = 'fabio.ger@gmail.com'



def index_view(request):
    return render_to_response('home/index.html', context_instance = RequestContext(request))

def about_view(request):
    mensaje="Aplicacionen Web - Gestion de Turnos e Historia Clinicas Unica  Desarrollado en Python 2.7, MySQL 5.4 , Django"
    version= django.get_version()
    ctx = {'msg':mensaje , 'version':version}
    return render_to_response('home/about.html',ctx, context_instance = RequestContext(request))

def contacto_view(request):
    info_enviado=False # Definir si se envio o no
    email=""
    titulo=""
    texto=""
    if request.method == "POST":
        formulario = ContactForm(request.POST)
        if formulario.is_valid():
            info_enviado=True
            email= formulario.cleaned_data['Email']
            titulo= formulario.cleaned_data['Titulo']
            texto= formulario.cleaned_data['Texto']
            #Correo 
            to_admin= ADMIN_MAIL
            html_content =  "informacion recibida de [%s] <br><br><br> **** Mensaje **** <br><br> %s"%(email,texto)
            msg = EmailMultiAlternatives('Correo de contacto',html_content,'from@server.com',[to_admin])                                                                                        
            msg.attach_alternative(html_content,'text/html')
            msg.send()
            
    else:        
        formulario=ContactForm()
    ctx = { 'form': formulario ,'email': email, 'titulo': titulo,'texto':texto,'info_enviado':info_enviado}
    return render_to_response('home/contacto.html',ctx, context_instance = RequestContext(request))

#Editar el perfil de Usuario
#@login_required
def editar_perfil_view(request):
    info='iniciando'
    usuario = User.objects.get(pk =  request.user.pk)
    if request.method == 'POST':
        info ='post'
        user_form = UserForm(request.POST)
        #perfil = PerfilUsuario.objects.get(user=request.user)
        #perfil_form = PerfilForm( request.POST, instance =perfil)
        if user_form.is_valid():# and perfil_form.is_valid():
        #if  perfil_form.is_valid():
            #Formulario valido guardar
            user_form.save()
            info='grabado'
         #   perfil_form.save()
            return HttpResponseRedirect('/')
    else:        
        user_form = UserForm()
        #perfil = PerfilUsuario.objects.get(user=request.user)
        #perfil_form = PerfilForm( instance = perfil)
    #ctx = {'user_form':user_form , 'perfil_form':perfil_form}
    ctx = {'user_form':user_form , 'informacion':info}
    return render_to_response('home/editar_perfil.html',ctx, context_instance=RequestContext(request))


def login_view(request):
    mensaje=""
    if request.user.is_authenticated():
        return HttpResponseRedirect('/')
    else:
        if request.method == "POST":
            form = LoginForm(request.POST)
            if form.is_valid():
                username = form.cleaned_data['username']
                password = form.cleaned_data['password']
                
                usuario = authenticate(username=username,password=password)
                if usuario is not None and usuario.is_active:
                    login(request,usuario)
                    return HttpResponseRedirect('/')
                else:
                    mensaje='Usuario y/o password incorrecto'
        form = LoginForm()
        ctx = {'form':form , 'mensaje':mensaje}
        return render_to_response('home/login.html',ctx, context_instance=RequestContext(request))

    
def logout_view(request):
    logout(request)
    return HttpResponseRedirect('/')

def register_view(request):
    form = RegisterForm()
    if request.method == 'POST':
        form = RegisterForm(request.POST)
        if form.is_valid():
            usuario = form.cleaned_data['username']
            email= form.cleaned_data['email']
            password_one = form.cleaned_data['password_one']
            password_two =  form.cleaned_data['password_two']
            u= User.objects.create_user(username=usuario, email=email, password=password_one)
            u.save() #guarda el objeto user
            return render_to_response('home/thanks_register.html', context_instance=RequestContext(request))
    ctx = {'form':form}
    return render_to_response('home/register.html', ctx, context_instance=RequestContext(request))
    