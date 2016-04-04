
-- MySQL 2 PostgreSQL dump

SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;

-- Table: HistoriaClinica_capitulosinos
DROP TABLE IF EXISTS "HistoriaClinica_capitulosinos" CASCADE;
CREATE TABLE "HistoriaClinica_capitulosinos" (
  "tipo" character varying(3) NOT NULL,
  "nro_capitulo" character varying(4) NOT NULL,
  "nombre_capitulo" character varying(30) NOT NULL
)
WITHOUT OIDS;

-- Table: HistoriaClinica_cie10
DROP TABLE IF EXISTS "HistoriaClinica_cie10" CASCADE;
CREATE TABLE "HistoriaClinica_cie10" (
  "codigo" character varying(4) NOT NULL,
  "descripcion" character varying(20) NOT NULL,
  "estado" boolean NOT NULL
)
WITHOUT OIDS;

DROP SEQUENCE IF EXISTS HistoriaClinica_consultamedica_id_seq CASCADE;
CREATE SEQUENCE HistoriaClinica_consultamedica_id_seq INCREMENT BY 1
                                  NO MAXVALUE NO MINVALUE CACHE 1;
SELECT pg_catalog.setval('HistoriaClinica_consultamedica_id_seq', 14, true);

-- Table: HistoriaClinica_consultamedica
DROP TABLE IF EXISTS "HistoriaClinica_consultamedica" CASCADE;
CREATE TABLE "HistoriaClinica_consultamedica" (
  "id" integer DEFAULT nextval('HistoriaClinica_consultamedica_id_seq'::regclass) NOT NULL,
  "historia_clinica_id" integer NOT NULL,
  "prestador_id" integer NOT NULL,
  "os_consulta_id" integer NOT NULL,
  "fecha" timestamp without time zone NOT NULL,
  "motivos_consulta" text NOT NULL,
  "sintomas" text NOT NULL,
  "terapeutica" text,
  "observaciones" text NOT NULL,
  "estado" boolean NOT NULL
)
WITHOUT OIDS;

DROP SEQUENCE IF EXISTS HistoriaClinica_consultamedica_diagnosticos_id_seq CASCADE;
CREATE SEQUENCE HistoriaClinica_consultamedica_diagnosticos_id_seq INCREMENT BY 1
                                  NO MAXVALUE NO MINVALUE CACHE 1;
SELECT pg_catalog.setval('HistoriaClinica_consultamedica_diagnosticos_id_seq', 20, true);

-- Table: HistoriaClinica_consultamedica_diagnosticos
DROP TABLE IF EXISTS "HistoriaClinica_consultamedica_diagnosticos" CASCADE;
CREATE TABLE "HistoriaClinica_consultamedica_diagnosticos" (
  "id" integer DEFAULT nextval('HistoriaClinica_consultamedica_diagnosticos_id_seq'::regclass) NOT NULL,
  "consultamedica_id" integer NOT NULL,
  "cie10_id" character varying(4) NOT NULL
)
WITHOUT OIDS;

DROP SEQUENCE IF EXISTS HistoriaClinica_examenfisico_id_seq CASCADE;
CREATE SEQUENCE HistoriaClinica_examenfisico_id_seq INCREMENT BY 1
                                  NO MAXVALUE NO MINVALUE CACHE 1;
SELECT pg_catalog.setval('HistoriaClinica_examenfisico_id_seq', 6, true);

-- Table: HistoriaClinica_examenfisico
DROP TABLE IF EXISTS "HistoriaClinica_examenfisico" CASCADE;
CREATE TABLE "HistoriaClinica_examenfisico" (
  "id" integer DEFAULT nextval('HistoriaClinica_examenfisico_id_seq'::regclass) NOT NULL,
  "historia_clinica_id" integer NOT NULL,
  "fecha_examen" timestamp without time zone NOT NULL,
  "impresion_general" text NOT NULL,
  "pres_art_sist" integer NOT NULL,
  "pres_art_diast" integer NOT NULL,
  "frec_respiratoria" integer NOT NULL,
  "temp_corporal" double precision NOT NULL,
  "pulso" integer NOT NULL,
  "peso_medio" double precision NOT NULL,
  "altura_media" double precision NOT NULL,
  "peso" double precision NOT NULL,
  "altura" double precision NOT NULL,
  "talla" character varying(30) NOT NULL,
  "bmi" double precision NOT NULL
)
WITHOUT OIDS;

DROP SEQUENCE IF EXISTS HistoriaClinica_fisiologicos_id_seq CASCADE;
CREATE SEQUENCE HistoriaClinica_fisiologicos_id_seq INCREMENT BY 1
                                  NO MAXVALUE NO MINVALUE CACHE 1;
SELECT pg_catalog.setval('HistoriaClinica_fisiologicos_id_seq', 7, true);

-- Table: HistoriaClinica_fisiologicos
DROP TABLE IF EXISTS "HistoriaClinica_fisiologicos" CASCADE;
CREATE TABLE "HistoriaClinica_fisiologicos" (
  "id" integer DEFAULT nextval('HistoriaClinica_fisiologicos_id_seq'::regclass) NOT NULL,
  "historia_clinica_id" integer NOT NULL,
  "fecha" timestamp without time zone NOT NULL,
  "alimentacion" character varying(30) NOT NULL,
  "dipsia" character varying(30) NOT NULL,
  "diuresis" character varying(30) NOT NULL,
  "catarsis" character varying(30) NOT NULL,
  "sommia" character varying(30) NOT NULL,
  "observaciones" text NOT NULL
)
WITHOUT OIDS;

DROP SEQUENCE IF EXISTS HistoriaClinica_habitostoxicos_id_seq CASCADE;
CREATE SEQUENCE HistoriaClinica_habitostoxicos_id_seq INCREMENT BY 1
                                  NO MAXVALUE NO MINVALUE CACHE 1;
SELECT pg_catalog.setval('HistoriaClinica_habitostoxicos_id_seq', 7, true);

-- Table: HistoriaClinica_habitostoxicos
DROP TABLE IF EXISTS "HistoriaClinica_habitostoxicos" CASCADE;
CREATE TABLE "HistoriaClinica_habitostoxicos" (
  "id" integer DEFAULT nextval('HistoriaClinica_habitostoxicos_id_seq'::regclass) NOT NULL,
  "historia_clinica_id" integer NOT NULL,
  "fecha" timestamp without time zone NOT NULL,
  "alcohol" boolean NOT NULL,
  "tabaco" boolean NOT NULL,
  "drogas" boolean NOT NULL,
  "infuciones" boolean NOT NULL,
  "observaciones" text NOT NULL
)
WITHOUT OIDS;

DROP SEQUENCE IF EXISTS HistoriaClinica_historiaclinica_id_seq CASCADE;
CREATE SEQUENCE HistoriaClinica_historiaclinica_id_seq INCREMENT BY 1
                                  NO MAXVALUE NO MINVALUE CACHE 1;
SELECT pg_catalog.setval('HistoriaClinica_historiaclinica_id_seq', 12, true);

-- Table: HistoriaClinica_historiaclinica
DROP TABLE IF EXISTS "HistoriaClinica_historiaclinica" CASCADE;
CREATE TABLE "HistoriaClinica_historiaclinica" (
  "id" integer DEFAULT nextval('HistoriaClinica_historiaclinica_id_seq'::regclass) NOT NULL,
  "paciente_id" integer NOT NULL,
  "prestador_id" integer NOT NULL,
  "fecha_creacion" date NOT NULL,
  "lugar_nacimiento" character varying(60) NOT NULL,
  "grupo_sanguineo" character varying(3) NOT NULL,
  "estado_civil" character varying(1) NOT NULL,
  "ocupacion" character varying(30) NOT NULL,
  "religion" character varying(30) NOT NULL,
  "padre" character varying(120) NOT NULL,
  "madre" character varying(120) NOT NULL,
  "motivo_consulta" text NOT NULL,
  "antecedentes_enfermedad_actual" text NOT NULL
)
WITHOUT OIDS;

DROP SEQUENCE IF EXISTS HistoriaClinica_inos_id_seq CASCADE;
CREATE SEQUENCE HistoriaClinica_inos_id_seq INCREMENT BY 1
                                  NO MAXVALUE NO MINVALUE CACHE 1;
SELECT pg_catalog.setval('HistoriaClinica_inos_id_seq', 28, true);

-- Table: HistoriaClinica_inos
DROP TABLE IF EXISTS "HistoriaClinica_inos" CASCADE;
CREATE TABLE "HistoriaClinica_inos" (
  "id" integer DEFAULT nextval('HistoriaClinica_inos_id_seq'::regclass) NOT NULL,
  "capitulo_id" character varying(4) NOT NULL,
  "codigo" character varying(6) NOT NULL,
  "descripcion" character varying(30) NOT NULL,
  "estado" boolean NOT NULL
)
WITHOUT OIDS;

DROP SEQUENCE IF EXISTS HistoriaClinica_laboratorio_id_seq CASCADE;
CREATE SEQUENCE HistoriaClinica_laboratorio_id_seq INCREMENT BY 1
                                  NO MAXVALUE NO MINVALUE CACHE 1;
SELECT pg_catalog.setval('HistoriaClinica_laboratorio_id_seq', 1, true);

-- Table: HistoriaClinica_laboratorio
DROP TABLE IF EXISTS "HistoriaClinica_laboratorio" CASCADE;
CREATE TABLE "HistoriaClinica_laboratorio" (
  "id" integer DEFAULT nextval('HistoriaClinica_laboratorio_id_seq'::regclass) NOT NULL,
  "historia_clinica_id" integer NOT NULL,
  "prestador_id" integer NOT NULL,
  "fecha" timestamp without time zone NOT NULL,
  "analisis_id" integer NOT NULL,
  "resultados" text NOT NULL
)
WITHOUT OIDS;

DROP SEQUENCE IF EXISTS HistoriaClinica_patologicos_id_seq CASCADE;
CREATE SEQUENCE HistoriaClinica_patologicos_id_seq INCREMENT BY 1
                                  NO MAXVALUE NO MINVALUE CACHE 1;
SELECT pg_catalog.setval('HistoriaClinica_patologicos_id_seq', 4, true);

-- Table: HistoriaClinica_patologicos
DROP TABLE IF EXISTS "HistoriaClinica_patologicos" CASCADE;
CREATE TABLE "HistoriaClinica_patologicos" (
  "id" integer DEFAULT nextval('HistoriaClinica_patologicos_id_seq'::regclass) NOT NULL,
  "historia_clinica_id" integer NOT NULL,
  "fecha" timestamp without time zone NOT NULL,
  "infancia" character varying(30) NOT NULL,
  "adulto" character varying(30) NOT NULL,
  "DBT" boolean NOT NULL,
  "HTA" boolean NOT NULL,
  "TBC" boolean NOT NULL,
  "gemelar" boolean NOT NULL,
  "otras" boolean NOT NULL,
  "especificacion" character varying(30) NOT NULL,
  "quirurgicos" character varying(30) NOT NULL,
  "catarsis" character varying(30) NOT NULL,
  "traumatologicos" character varying(30) NOT NULL,
  "alergicos" text NOT NULL
)
WITHOUT OIDS;

DROP SEQUENCE IF EXISTS HistoriaClinica_perinatales_id_seq CASCADE;
CREATE SEQUENCE HistoriaClinica_perinatales_id_seq INCREMENT BY 1
                                  NO MAXVALUE NO MINVALUE CACHE 1;
SELECT pg_catalog.setval('HistoriaClinica_perinatales_id_seq', 3, true);

-- Table: HistoriaClinica_perinatales
DROP TABLE IF EXISTS "HistoriaClinica_perinatales" CASCADE;
CREATE TABLE "HistoriaClinica_perinatales" (
  "id" integer DEFAULT nextval('HistoriaClinica_perinatales_id_seq'::regclass) NOT NULL,
  "historia_clinica_id" integer NOT NULL,
  "fecha" timestamp without time zone NOT NULL,
  "embarazo_nro" integer NOT NULL,
  "duracion_embarazo" integer NOT NULL,
  "controles" boolean NOT NULL,
  "parto_normal" boolean NOT NULL,
  "peso" double precision NOT NULL,
  "talla" double precision NOT NULL,
  "patologias" boolean NOT NULL,
  "atencion_medica" boolean NOT NULL,
  "otros_datos" text NOT NULL
)
WITHOUT OIDS;

DROP SEQUENCE IF EXISTS HistoriaClinica_practicadetalle_id_seq CASCADE;
CREATE SEQUENCE HistoriaClinica_practicadetalle_id_seq INCREMENT BY 1
                                  NO MAXVALUE NO MINVALUE CACHE 1;
SELECT pg_catalog.setval('HistoriaClinica_practicadetalle_id_seq', 17, true);

-- Table: HistoriaClinica_practicadetalle
DROP TABLE IF EXISTS "HistoriaClinica_practicadetalle" CASCADE;
CREATE TABLE "HistoriaClinica_practicadetalle" (
  "id" integer DEFAULT nextval('HistoriaClinica_practicadetalle_id_seq'::regclass) NOT NULL,
  "practica_medica_id" integer NOT NULL,
  "practica_id" integer NOT NULL,
  "indicaciones" character varying(100) NOT NULL
)
WITHOUT OIDS;

DROP SEQUENCE IF EXISTS HistoriaClinica_practicamedica_id_seq CASCADE;
CREATE SEQUENCE HistoriaClinica_practicamedica_id_seq INCREMENT BY 1
                                  NO MAXVALUE NO MINVALUE CACHE 1;
SELECT pg_catalog.setval('HistoriaClinica_practicamedica_id_seq', 14, true);

-- Table: HistoriaClinica_practicamedica
DROP TABLE IF EXISTS "HistoriaClinica_practicamedica" CASCADE;
CREATE TABLE "HistoriaClinica_practicamedica" (
  "id" integer DEFAULT nextval('HistoriaClinica_practicamedica_id_seq'::regclass) NOT NULL,
  "historia_clinica_id" integer NOT NULL,
  "prestador_id" integer NOT NULL,
  "os_prescripcion_id" integer NOT NULL,
  "fecha" timestamp without time zone NOT NULL,
  "efector_id" integer,
  "estado" character varying(10) NOT NULL,
  "fecha_modificado" timestamp without time zone,
  "resultados" text,
  "observaciones" text
)
WITHOUT OIDS;

DROP SEQUENCE IF EXISTS HistoriaClinica_receta_id_seq CASCADE;
CREATE SEQUENCE HistoriaClinica_receta_id_seq INCREMENT BY 1
                                  NO MAXVALUE NO MINVALUE CACHE 1;
SELECT pg_catalog.setval('HistoriaClinica_receta_id_seq', 10, true);

-- Table: HistoriaClinica_receta
DROP TABLE IF EXISTS "HistoriaClinica_receta" CASCADE;
CREATE TABLE "HistoriaClinica_receta" (
  "id" integer DEFAULT nextval('HistoriaClinica_receta_id_seq'::regclass) NOT NULL,
  "historia_clinica_id" integer NOT NULL,
  "prestador_id" integer NOT NULL,
  "os_receta_id" integer NOT NULL,
  "fecha" timestamp without time zone NOT NULL,
  "estado" character varying(10) NOT NULL,
  "observaciones" text
)
WITHOUT OIDS;

DROP SEQUENCE IF EXISTS HistoriaClinica_recetadetalle_id_seq CASCADE;
CREATE SEQUENCE HistoriaClinica_recetadetalle_id_seq INCREMENT BY 1
                                  NO MAXVALUE NO MINVALUE CACHE 1;
SELECT pg_catalog.setval('HistoriaClinica_recetadetalle_id_seq', 12, true);

-- Table: HistoriaClinica_recetadetalle
DROP TABLE IF EXISTS "HistoriaClinica_recetadetalle" CASCADE;
CREATE TABLE "HistoriaClinica_recetadetalle" (
  "id" integer DEFAULT nextval('HistoriaClinica_recetadetalle_id_seq'::regclass) NOT NULL,
  "receta_id" integer NOT NULL,
  "medicacion_id" integer NOT NULL,
  "indicaciones" character varying(100) NOT NULL
)
WITHOUT OIDS;

DROP SEQUENCE IF EXISTS HistoriaClinica_vademecum_id_seq CASCADE;
CREATE SEQUENCE HistoriaClinica_vademecum_id_seq INCREMENT BY 1
                                  NO MAXVALUE NO MINVALUE CACHE 1;
SELECT pg_catalog.setval('HistoriaClinica_vademecum_id_seq', 13, true);

-- Table: HistoriaClinica_vademecum
DROP TABLE IF EXISTS "HistoriaClinica_vademecum" CASCADE;
CREATE TABLE "HistoriaClinica_vademecum" (
  "id" integer DEFAULT nextval('HistoriaClinica_vademecum_id_seq'::regclass) NOT NULL,
  "monodroga" character varying(30) NOT NULL,
  "nombre_comercial" character varying(30) NOT NULL,
  "presentacion" character varying(50) NOT NULL,
  "estado" boolean NOT NULL
)
WITHOUT OIDS;

DROP SEQUENCE IF EXISTS auth_group_id_seq CASCADE;
CREATE SEQUENCE auth_group_id_seq INCREMENT BY 1
                                  NO MAXVALUE NO MINVALUE CACHE 1;
SELECT pg_catalog.setval('auth_group_id_seq', 4, true);

-- Table: auth_group
DROP TABLE IF EXISTS "auth_group" CASCADE;
CREATE TABLE "auth_group" (
  "id" integer DEFAULT nextval('auth_group_id_seq'::regclass) NOT NULL,
  "name" character varying(80) NOT NULL
)
WITHOUT OIDS;

DROP SEQUENCE IF EXISTS auth_group_permissions_id_seq CASCADE;
CREATE SEQUENCE auth_group_permissions_id_seq INCREMENT BY 1
                                  NO MAXVALUE NO MINVALUE CACHE 1;
SELECT pg_catalog.setval('auth_group_permissions_id_seq', 70, true);

-- Table: auth_group_permissions
DROP TABLE IF EXISTS "auth_group_permissions" CASCADE;
CREATE TABLE "auth_group_permissions" (
  "id" integer DEFAULT nextval('auth_group_permissions_id_seq'::regclass) NOT NULL,
  "group_id" integer NOT NULL,
  "permission_id" integer NOT NULL
)
WITHOUT OIDS;

DROP SEQUENCE IF EXISTS auth_permission_id_seq CASCADE;
CREATE SEQUENCE auth_permission_id_seq INCREMENT BY 1
                                  NO MAXVALUE NO MINVALUE CACHE 1;
SELECT pg_catalog.setval('auth_permission_id_seq', 103, true);

-- Table: auth_permission
DROP TABLE IF EXISTS "auth_permission" CASCADE;
CREATE TABLE "auth_permission" (
  "id" integer DEFAULT nextval('auth_permission_id_seq'::regclass) NOT NULL,
  "name" character varying(50) NOT NULL,
  "content_type_id" integer NOT NULL,
  "codename" character varying(100) NOT NULL
)
WITHOUT OIDS;

DROP SEQUENCE IF EXISTS auth_user_id_seq CASCADE;
CREATE SEQUENCE auth_user_id_seq INCREMENT BY 1
                                  NO MAXVALUE NO MINVALUE CACHE 1;
SELECT pg_catalog.setval('auth_user_id_seq', 62, true);

-- Table: auth_user
DROP TABLE IF EXISTS "auth_user" CASCADE;
CREATE TABLE "auth_user" (
  "id" integer DEFAULT nextval('auth_user_id_seq'::regclass) NOT NULL,
  "username" character varying(30) NOT NULL,
  "first_name" character varying(30) NOT NULL,
  "last_name" character varying(30) NOT NULL,
  "email" character varying(75) NOT NULL,
  "password" character varying(128) NOT NULL,
  "is_staff" boolean NOT NULL,
  "is_active" boolean NOT NULL,
  "is_superuser" boolean NOT NULL,
  "last_login" timestamp without time zone NOT NULL,
  "date_joined" timestamp without time zone NOT NULL
)
WITHOUT OIDS;

DROP SEQUENCE IF EXISTS auth_user_groups_id_seq CASCADE;
CREATE SEQUENCE auth_user_groups_id_seq INCREMENT BY 1
                                  NO MAXVALUE NO MINVALUE CACHE 1;
SELECT pg_catalog.setval('auth_user_groups_id_seq', 162, true);

-- Table: auth_user_groups
DROP TABLE IF EXISTS "auth_user_groups" CASCADE;
CREATE TABLE "auth_user_groups" (
  "id" integer DEFAULT nextval('auth_user_groups_id_seq'::regclass) NOT NULL,
  "user_id" integer NOT NULL,
  "group_id" integer NOT NULL
)
WITHOUT OIDS;

DROP SEQUENCE IF EXISTS auth_user_user_permissions_id_seq CASCADE;
CREATE SEQUENCE auth_user_user_permissions_id_seq INCREMENT BY 1
                                  NO MAXVALUE NO MINVALUE CACHE 1;
SELECT pg_catalog.setval('auth_user_user_permissions_id_seq', 1, true);

-- Table: auth_user_user_permissions
DROP TABLE IF EXISTS "auth_user_user_permissions" CASCADE;
CREATE TABLE "auth_user_user_permissions" (
  "id" integer DEFAULT nextval('auth_user_user_permissions_id_seq'::regclass) NOT NULL,
  "user_id" integer NOT NULL,
  "permission_id" integer NOT NULL
)
WITHOUT OIDS;

DROP SEQUENCE IF EXISTS django_admin_log_id_seq CASCADE;
CREATE SEQUENCE django_admin_log_id_seq INCREMENT BY 1
                                  NO MAXVALUE NO MINVALUE CACHE 1;
SELECT pg_catalog.setval('django_admin_log_id_seq', 934, true);

-- Table: django_admin_log
DROP TABLE IF EXISTS "django_admin_log" CASCADE;
CREATE TABLE "django_admin_log" (
  "id" integer DEFAULT nextval('django_admin_log_id_seq'::regclass) NOT NULL,
  "action_time" timestamp without time zone NOT NULL,
  "user_id" integer NOT NULL,
  "content_type_id" integer,
  "object_id" text,
  "object_repr" character varying(200) NOT NULL,
  "action_flag" integer NOT NULL,
  "change_message" text NOT NULL
)
WITHOUT OIDS;

DROP SEQUENCE IF EXISTS django_content_type_id_seq CASCADE;
CREATE SEQUENCE django_content_type_id_seq INCREMENT BY 1
                                  NO MAXVALUE NO MINVALUE CACHE 1;
SELECT pg_catalog.setval('django_content_type_id_seq', 35, true);

-- Table: django_content_type
DROP TABLE IF EXISTS "django_content_type" CASCADE;
CREATE TABLE "django_content_type" (
  "id" integer DEFAULT nextval('django_content_type_id_seq'::regclass) NOT NULL,
  "name" character varying(100) NOT NULL,
  "app_label" character varying(100) NOT NULL,
  "model" character varying(100) NOT NULL
)
WITHOUT OIDS;

-- Table: django_session
DROP TABLE IF EXISTS "django_session" CASCADE;
CREATE TABLE "django_session" (
  "session_key" character varying(40) NOT NULL,
  "session_data" text NOT NULL,
  "expire_date" timestamp without time zone NOT NULL
)
WITHOUT OIDS;

DROP SEQUENCE IF EXISTS django_site_id_seq CASCADE;
CREATE SEQUENCE django_site_id_seq INCREMENT BY 1
                                  NO MAXVALUE NO MINVALUE CACHE 1;
SELECT pg_catalog.setval('django_site_id_seq', 2, true);

-- Table: django_site
DROP TABLE IF EXISTS "django_site" CASCADE;
CREATE TABLE "django_site" (
  "id" integer DEFAULT nextval('django_site_id_seq'::regclass) NOT NULL,
  "domain" character varying(100) NOT NULL,
  "name" character varying(50) NOT NULL
)
WITHOUT OIDS;

-- Table: home_medico
DROP TABLE IF EXISTS "home_medico" CASCADE;
CREATE TABLE "home_medico" (
  "user_id" integer NOT NULL,
  "matricula" character varying(20) NOT NULL,
  "cuit" character varying(20) NOT NULL,
  "estado" boolean NOT NULL
)
WITHOUT OIDS;

-- Table: home_perfilusuario
DROP TABLE IF EXISTS "home_perfilusuario" CASCADE;
CREATE TABLE "home_perfilusuario" (
  "user_id" integer NOT NULL,
  "dni" character varying(20) NOT NULL,
  "tipo" character varying(5),
  "sexo" character varying(1),
  "photo" character varying(100),
  "telefono" character varying(30),
  "direccion" character varying(60),
  "fecha_nacimiento" date
)
WITHOUT OIDS;

DROP SEQUENCE IF EXISTS turnos_afiliadosos_id_seq CASCADE;
CREATE SEQUENCE turnos_afiliadosos_id_seq INCREMENT BY 1
                                  NO MAXVALUE NO MINVALUE CACHE 1;
SELECT pg_catalog.setval('turnos_afiliadosos_id_seq', 114, true);

-- Table: turnos_afiliadosos
DROP TABLE IF EXISTS "turnos_afiliadosos" CASCADE;
CREATE TABLE "turnos_afiliadosos" (
  "id" integer DEFAULT nextval('turnos_afiliadosos_id_seq'::regclass) NOT NULL,
  "afiliado_id" integer NOT NULL,
  "obrasocial_id" character varying(20) NOT NULL,
  "beneficiario" character varying(20) NOT NULL,
  "titular" character varying(20) NOT NULL,
  "estado" boolean NOT NULL
)
WITHOUT OIDS;

