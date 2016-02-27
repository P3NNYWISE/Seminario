# Create your views here.
from django.shortcuts import render_to_response , HttpResponseRedirect
from django.template import RequestContext

from Seminario.apps.HistoriaClinica.forms import HistoriaClinicaForm ,ExamenFisicoForm,HabitosToxicosForm,FisiologicosForm , PatologicosForm ,PerinatalesForm,ConsultaForm ,LaboratorioForm ,PracticaForm,PracticaFormSet ,RealizacionPracticaForm ,RecetaForm ,MedicamentoFormSet 


from Seminario.apps.HistoriaClinica.models import HistoriaClinica,ExamenFisico ,HabitosToxicos , Fisiologicos ,Patologicos ,Perinatales ,Cie10 ,ConsultaMedica ,Laboratorio ,PracticaMedica ,PracticaDetalle, Inos ,Receta , RecetaDetalle ,Vademecum 
from Seminario.apps.turnos.models import EspecialidadesMedicos,AfiliadosOS ,ObraSocial
from Seminario.apps.home.models import Medico
from Seminario.apps.home.views import is_medico,is_admin, is_admin_or_medico

from django.views.generic import TemplateView, ListView , CreateView ,DetailView,UpdateView ,DeleteView
from django.views.generic.dates import ArchiveIndexView ,YearArchiveView


from django.core.urlresolvers import reverse_lazy

from django.contrib.auth.models import User

from django.contrib.auth.decorators import login_required , user_passes_test
from django.utils.decorators import method_decorator

from datetime import date,datetime ,timedelta
from dateutil.relativedelta import relativedelta
from operator import itemgetter

from django.db.models.query import EmptyQuerySet
#Consultas complejas
from django.db.models import Q

from Seminario.apps.HistoriaClinica.reportes import generar_pdf ,generar_pdf_practicas ,generar_pdf_rank_practicas
import copy


class HceListar(ListView):
    model =  HistoriaClinica
    paginate_by = '15'
    context_object_name = 'historias_clinicas'
    template_name = 'historiaclinica/historias_clinicas.html'

    def get_queryset(self):
        #queryset = super(listar_os , self).get_query_set()
        if self.request.GET.get('query') :
            try:
                return HistoriaClinica.objects.filter( Q(id= self.request.GET.get('query')))
            except:
                return HistoriaClinica.objects.filter( Q(paciente__last_name__contains= self.request.GET.get('query')))
        return HistoriaClinica.objects.all()




@user_passes_test(is_admin_or_medico)
def hce_view(request,id_paciente):    
    informacion=''
    paciente = User.objects.get(id=id_paciente)
    #grupos = paciente.groups.all()
    editable = False
   
    try:
        historia_clinica= HistoriaClinica.objects.get(paciente= paciente)
        if historia_clinica.prestador.medico.user == request.user :
            editable = True        
    except HistoriaClinica.DoesNotExist:
        historia_clinica= False
    try:
        examen_fisico = ExamenFisico.objects.get(historia_clinica=historia_clinica)
    except ExamenFisico.DoesNotExist:
        examen_fisico = False
    
    try:
        fisiologicos = Fisiologicos.objects.get(historia_clinica=historia_clinica)
    except Fisiologicos.DoesNotExist:
        fisiologicos = False
        
    try:
        patologicos = Patologicos.objects.get(historia_clinica=historia_clinica)
    except Patologicos.DoesNotExist:
        patologicos = False
    
    
    try:
        habitos_toxicos = HabitosToxicos.objects.get(historia_clinica=historia_clinica)
    except HabitosToxicos.DoesNotExist:
        habitos_toxicos = False
        
    try:
        perinatales = Perinatales.objects.get(historia_clinica=historia_clinica)
    except Perinatales.DoesNotExist:
        perinatales = False
        
    if  ConsultaMedica.objects.filter(historia_clinica =  historia_clinica).count() > 0:
        consultas = True
    else:        
        consultas=False
        
        
    if request.user.groups.filter(name='Medicos').count() == 0:
        medico = False
    else:        
        medico = True
    #perfil = PerfilUsuario.objects.get(user=usuario)
    #ctx = {'perfil':perfil,'informacion':informacion}
    ctx = {'paciente':paciente,'medico':medico,'editable':editable ,'historia_clinica':historia_clinica ,'fisiologicos':fisiologicos,'patologicos':patologicos,'habitos_toxicos':habitos_toxicos,'perinatales':perinatales,'examen_fisico':examen_fisico, 'informacion':informacion, 'consultas':consultas }
    return render_to_response('historiaclinica/ver_hce.html', ctx, context_instance=RequestContext(request))




@user_passes_test(is_medico)
def historia_clinica_view(request,id_paciente):
    info = "Agregar"
    
    paciente = User.objects.get( pk= id_paciente) #estado
    
    profesional = Medico.objects.get(user =  request.user)  
    prestador = EspecialidadesMedicos.objects.filter(medico = profesional)
    print prestador
    if request.method == 'POST':
        form = HistoriaClinicaForm(request.POST , request.FILES)
        if form.is_valid() :
            prestador = EspecialidadesMedicos.objects.get(id = request.POST.get('prestador'))
            add = form.save(commit=False)
            add.paciente= paciente
            add.fecha_creacion = date.today()
            add.prestador = prestador
            add.save() #guardamos la informacion
            #form.save_m2m() # guardamos la relacion manyTomany
            info = 'Guardado Satisfactoriamente'
            #return HttpResponseRedirect('/perfil/%s' % id_paciente)
            return HttpResponseRedirect('/hce/%s' % id_paciente)
            
            
    else:
        form = HistoriaClinicaForm(initial={'paciente': paciente ,'fecha_creacion': date.today()})
    
    ctx = {'form':form, 'paciente':paciente , 'informacion':info, 'prestador':prestador}    
    return render_to_response('historiaclinica/historiaclinica.html',ctx, context_instance = RequestContext(request))

@user_passes_test(is_medico)    
def edit_historia_clinica_view(request , id_hce):    
    info='Editar'
    hce = HistoriaClinica.objects.get(pk= id_hce)
    # Verificar si es el mismo medico--falta implementar
    if (hce.prestador.medico.user == request.user):
        print 'si'
    else:
        print 'no'
        
    profesional = Medico.objects.get(user =  request.user)  
    prestador = EspecialidadesMedicos.objects.filter(medico = profesional)
    
    if request.method == 'POST':
        form = HistoriaClinicaForm(request.POST , request.FILES, instance=hce)
        if form.is_valid():
            edit_hce = form.save(commit=False)
            medico = EspecialidadesMedicos.objects.get(id = request.POST.get('prestador'))
            edit_hce.prestador =  medico
            edit_hce.save()
            #form.save_m2m()
            info='guardado'
            #return HttpResponseRedirect('/producto/%s' % edit_prod.id)
            #   return HttpResponseRedirect('/turnos/agenda/%s/page/1' % edit_agenda.prestador.id)    
    else:
        form = HistoriaClinicaForm(instance=hce)
    ctx = {'form':form, 'paciente':hce.paciente , 'informacion':info ,'prestador':prestador}
    return render_to_response('historiaclinica/historiaclinica.html', ctx, context_instance=RequestContext(request))


