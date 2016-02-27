# Create your views here.
from django.shortcuts import render_to_response
from django.template import RequestContext


#Formularios
from Seminario.apps.home.forms import ContactForm , LoginForm , RegisterForm , PerfilForm ,ProfileForm
from Seminario.apps.home.models import PerfilUsuario , Medico


#Autenticacion
from django.contrib.auth import login , logout, authenticate
from django.contrib.auth.models import User
from django.http import HttpResponseRedirect
from django.contrib.auth.decorators import login_required , user_passes_test
from django.utils.decorators import method_decorator
#Consultas complejas
from django.db.models import Q

#Correos
from django.core.mail import EmailMultiAlternatives #Envio Correo HTML
#Paginador
from django.core.paginator import Paginator, InvalidPage, EmptyPage
# historia Clinicas
#from Seminario.apps.HistoriaClinica.models import HistoriaClinica ,ExamenFisico ,HabitosToxicos
#Turnos
from Seminario.apps.turnos.models import EspecialidadesMedicos

from django.views.generic import UpdateView ,DeleteView ,ListView ,CreateView , DetailView ,TemplateView
from django.core.urlresolvers import reverse_lazy

import django







from django.template import RequestContext
from django.shortcuts import render_to_response
#from django.contrib.auth import User
import datetime
from Seminario.apps.qsstats import QuerySetStats
#import qsstats

def estadisticas(request):

    GOOGLE_API_KEY = 'clave'

    qs = User.objects.all()
    qss = QuerySetStats(qs, 'date_joined')

    hoy = datetime.date.today()
    hace_2_semanas = hoy - datetime.timedelta(weeks=2)

    users_stats = qss.time_series(hace_2_semanas, hoy)

    return render_to_response('estadisticas.html', locals(), context_instance=RequestContext(request))




















ADMIN_MAIL = 'fabio.ger@gmail.com'

def is_medico(user):
    return user.groups.filter(name='Medicos')

def is_admin(user):
    return user.groups.filter(name='Administradores')

def is_admin_or_medico(user):
    return user.groups.filter( Q(name='Administradores') | Q (name='Medicos'))


def index_view(request):
    if request.user.is_authenticated() :

        
        if is_medico(request.user):         

 
                medico =  Medico.objects.get(user=request.user)
                #print medico
                matricula= medico.matricula
                #return HttpResponseRedirect(reverse_lazy('vista_medicos_detalle'))
                return HttpResponseRedirect('/medicos/detalle/'+matricula)
            

            
            #return render_to_response('medicos/detalle.html', context_instance = RequestContext(request))
            
        else:
            return render_to_response('home/index.html', context_instance = RequestContext(request))

        
    else:
        return render_to_response('home/principal.html', context_instance = RequestContext(request))
        

def about_view(request):
    mensaje="Aplicacion Web - Gestion de Turnos e Historia Clinicas Unica  "
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
@login_required
def editar_perfil_view(request):
    info=''
    if request.method == 'POST':
        perfil_form = PerfilForm( request.POST,request.FILES, instance =request.user.perfilusuario)
        #if user_form.is_valid() and perfil_form.is_valid():
        if perfil_form.is_valid():
            #Formulario valido guardar            
            try:
                perfil_form.save()
                info='guardado'
            except:
                info="error"
            #return HttpResponseRedirect('/')
    else:    
        perfil = PerfilUsuario.objects.get(user=request.user)
        perfil_form = PerfilForm( instance = perfil)    
    ctx = {'form':perfil_form, 'informacion':info}
    return render_to_response('home/editar_perfil.html',ctx, context_instance=RequestContext(request))


class PerfilUpdate(UpdateView):
    model = PerfilUsuario
    form_class = ProfileForm
    template_name="home/perfil_update.html"
    
    @method_decorator(user_passes_test(is_admin_or_medico))
    def dispatch(self,*args, **kwargs):
        return super( PerfilUpdate,self).dispatch(*args, **kwargs)
        
    def get_context_data(self,**kargs):
        context = super( PerfilUpdate, self).get_context_data(**kargs)
        perfil =  PerfilUsuario.objects.get(pk=self.kwargs.get('pk'))        
        context['usuario']= perfil.user    
        return context




