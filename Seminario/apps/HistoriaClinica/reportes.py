

import cStringIO as StringIO

from django.template import RequestContext

from django.http import HttpResponse
from django.shortcuts import get_object_or_404

from datetime import date

from reportlab.platypus import SimpleDocTemplate,Table,TableStyle,Spacer

from reportlab.lib.pagesizes import A4
from reportlab.lib import colors

##Importamos clase de hoja de estilo de ejemplo.
from reportlab.lib.styles import getSampleStyleSheet
from reportlab.platypus import Paragraph
from reportlab.lib.units import inch


#Constantes
PAGE_WIDTH = A4[0]
PAGE_HEIGHT = A4[1]
PIE_PAGINA = "Sistema Online de  Gestion Medica"


def myFirstPage(canvas,doc):
    canvas.saveState()
    
    canvas.setFont('Times-Bold',10)
    #Marcos de pagina
    canvas.rect(30,80, PAGE_WIDTH-50, PAGE_HEIGHT-140)
    canvas.rect(30,80, PAGE_WIDTH-50, PAGE_HEIGHT-220)
    canvas.rect(30,30, PAGE_WIDTH-50,50)
    #canvas.drawCentredString(PAGE_WIDTH/2.0 , PAGE_HEIGHT , TITULO)
    canvas.drawCentredString(PAGE_WIDTH/2.0 , 35 , PIE_PAGINA)
    #canvas.drawString(inch , 10.5 * inch,TITULO)
    canvas.setFont('Times-Roman',9)
    canvas.drawString(inch , 0.75 * inch,'Pagina %s '%doc.page)
    canvas.restoreState()





def generar_pdf(request, os, reporte , periodo):
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
    parrafo = Paragraph("Reporte de Consultas                        -         Fecha    -"+date.today().strftime("%d/%m/%Y"),cabecera)
    story.append(parrafo)
    
    
    p =" Obra Social  : %s  -   Cuit : %s <br/> Periodo : %s "%(os,os.cuit,periodo)
    p=p+" <br/> Total  : %s   "%reporte.count()  
    parrafo = Paragraph(p,titulo)
    story.append(parrafo)
    

    
    lista=[['Nro ', 'Fecha','Afiliado','DNI','Paciente','Prestador','Matricula']]
    
    for linea in reporte:
            
                    
            nro= linea.id
            fecha = linea.fecha.strftime("%d/%m/%Y")
            nro_afiliado = linea.os_consulta.beneficiario
            dni = linea.historia_clinica.paciente.get_profile().dni
            paciente = linea.historia_clinica.paciente.get_full_name()
            prestador= linea.prestador        
            matricula = linea.prestador.medico.matricula
            lista.append([ nro ,fecha,nro_afiliado,dni ,paciente,prestador,matricula])
                 
    story.append(Spacer(0,15))
    story.append(Spacer(0,15))
    tabla=Table(lista)
    tabla.setStyle([('BACKGROUND',(0,0),(-1,0),colors.lightblue),('ALIGN',(0,0),(-1,-1),'CENTER')])
    tabla.setStyle([('BACKGROUND',(0,1),(0,-1),colors.lightblue)])
    tabla.setStyle([('TEXTCOLOR',(0,0),(0,-1),colors.blue),('TEXTCOLOR',(1,1),(-1,-1),colors.black)])
    tabla.setStyle([('BOX',(0,0),(-1,-1),0.25,colors.black)])
    tabla.setStyle([('INNERGRID', (0,0), (-1,-1), 0.25, colors.black)])
    
    story.append(tabla)
    

    
    #Crear con buffer como archivo pdf
    doc=SimpleDocTemplate(buffer,pagesize=A4,ShowBoundary=1 ,title="Titulo")
    doc.build(story , onFirstPage =  myFirstPage)


    # Get the value of the StringIO buffer and write it to the response.
    pdf = buffer.getvalue()
    buffer.close()
    #response.write(pdf)
    response.write(pdf)
    return response