DROP SEQUENCE IF EXISTS turnos_agenda_id_seq CASCADE;
CREATE SEQUENCE turnos_agenda_id_seq INCREMENT BY 1
                                  NO MAXVALUE NO MINVALUE CACHE 1;
SELECT pg_catalog.setval('turnos_agenda_id_seq', 78, true);

-- Table: turnos_agenda
DROP TABLE IF EXISTS "turnos_agenda" CASCADE;
CREATE TABLE "turnos_agenda" (
  "id" integer DEFAULT nextval('turnos_agenda_id_seq'::regclass) NOT NULL,
  "prestador_id" integer NOT NULL,
  "dia" integer NOT NULL,
  "dia_nombre" character varying(10) NOT NULL,
  "hora_inicial" time without time zone NOT NULL,
  "hora_final" time without time zone NOT NULL,
  "duracion" integer NOT NULL,
  "cant_turnos" integer,
  "estado" boolean NOT NULL
)
WITHOUT OIDS;

DROP SEQUENCE IF EXISTS turnos_diaatencion_id_seq CASCADE;
CREATE SEQUENCE turnos_diaatencion_id_seq INCREMENT BY 1
                                  NO MAXVALUE NO MINVALUE CACHE 1;
SELECT pg_catalog.setval('turnos_diaatencion_id_seq', 174, true);

-- Table: turnos_diaatencion
DROP TABLE IF EXISTS "turnos_diaatencion" CASCADE;
CREATE TABLE "turnos_diaatencion" (
  "id" integer DEFAULT nextval('turnos_diaatencion_id_seq'::regclass) NOT NULL,
  "prestador_id" integer NOT NULL,
  "fecha" date NOT NULL,
  "hora_inicial" time without time zone NOT NULL,
  "observacion" character varying(30) NOT NULL
)
WITHOUT OIDS;

DROP SEQUENCE IF EXISTS turnos_especialidad_id_seq CASCADE;
CREATE SEQUENCE turnos_especialidad_id_seq INCREMENT BY 1
                                  NO MAXVALUE NO MINVALUE CACHE 1;
SELECT pg_catalog.setval('turnos_especialidad_id_seq', 18, true);

-- Table: turnos_especialidad
DROP TABLE IF EXISTS "turnos_especialidad" CASCADE;
CREATE TABLE "turnos_especialidad" (
  "id" integer DEFAULT nextval('turnos_especialidad_id_seq'::regclass) NOT NULL,
  "nombre" character varying(30) NOT NULL,
  "estado" boolean NOT NULL
)
WITHOUT OIDS;

DROP SEQUENCE IF EXISTS turnos_especialidadesmedicos_id_seq CASCADE;
CREATE SEQUENCE turnos_especialidadesmedicos_id_seq INCREMENT BY 1
                                  NO MAXVALUE NO MINVALUE CACHE 1;
SELECT pg_catalog.setval('turnos_especialidadesmedicos_id_seq', 38, true);

-- Table: turnos_especialidadesmedicos
DROP TABLE IF EXISTS "turnos_especialidadesmedicos" CASCADE;
CREATE TABLE "turnos_especialidadesmedicos" (
  "id" integer DEFAULT nextval('turnos_especialidadesmedicos_id_seq'::regclass) NOT NULL,
  "medico_id" character varying(20) NOT NULL,
  "especialidad_id" integer NOT NULL,
  "fecha_habilitacion" date NOT NULL,
  "fecha_caducacion" date,
  "estado" boolean NOT NULL
)
WITHOUT OIDS;

-- Table: turnos_obrasocial
DROP TABLE IF EXISTS "turnos_obrasocial" CASCADE;
CREATE TABLE "turnos_obrasocial" (
  "cuit" character varying(20) NOT NULL,
  "nombre" character varying(30) NOT NULL,
  "domicilio" character varying(60) NOT NULL,
  "telefono" character varying(30) NOT NULL,
  "estado" boolean NOT NULL
)
WITHOUT OIDS;

DROP SEQUENCE IF EXISTS turnos_turno_id_seq CASCADE;
CREATE SEQUENCE turnos_turno_id_seq INCREMENT BY 1
                                  NO MAXVALUE NO MINVALUE CACHE 1;
SELECT pg_catalog.setval('turnos_turno_id_seq', 1561, true);

-- Table: turnos_turno
DROP TABLE IF EXISTS "turnos_turno" CASCADE;
CREATE TABLE "turnos_turno" (
  "id" integer DEFAULT nextval('turnos_turno_id_seq'::regclass) NOT NULL,
  "paciente_id" integer,
  "dia_atencion_id" integer NOT NULL,
  "hora_turno" time without time zone NOT NULL,
  "fecha_creacion" date,
  "observacion" text NOT NULL,
  "sede" character varying(30)
)
WITHOUT OIDS;

--
-- Data for Name: HistoriaClinica_capitulosinos; Type: TABLE DATA;
--

COPY "HistoriaClinica_capitulosinos" ("tipo", "nro_capitulo", "nombre_capitulo") FROM stdin;
ANC	-	-
ESP	14	Alergias
ESP	15	Anatomia patologica
ESP	16	 Anestesiologia
ESP	17	Cardiologia
ESP	18	Ecografia
\.


--
-- Data for Name: HistoriaClinica_cie10; Type: TABLE DATA;
--

COPY "HistoriaClinica_cie10" ("codigo", "descripcion", "estado") FROM stdin;
0000	En Estudio	t
A001	Colera	t
A002	Alergia	t
A010	Fiebre Tifoidea	t
A051	Botulismo	t
A073	Isosporiasis	t
A170	Meningitis Tuberculo	t
A200	Peste Bubonica	t
B03	Viruela	t
B05	Sarampion	t
B06	Rubeola	t
B15	Hepatitis Aguda A	t
B26	Paratoditis Inf	t
C43	Melanoma Maligno	t
D50	Anemias	t
F502	Bulimia Nerviosa	t
\.


--
-- Data for Name: HistoriaClinica_consultamedica; Type: TABLE DATA;
--

COPY "HistoriaClinica_consultamedica" ("id", "historia_clinica_id", "prestador_id", "os_consulta_id", "fecha", "motivos_consulta", "sintomas", "terapeutica", "observaciones", "estado") FROM stdin;
1	11	34	98	2014-12-02T14:40:23	fasdf	fsdafs	fdsaf	fafd	f
2	11	34	98	2014-12-02T14:51:13	fsda	fasdf	fdsaf	fsdafsd	f
3	7	20	99	2014-12-05T02:37:08	fsda	fdasf	fdas	fds	t
4	7	20	99	2014-12-05T02:37:52	hhh	jj	jj	jjj	t
5	11	20	98	2014-12-05T02:38:37	gwgw	gwgw	gwg	gwgw	t
6	11	20	98	2014-12-05T02:38:51	gwg	gwgw	gwg	gwg	t
7	7	20	99	2014-12-05T02:54:26	fdsaf	fdasf	f	fdas	t
8	7	20	99	2014-12-05T02:54:41	fsdf	fasdf	fdsa	fasd	t
9	4	34	100	2014-12-05T03:28:19	fasdf	fasdf	ffasdf	dfasfd	t
10	3	20	102	2014-12-05T03:29:04	sdfa	fasdf	fdsaf	fsdaf	t
11	1	20	94	2014-12-05T03:31:56	fsda	fasfasd	fsdaf	fdas	t
12	11	20	98	2014-12-05T03:44:51	dolor en el pecho,	 fatiga, cansancio	-	-	t
13	3	37	102	2014-12-08T15:48:43	fdasf	fsdaf	fasdf	fasdf	t
\.


--
-- Data for Name: HistoriaClinica_consultamedica_diagnosticos; Type: TABLE DATA;
--

COPY "HistoriaClinica_consultamedica_diagnosticos" ("id", "consultamedica_id", "cie10_id") FROM stdin;
1	1	B26
2	2	B06
3	3	B05
4	4	B05
5	5	B05
6	6	A002
10	7	A001
9	7	A002
7	7	B03
8	7	B05
11	8	B03
12	8	B05
13	8	B06
14	9	B03
16	10	A001
15	10	B26
17	11	A002
18	12	0000
19	13	A002
\.


--
-- Data for Name: HistoriaClinica_examenfisico; Type: TABLE DATA;
--

COPY "HistoriaClinica_examenfisico" ("id", "historia_clinica_id", "fecha_examen", "impresion_general", "pres_art_sist", "pres_art_diast", "frec_respiratoria", "temp_corporal", "pulso", "peso_medio", "altura_media", "peso", "altura", "talla", "bmi") FROM stdin;
1	1	2014-02-18T17:51:14	Buena	10	88	8	9.0	9	8.0	98.0	9.0	8.0	98	9.0
2	7	2014-08-25T00:08:11	fsdfasdf	64798	798	98	798.0	78	45.0	45.0	45.0	45.0	45	45.0
4	2	2014-08-25T03:18:17	fdsf	8	8	9	8.0	9	8.0	9.0	8.0	7.0	4	5.0
5	11	2014-12-01T03:48:22	normal	13	16	80	36.0	120	54.0	1.6	55.0	1.6	2	24.0
\.


--
-- Data for Name: HistoriaClinica_fisiologicos; Type: TABLE DATA;
--

COPY "HistoriaClinica_fisiologicos" ("id", "historia_clinica_id", "fecha", "alimentacion", "dipsia", "diuresis", "catarsis", "sommia", "observaciones") FROM stdin;
1	1	2014-02-18T17:49:41	normal	-	-	-	si	-
2	2	2014-03-04T03:16:18	kjkljk	kj	lk	ljk	ll	jkl
4	4	2014-07-05T02:41:21	fd asfasdf dafd fasfds fasdfds	fd safsdfdsfs	fsd fsdfasd f	sda fasdf	fasd fsdaf	fsd fasdfa\r\nd safasdf\r\ndf\r\n
5	3	2014-08-25T00:39:37	fdsa	sda	fasd	asdf	sda	fasd
6	10	2014-11-12T02:30:49	fwqefq	FDSAFQsafsd	FSDAFQ	sdaf	fdsafsdff	fsadfsd
\.


--
-- Data for Name: HistoriaClinica_habitostoxicos; Type: TABLE DATA;
--

COPY "HistoriaClinica_habitostoxicos" ("id", "historia_clinica_id", "fecha", "alcohol", "tabaco", "drogas", "infuciones", "observaciones") FROM stdin;
1	1	2014-02-18T17:50:29	t	f	f	t	fdsafasd
2	7	2014-03-06T02:41:04	t	f	f	t	tomo mucho vino
3	4	2014-08-21T05:24:13	t	f	f	t	-
5	3	2014-08-25T00:39:15	f	f	f	f	fsdaf
6	2	2014-08-25T03:17:51	t	t	f	f	fdsaf
\.


--
-- Data for Name: HistoriaClinica_historiaclinica; Type: TABLE DATA;
--

COPY "HistoriaClinica_historiaclinica" ("id", "paciente_id", "prestador_id", "fecha_creacion", "lugar_nacimiento", "grupo_sanguineo", "estado_civil", "ocupacion", "religion", "padre", "madre", "motivo_consulta", "antecedentes_enfermedad_actual") FROM stdin;
1	18	20	2014-02-18	Salta	O-	S	Profesor Universitario	Catolica	Juan Avila	soledad vargas	control programado	
2	17	28	2014-02-18	Rosario	O-	S	fdsa	fdsaf	fdsaf	fdsaf	fdsa	fdsa
3	28	20	2014-02-25	Tucuman	O+	S	fsaf	lkjkl	jklj	lj	jkj	lk
4	26	25	2014-02-26	lkjl 	O+	S	dssa	jkjk	hhkj	hj	hj	hjk
5	27	28	2014-03-03	USA	O+	C	fsafdsfs	jkl	jlk	kjlk	jkljlkkjl	jkljl
7	19	20	2014-03-05	Tucuman	A-	D	Estudiante	-	-	-	Dolor  en el pecho	-
8	30	34	2014-08-17	fsadf	O+	S	fsda	sad	fasd	fsda	fsdaf	fasdf
9	44	34	2014-08-17	fsd	O+	C	fsdaf	fdsaf	fasd	sadfd	fsdaf	fsadf
10	57	34	2014-11-11	Salta	A+	D	dfsafd	fdsaaqe	qqwwe	erwq	fqe qrer qwdsafasd	fasfdsfsdafsdaf
11	20	20	2014-11-12	Salta	O-	S	Estudiante	Catolica	Sergio Santillan	maria molina	dolor en el pecho	
\.


--
-- Data for Name: HistoriaClinica_inos; Type: TABLE DATA;
--

COPY "HistoriaClinica_inos" ("id", "capitulo_id", "codigo", "descripcion", "estado") FROM stdin;
11	14	01.01	Testificacion total. 	t
12	14	01.02	Testificacion parcial	t
13	15	01.01	Biopsia por incision 	t
14	15	01.02	Vesicula simple	t
15	-	001	Acetaldehido enzimatico.	t
16	-	002	Acetonuria. 	t
17	-	008	Adenograma. 	t
18	-	412	Glucemia. 	t
19	16	01.01	Anestesia mÍnima para proc	t
20	16	01.02 	Analgesia regional continua. 	t
21	17	01.01	Electrocardiograma en Constult	t
22	17	01.07	Vectocardiograma. 	t
23	18	01.01	Ecocardiograma	t
24	18	01.10	Ecografia tiroidea	t
25	18	01.12 	Ecografia completa de abdomen	t
26	-	017 	Alcoholemia. 	t
27	-	133 	 Calcemia total. 	t
\.


--
-- Data for Name: HistoriaClinica_laboratorio; Type: TABLE DATA;
--

COPY "HistoriaClinica_laboratorio" ("id", "historia_clinica_id", "prestador_id", "fecha", "analisis_id", "resultados") FROM stdin;
\.


--
-- Data for Name: HistoriaClinica_patologicos; Type: TABLE DATA;
--

COPY "HistoriaClinica_patologicos" ("id", "historia_clinica_id", "fecha", "infancia", "adulto", "DBT", "HTA", "TBC", "gemelar", "otras", "especificacion", "quirurgicos", "catarsis", "traumatologicos", "alergicos") FROM stdin;
1	1	2014-02-24T17:51:08	-	-	f	t	f	f	f	-	no tiene	normal	-	-
2	2	2014-03-06T03:19:54	mala	peor	t	f	t	f	t	fdsafd	fsafsa	fsdafdsaf	fdafads	fsafsdadfas
3	3	2014-08-25T00:39:28	fsdaf	fasdf	f	f	t	f	f	fdsa	fsda	asdf	fasd	fsad
\.


--
-- Data for Name: HistoriaClinica_perinatales; Type: TABLE DATA;
--

COPY "HistoriaClinica_perinatales" ("id", "historia_clinica_id", "fecha", "embarazo_nro", "duracion_embarazo", "controles", "parto_normal", "peso", "talla", "patologias", "atencion_medica", "otros_datos") FROM stdin;
1	1	2014-02-18T19:55:58	9	9	t	t	8.0	8.0	f	t	8
2	3	2014-08-25T00:39:06	1	12	t	t	56.0	5.0	f	f	ffdsaf
\.


--
-- Data for Name: HistoriaClinica_practicadetalle; Type: TABLE DATA;
--

COPY "HistoriaClinica_practicadetalle" ("id", "practica_medica_id", "practica_id", "indicaciones") FROM stdin;
1	1	18	12
2	1	25	1
3	2	16	fsdaffdsf
4	3	15	dsafsd
5	4	18	fdfdsaf
6	5	15	1
7	5	18	2
8	6	25	fasdf
9	7	24	fsdaf
10	8	18	Completo
11	8	27	-
12	9	18	.
13	10	25	.
14	11	18	fdsaf
15	12	24	fds
16	13	14	faf
\.


--
-- Data for Name: HistoriaClinica_practicamedica; Type: TABLE DATA;
--

COPY "HistoriaClinica_practicamedica" ("id", "historia_clinica_id", "prestador_id", "os_prescripcion_id", "fecha", "efector_id", "estado", "fecha_modificado", "resultados", "observaciones") FROM stdin;
1	1	20	94	2014-11-10T15:11:10	20	Finalizado	2014-11-10T15:11:42	fdsafsa	fsdafd
2	1	34	95	2014-11-11T16:03:40	34	Finalizado	2014-11-11T16:03:54	fsdafasdf	fdas
3	1	34	94	2014-11-12T00:17:17	20	Finalizado	2014-11-12T01:12:21	fdafdsf fdsafdsf dfsdafsda	fds fsdfsfsdfsafsda fas
4	11	34	98	2014-11-28T17:32:51	\N	Anulado	\N		
5	11	20	98	2014-11-29T22:22:02	\N	Pendiente	\N	dsa	asdfa
6	11	34	98	2014-12-02T00:49:44	\N	Anulado	\N	fsdaf	fdsaf
7	11	34	98	2014-12-02T00:49:53	\N	Anulado	\N	fdsaf	fasdf
8	11	20	98	2014-12-02T01:02:32	20	Realizado	2014-12-02T01:08:36	Glucosa       88 mg/dl\r\nCalcio          172 mg/dl	
9	7	20	99	2014-12-05T02:37:21	\N	Pendiente	\N		
10	7	20	99	2014-12-05T02:37:39	\N	Pendiente	\N		
11	3	37	113	2014-12-08T15:49:03	37	Finalizado	2014-12-08T15:49:12	dfsaf	fasdf
12	11	37	98	2014-12-08T15:50:29	\N	Pendiente	\N		
13	3	37	113	2014-12-08T15:56:02	\N	Pendiente	\N		
\.


--
-- Data for Name: HistoriaClinica_receta; Type: TABLE DATA;
--

COPY "HistoriaClinica_receta" ("id", "historia_clinica_id", "prestador_id", "os_receta_id", "fecha", "estado", "observaciones") FROM stdin;
1	1	34	94	2014-09-06T18:51:35	Activo	fasdf
2	1	34	94	2014-09-06T18:54:18	Activo	DAS
3	1	36	110	2014-09-06T19:02:36	Anulado	
4	1	34	94	2014-11-11T16:04:40	Anulado	
5	1	20	94	2014-11-12T01:11:36	Activo	
6	1	20	94	2014-11-12T01:11:36	Activo	
7	11	20	98	2014-12-01T01:46:34	Activo	gg
8	11	20	98	2014-12-01T01:46:51	Anulado	gg
9	11	20	98	2014-12-02T02:39:18	Activo	
\.


--
-- Data for Name: HistoriaClinica_recetadetalle; Type: TABLE DATA;
--

COPY "HistoriaClinica_recetadetalle" ("id", "receta_id", "medicacion_id", "indicaciones") FROM stdin;
1	1	8	fdasf
2	1	2	fasdf
3	2	4	dsaDS
4	3	8	c/ 6hrs
5	3	1	cada 8 horas
6	4	1	cada 6 hrs
7	5	12	cada 6 hrs
8	6	12	cada 6 hrs
9	7	3	tyt
10	8	3	tyt
11	9	4	cada 6 hrs
\.


--
-- Data for Name: HistoriaClinica_vademecum; Type: TABLE DATA;
--

COPY "HistoriaClinica_vademecum" ("id", "monodroga", "nombre_comercial", "presentacion", "estado") FROM stdin;
1	AMOXICILINA	ABIOTYL	250 MG SUSP.X 120 ML	t
2	AMOXICILINA	AMOXIBIOT FORTE	 \tJBE.X 100 ML	t
3	AMOXICILINA	AMOXICILINA DUO	SUSP.X 60 ML	t
4	AMOXICILINA	AMOXICILINA PHARMA	 \t500 MG COMP.X 10	t
5	DICLOFENAC	DIFENAC	 \t1% SOL.OFT.X 10 ML	t
6	DICLOFENAC DIETILAMINA	DICLOFENAC DENVER FARMA	 \tGEL X 50 G	t
7	DICLOFENAC PARACETAMOL	TAFIROL ARTRO	50/500 MG COMP.REC.X 20	f
8	PARACETAMOL	TAFIROL 1 G	COMP.RAN.X 100	t
9	HIDROCORTISONA	HIDROCORTISONA	500 MG F.A.X 1	t
10	HIDROCORTISONA	HIDROTISONA	10 MG COMP.X 30	t
11	HIDROCORTISONA	ORALSONE	COMP.X 12	f
12	DEXAMETASON	DECADRON	0.5 MG COMP.X 20	t
\.


--
-- Data for Name: auth_group; Type: TABLE DATA;
--

COPY "auth_group" ("id", "name") FROM stdin;
1	Administradores
3	Medicos
2	Pacientes
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA;
--

COPY "auth_group_permissions" ("id", "group_id", "permission_id") FROM stdin;
1	1	1
2	1	2
3	1	3
4	1	4
5	1	5
6	1	6
7	1	7
8	1	8
9	1	9
10	1	10
11	1	11
12	1	12
13	1	13
14	1	14
15	1	15
16	1	16
17	1	17
18	1	18
19	1	19
20	1	20
21	1	21
22	1	22
23	1	23
24	1	24
25	1	25
26	1	26
27	1	27
28	1	28
29	1	29
30	1	30
31	1	31
32	1	32
33	1	33
34	1	34
35	1	35
36	1	36
37	1	37
38	1	38
39	1	39
40	1	40
41	1	41
42	1	42
43	1	43
44	1	44
45	1	45
46	1	46
47	1	47
48	1	48
66	3	28
67	3	29
68	3	30
69	3	31
49	3	32
50	3	33
51	3	34
52	3	35
53	3	36
54	3	37
55	3	38
56	3	39
57	3	40
58	3	41
59	3	42
60	3	43
61	3	44
62	3	45
63	3	46
64	3	47
65	3	48
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA;
--

COPY "auth_permission" ("id", "name", "content_type_id", "codename") FROM stdin;
1	Can add permission	1	add_permission
2	Can change permission	1	change_permission
3	Can delete permission	1	delete_permission
4	Can add group	2	add_group
5	Can change group	2	change_group
6	Can delete group	2	delete_group
7	Can add user	3	add_user
8	Can change user	3	change_user
9	Can delete user	3	delete_user
10	Can add content type	4	add_contenttype
11	Can change content type	4	change_contenttype
12	Can delete content type	4	delete_contenttype
13	Can add session	5	add_session
14	Can change session	5	change_session
15	Can delete session	5	delete_session
16	Can add site	6	add_site
17	Can change site	6	change_site
18	Can delete site	6	delete_site
19	Can add log entry	7	add_logentry
20	Can change log entry	7	change_logentry
21	Can delete log entry	7	delete_logentry
22	Can add perfil usuario	8	add_perfilusuario
23	Can change perfil usuario	8	change_perfilusuario
24	Can delete perfil usuario	8	delete_perfilusuario
25	Can add medico	9	add_medico
26	Can change medico	9	change_medico
27	Can delete medico	9	delete_medico
28	Can add obra social	10	add_obrasocial
29	Can change obra social	10	change_obrasocial
30	Can delete obra social	10	delete_obrasocial
31	Can add afiliados os	11	add_afiliadosos
32	Can change afiliados os	11	change_afiliadosos
33	Can delete afiliados os	11	delete_afiliadosos
34	Can add especialidad	12	add_especialidad
35	Can change especialidad	12	change_especialidad
36	Can delete especialidad	12	delete_especialidad
37	Can add especialidades medicos	13	add_especialidadesmedicos
38	Can change especialidades medicos	13	change_especialidadesmedicos
39	Can delete especialidades medicos	13	delete_especialidadesmedicos
40	Can add agenda	14	add_agenda
41	Can change agenda	14	change_agenda
42	Can delete agenda	14	delete_agenda
43	Can add dia atencion	15	add_diaatencion
44	Can change dia atencion	15	change_diaatencion
45	Can delete dia atencion	15	delete_diaatencion
46	Can add turno	16	add_turno
47	Can change turno	16	change_turno
48	Can delete turno	16	delete_turno
49	Can add historia clinica	17	add_historiaclinica
50	Can change historia clinica	17	change_historiaclinica
51	Can delete historia clinica	17	delete_historiaclinica
52	Can add consulta medica	18	add_consultamedica
53	Can change consulta medica	18	change_consultamedica
54	Can delete consulta medica	18	delete_consultamedica
55	Can add habitos toxicos	19	add_habitostoxicos
56	Can change habitos toxicos	19	change_habitostoxicos
57	Can delete habitos toxicos	19	delete_habitostoxicos
58	Can add examen fisico	20	add_examenfisico
59	Can change examen fisico	20	change_examenfisico
60	Can delete examen fisico	20	delete_examenfisico
61	Can add fisiologicos	21	add_fisiologicos
62	Can change fisiologicos	21	change_fisiologicos
63	Can delete fisiologicos	21	delete_fisiologicos
64	Can add patologicos	22	add_patologicos
65	Can change patologicos	22	change_patologicos
66	Can delete patologicos	22	delete_patologicos
70	Can add perinatales	24	add_perinatales
71	Can change perinatales	24	change_perinatales
72	Can delete perinatales	24	delete_perinatales
76	Can add cie10	26	add_cie10
77	Can change cie10	26	change_cie10
78	Can delete cie10	26	delete_cie10
79	Can add laboratorio	27	add_laboratorio
80	Can change laboratorio	27	change_laboratorio
81	Can delete laboratorio	27	delete_laboratorio
82	Can add practica medica	28	add_practicamedica
83	Can change practica medica	28	change_practicamedica
84	Can delete practica medica	28	delete_practicamedica
85	Can add capitulos inos	29	add_capitulosinos
86	Can change capitulos inos	29	change_capitulosinos
87	Can delete capitulos inos	29	delete_capitulosinos
88	Can add inos	30	add_inos
89	Can change inos	30	change_inos
90	Can delete inos	30	delete_inos
91	Can add practica detalle	31	add_practicadetalle
92	Can change practica detalle	31	change_practicadetalle
93	Can delete practica detalle	31	delete_practicadetalle
94	Can add vademecum	32	add_vademecum
95	Can change vademecum	32	change_vademecum
96	Can delete vademecum	32	delete_vademecum
97	Can add receta	33	add_receta
98	Can change receta	33	change_receta
99	Can delete receta	33	delete_receta
100	Can add receta detalle	34	add_recetadetalle
101	Can change receta detalle	34	change_recetadetalle
102	Can delete receta detalle	34	delete_recetadetalle
\.


