
#import ho.pisa as pisa
import cStringIO as StringIO
import cgi
from django.template import RequestContext
from django.template.loader import render_to_string
from django.http import HttpResponse
from django.shortcuts import get_object_or_404
from Seminario.apps.turnos.models import  Especialidad ,DiaAtencion , Turno ,AfiliadosOS
from Seminario.apps.HistoriaClinica.models import  HistoriaClinica
from datetime import date

def generar_pdf_back(html):
    # Funcion para generar el archivo PDF y devolverlo mediante HttpResponse
    result = StringIO.StringIO()
    pdf = pisa.pisaDocument(StringIO.StringIO(html.encode("UTF-8")), result)
    if not pdf.err:
        return HttpResponse(result.getvalue(), mimetype='application/pdf')
    return HttpResponse('Error al generar el PDF: %s' % cgi.escape(html))

def especialidad_pdf(request, id):
    # vista de ejemplo con un hipotetico modelo Libro
    #esp = get_object_or_404(Especialidad, id=id)
    esp = Especialidad.objects.all()

    ctx = {'pagesize':'A4', 'especialidad':esp , 'fecha': date.today() } 
    html = render_to_string('turnos/turnos_pdf.bkp.html', ctx, context_instance=RequestContext(request))
    return generar_pdf(html)

def turnos_pdf_back(request, id):
    # vista de ejemplo con un hipotetico modelo Libro
    #esp = get_object_or_404(Especialidad, id=id)
    dia_atencion = DiaAtencion.objects.get(id=id)
    turnos = Turno.objects.filter(dia_atencion=dia_atencion)
    #afiliacion = turnos.objects.exclude(paciente == None)
    
    ctx = {'pagesize':'A4', 'turnos':turnos ,'dia_atencion':dia_atencion  , 'fecha': date.today() } 
    html = render_to_string('turnos/turnos_pdf.html', ctx, context_instance=RequestContext(request))
    return generar_pdf(html)

#from cStringIO import StringIO
from reportlab.pdfgen import canvas
#from django.http import HttpResponse

from reportlab.platypus import SimpleDocTemplate,Table,TableStyle,Spacer

from reportlab.lib.pagesizes import A4 ,letter,A5 , A6 ,landscape
from reportlab.lib import colors

##Importamos clase de hoja de estilo de ejemplo.
from reportlab.lib.styles import getSampleStyleSheet
from reportlab.platypus import Paragraph
from reportlab.lib.units import inch

PAGE_WIDTH = A4[0]

PAGE_HEIGHT = A4[1]

COMPROBANTE_WIDTH = A6[1]
COMPROBANTE_HEIGHT = A6[0]



TITULO = "Comprobante de Solicitud de Turno"
PIE_PAGINA = "Sistema Online de Gestion Medica"
OS= "IPS"
FECHA= "-/-/-"





def plantilla_turnos(canvas,doc):
    canvas.saveState()
    
    canvas.setFont('Times-Bold',10)
    canvas.rect(50,80, PAGE_WIDTH-100, PAGE_HEIGHT-140)
    canvas.rect(50,80, PAGE_WIDTH-100, PAGE_HEIGHT-200)
    canvas.rect(50,30, PAGE_WIDTH-100,50)
    #canvas.drawCentredString(PAGE_WIDTH/2.0 , PAGE_HEIGHT , TITULO)
    canvas.drawCentredString(PAGE_WIDTH/2.0 , 35 , PIE_PAGINA)
    #canvas.drawString(inch , 10.5 * inch,TITULO)
    canvas.setFont('Times-Roman',9)
    canvas.drawString(inch , 0.75 * inch,'Pagina %s '%doc.page)
    canvas.restoreState()





