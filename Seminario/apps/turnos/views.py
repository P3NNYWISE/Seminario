# Create your views here.

from Seminario.apps.turnos.models import Especialidad ,EspecialidadesMedicos , Agenda , DiaAtencion ,Turno, ObraSocial , AfiliadosOS
from Seminario.apps.home.models import Medico

from django.contrib.auth.models import User

#Consultas complejas
from django.db.models import Q
#Paginador
from django.core.paginator import Paginator, InvalidPage, EmptyPage

from Seminario.apps.tipos import *

# plantillas
from django.shortcuts import render_to_response , HttpResponseRedirect ,HttpResponse
from django.template import RequestContext
from Seminario.apps.turnos.forms import SolicitudForm ,AtencionForm , AgendaForm , OsForm , AfiliacionForm ,EspecialidadesMedicosForm ,AgendaEditarForm

#Formularioas
from django import forms


from django.views.generic import TemplateView, ListView , CreateView ,DetailView,UpdateView ,DeleteView
from django.views.generic.dates import ArchiveIndexView 
#from django.views.generic.edit import UpdateView
from django.core.urlresolvers import reverse_lazy
from django.core.urlresolvers import reverse


#serializers
from django.http import HttpResponse
# Serializacion
from django.core import serializers
from django.utils import simplejson
from django.core.serializers.json import DjangoJSONEncoder


#Fechas
from datetime import date
from datetime import date,datetime

# PDFs
from Seminario.apps.turnos.reportes import especialidad_pdf ,turnos_pdf , generar_pdf_comprobante


def listar_especialidades_view(request, pagina): #productos paginado
    if request.method == 'POST':
        lista_esp= Especialidad.objects.filter(nombre__contains=request.POST['query'])
    else:
        lista_esp= Especialidad.objects.all()
    paginator = Paginator(lista_esp,15) # paginamos con 3 productos
    try:
        page = int(pagina)
    except:
        page= 1
    try:
        pagina_esp =  paginator.page(page)
    except (EmptyPage, InvalidPage):
        pagina_esp= paginator.page(paginator.num_pages)
        
    ctx = {'especialidades':pagina_esp}
    return render_to_response('turnos/lista_especialidades.html',ctx, context_instance = RequestContext(request))
    
def listar_medicos_view(request,id_esp,pagina):
    if request.method == 'POST':
        lista_medicos= EspecialidadesMedicos.objects.filter(Q(especialidad= id_esp) &( Q(medico__user__last_name__contains=request.POST['query'])  | Q(medico__user__first_name__contains=request.POST['query'])))
    else:
        lista_medicos = EspecialidadesMedicos.objects.filter(especialidad= id_esp) #estado
    especialidad = Especialidad.objects.get(pk =  id_esp)
        
    paginator = Paginator(lista_medicos,15) # paginamos con 3 productos
    try:
        page = int(pagina)
    except:
        page= 1
    try:
        pagina_medicos =  paginator.page(page)
    except (EmptyPage, InvalidPage):
        pagina_medicos= paginator.page(paginator.num_pages)
        
    ctx = {'medicos':pagina_medicos, 'especialidad':especialidad}
    return render_to_response('turnos/turnos_medicos.html',ctx, context_instance = RequestContext(request))
    
    
def agenda_medicos_view(request,id_esp_med,pagina):
    
    prestador= EspecialidadesMedicos.objects.get(id=id_esp_med)
    agenda_medicos = Agenda.objects.filter( prestador= prestador)
    paginator = Paginator(agenda_medicos,15) # paginamos con 3 productos
    try:
        page = int(pagina)
    except:
        page= 1
    try:
        pagina_agenda =  paginator.page(page)
    except (EmptyPage, InvalidPage):
        pagina_agenda= paginator.page(paginator.num_pages)
        
    ctx = {'agenda':pagina_agenda, 'prestador':prestador}
    return render_to_response('turnos/agenda_medicos.html',ctx, context_instance = RequestContext(request))

class AgendaListar(ListView):
    model = Agenda
    paginate_by = '15'
    ##query_set = ObraSocial.objects.all()
    context_object_name = "agenda"
    template_name = "turnos/agenda_medicos.html"
    def get_context_data(self,**kargs):
        context = super( AgendaListar, self).get_context_data(**kargs)
        prestador= EspecialidadesMedicos.objects.get(pk = self.kwargs.get('id_esp_med'))
        context['prestador']= prestador
        return context

    
    def get_queryset(self):
        prestador= EspecialidadesMedicos.objects.get(pk = self.kwargs.get('id_esp_med'))
        agenda = Agenda.objects.filter(prestador=prestador).order_by('dia','hora_inicial')
        return agenda
        