@user_passes_test(is_medico)
def examen_fisico_view(request,id_hce):
    info = "Agregar"
    hce = HistoriaClinica.objects.get( pk= id_hce) #estado
        

    if request.method == 'POST':
        form = ExamenFisicoForm(request.POST , request.FILES)
        if form.is_valid() :
            add = form.save(commit=False)
            add.historia_clinica = hce
            add.fecha_creacion = datetime.now()
            add.save() #guardamos la informacion
            #form.save_m2m() # guardamos la relacion manyTomany
            info = 'Guardado'
            #return HttpResponseRedirect('/perfil/%s' % hce.paciente.id)
            return HttpResponseRedirect('/hce/%s' % hce.paciente.id)
            #form= ExamenFisicoForm(initial={'historia_clinica': hce})
            
    else:
        form = ExamenFisicoForm(initial={'historia_clinica': hce})
    ctx = {'form':form, 'historia_clinica':hce , 'informacion':info}    
    return render_to_response('historiaclinica/examen_fisico.html',ctx, context_instance = RequestContext(request))


@user_passes_test(is_medico)
def edit_examen_fisico_view(request , id_examen):    
    info='Editar'
    examen = ExamenFisico.objects.get(pk= id_examen)
    
    if request.method == 'POST':
        form = ExamenFisicoForm(request.POST , request.FILES, instance=examen)
        if form.is_valid():
            edit_examen = form.save(commit=False)
            #edit_agenda.estado = True
            edit_examen.save()
            #form.save_m2m()
            info='guardado'
            #return HttpResponseRedirect('/producto/%s' % edit_prod.id)
            #   return HttpResponseRedirect('/turnos/agenda/%s/page/1' % edit_agenda.prestador.id)    
    else:
        form = ExamenFisicoForm(instance=examen)
    ctx = {'form':form, 'historia_clinica':examen.historia_clinica , 'informacion':info}
    return render_to_response('historiaclinica/examen_fisico.html', ctx, context_instance=RequestContext(request))
   
@user_passes_test(is_medico)
def antecedentes_view(request,id_hce):
    info = "Agregar"
    hce = HistoriaClinica.objects.get( pk= id_hce) #estado
  

    if request.method == 'POST':
        form = HabitosToxicosForm(request.POST , request.FILES)
    
        if form.is_valid() :
            add = form.save(commit=False)
            add.historia_clinica = hce
            add.fecha = datetime.now()
            add.save() #guardamos la informacion
            #form.save_m2m() # guardamos la relacion manyTomany
            info = 'Guardado Satisfactoriamente'
            #return HttpResponseRedirect('/perfil/%s' % hce.paciente.id)
            return HttpResponseRedirect('/hce/%s' % hce.paciente.id)
            
    else:
        form = HabitosToxicosForm(initial={'historia_clinica': hce, 'fecha': datetime.now })
    ctx = {'form':form, 'historia_clinica':hce , 'informacion':info}    
    return render_to_response('historiaclinica/habitos_toxicos.html',ctx, context_instance = RequestContext(request))
     
     
@user_passes_test(is_medico)
def edit_habitos_toxicos_view(request , id_hab_tox):    
    info='Editar'
    habitos = HabitosToxicos.objects.get(pk= id_hab_tox)
    
    if request.method == 'POST':
        form = HabitosToxicosForm(request.POST , request.FILES, instance= habitos)
        if form.is_valid():
            edit_habitos = form.save(commit=False)
            #edit_agenda.estado = True
            edit_habitos.save()
            #form.save_m2m()
            info='guardado'
            #return HttpResponseRedirect('/producto/%s' % edit_prod.id)
            #return HttpResponseRedirect('/perfil/%s' % hce.paciente.id)
            #   return HttpResponseRedirect('/turnos/agenda/%s/page/1' % edit_agenda.prestador.id)    
    else:
        form = HabitosToxicosForm(instance=habitos)
    ctx = {'form':form, 'historia_clinica': habitos.historia_clinica , 'informacion':info}
    return render_to_response('historiaclinica/habitos_toxicos.html', ctx, context_instance=RequestContext(request))


class AntecedenteFisioAgregar(CreateView):
    template_name="historiaclinica/fisiologicos.html"
    model = Fisiologicos
    form_class =  FisiologicosForm
    
    """
    def get_initial(self):
        id_hce= self.kwargs.get('id_hce')
        hce =  HistoriaClinica.objects.get(pk= id_hce)
                
        return {'historia_clinica':hce, 'fecha': datetime.now()}
    """
    def form_valid(self, form):
        id_hce= self.kwargs.get('id_hce')
        hce =  HistoriaClinica.objects.get(pk= id_hce)
        form.instance.historia_clinica= hce
        form.instance.fecha=datetime.now()
        return super(AntecedenteFisioAgregar, self ).form_valid(form)
    def get_context_data(self, **kwargs):
        context = super(AntecedenteFisioAgregar ,self).get_context_data(**kwargs)
        id_hce= self.kwargs.get('id_hce')
        hce =  HistoriaClinica.objects.get(pk= id_hce)
        context['historia_clinica']=hce
        return context
        
        
    @method_decorator(user_passes_test(is_medico))
    def dispatch(self,request,*args, **kwargs):
        return super(  AntecedenteFisioAgregar, self).dispatch(request,*args, **kwargs)
    
class  AntecedenteFisioUpdate(UpdateView):
    model = Fisiologicos
    form_class =  FisiologicosForm
    template_name= "historiaclinica/fisiologicos.html"

class AntecedentePatoAgregar(CreateView):
    template_name="historiaclinica/patologicos.html"
    model = Patologicos
    form_class =  PatologicosForm
    
    """
    def get_initial(self):
        id_hce= self.kwargs.get('id_hce')
        hce =  HistoriaClinica.objects.get(pk= id_hce)
                
        return {'historia_clinica':hce, 'fecha': datetime.now()}
    """
    def form_valid(self, form):
        id_hce= self.kwargs.get('id_hce')
        hce = HistoriaClinica.objects.get(pk= id_hce)
        form.instance.historia_clinica= hce
        form.instance.fecha=datetime.now()
        return super( AntecedentePatoAgregar, self ).form_valid(form)
    
    
    def get_context_data(self, **kwargs):
        context = super(AntecedentePatoAgregar ,self).get_context_data(**kwargs)
        id_hce= self.kwargs.get('id_hce')
        hce =  HistoriaClinica.objects.get(pk= id_hce)
        context['historia_clinica']=hce
        return context
    
    @method_decorator(user_passes_test(is_medico))
    def dispatch(self,request,*args, **kwargs):
        return super( AntecedentePatoAgregar, self).dispatch(request,*args, **kwargs)
        
    
class  AntecedentePatoUpdate(UpdateView):
    model = Patologicos
    form_class =  PatologicosForm
    template_name= "historiaclinica/patologicos.html"

class AntecedentePerinatalesAgregar(CreateView):
    template_name="historiaclinica/perinatales.html"
    model = Perinatales
    form_class =  PerinatalesForm
    
    
    def form_valid(self, form):
        id_hce= self.kwargs.get('id_hce')
        hce = HistoriaClinica.objects.get(pk= id_hce)
        form.instance.historia_clinica= hce
        form.instance.fecha=datetime.now()
        return super( AntecedentePerinatalesAgregar, self ).form_valid(form)
    
    def get_context_data(self, **kwargs):
        context = super(AntecedentePerinatalesAgregar ,self).get_context_data(**kwargs)
        id_hce= self.kwargs.get('id_hce')
        hce =  HistoriaClinica.objects.get(pk= id_hce)
        context['historia_clinica']=hce
        return context
    
    
    @method_decorator(user_passes_test(is_medico))
    def dispatch(self,request,*args, **kwargs):
        return super( AntecedentePerinatalesAgregar, self).dispatch(request,*args, **kwargs)

