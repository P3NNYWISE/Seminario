from reportlab.platypus import SimpleDocTemplate,Table,TableStyle,Spacer

from reportlab.lib.pagesizes import A4
from reportlab.lib import colors

##Importamos clase de hoja de estilo de ejemplo.
from reportlab.lib.styles import getSampleStyleSheet
from reportlab.platypus import Paragraph

story=[]
##Creamos un PageTemplate de ejemplo.

estiloHoja = getSampleStyleSheet()
####Definimos c0mo queremos que sea el estilo de la PageTemplate.
cabecera = estiloHoja['Heading4']
##No se hara un salto de pagina despues de escribir la cabecera (valor 1 en caso contrario).
cabecera.pageBreakBefore=0


parrafo = Paragraph("CABECERA DEL DOCUMENTO ",cabecera)
story.append(parrafo)
##Definimos un parrafo. Vamos a crear un texto largo para demostrar cmo se genera ms de una hoja.
cadena = " cuerpo del parrafo" 

##Damos un estilo BodyText al segundo parrafo, que sera el texto a escribir.

estilo = estiloHoja['BodyText']
parrafo2 = Paragraph(cadena, estilo)
story.append(parrafo2)
doc=SimpleDocTemplate("ejemplo.pdf",pagesize=A4,ShowBoundary=1)

story.append(Spacer(0,15))


lista=[['','col2','col3'],['fil1','fil1','fil1'],['fil2','fil2','fil2'],['fil2','fil2','fil2'],['fil2','fil2','fil2']]

tabla=Table(lista)
tabla.setStyle([('BACKGROUND',(0,0),(-1,0),colors.cyan)])
tabla.setStyle([('TEXTCOLOR',(0,0),(0,-1),colors.blue),('TEXTCOLOR',(1,1),(-1,-1),colors.red)])
tabla.setStyle([('BOX',(0,0),(-1,-1),0.25,colors.black)])
tabla.setStyle([('INNERGRID', (0,0), (-1,-1), 0.25, colors.black)])
story.append(tabla)



doc.build(story)
print "fin"