class AgendaAgregar(CreateView):
    model = Agenda
    template_name=  "turnos/addagenda.html"
    form_class =  AgendaForm
    hidden_fields= ['prestador']
    
    def form_valid(self, form):
        prestador = EspecialidadesMedicos.objects.get(id = self.request.POST.get('prestador'))
        form.instance.prestador = prestador
        form.instance.dia_nombre=DIA_CHOICES[form.instance.dia][1]
        
        #grabar seleccion del combobox
        try:
            #self.object.full_clean()
            form.save(commit=False)
            return super( AgendaAgregar, self ).form_valid(form)
        except:
            from django.forms.util import ErrorList
            form._errors["dia"]= ErrorList([u"Error ya Cargada"])            
            return super( AgendaAgregar, self ).form_invalid(form)

    
    def get_context_data(self,**kargs):
        context = super( AgendaAgregar, self).get_context_data(**kargs)
        prestador= EspecialidadesMedicos.objects.get(pk = self.kwargs.get('id_esp_med'))
        context['prestador']= prestador
        context['agregar']= True
        return context
    
    def get_initial(self):
        prestador= EspecialidadesMedicos.objects.get(pk = self.kwargs.get('id_esp_med'))
        print prestador
        return {'prestador' : prestador}

class AgendaEditar(UpdateView):
    model = Agenda
    form_class =  AgendaEditarForm
    template_name= "turnos/addagenda.html"
    
    def form_valid(self, form):   
        form.instance.dia_nombre=DIA_CHOICES[form.instance.dia][1]
        try:
            #self.object.full_clean()
            form.save(commit=False)
            return super( AgendaEditar, self ).form_valid(form)
        except:
            from django.forms.util import ErrorList
            form._errors["dia"]= ErrorList([u"Error ya Cargada"])            
            return super( AgendaEditar, self ).form_invalid(form)

    def get_context_data(self,**kargs):
        context = super( AgendaEditar, self).get_context_data(**kargs)
        agenda = Agenda.objects.get(pk = self.kwargs.get('pk') )
        prestador= EspecialidadesMedicos.objects.get(pk = agenda.prestador.id)
        context['prestador']= prestador
        
        return context
    
    
class AgendaDelete(DeleteView):
    model = Agenda
    context_object_name = "agenda"
#    success_url = reverse('vista_agenda', kwargs={'id_esp_med':int(self.prestador.id)} ) 
    def delete(self,request, *args, **kwargs):
        self.object = self.get_object()
        id_prestador = self.object.prestador.id
        success_url= reverse_lazy('vista_agenda', args=(id_prestador,))
        self.object.delete()
        return HttpResponseRedirect(success_url)
    

     
def agregar_agenda_view(request,id_esp_med):
    info = "Agregar"
    prestador = EspecialidadesMedicos.objects.get( pk= id_esp_med) #estado
    if request.method == 'POST':
        form = AgendaForm(request.POST , request.FILES)
        if form.is_valid() :
            add = form.save(commit=False)
            add.estado = True
            add.save() #guardamos la informacion
            #form.save_m2m() # guardamos la relacion manyTomany
            info = 'Guardado Satisfactoriamente'
            return HttpResponseRedirect('/turnos/agenda/%s/page/1' % id_esp_med)
            
    else:
        form = AgendaForm(initial={'prestador': prestador})
    
    ctx = {'form':form, 'informacion':info}
    return render_to_response('turnos/addagenda.html', ctx, context_instance=RequestContext(request))

def edit_agenda_view(request,id_agenda):
    info='Editar'
    agenda = Agenda.objects.get(pk=id_agenda)
    prestador = EspecialidadesMedicos.objects.get(id = agenda.prestador.id)
    agenda.estado= False
    if request.method == 'POST':
        form = AgendaForm(request.POST , request.FILES, instance=agenda)
        if form.is_valid():
            edit_agenda = form.save(commit=False)
            edit_agenda.estado = True
            edit_agenda.save()
            #form.save_m2m()
            info='Correcto'
            #return HttpResponseRedirect('/producto/%s' % edit_prod.id)
            return HttpResponseRedirect('/turnos/agenda/%s/page/1' % edit_agenda.prestador.id)
    
    else:
        form = AgendaForm(instance=agenda)
    ctx = {'form':form, 'informacion':info , 'prestador': prestador}
    return render_to_response('turnos/addagenda.html', ctx, context_instance=RequestContext(request))