def generar_pdf_practicas(request, os, reporte , periodo):
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
    parrafo = Paragraph("Reporte de Prescripciones Practicas                        -         Fecha    -"+date.today().strftime("%d/%m/%Y"),cabecera)
    story.append(parrafo)
    
    
    p =" Obra Social  : %s  -   Cuit : %s <br/> Periodo : %s "%(os,os.cuit,periodo)
    p=p+" <br/> Total  : %s   "%reporte.count()  
    parrafo = Paragraph(p,titulo)
    story.append(parrafo)
    

    
    lista=[['Nro ', 'Fecha','Afiliado','DNI','Paciente','Prestador','Matricula','estado']]
    
    for linea in reporte:
            
                    
            nro= linea.id
            fecha = linea.fecha.strftime("%d/%m/%Y")
            
            nro_afiliado = linea.os_prescripcion.beneficiario
            dni = linea.historia_clinica.paciente.get_profile().dni
            paciente = linea.historia_clinica.paciente.get_full_name()
            prestador= linea.prestador        
            matricula = linea.prestador.medico.matricula
            estado = linea.estado
            lista.append([ nro ,fecha,nro_afiliado,dni ,paciente,prestador,matricula,estado])
                 
    story.append(Spacer(0,15))
    story.append(Spacer(0,15))
    tabla=Table(lista)
    tabla.setStyle([('BACKGROUND',(0,0),(-1,0),colors.lightblue),('ALIGN',(0,0),(-1,-1),'CENTER')])
    tabla.setStyle([('BACKGROUND',(0,1),(0,-1),colors.lightblue)])
    tabla.setStyle([('TEXTCOLOR',(0,0),(0,-1),colors.blue),('TEXTCOLOR',(1,1),(-1,-1),colors.black)])
    tabla.setStyle([('BOX',(0,0),(-1,-1),0.25,colors.black)])
    tabla.setStyle([('INNERGRID', (0,0), (-1,-1), 0.25, colors.black)])
    
    story.append(tabla)
    

    
    #Crear con buffer como archivo pdf
    doc=SimpleDocTemplate(buffer,pagesize=A4,ShowBoundary=1 ,title="Titulo")
    doc.build(story , onFirstPage =  myFirstPage)


    # Get the value of the StringIO buffer and write it to the response.
    pdf = buffer.getvalue()
    buffer.close()
    #response.write(pdf)
    response.write(pdf)
    return response



def generar_pdf_rank_practicas(request, os, reporte , periodo):
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
    parrafo = Paragraph("Reporte Ranking de Practicas por Obra Social                        -         Fecha    -"+date.today().strftime("%d/%m/%Y"),cabecera)
    story.append(parrafo)
    
    
    p =" Obra Social  : %s  -   Cuit : %s <br/> Periodo : %s "%(os,os.cuit,periodo)
    
    parrafo = Paragraph(p,titulo)
    story.append(parrafo)
    

    
    lista=[['Nro ', 'Codigo Practica','Descripcion','Cantidad']]
    
    #for linea in reporte:
    for i,practica in reporte:
            
                    
            nro= i
            """
            fecha = linea.fecha.strftime("%d/%m/%Y")
            
            nro_afiliado = linea.os_prescripcion.beneficiario
            dni = linea.historia_clinica.paciente.get_profile().dni
            paciente = linea.historia_clinica.paciente.get_full_name()
            prestador= linea.prestador        
            matricula = linea.prestador.medico.matricula
            estado = linea.estado
            """
            codigo=practica[0]
            descripcion =practica[0].descripcion 
            cantidad=practica[1]
            lista.append([ nro ,codigo,descripcion,cantidad])
                 
    story.append(Spacer(0,15))
    story.append(Spacer(0,15))
    tabla=Table(lista)
    tabla.setStyle([('BACKGROUND',(0,0),(-1,0),colors.lightblue),('ALIGN',(0,0),(-1,-1),'CENTER')])
    tabla.setStyle([('BACKGROUND',(0,1),(0,-1),colors.lightblue)])
    tabla.setStyle([('TEXTCOLOR',(0,0),(0,-1),colors.blue),('TEXTCOLOR',(1,1),(-1,-1),colors.black)])
    tabla.setStyle([('BOX',(0,0),(-1,-1),0.25,colors.black)])
    tabla.setStyle([('INNERGRID', (0,0), (-1,-1), 0.25, colors.black)])
    
    story.append(tabla)
    

    
    #Crear con buffer como archivo pdf
    doc=SimpleDocTemplate(buffer,pagesize=A4,ShowBoundary=1 ,title="Titulo")
    doc.build(story , onFirstPage =  myFirstPage)


    # Get the value of the StringIO buffer and write it to the response.
    pdf = buffer.getvalue()
    buffer.close()
    #response.write(pdf)
    response.write(pdf)
    return response