--
-- Data for Name: auth_user; Type: TABLE DATA;
--

COPY "auth_user" ("id", "username", "first_name", "last_name", "email", "password", "is_staff", "is_active", "is_superuser", "last_login", "date_joined") FROM stdin;
7	root	Admin	django	admin@gmail.com	pbkdf2_sha256$10000$j9wpPogDCIGi$qX3tQoZ/CMO2dyZ6XGApt9eIBj3cFj5vsd1dDLUSKiU=	t	t	t	2016-04-03T22:30:42	2014-09-07T06:35:04
17	fabio	Fabio G	Rodriguez	fabio.ger@gmail.com	pbkdf2_sha256$10000$Es8rWMfzRswq$d5ClhnxOq7yLTZF7NoCl7l3/hf9puTLMKXHV3qJp6Fc=	f	t	f	2015-06-10T00:17:03	2014-02-16T18:26:05
18	pepe	Jose	Avila	pepe@hotmail.com	pbkdf2_sha256$10000$xY16NZv6ia2i$fu8WV0KxJ0TpmvfdsRnn62Ybojxa9h4abDeSvG7wEzg=	f	t	f	2015-06-10T00:15:42	2014-02-16T18:39:08
19	abigail	Abigail	Perez	abi@gmail.com	pbkdf2_sha256$10000$p4gt6ApMMlNs$rBri3HyN+ctRaxT7HXC6xJaE/aoVSKhfHmZxPyBDxsw=	f	t	f	2014-11-18T12:40:57	2014-01-17T02:50:37
20	barby	Barbara	Santillan	barby@gmail.com	pbkdf2_sha256$10000$iCHfy80oGpBQ$Yq/A9O2juWeDeaXFX6dqXBsRg8OttRkVDJXTxHg8dbs=	f	t	f	2014-11-12T02:33:35	2014-02-20T02:20:41
26	jose	Jose	Lopez	jose@hotmail.com	pbkdf2_sha256$10000$1NlmIAGe1xCm$P0r4WCpbTiOBGMjAu2mxGSZKoA5TWE5iCsrxmGI0EIY=	f	t	f	2015-06-10T00:16:38	2014-02-24T01:10:47
27	jobs	Steve	Jobs	jobs@gmail.com	pbkdf2_sha256$10000$b3uCFNDcBrHC$oqAAvv+NRYkb5tV1622LWtT60J6wBqShfsUfp7kZTLA=	f	t	f	2014-02-24T02:40:15	2014-03-24T02:40:15
28	carlita	Carla	Chocobar	carlita@gmail.com	pbkdf2_sha256$10000$TvCAbHurD2Mi$OSskewQVja+qH/Y5csTRRxc7iQzF7ZaXtnaRkIwAzI8=	f	t	f	2015-06-10T00:15:12	2014-02-25T14:41:15
29	paciente1	Paciente	uno	paciente1@gmail.com	pbkdf2_sha256$10000$9Q5U6nAmCVc0$D9mCqbHh5TXd7nHxqqFBLx/fT6EcSPXesQwZlayG+5k=	f	t	f	2015-06-10T00:14:08	2014-04-19T19:24:47
30	paciente2	Pablo	Pino	paciente2@gmail.com	pbkdf2_sha256$10000$aaZVh6On1YGR$K02mpVVPxXFViV8E+vnm4EE3n7PrNrJRaxk4i9iDGEE=	f	t	f	2015-06-10T00:14:44	2014-04-19T19:27:48
31	paciente3	Paciente	3	paciente3@gmail.com	pbkdf2_sha256$10000$OSofqFFgtGFa$a1pKcp3yLOE8Kft6zc43ebFEuW2cOuMclR6b/s0yhgY=	f	t	f	2014-04-19T19:31:19	2014-04-19T19:31:19
44	euge	Eugenia	Perez	euge@gmail.com	pbkdf2_sha256$10000$ZK9pJUFgkkZq$kAe5dZpWL/gnq2L78/un7u1n9c0B9VDftA3ueTb5LRw=	f	t	f	2014-04-19T20:25:41	2014-04-19T20:25:35
45	pacientex	Paciente	x	pacx@gmail.com	pbkdf2_sha256$10000$o3qb3TGThyr2$NvuKTLWms/y0KQB+cK8bbfKTFjRutTrtr5JNsN+HrMU=	f	t	f	2014-08-24T21:09:05	2014-08-24T21:09:05
46	mochon	Mo	Mochon	m@gmail.com	pbkdf2_sha256$10000$AzTYURxa64HK$nkTxE2IqOkF+P3Ooy0ZtAEgRxlHe+nVZQR3CYss5MK8=	f	t	f	2014-08-26T05:19:49	2014-08-26T05:19:49
47	becker	b	Becker	b@gmail.com	pbkdf2_sha256$10000$5SNVET8XBI2Y$r0oG+zYmbHGbxj6s5grnaECxJnRY+IcCxh36hgzd2PQ=	f	t	f	2014-08-26T05:20:47	2014-08-26T05:20:47
48	paciente4	Paciente 4	ap	p4@gmail.com	pbkdf2_sha256$10000$OT9choDxbyEI$7iNLl65x4Z+itzrIMrNC4RasDULo8JgOk8DiFegFH2c=	f	t	f	2014-08-26T14:26:30	2014-08-26T14:26:30
49	XY	x	y	xy@gmail.com	pbkdf2_sha256$10000$OgdShOIITajc$StiEvV3RnJuavohHItVcAulN5+25d6Bb78NxL35F77A=	f	t	f	2014-08-26T15:05:25	2014-08-26T15:05:25
50	paciente5	Paciente5	P5	p5@gmail.com	pbkdf2_sha256$10000$XVFtnAxiPfU9$yID/3niDhCWkmHF/JmRqXQeHmBNWTvDS1G0T4wHBMNE=	f	t	f	2014-09-04T02:42:54	2014-09-04T02:42:40
51	paciente6	Paciente 6	P6	p6@gmail.com	pbkdf2_sha256$10000$jxDGeFXpjNlE$SW8aBcAdsugocriBrgofO+fd5g5tqwsPuDrqXI0SG1Q=	f	t	f	2014-09-04T02:46:13	2014-09-04T02:46:06
52	paciente7	paciente	7	p7@gmail.com	pbkdf2_sha256$10000$O6KPUODF6BVm$VUZVdXdtmR6i8m1pmjhO1x2RGqsb2mycaNVMsYfjTvg=	f	t	f	2014-09-04T02:47:04	2014-09-04T02:47:04
53	paciente8	Paciente	8	p8@gmail.com	pbkdf2_sha256$10000$6MZqqxpnMjpI$bpQtWsXaP+z0YdGF3FyLEoIvI+F/0Tf7jEXSKDdZdx4=	f	t	f	2014-09-04T02:50:19	2014-09-04T02:50:19
54	paciente9	Paciente	9	p9@gmail.com	pbkdf2_sha256$10000$rA6YLV3kzOgh$sW9asMhLha77QMU5r3K94eCGbnOvyL5KCJRYBNS7wxo=	f	t	f	2014-09-04T02:54:21	2014-09-04T02:54:21
55	paciente10	paciente	10	p10@gmaikl.com	pbkdf2_sha256$10000$lLJJ1COcLnhd$smwtBWQ7hL096WfTmw8CiIMBk+JWVAbLWwUE0Y7xgfA=	f	t	f	2014-09-04T02:58:07	2014-09-04T02:58:07
56	juan	Juan	Perez	juanp@hotmail.com	pbkdf2_sha256$10000$BKZ820h4Sh0T$DzF/m3FFgKkX4Oqk6ZIwDoye29V/VAZi4yKOw0QRzis=	f	t	f	2014-09-23T17:58:12	2014-09-23T17:58:12
57	Esteban	Esteba	Ayb	estbar@gmail.com	pbkdf2_sha256$10000$uUvaQsbEoBiN$kXEi3VbJVPE4pFc0kkGDpV20M0zyI55ivaWfxXukzTU=	f	t	f	2014-11-12T02:56:43	2014-11-12T01:35:47
58	Carlitos	Carlos	Cres	Carlitos@hotmail.com	pbkdf2_sha256$10000$QbmqwEmNh9d0$r38iiR5k4gRMiHqbCwoSDxRkb6zFpiVYMSmovPCEtSo=	f	t	f	2014-11-12T02:57:21	2014-11-12T01:36:47
59	seba	Seba	Guanca	seba@gmail.com	pbkdf2_sha256$10000$z9QaeRLnn8XZ$9OwJ8PzpIjdmuTJQ0962NuyBl5KMT2mxHFSeO2HtuMU=	f	t	f	2014-11-12T03:00:20	2014-11-12T03:00:12
60	martin	Martin	Salas	martin@gmail.com	pbkdf2_sha256$10000$G6QM6X8Y1uyQ$HoVAb/SSSlTys/HCOOpXAVCVTMEQAgPEAynRcEkq8j0=	f	t	f	2014-12-05T03:06:19	2014-12-05T03:06:19
61	gustavo	Gustavo	Avalos	g@salta.com	pbkdf2_sha256$10000$VPEceTPDIFIt$TuqBi0WPFb6kctMGV09YEC3EY7c9MF+VaR4i+Twl9Nc=	f	t	f	2014-12-05T03:08:23	2014-12-05T03:08:23
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA;
--

COPY "auth_user_groups" ("id", "user_id", "group_id") FROM stdin;
143	7	1
144	7	3
156	17	2
157	17	3
151	18	2
152	18	3
124	19	2
72	20	2
111	26	2
113	26	3
125	27	2
78	28	2
81	28	3
82	29	2
84	30	2
130	31	2
142	44	2
131	45	2
132	45	3
117	46	2
119	47	2
121	48	2
123	49	2
126	50	2
127	51	2
129	52	2
135	53	2
137	54	2
139	55	2
141	56	2
146	57	2
149	58	2
150	59	2
159	60	2
161	61	2
\.


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA;
--

COPY "auth_user_user_permissions" ("id", "user_id", "permission_id") FROM stdin;
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA;
--