"""
def turnos_medicos_view(request,id_esp_med,pagina):
    #prestador = EspecialidadesMedicos.objects.filter( pk= id_esp_med) #estado
    turnos_medicos = Turnos.objects.filter( prestador= id_esp_med) #estado 
    paginator = Paginator(turnos_medicos,7) # paginamos con 3 productos
    try:
        page = int(pagina)
    except:
        page= 1
    try:
        pagina_turnos =  paginator.page(page)
    except (EmptyPage, InvalidPage):
        pagina_turnos= paginator.page(paginator.num_pages)
        
    ctx = {'turnos':pagina_turnos,'prestador':prestador}
    return render_to_response('turnos/turnos_listado.html',ctx, context_instance = RequestContext(request))


def backsolicitud_turnos_view(request, id_esp_med ):
    prestador = EspecialidadesMedicos.objects.get( pk= id_esp_med) #estado
    informacion=''
    
    if request.method == 'POST'  : 
        #Valida Fecha y guardar e
        if request.POST['fecha'] :
                
            fecha_consulta = request.POST['fecha'].split(' ')
                
            dia = fecha_consulta[0]
            fecha = fecha_consulta[1]
        
            try:
                dia_atencion = DiaAtencion.objects.filter(prestador= prestador,fecha = fecha )
                print dia_atencion
                listado= []
                for d in dia_atencion :
                    turnos= Turno.objects.filter(dia_atencion=d )
                    turno = turnos.filter(paciente=request.user)
                    if turno :
                        reserva = True
                    else:
                        reserva= False
                    listado.append(turnos)   
                
                ctx = {'listado':listado, 'prestador':prestador , 'dia_atencion':dia_atencion,'reserva': reserva, 'turno':turnos[0]}
                
                return render_to_response('turnos/turnos_listado.html',ctx, context_instance = RequestContext(request))
            except  DiaAtencion.DoesNotExist :
                    informacion = 'Fecha Sin Atencion'
                    #return nHttpResponseRedirect('/turnos/solicitud/%s'%id_esp_med)
        else:
            informacion = "Ingrese una Fecha Valida"
    
    dia_atencion = DiaAtencion.objects.filter(prestador= prestador).filter(fecha__gte= date.today())            
    ctx = {'prestador':prestador, 'informacion':informacion , 'dia_atencion':dia_atencion}
    return render_to_response('turnos/turnos_solicitud.html',ctx, context_instance = RequestContext(request))
"""
def solicitud_turnos_view(request, id_esp_med ):
    prestador = EspecialidadesMedicos.objects.get( pk= id_esp_med) #estado
    informacion=''
    dia_atenciones = DiaAtencion.objects.filter(prestador= prestador).filter(fecha__gte= date.today()).order_by('fecha')
    print dia_atenciones
    if request.method == 'POST'  : 
        #Valida Fecha y guardar e
        if request.POST['fecha'] :
                
            fecha_consulta = request.POST['fecha'].split(' ')
                
            dia = fecha_consulta[0]
            fecha = fecha_consulta[1]
        
            try:
                dia_atencion = DiaAtencion.objects.filter(prestador= prestador,fecha = fecha )
                
                listado= []
                for d in dia_atencion :
                    turnos= Turno.objects.filter(dia_atencion=d )
                    #controla q el usuario ya tenga turno
                    turno = turnos.filter(paciente=request.user)
                    if turno :
                        reserva = True
                    else:
                        reserva= False
                    listado.append(turnos)   
                    duracion =  turnos[1].hora_turno.minute- turnos[0].hora_turno.minute
                    #dia_atenciones = DiaAtencion.objects.filter(prestador= prestador).filter(fecha__gte= date.today())
             
                         
               
                ctx = {'listado':listado, 'prestador':prestador , 'dia_atencion':dia_atencion[0],'reserva': reserva, 'duracion':duracion ,'dia_atenciones':dia_atenciones}
                
                return render_to_response('turnos/turnos_listado.html',ctx, context_instance = RequestContext(request))
            except  DiaAtencion.DoesNotExist :
                    informacion = 'Fecha Sin Atencion'
                    #return nHttpResponseRedirect('/turnos/solicitud/%s'%id_esp_med)
        else:
            informacion = "Ingrese una Fecha Valida"
    #hasta aki
    #dia_atencion = DiaAtencion.objects.filter(prestador= prestador).filter(fecha__gte= date.today())            
    if dia_atenciones :
        
        dia_activo= dia_atenciones[0]
    else:
        
        dia_activo = False

    ctx = {'prestador':prestador, 'informacion':informacion , 'dia_atenciones':dia_atenciones ,'dia_atencion':dia_activo}
    #return render_to_response('turnos/turnos_solicitud.html',ctx, context_instance = RequestContext(request))
    return render_to_response('turnos/turnos_listado.html',ctx, context_instance = RequestContext(request))

class ConsultaReservaListar(ArchiveIndexView):#ListView):
    model = Turno
    paginate_by = '15'
    date_field = "fecha_creacion"
    ##query_set = ObraSocial.objects.all()
    context_object_name = "reservas"
    template_name = "turnos/lista_turnos_reservas.html"
    allow_empty = True    
    def get_queryset(self):
        #queryset = super(listar_os , self).get_query_set()
        if self.request.GET.get('query') :
            return ObraSocial.objects.filter( Q(nombre__contains= self.request.GET.get('query')) | Q(cuit__contains= self.request.GET.get('query')))
        else:
            return Turno.objects.filter(Q(paciente=self.request.user) & Q(dia_atencion__fecha__gte=date.today()))