class AntecedentePerinatalesUpdate(UpdateView):
    model = Perinatales
    #form_class =  PerinatalesForm
    template_name= "historiaclinica/perinatales.html"
    
class Cie10Listar(ListView):
    model = Cie10
    #paginate_by = '10'
    #query_set = Cie10.objects.all()
    context_object_name = "cie10"
    template_name = "historiaclinica/lista_cie10.html"
        
    def get_queryset(self):
        #queryset = super(listar_os , self).get_query_set()
        if self.request.GET.get('query') :
            try:
                return Cie10.objects.filter( Q(codigo= self.request.GET.get('query'))|Q(descripcion__contains= self.request.GET.get('query')))
            except:
                return Cie10.objects.filter( Q(descripcion__contains= self.request.GET.get('query')))
        return Cie10.objects.all()

class Cie10Agregar(CreateView):
    template_name="historiaclinica/cie10_form.html"
    model = Cie10
    #form_class =  PerinatalesForm
    success_url = reverse_lazy('vista_cie10')


class Cie10Editar(UpdateView):
    model= Cie10
    template_name="historiaclinica/cie10_form.html"
    success_url = reverse_lazy('vista_cie10')
    
    
class Cie10Delete(DeleteView):
    model = Cie10
    context_object_name = "cie10"
    success_url = reverse_lazy('vista_cie10')
    
    def delete(self,request, *args, **kwargs):
        self.object = self.get_object()
        #id_hce = self.object.historia_clinica.id
        #success_url= reverse_lazy('vista_receta_detalle', args=(self.object.id,))
        #self.object.delete()
        self.object.estado=False
        self.object.save()
        return HttpResponseRedirect(self.success_url)
     

    
class ConsultasListar(ListView):
    model= ConsultaMedica
    paginate_by = '5'
    #query_set = Consultas.objects.all()
    context_object_name = "consultas"
    template_name = "historiaclinica/lista_consultas.html"
    
class ConsultasArchivo(ArchiveIndexView):
    #model = ConsultaMedica
    date_field = "fecha"
    paginate_by = '15'
    queryset= ConsultaMedica.objects.all()
    context_object_name = "consultas"
    template_name = "historiaclinica/lista_consultas.html"
    allow_empty = True
    
    def get_queryset(self):   
            
        hce = HistoriaClinica.objects.get(pk=self.kwargs.get('id_hce'))
        if self.request.GET.get('query') :
                queryset = ConsultaMedica.objects.filter( Q(historia_clinica= hce) & Q( prestador__medico__user= self.request.user ))
                if queryset:
                    return queryset
        return ConsultaMedica.objects.filter(historia_clinica= hce)                    
                
    def get_context_data(self,**kargs):
        context = super( ConsultasArchivo, self).get_context_data(**kargs)
        hce = HistoriaClinica.objects.get(pk=self.kwargs.get('id_hce'))
        context['expediente']=hce.id
        #paciente = User.objects.get(id= hce.paciente.id)
        context['paciente']= User.objects.get(id= hce.paciente.id)
        if self.request.user.groups.filter(name='Medicos').count() == 0:
            context['medico'] = False
        else:        
            context['medico'] = True
        
        if len(AfiliadosOS.objects.filter(afiliado= hce.paciente))>0:
            context['afiliacion'] = True
        else:
            context['afiliacion'] = False
            
        
        return context
    
class ConsultasAnualArchivo(YearArchiveView):
    model=ConsultaMedica
    query_set = ConsultaMedica.objects.all()
    date_field = "fecha"
    make_object_list = True
    context_object_name = "latest"
    template_name = "historiaclinica/consultamedica_archive.html"
        
        
class ConsultaView(DetailView):
    model= ConsultaMedica
    template_name = "historiaclinica/consulta.html"
    context_object_name = 'consulta'
  
    def get_context_data(self,**kargs):
        context = super( ConsultaView, self).get_context_data(**kargs)
        #consulta =  ConsultaMedica.objects.get(pk=self.kwargs.get('pk'))
        
        #context['diagnosticos']= Diagnostico.objects.filter(consulta= consulta)
        if self.request.user.groups.filter(name='Medicos').count() == 0:
            context['medico'] = False
        else:        
            context['medico'] = True
        
        
    
        return context




class ConsultaAgregar(CreateView):
    model = ConsultaMedica
    template_name=  "historiaclinica/consulta_form.html"
    form_class =  ConsultaForm
    

    def form_valid(self, form):
        
        form.instance.historia_clinica= self.get_context_data()['historia_clinica']
        #grabar seleccion del combobox
        prestador = EspecialidadesMedicos.objects.get(id = self.request.POST.get('prestador'))
        
        #os_consulta = AfiliadosOS.objects.get(id = self.request.POST.get('os_consulta'))
        
            
        form.instance.prestador = prestador
       
        form.instance.fecha = datetime.now()
        
        
        try:
            os_consulta = AfiliadosOS.objects.get(id = self.request.POST.get('os_consulta'))
            form.instance.os_consulta = os_consulta
            #self.object.full_clean()
            form.save(commit=False)
            return super( ConsultaAgregar, self ).form_valid(form)
        except:
            #from django.forms.util import ErrorList
            #form._errors["prestador"]= ErrorList([u"Error ya Cargada"])            
            return super( ConsultaAgregar, self ).form_invalid(form)
        #return super( ConsultaAgregar, self ).form_valid(form)
    
    def get_context_data(self,**kargs):
        
        context = super( ConsultaAgregar, self).get_context_data(**kargs)
        
        hce= HistoriaClinica.objects.get(pk=self.kwargs.get('id_hce'))
        
        context['historia_clinica'] = hce
        context['paciente_id'] = hce.paciente.id
        context['expediente'] =self.kwargs.get('id_hce')
        try:
            profesional = Medico.objects.get(user =  self.request.user)
        except:
            profesional = ""        
        prestador = EspecialidadesMedicos.objects.filter(medico = profesional)
        context['prestador']= prestador
        
        try:
            os_consulta = AfiliadosOS.objects.filter( Q(afiliado =  hce.paciente) & Q(estado=True))
        except:
            os_consulta = ""        
        
        context['os_consulta']= os_consulta
        
        
        cie10 = Cie10.objects.all()
        context['cie10'] = cie10
        #context['form'].fields['os_consulta'].queryset = AfiliadosOS.objects.filter( Q(afiliado =  hce.paciente) & Q(estado=True))

        return context
    
    @method_decorator(user_passes_test(is_medico))
    def dispatch(self,request,*args, **kwargs):
        return super( ConsultaAgregar, self).dispatch(request,*args, **kwargs)
    