COPY "django_admin_log" ("id", "action_time", "user_id", "content_type_id", "object_id", "object_repr", "action_flag", "change_message") FROM stdin;
252	2013-09-08T03:02:43	7	3	3	fabio	2	Modifica password.
253	2013-09-08T03:02:59	7	3	5	jose	2	Modifica password y email.
254	2013-09-08T03:03:16	7	3	6	juan	2	Modifica password, email y groups.
255	2013-09-08T03:03:30	7	3	4	Tomas	2	Modifica password y email.
256	2013-09-08T23:52:08	7	8	12312345	root	1	
259	2013-09-10T02:31:47	7	10	1234	OSDE	1	
260	2013-09-10T02:35:59	7	10	1567	Swiss Medical	1	
261	2013-09-14T02:53:22	7	17	1	jose | 1 	1	
262	2013-09-14T02:58:39	7	17	2	juan | 2 	1	
263	2013-09-14T02:59:50	7	17	3	carla | 3 	1	
264	2013-09-14T03:00:19	7	17	1	jose | 1 	2	Modifica antecedentes_enfermedad_actual.
265	2013-09-14T03:10:56	7	17	1	jose | 1 	1	
266	2013-09-14T03:13:15	7	17	1	jose | 1 	1	
267	2013-09-14T03:13:42	7	17	2	juan | 2 	1	
268	2013-09-14T03:15:58	7	17	3	pepe | 3 	1	
269	2013-09-14T03:45:05	7	18	1	1 | Jose Lopez  | 2013-09-14 00:44:54-05:00 	1	
270	2013-09-14T03:50:31	7	18	2	3 | Pepe A  | 2013-09-14 00:50:28-05:00 	1	
271	2013-09-15T03:14:34	7	20	1	1 | Jose Lopez  | 2013-09-15 00:13:57-05:00 	1	
272	2013-09-15T03:16:15	7	19	1	1 | Jose Lopez  | 2013-09-15 00:16:05-05:00 	1	
273	2013-09-15T03:16:39	7	19	2	2 | Juan Perez  | 2013-09-15 00:16:32-05:00 	1	
274	2013-09-16T00:43:20	7	3	3	fabio	2	Modifica password y groups.
275	2013-09-17T18:03:42	7	17	4	4 |  	3	
276	2013-09-17T18:10:18	7	3	10	sheryl	2	Modifica password, first_name y last_name.
277	2013-09-17T18:13:38	7	17	9	9 | sherly crow 	3	
278	2013-09-17T18:57:51	7	17	10	10 | Odie Rodriguez 	3	
279	2013-09-17T20:15:38	7	19	2	2 | Juan Perez  | 2013-09-15 00:16:32-05:00 	2	Modifica infuciones.
280	2013-09-17T23:40:54	7	19	3	5 | Carla Choco  | 2013-09-17 05:00:00+00:00 	3	
281	2014-02-01T18:45:22	7	21	6	Fisiologicos object	3	
282	2014-02-01T18:45:22	7	21	5	Fisiologicos object	3	
283	2014-02-01T18:45:22	7	21	4	Fisiologicos object	3	
284	2014-02-01T18:45:23	7	21	3	Fisiologicos object	3	
285	2014-02-01T18:45:23	7	21	2	Fisiologicos object	3	
286	2014-02-01T18:45:23	7	21	1	Fisiologicos object	3	
287	2014-02-03T00:29:06	7	20	13	14 | Steve Jobs  | 2014-02-03 00:27:39+00:00 	3	
288	2014-02-03T00:29:06	7	20	12	14 | Steve Jobs  | 2014-02-03 00:27:30+00:00 	3	
289	2014-02-03T00:29:06	7	20	11	14 | Steve Jobs  | 2014-02-03 00:27:18+00:00 	3	
290	2014-02-03T00:29:06	7	20	10	14 | Steve Jobs  | 2014-02-03 00:27:07+00:00 	3	
291	2014-02-03T00:29:06	7	20	9	14 | Steve Jobs  | 2014-02-03 00:26:26+00:00 	3	
292	2014-02-03T00:29:06	7	20	8	13 | sherly crow  | 2014-02-03 00:22:37+00:00 	3	
293	2014-02-03T00:29:06	7	20	7	3 | Pepe A  | 2014-02-03 00:19:22+00:00 	3	
294	2014-02-03T00:29:06	7	20	6	12 | Carla Chocobar  | 2014-02-02 15:03:00+00:00 	3	
295	2014-02-03T00:29:06	7	20	5	11 | Odie Rodriguez  | 2013-09-17 19:00:31+00:00 	3	
296	2014-02-03T00:29:06	7	20	4	7 | Fabio German  | 2013-09-17 18:55:03+00:00 	3	
297	2014-02-03T00:29:06	7	20	3	5 | Carla Choco  | 2013-09-17 18:02:04+00:00 	3	
298	2014-02-03T00:29:06	7	20	2	2 | Juan Perez  | 2013-09-17 17:59:34+00:00 	3	
299	2014-02-03T00:29:06	7	20	1	1 | Juan Jose Lopez  | 2013-09-15 05:13:57+00:00 	3	
300	2014-02-03T00:36:02	7	3	9	carla	3	
301	2014-02-03T00:36:02	7	3	14	carlita	3	
302	2014-02-03T00:41:32	7	21	11	Fisiologicos object	3	
303	2014-02-03T00:41:32	7	21	9	Fisiologicos object	3	
304	2014-02-03T00:41:32	7	21	7	Fisiologicos object	3	
305	2014-02-03T01:14:20	7	21	14	Fisiologicos object	3	
306	2014-02-03T01:14:20	7	21	13	Fisiologicos object	3	
307	2014-02-03T01:14:20	7	21	12	Fisiologicos object	3	
308	2014-02-03T01:17:24	7	21	17	Fisiologicos object	3	
309	2014-02-03T01:17:24	7	21	16	Fisiologicos object	3	
310	2014-02-03T01:17:24	7	21	15	Fisiologicos object	3	
311	2014-02-03T01:30:42	7	21	21	Fisiologicos object	3	
312	2014-02-03T01:30:42	7	21	20	Fisiologicos object	3	
313	2014-02-03T01:30:42	7	21	19	Fisiologicos object	3	
314	2014-02-03T01:30:42	7	21	18	Fisiologicos object	3	
315	2014-02-04T00:49:41	7	22	4	Patologicos object	3	
316	2014-02-04T00:49:41	7	22	3	Patologicos object	3	
317	2014-02-04T00:49:41	7	22	2	Patologicos object	3	
318	2014-02-04T00:49:41	7	22	1	Patologicos object	3	
319	2014-02-04T02:49:08	7	22	6	Patologicos object	3	
320	2014-02-04T02:49:08	7	22	5	Patologicos object	3	
321	2014-02-05T14:33:38	7	11	5	fabio | OSECAC	1	
322	2014-02-05T14:34:05	7	11	6	fabio | UOM	1	
323	2014-02-05T17:46:02	7	11	7	fabio | Pami	1	
324	2014-02-05T17:46:10	7	11	8	pepe | IPS	1	
325	2014-02-06T02:11:46	7	11	12	fabio | UTHGRA	3	
326	2014-02-06T02:11:46	7	11	11	fabio | OSPEcom	3	
327	2014-02-06T02:11:46	7	11	10	fabio | eqwe	3	
328	2014-02-06T02:11:46	7	11	9	fabio | UOCRA	3	
329	2014-02-06T02:11:46	7	11	8	pepe | IPS	3	
330	2014-02-06T02:11:46	7	11	7	fabio | Pami	3	
331	2014-02-06T02:11:46	7	11	6	fabio | UOM	3	
332	2014-02-06T02:11:46	7	11	5	fabio | OSECAC	3	
333	2014-02-06T03:13:52	7	11	31	fabio | IPS	3	
334	2014-02-06T03:13:52	7	11	30	fabio | aa	3	
335	2014-02-06T03:13:52	7	11	28	pepe | Swiss Medical	3	
336	2014-02-06T03:13:52	7	11	27	pepe | OSPEcom	3	
337	2014-02-06T03:13:52	7	11	25	pepe | 9	3	
338	2014-02-06T03:13:52	7	11	23	pepe | 212	3	
339	2014-02-06T03:13:52	7	11	21	pepe | UTHGRA	3	
340	2014-02-06T03:13:52	7	11	20	pepe | OSDE	3	
341	2014-02-06T03:13:53	7	11	19	pepe | aa	3	
342	2014-02-06T03:13:53	7	11	18	pepe | OSECAC	3	
343	2014-02-06T03:13:53	7	11	17	fabio | UOCRA	3	
344	2014-02-06T03:13:53	7	11	16	fabio | Swiss Medical	3	
345	2014-02-06T03:13:53	7	11	15	fabio | OSDE	3	
346	2014-02-06T03:13:53	7	11	14	fabio | UOM	3	
347	2014-02-06T03:13:53	7	11	13	fabio | OSECAC	3	
348	2014-02-14T04:41:14	7	3	8	pepe	2	Modifica password y groups.
349	2014-02-14T04:50:15	7	9	33232	Pepe A	1	
350	2014-02-14T05:49:44	7	9	666	John Lennon	3	
351	2014-02-14T05:50:51	7	9	343	sherly crow	3	
352	2014-02-14T05:50:59	7	9	33232	Pepe A	3	
353	2014-02-14T05:50:59	7	9	323	Steve Jobs	3	
354	2014-02-14T05:55:33	7	9	99090	sherly crow	3	
355	2014-02-14T05:55:41	7	9	2121111	py thon	3	
356	2014-02-14T05:56:07	7	9	1111	Abigail Perez	3	
357	2014-02-14T05:56:17	7	9	212	Juan Perez	3	
358	2014-02-16T18:15:23	7	9	21	Juan Perez	3	
359	2014-02-16T18:15:23	7	9	2	Steve Jobs	3	
360	2014-02-16T18:15:23	7	9	1	Fabio German	3	
361	2014-02-16T18:16:33	7	11	84	sheryl | Swiss Medical	3	
362	2014-02-16T18:16:33	7	11	79	fabio | Particular	3	
363	2014-02-16T18:16:33	7	11	78	fabio | OSECAC	3	
364	2014-02-16T18:16:33	7	11	60	Tomas | UTHGRA	3	
365	2014-02-16T18:16:33	7	11	58	Tomas | UOM	3	
366	2014-02-16T18:16:33	7	11	51	Tomas | OSECAC	3	
367	2014-02-16T18:16:56	7	3	6	juan	3	
368	2014-02-16T18:17:15	7	3	3	fabio	3	
369	2014-02-16T18:17:15	7	3	4	Tomas	3	
370	2014-02-16T18:22:48	7	3	16	abigail	3	
371	2014-02-16T18:22:48	7	3	13	jobs	3	
372	2014-02-16T18:22:48	7	3	11	john	3	
373	2014-02-16T18:22:48	7	3	5	jose	3	
374	2014-02-16T18:22:48	7	3	12	odie	3	
375	2014-02-16T18:22:48	7	3	8	pepe	3	
376	2014-02-16T18:22:48	7	3	15	python	3	
377	2014-02-16T18:22:48	7	3	10	sheryl	3	
378	2014-02-16T23:04:58	7	12	10	Oncologia	3	
379	2014-02-17T00:12:30	7	13	4	Pepe Avila | Clinico	1	
380	2014-02-17T00:13:06	7	13	5	Pepe Avila | Traumatologia	1	
381	2014-02-17T00:39:58	7	13	5	Pepe Avila | Traumatologia	3	
382	2014-02-17T00:39:58	7	13	4	Pepe Avila | Clinico	3	
383	2014-02-17T00:50:09	7	13	6	Pepe Avila | Traumatologia	1	
384	2014-02-17T00:50:18	7	13	7	Pepe Avila | Infectología	1	
385	2014-02-17T01:20:06	7	13	10	Pepe Avila | Nutriología	3	
386	2014-02-17T01:20:06	7	13	9	Pepe Avila | Oncologia	3	
387	2014-02-17T01:20:06	7	13	8	Pepe Avila | Reumatologia	3	
388	2014-02-17T01:20:06	7	13	7	Pepe Avila | Infectología	3	
389	2014-02-17T01:57:19	7	13	19	Pepe Avila | Endocrinología	3	
390	2014-02-17T01:57:19	7	13	17	Pepe Avila | Reumatologia	3	
391	2014-02-17T01:57:19	7	13	14	Pepe Avila | Nutriología	3	
392	2014-02-17T01:57:19	7	13	13	Fabio German | Clinico	3	
393	2014-02-17T01:57:19	7	13	12	Pepe Avila | Clinico	3	
394	2014-02-17T01:57:19	7	13	11	Pepe Avila | Infectología	3	
395	2014-02-17T01:57:19	7	13	6	Pepe Avila | Traumatologia	3	
396	2014-02-20T03:56:31	7	26	A001	A001	1	
397	2014-02-24T01:06:56	7	3	23	jose	3	
398	2014-02-24T01:09:34	7	3	24	jose	3	
399	2014-02-24T01:10:40	7	3	25	jose	3	
400	2014-02-24T02:38:02	7	3	21	jobs	3	
401	2014-02-24T02:38:02	7	3	22	john	3	
402	2014-02-24T17:59:17	7	18	1	1 | Pepe Avila  | 2014-02-24 14:58:18-03:00 	1	
403	2014-02-24T18:11:28	7	18	2	1 | Pepe Avila  | 2014-02-24 15:11:17-03:00 	1	
404	2014-02-24T18:24:53	7	18	3	2 | Fabio German  | 2014-02-24 15:24:44-03:00 	1	
405	2014-02-25T03:16:43	7	18	4	1 | Pepe Avila  | 2014-02-25 00:16:26-03:00 	1	
406	2014-02-25T17:13:16	7	18	1	1 | Pepe Avila  | 2014-02-25 14:13:09-03:00 	1	
407	2014-02-26T18:43:07	7	26	B001	B001	1	
408	2014-03-03T00:55:12	7	3	7	root	2	Modifica password y groups.
409	2014-03-04T17:40:40	7	18	1	1 | Pepe Avila  | 2014-03-04 14:40:32-03:00 	1	
410	2014-03-04T17:42:41	7	18	2	1 | Pepe Avila  | 2014-03-04 14:42:23-03:00 	1	
413	2014-03-05T01:34:31	7	18	4	1 | Pepe Avila  | 2013-03-04 22:34:26-03:00 	1	
414	2014-03-05T01:35:23	7	18	5	1 | Pepe Avila  | 2013-01-21 22:35:18-03:00 	1	
415	2014-03-05T15:04:22	7	26	A002	A002 | vavsafdsf	1	
416	2014-03-05T15:04:29	7	26	B002	B002 | fafasfjlakj lk	1	
417	2014-03-05T15:04:37	7	26	C001	C001 | fhasfk	1	
418	2014-03-05T15:04:42	7	26	C002	C002 | fasfsda	1	
419	2014-03-05T15:04:49	7	26	C003	C003 | jikjlkj 	1	
420	2014-03-05T15:24:18	7	26	C004	C004 | qqqerqe	1	
421	2014-03-05T15:24:34	7	18	1	1 | Pepe Avila  | 2014-03-05 12:23:47-03:00 	1	
422	2014-03-05T15:25:05	7	18	2	1 | Pepe Avila  | 2014-03-05 12:24:47-03:00 	1	
423	2014-03-05T15:35:03	7	18	2	1 | Pepe Avila  | 2014-03-05 12:24:47-03:00 	2	Modifica diagnosticos.
424	2014-03-11T19:19:34	7	27	1	Laboratorio object	1	
425	2014-03-11T19:19:53	7	27	2	Laboratorio object	1	
426	2014-03-16T16:03:58	7	28	1	1 | Pepe Avila  | 2014-03-16 13:03:36-03:00 	1	
427	2014-03-16T23:53:11	7	28	2	1 | Pepe Avila  | 2014-03-16 20:53:05-03:00 	1	
428	2014-03-21T02:25:37	7	16	22	Fabio German | Traumatologia | 2014-03-27  | 09:30:00 	3	
429	2014-03-21T02:25:37	7	16	21	Fabio German | Traumatologia | 2014-03-27  | 09:15:00 	3	
430	2014-03-21T02:25:37	7	16	20	Fabio German | Traumatologia | 2014-03-27  | 09:00:00 	3	
431	2014-03-21T02:25:37	7	16	19	Fabio German | Traumatologia | 2014-03-27  | 08:45:00 	3	
432	2014-03-21T02:25:37	7	16	18	Fabio German | Traumatologia | 2014-03-27  | 08:30:00 	3	
433	2014-03-21T02:25:37	7	16	17	Fabio German | Traumatologia | 2014-03-27  | 08:15:00 	3	
434	2014-03-21T02:25:37	7	16	16	Fabio German | Traumatologia | 2014-03-27  | 08:00:00 	3	
435	2014-03-21T02:25:37	7	16	15	Fabio German | Traumatologia | 2014-03-20  | 10:15:00 	3	
436	2014-03-21T02:25:37	7	16	14	Fabio German | Traumatologia | 2014-03-20  | 10:00:00 	3	
437	2014-03-21T02:25:37	7	16	13	Fabio German | Traumatologia | 2014-03-20  | 09:45:00 	3	
438	2014-03-21T02:25:37	7	16	12	Fabio German | Traumatologia | 2014-03-20  | 09:30:00 	3	
439	2014-03-21T02:25:37	7	16	11	Fabio German | Traumatologia | 2014-03-20  | 09:15:00 	3	
440	2014-03-21T02:25:37	7	16	10	Fabio German | Traumatologia | 2014-03-20  | 09:00:00 	3	
441	2014-03-21T02:25:37	7	16	9	Fabio German | Traumatologia | 2014-03-20  | 08:45:00 	3	
442	2014-03-21T02:25:37	7	16	8	Fabio German | Traumatologia | 2014-03-20  | 08:30:00 	3	
443	2014-03-21T02:25:37	7	16	7	Fabio German | Traumatologia | 2014-03-20  | 08:15:00 	3	
444	2014-03-21T02:25:37	7	16	6	Fabio German | Traumatologia | 2014-03-20  | 08:00:00 	3	
445	2014-03-21T02:25:37	7	16	5	Fabio German | Traumatologia | 2014-02-24  | 09:00:00 	3	
446	2014-03-21T02:25:37	7	16	4	Fabio German | Traumatologia | 2014-02-24  | 08:45:00 	3	
447	2014-03-21T02:25:37	7	16	3	Fabio German | Traumatologia | 2014-02-24  | 08:30:00 	3	
448	2014-03-21T02:25:37	7	16	2	Fabio German | Traumatologia | 2014-02-24  | 08:15:00 	3	
449	2014-03-21T02:25:37	7	16	1	Fabio German | Traumatologia | 2014-02-24  | 08:00:00 	3	
450	2014-03-21T02:25:47	7	15	6	Fabio German | Traumatologia | 2014-04-09 	3	
451	2014-03-21T02:25:47	7	15	5	Fabio German | Traumatologia | 2014-04-02 	3	
452	2014-03-21T02:25:47	7	15	4	Fabio German | Traumatologia | 2014-03-27 	3	
453	2014-03-21T02:25:47	7	15	3	Fabio German | Traumatologia | 2014-03-26 	3	
454	2014-03-21T02:25:47	7	15	2	Fabio German | Traumatologia | 2014-03-20 	3	
455	2014-03-21T02:25:47	7	15	1	Fabio German | Traumatologia | 2014-02-24 	3	
456	2014-03-22T15:46:56	7	15	12	Fabio German | Traumatologia | 2014-03-27 	3	
457	2014-03-22T15:46:56	7	15	11	Fabio German | Traumatologia | 2014-04-14 	3	
458	2014-03-22T15:46:56	7	15	10	Fabio German | Traumatologia | 2014-03-31 	3	
459	2014-03-22T15:46:56	7	15	9	Fabio German | Traumatologia | 2014-03-28 	3	
460	2014-03-22T15:46:56	7	15	8	Fabio German | Traumatologia | 2014-03-24 	3	
461	2014-03-22T15:46:56	7	15	7	Fabio German | Traumatologia | 2014-03-26 	3	
462	2014-03-22T16:04:42	7	15	17	Fabio German | Traumatologia | 2014-04-07 	3	
463	2014-03-22T16:04:42	7	15	16	Fabio German | Traumatologia | 2014-04-17 	3	
464	2014-03-22T16:04:42	7	15	15	Fabio German | Traumatologia | 2014-04-10 	3	
465	2014-03-22T16:04:42	7	15	14	Fabio German | Traumatologia | 2014-04-03 	3	
466	2014-03-22T16:04:42	7	15	13	Fabio German | Traumatologia | 2014-03-27 	3	
467	2014-03-22T16:06:30	7	15	19	Fabio German | Traumatologia | 2014-03-28 	3	
468	2014-03-22T16:06:30	7	15	18	Fabio German | Traumatologia | 2014-03-24 	3	
469	2014-03-22T19:58:20	7	15	33	Fabio German | Traumatologia | 2014-04-07 	3	
470	2014-03-22T19:58:20	7	15	32	Fabio German | Traumatologia | 2014-03-31 	3	
471	2014-03-22T19:58:20	7	15	31	Fabio German | Traumatologia | 2014-04-21 	3	
472	2014-03-22T19:58:20	7	15	30	Fabio German | Traumatologia | 2014-04-28 	3	
473	2014-03-22T19:58:20	7	15	29	Fabio German | Traumatologia | 2014-04-17 	3	
474	2014-03-22T19:58:20	7	15	28	Fabio German | Traumatologia | 2014-04-24 	3	
475	2014-03-22T19:58:20	7	15	27	Fabio German | Traumatologia | 2014-03-22 	3	
476	2014-03-22T19:58:20	7	15	26	Fabio German | Traumatologia | 2014-03-25 	3	
477	2014-03-22T19:58:20	7	15	25	Fabio German | Traumatologia | 2014-03-01 	3	
478	2014-03-22T19:58:20	7	15	24	Fabio German | Traumatologia | 2014-03-29 	3	
479	2014-03-22T19:58:20	7	15	23	Steve Jobs | Clinico | 2014-04-30 	3	
480	2014-03-22T19:58:20	7	15	22	Pepe Avila | Cardiologia | 2014-03-25 	3	
481	2014-03-22T19:58:20	7	15	21	Fabio German | Traumatologia | 2014-03-27 	3	
482	2014-03-22T19:58:20	7	15	20	Fabio German | Traumatologia | 2014-03-24 	3	
483	2014-03-22T20:15:33	7	15	49	Fabio German | Traumatologia | 2014-04-09 	3	
484	2014-03-22T20:15:33	7	15	48	Fabio German | Traumatologia | 2014-04-23 	3	
485	2014-03-22T20:15:33	7	15	47	Fabio German | Traumatologia | 2014-04-16 	3	
486	2014-03-22T20:15:33	7	15	46	Fabio German | Traumatologia | 2014-04-24 	3	
487	2014-03-22T20:15:33	7	15	45	Fabio German | Traumatologia | 2014-04-10 	3	
488	2014-03-22T20:15:33	7	15	44	Fabio German | Traumatologia | 2014-04-14 	3	
489	2014-03-22T20:15:33	7	15	43	Fabio German | Traumatologia | 2014-04-21 	3	
490	2014-03-22T20:15:33	7	15	42	Fabio German | Traumatologia | 2014-04-17 	3	
491	2014-03-22T20:15:33	7	15	41	Fabio German | Traumatologia | 2014-03-27 	3	
492	2014-03-22T20:15:33	7	15	40	Fabio German | Traumatologia | 2014-04-05 	3	
493	2014-03-22T20:15:33	7	15	39	Fabio German | Traumatologia | 2014-03-29 	3	
494	2014-03-22T20:15:33	7	15	38	Fabio German | Traumatologia | 2014-04-28 	3	
495	2014-03-22T20:15:33	7	15	37	Fabio German | Traumatologia | 2014-03-25 	3	
496	2014-03-22T20:15:33	7	15	36	Fabio German | Traumatologia | 2014-04-07 	3	
497	2014-03-22T20:15:33	7	15	35	Fabio German | Traumatologia | 2014-03-31 	3	
498	2014-03-22T20:15:33	7	15	34	Fabio German | Traumatologia | 2014-03-24 	3	
499	2014-04-10T19:16:12	7	15	68	Fabio German | Traumatologia | 2014-05-30 	3	
500	2014-04-10T19:16:12	7	15	67	Fabio German | Traumatologia | 2014-04-04 	3	
501	2014-04-10T19:16:12	7	15	66	Fabio German | Traumatologia | 2014-04-24 	3	
502	2014-04-10T19:16:12	7	15	65	Fabio German | Traumatologia | 2014-04-09 	3	
503	2014-04-10T19:16:12	7	15	64	Fabio German | Traumatologia | 2014-04-07 	3	
504	2014-04-10T19:16:12	7	15	63	Fabio German | Traumatologia | 2014-04-02 	3	
505	2014-04-10T19:16:12	7	15	62	Fabio German | Traumatologia | 2014-04-05 	3	
506	2014-04-10T19:16:12	7	15	61	Steve Jobs | Clinico | 2014-03-24 	3	
507	2014-04-10T19:16:12	7	15	60	Fabio German | Traumatologia | 2014-03-31 	3	
508	2014-04-10T19:16:12	7	15	59	Fabio German | Traumatologia | 2014-03-31 	3	
509	2014-04-10T19:16:12	7	15	58	Steve Jobs | Traumatologia | 2014-04-28 	3	
510	2014-04-10T19:16:12	7	15	57	Steve Jobs | Traumatologia | 2014-03-24 	3	
511	2014-04-10T19:16:12	7	15	56	Fabio German | Oncologia | 2014-03-24 	3	
512	2014-04-10T19:16:12	7	15	55	Fabio German | Traumatologia | 2014-04-30 	3	
513	2014-04-10T19:16:12	7	15	54	Fabio German | Traumatologia | 2014-04-10 	3	
514	2014-04-10T19:16:12	7	15	53	Fabio German | Traumatologia | 2014-04-23 	3	
515	2014-04-10T19:16:12	7	15	52	Fabio German | Traumatologia | 2014-03-29 	3	
516	2014-04-10T19:16:12	7	15	51	Fabio German | Traumatologia | 2014-03-27 	3	
517	2014-04-10T19:16:12	7	15	50	Fabio German | Traumatologia | 2014-03-24 	3	
518	2014-04-10T20:54:37	7	15	70	Fabio German | Traumatologia | 2014-04-16 	3	
519	2014-04-10T20:54:37	7	15	69	Fabio German | Traumatologia | 2014-04-14 	3	
520	2014-04-19T20:15:38	7	3	42	bla	3	
521	2014-04-19T20:15:38	7	3	43	ble	3	
522	2014-04-19T20:15:38	7	3	33	jo	3	
523	2014-04-19T20:15:38	7	3	34	jo1	3	
524	2014-04-19T20:15:38	7	3	35	jo2	3	
525	2014-04-19T20:15:38	7	3	36	jo3	3	
526	2014-04-19T20:15:38	7	3	41	keke	3	
527	2014-04-19T20:15:38	7	3	39	ko1	3	
528	2014-04-19T20:15:38	7	3	40	kop	3	
529	2014-04-19T20:15:38	7	3	38	odie1	3	
530	2014-04-19T20:15:38	7	3	32	paciente4	3	
531	2014-04-19T20:15:38	7	3	37	pe	3	
532	2014-06-08T23:00:49	7	29	0	ANC - 0	1	
533	2014-06-08T23:01:18	7	29	01	QUI - 01	1	
534	2014-06-08T23:01:39	7	29	02	QUI - 02	1	
535	2014-06-08T23:02:25	7	30	1	ANC - 0 - 001	1	
536	2014-06-08T23:02:53	7	30	2	ANC - 0 - 002	1	
537	2014-06-08T23:03:31	7	30	3	QUI - 01 - 01	1	
538	2014-06-08T23:03:45	7	30	4	QUI - 01 - 02	1	
539	2014-06-08T23:05:52	7	30	5	ANC - 0 - 01	1	
540	2014-06-08T23:06:26	7	30	5	ANC - 0 - 01	3	
541	2014-06-08T23:06:33	7	30	2	ANC - 0 - 02	2	Modifica codigo.
542	2014-06-08T23:06:39	7	30	1	ANC - 0 - 01	2	Modifica codigo.
543	2014-06-08T23:07:57	7	30	1	ANC - 0 . 001	2	Modifica codigo.
544	2014-06-08T23:08:04	7	30	2	ANC - 0 . 002	2	Modifica codigo.
545	2014-06-09T00:32:10	7	28	1	1 | Pepe Avila  | 2014-06-08 21:31:58-03:00 	1	
546	2014-06-09T00:35:50	7	28	2	2 | 2014-06-08 21:35:38-03:00 	1	
547	2014-06-09T00:37:09	7	28	2	2 	2	Se agregó practica detalle "2 -3 ".
548	2014-06-09T01:05:18	7	28	3	1 | Pepe Avila -2000-02-02 03:00:00+00:00 	3	
549	2014-06-09T01:05:18	7	28	2	1 | Pepe Avila -2014-06-09 00:35:38+00:00 	3	
550	2014-06-09T01:05:18	7	28	1	1 | Pepe Avila -2014-06-09 00:31:58+00:00 	3	
551	2014-06-09T13:56:58	7	28	5	1 | Pepe Avila -2000-02-02 03:00:00+00:00 	3	
552	2014-06-09T13:56:59	7	28	4	1 | Pepe Avila -2000-02-02 03:00:00+00:00 	3	
553	2014-07-02T21:15:16	7	18	16	1 | Pepe Avila  | 2014-06-08 21:35:49+00:00 	3	
554	2014-07-02T21:15:16	7	18	15	1 | Pepe Avila  | 2014-04-19 19:12:56+00:00 	3	
555	2014-07-02T21:15:16	7	18	14	1 | Pepe Avila  | 2014-03-14 18:59:51+00:00 	3	
556	2014-07-02T21:15:16	7	18	13	7 | Abigail Perez  | 2014-03-14 17:36:52+00:00 	3	
557	2014-07-02T21:15:16	7	18	9	3 | Carla Chocobar  | 2014-03-06 03:27:38+00:00 	3	
558	2014-07-02T21:15:16	7	18	7	3 | Carla Chocobar  | 2014-03-06 01:47:11+00:00 	3	
559	2014-07-02T21:15:16	7	18	2	1 | Pepe Avila  | 2014-03-05 15:24:47+00:00 	3	
560	2014-07-02T21:27:16	7	18	1	1 | Pepe Avila  | 2014-07-02 18:26:40-03:00 	1	
561	2014-07-02T21:28:16	7	18	1	1 | Pepe Avila  | 2014-07-02 21:26:40+00:00 	3	
562	2014-07-02T21:30:31	7	18	1	1 | Pepe Avila  | 2014-07-02 18:30:25-03:00 	1	
563	2014-07-02T21:41:46	7	18	3	1 | Pepe Avila  | 2014-07-02 18:41:00-03:00 	1	
564	2014-07-02T21:49:09	7	18	1	1 | Pepe Avila  | 2014-07-02 18:48:38-03:00 	1	
565	2014-07-02T22:36:14	7	18	9	2 | Fabio German  | 2014-07-02 19:36:11-03:00 	1	
566	2014-07-02T22:47:18	7	28	1	1 | Pepe Avila -2014-07-02 19:47:14-03:00 	1	
567	2014-07-03T00:03:02	7	28	2	2 | Fabio German -2014-07-02 21:02:46-03:00 	1	
568	2014-07-03T00:19:02	7	28	3	1 | Pepe Avila -2014-07-03 00:12:20+00:00 	3	
569	2014-07-03T00:19:02	7	28	2	2 | Fabio German -2014-07-03 00:02:46+00:00 	3	
570	2014-07-03T00:19:02	7	28	1	1 | Pepe Avila -2014-07-02 22:47:14+00:00 	3	
571	2014-07-03T02:31:38	7	28	10	1 | Pepe Avila -2014-07-03 02:24:11+00:00 	3	
572	2014-07-03T02:31:38	7	28	9	1 | Pepe Avila -2014-07-03 02:17:34+00:00 	3	
573	2014-07-03T02:31:38	7	28	8	1 | Pepe Avila -2014-07-03 01:39:37+00:00 	3	
574	2014-07-03T02:31:38	7	28	7	1 | Pepe Avila -2014-07-03 00:53:35+00:00 	3	
575	2014-07-03T02:31:38	7	28	6	1 | Pepe Avila -2014-07-03 00:53:14+00:00 	3	
576	2014-07-03T02:31:38	7	28	5	1 | Pepe Avila -2014-07-03 00:53:05+00:00 	3	
577	2014-07-03T02:31:38	7	28	4	1 | Pepe Avila -2014-07-03 00:49:33+00:00 	3	
578	2014-07-03T02:31:38	7	28	3	1 | Pepe Avila -2014-07-03 00:40:37+00:00 	3	
579	2014-07-03T02:31:38	7	28	2	1 | Pepe Avila -2014-07-03 00:38:51+00:00 	3	
580	2014-07-03T02:31:38	7	28	1	1 | Pepe Avila -2014-07-03 00:35:35+00:00 	3	
581	2014-07-03T02:41:11	7	28	1	1 | Pepe Avila -2014-07-02 23:40:24-03:00 	1	
582	2014-07-03T02:48:56	7	28	4	1 | Pepe Avila -2014-07-03 02:47:29+00:00 	3	
583	2014-07-03T02:48:56	7	28	3	1 | Pepe Avila -2014-07-03 02:46:53+00:00 	3	
584	2014-07-03T02:48:56	7	28	2	1 | Pepe Avila -2014-07-03 02:41:26+00:00 	3	
585	2014-07-03T02:48:56	7	28	1	1 | Pepe Avila -2014-07-03 02:40:24+00:00 	3	
586	2014-07-03T15:57:06	7	28	18	1 | Pepe Avila -2014-07-03 15:53:26+00:00 	3	
587	2014-07-03T15:57:06	7	28	17	1 | Pepe Avila -2014-07-03 15:50:00+00:00 	3	
588	2014-07-03T15:57:06	7	28	16	1 | Pepe Avila -2014-07-03 15:45:26+00:00 	3	
589	2014-07-03T15:57:06	7	28	15	1 | Pepe Avila -2014-07-03 15:43:32+00:00 	3	
590	2014-07-03T15:57:07	7	28	14	1 | Pepe Avila -2014-07-03 14:48:40+00:00 	3	
591	2014-07-03T15:57:07	7	28	13	1 | Pepe Avila -2014-07-03 14:48:06+00:00 	3	
592	2014-07-03T15:57:07	7	28	12	1 | Pepe Avila -2014-07-03 03:57:35+00:00 	3	
593	2014-07-03T15:57:07	7	28	11	1 | Pepe Avila -2014-07-03 03:50:32+00:00 	3	
594	2014-07-03T15:57:07	7	28	10	1 | Pepe Avila -2014-07-03 03:49:47+00:00 	3	
595	2014-07-03T15:57:07	7	28	9	1 | Pepe Avila -2014-07-03 03:44:48+00:00 	3	
596	2014-07-03T15:57:07	7	28	8	1 | Pepe Avila -2014-07-03 03:38:36+00:00 	3	
597	2014-07-03T15:57:07	7	28	7	1 | Pepe Avila -2014-07-03 03:34:57+00:00 	3	
598	2014-07-03T15:57:07	7	28	6	1 | Pepe Avila -2014-07-03 03:34:34+00:00 	3	
599	2014-07-03T15:57:07	7	28	5	1 | Pepe Avila -2014-07-03 03:32:50+00:00 	3	
600	2014-07-03T15:57:07	7	28	4	1 | Pepe Avila -2014-07-03 03:31:12+00:00 	3	
601	2014-07-03T15:57:07	7	28	3	1 | Pepe Avila -2014-07-03 03:27:06+00:00 	3	
602	2014-07-03T15:57:07	7	28	2	1 | Pepe Avila -2014-07-03 03:17:48+00:00 	3	
603	2014-07-03T15:57:07	7	28	1	1 | Pepe Avila -2014-07-03 02:53:54+00:00 	3	
604	2014-07-03T17:44:50	7	28	3	1 | Pepe Avila -2014-07-03 17:41:53+00:00 	3	
605	2014-07-03T17:44:51	7	28	2	1 | Pepe Avila -2014-07-03 17:36:48+00:00 	3	
606	2014-07-03T17:44:51	7	28	1	1 | Pepe Avila -2014-07-03 15:58:57+00:00 	3	
607	2014-07-04T00:44:06	7	28	18	7 | Abigail Perez -2014-07-03 19:02:13+00:00 	3	
608	2014-07-04T00:44:06	7	28	17	7 | Abigail Perez -2014-07-03 18:58:42+00:00 	3	
609	2014-07-04T00:44:06	7	28	16	7 | Abigail Perez -2014-07-03 18:56:02+00:00 	3	
610	2014-07-04T00:44:06	7	28	15	7 | Abigail Perez -2014-07-03 18:53:47+00:00 	3	
611	2014-07-04T00:44:06	7	28	14	1 | Pepe Avila -2014-07-03 18:32:42+00:00 	3	
612	2014-07-04T00:44:06	7	28	13	1 | Pepe Avila -2014-07-03 18:30:37+00:00 	3	
613	2014-07-04T00:44:06	7	28	12	1 | Pepe Avila -2014-07-03 18:23:05+00:00 	3	
614	2014-07-04T00:44:06	7	28	11	1 | Pepe Avila -2014-07-03 18:20:52+00:00 	3	
615	2014-07-04T00:44:06	7	28	10	1 | Pepe Avila -2014-07-03 18:18:42+00:00 	3	
616	2014-07-04T00:44:06	7	28	9	1 | Pepe Avila -2014-07-03 18:17:33+00:00 	3	
617	2014-07-04T00:44:06	7	28	8	1 | Pepe Avila -2014-07-03 18:11:39+00:00 	3	
618	2014-07-04T00:44:07	7	28	7	1 | Pepe Avila -2014-07-03 18:10:09+00:00 	3	
619	2014-07-04T00:44:07	7	28	6	1 | Pepe Avila -2014-07-03 18:03:54+00:00 	3	
620	2014-07-04T00:44:07	7	28	5	1 | Pepe Avila -2014-07-03 17:54:32+00:00 	3	
621	2014-07-04T00:44:07	7	28	4	1 | Pepe Avila -2014-07-03 17:45:04+00:00 	3	
622	2014-07-04T22:39:28	7	18	10	7 | Abigail Perez  | 2014-07-04 01:03:21+00:00 	3	
623	2014-07-04T22:39:28	7	18	9	2 | Fabio German  | 2014-07-02 22:36:11+00:00 	3	
624	2014-07-04T22:39:28	7	18	8	1 | Pepe Avila  | 2014-07-02 22:35:32+00:00 	3	
625	2014-07-04T22:39:28	7	18	7	1 | Pepe Avila  | 2014-07-02 22:34:51+00:00 	3	
626	2014-07-04T22:39:28	7	18	6	1 | Pepe Avila  | 2014-07-02 22:34:12+00:00 	3	
627	2014-07-04T22:39:28	7	18	5	1 | Pepe Avila  | 2014-07-02 22:33:36+00:00 	3	
628	2014-07-04T22:39:28	7	18	4	1 | Pepe Avila  | 2014-07-02 22:25:12+00:00 	3	
629	2014-07-04T22:39:28	7	18	3	1 | Pepe Avila  | 2014-07-02 22:24:13+00:00 	3	
630	2014-07-04T22:39:28	7	18	2	1 | Pepe Avila  | 2014-07-02 22:23:29+00:00 	3	
631	2014-07-04T22:39:28	7	18	1	1 | Pepe Avila  | 2014-07-02 22:22:27+00:00 	3	
632	2014-07-04T22:47:21	7	18	1	1 | Pepe Avila  | 2014-07-04 19:47:14-03:00 	1	
633	2014-07-04T23:39:21	7	28	26	7 | Abigail Perez -2014-07-04 22:36:33+00:00 	3	
634	2014-07-04T23:39:21	7	28	25	7 | Abigail Perez -2014-07-04 01:00:27+00:00 	3	
635	2014-07-04T23:39:22	7	28	24	7 | Abigail Perez -2014-07-04 00:58:12+00:00 	3	
636	2014-07-04T23:39:22	7	28	23	7 | Abigail Perez -2014-07-04 00:52:57+00:00 	3	
637	2014-07-04T23:39:22	7	28	22	7 | Abigail Perez -2014-07-04 00:50:40+00:00 	3	
638	2014-07-04T23:39:22	7	28	21	7 | Abigail Perez -2014-07-04 00:50:27+00:00 	3	
639	2014-07-04T23:39:22	7	28	20	7 | Abigail Perez -2014-07-04 00:49:00+00:00 	3	
640	2014-07-04T23:39:22	7	28	19	7 | Abigail Perez -2014-07-04 00:46:31+00:00 	3	
641	2014-07-05T03:03:59	7	32	1	1-Amoxicilina 	1	
642	2014-07-05T03:04:31	7	32	2	2-Amoxicilina 	1	
643	2014-07-05T03:18:47	7	33	1	1-fabio 	1	
644	2014-07-05T03:19:06	7	33	2	2-pepe 	1	
645	2014-07-05T03:20:46	7	34	3	3-1-fabio  	1	
646	2014-07-05T04:05:57	7	33	3	3-pepe 	1	
647	2014-07-05T23:30:13	7	33	9	9-pepe 	3	
648	2014-07-05T23:30:13	7	33	8	8-pepe 	3	
649	2014-07-05T23:30:13	7	33	7	7-pepe 	3	
650	2014-07-05T23:30:13	7	33	6	6-pepe 	3	
651	2014-07-05T23:30:13	7	33	5	5-pepe 	3	
652	2014-07-05T23:30:13	7	33	4	4-pepe 	3	
653	2014-07-05T23:30:13	7	33	3	3-pepe 	3	
654	2014-07-05T23:30:13	7	33	2	2-pepe 	3	
655	2014-07-05T23:30:13	7	33	1	1-fabio 	3	
656	2014-07-05T23:36:38	7	32	3	Diclofenac 75 mg	1	
657	2014-07-05T23:37:12	7	32	4	Parecetamol 500 mg	1	
658	2014-07-05T23:39:22	7	32	4	Paracetamol 500 mg	2	Modifica monodroga.
659	2014-07-06T01:01:51	7	15	92	92 | 2014-07-07 	3	
660	2014-07-06T01:01:51	7	15	91	91 | 2014-06-18 	3	
661	2014-07-06T01:01:51	7	15	90	90 | 2014-06-16 	3	
662	2014-07-06T01:01:51	7	15	89	89 | 2014-06-09 	3	
663	2014-07-06T01:01:51	7	15	88	88 | 2014-04-24 	3	
664	2014-07-06T01:01:51	7	15	87	87 | 2014-04-23 	3	
665	2014-07-06T01:01:51	7	15	86	86 | 2014-04-22 	3	
666	2014-07-06T01:01:51	7	15	85	85 | 2014-04-28 	3	
667	2014-07-06T01:01:51	7	15	84	84 | 2014-04-21 	3	
668	2014-07-06T01:01:51	7	15	83	83 | 2014-05-05 	3	
669	2014-07-06T01:01:51	7	15	82	82 | 2014-04-28 	3	
670	2014-07-06T01:01:51	7	15	81	81 | 2014-04-21 	3	
671	2014-07-06T01:01:51	7	15	80	80 | 2014-04-30 	3	
672	2014-07-06T01:01:51	7	15	79	79 | 2014-04-23 	3	
673	2014-07-06T01:01:51	7	15	78	78 | 2014-04-21 	3	
674	2014-07-06T01:01:51	7	15	77	77 | 2014-04-21 	3	
675	2014-07-06T01:01:51	7	15	76	76 | 2014-04-17 	3	
676	2014-07-06T01:01:51	7	15	75	75 | 2014-04-11 	3	
677	2014-07-06T01:01:51	7	15	74	74 | 2014-04-24 	3	
678	2014-07-06T01:01:51	7	15	73	73 | 2014-04-16 	3	
679	2014-07-06T01:01:51	7	15	72	72 | 2014-04-14 	3	
680	2014-07-06T01:01:51	7	15	71	71 | 2014-04-10 	3	
681	2014-07-06T01:02:15	7	15	93	93 | 2014-07-07 	1	
682	2014-07-06T01:02:39	7	15	93	93 | 2014-07-07 	3	
683	2014-08-12T18:26:30	7	30	5	Analisis Clinicos - 0 . 003	1	
684	2014-08-12T18:26:39	7	30	6	Analisis Clinicos - 0 . 004	1	
685	2014-08-12T18:26:56	7	30	7	Analisis Clinicos - 0 . 005	1	
686	2014-08-12T18:32:39	7	28	13	13-abigail 	3	
687	2014-08-12T18:32:39	7	28	12	12-abigail 	3	
688	2014-08-12T18:32:39	7	28	11	11-abigail 	3	
689	2014-08-12T18:32:39	7	28	10	10-barby 	3	
690	2014-08-12T18:32:39	7	28	9	9-pepe 	3	
691	2014-08-12T18:32:39	7	28	8	8-pepe 	3	
692	2014-08-12T18:32:39	7	28	7	7-abigail 	3	
693	2014-08-12T18:32:39	7	28	6	6-pepe 	3	
694	2014-08-12T18:32:39	7	28	5	5-pepe 	3	
695	2014-08-12T18:32:39	7	28	4	4-abigail 	3	
696	2014-08-12T18:32:39	7	28	3	3-barby 	3	
697	2014-08-12T18:32:39	7	28	2	2-pepe 	3	
698	2014-08-12T18:32:39	7	28	1	1-abigail 	3	
699	2014-08-15T15:44:41	7	32	4	Paracetamol 500 mg	3	
700	2014-08-15T15:44:41	7	32	3	Diclofenac 75 mg	3	
701	2014-08-15T15:44:41	7	32	2	Amoxicilina 250mg	3	
702	2014-08-15T15:44:41	7	32	1	Amoxicilina 500mg	3	
703	2014-08-15T15:45:03	7	33	15	15-barby 	3	
704	2014-08-15T15:45:03	7	33	14	14-pepe 	3	
705	2014-08-15T15:45:03	7	33	13	13-pepe 	3	
706	2014-08-15T15:45:03	7	33	12	12-pepe 	3	
707	2014-08-15T15:45:03	7	33	11	11-pepe 	3	
708	2014-08-15T15:45:03	7	33	10	10-pepe 	3	
709	2014-08-17T23:53:04	7	30	7	Analisis Clinicos - 0 . 005	3	
710	2014-08-17T23:53:04	7	30	6	Analisis Clinicos - 0 . 004	3	
711	2014-08-17T23:53:04	7	30	5	Analisis Clinicos - 0 . 003	3	
712	2014-08-17T23:53:04	7	30	4	Quirurgicas - 01 . 02	3	
713	2014-08-17T23:53:04	7	30	3	Quirurgicas - 01 . 01	3	
714	2014-08-17T23:53:04	7	30	2	Analisis Clinicos - 0 . 002	3	
715	2014-08-17T23:53:04	7	30	1	Analisis Clinicos - 0 . 001	3	
716	2014-08-17T23:53:51	7	29	02	Quirurgicas - 02	3	
717	2014-08-17T23:53:51	7	29	01	Quirurgicas - 01	3	
718	2014-08-17T23:53:51	7	29	0	Analisis Clinicos - 0	3	
719	2014-08-17T23:59:46	7	29	00	Analisis Clinicos - 00	1	
720	2014-08-17T23:59:55	7	29	01	Analisis Clinicos - 01	1	
721	2014-08-18T00:00:18	7	30	1	Analisis Clinicos - 00 . 001	1	
722	2014-08-18T00:00:24	7	30	2	Analisis Clinicos - 00 . 002	1	
723	2014-08-18T00:01:48	7	30	5	Analisis Clinicos - 01 . 002	3	
724	2014-08-18T00:01:48	7	30	4	Analisis Clinicos - 01 . 001	3	
725	2014-08-18T00:01:48	7	30	3	Analisis Clinicos - 00 . 003	3	
726	2014-08-18T00:01:48	7	30	2	Analisis Clinicos - 00 . 002	3	
727	2014-08-18T00:01:49	7	30	1	Analisis Clinicos - 00 . 001	3	
728	2014-08-18T00:01:55	7	29	01	Analisis Clinicos - 01	3	
729	2014-08-18T00:01:55	7	29	00	Analisis Clinicos - 00	3	
730	2014-08-18T00:07:51	7	29	00	Analisis Clinicos - 00	1	
731	2014-08-18T00:07:56	7	29	01	Analisis Clinicos - 01	1	
732	2014-08-18T00:08:08	7	30	1	Analisis Clinicos - 00 . 001	1	
733	2014-08-18T00:08:16	7	30	2	Analisis Clinicos - 00 . 002	1	
734	2014-08-18T00:08:22	7	30	3	Analisis Clinicos - 01 . 001	1	
735	2014-08-18T00:36:07	7	26	D002	D002 - fasfasdfq	3	
736	2014-08-18T00:36:07	7	26	D001	D001 - fdasfasq	3	
737	2014-08-18T00:36:07	7	26	C002	C002 - fasfsda	3	
738	2014-08-18T00:36:07	7	26	C001	C001 - fhasfk	3	
739	2014-08-18T00:36:07	7	26	B003	B003 - fdsaf	3	
740	2014-08-18T00:36:07	7	26	B002	B002 - fafasfjlakj	3	
741	2014-08-18T00:36:07	7	26	B001	B001 - apendicitis	3	
742	2014-08-18T00:36:07	7	26	A004	A004 -  safdsf	3	
743	2014-08-18T00:36:07	7	26	A002	A002 - vavsafdsf	3	
744	2014-08-18T00:36:07	7	26	A001	A001 - Colera	3	
745	2014-08-18T00:40:36	7	18	9	6 | Barbara Santillan  | 2014-07-28 04:58:45+00:00 	3	
746	2014-08-18T00:40:36	7	18	8	7 | Abigail Perez  | 2014-07-28 03:01:59+00:00 	3	
747	2014-08-18T00:40:36	7	18	7	1 | Pepe Avila  | 2014-07-28 02:46:32+00:00 	3	
748	2014-08-18T00:40:36	7	18	6	6 | Barbara Santillan  | 2014-07-06 00:18:20+00:00 	3	
749	2014-08-18T00:40:36	7	18	5	6 | Barbara Santillan  | 2014-07-06 00:18:20+00:00 	3	
750	2014-08-18T00:40:36	7	18	4	1 | Pepe Avila  | 2014-07-05 00:14:21+00:00 	3	
751	2014-08-18T00:40:36	7	18	3	7 | Abigail Perez  | 2014-07-04 23:31:30+00:00 	3	
752	2014-08-18T00:40:36	7	18	2	7 | Abigail Perez  | 2014-07-04 23:30:03+00:00 	3	
753	2014-08-18T00:40:36	7	18	1	1 | Pepe Avila  | 2014-07-04 22:47:14+00:00 	3	
754	2014-08-18T01:11:55	7	10	4354	IPS	3	
755	2014-08-18T01:11:55	7	10	43242	UOCRA	3	
756	2014-08-18T01:11:55	7	10	4324	UTHGRA	3	
757	2014-08-18T01:11:55	7	10	3242	OSPEcom	3	
758	2014-08-18T01:11:55	7	10	2020	Pami	3	
759	2014-08-18T01:11:55	7	10	1567	Swiss Medical	3	
760	2014-08-18T01:11:55	7	10	1234	OSDE	3	
761	2014-08-18T01:11:55	7	10	11	UOM	3	
762	2014-08-18T01:11:55	7	10	1	OSECAC	3	
763	2014-08-18T02:02:04	7	10	000	Particular	1	
764	2014-08-18T02:02:21	7	10	15463	IPS	1	
765	2014-08-18T02:02:36	7	11	93	fabio | Particular	1	
766	2014-08-18T02:20:33	7	12	13	aablalalq	2	No ha modificado ningún campo.
767	2014-08-18T02:20:37	7	12	14	fdsfsdafsd	1	
768	2014-08-18T15:16:06	7	10	0303	OSECAC	3	
769	2014-08-19T00:01:28	7	11	105	paciente1 | Swiss Medical	1	
770	2014-09-04T01:20:15	7	15	117	117 | 2014-09-15 	3	
771	2014-09-04T01:20:15	7	15	116	116 | 2014-08-26 	3	
772	2014-09-04T01:20:15	7	15	115	115 | 2014-09-01 	3	
773	2014-09-04T01:20:15	7	15	114	114 | 2014-09-08 	3	
774	2014-09-04T01:20:15	7	15	113	113 | 2014-08-25 	3	
775	2014-09-04T01:20:15	7	15	112	112 | 2014-08-29 	3	
776	2014-09-04T01:20:15	7	15	111	111 | 2014-09-01 	3	
777	2014-09-04T01:20:15	7	15	110	110 | 2014-08-26 	3	
778	2014-09-04T01:20:15	7	15	109	109 | 2014-08-27 	3	
779	2014-09-04T01:20:15	7	15	108	108 | 2014-08-22 	3	
780	2014-09-04T01:20:15	7	15	107	107 | 2014-08-21 	3	
781	2014-09-04T01:20:15	7	15	106	106 | 2014-08-20 	3	
782	2014-09-04T01:20:15	7	15	105	105 | 2014-09-01 	3	
783	2014-09-04T01:20:15	7	15	104	104 | 2014-08-25 	3	
784	2014-09-04T01:20:15	7	15	103	103 | 2014-08-11 	3	
785	2014-09-04T01:20:15	7	15	102	102 | 2014-08-12 	3	
786	2014-09-04T01:20:15	7	15	101	101 | 2014-08-04 	3	
787	2014-09-04T01:20:15	7	15	100	100 | 2014-08-04 	3	
788	2014-09-04T01:20:15	7	15	99	99 | 2014-07-15 	3	
789	2014-09-04T01:20:15	7	15	98	98 | 2014-07-14 	3	
790	2014-09-04T01:20:15	7	15	97	97 | 2014-07-10 	3	
791	2014-09-04T01:20:15	7	15	96	96 | 2014-07-16 	3	
792	2014-09-04T01:20:15	7	15	95	95 | 2014-07-09 	3	
793	2014-09-04T01:20:15	7	15	94	94 | 2014-07-14 	3	
794	2014-09-04T03:05:07	7	10	78797	|fasdfasd	3	
795	2014-09-04T03:05:07	7	10	65465	qqweq	3	
796	2014-09-04T03:05:07	7	10	465	dfsfas	3	
797	2014-09-04T14:01:44	7	26	E001	E001 - fasdfasdf	3	
798	2014-09-04T14:01:44	7	26	C003	C003 - tew	3	
799	2014-09-04T14:01:44	7	26	C001	C001 - uhunqq	3	
800	2014-09-04T14:01:44	7	26	B004	B004 - opipip	3	
801	2014-09-04T14:01:44	7	26	B003	B003 - qwerqwerqwe	3	
802	2014-09-04T14:01:44	7	26	B001	B001 - sdfas fsdfadf	3	
803	2014-09-04T14:01:44	7	26	A004	A004 - qtret	3	
804	2014-09-04T14:02:22	7	32	10	eteteqtq qtweasa	3	
805	2014-09-04T14:02:22	7	32	9	ououoku uoukuuk	3	
806	2014-09-04T14:02:22	7	32	8	jujuju jtjtj	3	
807	2014-09-04T14:02:22	7	32	7	aallylylylyylfgfh adafq	3	
808	2014-09-04T14:02:22	7	32	6	ttqtqtqt qfqfqeasas	3	
809	2014-09-04T14:02:22	7	32	5	qfqfqf fqqffasdfa	3	
810	2014-09-04T14:02:22	7	32	4	fdsaf fasd	3	
811	2014-09-04T14:02:22	7	32	3	fdsafda fdsfasd	3	
812	2014-09-04T14:02:22	7	32	2	fdasf fsdaf	3	
813	2014-09-04T14:03:02	7	30	10	Analisis Clinicos - 01 . 007	3	
814	2014-09-04T14:03:02	7	30	9	Analisis Clinicos - 01 . 006	3	
815	2014-09-04T14:03:02	7	30	8	Analisis Clinicos - 01 . 004	3	
816	2014-09-04T14:03:02	7	30	7	Analisis Clinicos - 01 . 005	3	
817	2014-09-04T14:03:02	7	30	5	Analisis Clinicos - 00 . 005	3	
818	2014-09-04T14:03:02	7	30	4	Analisis Clinicos - 00 . 003	3	
819	2014-09-04T14:03:02	7	30	3	Analisis Clinicos - 01 . 001	3	
820	2014-09-04T14:03:02	7	30	2	Analisis Clinicos - 00 . 002	3	
821	2014-09-04T14:03:02	7	30	1	Analisis Clinicos - 00 . 001	3	
822	2014-09-04T14:03:16	7	28	13	13-abigail 	3	
823	2014-09-04T14:03:16	7	28	12	12-carlita 	3	
824	2014-09-04T14:03:16	7	28	11	11-fabio 	3	
825	2014-09-04T14:03:16	7	28	10	10-pepe 	3	
826	2014-09-04T14:03:16	7	28	9	9-pepe 	3	
827	2014-09-04T14:03:16	7	28	8	8-fabio 	3	
828	2014-09-04T14:03:16	7	28	7	7-pepe 	3	
829	2014-09-04T14:03:16	7	28	6	6-jose 	3	
830	2014-09-04T14:03:16	7	28	5	5-fabio 	3	
831	2014-09-04T14:03:16	7	28	4	4-euge 	3	
832	2014-09-04T14:03:16	7	28	3	3-carlita 	3	
833	2014-09-04T14:03:16	7	28	2	2-pepe 	3	
834	2014-09-04T14:03:33	7	33	25	25-pepe 	3	
835	2014-09-04T14:03:33	7	33	24	24-fabio 	3	
836	2014-09-04T14:03:33	7	33	23	23-fabio 	3	
837	2014-09-04T14:03:33	7	33	22	22-jose 	3	
838	2014-09-04T14:03:33	7	33	21	21-pepe 	3	
839	2014-09-04T14:03:33	7	33	20	20-fabio 	3	
840	2014-09-04T14:03:33	7	33	19	19-euge 	3	
841	2014-09-04T14:04:10	7	27	26	Laboratorio object	3	
842	2014-09-04T14:04:10	7	27	25	Laboratorio object	3	
843	2014-09-04T14:04:10	7	27	24	Laboratorio object	3	
844	2014-09-04T14:04:10	7	27	21	Laboratorio object	3	
845	2014-09-04T14:04:10	7	27	19	Laboratorio object	3	
846	2014-09-04T14:04:10	7	27	16	Laboratorio object	3	
847	2014-09-04T14:04:10	7	27	15	Laboratorio object	3	
848	2014-09-04T14:04:10	7	27	14	Laboratorio object	3	
849	2014-09-04T14:04:10	7	27	13	Laboratorio object	3	
850	2014-09-04T14:04:10	7	27	12	Laboratorio object	3	
851	2014-09-04T14:04:10	7	27	10	Laboratorio object	3	
852	2014-09-04T14:04:10	7	27	9	Laboratorio object	3	
853	2014-09-04T14:04:10	7	27	7	Laboratorio object	3	
854	2014-09-04T14:04:10	7	27	6	Laboratorio object	3	
855	2014-09-04T14:04:10	7	27	5	Laboratorio object	3	
856	2014-09-04T14:04:10	7	27	4	Laboratorio object	3	
857	2014-09-04T14:04:10	7	27	3	Laboratorio object	3	
858	2014-09-04T14:04:10	7	27	1	Laboratorio object	3	
859	2014-09-04T14:04:39	7	26	A003	A003 - fdsafdfad	3	
860	2014-09-06T18:19:31	7	32	1	Amoxicilina fdsaf	3	
861	2014-09-06T19:41:21	7	29	14	Especializadas - 14	1	
862	2014-09-06T19:41:39	7	29	15	Especializadas - 15	1	
863	2014-09-06T19:41:48	7	29	16	Analisis Clinicos - 16	1	
864	2014-09-06T19:42:21	7	29	08	Analisis Clinicos - 08	1	
865	2014-09-06T19:43:16	7	29	174	Analisis Clinicos - 174	1	
866	2014-09-06T19:44:00	7	29	413	Analisis Clinicos - 413	1	
867	2014-09-06T19:44:25	7	29	466	Analisis Clinicos - 466	1	
868	2014-09-06T19:45:03	7	29	17	Analisis Clinicos - 17	1	
869	2014-09-06T19:45:18	7	29	18	Especializadas - 18	1	
870	2014-09-06T19:45:30	7	29	17	Especializadas - 17	2	Modifica tipo.
871	2014-09-06T19:45:40	7	29	16	Especializadas - 16	2	Modifica tipo.
872	2014-09-06T19:49:36	7	29	466	Analisis Clinicos - 466	3	
873	2014-09-06T19:49:36	7	29	413	Analisis Clinicos - 413	3	
874	2014-09-06T19:49:36	7	29	174	Analisis Clinicos - 174	3	
875	2014-09-06T19:49:36	7	29	08	Analisis Clinicos - 08	3	
876	2014-09-06T19:49:36	7	29	01	Analisis Clinicos - 01	3	
877	2014-09-06T19:50:18	7	29	00	Analisis Clinicos - 00	2	Modifica nombre_capitulo.
878	2014-09-06T19:50:29	7	29	0	Analisis Clinicos - 0	2	Modifica nro_capitulo.
879	2014-09-06T19:50:44	7	29	-	Analisis Clinicos - -	2	Modifica nro_capitulo.
880	2014-09-06T19:50:55	7	29	00	Analisis Clinicos - 00	3	
881	2014-09-06T19:50:55	7	29	0	Analisis Clinicos - 0	3	
882	2014-09-07T00:43:54	7	12	15	fdsafd	3	
883	2014-09-07T00:43:54	7	12	14	fdsfsdafsd	3	
884	2014-09-07T00:43:54	7	12	13	aablalalq	3	
885	2014-09-07T01:21:26	7	27	1	Laboratorio object	3	
886	2014-09-07T01:22:59	7	27	1	Laboratorio object	1	
887	2014-09-08T00:53:15	7	27	4	Laboratorio object	3	
888	2014-09-08T00:53:15	7	27	3	Laboratorio object	3	
889	2014-09-08T00:53:15	7	27	2	Laboratorio object	3	
890	2014-09-08T00:53:15	7	27	1	Laboratorio object	3	
891	2014-09-08T00:53:41	7	28	4	4-pepe 	3	
892	2014-09-08T00:53:41	7	28	3	3-pepe 	3	
893	2014-09-08T00:53:41	7	28	2	2-pepe 	3	
894	2014-09-08T00:53:41	7	28	1	1-pepe 	3	
895	2014-09-23T18:09:14	7	15	131	131 | 2014-09-30 	3	
896	2014-09-23T18:09:14	7	15	130	130 | 2014-09-23 	3	
897	2014-09-23T18:09:14	7	15	129	129 | 2014-10-02 	3	
898	2014-09-23T18:09:14	7	15	128	128 | 2014-10-01 	3	
899	2014-09-23T18:09:14	7	15	127	127 | 2014-09-26 	3	
900	2014-09-23T18:09:14	7	15	126	126 | 2014-09-25 	3	
901	2014-09-23T18:09:14	7	15	125	125 | 2014-09-24 	3	
902	2014-09-23T18:09:14	7	15	124	124 | 2014-10-06 	3	
903	2014-09-23T18:09:14	7	15	123	123 | 2014-09-29 	3	
904	2014-09-23T18:09:14	7	15	122	122 | 2014-09-05 	3	
905	2014-09-23T18:09:14	7	15	121	121 | 2014-09-04 	3	
906	2014-09-23T18:09:14	7	15	120	120 | 2014-09-17 	3	
907	2014-09-23T18:09:14	7	15	119	119 | 2014-09-03 	3	
908	2014-09-23T18:09:14	7	15	118	118 | 2014-09-08 	3	
909	2014-11-12T03:13:55	7	17	6	6 | Barbara Santillan 	2	Modifica estado_civil, ocupacion, religion, padre, madre, motivo_consulta y antecedentes_enfermedad_actual.
910	2014-11-12T03:15:17	7	17	1	1 | Jose Avila 	2	Modifica ocupacion, religion, padre, madre, motivo_consulta y antecedentes_enfermedad_actual.
911	2014-11-12T03:16:19	7	21	1	Fisiologicos object	2	Modifica alimentacion, dipsia, diuresis, catarsis, sommia y observaciones.
912	2014-11-12T03:17:02	7	22	1	Patologicos object	2	Modifica infancia, adulto, especificacion, quirurgicos, catarsis, traumatologicos y alergicos.
913	2014-11-12T03:20:11	7	17	6	6 | Barbara Santillan 	3	
914	2014-12-02T14:34:45	7	18	27	11 | Barbara Santillan  | 2014-11-28 17:57:07+00:00 	3	
915	2014-12-02T14:34:45	7	18	26	11 | Barbara Santillan  | 2014-11-28 17:56:54+00:00 	3	
916	2014-12-02T14:34:45	7	18	25	11 | Barbara Santillan  | 2014-11-28 17:56:41+00:00 	3	
917	2014-12-02T14:34:45	7	18	23	11 | Barbara Santillan  | 2014-11-28 17:29:31+00:00 	3	
918	2014-12-02T14:34:45	7	18	22	7 | Abigail Perez  | 2014-11-18 14:15:12+00:00 	3	
919	2014-12-02T14:34:45	7	18	21	1 | Jose Avila  | 2014-11-10 15:10:02+00:00 	3	
920	2014-12-02T14:34:45	7	18	20	3 | Carla Chocobar  | 2014-09-06 19:32:06+00:00 	3	
921	2014-12-02T14:34:45	7	18	19	1 | Jose Avila  | 2014-09-06 19:14:52+00:00 	3	
922	2014-12-02T14:34:45	7	18	18	1 | Jose Avila  | 2014-09-06 18:39:59+00:00 	3	
923	2014-12-02T14:34:45	7	18	17	1 | Jose Avila  | 2014-08-26 03:31:06+00:00 	3	
924	2014-12-02T14:34:45	7	18	14	7 | Abigail Perez  | 2014-08-26 02:31:50+00:00 	3	
925	2014-12-02T14:34:45	7	18	13	3 | Carla Chocobar  | 2014-08-26 02:30:33+00:00 	3	
926	2014-12-02T14:34:45	7	18	12	2 | Fabio G Rodriguez  | 2014-08-26 00:59:28+00:00 	3	
927	2014-12-02T14:34:45	7	18	11	1 | Jose Avila  | 2014-08-25 00:01:09+00:00 	3	
928	2014-12-02T14:34:45	7	18	10	1 | Jose Avila  | 2014-08-24 23:57:38+00:00 	3	
929	2014-12-02T14:34:46	7	18	9	4 | Jose Lopez  | 2014-08-21 05:28:14+00:00 	3	
930	2014-12-02T14:34:46	7	18	8	1 | Jose Avila  | 2014-08-19 02:16:53+00:00 	3	
931	2014-12-02T14:34:46	7	18	7	2 | Fabio G Rodriguez  | 2014-08-19 02:06:49+00:00 	3	
932	2014-12-02T14:34:46	7	18	6	1 | Jose Avila  | 2014-08-18 18:24:44+00:00 	3	
933	2014-12-02T14:34:46	7	18	5	9 | Eugenia Perez  | 2014-08-18 18:08:11+00:00 	3	
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA;
--

