

SEXO_CHOICE = (
                   ('M','Masculino'),
                   ('F','Femenino'),
                   )
TIPO_DOC = (
            ('DNI','DNI'),
            ('CI','Cedula de Identidad'),
            ('LE','Libreta de Enrolamiento'),
            ('LC','Libreta Civica'),
            )
"""
DIA_CHOICES = (
               ('LUN', 'Lunes'),
               ('MAR','Martes'),
               ('MIE','Miercoles'),
               ('JUE','Jueves'),
               ('VIE','Viernes'),
               ('SAB','Sabado'),
               
                )
"""
DIA_CHOICES = (
               (0, 'Lunes'),
               (1,'Martes'),
               (2,'Miercoles'),
               (3,'Jueves'),
               (4,'Viernes'),
               (5,'Sabado'),
               
                )

ESTADO_CIVIL_CHOICE = (
    ('-', 'No Definido'),
    ('S', 'Soltero'),
    ('C', 'Casado'),
    ('V', 'Viudo'),
    ('D', 'Divorciado'),
)


GRUPO_SANGUINEO_CHOICE = (
    ("O+", "O+"),
    ("O-","O-"),
    ("A+","A+"),
    ("A-","A-"),
    ("B+","B+"),
    ("B-","B-"),
    ("AB+","AB+"),
    ("AB-","AB-"),
)


TIPOS_PRACTICAS_CHOICES =( ("ANC","Analisis Clinicos"),
                           ("QUI","Quirurgicas"),
                           ("ODO","Odontologicas"),
                           ("ESP","Especializadas"),
                           )

TIPOS_ESTADOS_PRACTICAS =( ("Pendiente","Pendiente"),
                           ("Realizado","Realizado"),
                           ("Finalizado","Finalizado"),
                           ("Anulado","Anulado"),
                           
                           )


TIPOS_ESTADOS_RECETA = ( ("Activo","Activo"),
                        ("Anulado","Anulado"),
                           
                           
                           )
TIPOS_ESTADOS_TURNOS = ( ("Presente","Presente"),                        
                        ("Ausente","Ausente"),                                                    
                           )

MESES =['01','02','03','04','05','06','07','08','09','10','11','12',]