"""          
    def get_initials(self):

        
        initial =  super(ConsultaAgregar ,self).get_initials()
        profesional = Medico.objects.get(user =  self.request.user)
        print profesional
        prestador = EspecialidadesMedicos.objects.filter(medico = profesional)
        print prestador
    
        initial['form']= prestador
        print initial
        return {'prestador':prestador}
"""     



class ConsultaEditar(UpdateView):
    model= ConsultaMedica
    template_name="historiaclinica/consulta_form.html"
    form_class =  ConsultaForm
    
    
    def get_context_data(self,**kargs):
        
        context = super( ConsultaEditar, self).get_context_data(**kargs)
        consulta = ConsultaMedica.objects.get(pk=self.kwargs.get('pk'))
        hce= consulta.historia_clinica
        context['historia_clinica'] = hce
        context['paciente_id'] = hce.paciente.id
        context['expediente'] =hce.id
        try:
            profesional = Medico.objects.get(user =  self.request.user)
        except:
            profesional = ""        
        prestador = EspecialidadesMedicos.objects.filter(medico = profesional)
        context['prestador']= prestador        
        return context

class ConsultaDelete(DeleteView):
    model = ConsultaMedica
    context_object_name = "consulta"
    #success_url = reverse_lazy('vista_laboratorio')
  
    def delete(self,request, *args, **kwargs):
        self.object = self.get_object()
        id_hce = self.object.historia_clinica.id
        success_url= reverse_lazy('vista_consultas', args=(id_hce,))
        #self.object.delete()
        self.object.estado=False
        self.object.save()

        return HttpResponseRedirect(success_url)



    
class LaboratorioArchivo(ArchiveIndexView):
    #model = ConsultaMedica
    date_field = "fecha"
    paginate_by = '10'
    queryset= Laboratorio.objects.all()
    context_object_name = "laboratorio"
    template_name = "historiaclinica/lista_laboratorio.html"
    allow_empty = True
    
    def get_queryset(self):                
        hce = HistoriaClinica.objects.get(pk=self.kwargs.get('id_hce'))
        if self.request.GET.get('query') :
                queryset = Laboratorio.objects.filter( Q(historia_clinica= hce) & Q( prestador__medico__user= self.request.user ))
                if queryset:
                    return queryset
        queryset= Laboratorio.objects.filter(historia_clinica= hce)
        if queryset:
            return queryset                    
        return    Laboratorio.objects.get_empty_query_set()
    
    def get_context_data(self,**kargs):
        context = super( LaboratorioArchivo, self).get_context_data(**kargs)
        hce = HistoriaClinica.objects.get(pk=self.kwargs.get('id_hce'))
        context['expediente']=hce.id
        #paciente = User.objects.get(id= hce.paciente.id)
        context['paciente']= User.objects.get(id= hce.paciente.id)
        if self.request.user.groups.filter(name='Medicos').count() == 0:
            context['medico'] = False
        else:        
            context['medico'] = True
        print context['medico']
        return context

class LaboratorioView(DetailView):
    model= Laboratorio
    template_name = "historiaclinica/laboratorio.html"
    context_object_name = 'laboratorio'
    
    
class LaboratorioAgregar(CreateView):
    model = Laboratorio
    template_name=  "historiaclinica/laboratorio_form.html"
    form_class =  LaboratorioForm

    
    def form_valid(self,form):
        form.instance.historia_clinica= self.get_context_data()['historia_clinica']
        #grabar seleccion del combobox
        prestador = EspecialidadesMedicos.objects.get(id = self.request.POST.get('prestador'))
        form.instance.prestador = prestador
        form.instance.fecha = datetime.now()
        
        
        try:
            #self.object.full_clean()
            form.save(commit=False)
            return super( LaboratorioAgregar, self ).form_valid(form)
        except:
            from django.forms.util import ErrorList
            form._errors["prestador"]= ErrorList([u"Error ya Cargada"])            
            return super( LaboratorioAgregar, self ).form_invalid(form)
        #return super( ConsultaAgregar, self ).form_valid(form)

    def get_context_data(self,**kargs):        
        context = super( LaboratorioAgregar, self).get_context_data(**kargs)
        
        hce= HistoriaClinica.objects.get(pk=self.kwargs.get('id_hce'))
        context['historia_clinica'] = hce
        context['paciente_id'] = hce.paciente.id
        context['expediente'] =self.kwargs.get('id_hce')
        try:
            profesional = Medico.objects.get(user =  self.request.user)
        except:
            profesional = ""        
        prestador = EspecialidadesMedicos.objects.filter(medico = profesional)
        context['prestador']= prestador        
        return context  

    @method_decorator(user_passes_test(is_medico))
    def dispatch(self,request,*args, **kwargs):
        return super( LaboratorioAgregar, self).dispatch(request,*args, **kwargs)


class LaboratorioEditar(UpdateView):
    model= Laboratorio
    template_name="historiaclinica/laboratorio_form.html"
    form_class =  LaboratorioForm
    #success_url = reverse_lazy('vista_laboratorio')
    def get_context_data(self,**kargs):        
        context = super( LaboratorioEditar, self).get_context_data(**kargs)
        laboratorio = Laboratorio.objects.get(pk=self.kwargs.get('pk'))
        hce = laboratorio.historia_clinica
        context['historia_clinica'] = hce
        context['paciente_id'] = hce.paciente.id
        context['expediente'] = hce.id
        try:
            profesional = Medico.objects.get(user =  self.request.user)
        except:
            profesional = ""        
        prestador = EspecialidadesMedicos.objects.filter(medico = profesional)
        context['prestador']= prestador        
        return context
    
    
class LaboratorioDelete(DeleteView):
    model = Laboratorio
    context_object_name = "laboratorio"
    #success_url = reverse_lazy('vista_laboratorio')
  
    def delete(self,request, *args, **kwargs):
        self.object = self.get_object()
        id_hce = self.object.historia_clinica.id
        success_url= reverse_lazy('vista_laboratorio', args=(id_hce,))
        self.object.delete()
        return HttpResponseRedirect(success_url)
    
class PracticasArchivo(ArchiveIndexView):
    #model = PracticaMedica
    date_field = "fecha"
    paginate_by = '15'
    queryset= PracticaMedica.objects.all()
    context_object_name = "practicas"
    template_name = "historiaclinica/lista_practicas.html"
    allow_empty = True
    
        
    def get_queryset(self):
        #queryset = super(listar_os , self).get_query_set()
        hce = HistoriaClinica.objects.get(pk=self.kwargs.get('id_hce'))
        if self.request.GET.get('query') :
            return PracticaMedica.objects.filter( Q(historia_clinica= hce) & Q(id__contains=self.request.GET.get('query')) )            
        else:
            return PracticaMedica.objects.filter(historia_clinica= hce)
        
    def get_context_data(self,**kargs):
        context = super( PracticasArchivo, self).get_context_data(**kargs)
        hce = HistoriaClinica.objects.get(pk=self.kwargs.get('id_hce'))
        context['expediente']=hce.id
        #paciente = User.objects.get(id= hce.paciente.id)
        context['paciente']= User.objects.get(id= hce.paciente.id)
        if self.request.user.groups.filter(name='Medicos').count() == 0:
            context['medico'] = False
        else:        
            context['medico'] = True
        print context['medico']
        return context