COPY "django_content_type" ("id", "name", "app_label", "model") FROM stdin;
1	permission	auth	permission
2	group	auth	group
3	user	auth	user
4	content type	contenttypes	contenttype
5	session	sessions	session
6	site	sites	site
7	log entry	admin	logentry
8	perfil usuario	home	perfilusuario
9	medico	home	medico
10	obra social	turnos	obrasocial
11	afiliados os	turnos	afiliadosos
12	especialidad	turnos	especialidad
13	especialidades medicos	turnos	especialidadesmedicos
14	agenda	turnos	agenda
15	dia atencion	turnos	diaatencion
16	turno	turnos	turno
17	historia clinica	HistoriaClinica	historiaclinica
18	consulta medica	HistoriaClinica	consultamedica
19	habitos toxicos	HistoriaClinica	habitostoxicos
20	examen fisico	HistoriaClinica	examenfisico
21	fisiologicos	HistoriaClinica	fisiologicos
22	patologicos	HistoriaClinica	patologicos
24	perinatales	HistoriaClinica	perinatales
26	cie10	HistoriaClinica	cie10
27	laboratorio	HistoriaClinica	laboratorio
28	practica medica	HistoriaClinica	practicamedica
29	capitulos inos	HistoriaClinica	capitulosinos
30	inos	HistoriaClinica	inos
31	practica detalle	HistoriaClinica	practicadetalle
32	vademecum	HistoriaClinica	vademecum
33	receta	HistoriaClinica	receta
34	receta detalle	HistoriaClinica	recetadetalle
\.