class  UserUpdate(UpdateView):
    model = User
    exclude = {'email'}    
    template_name= "home/user_update.html"
    
    @method_decorator(user_passes_test(is_admin))
    def dispatch(self,request,*args, **kwargs):
        return super( UserUpdate, self).dispatch(request,*args, **kwargs)
        
        
    def get_success_url(self):
        return reverse_lazy('vista_perfil',args=(self.kwargs.get('pk'),))

    def get_context_data(self,**kargs):
        context = super( UserUpdate, self).get_context_data(**kargs)
        user =  User.objects.get(pk=self.kwargs.get('pk'))        
        context['usuario']= user    
        return context



def register_view(request):
    form = RegisterForm()
    if request.method == 'POST':
        form = RegisterForm(request.POST)
        if form.is_valid():
            usuario = form.cleaned_data['username']
            email= form.cleaned_data['email']
            dni= form.cleaned_data['dni']
            password_one = form.cleaned_data['password_one']
            password_two =  form.cleaned_data['password_two']
            u= User.objects.create_user(username=usuario, email=email, password=password_one)
            u.groups.add(2) #Agregar al Grupo Pacientes            
            u.save() #guarda el objeto user
            #User.profile = property( lambda u: PerfilUsuario.objects.get_or_create(user = u)[0])
            #p = PerfilUsuario.crear_perfil( instance=u, dni=dni, created=True)
            #Mejorar la Creacion de Perfil de Usuario
            p= PerfilUsuario.objects.create(user=u,dni=dni,tipo='',sexo='',telefono='',direccion='',fecha_nacimiento='1900-01-01',photo='MultimediaData/Users/anonimo.jpg')
            #return render_to_response('home/index.html', context_instance=RequestContext(request))
            #return render_to_response('home/index.html', context_instance=RequestContext(request))
            #return reverse_lazy('vista_user_update')
            return HttpResponseRedirect(reverse_lazy('vista_user_update',args=(u.id,)))
            #return HttpResponseRedirect('/perfil/update/'+str(u.id))
        
        
    ctx = {'form':form}
    return render_to_response('home/register.html', ctx, context_instance=RequestContext(request))


def register_byuser_view(request):
    form = RegisterForm()
    if request.method == 'POST':
        form = RegisterForm(request.POST)
        if form.is_valid():
            usuario = form.cleaned_data['username']
            email= form.cleaned_data['email']
            dni= form.cleaned_data['dni']
            password_one = form.cleaned_data['password_one']
            password_two =  form.cleaned_data['password_two']
            u= User.objects.create_user(username=usuario, email=email, password=password_one)
            u.groups.add(2) #Agregar al Grupo Pacientes            
            u.save() #guarda el objeto user
            
            p= PerfilUsuario.objects.create(user=u,dni=dni,tipo='',sexo='',telefono='',direccion='',fecha_nacimiento='1900-01-01',photo='MultimediaData/Users/anonimo.jpg')
       
            return HttpResponseRedirect(reverse_lazy('vista_login'))
            
        
        
    ctx = {'form':form}
    return render_to_response('home/register.html', ctx, context_instance=RequestContext(request))


@login_required
def perfil_view(request,id_paciente):    
    informacion=''
    paciente = User.objects.get(id=id_paciente)
    grupos = paciente.groups.all()    
    ctx = {'paciente':paciente, 'grupos':grupos, 'informacion':informacion}
    return render_to_response('home/ver_perfil.html', ctx, context_instance=RequestContext(request))
    
@user_passes_test(is_admin_or_medico)
def listar_pacientes_view(request, pagina): #productos paginado
    
    if request.method == 'POST':
        
        
        lista_pacientes= User.objects.filter(Q(groups=2) & ( Q(first_name__contains= request.POST['query']) | Q(last_name__contains= request.POST['query']) | Q(perfilusuario__dni__contains=request.POST['query'])))
    else:
        lista_pacientes= User.objects.filter(groups=2).order_by('last_name')
        #Filtrado por Pacientes
    paginator = Paginator(lista_pacientes,5) # paginamos con 3 productos
    try:
        page = int(pagina)
    except:
        page= 1
    try:
        pagina_pacientes =  paginator.page(page)
    except (EmptyPage, InvalidPage):
        pagina_pacientes= paginator.page(paginator.num_pages)
     
    #lista_pacientes= User.objects.all()
    ctx = {'pacientes': lista_pacientes}
    return render_to_response('home/lista_pacientes.html',ctx, context_instance = RequestContext(request))