"""    
    
    def get_queryset(self):                
        hce = HistoriaClinica.objects.get(pk=self.kwargs.get('id_hce'))
        if self.request.GET.get('query') :
                queryset = PracticaMedica.objects.filter( Q(historia_clinica= hce) & Q( prestador__medico__user= self.request.user ))
                if queryset:
                    return queryset
        queryset= PracticaMedica.objects.filter(historia_clinica= hce)
        #ueryset= PracticaMedica.objects.all()
        
        if queryset:
            return queryset                    
        return    PracticaMedica.objects.get_empty_query_set()
    
"""    

    
class PracticaView(DetailView):
    model= PracticaMedica
    template_name = "historiaclinica/practica.html"
    context_object_name = 'prescripcion'
    
    def get_context_data(self,**kargs):
        context = super( PracticaView, self).get_context_data(**kargs)
        prescripcion= PracticaMedica.objects.get(pk=self.kwargs.get('pk'))
        detalle= PracticaDetalle.objects.filter(practica_medica=prescripcion)
        context['detalle']=detalle
        return context
    
        
        
        
        
    
class PracticaAgregar(CreateView):
    model = PracticaMedica
    template_name=  "historiaclinica/practica_form.html"
    form_class =  PracticaForm
    
    
    def form_valid(self,form):
        form.instance.historia_clinica= self.get_context_data()['historia_clinica']
        #grabar seleccion del combobox
        prestador = EspecialidadesMedicos.objects.get(id = self.request.POST.get('prestador'))
        form.instance.prestador = prestador
        form.instance.fecha = datetime.now()                
        try:
            #self.object.full_clean()
            form.save(commit=False)
            return super( PracticaAgregar, self ).form_valid(form)
        except:
            from django.forms.util import ErrorList
            form._errors["prestador"]= ErrorList([u"Error ya Cargada"])            
            return super( PracticaAgregar, self ).form_invalid(form)
        #return super( PracticaAgregar, self ).form_valid(form)

    
    def get_context_data(self,**kargs):        
        context = super( PracticaAgregar, self).get_context_data(**kargs)
        
        hce= HistoriaClinica.objects.get(pk=self.kwargs.get('id_hce'))
        context['historia_clinica'] = hce
        context['paciente_id'] = hce.paciente.id
        context['expediente'] =self.kwargs.get('id_hce')
        try:
            profesional = Medico.objects.get(user =  self.request.user)
            prestador = EspecialidadesMedicos.objects.filter(medico = profesional)
        except:
            prestador = ""                
        context['prestador']= prestador
                
        return context
      
    @method_decorator(user_passes_test(is_medico))
    def dispatch(self,request,*args, **kwargs):
        return super( PracticaAgregar, self).dispatch(request,*args, **kwargs)
    
class PracticaEditar(UpdateView):
    model= PracticaMedica
    template_name="historiaclinica/practica_form.html"
    form_class = RealizacionPracticaForm
    
    def get_context_data(self,**kargs):        
        context = super( PracticaEditar, self).get_context_data(**kargs)
        practica = PracticaMedica.objects.get(pk=self.kwargs.get('pk'))
        hce = practica.historia_clinica
        if practica.estado == 'Pendiente':
            context['pendiente'] = True
        
        context['historia_clinica'] = hce
        context['paciente_id'] = hce.paciente.id
        context['expediente'] = hce.id
        
        try:
            profesional = Medico.objects.get(user =  self.request.user)
            efector = EspecialidadesMedicos.objects.filter(medico = profesional)
        except:
            efector = ""        
        
        context['efector']= efector       
        return context
    
        
    def form_valid(self,form):
        #form.instance.historia_clinica= self.get_context_data()['historia_clinica']
        #grabar seleccion del combobox
        efector = EspecialidadesMedicos.objects.get(id = self.request.POST.get('efector'))
        form.instance.efector = efector
        form.instance.estado = "Realizado"
        form.instance.fecha_modificado = datetime.now()
        try:
            #self.object.full_clean()
            form.save(commit=False)
            return super( PracticaEditar, self ).form_valid(form)
        except:
          
            return super( PracticaEditar, self ).form_invalid(form)
        #return super( PracticaAgregar, self ).form_valid(form)  
        
        
        
class PracticaDelete(DeleteView):
    model = PracticaMedica
    context_object_name = "practica"
    #success_url = reverse_lazy('vista_laboratorio')
  
    def delete(self,request, *args, **kwargs):
        self.object = self.get_object()
        #id_hce = self.object.historia_clinica.id
        success_url= reverse_lazy('vista_practica_detalle', args=(self.object.id,))
        #self.object.delete()
        self.object.estado="Anulado"
        self.object.save()
        return HttpResponseRedirect(success_url)
    
        
        
        
class PracticaTerminar(DeleteView):
    model = PracticaMedica
    context_object_name = "practica"
    #success_url = reverse_lazy('vista_laboratorio')
  
    def delete(self,request, *args, **kwargs):
        self.object = self.get_object()
        #id_hce = self.object.historia_clinica.id
        success_url= reverse_lazy('vista_practica_detalle', args=(self.object.id,))
        #self.object.delete()
        self.object.estado="Finalizado"
        self.object.save()
        return HttpResponseRedirect(success_url)
    
    
  

        
    
    
    
class PracticaCreateView(CreateView):
    template_name = 'historiaclinica/PracticaMedica.html'
    model = PracticaMedica
    form_class = PracticaForm
    #success_url = '/'
    
    

    def get(self, request, *args, **kwargs):
        """
        Handles GET requests and instantiates blank versions of the form
        and its inline formsets.
        """
        self.object = None
        form_class = self.get_form_class()
        form = self.get_form(form_class)
        detalle_form = PracticaFormSet()
        
        #inos_list = Inos.objects.all().exclude(capitulo__tipo="ANC")
        inos_list = Inos.objects.all().order_by('capitulo','codigo')
        print inos_list
        return self.render_to_response(
            self.get_context_data(form=form,
                                  detalle_form=detalle_form,
                                  inos=inos_list,))
    def post(self, request, *args, **kwargs):
        """
        Handles POST requests, instantiating a form instance and its inline
        formsets with the passed POST variables and then checking them for
        validity.
        """
        self.object = None
        form_class = self.get_form_class()
        form = self.get_form(form_class)
        detalle_form = PracticaFormSet(self.request.POST)

        
        
        if (form.is_valid() and detalle_form.is_valid() ):
            return self.form_valid(form, detalle_form)
        else:
            return self.form_invalid(form, detalle_form)

    def form_valid(self, form, detalle_form):
        """
        Called if all forms are valid. Creates a Recipe instance along with
        associated Ingredients and Instructions and then redirects to a
        success page.
        """
        
        "Checkear q no esta vacio el formset angd"
        form.instance.historia_clinica= self.get_context_data()['historia_clinica']
        #grabar seleccion del combobox
        prestador = EspecialidadesMedicos.objects.get(id = self.request.POST.get('prestador'))
        form.instance.prestador = prestador
        os_prescripcion = AfiliadosOS.objects.get(id = self.request.POST.get('os_prescripcion'))        
        form.instance.os_prescripcion = os_prescripcion
        form.instance.fecha = datetime.now() 
        
        self.object = form.save()
        
        detalle_form.instance = self.object
              
        detalle_form.save()


        
        
        return HttpResponseRedirect(self.get_success_url())
    
    def form_invalid(self, form, detalle_form,):
        """
        Called if a form is invalid. Re-renders the context data with the
        data-filled forms and errors.
        """
        inos_list = Inos.objects.all().order_by('capitulo','codigo')
        return self.render_to_response(
            self.get_context_data(form=form,
                                  detalle_form=detalle_form,
                                  inos=inos_list,
                                  ))

    def get_context_data(self,**kargs):        
        context = super( PracticaCreateView, self).get_context_data(**kargs)
        
        hce= HistoriaClinica.objects.get(pk=self.kwargs.get('id_hce'))
        context['historia_clinica'] = hce
        context['paciente_id'] = hce.paciente.id
        context['expediente'] =self.kwargs.get('id_hce')
        try:
            profesional = Medico.objects.get(user =  self.request.user)
            prestador = EspecialidadesMedicos.objects.filter(medico = profesional)
        except:
            prestador = ""        
        
        context['prestador']= prestador        
        try:
            os_prescripcion = AfiliadosOS.objects.filter( Q(afiliado =  hce.paciente) & Q(estado=True))
            #os_prescripcion = AfiliadosOS.objects.filter( afiliado =  hce.paciente)
        except:
            os_prescripcion = ""        
        
        context['os_prescripcion']= os_prescripcion
        return context 
    
    @method_decorator(user_passes_test(is_medico))
    def dispatch(self,request,*args, **kwargs):
        return super( PracticaCreateView, self).dispatch(request,*args, **kwargs)
        
        