--
-- Data for Name: django_session; Type: TABLE DATA;
--

COPY "django_session" ("session_key", "session_data", "expire_date") FROM stdin;
15d1906b2bd86d230d1f2f7e024595a2	NTYyOGUyYTNkMjllZTY3MDVlMjE3OGUwODMwNWYxYzY3MTBlYmVlNTqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQSKAQd1Lg==\n	2013-09-23T13:57:32
2a4ea03b05612f9fc5f744b598d9a727	NWNmY2MxZGU4NDQ2MDg1NzZlYjE3NTNlNDI3NjllYTJkZWNiMjdhNDqAAn1xAS4=\n	2013-09-23T01:41:13
33ab57f939cedb38b2650a86cc37818e	NTYyOGUyYTNkMjllZTY3MDVlMjE3OGUwODMwNWYxYzY3MTBlYmVlNTqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQSKAQd1Lg==\n	2013-10-03T14:19:21
3e8c3c7a085c8d794da8d015048eb044	NTYyOGUyYTNkMjllZTY3MDVlMjE3OGUwODMwNWYxYzY3MTBlYmVlNTqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQSKAQd1Lg==\n	2014-08-18T05:09:26
48da7f0d8a920bf33bfa599c3b8c8755	NTYyOGUyYTNkMjllZTY3MDVlMjE3OGUwODMwNWYxYzY3MTBlYmVlNTqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQSKAQd1Lg==\n	2014-09-08T03:26:53
49c804962f716c308a92147eab365b75	ZjlkZjNmY2MxOTA2N2NhMGUwZjk1MDNhZmY2ZWU5ZjgwZjNlMTdmMTqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQSKARF1Lg==\n	2014-08-13T00:35:56
4bc88c02601036246d2252d1b0207297	NWNmY2MxZGU4NDQ2MDg1NzZlYjE3NTNlNDI3NjllYTJkZWNiMjdhNDqAAn1xAS4=\n	2014-09-08T03:42:10
4f2891d7b10e461d5e6aca05dc5f4f22	M2RlMjQ1YmI3ZjM4YzU4MjQ2ZDNiMDZhMzdlODIxOWUzNGJlZTRjNjqAAn1xAShVCnRlc3Rjb29r\naWVVBndvcmtlZFUSX2F1dGhfdXNlcl9iYWNrZW5kcQJVKWRqYW5nby5jb250cmliLmF1dGguYmFj\na2VuZHMuTW9kZWxCYWNrZW5kcQNVDV9hdXRoX3VzZXJfaWRxBIoBB3Uu\n	2014-08-18T17:09:00
5aae30d5895b53874e540513d1b439e4	NTYyOGUyYTNkMjllZTY3MDVlMjE3OGUwODMwNWYxYzY3MTBlYmVlNTqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQSKAQd1Lg==\n	2014-08-18T16:50:22
6979b818c2f4c29f41af118b3ba8f8ec	NWNmY2MxZGU4NDQ2MDg1NzZlYjE3NTNlNDI3NjllYTJkZWNiMjdhNDqAAn1xAS4=\n	2014-12-02T14:22:50
72d21c83c9eeae149d96c316a2e4e840	ZjlkZjNmY2MxOTA2N2NhMGUwZjk1MDNhZmY2ZWU5ZjgwZjNlMTdmMTqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQSKARF1Lg==\n	2014-07-21T14:56:01
74d75b71033d6da8f15c95eb2902331f	NTYyOGUyYTNkMjllZTY3MDVlMjE3OGUwODMwNWYxYzY3MTBlYmVlNTqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQSKAQd1Lg==\n	2014-09-21T01:20:56
7e740fc8b999b2990817eabdb35508af	YzExY2U1MzdjNDc5ZTEwNzkxZjQ3OTUwNmVhYTY0MGFlMDhmODNlMDqAAn1xAVUKdGVzdGNvb2tp\nZXECVQZ3b3JrZWRxA3Mu\n	2014-03-25T17:52:55
806b8a98d0e976b3cb489947be4868b0	NTYyOGUyYTNkMjllZTY3MDVlMjE3OGUwODMwNWYxYzY3MTBlYmVlNTqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQSKAQd1Lg==\n	2014-09-22T00:52:06
8078f5820694ffbf212f8ec04f79bb65	NTYyOGUyYTNkMjllZTY3MDVlMjE3OGUwODMwNWYxYzY3MTBlYmVlNTqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQSKAQd1Lg==\n	2013-09-28T21:04:40
82005a61d830bf559a0c30cea7ff54bf	NTYyOGUyYTNkMjllZTY3MDVlMjE3OGUwODMwNWYxYzY3MTBlYmVlNTqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQSKAQd1Lg==\n	2013-09-23T13:01:34
848239abbfc572fe1af2a7b7b4e8ea73	NTYyOGUyYTNkMjllZTY3MDVlMjE3OGUwODMwNWYxYzY3MTBlYmVlNTqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQSKAQd1Lg==\n	2014-03-03T02:51:31
858f3e63ff06893ce5c10ab3221b9479	NTYyOGUyYTNkMjllZTY3MDVlMjE3OGUwODMwNWYxYzY3MTBlYmVlNTqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQSKAQd1Lg==\n	2014-08-14T00:24:37
89fc103220412d1902c3f5e13095ad68	NTYyOGUyYTNkMjllZTY3MDVlMjE3OGUwODMwNWYxYzY3MTBlYmVlNTqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQSKAQd1Lg==\n	2014-08-18T17:00:41
8f07879265ad3f6a898e0c5d0ddc3151	NTYyOGUyYTNkMjllZTY3MDVlMjE3OGUwODMwNWYxYzY3MTBlYmVlNTqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQSKAQd1Lg==\n	2015-06-24T13:52:11
a43fc8a4ebed00af2041b5b81b6fbc05	NTYyOGUyYTNkMjllZTY3MDVlMjE3OGUwODMwNWYxYzY3MTBlYmVlNTqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQSKAQd1Lg==\n	2014-07-16T21:14:37
abf949149ba6028dc12a5059901ffb24	NTYyOGUyYTNkMjllZTY3MDVlMjE3OGUwODMwNWYxYzY3MTBlYmVlNTqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQSKAQd1Lg==\n	2014-03-15T01:50:13
b0082e394840f2065320acbec987a9e9	NTYyOGUyYTNkMjllZTY3MDVlMjE3OGUwODMwNWYxYzY3MTBlYmVlNTqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQSKAQd1Lg==\n	2014-09-01T02:01:24
c725f8b7fc6f52b11cb2e621ba6f59ef	NTYyOGUyYTNkMjllZTY3MDVlMjE3OGUwODMwNWYxYzY3MTBlYmVlNTqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQSKAQd1Lg==\n	2014-04-18T17:37:14
c763e1428076c254fcabceebdb1da7fd	M2RlMjQ1YmI3ZjM4YzU4MjQ2ZDNiMDZhMzdlODIxOWUzNGJlZTRjNjqAAn1xAShVCnRlc3Rjb29r\naWVVBndvcmtlZFUSX2F1dGhfdXNlcl9iYWNrZW5kcQJVKWRqYW5nby5jb250cmliLmF1dGguYmFj\na2VuZHMuTW9kZWxCYWNrZW5kcQNVDV9hdXRoX3VzZXJfaWRxBIoBB3Uu\n	2014-05-05T13:40:07
cb347b9e4f4eead13bf5364dee50ccb6	NTYyOGUyYTNkMjllZTY3MDVlMjE3OGUwODMwNWYxYzY3MTBlYmVlNTqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQSKAQd1Lg==\n	2016-04-17T22:30:42
d08dbf56f86e6e16002988cbc1ae8ea8	NWNmY2MxZGU4NDQ2MDg1NzZlYjE3NTNlNDI3NjllYTJkZWNiMjdhNDqAAn1xAS4=\n	2014-09-05T03:32:39
d57dc80515d3f8a8b873f33a6c4927da	NDAzODY4NDc5YTE4MTdhZGVhZjljZDdmMjljN2JmZDZkMmRkNjAyMzqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQSKARJ1Lg==\n	2014-03-20T03:27:04
d8cb9737eae7025dbb44a93b79ee05a6	NTYyOGUyYTNkMjllZTY3MDVlMjE3OGUwODMwNWYxYzY3MTBlYmVlNTqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQSKAQd1Lg==\n	2014-05-03T20:29:43
dc4b33555d59ccba58acfd59412d7a31	NTYyOGUyYTNkMjllZTY3MDVlMjE3OGUwODMwNWYxYzY3MTBlYmVlNTqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQSKAQd1Lg==\n	2014-06-22T22:00:58
de67b76b8855a9979bb956c45a03f517	MTU5YmIyY2Q1OWI0ZTY1MTU4ZTMzYzkyZmFmZjFiYjVjN2YxN2YxYTqAAn1xAShVCnRlc3Rjb29r\naWVVBndvcmtlZHECVQ1fYXV0aF91c2VyX2lkigERVRJfYXV0aF91c2VyX2JhY2tlbmRVKWRqYW5n\nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kdS4=\n	2014-06-26T01:45:11
e50df0d949d6ac3f70b82f2f80197777	NmRiYzE4YWM5MTAxNDg2MmVhOWU0YjQzZGI5ZWEyY2ZhOWRjNWE2ODqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQSKARp1Lg==\n	2014-12-22T15:48:26
ec2f4b770a6a5f18a4b6b1205e19d9dd	NTYyOGUyYTNkMjllZTY3MDVlMjE3OGUwODMwNWYxYzY3MTBlYmVlNTqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQSKAQd1Lg==\n	2013-10-03T02:50:46
f24f70cb5f554699f40ff1d3ee2d6cd5	NTYyOGUyYTNkMjllZTY3MDVlMjE3OGUwODMwNWYxYzY3MTBlYmVlNTqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQSKAQd1Lg==\n	2013-09-24T01:18:46
f6599d88031f5ecf84533b43f66931e2	NTYyOGUyYTNkMjllZTY3MDVlMjE3OGUwODMwNWYxYzY3MTBlYmVlNTqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQSKAQd1Lg==\n	2014-10-07T19:18:23
\.


--
-- Data for Name: django_site; Type: TABLE DATA;
--

COPY "django_site" ("id", "domain", "name") FROM stdin;
1	example.com	example.com
\.


--
-- Data for Name: home_medico; Type: TABLE DATA;
--

COPY "home_medico" ("user_id", "matricula", "cuit", "estado") FROM stdin;
17	1	10	t
7	10	10	t
26	1515	1213	t
18	232	32	t
28	253	25555	t
27	4002	32039	t
19	456654	45645	f
44	66	66	f
45	fdasfasdfas	asd	t
20	fdsaf	asd	f
\.


--
-- Data for Name: home_perfilusuario; Type: TABLE DATA;
--

COPY "home_perfilusuario" ("user_id", "dni", "tipo", "sexo", "photo", "telefono", "direccion", "fecha_nacimiento") FROM stdin;
26	1	DNI	M	MultimediaData/Users/jose/fer120.jpg	1453424342	432423	1910-01-26
20	12121	DNI	F	MultimediaData/Users/barby/Screenshot_3.png	4342	fdsaf	2003-01-14
7	12312345	DNI	M	MultimediaData/Users/root/santiago.jpg	12313231	las heras	1999-08-31
46	1564655			MultimediaData/Users/anonimo.jpg			1900-01-01
27	21		M	MultimediaData/Users/jobs/large_511_1.png	323	edwqdq	1900-01-01
28	212321313		F	MultimediaData/Users/carlita/images (1).jpg	4543543	los tilos 192	1920-01-02
58	23100201		M	MultimediaData/Users/anonimo.jpg	4392032	los crespones 600	1987-01-08
56	28164564		M	MultimediaData/Users/juan/karucha120.jpg	4395062	los tilos 200	1988-01-20
57	29008109			MultimediaData/Users/anonimo.jpg			1900-01-01
29	3246688	DNI	M	MultimediaData/Users/paciente1/large_992921.png	43655	cordoba 152	1910-01-18
61	325689464			MultimediaData/Users/anonimo.jpg			1900-01-01
44	3569685	DNI	M	MultimediaData/Users/anonimo.jpg	4356898	pinos 256	1970-01-14
18	42342	DNI	M	MultimediaData/Users/pepe/josx120.jpg	43421	43242222	1977-01-05
17	432421	DNI	M	MultimediaData/Users/fabio/large_1459_4.png	4353	fsfs	1908-01-08
59	4343243	DNI	M	MultimediaData/Users/anonimo.jpg	34234223	fasdf	1900-01-01
19	43434343	DNI	F	MultimediaData/Users/abigail/Screenshot_1.png	43423	32423fdsafsdf	1980-02-14
30	45646	DNI	M	MultimediaData/Users/anonimo.jpg	468	5465	1995-01-11
47	456543			MultimediaData/Users/anonimo.jpg			1900-01-01
52	465			MultimediaData/Users/anonimo.jpg			1900-01-01
55	46546			MultimediaData/Users/anonimo.jpg			1900-01-01
49	48564			MultimediaData/Users/anonimo.jpg			1900-01-01
48	49789789			MultimediaData/Users/anonimo.jpg			1900-01-01
31	546465			MultimediaData/Users/anonimo.jpg			1900-01-01
45	5646546			MultimediaData/Users/anonimo.jpg			1900-01-01
60	5987946		M	MultimediaData/Users/anonimo.jpg	46855989	4654664	1900-01-01
54	879			MultimediaData/Users/anonimo.jpg			1900-01-01
50	98798	DNI	M	MultimediaData/Users/anonimo.jpg	4546	465465	1900-01-01
51	987983	DNI	M	MultimediaData/Users/anonimo.jpg	465	546	1900-01-01
53	987988788			MultimediaData/Users/anonimo.jpg			1900-01-01
\.


--
-- Data for Name: turnos_afiliadosos; Type: TABLE DATA;
--

COPY "turnos_afiliadosos" ("id", "afiliado_id", "obrasocial_id", "beneficiario", "titular", "estado") FROM stdin;
94	18	000	0202	111	t
95	18	15463	xxxxxc	xxxx	t
98	20	15463	1231	321313	t
99	19	000	4654	46546	t
100	26	000	12354	3544	t
102	28	000	2132	13213	t
103	44	98798	xx	xxx	f
104	30	000	kk	kkk	f
105	29	98798	222	222	t
107	17	000	xxxx	xxx	t
108	17	98798	ewr	rweq	f
109	26	15463	01012	12132	f
110	18	341564	88	888	t
111	56	341564	446566	12131	t
112	7	15463	46546	465465	t
113	28	15463	56411	13255	t
\.


--
-- Data for Name: turnos_agenda; Type: TABLE DATA;
--

COPY "turnos_agenda" ("id", "prestador_id", "dia", "dia_nombre", "hora_inicial", "hora_final", "duracion", "cant_turnos", "estado") FROM stdin;
53	32	0	Lunes	08:00:00	12:00:00	15	\N	t
58	20	3	Jueves	08:00:00	10:00:00	15	10	t
60	20	0	Lunes	08:00:00	10:00:00	20	\N	t
61	25	0	Lunes	09:00:00	12:00:00	15	10	t
63	30	0	Lunes	08:00:00	10:00:00	20	\N	t
65	20	2	Miercoles	08:00:00	12:00:00	15	\N	t
66	20	4	Viernes	09:00:00	13:00:00	25	5	t
67	33	0	Lunes	12:00:00	16:00:00	30	\N	t
68	32	1	Martes	08:00:00	12:00:00	15	\N	t
69	32	2	Miercoles	09:00:00	11:00:00	15	\N	t
70	32	3	Jueves	16:00:00	20:00:00	15	\N	t
71	34	0	Lunes	08:00:00	12:00:00	15	\N	t
72	34	1	Martes	12:00:00	16:00:00	15	\N	t
73	34	2	Miercoles	12:00:00	16:00:00	15	\N	t
75	36	1	Martes	08:30:00	12:00:00	15	\N	t
76	20	1	Martes	08:00:00	12:00:00	15	\N	t
77	32	4	Viernes	08:00:00	12:00:00	15	\N	t
\.


--
-- Data for Name: turnos_diaatencion; Type: TABLE DATA;
--

COPY "turnos_diaatencion" ("id", "prestador_id", "fecha", "hora_inicial", "observacion") FROM stdin;
132	20	2014-09-29	08:00:00	
133	20	2014-09-23	08:00:00	
134	20	2014-09-24	08:00:00	
135	20	2014-09-25	08:00:00	
136	20	2014-09-26	09:00:00	
137	20	2014-10-06	08:00:00	
138	20	2014-09-30	08:00:00	
139	20	2014-10-27	08:00:00	
140	20	2014-11-04	08:00:00	
141	20	2014-11-05	08:00:00	
142	20	2014-11-17	08:00:00	
143	20	2014-11-11	08:00:00	
144	20	2014-11-12	08:00:00	
145	20	2014-11-13	08:00:00	
146	20	2014-11-20	08:00:00	
147	20	2014-11-14	09:00:00	
148	34	2014-11-17	08:00:00	
149	20	2014-11-24	08:00:00	
150	20	2014-11-25	08:00:00	
151	20	2014-11-19	08:00:00	
152	20	2014-11-26	08:00:00	
153	20	2014-11-27	08:00:00	
154	20	2014-11-21	09:00:00	
155	20	2014-11-28	09:00:00	
156	20	2014-11-18	08:00:00	
157	32	2014-11-24	08:00:00	
158	32	2014-12-01	15:00:00	
159	32	2014-11-18	08:00:00	
160	32	2014-11-19	09:00:00	
161	32	2014-11-20	16:00:00	
162	20	2015-06-10	08:00:00	
163	20	2015-06-11	08:00:00	
164	20	2015-06-12	09:00:00	
165	20	2015-06-15	08:00:00	
166	20	2015-06-16	08:00:00	
167	20	2015-06-17	08:00:00	
168	32	2015-06-10	09:00:00	
169	32	2015-06-11	16:00:00	
170	32	2015-06-12	08:00:00	
171	32	2015-06-15	08:00:00	
172	20	2016-04-11	08:00:00	
173	20	2016-04-12	08:00:00	
\.


--
-- Data for Name: turnos_especialidad; Type: TABLE DATA;
--

COPY "turnos_especialidad" ("id", "nombre", "estado") FROM stdin;
1	Traumatologia	t
2	Clinico	t
3	Reumatologia	t
4	Cardiologia	f
5	Infectología	f
6	Endocrinología	f
7	Nutriología	t
8	Pediatría	f
9	Oncologia	f
12	Kinesiologia	f
16	Neurología	t
17	Oftalmología	t
\.


--
-- Data for Name: turnos_especialidadesmedicos; Type: TABLE DATA;
--

COPY "turnos_especialidadesmedicos" ("id", "medico_id", "especialidad_id", "fecha_habilitacion", "fecha_caducacion", "estado") FROM stdin;
20	1	1	2014-02-16	1990-12-12	t
25	1	9	2014-02-16	\N	t
28	232	4	2014-02-18	\N	f
29	1	12	2014-02-23	\N	t
30	4002	2	2014-02-24	\N	t
31	1	8	2014-02-25	\N	t
32	4002	1	2014-03-20	\N	t
33	253	7	2014-04-19	\N	t
34	10	5	2014-07-02	\N	t
35	66	1	2014-08-18	\N	t
36	10	12	2014-08-21	\N	t
37	1515	4	2014-12-08	\N	t
\.


--
-- Data for Name: turnos_obrasocial; Type: TABLE DATA;
--

COPY "turnos_obrasocial" ("cuit", "nombre", "domicilio", "telefono", "estado") FROM stdin;
000	Particular	-	-	t
03033	OSECAC	xxxxxxxxxxxx	xxxxxxx	t
12331	COSECAC	xx	xx	t
12456	OSDOP	xxxxx	xxxxxx	t
15463	IPS	xxxxx	xxxxx	t
31321	OSYPF	xxxxxxxxx	xxxxxxx	t
341564	OSDE	xxxxx	xxxxx	t
46546	ASE	xxxxxxxxxxx	xxxxxxx	t
979878	OSDOP	xxxxx	xxxxx	t
98798	Swiss Medical	xxxxxxx	xxxxxx	t
\.


--
-- Data for Name: turnos_turno; Type: TABLE DATA;
--