class PacientesListar(ListView):
    model = User
    paginate_by = '20'
    context_object_name =  'pacientes'
          
    template_name="home/lista_pacientes.html"
    def get_queryset(self):
        #queryset = super(listar_os , self).get_query_set()
        if self.request.GET.get('query') :
            try:
                return User.objects.filter(Q(groups=2) & ( Q(first_name__contains= self.request.GET['query']) | Q(last_name__contains= self.request.GET['query']) | Q(perfilusuario__dni__contains=self.request.GET['query'])))
                
                #return User.objects.filter( Q(matricula= self.request.GET.get('query')) | Q(user__last_name__contains= self.request.GET.get('query')) | Q(user__first_name__contains= self.request.GET.get('query')))
            except:
                return  User.objects.all()
                #return Medico.objects.filter( Q(user__last_name__contains= self.request.GET.get('query')))

        return  User.objects.all()


class MedicosListar(ListView):
    model = Medico
    paginate_by = '10'
    context_object_name =  'medicos'
    #queryset = Medico.objects.all()        
    template_name="home/lista_medicos.html"
    def get_queryset(self):
        #queryset = super(listar_os , self).get_query_set()
        if self.request.GET.get('query') :
            try:
                return Medico.objects.filter( Q(matricula= self.request.GET.get('query')) | Q(user__last_name__contains= self.request.GET.get('query')) | Q(user__first_name__contains= self.request.GET.get('query')))
            except:
                return Medico.objects.filter( Q(user__last_name__contains= self.request.GET.get('query')))
        return Medico.objects.all()
    
    
    
class MedicosAgregar(CreateView):
    template_name="home/medicos_form.html"
    model = Medico
  
    @method_decorator(user_passes_test(is_admin))
    def dispatch(self,request,*args, **kwargs):
        return super( MedicosAgregar, self).dispatch(request,*args, **kwargs)
    
    def form_valid(self, form):
        user= form.instance.user
        user.groups.add(3)
        form.save(commit=False)
        return super( MedicosAgregar, self ).form_valid(form)
    
    
class  MedicosView(DetailView):  
    model= Medico
    template_name= "home/medicos.html"
    context_object_name = "medico"
    
    def get_context_data(self,**kargs):
        context = super( MedicosView, self).get_context_data(**kargs)
        medico =  Medico.objects.get(pk=self.kwargs.get('pk'))
        
        context['especialidades']= EspecialidadesMedicos.objects.filter(medico=medico)
    
        return context
    
 
def MedicosPrincipal(request):    
            
    medico =  Medico.objects.get(user=request.user)
    print medico
    matricula= medico.matricula
    #return HttpResponseRedirect(reverse_lazy('vista_medicos_detalle'))
    return HttpResponseRedirect('/medicos/detalle/'+matricula)
    
    
class MedicosUpdate(UpdateView):
    model = Medico
    template_name= "home/medicos_form.html"
    
    @method_decorator(user_passes_test(is_admin))
    def dispatch(self,request,*args, **kwargs):
        return super( MedicosUpdate, self).dispatch(request,*args, **kwargs)
    
    
    
class MedicosDelete(DeleteView):
    model = Medico
    context_object_name = "medico"
    success_url = reverse_lazy('vista_medicos')

    """    
    def post(self,request,*args ,**kwargs):
        #eliminar del grupo medicos
        medico = Medico.objects.get(matricula= self.kwargs.get('pk'))
        medico.user.groups.remove(3)
 
        #return super(MedicosDelete,self).post(self,request,*args ,**kwargs)
    
    @method_decorator(user_passes_test(is_admin))
    def dispatch(self,request,*args, **kwargs):
        return super( MedicosDelete, self).dispatch(request,*args, **kwargs)
    
    """     
    def delete(self,request, *args, **kwargs):
        self.object = self.get_object()
        #id_hce = self.object.historia_clinica.id
        #success_url= reverse_lazy('vista_receta_detalle', args=(self.object.id,))
        #self.object.delete()
        #medico = Medico.objects.get(matricula= self.kwargs.get('pk'))
        self.object.user.groups.remove(3)
        
        self.object.estado=False
        self.object.save()
        return HttpResponseRedirect(self.success_url)
    

        

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
                    if request.user.get_full_name():
                        return HttpResponseRedirect('/')
                    else:                        
                        return HttpResponseRedirect(reverse_lazy('vista_editar_perfil'))
                else:
                    mensaje='Usuario y/o password incorrecto'
        form = LoginForm()
        ctx = {'form':form , 'mensaje':mensaje}
        return render_to_response('home/login.html',ctx, context_instance=RequestContext(request))


def logout_view(request):
    logout(request)
    return HttpResponseRedirect('/')