class RecetasArchivo(ArchiveIndexView):
    #model = PracticaMedica
    date_field = "fecha"
    #paginate_by = '10'
    queryset= Receta.objects.all()
    context_object_name = "recetas"
    template_name = "historiaclinica/lista_recetas.html"
    allow_empty = True
    
        
    def get_queryset(self):
        #queryset = super(listar_os , self).get_query_set()
        hce = HistoriaClinica.objects.get(pk=self.kwargs.get('id_hce'))
        if self.request.GET.get('query') :
            return Receta.objects.filter( Q(historia_clinica= hce) & Q(id__contains=self.request.GET.get('query')) )            
        else:
            return Receta.objects.filter(historia_clinica= hce)
        
    def get_context_data(self,**kargs):
        context = super( RecetasArchivo, self).get_context_data(**kargs)
        hce = HistoriaClinica.objects.get(pk=self.kwargs.get('id_hce'))
        context['expediente']=hce.id
        #paciente = User.objects.get(id= hce.paciente.id)
        context['paciente']= User.objects.get(id= hce.paciente.id)
        if self.request.user.groups.filter(name='Medicos').count() == 0:
            context['medico'] = False
        else:        
            context['medico'] = True
        print context['medico']
        return context
class RecetaView(DetailView):
    model= Receta
    template_name = "historiaclinica/receta.html"
    context_object_name = 'receta'
    
    def get_context_data(self,**kargs):
        context = super( RecetaView, self).get_context_data(**kargs)
        receta= Receta.objects.get(pk=self.kwargs.get('pk'))
        detalle= RecetaDetalle.objects.filter(receta=receta)
        context['detalle']=detalle
        return context
    
    
class RecetaRegistrarView(CreateView):
    template_name = 'historiaclinica/receta_form.html'
    model = Receta
    form_class = RecetaForm
    #success_url = '/'
    
    

    def get(self, request, *args, **kwargs):
        """
        Handles GET requests and instantiates blank versions of the form
        and its inline formsets.
        """
        self.object = None
        form_class = self.get_form_class()
        form = self.get_form(form_class)
        detalle_form = MedicamentoFormSet()
        
        vademecum = Vademecum.objects.all().filter(estado=True)
        #inos_list = Inos.objects.all()
        #print inos_list
        return self.render_to_response(
            self.get_context_data(form=form,
                                  detalle_form=detalle_form,
                                  vademecum=vademecum,))
    def post(self, request, *args, **kwargs):
        """
        Handles POST requests, instantiating a form instance and its inline
        formsets with the passed POST variables and then checking them for
        validity.
        """
        self.object = None
        form_class = self.get_form_class()
        form = self.get_form(form_class)
        detalle_form = MedicamentoFormSet(self.request.POST)

        
        
        if (form.is_valid() and detalle_form.is_valid() ):
            return self.form_valid(form, detalle_form)
        else:
            return self.form_invalid(form, detalle_form)

    def form_valid(self, form, detalle_form):
        """
        Called if all forms are valid. Creates a Recipe instance along with
        associated Ingredients and Instructions and then redirects to a
        success page.
        """
        
        "Checkear q no esta vacio el formset angd"
        form.instance.historia_clinica= self.get_context_data()['historia_clinica']
        #grabar seleccion del combobox
        prestador = EspecialidadesMedicos.objects.get(id = self.request.POST.get('prestador'))
        form.instance.prestador = prestador
        os_receta = AfiliadosOS.objects.get(id = self.request.POST.get('os_receta'))        
        form.instance.os_receta = os_receta
        form.instance.fecha = datetime.now() 
        
        self.object = form.save()
        
        detalle_form.instance = self.object
              
        detalle_form.save()


        
        
        return HttpResponseRedirect(self.get_success_url())
    
    def form_invalid(self, form, detalle_form,):
        """
        Called if a form is invalid. Re-renders the context data with the
        data-filled forms and errors.
        """
        vademecum = Vademecum.objects.all()
        return self.render_to_response(
            self.get_context_data(form=form,
                                  detalle_form=detalle_form,
                                  vademecum=vademecum,
                                  ))

    def get_context_data(self,**kargs):        
        context = super( RecetaRegistrarView, self).get_context_data(**kargs)
        
        hce= HistoriaClinica.objects.get(pk=self.kwargs.get('id_hce'))
        context['historia_clinica'] = hce
        context['paciente_id'] = hce.paciente.id
        context['expediente'] =self.kwargs.get('id_hce')
        try:
            profesional = Medico.objects.get(user =  self.request.user)
            prestador = EspecialidadesMedicos.objects.filter(medico = profesional)
        except:
            prestador = ""        
        
        context['prestador']= prestador        
        try:
            os_receta = AfiliadosOS.objects.filter( Q(afiliado =  hce.paciente) & Q(estado=True))
            #os_receta = AfiliadosOS.objects.filter( afiliado =  hce.paciente)
        except:
            os_receta = ""        
        
        context['os_receta']= os_receta
        return context
    
    
    @method_decorator(user_passes_test(is_medico))
    def dispatch(self,request,*args, **kwargs):
        return super( RecetaRegistrarView, self).dispatch(request,*args, **kwargs)
     
    
class RecetaEditar(UpdateView):
    #No edita el formset!!!!!!
    model= Receta
    template_name="historiaclinica/receta_form.html"
    form_class = RecetaForm
    
    def get_context_data(self,**kargs):        
        context = super( RecetaEditar, self).get_context_data(**kargs)
        receta = Receta.objects.get(pk=self.kwargs.get('pk'))
        hce = receta.historia_clinica
        #if receta.estado == 'Pendiente':
        #   context['pendiente'] = True
        
        context['historia_clinica'] = hce
        context['paciente_id'] = hce.paciente.id
        context['expediente'] = hce.id
        
        try:
            profesional = Medico.objects.get(user =  self.request.user)
            prestador = EspecialidadesMedicos.objects.filter(medico = profesional)
        except:
            prestador = ""        
        
        context['prestador']= prestador       
        return context