COPY "turnos_turno" ("id", "paciente_id", "dia_atencion_id", "hora_turno", "fecha_creacion", "observacion", "sede") FROM stdin;
1072	\N	132	08:00:00	\N		\N
1073	\N	132	08:20:00	\N		\N
1074	\N	132	08:40:00	\N		\N
1075	\N	132	09:00:00	\N		\N
1076	\N	132	09:20:00	\N		\N
1077	\N	132	09:40:00	\N		\N
1078	19	133	08:00:00	2014-09-23		\N
1079	\N	133	08:15:00	\N		\N
1080	\N	133	08:30:00	\N		\N
1081	\N	133	08:45:00	\N		\N
1082	\N	133	09:00:00	\N		\N
1083	\N	133	09:15:00	\N		\N
1084	\N	133	09:30:00	\N		\N
1085	\N	133	09:45:00	\N		\N
1086	\N	133	10:00:00	\N		\N
1087	\N	133	10:15:00	\N		\N
1088	\N	133	10:30:00	\N		\N
1089	\N	133	10:45:00	\N		\N
1090	\N	133	11:00:00	\N		\N
1091	\N	133	11:15:00	\N		\N
1092	\N	133	11:30:00	\N		\N
1093	\N	133	11:45:00	\N		\N
1094	\N	134	08:00:00	\N		\N
1095	\N	134	08:15:00	\N		\N
1096	\N	134	08:30:00	\N		\N
1097	\N	134	08:45:00	\N		\N
1098	\N	134	09:00:00	\N		\N
1099	\N	134	09:15:00	\N		\N
1100	\N	134	09:30:00	\N		\N
1101	\N	134	09:45:00	\N		\N
1102	\N	134	10:00:00	\N		\N
1103	\N	134	10:15:00	\N		\N
1104	\N	134	10:30:00	\N		\N
1105	\N	134	10:45:00	\N		\N
1106	\N	134	11:00:00	\N		\N
1107	\N	134	11:15:00	\N		\N
1108	\N	134	11:30:00	\N		\N
1109	\N	134	11:45:00	\N		\N
1110	\N	135	08:00:00	\N		\N
1111	\N	135	08:15:00	\N		\N
1112	\N	135	08:30:00	\N		\N
1113	\N	135	08:45:00	\N		\N
1114	\N	135	09:00:00	\N		\N
1115	\N	135	09:15:00	\N		\N
1116	\N	135	09:30:00	\N		\N
1117	\N	135	09:45:00	\N		\N
1118	\N	135	10:00:00	\N		\N
1119	\N	135	10:15:00	\N		\N
1120	\N	136	09:00:00	\N		\N
1121	\N	136	09:25:00	\N		\N
1122	\N	136	09:50:00	\N		\N
1123	\N	136	10:15:00	\N		\N
1124	\N	136	10:40:00	\N		\N
1125	\N	137	08:00:00	\N		\N
1126	\N	137	08:20:00	\N		\N
1127	\N	137	08:40:00	\N		\N
1128	\N	137	09:00:00	\N		\N
1129	\N	137	09:20:00	\N		\N
1130	\N	137	09:40:00	\N		\N
1131	\N	138	08:00:00	\N		\N
1132	\N	138	08:15:00	\N		\N
1133	\N	138	08:30:00	\N		\N
1134	\N	138	08:45:00	\N		\N
1135	\N	138	09:00:00	\N		\N
1136	\N	138	09:15:00	\N		\N
1137	\N	138	09:30:00	\N		\N
1138	\N	138	09:45:00	\N		\N
1139	\N	138	10:00:00	\N		\N
1140	\N	138	10:15:00	\N		\N
1141	\N	138	10:30:00	\N		\N
1142	\N	138	10:45:00	\N		\N
1143	\N	138	11:00:00	\N		\N
1144	\N	138	11:15:00	\N		\N
1145	\N	138	11:30:00	\N		\N
1146	\N	138	11:45:00	\N		\N
1147	\N	139	08:00:00	2014-10-26		\N
1148	\N	139	08:20:00	\N		\N
1149	\N	139	08:40:00	2014-10-26		\N
1150	\N	139	09:00:00	\N		\N
1151	\N	139	09:20:00	2014-10-26		\N
1152	19	139	09:40:00	2014-10-26		\N
1153	\N	140	08:00:00	\N		\N
1154	\N	140	08:15:00	\N		\N
1155	\N	140	08:30:00	\N		\N
1156	\N	140	08:45:00	\N		\N
1157	\N	140	09:00:00	\N		\N
1158	17	140	09:15:00	2014-10-29		\N
1159	19	140	09:30:00	2014-10-29		\N
1160	\N	140	09:45:00	\N		\N
1161	\N	140	10:00:00	\N		\N
1162	7	140	10:15:00	2014-10-29		\N
1163	\N	140	10:30:00	\N		\N
1164	\N	140	10:45:00	\N		\N
1165	\N	140	11:00:00	\N		\N
1166	\N	140	11:15:00	\N		\N
1167	\N	140	11:30:00	\N		\N
1168	\N	140	11:45:00	\N		\N
1169	\N	141	08:00:00	\N		\N
1170	\N	141	08:15:00	\N		\N
1171	\N	141	08:30:00	\N		\N
1172	\N	141	08:45:00	\N		\N
1173	\N	141	09:00:00	\N		\N
1174	\N	141	09:15:00	\N		\N
1175	\N	141	09:30:00	\N		\N
1176	\N	141	09:45:00	2014-10-26		\N
1177	19	141	10:00:00	2014-10-26		\N
1178	\N	141	10:15:00	2014-10-26		\N
1179	\N	141	10:30:00	\N		\N
1180	\N	141	10:45:00	\N		\N
1181	\N	141	11:00:00	\N		\N
1182	\N	141	11:15:00	\N		\N
1183	\N	141	11:30:00	\N		\N
1184	\N	141	11:45:00	\N		\N
1185	\N	142	08:00:00	\N		\N
1186	\N	142	08:20:00	\N		\N
1187	\N	142	08:40:00	\N		\N
1188	\N	142	09:00:00	\N		\N
1189	\N	142	09:20:00	\N		\N
1190	\N	142	09:40:00	\N		\N
1191	\N	143	08:00:00	\N		\N
1192	\N	143	08:15:00	\N		\N
1193	\N	143	08:30:00	\N		\N
1194	\N	143	08:45:00	\N		\N
1195	19	143	09:00:00	2014-11-11		\N
1196	\N	143	09:15:00	\N		\N
1197	\N	143	09:30:00	2014-11-10		\N
1198	\N	143	09:45:00	\N		\N
1199	\N	143	10:00:00	\N		\N
1200	\N	143	10:15:00	\N		\N
1201	\N	143	10:30:00	\N		\N
1202	\N	143	10:45:00	\N		\N
1203	\N	143	11:00:00	\N		\N
1204	\N	143	11:15:00	\N		\N
1205	\N	143	11:30:00	\N		\N
1206	\N	143	11:45:00	\N		\N
1207	\N	144	08:00:00	\N		\N
1208	\N	144	08:15:00	\N		\N
1209	\N	144	08:30:00	\N		\N
1210	18	144	08:45:00	2014-11-11		\N
1211	58	144	09:00:00	2014-11-11		\N
1212	19	144	09:15:00	2014-11-11		\N
1213	57	144	09:30:00	2014-11-11		\N
1214	20	144	09:45:00	2014-11-10		\N
1215	26	144	10:00:00	2014-11-11		\N
1216	\N	144	10:15:00	\N		\N
1217	\N	144	10:30:00	\N		\N
1218	\N	144	10:45:00	2014-11-11		\N
1219	59	144	11:00:00	2014-11-12		\N
1220	\N	144	11:15:00	\N		\N
1221	\N	144	11:30:00	\N		\N
1222	\N	144	11:45:00	\N		\N
1223	\N	145	08:00:00	\N		\N
1224	\N	145	08:15:00	\N		\N
1225	18	145	08:30:00	2014-11-11		\N
1226	\N	145	08:45:00	\N		\N
1227	\N	145	09:00:00	\N		\N
1228	\N	145	09:15:00	2014-11-10		\N
1229	19	145	09:30:00	2014-11-10		\N
1230	20	145	09:45:00	2014-11-10		\N
1231	58	145	10:00:00	2014-11-11		\N
1232	57	145	10:15:00	2014-11-11		\N
1233	\N	146	08:00:00	\N		\N
1234	\N	146	08:15:00	\N		\N
1235	\N	146	08:30:00	\N		\N
1236	\N	146	08:45:00	\N		\N
1237	\N	146	09:00:00	2014-11-11		\N
1238	\N	146	09:15:00	\N		\N
1239	\N	146	09:30:00	2014-11-11		\N
1240	\N	146	09:45:00	\N		\N
1241	19	146	10:00:00	2014-11-18		\N
1242	20	146	10:15:00	2014-11-10		\N
1243	20	147	09:00:00	2014-11-10		\N
1244	\N	147	09:25:00	\N		\N
1245	\N	147	09:50:00	2014-11-10		\N
1246	\N	147	10:15:00	\N		\N
1247	58	147	10:40:00	2014-11-11		\N
1248	\N	148	08:00:00	\N		\N
1249	\N	148	08:15:00	\N		\N
1250	\N	148	08:30:00	\N		\N
1251	\N	148	08:45:00	\N		\N
1252	\N	148	09:00:00	\N		\N
1253	\N	148	09:15:00	2014-11-11		\N
1254	\N	148	09:30:00	\N		\N
1255	\N	148	09:45:00	\N		\N
1256	\N	148	10:00:00	\N		\N
1257	\N	148	10:15:00	\N		\N
1258	\N	148	10:30:00	\N		\N
1259	\N	148	10:45:00	\N		\N
1260	\N	148	11:00:00	\N		\N
1261	\N	148	11:15:00	\N		\N
1262	\N	148	11:30:00	\N		\N
1263	\N	148	11:45:00	\N		\N
1264	\N	149	08:00:00	2014-11-18		\N
1265	\N	149	08:20:00	\N		\N
1266	\N	149	08:40:00	\N		\N
1267	\N	149	09:00:00	2014-11-18		\N
1268	\N	149	09:20:00	\N		\N
1269	\N	149	09:40:00	\N		\N
1270	\N	150	08:00:00	\N		\N
1271	\N	150	08:15:00	\N		\N
1272	\N	150	08:30:00	\N		\N
1273	\N	150	08:45:00	\N		\N
1274	\N	150	09:00:00	\N		\N
1275	\N	150	09:15:00	\N		\N
1276	\N	150	09:30:00	\N		\N
1277	\N	150	09:45:00	\N		\N
1278	\N	150	10:00:00	\N		\N
1279	\N	150	10:15:00	\N		\N
1280	\N	150	10:30:00	\N		\N
1281	\N	150	10:45:00	\N		\N
1282	\N	150	11:00:00	\N		\N
1283	\N	150	11:15:00	\N		\N
1284	\N	150	11:30:00	\N		\N
1285	\N	150	11:45:00	\N		\N
1286	\N	151	08:00:00	\N		\N
1287	\N	151	08:15:00	\N		\N
1288	\N	151	08:30:00	\N		\N
1289	\N	151	08:45:00	\N		\N
1290	7	151	09:00:00	2014-11-18		\N
1291	\N	151	09:15:00	\N		\N
1292	\N	151	09:30:00	\N		\N
1293	\N	151	09:45:00	\N		\N
1294	\N	151	10:00:00	\N		\N
1295	\N	151	10:15:00	\N		\N
1296	\N	151	10:30:00	\N		\N
1297	\N	151	10:45:00	\N		\N
1298	\N	151	11:00:00	\N		\N
1299	\N	151	11:15:00	\N		\N
1300	\N	151	11:30:00	\N		\N
1301	\N	151	11:45:00	\N		\N
1302	\N	152	08:00:00	\N		\N
1303	\N	152	08:15:00	\N		\N
1304	\N	152	08:30:00	\N		\N
1305	\N	152	08:45:00	\N		\N
1306	\N	152	09:00:00	2014-11-18		\N
1307	\N	152	09:15:00	\N		\N
1308	29	152	09:30:00	2014-11-18		\N
1309	\N	152	09:45:00	\N		\N
1310	\N	152	10:00:00	\N		\N
1311	\N	152	10:15:00	\N		\N
1312	\N	152	10:30:00	\N		\N
1313	\N	152	10:45:00	\N		\N
1314	\N	152	11:00:00	\N		\N
1315	\N	152	11:15:00	\N		\N
1316	\N	152	11:30:00	\N		\N
1317	\N	152	11:45:00	\N		\N
1318	\N	153	08:00:00	\N		\N
1319	\N	153	08:15:00	\N		\N
1320	\N	153	08:30:00	\N		\N
1321	\N	153	08:45:00	\N		\N
1322	\N	153	09:00:00	\N		\N
1323	\N	153	09:15:00	\N		\N
1324	\N	153	09:30:00	\N		\N
1325	\N	153	09:45:00	\N		\N
1326	\N	153	10:00:00	\N		\N
1327	\N	153	10:15:00	\N		\N
1328	\N	154	09:00:00	\N		\N
1329	\N	154	09:25:00	\N		\N
1330	\N	154	09:50:00	\N		\N
1331	\N	154	10:15:00	\N		\N
1332	\N	154	10:40:00	\N		\N
1333	7	155	09:00:00	2014-11-28		\N
1334	\N	155	09:25:00	\N		\N
1335	\N	155	09:50:00	\N		\N
1336	\N	155	10:15:00	\N		\N
1337	\N	155	10:40:00	\N		\N
1338	\N	156	08:00:00	\N		\N
1339	\N	156	08:15:00	\N		\N
1340	\N	156	08:30:00	\N		\N
1341	\N	156	08:45:00	2014-11-18		\N
1342	\N	156	09:00:00	\N		\N
1343	\N	156	09:15:00	\N		\N
1344	\N	156	09:30:00	\N		\N
1345	\N	156	09:45:00	\N		\N
1346	\N	156	10:00:00	\N		\N
1347	\N	156	10:15:00	\N		\N
1348	\N	156	10:30:00	\N		\N
1349	\N	156	10:45:00	\N		\N
1350	\N	156	11:00:00	\N		\N
1351	\N	156	11:15:00	\N		\N
1352	\N	156	11:30:00	\N		\N
1353	\N	156	11:45:00	\N		\N
1354	\N	157	08:00:00	\N		\N
1355	\N	157	08:15:00	\N		\N
1356	\N	157	08:30:00	\N		\N
1357	\N	157	08:45:00	\N		\N
1358	\N	157	09:00:00	\N		\N
1359	\N	157	09:15:00	\N		\N
1360	\N	157	09:30:00	\N		\N
1361	\N	157	09:45:00	\N		\N
1362	\N	157	10:00:00	\N		\N
1363	\N	157	10:15:00	\N		\N
1364	\N	157	10:30:00	\N		\N
1365	\N	157	10:45:00	\N		\N
1366	\N	157	11:00:00	\N		\N
1367	\N	157	11:15:00	\N		\N
1368	\N	157	11:30:00	\N		\N
1369	\N	157	11:45:00	\N		\N
1370	\N	158	15:00:00	\N		\N
1371	\N	158	15:15:00	\N		\N
1372	\N	158	15:30:00	\N		\N
1373	\N	158	15:45:00	\N		\N
1374	\N	159	08:00:00	\N		\N
1375	\N	159	08:15:00	\N		\N
1376	\N	159	08:30:00	\N		\N
1377	\N	159	08:45:00	\N		\N
1378	\N	159	09:00:00	\N		\N
1379	\N	159	09:15:00	\N		\N
1380	\N	159	09:30:00	\N		\N
1381	\N	159	09:45:00	\N		\N
1382	\N	159	10:00:00	\N		\N
1383	\N	159	10:15:00	\N		\N
1384	\N	159	10:30:00	\N		\N
1385	\N	159	10:45:00	\N		\N
1386	\N	159	11:00:00	\N		\N
1387	\N	159	11:15:00	\N		\N
1388	\N	159	11:30:00	\N		\N
1389	\N	159	11:45:00	\N		\N
1390	\N	160	09:00:00	\N		\N
1391	\N	160	09:15:00	\N		\N
1392	\N	160	09:30:00	\N		\N
1393	\N	160	09:45:00	\N		\N
1394	\N	160	10:00:00	\N		\N
1395	\N	160	10:15:00	\N		\N
1396	\N	160	10:30:00	\N		\N
1397	\N	160	10:45:00	\N		\N
1398	\N	161	16:00:00	\N		\N
1399	\N	161	16:15:00	\N		\N
1400	\N	161	16:30:00	\N		\N
1401	\N	161	16:45:00	\N		\N
1402	\N	161	17:00:00	\N		\N
1403	\N	161	17:15:00	\N		\N
1404	\N	161	17:30:00	\N		\N
1405	\N	161	17:45:00	\N		\N
1406	\N	161	18:00:00	\N		\N
1407	\N	161	18:15:00	\N		\N
1408	\N	161	18:30:00	\N		\N
1409	\N	161	18:45:00	\N		\N
1410	\N	161	19:00:00	\N		\N
1411	\N	161	19:15:00	\N		\N
1412	\N	161	19:30:00	\N		\N
1413	\N	161	19:45:00	\N		\N
1414	\N	162	08:00:00	\N		\N
1415	\N	162	08:15:00	\N		\N
1416	\N	162	08:30:00	\N		\N
1417	7	162	08:45:00	2015-06-10		\N
1418	\N	162	09:00:00	\N		\N
1419	\N	162	09:15:00	\N		\N
1420	26	162	09:30:00	2015-06-09		\N
1421	\N	162	09:45:00	\N		\N
1422	\N	162	10:00:00	\N		\N
1423	\N	162	10:15:00	\N		\N
1424	18	162	10:30:00	2015-06-09		\N
1425	30	162	10:45:00	2015-06-09		\N
1426	29	162	11:00:00	2015-06-09		\N
1427	28	162	11:15:00	2015-06-09		\N
1428	\N	162	11:30:00	\N		\N
1429	\N	162	11:45:00	\N		\N
1430	\N	163	08:00:00	\N		\N
1431	\N	163	08:15:00	\N		\N
1432	\N	163	08:30:00	\N		\N
1433	26	163	08:45:00	2015-06-09		\N
1434	18	163	09:00:00	2015-06-09		\N
1435	28	163	09:15:00	2015-06-09		\N
1436	30	163	09:30:00	2015-06-09		\N
1437	29	163	09:45:00	2015-06-09		\N
1438	\N	163	10:00:00	2015-06-10		\N
1439	\N	163	10:15:00	\N		\N
1440	29	164	09:00:00	2015-06-09		\N
1441	18	164	09:25:00	2015-06-09		\N
1442	26	164	09:50:00	2015-06-09		\N
1443	30	164	10:15:00	2015-06-09		\N
1444	28	164	10:40:00	2015-06-09		\N
1445	\N	165	08:00:00	\N		\N
1446	\N	165	08:20:00	\N		\N
1447	\N	165	08:40:00	\N		\N
1448	\N	165	09:00:00	\N		\N
1449	\N	165	09:20:00	\N		\N
1450	\N	165	09:40:00	\N		\N
1451	\N	166	08:00:00	\N		\N
1452	\N	166	08:15:00	\N		\N
1453	\N	166	08:30:00	\N		\N
1454	\N	166	08:45:00	\N		\N
1455	\N	166	09:00:00	\N		\N
1456	\N	166	09:15:00	\N		\N
1457	\N	166	09:30:00	\N		\N
1458	\N	166	09:45:00	\N		\N
1459	\N	166	10:00:00	\N		\N
1460	\N	166	10:15:00	\N		\N
1461	\N	166	10:30:00	\N		\N
1462	\N	166	10:45:00	\N		\N
1463	\N	166	11:00:00	\N		\N
1464	\N	166	11:15:00	\N		\N
1465	\N	166	11:30:00	\N		\N
1466	\N	166	11:45:00	\N		\N
1467	\N	167	08:00:00	\N		\N
1468	\N	167	08:15:00	\N		\N
1469	\N	167	08:30:00	\N		\N
1470	\N	167	08:45:00	\N		\N
1471	\N	167	09:00:00	\N		\N
1472	\N	167	09:15:00	\N		\N
1473	\N	167	09:30:00	\N		\N
1474	\N	167	09:45:00	\N		\N
1475	\N	167	10:00:00	\N		\N
1476	\N	167	10:15:00	\N		\N
1477	\N	167	10:30:00	\N		\N
1478	\N	167	10:45:00	\N		\N
1479	\N	167	11:00:00	\N		\N
1480	\N	167	11:15:00	\N		\N
1481	\N	167	11:30:00	\N		\N
1482	\N	167	11:45:00	\N		\N
1483	29	168	09:00:00	2015-06-09		\N
1484	\N	168	09:15:00	\N		\N
1485	\N	168	09:30:00	\N		\N
1486	\N	168	09:45:00	\N		\N
1487	\N	168	10:00:00	\N		\N
1488	\N	168	10:15:00	\N		\N
1489	\N	168	10:30:00	\N		\N
1490	17	168	10:45:00	2015-06-09		\N
1491	\N	169	16:00:00	\N		\N
1492	\N	169	16:15:00	\N		\N
1493	\N	169	16:30:00	\N		\N
1494	\N	169	16:45:00	\N		\N
1495	\N	169	17:00:00	\N		\N
1496	\N	169	17:15:00	\N		\N
1497	\N	169	17:30:00	\N		\N
1498	\N	169	17:45:00	\N		\N
1499	\N	169	18:00:00	\N		\N
1500	\N	169	18:15:00	\N		\N
1501	\N	169	18:30:00	\N		\N
1502	\N	169	18:45:00	\N		\N
1503	\N	169	19:00:00	\N		\N
1504	\N	169	19:15:00	\N		\N
1505	\N	169	19:30:00	\N		\N
1506	\N	169	19:45:00	\N		\N
1507	\N	170	08:00:00	\N		\N
1508	\N	170	08:15:00	\N		\N
1509	\N	170	08:30:00	\N		\N
1510	\N	170	08:45:00	\N		\N
1511	\N	170	09:00:00	\N		\N
1512	\N	170	09:15:00	\N		\N
1513	\N	170	09:30:00	\N		\N
1514	\N	170	09:45:00	\N		\N
1515	\N	170	10:00:00	\N		\N
1516	\N	170	10:15:00	\N		\N
1517	\N	170	10:30:00	\N		\N
1518	\N	170	10:45:00	\N		\N
1519	\N	170	11:00:00	\N		\N
1520	\N	170	11:15:00	\N		\N
1521	\N	170	11:30:00	\N		\N
1522	\N	170	11:45:00	\N		\N
1523	\N	171	08:00:00	\N		\N
1524	\N	171	08:15:00	\N		\N
1525	\N	171	08:30:00	\N		\N
1526	\N	171	08:45:00	\N		\N
1527	\N	171	09:00:00	\N		\N
1528	\N	171	09:15:00	\N		\N
1529	\N	171	09:30:00	\N		\N
1530	\N	171	09:45:00	\N		\N
1531	\N	171	10:00:00	\N		\N
1532	\N	171	10:15:00	\N		\N
1533	\N	171	10:30:00	\N		\N
1534	\N	171	10:45:00	\N		\N
1535	\N	171	11:00:00	\N		\N
1536	\N	171	11:15:00	\N		\N
1537	\N	171	11:30:00	\N		\N
1538	\N	171	11:45:00	\N		\N
1539	\N	172	08:00:00	\N		\N
1540	\N	172	08:20:00	\N		\N
1541	7	172	08:40:00	2016-04-03		\N
1542	\N	172	09:00:00	\N		\N
1543	\N	172	09:20:00	\N		\N
1544	\N	172	09:40:00	\N		\N
1545	7	173	08:00:00	2016-04-03		\N
1546	\N	173	08:15:00	\N		\N
1547	\N	173	08:30:00	\N		\N
1548	\N	173	08:45:00	\N		\N
1549	\N	173	09:00:00	\N		\N
1550	\N	173	09:15:00	\N		\N
1551	\N	173	09:30:00	\N		\N
1552	\N	173	09:45:00	\N		\N
1553	\N	173	10:00:00	\N		\N
1554	\N	173	10:15:00	\N		\N
1555	\N	173	10:30:00	\N		\N
1556	\N	173	10:45:00	\N		\N
1557	\N	173	11:00:00	\N		\N
1558	\N	173	11:15:00	\N		\N
1559	\N	173	11:30:00	\N		\N
1560	\N	173	11:45:00	\N		\N
\.