class TurnoCancelar(DeleteView):
    model = Turno
    context_object_name = "turno"
    success_url = reverse_lazy('vista_turnos_reservas')
    
    def delete(self,request, *args, **kwargs):
        self.object = self.get_object()
        self.object.paciente = None
        success_url= self.get_success_url()
        self.object.save()
        return HttpResponseRedirect(success_url)


def consulta_turnos_view(request, id_esp_med ):
    """
    Funcion con Acceso solo para el profesional
    """
    prestador = EspecialidadesMedicos.objects.get( pk= id_esp_med) #estado
    informacion=''
    dia_atenciones = DiaAtencion.objects.filter(prestador= prestador).filter(fecha__gte= date.today()).order_by('fecha')
    
    if request.method == 'POST'  : 
        #Valida Fecha y guardar e
        if request.POST['fecha'] :
                
            fecha_consulta = request.POST['fecha'].split(' ')
                
            dia = fecha_consulta[0]
            fecha = fecha_consulta[1]
        
            try:
                dia_atencion = DiaAtencion.objects.filter(prestador= prestador,fecha = fecha )
                
                listado= []
                for d in dia_atencion :
                    turnos= Turno.objects.filter(dia_atencion=d )
                    #controla q el usuario ya tenga turno
                    turno = turnos.filter(paciente=request.user)
                    if turno :
                        reserva = True
                    else:
                        reserva= False
                    listado.append(turnos)   
                    duracion =  turnos[1].hora_turno.minute- turnos[0].hora_turno.minute

                                 
                         
               
                ctx = {'listado':listado, 'prestador':prestador , 'dia_atencion':dia_atencion[0],'reserva': reserva, 'duracion':duracion , 'dia_atenciones':dia_atenciones}
                
                return render_to_response('turnos/turnos_planillas.html',ctx, context_instance = RequestContext(request))
            except  DiaAtencion.DoesNotExist :
                    informacion = 'Fecha Sin Atencion'
                    #return nHttpResponseRedirect('/turnos/solicitud/%s'%id_esp_med)
        else:
            informacion = "Ingrese una Fecha Valida"
    if dia_atenciones :
        
        dia_activo= dia_atenciones[0]
    else:
        
        dia_activo = False
    
    
    #dia_atencion = DiaAtencion.objects.filter(prestador= prestador).filter(fecha__gte= date.today())            
    ctx = {'prestador':prestador, 'informacion':informacion , 'dia_atencion':dia_activo,'dia_atenciones':dia_atenciones}
    return render_to_response('turnos/turnos_planillas.html',ctx, context_instance = RequestContext(request))


def CalendarEvents(request,id_esp_med):
    turnos=[]        
    prestador = EspecialidadesMedicos.objects.get( pk= id_esp_med) #estado
    dia_atencion = DiaAtencion.objects.filter(prestador= prestador , fecha__gte = date.today())
    for dia in dia_atencion:
        turnos_data = Turno.objects.filter(dia_atencion=dia)
        duracion = turnos_data[1].hora_turno.minute - turnos_data[0].hora_turno.minute    
        end = turnos_data[0].hora_turno
        h =  end.hour
        m= end.minute                        
        for turno in turnos_data:
            m= m + duracion
            if m >= 60 :                                   
                h = h +1
                m=m-60
            #end = end.replace( hour= h, minute=m)
            #print end  
            evento= datetime(turno.dia_atencion.fecha.year,turno.dia_atencion.fecha.month,turno.dia_atencion.fecha.day,turno.hora_turno.hour,turno.hora_turno.minute)
            start = evento.strftime("%Y-%m-%d %H:%M") 
            
            evento= datetime(turno.dia_atencion.fecha.year,turno.dia_atencion.fecha.month,turno.dia_atencion.fecha.day,h,m)
            end = evento.strftime("%Y-%m-%d %H:%M")
            titulo = turno.get_paciente_name()
            if (titulo =='') :
                color=''
            else:
                color='red'
            
            
            turnos.append({'id':turno.id ,'title':turno.get_paciente_name() ,'start':start, 'end':end ,'allDay':False , 'backgroundColor':  color })
        
    # retornamos en formato Json
    #return HttpResponse(data , mimetype= "aplication/"+tipo)
    return HttpResponse(simplejson.dumps(turnos,cls= DjangoJSONEncoder), mimetype='aplication/json')    
        
    
    
    














def listado_turnos_view(request,id_esp_med,pagina):
    agenda_medicos = Agenda.objects.filter( prestador= id_esp_med) #estado .order_by('dia')
    paginator = Paginator(agenda_medicos,7) # paginamos con 3 productos
    try:
        page = int(pagina)
    except:
        page= 1
    try:
        pagina_turnos =  paginator.page(page)
    except (EmptyPage, InvalidPage):
        pagina_turnos= paginator.page(paginator.num_pages)
        
    ctx = {'turnos':pagina_turnos, 'id_prestador':id_esp_med}
    return render_to_response('turnos/turnos_listado.html',ctx, context_instance = RequestContext(request))