class RecetaDelete(DeleteView):
    model = Receta
    context_object_name = "receta"
    #success_url = reverse_lazy('vista_laboratorio')
  
    def delete(self,request, *args, **kwargs):
        self.object = self.get_object()
        #id_hce = self.object.historia_clinica.id
        success_url= reverse_lazy('vista_receta_detalle', args=(self.object.id,))
        #self.object.delete()
        self.object.estado="Anulado"
        self.object.save()
        return HttpResponseRedirect(success_url)
    
#Reportes 
class Consultas_X_OS(ArchiveIndexView):
    model =  ConsultaMedica
    paginate_by = '10'
    date_field = "fecha"
    context_object_name = 'consultas_os'
    template_name = 'historiaclinica/consultas_os.html'
    allow_empty = True


    def get_queryset(self):
        #queryset = super(Consultas_X_OS , self).get_query_set()
        if self.request.GET.get('query') :
            try:
                os = ObraSocial.objects.get( nombre= self.request.GET.get('query'))                        
                reporte_os = ConsultaMedica.objects.filter(Q(os_consulta__obrasocial= os))
                if self.request.GET.get('fecha_ini') != "" and self.request.GET.get('fecha_fin') != "":
                    return reporte_os.filter(fecha__range= [self.request.GET.get('fecha_ini'),self.request.GET.get('fecha_fin')])
                return reporte_os
            except:
                pass
            
        return ConsultaMedica.objects.filter(id=self.request.GET.get('id_os'))            
        
        
    def get_context_data(self,**kargs):        
        context = super( ArchiveIndexView, self).get_context_data(**kargs)
        
        
        context['obrasociales'] = ObraSocial.objects.all() 
        if self.request.GET.get('query') :
            try:
                os = ObraSocial.objects.get( nombre= self.request.GET.get('query'))
                context['os_reporte'] = os
                context['fecha_ini'] = self.request.GET.get('fecha_ini')
                context['fecha_fin'] = self.request.GET.get('fecha_fin')
            except:
                pass                            
  
        return context   
    
    
    
#generar PDF
def Consultas_X_OS_PDF(request):
    os = ObraSocial.objects.get( cuit= request.GET.get('os_'))    
    fecha_ini = request.GET.get('fecha_ini_')
    fecha_fin= request.GET.get('fecha_fin_')            
    reporte_os = ConsultaMedica.objects.filter(os_consulta__obrasocial= os)
    if fecha_ini != "" and fecha_fin != "":
        reporte_os =reporte_os.filter(fecha__range= [fecha_ini,fecha_fin])

    periodo= fecha_ini +" - "+ fecha_fin
    print os , reporte_os
    return generar_pdf(request,os , reporte_os , periodo)
    
class Practicas_X_OS(ArchiveIndexView):
    model =  PracticaMedica
    paginate_by = '10'
    date_field = "fecha"
    context_object_name = 'practicas_os'
    template_name = 'historiaclinica/practicas_os.html'
    allow_empty = True
    
    
    def get_context_data(self,**kargs):        
        context = super( ArchiveIndexView, self).get_context_data(**kargs)
        
        
        context['obrasociales'] = ObraSocial.objects.all() 
        if self.request.GET.get('query') :
            try:
                os = ObraSocial.objects.get( nombre= self.request.GET.get('query'))
                context['os_reporte'] = os
                context['fecha_ini'] = self.request.GET.get('fecha_ini')
                context['fecha_fin'] = self.request.GET.get('fecha_fin')
            except:
                pass                            
  
        return context
    
    def get_queryset(self):
        #queryset = super(Consultas_X_OS , self).get_query_set()
        if self.request.GET.get('query') :
            try:
                os = ObraSocial.objects.get( nombre= self.request.GET.get('query'))                        
                reporte_os = PracticaMedica.objects.filter(Q(os_prescripcion__obrasocial= os))
                if self.request.GET.get('fecha_ini') != "" and self.request.GET.get('fecha_fin') != "":
                    return reporte_os.filter(fecha__range= [self.request.GET.get('fecha_ini'),self.request.GET.get('fecha_fin')])
                return reporte_os
            except:
                pass
            
            
        return PracticaMedica.objects.filter(id=self.request.GET.get('id_os'))   
"""    
    
    def get_queryset(self):
        #queryset = super(Consultas_X_OS , self).get_query_set()
        if self.request.GET.get('query') :
            try:
                os = ObraSocial.objects.get( nombre= self.request.GET.get('query'))                        
                reporte_os = PracticaMedica.objects.filter(Q(os_prescripcion__obrasocial= os))
                if self.request.GET.get('fecha_ini') != "" and self.request.GET.get('fecha_fin') != "":
                    return reporte_os.filter(fecha__range= [self.request.GET.get('fecha_ini'),self.request.GET.get('fecha_fin')])
                
                rank = {}
                print rank
                for prescripcion in reporte_os:
                    for p in prescripcion.practicas.all():
                        
                        print p
                        if not p in rank:
                            rank[p]= PracticaDetalle.objects.filter(practica = p).count()
                            print rank
                        else:
                            print "yata"
                
                
            
                rank= reversed(sorted(rank.items() , key=itemgetter(1)))
                for e in rank:
                    print e[0] , e[0].descripcion ,  e[1]
                    
                #return reporte_os
                return rank
            except:
                pass
            
            
        return PracticaMedica.objects.filter(id=self.request.GET.get('id_os'))  
"""     

    

 
    
#generar PDF
def Practicas_X_OS_PDF(request):
    os = ObraSocial.objects.get( cuit= request.GET.get('os_'))    
    fecha_ini = request.GET.get('fecha_ini_')
    fecha_fin= request.GET.get('fecha_fin_')            
    reporte_os = PracticaMedica.objects.filter(os_prescripcion__obrasocial= os)
    if fecha_ini != "" and fecha_fin != "":
        reporte_os =reporte_os.filter(fecha__range= [fecha_ini,fecha_fin])

    periodo= fecha_ini +" - "+ fecha_fin
    print os , reporte_os
    return generar_pdf_practicas(request,os , reporte_os , periodo)


class Rank_Practicas_X_OS(TemplateView):
    template_name ='historiaclinica/rank_practicas_os.html'
    
    
    def get_context_data(self,**kargs):        
        context = super( Rank_Practicas_X_OS, self).get_context_data(**kargs)
        
        
        context['obrasociales'] = ObraSocial.objects.all() 
        if self.request.GET.get('query') :
            try:
                os = ObraSocial.objects.get( nombre= self.request.GET.get('query'))
                context['os_reporte'] = os
                context['fecha_ini'] = self.request.GET.get('fecha_ini')
                context['fecha_fin'] = self.request.GET.get('fecha_fin')
                prescripciones = PracticaMedica.objects.filter(Q(os_prescripcion__obrasocial= os))
                #prescripciones = PracticaMedica.objects.all()
                
                if self.request.GET.get('fecha_ini') != "" and self.request.GET.get('fecha_fin') != "":
                    prescripciones =  prescripciones.filter(fecha__range= [self.request.GET.get('fecha_ini'),self.request.GET.get('fecha_fin')])
                    
                
                
                if prescripciones:
                    
                    rank = {}
                
                    for prescripcion in prescripciones:
                        for p in prescripcion.practicas.all():
                        
                        
                            if not p in rank:
                                rank[p]= PracticaDetalle.objects.filter(practica = p).count()
                            
                                    
                    rank= sorted(rank.items() , key=itemgetter(1))
                
                    rank.reverse()
                    rank = enumerate(rank, start =1)
                else :
                    rank=False
                    context["ranking_vacio"]=True
                    
                     
         
               
        
                context["ranking_practicas"] = list(rank)
                
                
                context["data_grafico"] =  context["ranking_practicas"] 
                
                
                
                
            except:
                pass                            
  
        return context
    
    #generar PDF