ALTER TABLE "HistoriaClinica_capitulosinos" ADD CONSTRAINT "HistoriaClinica_capitulosinos_nro_capitulo_pkey" PRIMARY KEY(nro_capitulo);
DROP INDEX IF EXISTS "HistoriaClinica_capitulosinos_tipo_nro_capitulo" CASCADE;
CREATE UNIQUE INDEX "HistoriaClinica_capitulosinos_tipo_nro_capitulo" ON "HistoriaClinica_capitulosinos" ("tipo", "nro_capitulo");ALTER TABLE "HistoriaClinica_cie10" ADD CONSTRAINT "HistoriaClinica_cie10_codigo_pkey" PRIMARY KEY(codigo);ALTER TABLE "HistoriaClinica_consultamedica" ADD CONSTRAINT "HistoriaClinica_consultamedica_id_pkey" PRIMARY KEY(id);
DROP INDEX IF EXISTS "HistoriaClinica_consultamedica_historia_clinica_id" CASCADE;
CREATE INDEX "HistoriaClinica_consultamedica_historia_clinica_id" ON "HistoriaClinica_consultamedica" ("historia_clinica_id");
DROP INDEX IF EXISTS "HistoriaClinica_consultamedica_prestador_id" CASCADE;
CREATE INDEX "HistoriaClinica_consultamedica_prestador_id" ON "HistoriaClinica_consultamedica" ("prestador_id");
DROP INDEX IF EXISTS "HistoriaClinica_consultamedica_os_consulta_id" CASCADE;
CREATE INDEX "HistoriaClinica_consultamedica_os_consulta_id" ON "HistoriaClinica_consultamedica" ("os_consulta_id");ALTER TABLE "HistoriaClinica_consultamedica_diagnosticos" ADD CONSTRAINT "HistoriaClinica_consultamedica_diagnosticos_id_pkey" PRIMARY KEY(id);
DROP INDEX IF EXISTS "HistoriaClinica_consultamedica_diagnosticos_consultamedica_id_cie10_id" CASCADE;
CREATE UNIQUE INDEX "HistoriaClinica_consultamedica_diagnosticos_consultamedica_id_cie10_id" ON "HistoriaClinica_consultamedica_diagnosticos" ("consultamedica_id", "cie10_id");
DROP INDEX IF EXISTS "HistoriaClinica_consultamedica_diagnosticos_consultamedica_id" CASCADE;
CREATE INDEX "HistoriaClinica_consultamedica_diagnosticos_consultamedica_id" ON "HistoriaClinica_consultamedica_diagnosticos" ("consultamedica_id");
DROP INDEX IF EXISTS "HistoriaClinica_consultamedica_diagnosticos_cie10_id" CASCADE;
CREATE INDEX "HistoriaClinica_consultamedica_diagnosticos_cie10_id" ON "HistoriaClinica_consultamedica_diagnosticos" ("cie10_id");ALTER TABLE "HistoriaClinica_examenfisico" ADD CONSTRAINT "HistoriaClinica_examenfisico_id_pkey" PRIMARY KEY(id);
DROP INDEX IF EXISTS "HistoriaClinica_examenfisico_historia_clinica_id" CASCADE;
CREATE INDEX "HistoriaClinica_examenfisico_historia_clinica_id" ON "HistoriaClinica_examenfisico" ("historia_clinica_id");ALTER TABLE "HistoriaClinica_fisiologicos" ADD CONSTRAINT "HistoriaClinica_fisiologicos_id_pkey" PRIMARY KEY(id);
DROP INDEX IF EXISTS "HistoriaClinica_fisiologicos_historia_clinica_id" CASCADE;
CREATE INDEX "HistoriaClinica_fisiologicos_historia_clinica_id" ON "HistoriaClinica_fisiologicos" ("historia_clinica_id");ALTER TABLE "HistoriaClinica_habitostoxicos" ADD CONSTRAINT "HistoriaClinica_habitostoxicos_id_pkey" PRIMARY KEY(id);
DROP INDEX IF EXISTS "HistoriaClinica_habitostoxicos_historia_clinica_id" CASCADE;
CREATE INDEX "HistoriaClinica_habitostoxicos_historia_clinica_id" ON "HistoriaClinica_habitostoxicos" ("historia_clinica_id");ALTER TABLE "HistoriaClinica_historiaclinica" ADD CONSTRAINT "HistoriaClinica_historiaclinica_id_pkey" PRIMARY KEY(id);
DROP INDEX IF EXISTS "HistoriaClinica_historiaclinica_paciente_id" CASCADE;
CREATE UNIQUE INDEX "HistoriaClinica_historiaclinica_paciente_id" ON "HistoriaClinica_historiaclinica" ("paciente_id");
DROP INDEX IF EXISTS "HistoriaClinica_historiaclinica_prestador_id" CASCADE;
CREATE INDEX "HistoriaClinica_historiaclinica_prestador_id" ON "HistoriaClinica_historiaclinica" ("prestador_id");ALTER TABLE "HistoriaClinica_inos" ADD CONSTRAINT "HistoriaClinica_inos_id_pkey" PRIMARY KEY(id);
DROP INDEX IF EXISTS "HistoriaClinica_inos_capitulo_id_codigo" CASCADE;
CREATE UNIQUE INDEX "HistoriaClinica_inos_capitulo_id_codigo" ON "HistoriaClinica_inos" ("capitulo_id", "codigo");
DROP INDEX IF EXISTS "HistoriaClinica_inos_capitulo_id" CASCADE;
CREATE INDEX "HistoriaClinica_inos_capitulo_id" ON "HistoriaClinica_inos" ("capitulo_id");ALTER TABLE "HistoriaClinica_laboratorio" ADD CONSTRAINT "HistoriaClinica_laboratorio_id_pkey" PRIMARY KEY(id);
DROP INDEX IF EXISTS "HistoriaClinica_laboratorio_historia_clinica_id" CASCADE;
CREATE INDEX "HistoriaClinica_laboratorio_historia_clinica_id" ON "HistoriaClinica_laboratorio" ("historia_clinica_id");
DROP INDEX IF EXISTS "HistoriaClinica_laboratorio_prestador_id" CASCADE;
CREATE INDEX "HistoriaClinica_laboratorio_prestador_id" ON "HistoriaClinica_laboratorio" ("prestador_id");
DROP INDEX IF EXISTS "HistoriaClinica_laboratorio_analisis_id" CASCADE;
CREATE INDEX "HistoriaClinica_laboratorio_analisis_id" ON "HistoriaClinica_laboratorio" ("analisis_id");ALTER TABLE "HistoriaClinica_patologicos" ADD CONSTRAINT "HistoriaClinica_patologicos_id_pkey" PRIMARY KEY(id);
DROP INDEX IF EXISTS "HistoriaClinica_patologicos_historia_clinica_id" CASCADE;
CREATE INDEX "HistoriaClinica_patologicos_historia_clinica_id" ON "HistoriaClinica_patologicos" ("historia_clinica_id");ALTER TABLE "HistoriaClinica_perinatales" ADD CONSTRAINT "HistoriaClinica_perinatales_id_pkey" PRIMARY KEY(id);
DROP INDEX IF EXISTS "HistoriaClinica_perinatales_historia_clinica_id" CASCADE;
CREATE INDEX "HistoriaClinica_perinatales_historia_clinica_id" ON "HistoriaClinica_perinatales" ("historia_clinica_id");ALTER TABLE "HistoriaClinica_practicadetalle" ADD CONSTRAINT "HistoriaClinica_practicadetalle_id_pkey" PRIMARY KEY(id);
DROP INDEX IF EXISTS "HistoriaClinica_practicadetalle_practica_medica_id_practica_id" CASCADE;
CREATE UNIQUE INDEX "HistoriaClinica_practicadetalle_practica_medica_id_practica_id" ON "HistoriaClinica_practicadetalle" ("practica_medica_id", "practica_id");
DROP INDEX IF EXISTS "HistoriaClinica_practicadetalle_practica_medica_id" CASCADE;
CREATE INDEX "HistoriaClinica_practicadetalle_practica_medica_id" ON "HistoriaClinica_practicadetalle" ("practica_medica_id");
DROP INDEX IF EXISTS "HistoriaClinica_practicadetalle_practica_id" CASCADE;
CREATE INDEX "HistoriaClinica_practicadetalle_practica_id" ON "HistoriaClinica_practicadetalle" ("practica_id");ALTER TABLE "HistoriaClinica_practicamedica" ADD CONSTRAINT "HistoriaClinica_practicamedica_id_pkey" PRIMARY KEY(id);
DROP INDEX IF EXISTS "HistoriaClinica_practicamedica_historia_clinica_id" CASCADE;
CREATE INDEX "HistoriaClinica_practicamedica_historia_clinica_id" ON "HistoriaClinica_practicamedica" ("historia_clinica_id");
DROP INDEX IF EXISTS "HistoriaClinica_practicamedica_prestador_id" CASCADE;
CREATE INDEX "HistoriaClinica_practicamedica_prestador_id" ON "HistoriaClinica_practicamedica" ("prestador_id");
DROP INDEX IF EXISTS "HistoriaClinica_practicamedica_os_prescripcion_id" CASCADE;
CREATE INDEX "HistoriaClinica_practicamedica_os_prescripcion_id" ON "HistoriaClinica_practicamedica" ("os_prescripcion_id");
DROP INDEX IF EXISTS "HistoriaClinica_practicamedica_efector_id" CASCADE;
CREATE INDEX "HistoriaClinica_practicamedica_efector_id" ON "HistoriaClinica_practicamedica" ("efector_id");ALTER TABLE "HistoriaClinica_receta" ADD CONSTRAINT "HistoriaClinica_receta_id_pkey" PRIMARY KEY(id);
DROP INDEX IF EXISTS "HistoriaClinica_receta_historia_clinica_id" CASCADE;
CREATE INDEX "HistoriaClinica_receta_historia_clinica_id" ON "HistoriaClinica_receta" ("historia_clinica_id");
DROP INDEX IF EXISTS "HistoriaClinica_receta_prestador_id" CASCADE;
CREATE INDEX "HistoriaClinica_receta_prestador_id" ON "HistoriaClinica_receta" ("prestador_id");
DROP INDEX IF EXISTS "HistoriaClinica_receta_os_receta_id" CASCADE;
CREATE INDEX "HistoriaClinica_receta_os_receta_id" ON "HistoriaClinica_receta" ("os_receta_id");ALTER TABLE "HistoriaClinica_recetadetalle" ADD CONSTRAINT "HistoriaClinica_recetadetalle_id_pkey" PRIMARY KEY(id);
DROP INDEX IF EXISTS "HistoriaClinica_recetadetalle_receta_id_medicacion_id" CASCADE;
CREATE UNIQUE INDEX "HistoriaClinica_recetadetalle_receta_id_medicacion_id" ON "HistoriaClinica_recetadetalle" ("receta_id", "medicacion_id");
DROP INDEX IF EXISTS "HistoriaClinica_recetadetalle_receta_id" CASCADE;
CREATE INDEX "HistoriaClinica_recetadetalle_receta_id" ON "HistoriaClinica_recetadetalle" ("receta_id");
DROP INDEX IF EXISTS "HistoriaClinica_recetadetalle_medicacion_id" CASCADE;
CREATE INDEX "HistoriaClinica_recetadetalle_medicacion_id" ON "HistoriaClinica_recetadetalle" ("medicacion_id");ALTER TABLE "HistoriaClinica_vademecum" ADD CONSTRAINT "HistoriaClinica_vademecum_id_pkey" PRIMARY KEY(id);ALTER TABLE "auth_group" ADD CONSTRAINT "auth_group_id_pkey" PRIMARY KEY(id);
DROP INDEX IF EXISTS "auth_group_name" CASCADE;
CREATE UNIQUE INDEX "auth_group_name" ON "auth_group" ("name");ALTER TABLE "auth_group_permissions" ADD CONSTRAINT "auth_group_permissions_id_pkey" PRIMARY KEY(id);
DROP INDEX IF EXISTS "auth_group_permissions_group_id_permission_id" CASCADE;
CREATE UNIQUE INDEX "auth_group_permissions_group_id_permission_id" ON "auth_group_permissions" ("group_id", "permission_id");
DROP INDEX IF EXISTS "auth_group_permissions_group_id" CASCADE;
CREATE INDEX "auth_group_permissions_group_id" ON "auth_group_permissions" ("group_id");
DROP INDEX IF EXISTS "auth_group_permissions_permission_id" CASCADE;
CREATE INDEX "auth_group_permissions_permission_id" ON "auth_group_permissions" ("permission_id");ALTER TABLE "auth_permission" ADD CONSTRAINT "auth_permission_id_pkey" PRIMARY KEY(id);
DROP INDEX IF EXISTS "auth_permission_content_type_id_codename" CASCADE;
CREATE UNIQUE INDEX "auth_permission_content_type_id_codename" ON "auth_permission" ("content_type_id", "codename");
DROP INDEX IF EXISTS "auth_permission_content_type_id" CASCADE;
CREATE INDEX "auth_permission_content_type_id" ON "auth_permission" ("content_type_id");ALTER TABLE "auth_user" ADD CONSTRAINT "auth_user_id_pkey" PRIMARY KEY(id);
DROP INDEX IF EXISTS "auth_user_username" CASCADE;
CREATE UNIQUE INDEX "auth_user_username" ON "auth_user" ("username");ALTER TABLE "auth_user_groups" ADD CONSTRAINT "auth_user_groups_id_pkey" PRIMARY KEY(id);
DROP INDEX IF EXISTS "auth_user_groups_user_id_group_id" CASCADE;
CREATE UNIQUE INDEX "auth_user_groups_user_id_group_id" ON "auth_user_groups" ("user_id", "group_id");
DROP INDEX IF EXISTS "auth_user_groups_user_id" CASCADE;
CREATE INDEX "auth_user_groups_user_id" ON "auth_user_groups" ("user_id");
DROP INDEX IF EXISTS "auth_user_groups_group_id" CASCADE;
CREATE INDEX "auth_user_groups_group_id" ON "auth_user_groups" ("group_id");ALTER TABLE "auth_user_user_permissions" ADD CONSTRAINT "auth_user_user_permissions_id_pkey" PRIMARY KEY(id);
DROP INDEX IF EXISTS "auth_user_user_permissions_user_id_permission_id" CASCADE;
CREATE UNIQUE INDEX "auth_user_user_permissions_user_id_permission_id" ON "auth_user_user_permissions" ("user_id", "permission_id");
DROP INDEX IF EXISTS "auth_user_user_permissions_user_id" CASCADE;
CREATE INDEX "auth_user_user_permissions_user_id" ON "auth_user_user_permissions" ("user_id");
DROP INDEX IF EXISTS "auth_user_user_permissions_permission_id" CASCADE;
CREATE INDEX "auth_user_user_permissions_permission_id" ON "auth_user_user_permissions" ("permission_id");ALTER TABLE "django_admin_log" ADD CONSTRAINT "django_admin_log_id_pkey" PRIMARY KEY(id);
DROP INDEX IF EXISTS "django_admin_log_user_id" CASCADE;
CREATE INDEX "django_admin_log_user_id" ON "django_admin_log" ("user_id");
DROP INDEX IF EXISTS "django_admin_log_content_type_id" CASCADE;
CREATE INDEX "django_admin_log_content_type_id" ON "django_admin_log" ("content_type_id");ALTER TABLE "django_content_type" ADD CONSTRAINT "django_content_type_id_pkey" PRIMARY KEY(id);
DROP INDEX IF EXISTS "django_content_type_app_label_model" CASCADE;
CREATE UNIQUE INDEX "django_content_type_app_label_model" ON "django_content_type" ("app_label", "model");ALTER TABLE "django_session" ADD CONSTRAINT "django_session_session_key_pkey" PRIMARY KEY(session_key);
DROP INDEX IF EXISTS "django_session_expire_date" CASCADE;
CREATE INDEX "django_session_expire_date" ON "django_session" ("expire_date");ALTER TABLE "django_site" ADD CONSTRAINT "django_site_id_pkey" PRIMARY KEY(id);ALTER TABLE "home_medico" ADD CONSTRAINT "home_medico_matricula_pkey" PRIMARY KEY(matricula);
DROP INDEX IF EXISTS "home_medico_user_id" CASCADE;
CREATE UNIQUE INDEX "home_medico_user_id" ON "home_medico" ("user_id");ALTER TABLE "home_perfilusuario" ADD CONSTRAINT "home_perfilusuario_dni_pkey" PRIMARY KEY(dni);
DROP INDEX IF EXISTS "home_perfilusuario_user_id" CASCADE;
CREATE UNIQUE INDEX "home_perfilusuario_user_id" ON "home_perfilusuario" ("user_id");ALTER TABLE "turnos_afiliadosos" ADD CONSTRAINT "turnos_afiliadosos_id_pkey" PRIMARY KEY(id);
DROP INDEX IF EXISTS "turnos_afiliadosos_afiliado_id_obrasocial_id" CASCADE;
CREATE UNIQUE INDEX "turnos_afiliadosos_afiliado_id_obrasocial_id" ON "turnos_afiliadosos" ("afiliado_id", "obrasocial_id");
DROP INDEX IF EXISTS "turnos_afiliadosos_afiliado_id" CASCADE;
CREATE INDEX "turnos_afiliadosos_afiliado_id" ON "turnos_afiliadosos" ("afiliado_id");
DROP INDEX IF EXISTS "turnos_afiliadosos_obrasocial_id" CASCADE;
CREATE INDEX "turnos_afiliadosos_obrasocial_id" ON "turnos_afiliadosos" ("obrasocial_id");ALTER TABLE "turnos_agenda" ADD CONSTRAINT "turnos_agenda_id_pkey" PRIMARY KEY(id);
DROP INDEX IF EXISTS "turnos_agenda_prestador_id_dia_hora_inicial" CASCADE;
CREATE UNIQUE INDEX "turnos_agenda_prestador_id_dia_hora_inicial" ON "turnos_agenda" ("prestador_id", "dia", "hora_inicial");
DROP INDEX IF EXISTS "turnos_agenda_prestador_id" CASCADE;
CREATE INDEX "turnos_agenda_prestador_id" ON "turnos_agenda" ("prestador_id");ALTER TABLE "turnos_diaatencion" ADD CONSTRAINT "turnos_diaatencion_id_pkey" PRIMARY KEY(id);
DROP INDEX IF EXISTS "turnos_diaatencion_prestador_id" CASCADE;
CREATE INDEX "turnos_diaatencion_prestador_id" ON "turnos_diaatencion" ("prestador_id");ALTER TABLE "turnos_especialidad" ADD CONSTRAINT "turnos_especialidad_id_pkey" PRIMARY KEY(id);ALTER TABLE "turnos_especialidadesmedicos" ADD CONSTRAINT "turnos_especialidadesmedicos_id_pkey" PRIMARY KEY(id);
DROP INDEX IF EXISTS "turnos_especialidadesmedicos_medico_id_especialidad_id" CASCADE;
CREATE UNIQUE INDEX "turnos_especialidadesmedicos_medico_id_especialidad_id" ON "turnos_especialidadesmedicos" ("medico_id", "especialidad_id");
DROP INDEX IF EXISTS "turnos_especialidadesmedicos_medico_id" CASCADE;
CREATE INDEX "turnos_especialidadesmedicos_medico_id" ON "turnos_especialidadesmedicos" ("medico_id");
DROP INDEX IF EXISTS "turnos_especialidadesmedicos_especialidad_id" CASCADE;
CREATE INDEX "turnos_especialidadesmedicos_especialidad_id" ON "turnos_especialidadesmedicos" ("especialidad_id");ALTER TABLE "turnos_obrasocial" ADD CONSTRAINT "turnos_obrasocial_cuit_pkey" PRIMARY KEY(cuit);ALTER TABLE "turnos_turno" ADD CONSTRAINT "turnos_turno_id_pkey" PRIMARY KEY(id);
DROP INDEX IF EXISTS "turnos_turno_paciente_id" CASCADE;
CREATE INDEX "turnos_turno_paciente_id" ON "turnos_turno" ("paciente_id");
DROP INDEX IF EXISTS "turnos_turno_dia_atencion_id" CASCADE;
CREATE INDEX "turnos_turno_dia_atencion_id" ON "turnos_turno" ("dia_atencion_id");ALTER TABLE "HistoriaClinica_consultamedica" ADD FOREIGN KEY ("historia_clinica_id")
            REFERENCES "HistoriaClinica_historiaclinica"(id);
ALTER TABLE "HistoriaClinica_consultamedica" ADD FOREIGN KEY ("os_consulta_id")
            REFERENCES "turnos_afiliadosos"(id);
ALTER TABLE "HistoriaClinica_consultamedica" ADD FOREIGN KEY ("prestador_id")
            REFERENCES "turnos_especialidadesmedicos"(id);ALTER TABLE "HistoriaClinica_consultamedica_diagnosticos" ADD FOREIGN KEY ("cie10_id")
            REFERENCES "HistoriaClinica_cie10"(codigo);
ALTER TABLE "HistoriaClinica_consultamedica_diagnosticos" ADD FOREIGN KEY ("consultamedica_id")
            REFERENCES "HistoriaClinica_consultamedica"(id);ALTER TABLE "HistoriaClinica_examenfisico" ADD FOREIGN KEY ("historia_clinica_id")
            REFERENCES "HistoriaClinica_historiaclinica"(id);ALTER TABLE "HistoriaClinica_fisiologicos" ADD FOREIGN KEY ("historia_clinica_id")
            REFERENCES "HistoriaClinica_historiaclinica"(id);ALTER TABLE "HistoriaClinica_habitostoxicos" ADD FOREIGN KEY ("historia_clinica_id")
            REFERENCES "HistoriaClinica_historiaclinica"(id);ALTER TABLE "HistoriaClinica_historiaclinica" ADD FOREIGN KEY ("paciente_id")
            REFERENCES "auth_user"(id);
ALTER TABLE "HistoriaClinica_historiaclinica" ADD FOREIGN KEY ("prestador_id")
            REFERENCES "turnos_especialidadesmedicos"(id);ALTER TABLE "HistoriaClinica_inos" ADD FOREIGN KEY ("capitulo_id")
            REFERENCES "HistoriaClinica_capitulosinos"(nro_capitulo);ALTER TABLE "HistoriaClinica_laboratorio" ADD FOREIGN KEY ("analisis_id")
            REFERENCES "HistoriaClinica_inos"(id);
ALTER TABLE "HistoriaClinica_laboratorio" ADD FOREIGN KEY ("historia_clinica_id")
            REFERENCES "HistoriaClinica_historiaclinica"(id);
ALTER TABLE "HistoriaClinica_laboratorio" ADD FOREIGN KEY ("prestador_id")
            REFERENCES "turnos_especialidadesmedicos"(id);ALTER TABLE "HistoriaClinica_patologicos" ADD FOREIGN KEY ("historia_clinica_id")
            REFERENCES "HistoriaClinica_historiaclinica"(id);ALTER TABLE "HistoriaClinica_perinatales" ADD FOREIGN KEY ("historia_clinica_id")
            REFERENCES "HistoriaClinica_historiaclinica"(id);ALTER TABLE "HistoriaClinica_practicadetalle" ADD FOREIGN KEY ("practica_id")
            REFERENCES "HistoriaClinica_inos"(id);
ALTER TABLE "HistoriaClinica_practicadetalle" ADD FOREIGN KEY ("practica_medica_id")
            REFERENCES "HistoriaClinica_practicamedica"(id);ALTER TABLE "HistoriaClinica_practicamedica" ADD FOREIGN KEY ("efector_id")
            REFERENCES "turnos_especialidadesmedicos"(id);
ALTER TABLE "HistoriaClinica_practicamedica" ADD FOREIGN KEY ("historia_clinica_id")
            REFERENCES "HistoriaClinica_historiaclinica"(id);
ALTER TABLE "HistoriaClinica_practicamedica" ADD FOREIGN KEY ("os_prescripcion_id")
            REFERENCES "turnos_afiliadosos"(id);
ALTER TABLE "HistoriaClinica_practicamedica" ADD FOREIGN KEY ("prestador_id")
            REFERENCES "turnos_especialidadesmedicos"(id);ALTER TABLE "HistoriaClinica_receta" ADD FOREIGN KEY ("historia_clinica_id")
            REFERENCES "HistoriaClinica_historiaclinica"(id);
ALTER TABLE "HistoriaClinica_receta" ADD FOREIGN KEY ("os_receta_id")
            REFERENCES "turnos_afiliadosos"(id);
ALTER TABLE "HistoriaClinica_receta" ADD FOREIGN KEY ("prestador_id")
            REFERENCES "turnos_especialidadesmedicos"(id);ALTER TABLE "HistoriaClinica_recetadetalle" ADD FOREIGN KEY ("medicacion_id")
            REFERENCES "HistoriaClinica_vademecum"(id);
ALTER TABLE "HistoriaClinica_recetadetalle" ADD FOREIGN KEY ("receta_id")
            REFERENCES "HistoriaClinica_receta"(id);ALTER TABLE "auth_group_permissions" ADD FOREIGN KEY ("group_id")
            REFERENCES "auth_group"(id);
ALTER TABLE "auth_group_permissions" ADD FOREIGN KEY ("permission_id")
            REFERENCES "auth_permission"(id);ALTER TABLE "auth_permission" ADD FOREIGN KEY ("content_type_id")
            REFERENCES "django_content_type"(id);ALTER TABLE "auth_user_groups" ADD FOREIGN KEY ("group_id")
            REFERENCES "auth_group"(id);
ALTER TABLE "auth_user_groups" ADD FOREIGN KEY ("user_id")
            REFERENCES "auth_user"(id);ALTER TABLE "auth_user_user_permissions" ADD FOREIGN KEY ("permission_id")
            REFERENCES "auth_permission"(id);
ALTER TABLE "auth_user_user_permissions" ADD FOREIGN KEY ("user_id")
            REFERENCES "auth_user"(id);ALTER TABLE "django_admin_log" ADD FOREIGN KEY ("content_type_id")
            REFERENCES "django_content_type"(id);
ALTER TABLE "django_admin_log" ADD FOREIGN KEY ("user_id")
            REFERENCES "auth_user"(id);ALTER TABLE "home_medico" ADD FOREIGN KEY ("user_id")
            REFERENCES "auth_user"(id);ALTER TABLE "home_perfilusuario" ADD FOREIGN KEY ("user_id")
            REFERENCES "auth_user"(id);ALTER TABLE "turnos_afiliadosos" ADD FOREIGN KEY ("afiliado_id")
            REFERENCES "auth_user"(id);
ALTER TABLE "turnos_afiliadosos" ADD FOREIGN KEY ("obrasocial_id")
            REFERENCES "turnos_obrasocial"(cuit);ALTER TABLE "turnos_agenda" ADD FOREIGN KEY ("prestador_id")
            REFERENCES "turnos_especialidadesmedicos"(id);ALTER TABLE "turnos_diaatencion" ADD FOREIGN KEY ("prestador_id")
            REFERENCES "turnos_especialidadesmedicos"(id);ALTER TABLE "turnos_especialidadesmedicos" ADD FOREIGN KEY ("especialidad_id")
            REFERENCES "turnos_especialidad"(id);
ALTER TABLE "turnos_especialidadesmedicos" ADD FOREIGN KEY ("medico_id")
            REFERENCES "home_medico"(matricula);ALTER TABLE "turnos_turno" ADD FOREIGN KEY ("dia_atencion_id")
            REFERENCES "turnos_diaatencion"(id);
ALTER TABLE "turnos_turno" ADD FOREIGN KEY ("paciente_id")
            REFERENCES "auth_user"(id);