"""
def reservar_turno_view(request,id_turno):
    reserva = True
    turno = Turno.objects.get(id=id_turno)
    turno.paciente= request.user
    turno.save()
    dia_atencion = DiaAtencion.objects.get(prestador= turno.dia_atencion.prestador,fecha = turno.dia_atencion.fecha )
    turnos = Turno.objects.filter(dia_atencion=dia_atencion )
    ctx = {'turnos':turnos, 'prestador':turno.dia_atencion.prestador , 'dia_atencion':turno.dia_atencion,'reserva':reserva}
    return render_to_response('turnos/turnos_listado.html',ctx, context_instance = RequestContext(request))
"""    
def reservar_turno_view(request,id_turno):
    #reserva = True
    turno = Turno.objects.get(id=id_turno)
    turnos  = ''
    
    if (turno.paciente ==None and not (Turno.objects.filter(dia_atencion= turno.dia_atencion , paciente = request.user))):
        
        #dia_atencion = DiaAtencion.objects.get(id= turno.dia_atencion.id )
        #print dia_atencion
        turno.paciente = request.user 
        turno.fecha_creacion= datetime.today()   
        turno.save()
        
    turnos = {'id':turno.id ,'title': turno.get_paciente_name(), }
    
    print turnos
    return HttpResponse(simplejson.dumps(turnos,cls= DjangoJSONEncoder), mimetype='aplication/json')

def anular_turno_view(request,id_turno):
    #reserva = True
    turno = Turno.objects.get(id=id_turno)
    
    
    
    if (turno.paciente == request.user):
        turno.paciente = None
        turno.save()

    turnos = {'id':turno.id ,'title': turno.get_paciente_name() , }
    
    print turnos
    return HttpResponse(simplejson.dumps(turnos,cls= DjangoJSONEncoder), mimetype='aplication/json')    
    
    



    
def backanular_turno_view(request,id_turno):
    
    turno = Turno.objects.get(id=id_turno)
    if turno.paciente == request.user :       
        turno.paciente= None
        turno.save()
    reserva = False 
    dia_atencion = DiaAtencion.objects.get(prestador= turno.dia_atencion.prestador,fecha = turno.dia_atencion.fecha )
    turnos = Turno.objects.filter(dia_atencion=dia_atencion )
    ctx = {'turnos':turnos, 'prestador':turno.dia_atencion.prestador , 'dia_atencion':turno.dia_atencion,'reserva':reserva}
    return render_to_response('turnos/turnos_listado.html',ctx, context_instance = RequestContext(request))

def turnos_pdf_view(request, id_turnos):
 
    #esp = get_object_or_404(Especialidad, id=id)
    #html = render_to_string('turnos_pdf.html', {'pagesize':'A4', 'especialidad':esp}, context_instance=RequestContext(request))
    #return turnos_pdf(request, id_esp)
    return turnos_pdf(request, id_turnos)

    
def turnos_comprobantes_pdf(request,id_turno):
    turno  = Turno.objects.get(id=id_turno)
    
    
    return generar_pdf_comprobante(request, turno)   
    
def agregar_atencion_view(request, id_esp_med):
    prestador = EspecialidadesMedicos.objects.get( pk= id_esp_med) #estado

    info=''
    if request.method == 'POST':
        form = AtencionForm(request.POST , request.FILES)
        if form.is_valid() :
            add_atencion = form.save(commit=False)
            dia_fecha = request.POST['dp_fecha'].split(' ')
        
            add_atencion.fecha = dia_fecha[1]
                 
            print dia_fecha      
            try:
                atencion=DiaAtencion.objects.get(Q(fecha= add_atencion.fecha) & Q(prestador=prestador))
                info= 'Fecha ya Cargada'
                print info
            except DiaAtencion.DoesNotExist:
                try: 
                    agenda_medicos = Agenda.objects.get( Q(prestador= id_esp_med) & Q(dia_nombre=dia_fecha[0] )& Q(hora_inicial=hora_inicial)) #estado .order_by('dia')
                    add_atencion.save() #guardamos la informacion de atencion   
                    hora_inicial =  agenda_medicos.hora_inicial 
                    hora_inicial =  agenda_medicos.hora_inicial
                    hora_final =  agenda_medicos.hora_final
                    duracion = agenda_medicos.duracion
                    print agenda_medicos.duracion
                             
                    print agenda_medicos.cant_turnos
                    print hora_inicial
                    print hora_final   
                    
                    hora = hora_inicial                                                            
                    h=hora.hour
                    m=hora.minute          
                    if agenda_medicos.cant_turnos:
                        cantidad = agenda_medicos.cant_turnos                        
                               
                        for i in range(0,cantidad):
                            turnos = Turno.objects.create(dia_atencion=add_atencion , hora_turno= hora )
                            #turnos.save()    
                            m= m + duracion
                            if m >= 60 :                                   
                                h = h +1
                                m=m-60
                            
                            hora = hora.replace( hour= h, minute=m)
                            
                    else:
                        while hora < hora_final:
                            turnos = Turno.objects.create(dia_atencion=add_atencion , hora_turno= hora )
                            #turnos.save()    
                            m= m + duracion
                            if m >= 60 :                                   
                                h = h +1
                                m=m-60
                            
                            hora = hora.replace( hour= h, minute=m)
                            print hora                        
                    
                    
                    return HttpResponseRedirect('/turnos/agenda/%s'%(id_esp_med))
                    
                
                except:
                    info ='Ingrese una Fecha Valida '
    else:
        form = AtencionForm(initial={ 'prestador':prestador , 'fecha': date.today(), 'hora_inicial':'8:00'} )
    
    ctx = {'form':form, 'informacion': info , 'dia':1, 'prestador':prestador}
    return render_to_response('turnos/alta_atencion.html',ctx, context_instance = RequestContext(request))
            
            