def generar_pdf(request, dia_atencion, turnos):
    # Create the HttpResponse object with the appropriate PDF headers.
    response = HttpResponse(mimetype='application/pdf')
    #response['Content-Disposition'] = 'attachment; filename=somefilename.pdf'

    buffer = StringIO.StringIO()

    # Create the PDF object, using the StringIO object as its "file."
    #p = canvas.Canvas(buffer)

    # Draw things on the PDF. Here's where the PDF generation happens.
    # See the ReportLab documentation for the full list of functionality.
    #p.drawString(100, 100, "Hello world.")

    # Close the PDF object cleanly.
    story=[]
    ##Creamos un PageTemplate de ejemplo.

    estiloHoja = getSampleStyleSheet()
    ####Definimos c0mo queremos que sea el estilo de la PageTemplate.
    cabecera = estiloHoja['Heading3']
    titulo = estiloHoja['Heading4']
    ##No se hara un salto de pagina despues de escribir la cabecera (valor 1 en caso contrario).
    cabecera.pageBreakBefore=0
    parrafo = Paragraph("Reporte de Turnos                        -         Fecha    -"+date.today().strftime("%d/%m/%Y"),cabecera)
    story.append(parrafo)
    #parrafo = Paragraph("Prestador  : "+dia_atencion.prestador.__unicode__(),titulo)
    #story.append(parrafo)
    #parrafo = Paragraph("<br/> Turnos del dia : " + dia_atencion.fecha.strftime("%d/%m/%Y"),titulo)
    
    p =" Prestador  : %s  <br/><br/> Turnos del dia : %s"%(dia_atencion.prestador.__unicode__() , dia_atencion.fecha.strftime("%d/%m/%Y")) 
    parrafo = Paragraph(p,titulo)
    story.append(parrafo)
    
    """Definimos un parrafo. Vamos a crear un texto largo para demostrar cmo se genera ms de una hoja.
    cadena = "parrafo"    
    estilo = estiloHoja['BodyText']
    parrafo2 = Paragraph(cadena, estilo)
    story.append(parrafo2)
    """
    
    lista=[['Hora ', 'Paciente','Tipo','Nro','Telefono','Expediente' ,'Observaciones']]
    for t in turnos:
        if t.paciente:
            
            try:
                expediente=HistoriaClinica.objects.get(paciente= t.paciente).id
            except:    
                expediente=""
            paciente= t.paciente.get_full_name()
            tipo = t.paciente.get_profile().tipo
            dni = t.paciente.get_profile().dni
            telefono= t.paciente.get_profile().telefono
        else:
            expediente=""
            paciente= "Disponible"
            tipo=""
            dni=""
            telefono=""
        lista.append([ t.hora_turno ,paciente,tipo, dni,telefono,expediente ,t.observacion])     
    story.append(Spacer(0,15))
    tabla=Table(lista)
    tabla.setStyle([('BACKGROUND',(0,0),(-1,0),colors.lightblue) ,('ALIGN',(0,0),(-1,-1),'CENTER')])
    tabla.setStyle([('BACKGROUND',(0,1),(0,-1),colors.lightblue)])
    tabla.setStyle([('TEXTCOLOR',(0,0),(0,-1),colors.blue),('TEXTCOLOR',(1,1),(-1,-1),colors.black)])
    tabla.setStyle([('BOX',(0,0),(-1,-1),0.25,colors.black)])
    tabla.setStyle([('INNERGRID', (0,0), (-1,-1), 0.25, colors.black)])
    
    story.append(tabla)
    #Crear con buffer como archivo pdf
    doc=SimpleDocTemplate(buffer,pagesize=A4,ShowBoundary=1 ,title="Titulo")
    doc.build(story , onFirstPage =  plantilla_turnos)


    # Get the value of the StringIO buffer and write it to the response.
    pdf = buffer.getvalue()
    buffer.close()
    #response.write(pdf)
    response.write(pdf)
    return response