def Rank_Practicas_X_OS_PDF(request):
    os = ObraSocial.objects.get( cuit= request.GET.get('os_'))    
    fecha_ini = request.GET.get('fecha_ini_')
    fecha_fin= request.GET.get('fecha_fin_')            


    prescripciones = PracticaMedica.objects.filter(Q(os_prescripcion__obrasocial= os))
    if fecha_ini != "" and fecha_fin != "":
        prescripciones =  prescripciones.filter(fecha__range= [fecha_ini,fecha_fin])
               
    rank = {}
                
    for prescripcion in prescripciones:
        for p in prescripcion.practicas.all():
        
        
            if not p in rank:
                rank[p]= PracticaDetalle.objects.filter(practica = p).count()
            
                    
    rank= sorted(rank.items() , key=itemgetter(1))

    rank.reverse()
    rank = enumerate(rank, start =1)
    
    periodo= fecha_ini +" - "+ fecha_fin
    print os , rank
    return generar_pdf_rank_practicas(request,os , rank , periodo)

class VademecumListar(ListView):
    model= Vademecum
    paginate_by = '15'
    query_set = Vademecum.objects.all()
    context_object_name = "vademecum"
    template_name = "historiaclinica/lista_vademecum.html"
    
    
    
    def get_queryset(self):
        #queryset = super(Consultas_X_OS , self).get_query_set()
        if self.request.GET.get('query') :
            try:
                queryset = Vademecum.objects.filter( monodroga__contains= self.request.GET.get('query'))                        
                return queryset
            except:
                pass            
            
            
        return Vademecum.objects.all().order_by('id')       
    
    
class VademecumAgregar(CreateView):
    template_name="historiaclinica/vademecum_form.html"
    model = Vademecum
    #form_class =  PerinatalesForm
    success_url = reverse_lazy('vista_vademecum')
    
class VademecumEditar(UpdateView):
    model= Vademecum
    template_name="historiaclinica/vademecum_form.html"
    success_url = reverse_lazy('vista_vademecum')
    
class VademecumDeshabilitar(DeleteView):
    model = Vademecum
    context_object_name = "vademecum"
    success_url = reverse_lazy('vista_vademecum')
    
      
    def delete(self,request, *args, **kwargs):
        self.object = self.get_object()
        #id_hce = self.object.historia_clinica.id
        #success_url= reverse_lazy('vista_receta_detalle', args=(self.object.id,))
        #self.object.delete()
        self.object.estado=False
        self.object.save()
        return HttpResponseRedirect(self.success_url)
    
class InosListar(ListView):
    model= Inos
    paginate_by = '15'
    query_set = Inos.objects.all()
    context_object_name = "inos"
    template_name = "historiaclinica/lista_inos.html"
    
    
    
    def get_queryset(self):
        #queryset = super(Consultas_X_OS , self).get_query_set()
        if self.request.GET.get('query') :
            try:
                queryset = Inos.objects.filter( descripcion__contains= self.request.GET.get('query'))                        
                return queryset
            except:
                pass
                
                
        return Inos.objects.all().order_by('capitulo','codigo')
            
            
class InosAgregar(CreateView):
    template_name="historiaclinica/inos_form.html"
    model = Inos
    #form_class =  PerinatalesForm
    success_url = reverse_lazy('vista_inos')
        
class InosEditar(UpdateView):   
    model= Inos
    template_name="historiaclinica/inos_form.html"
    success_url = reverse_lazy('vista_inos')
    
class InosDeshabilitar(DeleteView):
    model = Inos
    context_object_name = "inos"
    success_url = reverse_lazy('vista_inos')
    
     
    def delete(self,request, *args, **kwargs):
        self.object = self.get_object()
        #id_hce = self.object.historia_clinica.id
        #success_url= reverse_lazy('vista_receta_detalle', args=(self.object.id,))
        #self.object.delete()
        self.object.estado=False
        self.object.save()
        return HttpResponseRedirect(self.success_url)
     
    
class Rank_Diagnosticos(TemplateView):
    template_name ='historiaclinica/rank_diagnosticos.html'
    
    
    def get_context_data(self,**kargs):        
        context = super( Rank_Diagnosticos, self).get_context_data(**kargs)
        
        consultas= ConsultaMedica.objects.all()
        
        
        if self.request.GET.get('fecha_ini')  and self.request.GET.get('fecha_fin') :
            
            consultas =  ConsultaMedica.objects.filter(fecha__range= [self.request.GET.get('fecha_ini'),self.request.GET.get('fecha_fin')])
         
   
        
        print consultas
        context['fecha_ini'] = self.request.GET.get('fecha_ini')
        context['fecha_fin'] = self.request.GET.get('fecha_fin')
                        
        if consultas:
            
            rank = {}
        
            for consulta in consultas:
                for diagnostico in consulta.diagnosticos.all():
                
          
                    if not diagnostico in rank and diagnostico.codigo !='0000':
                        #rank[diagnostico]= Consulta.objects.filter(diag = p).count()
                        rank[diagnostico]= diagnostico.consultamedica_set.all().count()
                    
                    
                            
            rank= sorted(rank.items() , key=itemgetter(1))
        
            rank.reverse()
            rank = enumerate(rank, start =1)
        else :
            rank=()         
            context["ranking_vacio"]=True
         
            
             
 
       

        context["ranking_diagnosticos"] = list(rank)
        
        
        context["data_grafico"] =  context["ranking_diagnosticos"] 
        
                                   
  
        return context
            
            
class Rank_Usuarios(TemplateView):
    template_name ='historiaclinica/rank_usuarios_registrados.html'
        
    def get_context_data(self,**kargs):        
        context = super( Rank_Usuarios, self).get_context_data(**kargs)
        
        usuarios= User.objects.all()
        
        
        #if self.request.GET.get('fecha_ini')  and self.request.GET.get('fecha_fin') :
        #usuarios =  User.objects.filter(date_joined__range= [self.request.GET.get('fecha_ini'),self.request.GET.get('fecha_fin')])
           
         
   
        
        
        rank={}

        hasta = datetime.today()
        dias= hasta.day
        
        desde= hasta -  timedelta(days= dias)
        for i in range(1,12):
            rank[hasta] =  User.objects.filter(date_joined__range= [desde,hasta]).count()        
            hasta = desde
            desde = hasta - relativedelta(months=1)
        
        item= rank.keys() 
        lista=[]
        for f in  sorted(item):
            lista.append([f.strftime('%B %m/%Y') , rank[f]])
        
   
       
        context["usuarios"] = lista
        context["data_grafico"] =  context["usuarios"]                        
  
        return context
    