def agregar_atencion_agenda_view(request, id_esp_med,id_agenda):
        prestador = EspecialidadesMedicos.objects.get( pk= id_esp_med) #estado
        agenda = Agenda.objects.get( pk = id_agenda) #estado .order_by('dia')
        info =''
        if request.method == 'POST':
            form = AtencionForm(request.POST , request.FILES)
            if form.is_valid() :            
                add_atencion = form.save(commit=False)
                dia_fecha = request.POST['dp_fecha'].split(' ')        
                add_atencion.fecha = dia_fecha[1]   
                hora_inicial =  add_atencion.hora_inicial
                cantidad = request.POST['turnos_cantidad']
                print dia_fecha , cantidad
                try:
                    atencion=DiaAtencion.objects.get(Q(fecha= add_atencion.fecha) & Q(prestador=prestador) & Q(hora_inicial=hora_inicial))
                    info= 'Fecha ya Cargada'
                    print info
                except DiaAtencion.DoesNotExist:
                    try: 
                    #agenda_medicos = Agenda.objects.get( Q(prestador= id_esp_med) & Q(dia_nombre=dia_fecha[0] )) #estado .order_by('dia')
                        hora_inicial =  add_atencion.hora_inicial
                        hora_final =  agenda.hora_final
                        duracion = agenda.duracion
                        add_atencion.save() #guardamos la informacion de atencion
                        hora = hora_inicial
                        print hora_inicial , hora_final, duracion, hora
                                                                                    
                        h=hora.hour
                        m=hora.minute
                     
                        if cantidad !="None":
                            print "aki"
                            #cantidad = agenda_medicos.cant_turnos
                            cantidad = int(cantidad)                                                  
                            for i in range(0,cantidad):
                               
                                turnos = Turno.objects.create(dia_atencion=add_atencion , hora_turno= hora )
                                #turnos.save()    
                                m= m + duracion
                                if m >= 60 :                                   
                                    h = h +1
                                    m=m-60
                                
                                hora = hora.replace( hour= h, minute=m)
                                print hora
                        else:
                            print "o aki"
                            while hora < hora_final:
                                
                                turnos = Turno.objects.create(dia_atencion=add_atencion , hora_turno= hora )
                                #turnos.save()    
                                m= m + duracion
                                if m >= 60 :                                   
                                    h = h +1
                                    m=m-60
                            
                                hora = hora.replace( hour= h, minute=m)
                                print hora  
                        print "fianl"                      
                        return HttpResponseRedirect('/turnos/agenda/%s'%(id_esp_med))
                    except:
                        info ='Ingrese una Fecha Valida '                                                   
        else:
        
            form = AtencionForm(initial={ 'prestador':prestador , 'hora_inicial':agenda.hora_inicial} )
    
        ctx = {'form':form ,'info':info, 'agenda':agenda,'dia':1 ,'prestador':prestador}
        return render_to_response('turnos/atencion_agenda_form.html',ctx, context_instance = RequestContext(request))
    
            