def turnos_pdf(request, id):
    # vista de ejemplo con un hipotetico modelo Libro
    #esp = get_object_or_404(Especialidad, id=id)
    dia_atencion = DiaAtencion.objects.get(id=id)
    turnos = Turno.objects.filter(dia_atencion=dia_atencion)
    #afiliacion = turnos.objects.exclude(paciente == None)
    
    #ctx = {'pagesize':'A4', 'turnos':turnos ,'dia_atencion':dia_atencion  , 'fecha': date.today() } 
    #html = render_to_string('turnos/turnos_pdf.html', ctx, context_instance=RequestContext(request))
    return generar_pdf(request,dia_atencion , turnos)


def plantilla_comprobante(canvas,doc):
    canvas.saveState()
    canvas.setTitle('Titulo2')
    canvas.setSubject('Titulo3')
    canvas.setFont('Times-Bold',10)
    canvas.rect(15,65, COMPROBANTE_WIDTH-30, COMPROBANTE_HEIGHT-80)
    canvas.rect(15,65, COMPROBANTE_WIDTH-30, COMPROBANTE_HEIGHT-150)
    canvas.rect(15,15, COMPROBANTE_WIDTH-30,50)
    #canvas.drawCentredString(PAGE_WIDTH/2.0 , PAGE_HEIGHT , TITULO)
    canvas.drawCentredString(COMPROBANTE_WIDTH/2.0 , 20 , PIE_PAGINA)
    #canvas.drawString(inch , 10.5 * inch,TITULO)
    canvas.setFont('Times-Roman',9)
    canvas.drawString(inch , 0.75 * inch,'Pagina %s '%doc.page)
    canvas.restoreState()



def generar_pdf_comprobante(request,turno):
    
    # Create the HttpResponse object with the appropriate PDF headers.
    response = HttpResponse(mimetype='application/pdf')
    #response['Content-Disposition'] = 'attachment; filename=somefilename.pdf'

    buffer = StringIO.StringIO()

    # Create the PDF object, using the StringIO object as its "file."
    #p = canvas.Canvas(buffer)

    # Draw things on the PDF. Here's where the PDF generation happens.
    # See the ReportLab documentation for the full list of functionality.
    #p.drawString(100, 100, "Hello world.")

    # Close the PDF object cleanly.
    story=[]
    ##Creamos un PageTemplate de ejemplo.

    estiloHoja = getSampleStyleSheet()
    ####Definimos c0mo queremos que sea el estilo de la PageTemplate.
    cabecera = estiloHoja['Heading4']

    ##No se hara un salto de pagina despues de escribir la cabecera (valor 1 en caso contrario).
    cabecera.pageBreakBefore=0
    cabecera.keepWithtext=1
    
    
    parrafo = Paragraph(TITULO,cabecera)
    story.append(parrafo)
    ##Definimos un parrafo. Vamos a crear un texto largo para demostrar cmo se genera ms de una hoja.
    cadena = "Paciente : %s "  % turno.paciente.get_full_name()  
    cadena += "<br/> Fecha Solicitud  :    " + turno.fecha_creacion.strftime("%d/%m/%Y")
    ##Damos un estilo BodyText al segundo parrafo, que sera el texto a escribir.
    
    estilo = estiloHoja['BodyText']
    parrafo2 = Paragraph(cadena, estilo)
    story.append(parrafo2)
    
    
    story.append(Spacer(0,30))
    turno = "Profesional   :  %s   <br/><br/> Fecha :  %s <br/><br/>  Hora : %s <br/> <br/>Orden : %s <br/>"%(turno.dia_atencion.prestador , turno.dia_atencion.fecha.strftime("%d/%m/%Y") , turno.hora_turno ,turno.id)
    turno = Paragraph(turno, estilo)
    story.append(turno)
    
    doc=SimpleDocTemplate(buffer,pagesize=landscape(A6),ShowBoundary=1 , title="Titulo" , leftMargin= 35 , topMargin = 20)


    doc.build(story , onFirstPage =  plantilla_comprobante)


    # Get the value of the StringIO buffer and write it to the response.
    pdf = buffer.getvalue()
    buffer.close()
    #response.write(pdf)
    response.write(pdf)
    return response
    
    
    