"""            
def listar_os_view(request, pagina): #productos paginado
    if request.method == 'POST':
        lista_os= ObraSocial.objects.filter(nombre__contains=request.POST['query'])
    else:
        lista_os= ObraSocial.objects.all()
    paginator = Paginator(lista_os,10) # paginamos con 3 productos
    try:
        page = int(pagina)
    except:
        page= 1
    try:
        pagina_os =  paginator.page(page)
    except (EmptyPage, InvalidPage):
        pagina_os= paginator.page(paginator.num_pages)
        
    ctx = {'obrasociales':pagina_os}
    return render_to_response('turnos/lista_os.html',ctx, context_instance = RequestContext(request))    
"""
"""
class listar_os(TemplateView):
    
    ##model= ObraSocial
    def get(self,request, *args , **kargs):
        
        lista_os =ObraSocial.objects.all()
        paginator = Paginator(lista_os,10) # paginamos con 3 productos
        try:
            page = int(self.get_context_data()['pagina'])##self.kwargs.get('pagina'))
            
        except:
            page= 1
        try:
            pagina_os =  paginator.page(page)
        except (EmptyPage, InvalidPage):
            pagina_os= paginator.page(paginator.num_pages)
            
        ctx = {'obrasociales':pagina_os}
        return render_to_response('turnos/lista_os.html',ctx, context_instance = RequestContext(request))
            
    def post(self,request, *args , **kargs):
        lista_os= ObraSocial.objects.filter( Q(nombre__contains= self.request.POST['query']) | Q(cuit__contains= self.request.POST['query']))
        print request.POST['query']
        paginator = Paginator(lista_os,10) # paginamos con 3 productos
        try:
            page = int(self.get_context_data()['pagina'])
        except:
            page= 1
        try:
            pagina_os =  paginator.page(page)
        except (EmptyPage, InvalidPage):
            pagina_os= paginator.page(paginator.num_pages)
            
        ctx = {'obrasociales':pagina_os}
        return render_to_response('turnos/lista_os.html',ctx, context_instance = RequestContext(request))
        
    
    def get_context_data(self,**kargs):
        context = super(listar_os, self).get_context_data(**kargs)
        context['pagina']= self.kwargs.get('pagina')
        return context


"""


class OsListar(ListView):
    model = ObraSocial
    paginate_by = '15'
    context_object_name = "obrasociales"
    template_name = "turnos/lista_os.html"

    def get_queryset(self):
        if self.request.GET.get('query') :
            return ObraSocial.objects.filter( Q(nombre__contains= self.request.GET.get('query')) | Q(cuit__contains= self.request.GET.get('query')))
        else:
            return ObraSocial.objects.filter().order_by('nombre')
    
    
        
   
        
    

"""       
Funcion Mejorada con agregar_os
def agregar_os_view(request):
    form = OsForm()
    info='Agregar'
    if request.method == 'POST':
        form = OsForm(request.POST)
        if form.is_valid():
            add = form.save(commit=False)
                        
            add.save() #guarda el objeto os
            info= 'guardado'
            return HttpResponseRedirect('/listado-os/page/1')
            #return render_to_response('home/thanks_register.html', context_instance=RequestContext(request))

    ctx = {'form':form,'informacion':info}
    return render_to_response('turnos/addos.html', ctx, context_instance=RequestContext(request))
"""

class OsAgregar(CreateView):
    template_name="turnos/addos.html"
    model = ObraSocial
    #success_url = reverse_lazy('vista_obrasociales')
    
    #def get_success_url(self):
    #   return reverse_lazy('vista_os', args=(self.kwargs.get('pk'),))
    
    
class  OsView(DetailView):  
    model=ObraSocial
    template_name= "turnos/os.html"
    context_object_name = "obrasocial"
    
class  OsUpdate(UpdateView):
    model = ObraSocial
    template_name= "turnos/addos.html"
    
class OsDelete(DeleteView):
    model = ObraSocial
    context_object_name = "obrasocial"
    success_url = reverse_lazy('vista_obrasociales')
    
    def delete(self,request, *args, **kwargs):
        self.object = self.get_object()
        #id_hce = self.object.historia_clinica.id
        #success_url= reverse_lazy('vista_receta_detalle', args=(self.object.id,))
        #self.object.delete()
        self.object.estado=False
        self.object.save()
        return HttpResponseRedirect(self.success_url)
    
    
class AfiliacionListar(ListView):
    model = AfiliadosOS
    paginate_by = '10'
    #query_set = ObraSocial.objects.filter(afiliado__id= self.get_context_data()['pk'])
    context_object_name = "afiliaciones"
    template_name = "turnos/lista_afiliaciones.html"
    
    def get_context_data(self,**kargs):
        context = super(AfiliacionListar, self).get_context_data(**kargs)
        context['paciente']= User.objects.get(id= int(self.kwargs.get('pk')))
        return context
    
    def get_queryset(self):
    
       
        if self.kwargs.get('pk'):
            return AfiliadosOS.objects.filter( afiliado__id= int(self.kwargs.get('pk')))
        else:
            #return User.objects.get(id= int(self.kwargs.get('pk')))
            return False
  
class AfiliacionAgregar(CreateView):
    template_name="turnos/afiliacion_form.html"
    model = AfiliadosOS
    form_class = AfiliacionForm
    
    
    def form_valid(self, form):
        #id_paciente= self.kwargs.get('pk')        
        #paciente =  User.objects.get(id= id_paciente)
        #form.instance.afiliado= paciente
        #self.object= form.save(commit=False)
        #self.object.afiliado =self.get_context_data()['afiliado']
        form.instance.afiliado= self.get_context_data()['afiliado']
        
        
        try:
            #self.object.full_clean()
            form.save(commit=False)
            return super( AfiliacionAgregar, self ).form_valid(form)
        except:
            from django.forms.util import ErrorList
            form._errors["obrasocial"]= ErrorList([u"Obra Social ya Cargada"])
            
            return super( AfiliacionAgregar, self ).form_invalid(form)
        return super( AfiliacionAgregar, self ).form_valid(form)   
    
    
    #def get_success_url(self):
    #   return  reverse_lazy('vista_afiliacion_detalle', args=(self.kwargs.get('pk'),))
    
    def get_context_data(self,**kargs):
        context = super(AfiliacionAgregar, self).get_context_data(**kargs)
        context['afiliado']= User.objects.get(pk=self.kwargs.get('pk'))
        return context

class  AfiliacionView(DetailView):  
    model= AfiliadosOS
    template_name= "turnos/afiliacion.html"
    context_object_name = "afiliacion"
        
        
        
class AfiliacionUpdate(UpdateView):
    model = AfiliadosOS
    form_class = AfiliacionForm
    template_name= "turnos/afiliacion_form.html"
    
    def get_context_data(self,**kargs):
        context = super(AfiliacionUpdate, self).get_context_data(**kargs)
        instancia= AfiliadosOS.objects.get(pk = self.kwargs.get('pk'))
        print instancia
        context['afiliado']= User.objects.get(pk=instancia.afiliado.id)        
        #context['afiliado']= instancia
        return context
    
    def form_valid(self, form):
        form.instance.afiliado= self.get_context_data()['afiliado']                
        try:
            
            form.save(commit=False)
            return super( AfiliacionUpdate, self ).form_valid(form)
        except:
            from django.forms.util import ErrorList
            form._errors["obrasocial"]= ErrorList([u"Obra Social ya Cargada"])            
            return super( AfiliacionUpdate, self ).form_invalid(form)

class AfiliacionDelete(DeleteView):
    model = AfiliadosOS
    context_object_name = "afiliacion"
#    success_url = reverse_lazy('vista_hce')
    
    def delete(self,request, *args, **kwargs):
        self.object = self.get_object()
        id_paciente = self.object.afiliado.id
        success_url= reverse_lazy('vista_afiliacion', args=(id_paciente,))
        
            
        self.object.estado=False
        self.object.save()
        return HttpResponseRedirect(success_url)
        
        
        

        

class EspecialidadListar(ListView):
    model = Especialidad
    paginate_by = '15'
    query_set = Especialidad.objects.all().order_by('-nombre')
    context_object_name = "especialidades"
    template_name = "turnos/lista_especialidad.html"
    
class EspecialidadView(DetailView):
    model= Especialidad
    template_name= "turnos/especialidad.html"
    context_object_name = "especialidad"
    
    
class EspecialidadAgregar(CreateView):    
    template_name="turnos/especialidad_form.html"
    model = Especialidad
    
class EspecialidadUpdate(UpdateView):
    model = Especialidad
    template_name= "turnos/especialidad_form.html"
    
class EspecialidadDelete(DeleteView):
    model = Especialidad
    context_object_name = "especialidad"
    success_url = reverse_lazy('vista_especialidades')
    

    
class EspecialidadesMedicosAgregar(CreateView):
    template_name="turnos/especialidades_medico_form.html"
    model = EspecialidadesMedicos
    form_class= EspecialidadesMedicosForm
    #success_url= reverse_lazy('vista_medicos_detalle',args)
    
    def get_context_data(self,**kargs):
        context = super( EspecialidadesMedicosAgregar, self).get_context_data(**kargs)
        context['medico']= Medico.objects.get(matricula=self.kwargs.get('pk'))
        return context
    def form_valid(self, form):        
        form.instance.medico= self.get_context_data()['medico']
        form.instance.fecha_habilitacion = date.today()
                
        try:
        
            form.save(commit=False)
            return super( EspecialidadesMedicosAgregar, self ).form_valid(form)
        except:
            from django.forms.util import ErrorList
            form._errors["especialidad"]= ErrorList([u"Especialidad ya Cargada"])
            
            
            return super( EspecialidadesMedicosAgregar, self ).form_invalid(form)
        return super( EspecialidadesMedicosAgregar, self ).form_valid(form)
class EspecialidadesMedicoUpdate(UpdateView):
    model = EspecialidadesMedicos
    template_name= "turnos/especialidades_medico_form.html"
    form_class= EspecialidadesMedicosForm
    
    def get_context_data(self,**kargs):
        context = super( EspecialidadesMedicoUpdate, self).get_context_data(**kargs)
        instancia= EspecialidadesMedicos.objects.get(pk = self.kwargs.get('pk'))
        print instancia
        context['medico']= Medico.objects.get(matricula=instancia.medico.matricula)        
        #context['afiliado']= instancia
        context['editar']=instancia.especialidad
        return context