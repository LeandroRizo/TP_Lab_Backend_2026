--
-- PostgreSQL database dump
--

\restrict CPH9Y05PeSdTIddbws5QPXwdgeGeJCb0D37fL3mct0WgBClM5k3Qo8foOzmkwYM

-- Dumped from database version 18.4
-- Dumped by pg_dump version 18.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE IF EXISTS ONLY public."Zona" DROP CONSTRAINT IF EXISTS "Zona_id_pabellon_fkey";
ALTER TABLE IF EXISTS ONLY public."Usuario" DROP CONSTRAINT IF EXISTS "Usuario_id_rol_fkey";
ALTER TABLE IF EXISTS ONLY public."Stand" DROP CONSTRAINT IF EXISTS "Stand_id_zona_fkey";
ALTER TABLE IF EXISTS ONLY public."Solicitud" DROP CONSTRAINT IF EXISTS "Solicitud_id_artesano_fkey";
ALTER TABLE IF EXISTS ONLY public."Producto" DROP CONSTRAINT IF EXISTS "Producto_id_categoria_fkey";
ALTER TABLE IF EXISTS ONLY public."Producto" DROP CONSTRAINT IF EXISTS "Producto_id_artesano_fkey";
ALTER TABLE IF EXISTS ONLY public."Inscripcion" DROP CONSTRAINT IF EXISTS "Inscripcion_id_stand_fkey";
ALTER TABLE IF EXISTS ONLY public."Inscripcion" DROP CONSTRAINT IF EXISTS "Inscripcion_id_artesano_fkey";
ALTER TABLE IF EXISTS ONLY public."Artesano" DROP CONSTRAINT IF EXISTS "Artesano_id_usuario_fkey";
ALTER TABLE IF EXISTS ONLY public."Artesano" DROP CONSTRAINT IF EXISTS "Artesano_id_rubro_fkey";
ALTER TABLE IF EXISTS ONLY public."Artesano" DROP CONSTRAINT IF EXISTS "Artesano_id_localidad_fkey";
DROP INDEX IF EXISTS public."Usuario_email_key";
DROP INDEX IF EXISTS public."Localidad_provincia_idx";
DROP INDEX IF EXISTS public."Localidad_nombre_idx";
DROP INDEX IF EXISTS public."Localidad_id_georef_key";
DROP INDEX IF EXISTS public."Localidad_departamento_idx";
DROP INDEX IF EXISTS public."Artesano_id_usuario_key";
DROP INDEX IF EXISTS public."Artesano_dni_key";
ALTER TABLE IF EXISTS ONLY public._prisma_migrations DROP CONSTRAINT IF EXISTS _prisma_migrations_pkey;
ALTER TABLE IF EXISTS ONLY public."Zona" DROP CONSTRAINT IF EXISTS "Zona_pkey";
ALTER TABLE IF EXISTS ONLY public."Usuario" DROP CONSTRAINT IF EXISTS "Usuario_pkey";
ALTER TABLE IF EXISTS ONLY public."TokenRevocado" DROP CONSTRAINT IF EXISTS "TokenRevocado_pkey";
ALTER TABLE IF EXISTS ONLY public."Stand" DROP CONSTRAINT IF EXISTS "Stand_pkey";
ALTER TABLE IF EXISTS ONLY public."Solicitud" DROP CONSTRAINT IF EXISTS "Solicitud_pkey";
ALTER TABLE IF EXISTS ONLY public."Rubro" DROP CONSTRAINT IF EXISTS "Rubro_pkey";
ALTER TABLE IF EXISTS ONLY public."Rol" DROP CONSTRAINT IF EXISTS "Rol_pkey";
ALTER TABLE IF EXISTS ONLY public."Producto" DROP CONSTRAINT IF EXISTS "Producto_pkey";
ALTER TABLE IF EXISTS ONLY public."Pabellon" DROP CONSTRAINT IF EXISTS "Pabellon_pkey";
ALTER TABLE IF EXISTS ONLY public."Localidad" DROP CONSTRAINT IF EXISTS "Localidad_pkey";
ALTER TABLE IF EXISTS ONLY public."Inscripcion" DROP CONSTRAINT IF EXISTS "Inscripcion_pkey";
ALTER TABLE IF EXISTS ONLY public."Categoria" DROP CONSTRAINT IF EXISTS "Categoria_pkey";
ALTER TABLE IF EXISTS ONLY public."Artesano" DROP CONSTRAINT IF EXISTS "Artesano_pkey";
ALTER TABLE IF EXISTS public."Zona" ALTER COLUMN id_zona DROP DEFAULT;
ALTER TABLE IF EXISTS public."Stand" ALTER COLUMN id_stand DROP DEFAULT;
ALTER TABLE IF EXISTS public."Solicitud" ALTER COLUMN id_solicitud DROP DEFAULT;
ALTER TABLE IF EXISTS public."Rubro" ALTER COLUMN id_rubro DROP DEFAULT;
ALTER TABLE IF EXISTS public."Rol" ALTER COLUMN id_rol DROP DEFAULT;
ALTER TABLE IF EXISTS public."Producto" ALTER COLUMN id_producto DROP DEFAULT;
ALTER TABLE IF EXISTS public."Pabellon" ALTER COLUMN id_pabellon DROP DEFAULT;
ALTER TABLE IF EXISTS public."Localidad" ALTER COLUMN id_localidad DROP DEFAULT;
ALTER TABLE IF EXISTS public."Inscripcion" ALTER COLUMN id_inscripcion DROP DEFAULT;
ALTER TABLE IF EXISTS public."Categoria" ALTER COLUMN id_categoria DROP DEFAULT;
ALTER TABLE IF EXISTS public."Artesano" ALTER COLUMN id_artesano DROP DEFAULT;
DROP TABLE IF EXISTS public._prisma_migrations;
DROP SEQUENCE IF EXISTS public."Zona_id_zona_seq";
DROP TABLE IF EXISTS public."Zona";
DROP TABLE IF EXISTS public."Usuario";
DROP TABLE IF EXISTS public."TokenRevocado";
DROP SEQUENCE IF EXISTS public."Stand_id_stand_seq";
DROP TABLE IF EXISTS public."Stand";
DROP SEQUENCE IF EXISTS public."Solicitud_id_solicitud_seq";
DROP TABLE IF EXISTS public."Solicitud";
DROP SEQUENCE IF EXISTS public."Rubro_id_rubro_seq";
DROP TABLE IF EXISTS public."Rubro";
DROP SEQUENCE IF EXISTS public."Rol_id_rol_seq";
DROP TABLE IF EXISTS public."Rol";
DROP SEQUENCE IF EXISTS public."Producto_id_producto_seq";
DROP TABLE IF EXISTS public."Producto";
DROP SEQUENCE IF EXISTS public."Pabellon_id_pabellon_seq";
DROP TABLE IF EXISTS public."Pabellon";
DROP SEQUENCE IF EXISTS public."Localidad_id_localidad_seq";
DROP TABLE IF EXISTS public."Localidad";
DROP SEQUENCE IF EXISTS public."Inscripcion_id_inscripcion_seq";
DROP TABLE IF EXISTS public."Inscripcion";
DROP SEQUENCE IF EXISTS public."Categoria_id_categoria_seq";
DROP TABLE IF EXISTS public."Categoria";
DROP SEQUENCE IF EXISTS public."Artesano_id_artesano_seq";
DROP TABLE IF EXISTS public."Artesano";
SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Artesano; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Artesano" (
    id_artesano integer NOT NULL,
    id_usuario uuid NOT NULL,
    nombre text NOT NULL,
    apellido text NOT NULL,
    dni text NOT NULL,
    telefono text,
    direccion text,
    descripcion text,
    instagram text,
    id_localidad integer NOT NULL,
    id_rubro integer NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone NOT NULL
);


--
-- Name: Artesano_id_artesano_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."Artesano_id_artesano_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: Artesano_id_artesano_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."Artesano_id_artesano_seq" OWNED BY public."Artesano".id_artesano;


--
-- Name: Categoria; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Categoria" (
    id_categoria integer NOT NULL,
    nombre text NOT NULL,
    descripcion text,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone NOT NULL
);


--
-- Name: Categoria_id_categoria_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."Categoria_id_categoria_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: Categoria_id_categoria_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."Categoria_id_categoria_seq" OWNED BY public."Categoria".id_categoria;


--
-- Name: Inscripcion; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Inscripcion" (
    id_inscripcion integer NOT NULL,
    id_artesano integer NOT NULL,
    id_stand integer,
    anio integer NOT NULL,
    fecha_solicitud timestamp(3) without time zone NOT NULL,
    fecha_resolucion timestamp(3) without time zone,
    estado text NOT NULL,
    motivo_rechazo text,
    observaciones text,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone NOT NULL
);


--
-- Name: Inscripcion_id_inscripcion_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."Inscripcion_id_inscripcion_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: Inscripcion_id_inscripcion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."Inscripcion_id_inscripcion_seq" OWNED BY public."Inscripcion".id_inscripcion;


--
-- Name: Localidad; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Localidad" (
    id_localidad integer NOT NULL,
    nombre text NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone NOT NULL,
    departamento text,
    id_georef text,
    latitud double precision,
    longitud double precision,
    provincia text
);


--
-- Name: Localidad_id_localidad_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."Localidad_id_localidad_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: Localidad_id_localidad_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."Localidad_id_localidad_seq" OWNED BY public."Localidad".id_localidad;


--
-- Name: Pabellon; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Pabellon" (
    id_pabellon integer NOT NULL,
    numero integer NOT NULL,
    nombre text NOT NULL,
    descripcion text,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone NOT NULL
);


--
-- Name: Pabellon_id_pabellon_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."Pabellon_id_pabellon_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: Pabellon_id_pabellon_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."Pabellon_id_pabellon_seq" OWNED BY public."Pabellon".id_pabellon;


--
-- Name: Producto; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Producto" (
    id_producto integer NOT NULL,
    id_artesano integer NOT NULL,
    id_categoria integer NOT NULL,
    nombre text NOT NULL,
    descripcion text,
    precio numeric(65,30) NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone NOT NULL
);


--
-- Name: Producto_id_producto_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."Producto_id_producto_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: Producto_id_producto_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."Producto_id_producto_seq" OWNED BY public."Producto".id_producto;


--
-- Name: Rol; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Rol" (
    id_rol integer NOT NULL,
    nombre text NOT NULL,
    descripcion text,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone NOT NULL
);


--
-- Name: Rol_id_rol_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."Rol_id_rol_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: Rol_id_rol_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."Rol_id_rol_seq" OWNED BY public."Rol".id_rol;


--
-- Name: Rubro; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Rubro" (
    id_rubro integer NOT NULL,
    nombre text NOT NULL,
    descripcion text,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone NOT NULL
);


--
-- Name: Rubro_id_rubro_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."Rubro_id_rubro_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: Rubro_id_rubro_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."Rubro_id_rubro_seq" OWNED BY public."Rubro".id_rubro;


--
-- Name: Solicitud; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Solicitud" (
    id_solicitud integer NOT NULL,
    id_artesano integer NOT NULL,
    estado text DEFAULT 'PENDIENTE'::text NOT NULL,
    motivo_rechazo text,
    observaciones text,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone NOT NULL
);


--
-- Name: Solicitud_id_solicitud_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."Solicitud_id_solicitud_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: Solicitud_id_solicitud_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."Solicitud_id_solicitud_seq" OWNED BY public."Solicitud".id_solicitud;


--
-- Name: Stand; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Stand" (
    id_stand integer NOT NULL,
    id_zona integer NOT NULL,
    numero integer NOT NULL,
    descripcion text,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone NOT NULL
);


--
-- Name: Stand_id_stand_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."Stand_id_stand_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: Stand_id_stand_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."Stand_id_stand_seq" OWNED BY public."Stand".id_stand;


--
-- Name: TokenRevocado; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."TokenRevocado" (
    jti text NOT NULL,
    "venceEn" timestamp(3) without time zone NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: Usuario; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Usuario" (
    id_usuario uuid NOT NULL,
    email text NOT NULL,
    "passwordHash" text NOT NULL,
    id_rol integer DEFAULT 2 NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone NOT NULL,
    nombre text NOT NULL,
    activo boolean DEFAULT true NOT NULL
);


--
-- Name: Zona; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Zona" (
    id_zona integer NOT NULL,
    id_pabellon integer NOT NULL,
    numero integer NOT NULL,
    nombre text NOT NULL,
    descripcion text,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone NOT NULL
);


--
-- Name: Zona_id_zona_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."Zona_id_zona_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: Zona_id_zona_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."Zona_id_zona_seq" OWNED BY public."Zona".id_zona;


--
-- Name: _prisma_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);


--
-- Name: Artesano id_artesano; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Artesano" ALTER COLUMN id_artesano SET DEFAULT nextval('public."Artesano_id_artesano_seq"'::regclass);


--
-- Name: Categoria id_categoria; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Categoria" ALTER COLUMN id_categoria SET DEFAULT nextval('public."Categoria_id_categoria_seq"'::regclass);


--
-- Name: Inscripcion id_inscripcion; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Inscripcion" ALTER COLUMN id_inscripcion SET DEFAULT nextval('public."Inscripcion_id_inscripcion_seq"'::regclass);


--
-- Name: Localidad id_localidad; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Localidad" ALTER COLUMN id_localidad SET DEFAULT nextval('public."Localidad_id_localidad_seq"'::regclass);


--
-- Name: Pabellon id_pabellon; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Pabellon" ALTER COLUMN id_pabellon SET DEFAULT nextval('public."Pabellon_id_pabellon_seq"'::regclass);


--
-- Name: Producto id_producto; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Producto" ALTER COLUMN id_producto SET DEFAULT nextval('public."Producto_id_producto_seq"'::regclass);


--
-- Name: Rol id_rol; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Rol" ALTER COLUMN id_rol SET DEFAULT nextval('public."Rol_id_rol_seq"'::regclass);


--
-- Name: Rubro id_rubro; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Rubro" ALTER COLUMN id_rubro SET DEFAULT nextval('public."Rubro_id_rubro_seq"'::regclass);


--
-- Name: Solicitud id_solicitud; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Solicitud" ALTER COLUMN id_solicitud SET DEFAULT nextval('public."Solicitud_id_solicitud_seq"'::regclass);


--
-- Name: Stand id_stand; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Stand" ALTER COLUMN id_stand SET DEFAULT nextval('public."Stand_id_stand_seq"'::regclass);


--
-- Name: Zona id_zona; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Zona" ALTER COLUMN id_zona SET DEFAULT nextval('public."Zona_id_zona_seq"'::regclass);


--
-- Data for Name: Artesano; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Artesano" (id_artesano, id_usuario, nombre, apellido, dni, telefono, direccion, descripcion, instagram, id_localidad, id_rubro, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: Categoria; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Categoria" (id_categoria, nombre, descripcion, created_at, updated_at) FROM stdin;
1	Ponchos y Mantas	Prendas mayores tejidas en telar criollo	2026-11-08 23:05:23.892	2026-11-08 23:05:23.892
2	Chales y Bufandas	Accesorios textiles artesanales	2026-11-08 23:05:23.893	2026-11-08 23:05:23.893
3	Piezas de Cerámica	Vasijas, cuencos y esculturas en barro cocido	2026-11-08 23:05:23.894	2026-11-08 23:05:23.894
4	Joyería en Rodocrosita	Anillos, dijes y aros con piedra nacional	2026-11-08 23:05:23.895	2026-11-08 23:05:23.895
\.


--
-- Data for Name: Inscripcion; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Inscripcion" (id_inscripcion, id_artesano, id_stand, anio, fecha_solicitud, fecha_resolucion, estado, motivo_rechazo, observaciones, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: Localidad; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Localidad" (id_localidad, nombre, created_at, updated_at, departamento, id_georef, latitud, longitud, provincia) FROM stdin;
1	Hocker	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Colón	30008050	-32.088313118	-58.339488507	Entre Ríos
2	Simoca	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Simoca	90091050	-27.262904015	-65.357917302	Tucumán
3	Abralaite	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Cochinoca	38007030	-23.169146969	-65.793877601	Jujuy
4	Cerrito	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Paraná	30084050	-31.579939027	-60.075546703	Entre Ríos
5	Pieres	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Lobería	06476040	-38.394116934	-58.672376625	Buenos Aires
6	Ayacucho	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Ayacucho	06042010	-37.152760991	-58.488379175	Buenos Aires
7	La Constancia	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Ayacucho	06042020	-37.226346599	-58.760104413	Buenos Aires
8	Solanet	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Ayacucho	06042030	-36.842874855	-58.508167569	Buenos Aires
9	Udaquiola	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Ayacucho	06042040	-36.562367904	-58.534696319	Buenos Aires
10	Napaleofú	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Balcarce	06063030	-37.62307067	-58.746368507	Buenos Aires
11	Ramos Otero	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Balcarce	06063040	-37.54089492	-58.340605119	Buenos Aires
12	Villa Laguna La Brava	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Balcarce	06063060	-37.861223079	-57.981012024	Buenos Aires
13	Castelli	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Castelli	06168010	-36.090917851	-57.807478999	Buenos Aires
14	Mar del Sur	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	General Alvarado	06280020	-38.343656482	-57.992208541	Buenos Aires
15	Miramar	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	General Alvarado	06280040	-38.270461018	-57.839854455	Buenos Aires
16	General Juan Madariaga	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	General Juan Madariaga	06315010	-36.995291945	-57.136861256	Buenos Aires
17	General Lavalle	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	General Lavalle	06336020	-36.408086093	-56.943357844	Buenos Aires
18	Barrio El Boquerón	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	General Pueyrredón	06357020	-38.0269032	-57.795545892	Buenos Aires
19	Barrio Santa Paula	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	General Pueyrredón	06357060	-37.930541065	-57.683640356	Buenos Aires
20	Chapadmalal	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	General Pueyrredón	06357080	-38.170949159	-57.639771267	Buenos Aires
21	Mar del Plata	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	General Pueyrredón	06357110	-37.997610575	-57.548162215	Buenos Aires
22	San Clemente del Tuyú	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	La Costa	06420030	-36.354193125	-56.725679308	Buenos Aires
23	Santa Teresita - Mar del Tuyú	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	La Costa	06420040	-36.581421317	-56.689898449	Buenos Aires
24	Arenas Verdes	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Lobería	06476010	-38.545072468	-58.55735447	Buenos Aires
25	Lobería	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Lobería	06476030	-38.163384929	-58.781846799	Buenos Aires
26	Tamangueyú	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Lobería	06476060	-38.201990536	-58.73914694	Buenos Aires
27	Maipú	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Maipú	06511020	-36.862958702	-57.883123322	Buenos Aires
28	Santo Domingo	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Maipú	06511030	-36.711559778	-57.586167451	Buenos Aires
29	Coronel Vidal	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Mar Chiquita	06518010	-37.446516204	-57.729391766	Buenos Aires
30	La Armonía	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Mar Chiquita	06518030	-37.773986335	-57.634189526	Buenos Aires
31	Mar Chiquita	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Mar Chiquita	06518040	-37.745539478	-57.425410275	Buenos Aires
32	Santa Clara del Mar	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Mar Chiquita	06518060	-37.834380174	-57.507490265	Buenos Aires
33	Casalins	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Pila	06630010	-36.316360805	-58.551429369	Buenos Aires
34	Carhué	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Adolfo Alsina	06007010	-37.179483265	-62.75999039	Buenos Aires
35	Espartillar	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Adolfo Alsina	06007040	-37.357410999	-62.438379793	Buenos Aires
36	Adolfo Gonzales Chaves	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Adolfo Gonzales Chaves	06014010	-38.032370729	-60.099391928	Buenos Aires
37	De La Garma	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Adolfo Gonzales Chaves	06014020	-37.966541728	-60.416785485	Buenos Aires
38	16 de Julio	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Azul	06049050	-37.200514968	-60.164653346	Buenos Aires
39	Hale	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Bolívar	06105010	-36.002064335	-60.855489815	Buenos Aires
40	San Carlos de Bolívar	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Bolívar	06105060	-36.229879267	-61.113917084	Buenos Aires
41	Urdampilleta	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Bolívar	06105070	-36.43161907	-61.420100225	Buenos Aires
42	Villa Lynch Pueyrredón	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Bolívar	06105080	-36.601531573	-61.363665984	Buenos Aires
43	Bellocq	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Carlos Casares	06147010	-35.916616773	-61.534113496	Buenos Aires
44	Hortensia	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Carlos Casares	06147050	-35.924233179	-61.262850776	Buenos Aires
45	Coronel Pringles	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Coronel Pringles	06196010	-37.985667775	-61.350397431	Buenos Aires
46	El Divisorio	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Coronel Pringles	06196020	-38.323280665	-61.44427556	Buenos Aires
47	Cascada	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Coronel Suárez	06203010	-37.292500093	-62.297196204	Buenos Aires
48	Curamalal	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Coronel Suárez	06203030	-37.484246938	-62.104557716	Buenos Aires
49	D'Orbigny	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Coronel Suárez	06203040	-37.676545574	-61.707744337	Buenos Aires
50	Pasman	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Coronel Suárez	06203060	-37.223639849	-62.164754634	Buenos Aires
51	Santa María	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Coronel Suárez	06203080	-37.558405246	-61.874449411	Buenos Aires
52	Andant	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Daireaux	06231010	-36.560065158	-62.139019203	Buenos Aires
53	Arboledas	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Daireaux	06231020	-36.883152328	-61.487719881	Buenos Aires
54	La Larga	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Daireaux	06231040	-36.675500343	-61.928336352	Buenos Aires
55	Salazar	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Daireaux	06231060	-36.307182012	-62.202998568	Buenos Aires
56	General Alvear	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	General Alvear	06287010	-36.021741877	-60.014505384	Buenos Aires
57	Casbas	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Guaminí	06399020	-36.757700351	-62.504382463	Buenos Aires
58	General La Madrid	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	General La Madrid	06322010	-37.249667284	-61.262199209	Buenos Aires
59	Pontaut	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	General La Madrid	06322050	-37.731749854	-61.323607151	Buenos Aires
60	Garré	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Guaminí	06399030	-36.561897227	-62.604408607	Buenos Aires
61	Laguna Alsina	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Guaminí	06399050	-36.807563564	-62.247966121	Buenos Aires
62	Henderson	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Hipólito Yrigoyen	06406010	-36.298177124	-61.718562385	Buenos Aires
63	Herrera Vegas	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Hipólito Yrigoyen	06406020	-36.087557544	-61.410898388	Buenos Aires
64	Recalde	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Olavarría	06595080	-36.651788449	-61.085906327	Buenos Aires
65	Colonia San Miguel	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Olavarría	06595040	-36.948754783	-60.111444317	Buenos Aires
66	Hinojo	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Olavarría	06595060	-36.86584318	-60.160281998	Buenos Aires
67	Sierras Bayas	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Olavarría	06595110	-36.936611908	-60.156057877	Buenos Aires
68	Villa Alfredo Fortabat	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Olavarría	06595120	-36.981004938	-60.278601724	Buenos Aires
69	Capitán Castro	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Pehuajó	06609010	-35.912408463	-62.22422799	Buenos Aires
70	Francisco Madero	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Pehuajó	06609030	-35.849397922	-62.066647205	Buenos Aires
71	Juan José Paso	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Pehuajó	06609040	-35.849370285	-62.294717631	Buenos Aires
72	Nueva Plata	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Pehuajó	06609070	-35.918649644	-61.81354751	Buenos Aires
73	Pehuajó	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Pehuajó	06609080	-35.810805333	-61.898968213	Buenos Aires
74	17 de Agosto	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Puán	06651040	-37.909750691	-62.93563898	Buenos Aires
75	Villa Castelar	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Puán	06651100	-37.394921424	-62.803444347	Buenos Aires
76	Arroyo Corto	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Saavedra	06700010	-37.51488223	-62.312248649	Buenos Aires
77	Goyena	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Saavedra	06700050	-37.721018771	-62.606454847	Buenos Aires
78	Las Encadenadas	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Saavedra	06700055	-38.037033156	-62.469833465	Buenos Aires
79	Pigüé	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Saavedra	06700060	-37.602548713	-62.408361485	Buenos Aires
80	Crotto	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Tapalqué	06798010	-36.57636308	-60.172200762	Buenos Aires
81	Tapalqué	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Tapalqué	06798020	-36.356235977	-60.025112403	Buenos Aires
82	Sierra de la Ventana	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Tornquist	06819030	-38.131175064	-61.800032724	Buenos Aires
83	Tres Picos	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Tornquist	06819050	-38.28960556	-62.208055581	Buenos Aires
84	La Gruta	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Tornquist	06819060	-38.059727662	-62.077625025	Buenos Aires
85	Berutti	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Trenque Lauquen	06826010	-35.852631939	-62.512378076	Buenos Aires
86	Girodias	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Trenque Lauquen	06826020	-36.365748391	-62.358079998	Buenos Aires
87	La Carreta	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Trenque Lauquen	06826030	-36.20373136	-62.235463626	Buenos Aires
88	30 de Agosto	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Trenque Lauquen	06826040	-36.278647645	-62.545224004	Buenos Aires
89	San Mayol	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Tres Arroyos	06833090	-38.318013618	-60.027620924	Buenos Aires
90	Ingeniero Thompson	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Tres Lomas	06847010	-36.610923177	-62.912934777	Buenos Aires
91	Barrio El Taladro	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Cañuelas	06134020	-35.071451539	-58.865309649	Buenos Aires
92	Cañuelas	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Cañuelas	06134030	-35.05383883	-58.761991187	Buenos Aires
93	Santa Rosa	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Cañuelas	06134060	-34.960845385	-58.728762459	Buenos Aires
94	Uribelarrea	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Cañuelas	06134070	-35.123830511	-58.892036442	Buenos Aires
95	Gorchs	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	General Belgrano	06301020	-35.672069646	-58.958410415	Buenos Aires
96	General Las Heras	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	General Las Heras	06329020	-34.92690929	-58.946706953	Buenos Aires
97	Villars	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	General Las Heras	06329060	-34.826044661	-58.939018869	Buenos Aires
98	Lobos	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Lobos	06483040	-35.185425547	-59.097834161	Buenos Aires
99	Salvador María	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Lobos	06483050	-35.300670997	-59.170135916	Buenos Aires
100	Barrio Santa Rosa	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Marcos Paz	06525010	-34.951537566	-58.780450023	Buenos Aires
101	Marcos Paz	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Marcos Paz	06525020	-34.782495898	-58.83788909	Buenos Aires
102	Abbott	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Monte	06547010	-35.28132425	-58.802783358	Buenos Aires
103	San Miguel del Monte	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Monte	06547020	-35.441043881	-58.803451448	Buenos Aires
104	Zenón Videla Dorna	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Monte	06547030	-35.54208449	-58.886450754	Buenos Aires
105	Navarro	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Navarro	06574030	-35.005906715	-59.278283983	Buenos Aires
106	Carlos Beguerie	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Roque Pérez	06693010	-35.48563921	-59.099769566	Buenos Aires
107	Azul	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Azul	06049020	-36.777447	-59.863443046	Buenos Aires
108	Cacharí	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Azul	06049030	-36.376673005	-59.504604217	Buenos Aires
109	Balcarce	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Balcarce	06063010	-37.846382623	-58.255491169	Buenos Aires
110	Los Pinos	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Balcarce	06063020	-37.942709752	-58.32427674	Buenos Aires
111	San Agustín	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Balcarce	06063050	-38.014111278	-58.35593425	Buenos Aires
112	López	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Benito Juárez	06084030	-37.552280337	-59.627766619	Buenos Aires
113	Tedín Uriburu	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Benito Juárez	06084040	-37.364271855	-59.760202926	Buenos Aires
114	Villa Cacique	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Benito Juárez	06084050	-37.676225444	-59.396186471	Buenos Aires
115	Centro Guerrero	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Castelli	06168020	-36.055467874	-57.821096217	Buenos Aires
116	Cerro de la Gloria	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Castelli	06168030	-35.974860451	-57.449535438	Buenos Aires
117	Dolores	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Dolores	06238010	-36.315389184	-57.675461555	Buenos Aires
118	Sevigne	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Dolores	06238020	-36.206925251	-57.742699767	Buenos Aires
119	Comandante Nicanor Otamendi	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	General Alvarado	06280010	-38.110549783	-57.841245608	Buenos Aires
120	Mechongué	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	General Alvarado	06280030	-38.146222184	-58.229243432	Buenos Aires
121	General Guido	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	General Guido	06308010	-36.643166588	-57.790502395	Buenos Aires
122	Labardén	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	General Guido	06308020	-36.948966365	-58.103567635	Buenos Aires
123	Pavón	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	General Lavalle	06336030	-36.710748622	-56.737082635	Buenos Aires
124	El Marquesado	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	General Pueyrredón	06357090	-38.22861156	-57.754407057	Buenos Aires
125	Sierra de los Padres	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	General Pueyrredón	06357120	-37.941287946	-57.775364441	Buenos Aires
126	Coronel Boerr	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Las Flores	06455010	-35.940461089	-59.068086887	Buenos Aires
127	El Trigo	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Las Flores	06455020	-35.880275623	-59.406070527	Buenos Aires
128	Las Flores	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Las Flores	06455030	-36.014268753	-59.099863977	Buenos Aires
129	Pardo	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Las Flores	06455040	-36.245041111	-59.365035051	Buenos Aires
130	Licenciado Matienzo	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Lobería	06476020	-37.908510622	-58.912554211	Buenos Aires
131	San Manuel	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Lobería	06476050	-37.786485875	-58.848486716	Buenos Aires
132	Las Armas	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Maipú	06511010	-37.086333288	-57.829420071	Buenos Aires
133	General Pirán	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Mar Chiquita	06518020	-37.275973858	-57.774196638	Buenos Aires
134	Mar de Cobo	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Mar Chiquita	06518050	-37.773700541	-57.454391247	Buenos Aires
135	Vivoratá	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Mar Chiquita	06518070	-37.663155091	-57.668120806	Buenos Aires
136	Claraz	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Necochea	06581010	-37.893430413	-59.291069564	Buenos Aires
137	Juan N. Fernández	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Necochea	06581030	-38.005522797	-59.263923456	Buenos Aires
138	Nicanor Olivera	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Necochea	06581050	-38.283051908	-59.202743773	Buenos Aires
139	Pila	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Pila	06630020	-36.004185241	-58.141067696	Buenos Aires
140	Pinamar	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Pinamar	06644010	-37.111081116	-56.865233689	Buenos Aires
141	Rauch	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Rauch	06672010	-36.774414707	-59.088289143	Buenos Aires
142	De la Canal	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Tandil	06791010	-37.127286584	-59.105380805	Buenos Aires
143	Tandil	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Tandil	06791050	-37.328695483	-59.136897557	Buenos Aires
144	Velloso	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Tapalqué	06798030	-36.12056972	-59.651868835	Buenos Aires
145	General Conesa	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Tordillo	06812010	-36.520860508	-57.324938712	Buenos Aires
146	Villa Gesell	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Villa Gesell	06868020	-37.263230508	-56.974558609	Buenos Aires
147	Arroyo Cabral	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	General San Martín	14042020	-32.489493401	-63.402375774	Córdoba
148	Ausonia	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	General San Martín	14042030	-32.661795002	-63.243112954	Córdoba
149	Chazón	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	General San Martín	14042040	-33.077868683	-63.275068808	Córdoba
150	Etruria	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	General San Martín	14042050	-32.939231616	-63.245008029	Córdoba
151	La Laguna	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	General San Martín	14042060	-32.802526464	-63.247093341	Córdoba
152	La Palestina	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	General San Martín	14042070	-32.616434572	-63.409399232	Córdoba
153	Las Mojarras	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	General San Martín	14042090	-32.304333301	-63.233436456	Córdoba
154	Luca	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	General San Martín	14042100	-32.54050567	-63.476893221	Córdoba
155	Pasco	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	General San Martín	14042110	-32.746218035	-63.341735757	Córdoba
156	Sanabria	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	General San Martín	14042120	-32.528293028	-63.24801631	Córdoba
157	Ticino	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	General San Martín	14042140	-32.693126807	-63.437106525	Córdoba
158	Tío Pujio	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	General San Martín	14042150	-32.287073328	-63.353681296	Córdoba
159	Villa María	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	General San Martín	14042170	-32.413504193	-63.248329033	Córdoba
160	Villa Nueva	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	General San Martín	14042180	-32.435476413	-63.247857579	Córdoba
161	Villa Oeste	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	General San Martín	14042190	-32.416942409	-63.283458353	Córdoba
162	Alejandro Roca	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Juárez Celman	14056010	-33.353561142	-63.717734591	Córdoba
163	Assunta	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Juárez Celman	14056020	-33.634165386	-63.225622094	Córdoba
164	Bengolea	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Juárez Celman	14056030	-33.024771502	-63.669895805	Córdoba
165	Carnerillo	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Juárez Celman	14056040	-32.91314825	-64.022579957	Córdoba
166	Charras	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Juárez Celman	14056050	-33.025379108	-64.04687455	Córdoba
167	El Rastreador	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Juárez Celman	14056060	-33.666183448	-63.539332916	Córdoba
168	General Cabrera	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Juárez Celman	14056070	-32.814572954	-63.874957223	Córdoba
169	General Deheza	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Juárez Celman	14056080	-32.756327256	-63.789132549	Córdoba
170	Huanchillas	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Juárez Celman	14056090	-33.668490297	-63.636259222	Córdoba
171	La Carlota	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Juárez Celman	14056100	-33.417977676	-63.293628941	Córdoba
172	Los Cisnes	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Juárez Celman	14056110	-33.400358381	-63.472388894	Córdoba
173	Olaeta	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Juárez Celman	14056120	-33.044761449	-63.906066645	Córdoba
174	Pacheco de Melo	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Juárez Celman	14056130	-33.758446019	-63.490302326	Córdoba
175	Paso del Durazno	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Juárez Celman	14056140	-33.170736857	-64.047763039	Córdoba
176	Santa Eufemia	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Juárez Celman	14056150	-33.176479137	-63.286607639	Córdoba
177	Ucacha	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Juárez Celman	14056160	-33.031440048	-63.506119892	Córdoba
178	Villa Reducción	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Juárez Celman	14056170	-33.203113808	-63.862645526	Córdoba
179	Chucul	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Río Cuarto	14098080	-33.009337122	-64.169974786	Córdoba
180	Las Acequias	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Río Cuarto	14098150	-33.280282336	-63.97537615	Córdoba
181	Las Peñas	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Río Cuarto	14098180	-32.534705705	-64.104572596	Córdoba
182	Paso del Durazno	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Río Cuarto	14098220	-33.168558774	-64.048921712	Córdoba
183	Dalmacio Vélez	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Tercero Arriba	14161040	-32.608600362	-63.583491031	Córdoba
184	General Fotheringham	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Tercero Arriba	14161050	-32.322414209	-63.868471659	Córdoba
185	Hernando	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Tercero Arriba	14161060	-32.427881395	-63.733471104	Córdoba
186	James Craik	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Tercero Arriba	14161070	-32.161431346	-63.467969816	Córdoba
187	Las Isletillas	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Tercero Arriba	14161080	-32.509219089	-63.928956041	Córdoba
188	Las Perdices	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Tercero Arriba	14161090	-32.698955828	-63.704674205	Córdoba
189	Pampayasta Norte	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Tercero Arriba	14161120	-32.240997225	-63.642975566	Córdoba
190	Pampayasta Sud	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Tercero Arriba	14161130	-32.250502076	-63.651676236	Córdoba
191	Punta del Agua	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Tercero Arriba	14161140	-32.575805707	-63.810209503	Córdoba
192	Río Tercero	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Tercero Arriba	14161150	-32.176739374	-64.112962841	Córdoba
193	Tancacha	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Tercero Arriba	14161160	-32.237584813	-63.979865775	Córdoba
194	Villa Ascasubi	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Tercero Arriba	14161170	-32.162738587	-63.892422433	Córdoba
195	Ballesteros	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Unión	14182040	-32.541697047	-62.980810867	Córdoba
196	Ballesteros Sud	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Unión	14182050	-32.589478061	-63.030218272	Córdoba
197	Idiazabal	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Unión	14182130	-32.812536019	-63.032397104	Córdoba
198	Laborde	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Unión	14182150	-33.154839841	-62.85747619	Córdoba
199	Morrison	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Unión	14182180	-32.592865391	-62.833340645	Córdoba
200	Ordoñez	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Unión	14182200	-32.841007328	-62.865985554	Córdoba
201	Pascanas	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Unión	14182210	-33.124700409	-63.040124716	Córdoba
202	Ramón J. Cárcano	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Unión	14182230	-32.491157532	-63.104233635	Córdoba
203	San Severo	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Unión	14182260	-33.53865363	-63.047474609	Córdoba
204	Wenceslao Escalante	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Unión	14182290	-33.171677002	-62.769416108	Córdoba
205	Agua de Oro	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Colón	14021010	-31.062228855	-64.300640522	Córdoba
206	Ascochinga	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Colón	14021020	-30.959035894	-64.2733494	Córdoba
207	El Manzano	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Colón	14021110	-31.084230839	-64.29869766	Córdoba
208	La Calera	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Colón	14021150	-31.345792617	-64.338487315	Córdoba
209	La Granja	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Colón	14021160	-31.008624164	-64.267893428	Córdoba
210	Mendiolaza	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Colón	14021200	-31.26404437	-64.309127773	Córdoba
211	Río Ceballos	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Colón	14021230	-31.16975013	-64.317504169	Córdoba
212	Saldán	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Colón	14021240	-31.315306214	-64.303528682	Córdoba
213	Salsipuedes	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Colón	14021250	-31.142353597	-64.297418474	Córdoba
214	Unquillo	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Colón	14021280	-31.237152375	-64.311763694	Córdoba
215	Villa Allende	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Colón	14021290	-31.293649626	-64.297701308	Córdoba
216	Villa Cerro Azul	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Colón	14021300	-31.070665182	-64.316235393	Córdoba
217	Bañado de Soto	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Cruz del Eje	14028020	-30.79513069	-65.052641451	Córdoba
218	Cruz de Caña	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Cruz del Eje	14028040	-31.067836217	-64.934787016	Córdoba
219	Cruz del Eje	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Cruz del Eje	14028050	-30.743928785	-64.790776263	Córdoba
220	El Brete	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Cruz del Eje	14028060	-30.672634806	-64.871898458	Córdoba
221	La Higuera	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Cruz del Eje	14028110	-31.013290293	-65.102896199	Córdoba
222	Las Cañadas	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Cruz del Eje	14028120	-30.914993056	-64.734725361	Córdoba
223	Las Playas	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Cruz del Eje	14028130	-30.706740607	-64.847295853	Córdoba
224	Media Naranja	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Cruz del Eje	14028150	-30.644076685	-64.928256127	Córdoba
225	San Marcos Sierra	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Cruz del Eje	14028170	-30.783012898	-64.636189565	Córdoba
226	Villa de Soto	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Cruz del Eje	14028200	-30.855231264	-64.98489144	Córdoba
227	Avellaneda	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Ischilín	14049010	-30.594290437	-64.205686954	Córdoba
228	Cañada de Río Pinto	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Ischilín	14049020	-30.775791186	-64.218650968	Córdoba
229	Copacabana	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Ischilín	14049040	-30.642902029	-64.499504305	Córdoba
230	Villa Gutiérrez	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Ischilín	14049120	-30.679205536	-64.16015406	Córdoba
231	San Carlos Minas	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Minas	14070060	-31.176558441	-65.101820118	Córdoba
232	Los Talares	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Pocho	14077030	-31.407147248	-65.047018417	Córdoba
233	Salsacate	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Pocho	14077040	-31.317857577	-65.089525308	Córdoba
234	San Gerónimo	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Pocho	14077050	-31.344184492	-64.919048275	Córdoba
235	Tala Cañada	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Pocho	14077060	-31.354488484	-64.97590613	Córdoba
236	Bialet Massé	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Punilla	14091020	-31.313905309	-64.464035018	Córdoba
237	Cabalango	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Punilla	14091030	-31.390556962	-64.560305553	Córdoba
238	Capilla del Monte	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Punilla	14091040	-30.856869166	-64.526350522	Córdoba
239	Casa Grande	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Punilla	14091050	-31.152841555	-64.473454564	Córdoba
240	Charbonier	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Punilla	14091060	-30.774979058	-64.544169334	Córdoba
241	Cosquín	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Punilla	14091070	-31.243668282	-64.46534855	Córdoba
242	Cuesta Blanca	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Punilla	14091080	-31.480334849	-64.578692179	Córdoba
243	Estancia Vieja	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Punilla	14091090	-31.382027434	-64.531421861	Córdoba
244	Huerta Grande	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Punilla	14091100	-31.075289467	-64.490828014	Córdoba
245	La Cumbre	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Punilla	14091110	-30.982133781	-64.494197593	Córdoba
246	La Falda	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Punilla	14091120	-31.09442652	-64.482947648	Córdoba
247	Las Jarillas	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Punilla	14091130	-31.517419234	-64.534184307	Córdoba
248	Los Cocos	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Punilla	14091140	-30.926464684	-64.500392389	Córdoba
249	Mallín	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Punilla	14091150	-31.297021853	-64.573254363	Córdoba
250	Mayu Sumaj	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Punilla	14091160	-31.47227156	-64.541469681	Córdoba
251	San Antonio de Arredondo	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Punilla	14091180	-31.482791879	-64.527810481	Córdoba
252	San Esteban	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Punilla	14091190	-30.921140762	-64.536371463	Córdoba
253	San Roque	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Punilla	14091200	-31.34529886	-64.451103393	Córdoba
254	Santa María de Punilla	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Punilla	14091210	-31.275638255	-64.463627265	Córdoba
255	Tala Huasi	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Punilla	14091220	-31.4733149	-64.566943062	Córdoba
256	Tanti	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Punilla	14091230	-31.354796397	-64.592347253	Córdoba
257	Valle Hermoso	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Punilla	14091240	-31.113961203	-64.485158944	Córdoba
258	Villa Carlos Paz	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Punilla	14091250	-31.41791694	-64.494029164	Córdoba
259	Villa Flor Serrana	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Punilla	14091260	-31.390545252	-64.595688724	Córdoba
260	Villa Giardino	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Punilla	14091270	-31.050271932	-64.496785385	Córdoba
261	Villa Lago Azul	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Punilla	14091280	-31.373409821	-64.483197685	Córdoba
262	Villa Parque Siquimán	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Punilla	14091290	-31.346455506	-64.482448759	Córdoba
263	Villa Río Icho Cruz	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Punilla	14091300	-31.482675029	-64.564726293	Córdoba
264	Villa Santa Cruz del Lago	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Punilla	14091320	-31.36638134	-64.521998593	Córdoba
265	Ambul	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	San Alberto	14126010	-31.490541	-65.053952156	Córdoba
266	Mussi	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	San Alberto	14126100	-31.436262783	-65.066006533	Córdoba
267	Panaholma	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	San Alberto	14126120	-31.632953599	-65.054953292	Córdoba
268	San Lorenzo	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	San Alberto	14126140	-31.670919664	-65.017720994	Córdoba
269	Malagueño	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Santa María	14147210	-31.467399279	-64.359021202	Córdoba
270	Alta Gracia	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Santa María	14147010	-31.649792126	-64.429871976	Córdoba
271	Barrio Gilbert (1º de Mayo) - Tejas Tres	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Santa María	14147030	-31.439710418	-64.317995652	Córdoba
272	Bouwer	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Santa María	14147050	-31.558132699	-64.190690257	Córdoba
273	Falda del Cañete	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Santa María	14147100	-31.525410945	-64.450923137	Córdoba
274	Falda del Carmen	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Santa María	14147110	-31.585357624	-64.454648181	Córdoba
275	Los Cedros	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Santa María	14147190	-31.526144321	-64.28452442	Córdoba
276	Rafael García	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Santa María	14147240	-31.645100027	-64.259398689	Córdoba
277	Villa del Prado	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Santa María	14147320	-31.621286368	-64.394138002	Córdoba
278	Villa Parque Santa Ana	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Santa María	14147350	-31.592623953	-64.347082591	Córdoba
279	La Pampa	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Totoral	14168040	-30.942230382	-64.276935116	Córdoba
280	Santa Catalina	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Totoral	14168080	-30.870098328	-64.23328834	Córdoba
281	El Espinillo	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	General Güemes	22063010	-25.408798321	-60.447784868	Chaco
282	Fortín Lavalle	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	General Güemes	22063040	-25.704490244	-60.201485546	Chaco
283	Juan José Castelli	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	General Güemes	22063060	-25.946578929	-60.620067045	Chaco
284	Miraflores	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	General Güemes	22063070	-25.649424978	-60.930187454	Chaco
285	Villa Río Bermejito	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	General Güemes	22063100	-25.637554926	-60.26543677	Chaco
286	Zaparinqui	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	General Güemes	22063120	-26.065792017	-60.561926701	Chaco
287	Pampa del Indio	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Libertador General San Martín	22084060	-26.049025	-59.942753581	Chaco
288	Estanislao del Campo	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Patiño	34035050	-25.053546274	-60.090638521	Formosa
289	Ibarreta	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Patiño	34035080	-25.214499757	-59.858892437	Formosa
290	Juan G. Bazán	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Patiño	34035090	-24.54299923	-60.832908644	Formosa
291	Las Lomitas	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Patiño	34035100	-24.708135606	-60.591376883	Formosa
292	Pozo del Tigre	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Patiño	34035120	-24.895553545	-60.319184515	Formosa
293	San Martín I	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Patiño	34035130	-24.53246612	-59.902120592	Formosa
294	Subteniente Perín	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Patiño	34035150	-25.535408824	-60.018824327	Formosa
295	El Sauzal	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	General Güemes	22063020	-24.57851406	-61.534954814	Chaco
296	Nueva Pompeya	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	General Güemes	22063080	-24.933074618	-61.483145173	Chaco
297	Wichi	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	General Güemes	22063110	-24.690329442	-61.426130338	Chaco
298	San Bernardo	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	9 de Julio	82077065	-28.667411838	-61.528016638	Santa Fe
299	Gregoria Pérez de Denis	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	9 de Julio	82077030	-28.227452799	-61.527816018	Santa Fe
300	Villa Minetti	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	9 de Julio	82077090	-28.622961222	-61.626763494	Santa Fe
301	Santa Margarita	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	9 de Julio	82077070	-28.313823651	-61.548754328	Santa Fe
302	Pozo Borrado	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	9 de Julio	82077060	-28.938083722	-61.704872956	Santa Fe
303	Tostado	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	9 de Julio	82077080	-29.232729704	-61.771207863	Santa Fe
304	Sachayoj	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Alberdi	86014040	-26.675407254	-61.815044365	Santiago del Estero
305	Pampa de los Guanacos	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Copo	86056070	-26.230182279	-61.836474121	Santiago del Estero
306	La Nena	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	General Taboada	86077040	-28.452299668	-61.838315907	Santiago del Estero
307	El Cuadrado	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Juan Felipe Ibarra	86098020	-28.228376871	-61.802075566	Santiago del Estero
308	Arroyo Barú	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Colón	30008010	-31.86728984	-58.448308582	Entre Ríos
309	Colón	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Colón	30008020	-32.225050079	-58.142269502	Entre Ríos
310	Colonia Hugues	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Colón	30008030	-32.295698692	-58.233708068	Entre Ríos
311	Hambis	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Colón	30008040	-31.963630618	-58.507729763	Entre Ríos
312	La Clarita	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Colón	30008060	-31.975752234	-58.392431333	Entre Ríos
313	Pueblo Cazes	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Colón	30008070	-32.003149586	-58.490794269	Entre Ríos
314	Pueblo Liebig's	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Colón	30008080	-32.154190205	-58.192078892	Entre Ríos
315	San José	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Colón	30008090	-32.207718833	-58.218798941	Entre Ríos
316	Ubajay	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Colón	30008100	-31.795177823	-58.315065321	Entre Ríos
317	Villa Elisa	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Colón	30008110	-32.163218743	-58.400531576	Entre Ríos
318	Calabacilla	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Concordia	30015010	-31.507003424	-58.133046985	Entre Ríos
319	Clodomiro Ledesma	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Concordia	30015020	-31.576667693	-58.180333915	Entre Ríos
320	Colonia General Roca	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Concordia	30015040	-31.35085093	-58.085076783	Entre Ríos
321	Concordia	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Concordia	30015060	-31.391964817	-58.017007785	Entre Ríos
322	Estación Yeruá	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Concordia	30015080	-31.471106729	-58.26332981	Entre Ríos
323	Estación Yuquerí	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Concordia	30015083	-31.398216857	-58.162435867	Entre Ríos
324	Estancia Grande	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Concordia	30015087	-31.439167054	-58.119570245	Entre Ríos
325	La Criolla	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Concordia	30015090	-31.269113391	-58.108827732	Entre Ríos
326	Nueva Escocia	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Concordia	30015110	-31.649616532	-58.016335683	Entre Ríos
327	Osvaldo Magnasco	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Concordia	30015120	-31.313102939	-58.059322469	Entre Ríos
328	Pedernal	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Concordia	30015130	-31.671973069	-58.230581357	Entre Ríos
329	Puerto Yeruá	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Concordia	30015140	-31.531358498	-58.015182705	Entre Ríos
330	General Campos	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	San Salvador	30088010	-31.523376199	-58.405804539	Entre Ríos
331	San Salvador	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	San Salvador	30088020	-31.624960879	-58.505032006	Entre Ríos
332	1º de Mayo	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Uruguay	30098090	-32.255373171	-58.422600193	Entre Ríos
333	Pronunciamiento	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Uruguay	30098100	-32.346007062	-58.444177912	Entre Ríos
334	Jubileo	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Villaguay	30113030	-31.731207659	-58.635717569	Entre Ríos
335	Barrio Los Pioneros (Barrio Tavella)	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Campana	06126020	-34.252524213	-58.959743539	Buenos Aires
336	Campana	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Campana	06126030	-34.16325402	-58.95920775	Buenos Aires
337	Escobar	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Escobar	06252010	-34.346045734	-58.794415465	Buenos Aires
338	Tupelí	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	25 de Mayo	70126020	-31.836114355	-68.358515746	San Juan
339	Capilla del Señor	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Exaltación de la Cruz	06266020	-34.294140042	-59.099270981	Buenos Aires
340	Diego Gaynor	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Exaltación de la Cruz	06266030	-34.286760259	-59.222105908	Buenos Aires
341	Los Cardales	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Exaltación de la Cruz	06266040	-34.33075431	-58.987062904	Buenos Aires
342	Parada Robles - Pavón	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Exaltación de la Cruz	06266060	-34.375087489	-59.123203922	Buenos Aires
343	La Choza	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	General Las Heras	06329030	-34.782849218	-59.109652356	Buenos Aires
344	Plomer	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	General Las Heras	06329050	-34.794571503	-59.03116095	Buenos Aires
345	General Rodríguez	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	General Rodríguez	06364030	-34.606431069	-58.952160636	Buenos Aires
346	General San Martín	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	General San Martín	06371010	-34.577910096	-58.538656474	Buenos Aires
347	Hurlingham	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Hurlingham	06408010	-34.589871884	-58.637441026	Buenos Aires
348	Ituzaingó	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Ituzaingó	06410010	-34.660388494	-58.666167513	Buenos Aires
349	José C. Paz	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	José C. Paz	06412010	-34.523193843	-58.751943503	Buenos Aires
350	La Matanza	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	La Matanza	06427010	-34.67760672	-58.561008241	Buenos Aires
351	Carlos Keen	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Luján	06497020	-34.486751826	-59.219546215	Buenos Aires
352	Club de Campo Los Puentes	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Luján	06497025	-34.570187875	-59.025260651	Buenos Aires
353	Luján	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Luján	06497060	-34.56335741	-59.121118319	Buenos Aires
354	Olivera	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Luján	06497070	-34.627893595	-59.255199726	Buenos Aires
355	Torres	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Luján	06497090	-34.43099166	-59.127864237	Buenos Aires
356	Malvinas Argentinas	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Malvinas Argentinas	06515010	-34.498795201	-58.701087604	Buenos Aires
357	Goldney	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Mercedes	06532005	-34.601990271	-59.287448719	Buenos Aires
358	Jorge Born	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Mercedes	06532030	-34.697676984	-59.318525783	Buenos Aires
359	Merlo	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Merlo	06539010	-34.664983228	-58.727948114	Buenos Aires
360	Moreno	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Moreno	06560010	-34.651292328	-58.790001915	Buenos Aires
361	Morón	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Morón	06568010	-34.651057923	-58.621854098	Buenos Aires
362	Pilar	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Pilar	06638040	-34.458696526	-58.913967912	Buenos Aires
363	Solís	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	San Andrés de Giles	06728050	-34.298040883	-59.323681617	Buenos Aires
364	Villa Ruiz	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	San Andrés de Giles	06728070	-34.43167821	-59.261552139	Buenos Aires
365	San Fernando	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	San Fernando	06749010	-34.440604481	-58.558148942	Buenos Aires
366	San Isidro	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	San Isidro	06756010	-34.466428522	-58.509689813	Buenos Aires
367	San Miguel	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	San Miguel	06760010	-34.543041602	-58.711968988	Buenos Aires
368	Tigre	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Tigre	06805010	-34.42264926	-58.580875289	Buenos Aires
369	Tres de Febrero	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Tres de Febrero	06840010	-34.603529173	-58.563192266	Buenos Aires
370	Vicente López	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Vicente López	06861010	-34.508944163	-58.486154865	Buenos Aires
371	Diadema Argentina	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Escalante	26021040	-45.774964785	-67.674774138	Chubut
372	Camarones	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Florentino Ameghino	26028010	-44.798454874	-65.710332751	Chubut
373	Garayalde	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Florentino Ameghino	26028020	-44.686845009	-66.620939954	Chubut
374	Aldea Apeleg	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Río Senguer	26084010	-44.687639351	-70.85291291	Chubut
375	Aldea Beleiro	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Río Senguer	26084020	-45.55326821	-71.522636668	Chubut
376	Alto Río Senguer	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Río Senguer	26084030	-45.041882273	-70.823383603	Chubut
377	Doctor Ricardo Rojas	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Río Senguer	26084040	-45.575664061	-71.035053015	Chubut
378	Facundo	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Río Senguer	26084050	-45.308642884	-69.974862491	Chubut
379	Lago Blanco	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Río Senguer	26084060	-45.936983544	-71.268242948	Chubut
380	Río Mayo	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Río Senguer	26084070	-45.686176998	-70.256637958	Chubut
381	Buen Pasto	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Sarmiento	26091010	-45.07613335	-69.458898569	Chubut
382	La Ramada	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Burruyacú	90007050	-26.686558145	-64.948144355	Tucumán
383	Barrio San Jorge	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Burruyacú	90007010	-26.676850829	-65.045695722	Tucumán
384	Colombres	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Cruz Alta	90014040	-26.885424244	-65.099833398	Tucumán
385	Banda del Río Salí	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Cruz Alta	90014020	-26.839969946	-65.161859511	Tucumán
386	La Florida	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Cruz Alta	90014080	-26.820712729	-65.095386488	Tucumán
387	Los Ralos	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Cruz Alta	90014100	-26.889419859	-64.997011329	Tucumán
388	El Bracho	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Cruz Alta	90014070	-26.99216892	-65.181904372	Tucumán
389	San Andrés	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Cruz Alta	90014130	-26.888178723	-65.193552033	Tucumán
390	Ranchillos	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Cruz Alta	90014120	-26.957214925	-65.044492672	Tucumán
391	Alderetes	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Cruz Alta	90014010	-26.820225872	-65.143321212	Tucumán
392	Colonia Mayo - Barrio La Milagrosa	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Cruz Alta	90014050	-26.833753553	-64.988184668	Tucumán
393	Delfín Gallo	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Cruz Alta	90014060	-26.84424367	-65.093192456	Tucumán
394	Pacará	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Cruz Alta	90014110	-26.899242427	-65.14962568	Tucumán
395	Famaillá	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Famaillá	90028030	-27.054515777	-65.401890752	Tucumán
396	Campo de Herrera	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Famaillá	90028020	-27.026397413	-65.345625814	Tucumán
397	Ingenio Fronterita	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Famaillá	90028040	-27.03092713	-65.460392413	Tucumán
398	Río Colorado	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Leales	90056060	-27.148605721	-65.356950305	Tucumán
399	Los Puestos	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Leales	90056030	-27.281836654	-65.019438333	Tucumán
400	Santa Rosa de Leales	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Leales	90056070	-27.137714015	-65.260868828	Tucumán
401	Bella Vista	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Leales	90056010	-27.032791929	-65.307089863	Tucumán
402	Estación Aráoz	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Leales	90056020	-27.055148564	-64.9212945	Tucumán
403	Villa de Leales	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Leales	90056090	-27.193830737	-65.310242514	Tucumán
404	Villa Fiad - Ingenio Leales	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Leales	90056080	-27.06774724	-65.235448752	Tucumán
405	Manuel García Fernández	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Leales	90056040	-26.955703391	-65.272073063	Tucumán
406	Lules	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Lules	90063050	-26.922184268	-65.337715824	Tucumán
407	Ingenio San Pablo	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Lules	90063030	-26.869992213	-65.310892532	Tucumán
408	Barrio San Felipe	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Lules	90063010	-26.872104997	-65.232453531	Tucumán
409	La Reducción	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Lules	90063040	-26.957602742	-65.350550652	Tucumán
410	El Manantial	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Lules	90063020	-26.848052942	-65.281860743	Tucumán
411	Acheral	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Monteros	90070010	-27.120720505	-65.470564718	Tucumán
412	San Miguel de Tucumán	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Capital	90084010	-26.830388762	-65.203779703	Tucumán
413	Villa Mariano Moreno - El Colmenar	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Tafí Viejo	90105100	-26.775828017	-65.209092441	Tucumán
414	Yerba Buena - Marcos Paz	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Yerba Buena	90119030	-26.816041685	-65.292538306	Tucumán
415	Andalhualá	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Santa María	10091010	-26.877358909	-66.047409811	Catamarca
416	Chañar Punco	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Santa María	10091030	-26.721940949	-66.066941137	Catamarca
417	El Desmonte	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Santa María	10091050	-26.883232729	-66.101663459	Catamarca
418	El Puesto	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Santa María	10091060	-26.677248296	-66.04058805	Catamarca
419	Famatanca	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Santa María	10091070	-26.768363372	-66.082603147	Catamarca
420	Las Mojarras	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Santa María	10091110	-26.695690849	-66.066651978	Catamarca
421	Punta de Balasto	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Santa María	10091130	-26.953387115	-66.136231793	Catamarca
422	San José	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Santa María	10091140	-26.80124478	-66.069733311	Catamarca
423	Santa María	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Santa María	10091150	-26.694525092	-66.047966934	Catamarca
424	Yapes	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Santa María	10091160	-26.834037549	-66.033601546	Catamarca
425	Teniente Berdina	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Monteros	90070090	-27.05033755	-65.487702719	Tucumán
426	Pueblo Independencia	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Monteros	90070040	-27.219521104	-65.52732927	Tucumán
427	Capitán Cáceres	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Monteros	90070020	-27.190069926	-65.604732387	Tucumán
428	Soldado Maldonado	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Monteros	90070080	-27.144104076	-65.565435782	Tucumán
429	Sargento Moya	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Monteros	90070070	-27.228154384	-65.660016711	Tucumán
430	Río Seco	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Monteros	90070050	-27.26840118	-65.557353955	Tucumán
431	Villa Quinteros	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Monteros	90070100	-27.252889145	-65.54920352	Tucumán
432	Santa Lucía	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Monteros	90070060	-27.092774371	-65.532518397	Tucumán
433	Monteros	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Monteros	90070030	-27.16528714	-65.497218288	Tucumán
434	Tafí del Valle	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Tafí del Valle	90098040	-26.851944894	-65.710690161	Tucumán
435	El Mollar	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Tafí del Valle	90098030	-26.939796158	-65.709194971	Tucumán
436	Bañado de Ovanta	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Santa Rosa	10098020	-28.106287028	-65.31925669	Catamarca
437	Las Cañas	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Santa Rosa	10098030	-28.204722358	-65.214386235	Catamarca
438	Lavalle	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Santa Rosa	10098040	-28.195029894	-65.114334947	Catamarca
439	San Pedro	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Santa Rosa	10098070	-27.956622281	-65.171175039	Catamarca
440	Lavalle	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Guasayán	86084010	-28.194511097	-65.10766565	Santiago del Estero
441	San Pedro	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Guasayán	86084020	-27.95589693	-65.168496153	Santiago del Estero
442	Mansupa	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Río Hondo	86147090	-27.458402318	-64.907771753	Santiago del Estero
443	Colonia Tinco	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Río Hondo	86147030	-27.414801325	-64.94077123	Santiago del Estero
444	La Nueva Donosa	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Río Hondo	86147060	-27.44217907	-64.946108823	Santiago del Estero
445	Villa Turística del Embalse de Rio Hondo	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Río Hondo	86147160	-27.514297064	-64.906949647	Santiago del Estero
446	Taco Ralo	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Graneros	90035030	-27.835068384	-65.19460177	Tucumán
447	Lamadrid	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Graneros	90035020	-27.645065055	-65.246850324	Tucumán
448	Villa Chicligasta	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Simoca	90091060	-27.434081537	-65.16424076	Tucumán
449	Monteagudo	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Simoca	90091020	-27.510776782	-65.27732954	Tucumán
450	Atahona	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Simoca	90091010	-27.416867355	-65.286681154	Tucumán
451	Lima	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Zárate	06882040	-34.044794887	-59.196149154	Buenos Aires
452	Zárate	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Zárate	06882050	-34.09580509	-59.024323231	Buenos Aires
453	Aldea Asunción	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Gualeguay	30049010	-32.82470911	-59.239118153	Entre Ríos
454	Estación Lazo	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Gualeguay	30049020	-32.87081324	-59.422330369	Entre Ríos
455	General Galarza	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Gualeguay	30049030	-32.720484663	-59.39570656	Entre Ríos
456	Gualeguay	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Gualeguay	30049040	-33.15043008	-59.310575586	Entre Ríos
457	Puerto Ruiz	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Gualeguay	30049050	-33.221824173	-59.36546489	Entre Ríos
458	Aldea San Antonio	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Gualeguaychú	30056010	-32.625174726	-58.70442364	Entre Ríos
459	Aldea San Juan	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Gualeguaychú	30056020	-32.695958313	-58.771751966	Entre Ríos
460	Enrique Carbó	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Gualeguaychú	30056030	-33.145461072	-59.208055823	Entre Ríos
461	Estación Escriña	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Gualeguaychú	30056035	-32.592130204	-58.905928284	Entre Ríos
462	Faustino M. Parera	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Gualeguaychú	30056040	-32.804430236	-58.882633679	Entre Ríos
463	General Almada	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Gualeguaychú	30056050	-32.83738899	-58.802648974	Entre Ríos
464	Gilbert	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Gualeguaychú	30056060	-32.535832166	-58.934009989	Entre Ríos
465	Gualeguaychú	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Gualeguaychú	30056070	-33.007797697	-58.510770086	Entre Ríos
466	Irazusta	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Gualeguaychú	30056080	-32.92586532	-58.949648514	Entre Ríos
467	Larroque	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Gualeguaychú	30056090	-33.036521531	-58.999086203	Entre Ríos
468	Pastor Britos	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Gualeguaychú	30056095	-32.770237103	-58.906294384	Entre Ríos
469	Pueblo General Belgrano	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Gualeguaychú	30056100	-33.01737328	-58.475033211	Entre Ríos
470	Urdinarrain	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Gualeguaychú	30056110	-32.691046099	-58.888420076	Entre Ríos
471	Ceibas	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Islas del Ibicuy	30063020	-33.499414342	-58.800355262	Entre Ríos
472	Ibicuy	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Islas del Ibicuy	30063030	-33.742476857	-59.157590208	Entre Ríos
473	Médanos	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Islas del Ibicuy	30063040	-33.435774048	-59.068857296	Entre Ríos
474	Villa Paranacito	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Islas del Ibicuy	30063060	-33.715603477	-58.6652645	Entre Ríos
475	Estación Arroyo Clé	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Tala	30091030	-32.635031039	-59.401503424	Entre Ríos
476	Gobernador Mansilla	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Tala	30091050	-32.545435872	-59.356618806	Entre Ríos
477	Caseros	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Uruguay	30098020	-32.462118892	-58.479321323	Entre Ríos
478	Colonia Elía	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Uruguay	30098030	-32.670403334	-58.325351359	Entre Ríos
479	Concepción del Uruguay	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Uruguay	30098040	-32.484661266	-58.232120779	Entre Ríos
480	Herrera	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Uruguay	30098060	-32.433784475	-58.634653236	Entre Ríos
481	Villa San Justo	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Uruguay	30098140	-32.445604455	-58.435429769	Entre Ríos
482	Fortín Soledad	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Bermejo	34007003	-24.148753512	-60.689961406	Formosa
483	Guadalcazar	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Bermejo	34007005	-23.672947932	-61.163607603	Formosa
484	Laguna Yema	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Bermejo	34007010	-24.255524629	-61.241985111	Formosa
485	Lamadrid	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Bermejo	34007015	-23.896946974	-60.754546867	Formosa
486	Los Chiriguanos	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Bermejo	34007020	-24.098814349	-61.461974295	Formosa
487	Pozo del Mortero	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Bermejo	34007040	-24.407167571	-61.026207823	Formosa
488	Fortín Cabo 1º Lugones	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Patiño	34035060	-24.286422629	-59.8276786	Formosa
489	Posta Cambio Zalazar	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Patiño	34035110	-24.210788936	-60.197262428	Formosa
490	San Martín II	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	Patiño	34035140	-24.433734103	-59.654904791	Formosa
491	Loma Blanca	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	General Belgrano	46063030	-30.641007569	-66.242631721	La Rioja
492	Chañar	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	General Belgrano	46063020	-30.541440759	-65.956064208	La Rioja
493	Olta	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	General Belgrano	46063040	-30.630676407	-66.267251085	La Rioja
494	Portezuelo	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	General Juan Facundo Quiroga	46070030	-30.836906371	-66.701802673	La Rioja
495	Malanzán	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	General Juan Facundo Quiroga	46070010	-30.804670547	-66.604234252	La Rioja
496	Nácate	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	General Juan Facundo Quiroga	46070020	-30.85290735	-66.424951296	La Rioja
497	San Antonio	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	General Juan Facundo Quiroga	46070040	-31.085345617	-66.731592082	La Rioja
498	Milagro	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	General Ortiz de Ocampo	46084030	-31.005816576	-65.992395166	La Rioja
499	Ambil	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	General Ortiz de Ocampo	46084010	-31.129579112	-66.343920837	La Rioja
500	Colonia Ortiz de Ocampo	2026-11-08 23:05:59.597	2026-11-08 23:05:59.597	General Ortiz de Ocampo	46084020	-30.962785081	-66.17669303	La Rioja
501	Olpas	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	General Ortiz de Ocampo	46084040	-30.806183145	-66.243957452	La Rioja
502	Santa Rita de Catuna	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	General Ortiz de Ocampo	46084050	-30.954712505	-66.220689325	La Rioja
503	Ulapes	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	General San Martín	46091010	-31.57274656	-66.237533257	La Rioja
504	Chepes	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Rosario Vera Peñaloza	46112010	-31.340973587	-66.591923156	La Rioja
505	Desiderio Tello	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Rosario Vera Peñaloza	46112020	-31.212496849	-66.31443074	La Rioja
506	Candelaria	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Ayacucho	74007010	-32.061268221	-65.824815266	San Luis
507	El Rincón	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Albardón	70007010	-31.448212463	-68.541203009	San Juan
508	Villa General San Martín - Campo Afuera	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Albardón	70007020	-31.439784762	-68.520386679	San Juan
509	Villa El Salvador - Villa Sefair	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Angaco	70014020	-31.453269651	-68.40376008	San Juan
510	Las Tapias	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Angaco	70014010	-31.410387096	-68.399309845	San Juan
511	San Juan	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Capital	70028010	-31.537259036	-68.525017206	San Juan
512	Bermejo	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Caucete	70035010	-31.588505209	-67.656992499	San Juan
513	Caucete	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Caucete	70035020	-31.651480611	-68.281978511	San Juan
514	Las Talas - Los Médanos	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Caucete	70035040	-31.596786098	-68.275178788	San Juan
515	Pie de Palo	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Caucete	70035060	-31.661265178	-68.219700178	San Juan
516	Vallecito	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Caucete	70035070	-31.734640519	-67.982870671	San Juan
517	Villa Independencia	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Caucete	70035080	-31.624583019	-68.313925469	San Juan
518	Marayes	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Caucete	70035050	-31.463440255	-67.351506831	San Juan
519	El Rincón	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Caucete	70035030	-31.670130607	-68.317305806	San Juan
520	Chimbas	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Chimbas	70042010	-31.493266302	-68.53256519	San Juan
521	Mogna	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Jáchal	70056040	-30.695384637	-68.360307617	San Juan
522	Alto de Sierra	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	9 de Julio	70063010	-31.538932967	-68.413921101	San Juan
523	Las Chacritas	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	9 de Julio	70063030	-31.594193519	-68.400512529	San Juan
524	9 de Julio	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	9 de Julio	70063040	-31.669750518	-68.39004171	San Juan
525	Villa Centenario	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Pocito	70070060	-31.695055263	-68.573253973	San Juan
526	Barrio Ruta 40	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Pocito	70070010	-31.859042298	-68.536945449	San Juan
527	Villa Aberastain - La Rinconada	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Pocito	70070040	-31.65804257	-68.579413431	San Juan
528	Carpintería	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Pocito	70070020	-31.819219879	-68.541344785	San Juan
529	Villa Barboza - Villa Nacusi	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Pocito	70070050	-31.596436238	-68.542632758	San Juan
530	Quinto Cuartel	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Pocito	70070030	-31.613321526	-68.601203106	San Juan
531	Barrio Municipal	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Pocito	70070005	-31.752800799	-68.553127262	San Juan
532	Rawson	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Rawson	70077010	-31.581887286	-68.542113859	San Juan
533	Villa Bolaños (Médano de Oro)	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Rawson	70077020	-31.628935674	-68.480377306	San Juan
534	Rivadavia	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Rivadavia	70084010	-31.53244252	-68.597140608	San Juan
535	Dos Acequias	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Martín	70091020	-31.494856547	-68.416819206	San Juan
536	Villa Don Bosco	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Martín	70091060	-31.553816095	-68.338975493	San Juan
537	Villa Dominguito	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Martín	70091050	-31.559162298	-68.30050206	San Juan
538	Villa San Martín	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Martín	70091070	-31.516685032	-68.350119443	San Juan
539	Barrio Sadop - Bella Vista	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Martín	70091010	-31.53421478	-68.398474265	San Juan
540	Villa del Salvador	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Martín	70091040	-31.465280777	-68.411157688	San Juan
541	San Isidro	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Martín	70091030	-31.487148616	-68.324786527	San Juan
542	Santa Lucía	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Santa Lucía	70098010	-31.540541852	-68.49786893	San Juan
543	Los Berros	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Sarmiento	70105070	-31.952830718	-68.654147469	San Juan
544	Cañada Honda	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Sarmiento	70105010	-31.985127177	-68.548663309	San Juan
545	Cienaguita	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Sarmiento	70105020	-32.077161085	-68.693531008	San Juan
546	Colonia Fiscal	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Sarmiento	70105030	-31.902206559	-68.470713211	San Juan
547	Punta del Médano	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Sarmiento	70105090	-31.894183386	-68.418761032	San Juan
548	Villa Media Agua	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Sarmiento	70105100	-31.981446827	-68.426672744	San Juan
549	Pedernal	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Sarmiento	70105080	-31.996410287	-68.763950032	San Juan
550	Divisadero	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Sarmiento	70105040	-32.007271723	-68.693871725	San Juan
551	Las Lagunas	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Sarmiento	70105060	-32.044149347	-68.367960456	San Juan
552	Villa Ibáñez	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Ullum	70112010	-31.465692425	-68.734714267	San Juan
553	Chucuma	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Valle Fértil	70119030	-31.069416137	-67.282111243	San Juan
554	Villa San Agustín	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Valle Fértil	70119060	-30.634640561	-67.467821288	San Juan
555	Astica	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Valle Fértil	70119010	-30.955056193	-67.304474781	San Juan
556	El Encón	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	25 de Mayo	70126010	-32.217057209	-67.795767069	San Juan
557	Villa Borjas - La Chimbera	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	25 de Mayo	70126030	-31.810153688	-68.3284492	San Juan
558	Villa Santa Rosa	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	25 de Mayo	70126050	-31.744817771	-68.31429108	San Juan
559	Villa El Tango	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	25 de Mayo	70126040	-31.749256303	-68.23608654	San Juan
560	Villa Basilio Nievas	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Zonda	70133010	-31.550210096	-68.731328594	San Juan
561	Aluminé	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Aluminé	58007010	-39.238469802	-70.915952619	Neuquén
562	Moquehue	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Aluminé	58007015	-38.942119232	-71.329011951	Neuquén
563	Villa Pehuenia	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Aluminé	58007020	-38.882063027	-71.173153212	Neuquén
564	Las Coloradas	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Catán Lil	58021010	-39.556406849	-70.594152662	Neuquén
565	Piedra del Águila	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Collón Curá	58028010	-40.048479475	-70.075016026	Neuquén
566	Santo Tomás	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Collón Curá	58028020	-39.820743846	-70.100517315	Neuquén
567	Junín de los Andes	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Huiliches	58049010	-39.950884943	-71.07086358	Neuquén
568	San Martín de los Andes	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Lácar	58056010	-40.156937939	-71.352714326	Neuquén
569	Villa Lago Meliquina	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Lácar	58056020	-40.383250927	-71.253397816	Neuquén
570	Chorriaca	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Loncopué	58063010	-37.936840956	-70.100367124	Neuquén
571	Loncopué	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Loncopué	58063020	-38.073089622	-70.61444659	Neuquén
572	Villa Traful	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Los Lagos	58070020	-40.654358109	-71.400039168	Neuquén
573	Caviahue	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Ñorquín	58084010	-37.871079702	-71.055058253	Neuquén
574	Copahue	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Ñorquín	58084020	-37.8188588	-71.098778599	Neuquén
575	El Huecú	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Ñorquín	58084040	-37.644907696	-70.581024799	Neuquén
576	Paso Aguerre	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Picún Leufú	58098010	-39.338783703	-69.843596696	Neuquén
577	Bajada del Agrio	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Picunches	58105010	-38.40743814	-70.033105591	Neuquén
578	La Buitrera	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Picunches	58105020	-38.552230388	-70.369430961	Neuquén
579	Las Lajas	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Picunches	58105030	-38.523414946	-70.361640644	Neuquén
580	Quili Malal	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Picunches	58105040	-38.326149936	-69.813541099	Neuquén
581	Los Catutos	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Zapala	58112010	-38.83735609	-70.198417632	Neuquén
582	Mariano Moreno	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Zapala	58112020	-38.761336255	-70.036359662	Neuquén
583	Zapala	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Zapala	58112040	-38.902934355	-70.064211217	Neuquén
584	Mencué	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	El Cuy	62035050	-40.423641317	-69.614527411	Río Negro
585	Naupa Huen	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	El Cuy	62035060	-39.830224744	-69.509124071	Río Negro
586	Aguada Guzmán	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	El Cuy	62035010	-39.98185576	-68.873867888	Río Negro
587	Santa Isabel	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Chalileo	42049010	-36.230195151	-66.938973642	La Pampa
588	La Humada	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Chical Co	42063020	-36.34903888	-68.013520726	La Pampa
589	La Reforma	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Limay Mahuida	42091010	-37.551184545	-66.227108865	La Pampa
590	Malargüe	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Malargüe	50077040	-35.468373998	-69.584707553	Mendoza
591	Las Leñas	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Malargüe	50077030	-35.147610614	-70.082130749	Mendoza
592	Jaime Prats	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Rafael	50105110	-34.910291579	-67.820477321	Mendoza
593	Punta del Agua	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Rafael	50105170	-35.527636001	-68.078559731	Mendoza
594	Chos Malal	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Chos Malal	58042010	-37.374827881	-70.276331075	Neuquén
595	Tricao Malal	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Chos Malal	58042020	-37.044736731	-70.32482026	Neuquén
596	Villa del Curi Leuvú	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Chos Malal	58042030	-37.131143383	-70.397733822	Neuquén
597	Andacollo	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Minas	58077010	-37.179745045	-70.669959796	Neuquén
598	Las Ovejas	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Minas	58077030	-36.988972916	-70.749520791	Neuquén
599	Los Miches	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Minas	58077040	-37.205444005	-70.819223195	Neuquén
600	Manzano Amargo	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Minas	58077050	-36.753091528	-70.763213858	Neuquén
601	Villa del Nahueve	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Minas	58077070	-37.120280497	-70.770019635	Neuquén
602	Huinganco	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Minas	58077020	-37.16073741	-70.624091503	Neuquén
603	Varvarco	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Minas	58077060	-36.854788152	-70.678151974	Neuquén
604	El Cholar	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Ñorquín	58084030	-37.441481036	-70.64544559	Neuquén
605	Taquimilán	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Ñorquín	58084050	-37.517446618	-70.248757275	Neuquén
606	Barrancas	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Pehuenches	58091010	-36.821283998	-69.915284287	Neuquén
607	Buta Ranquil	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Pehuenches	58091020	-37.0516079	-69.877794918	Neuquén
608	Martín de Loyola	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Gobernador Dupuy	74042100	-35.712453031	-66.353856587	San Luis
609	Los Overos	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Gobernador Dupuy	74042090	-35.877477917	-66.453175847	San Luis
610	La Maroma	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Gobernador Dupuy	74042080	-35.213922352	-66.329486114	San Luis
611	Aristóbulo del Valle	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Cainguás	54014010	-27.095675651	-54.893417614	Misiones
612	Campo Grande	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Cainguás	54014020	-27.207959476	-54.9797024	Misiones
613	Dos de Mayo Nucleo III (Bº Bernardino Rivadavia)	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Cainguás	54014050	-27.013338352	-54.608156134	Misiones
614	1º de Mayo	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Cainguás	54014060	-27.167990846	-55.029062705	Misiones
615	Pueblo Illia	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Cainguás	54014070	-27.152577496	-54.560736192	Misiones
616	Salto Encantado	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Cainguás	54014080	-27.087322576	-54.833367327	Misiones
617	Kilómetro 17	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Cainguás	54014055	-27.315740141	-54.90272589	Misiones
618	Dos de Mayo	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Cainguás	54014030	-27.019936773	-54.684530968	Misiones
619	El Soberbio	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Guaraní	54056010	-27.297511036	-54.197545618	Misiones
620	Fracrán	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Guaraní	54056020	-26.743431869	-54.297453716	Misiones
621	San Vicente	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Guaraní	54056030	-26.993297387	-54.486618972	Misiones
622	Capioví	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Libertador General San Martín	54077010	-26.928315109	-55.057298119	Misiones
623	El Alcázar	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Libertador General San Martín	54077020	-26.713647149	-54.814047833	Misiones
624	Garuhapé	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Libertador General San Martín	54077030	-26.82112566	-54.957745426	Misiones
625	Mbopicuá	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Libertador General San Martín	54077040	-26.863850723	-55.045161981	Misiones
626	Puerto Rico	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Libertador General San Martín	54077060	-26.808591683	-55.022126841	Misiones
627	Ruiz de Montoya	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Libertador General San Martín	54077070	-26.970432634	-55.052222493	Misiones
628	San Alberto	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Libertador General San Martín	54077080	-26.8082371	-54.989473162	Misiones
629	San Miguel	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Libertador General San Martín	54077100	-26.853657763	-54.888792406	Misiones
630	Villa Bonita	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Oberá	54091120	-27.482900344	-54.964832653	Misiones
631	Villa Akerman	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Libertador General San Martín	54077110	-26.943328445	-55.095519014	Misiones
632	Villa Urrutia	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Libertador General San Martín	54077120	-26.836892679	-54.753063052	Misiones
633	Puerto Leoni	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Libertador General San Martín	54077050	-26.989846797	-55.165880966	Misiones
634	San Gotardo	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Libertador General San Martín	54077090	-26.923731746	-55.123754287	Misiones
635	Capioviciño	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Libertador General San Martín	54077015	-26.891713188	-55.072239959	Misiones
636	Tarumá	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Montecarlo	54084060	-26.71743571	-54.720061426	Misiones
637	Caraguatay	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Montecarlo	54084010	-26.657281001	-54.739179523	Misiones
638	Barrio Escuela 633	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Oberá	54091017	-27.470355482	-55.080588446	Misiones
639	Campo Ramón	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Oberá	54091020	-27.454268759	-55.02294777	Misiones
640	Campo Viera	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Oberá	54091030	-27.330971609	-55.054252029	Misiones
641	General Alvear	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Oberá	54091050	-27.426346833	-55.169603448	Misiones
642	Los Helechos	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Oberá	54091070	-27.557663325	-55.076263385	Misiones
643	Oberá	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Oberá	54091080	-27.486790956	-55.120056983	Misiones
644	Panambí	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Oberá	54091090	-27.722028043	-54.91482578	Misiones
645	Panambí Kilómetro 8	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Oberá	54091100	-27.668501221	-54.98267866	Misiones
646	Panambi Kilómetro 15	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Oberá	54091105	-27.709150325	-54.967449514	Misiones
647	Barrio Escuela 461	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Oberá	54091013	-27.624459224	-55.039467996	Misiones
648	Colonia Polana	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Ignacio	54098010	-26.981993392	-55.318225555	Misiones
649	Corpus	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Ignacio	54098020	-27.12946852	-55.510831451	Misiones
650	General Urquiza	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Ignacio	54098040	-27.107866319	-55.376616132	Misiones
651	Gobernador Roca	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Ignacio	54098050	-27.190061162	-55.469319313	Misiones
652	Helvecia	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Ignacio	54098060	-27.109734297	-55.344458449	Misiones
653	Hipólito Yrigoyen	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Ignacio	54098070	-27.085711125	-55.287419647	Misiones
654	Oasis	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Ignacio	54098090	-26.971725847	-55.249723491	Misiones
655	Roca Chica	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Ignacio	54098100	-27.214245842	-55.420017265	Misiones
656	San Ignacio	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Ignacio	54098110	-27.25861333	-55.538974794	Misiones
657	Jardín América	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Ignacio	54098080	-27.04315879	-55.227018022	Misiones
658	Santo Pipó	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Ignacio	54098120	-27.140123992	-55.408509286	Misiones
659	Barrio Tungoil	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Ignacio	54098005	-27.114815163	-55.383870621	Misiones
660	Florentino Ameghino	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Javier	54105010	-27.633616944	-55.085526088	Misiones
661	Mojón Grande	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Javier	54105030	-27.712041381	-55.157433976	Misiones
662	Paraíso	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Pedro	54112020	-26.687072887	-54.203073206	Misiones
663	Alba Posse	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	25 de Mayo	54119010	-27.568951129	-54.683040628	Misiones
664	Alicia Baja	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	25 de Mayo	54119025	-27.439400874	-54.353709309	Misiones
665	Colonia Aurora	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	25 de Mayo	54119030	-27.473724594	-54.524108784	Misiones
666	San Francisco de Asís	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	25 de Mayo	54119040	-27.462654524	-54.745318069	Misiones
667	Santa Rita	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	25 de Mayo	54119050	-27.520323789	-54.727907695	Misiones
668	25 de Mayo	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	25 de Mayo	54119060	-27.378178704	-54.744877516	Misiones
669	Alicia Alta	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	25 de Mayo	54119020	-27.377818217	-54.35209801	Misiones
670	Russell	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Maipú	50070080	-33.005845686	-68.796625647	Mendoza
671	Las Violetas	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Lavalle	50056140	-32.822516195	-68.604881164	Mendoza
672	Mendoza	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Capital	50007010	-32.889732553	-68.844444231	Mendoza
673	3 de Mayo	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Lavalle	50056150	-32.680470537	-68.639226937	Mendoza
674	Godoy Cruz	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Godoy Cruz	50021010	-32.92533457	-68.844281463	Mendoza
675	Colonia Segovia	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Guaymallén	50028010	-32.847600925	-68.714112383	Mendoza
676	Guaymallén	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Guaymallén	50028020	-32.900052082	-68.787677631	Mendoza
677	La Primavera	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Guaymallén	50028030	-32.922136956	-68.671097878	Mendoza
678	Los Corralitos	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Guaymallén	50028040	-32.901068352	-68.697581867	Mendoza
679	Puente de Hierro	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Guaymallén	50028050	-32.867475517	-68.675808681	Mendoza
680	Ingeniero Giagnoni	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Junín	50035010	-33.127825029	-68.412388526	Mendoza
681	Junín	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Junín	50035020	-33.14653115	-68.487269074	Mendoza
682	La Colonia	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Junín	50035030	-33.098941369	-68.480499524	Mendoza
683	Medrano	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Junín	50035050	-33.176773295	-68.615165408	Mendoza
684	Phillips	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Junín	50035060	-33.200980765	-68.377492855	Mendoza
685	Rodríguez Peña	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Junín	50035070	-33.120442619	-68.595162564	Mendoza
686	Los Barriales	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Junín	50035040	-33.099679353	-68.568805968	Mendoza
687	Barrio Alto del Olvido	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Lavalle	50056010	-32.669650548	-68.580001232	Mendoza
688	Barrio Jocolí II	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Lavalle	50056020	-32.656666235	-68.658949134	Mendoza
689	Barrio La Pega	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Lavalle	50056040	-32.808016056	-68.669546791	Mendoza
690	Barrio Los Jarilleros	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Lavalle	50056060	-32.716304541	-68.652106137	Mendoza
691	Barrio Los Olivos	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Lavalle	50056070	-32.679323003	-68.331868782	Mendoza
692	Barrio Virgen del Rosario	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Lavalle	50056075	-32.701821351	-68.314515343	Mendoza
693	Ingeniero Gustavo André	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Lavalle	50056110	-32.679459669	-68.317058465	Mendoza
694	Villa Tulumaya	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Lavalle	50056160	-32.721449195	-68.595775724	Mendoza
695	Costa de Araujo	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Lavalle	50056080	-32.757640309	-68.408271872	Mendoza
696	Barrio Perdriel IV	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Luján de Cuyo	50063020	-33.076682897	-68.913798513	Mendoza
697	Costa Flores	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Luján de Cuyo	50063040	-33.058226667	-68.931871203	Mendoza
698	Luján de Cuyo	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Luján de Cuyo	50063090	-33.039170875	-68.879552317	Mendoza
699	Perdriel	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Luján de Cuyo	50063100	-33.074903187	-68.888395288	Mendoza
700	Ugarteche	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Luján de Cuyo	50063120	-33.212070153	-68.891350898	Mendoza
701	Barrancas	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Maipú	50070010	-33.081832868	-68.727615194	Mendoza
702	Rodeo del Medio	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Maipú	50070070	-32.99486843	-68.685965956	Mendoza
703	San Roque	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Maipú	50070090	-33.033240792	-68.586123145	Mendoza
704	Andrade	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Rivadavia	50084010	-33.17267675	-68.502346509	Mendoza
705	Barrio Cooperativa Los Campamentos	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Rivadavia	50084020	-33.272992595	-68.413460094	Mendoza
706	Los Campamentos	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Rivadavia	50084100	-33.275493232	-68.392579526	Mendoza
707	Reducción de Abajo	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Rivadavia	50084130	-33.221613921	-68.557484136	Mendoza
708	Rivadavia	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Rivadavia	50084140	-33.195765472	-68.465922877	Mendoza
709	Santa María de Oro	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Rivadavia	50084150	-33.205893119	-68.428880477	Mendoza
710	Medrano	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Rivadavia	50084110	-33.181046519	-68.614983212	Mendoza
711	Alto Verde	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Martín	50098020	-33.119570855	-68.40675127	Mendoza
712	Barrio Carrasco	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Carlos	50091005	-33.831106735	-69.048859084	Mendoza
713	Barrio El Cepillo	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Carlos	50091010	-33.835269192	-69.123648533	Mendoza
714	La Consulta	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Carlos	50091040	-33.733847173	-69.11988526	Mendoza
715	Pareditas	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Carlos	50091050	-33.942549724	-69.078545051	Mendoza
716	Chilecito	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Carlos	50091020	-33.891472758	-69.071192964	Mendoza
717	San Carlos	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Carlos	50091060	-33.772066617	-69.040391528	Mendoza
718	Barrio Chivilcoy	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Martín	50098030	-33.041958998	-68.352706877	Mendoza
719	Barrio Los Charabones	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Martín	50098050	-32.996193092	-68.27822845	Mendoza
720	Barrio Ntra. Sra. De Fátima	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Martín	50098055	-33.125358285	-68.347895174	Mendoza
721	Chivilcoy	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Martín	50098070	-33.042664592	-68.447913373	Mendoza
722	El Ramblón	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Martín	50098077	-33.157351615	-68.295543909	Mendoza
723	San Martín	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Martín	50098100	-33.087714239	-68.475807203	Mendoza
724	Chapanay	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Martín	50098060	-32.984714674	-68.464391657	Mendoza
725	Montecaseros	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Martín	50098080	-33.013730491	-68.389824174	Mendoza
726	Barrio Emanuel	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Martín	50098040	-32.842994127	-68.393256888	Mendoza
727	Barrio Molina Cabrera	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Santa Rosa	50112030	-33.109047545	-68.1875185	Mendoza
728	La Dormida	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Santa Rosa	50112040	-33.346716903	-67.917131761	Mendoza
729	Las Catitas	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Santa Rosa	50112050	-33.293842558	-68.048518175	Mendoza
730	Santa Rosa	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Santa Rosa	50112060	-33.254073839	-68.150662041	Mendoza
731	Barrio 12 de Octubre	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Santa Rosa	50112010	-33.197042044	-68.255138754	Mendoza
732	Barrio San Cayetano	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Tunuyán	50119010	-33.633474286	-69.179707874	Mendoza
733	Campo Los Andes	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Tunuyán	50119020	-33.700321936	-69.176495017	Mendoza
734	Colonia Las Rosas	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Tunuyán	50119030	-33.60563864	-69.10442623	Mendoza
735	El Manzano	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Tunuyán	50119040	-33.586141185	-69.327106583	Mendoza
736	Tunuyán	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Tunuyán	50119060	-33.581253156	-69.01536856	Mendoza
737	Vista Flores	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Tunuyán	50119070	-33.650875752	-69.155760396	Mendoza
738	Los Sauces	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Tunuyán	50119050	-33.594464192	-69.175498049	Mendoza
739	Barrio Belgrano Norte	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Tupungato	50126010	-33.330785669	-69.126164083	Mendoza
740	El Zampal	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Tupungato	50126035	-33.399066647	-69.105739787	Mendoza
741	San José	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Tupungato	50126050	-33.308282525	-69.152898885	Mendoza
742	Barrio El Nevado	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Rafael	50105020	-34.788136852	-67.979997621	Mendoza
743	Barrio Empleados de Comercio	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Rafael	50105030	-34.555744851	-68.301833046	Mendoza
744	Barrio Intendencia	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Rafael	50105040	-34.646869102	-68.264991204	Mendoza
745	Capitán Montoya	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Rafael	50105050	-34.582308203	-68.457600144	Mendoza
746	El Nihuil	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Rafael	50105070	-35.02729288	-68.672812313	Mendoza
747	El Sosneado	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Rafael	50105080	-35.080985276	-69.582519437	Mendoza
748	El Tropezón	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Rafael	50105090	-34.683908435	-68.2778978	Mendoza
749	La Llave Nueva	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Rafael	50105120	-34.639138114	-68.009905858	Mendoza
750	Las Malvinas	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Rafael	50105130	-34.835097763	-68.248632233	Mendoza
751	Monte Comán	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Rafael	50105150	-34.592370149	-67.868953493	Mendoza
752	Pobre Diablo	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Rafael	50105160	-34.66464622	-68.356936799	Mendoza
753	Rama Caída	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Rafael	50105180	-34.70139955	-68.368683165	Mendoza
754	Salto de las Rosas	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Rafael	50105200	-34.72546158	-68.231253982	Mendoza
755	San Rafael	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Rafael	50105210	-34.612861378	-68.330416984	Mendoza
756	25 de Mayo	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Rafael	50105220	-34.582558146	-68.536875913	Mendoza
757	Villa Atuel	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Rafael	50105230	-34.832060147	-67.923509349	Mendoza
758	Villa Atuel Norte	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Rafael	50105240	-34.754756786	-68.031017382	Mendoza
759	Goudge	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Rafael	50105100	-34.680029834	-68.131737314	Mendoza
760	Cuadro Benegas	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Rafael	50105060	-34.638561005	-68.466630043	Mendoza
761	Cazadores Correntinos	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Curuzú Cuatiá	18035010	-29.982380482	-58.304240284	Corrientes
762	Curuzú Cuatiá	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Curuzú Cuatiá	18035020	-29.791451212	-58.049858806	Corrientes
763	Mariano I. Loza	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Mercedes	18105020	-29.3768721	-58.192234556	Corrientes
764	Colonia Libertad	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Monte Caseros	18112010	-30.043303396	-57.821708317	Corrientes
765	Estación Libertad	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Monte Caseros	18112020	-30.013295461	-57.859334504	Corrientes
766	Juan Pujol	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Monte Caseros	18112030	-30.419321744	-57.855892569	Corrientes
767	Mocoretá	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Monte Caseros	18112040	-30.616677162	-57.975362574	Corrientes
768	Monte Caseros	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Monte Caseros	18112050	-30.24942296	-57.629481767	Corrientes
769	Parada Acuña	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Monte Caseros	18112060	-29.908841571	-57.958865554	Corrientes
770	Parada Labougle	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Monte Caseros	18112070	-30.319012997	-57.729687544	Corrientes
771	Bonpland	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Paso de los Libres	18119010	-29.817471535	-57.427832539	Corrientes
772	Parada Pucheta	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Paso de los Libres	18119020	-29.906039279	-57.574168835	Corrientes
773	Paso de los Libres	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Paso de los Libres	18119030	-29.713714811	-57.085405399	Corrientes
774	Tapebicuá	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Paso de los Libres	18119040	-29.506822084	-56.974850403	Corrientes
775	Colonia Ayuí	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Concordia	30015030	-31.207720071	-58.03124415	Entre Ríos
776	Los Charrúas	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Concordia	30015100	-31.169430052	-58.185540501	Entre Ríos
777	Chajarí	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Federación	30028010	-30.754724203	-57.981789368	Entre Ríos
778	Colonia Alemana	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Federación	30028020	-30.903595069	-57.99989434	Entre Ríos
779	Colonia La Argentina	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Federación	30028040	-31.074077023	-58.026021653	Entre Ríos
780	Federación	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Federación	30028070	-30.990262735	-57.917762324	Entre Ríos
781	Los Conquistadores	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Federación	30028080	-30.591337145	-58.466235709	Entre Ríos
782	San Jaime de la Frontera	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Federación	30028090	-30.340340136	-58.306929158	Entre Ríos
783	San Pedro	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Federación	30028100	-30.758195778	-58.081590008	Entre Ríos
784	San Ramón	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Federación	30028105	-30.818815647	-58.249794767	Entre Ríos
785	Santa Ana	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Federación	30028110	-30.899370024	-57.93107825	Entre Ríos
786	Villa del Rosario	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Federación	30028120	-30.795738501	-57.91455271	Entre Ríos
787	Nueva Vizcaya	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Federal	30035040	-30.968514032	-58.612749344	Entre Ríos
788	Colonia 10 de Julio	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Justo	14140070	-30.525237488	-62.112434416	Córdoba
789	Esteban Rams	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	9 de Julio	82077010	-29.772421746	-61.489981972	Santa Fe
790	Logroño	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	9 de Julio	82077040	-29.503755545	-61.696147335	Santa Fe
791	Montefiore	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	9 de Julio	82077050	-29.668695214	-61.866895004	Santa Fe
792	Suardi	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Cristóbal	82091260	-30.534423803	-61.961005427	Santa Fe
793	Capivara	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Cristóbal	82091050	-30.459709764	-61.271153065	Santa Fe
794	Las Avispas	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Cristóbal	82091160	-29.896417379	-61.288067306	Santa Fe
795	Villa Trinidad	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Cristóbal	82091280	-30.21610844	-61.877092089	Santa Fe
796	Colonia Rosa	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Cristóbal	82091090	-30.300382718	-61.983818103	Santa Fe
797	Huanqueros	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Cristóbal	82091130	-30.011993903	-61.218465247	Santa Fe
798	La Cabral	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Cristóbal	82091140	-30.086801201	-61.178333962	Santa Fe
799	Monigotes	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Cristóbal	82091190	-30.488367625	-61.634231121	Santa Fe
800	Constanza	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Cristóbal	82091100	-30.6635181	-61.319733818	Santa Fe
801	Ceres	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Cristóbal	82091060	-29.88189414	-61.945093712	Santa Fe
802	Ambrosetti	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Cristóbal	82091020	-30.015241633	-61.576022958	Santa Fe
803	Colonia Bossi	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Cristóbal	82091080	-30.667845931	-61.787743653	Santa Fe
804	Aguará Grande	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Cristóbal	82091010	-30.116102371	-60.894260451	Santa Fe
805	Las Palmeras	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Cristóbal	82091170	-30.630256524	-61.625822721	Santa Fe
806	La Rubia	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Cristóbal	82091150	-30.110287289	-61.793504117	Santa Fe
807	Balneario La Verde	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Cristóbal	82091040	-29.980913069	-61.241905506	Santa Fe
808	Santurce	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Cristóbal	82091240	-30.186567749	-61.181077267	Santa Fe
809	Hersilia	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Cristóbal	82091120	-30.003944549	-61.839149263	Santa Fe
810	San Guillermo	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Cristóbal	82091230	-30.358454011	-61.917319298	Santa Fe
811	Ñanducita	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Cristóbal	82091200	-30.369818871	-61.13337609	Santa Fe
812	Arrufo	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Cristóbal	82091030	-30.23241747	-61.728021461	Santa Fe
813	Curupaytí	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Cristóbal	82091110	-30.396104025	-61.653130515	Santa Fe
814	San Cristóbal	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Cristóbal	82091220	-30.31168942	-61.236206252	Santa Fe
815	Colonia Ana	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Cristóbal	82091070	-30.143748705	-61.913692551	Santa Fe
816	Argentina	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Aguirre	86007010	-29.534710697	-62.267139678	Santiago del Estero
817	Guardia Escolta	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Belgrano	86042040	-28.988338542	-62.126599523	Santiago del Estero
818	Cuatro Bocas	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Belgrano	86042020	-28.864274659	-61.857592655	Santiago del Estero
819	Bandera	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Belgrano	86042010	-28.888091734	-62.269025271	Santiago del Estero
820	Fortín Inca	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Belgrano	86042030	-29.127471389	-61.934476265	Santiago del Estero
821	Los Juríes	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	General Taboada	86077050	-28.462926434	-62.110240174	Santiago del Estero
822	Tomás Young	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	General Taboada	86077060	-28.600540693	-62.182674913	Santiago del Estero
823	Selva	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Rivadavia	86154030	-29.768247953	-62.047532444	Santiago del Estero
824	Colonia Alpina	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Rivadavia	86154010	-30.060097197	-62.103391679	Santiago del Estero
825	Palo Negro	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Rivadavia	86154020	-29.675072184	-62.13562305	Santiago del Estero
826	El Cajón	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Santa María	10091040	-26.407570614	-66.253831532	Catamarca
827	Fuerte Quemado	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Santa María	10091080	-26.626838816	-66.04848594	Catamarca
828	La Hoyada	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Santa María	10091090	-26.543618555	-66.362164827	Catamarca
829	Cafayate	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Cafayate	66021010	-26.073043967	-65.975983382	Salta
830	Tolombón	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Cafayate	66021020	-26.182713901	-65.939814335	Salta
831	San Carlos	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Carlos	66154040	-25.893166648	-65.92905764	Salta
832	Animaná	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Carlos	66154020	-25.969483643	-65.94899523	Salta
833	Angastaco	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Carlos	66154010	-25.690948763	-66.167020141	Salta
834	Colalao del Valle	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Tafí del Valle	90098020	-26.363107315	-65.95706754	Tucumán
835	Amaicha del Valle	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Tafí del Valle	90098010	-26.59366052	-65.920085166	Tucumán
836	Bandera Bajada	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Figueroa	86070010	-27.273290681	-63.51318191	Santiago del Estero
837	La Cañada	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Figueroa	86070060	-27.709508899	-63.772554212	Santiago del Estero
838	El Crucero	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Figueroa	86070040	-27.57418431	-63.329035718	Santiago del Estero
839	Colonia San Juan	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Figueroa	86070030	-27.617907614	-63.300576778	Santiago del Estero
840	Vaca Huañuna	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Figueroa	86070090	-27.463694211	-63.472420567	Santiago del Estero
841	Minerva	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Figueroa	86070080	-27.533035028	-63.38325403	Santiago del Estero
842	Caspi Corral	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Figueroa	86070020	-27.388416955	-63.546922948	Santiago del Estero
843	Suncho Corral	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Juan Felipe Ibarra	86098040	-27.932845714	-63.430152203	Santiago del Estero
844	Yuchán	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Juan Felipe Ibarra	86098060	-27.780853905	-62.975263834	Santiago del Estero
845	Matará	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Juan Felipe Ibarra	86098030	-28.110413913	-63.195071251	Santiago del Estero
846	Lilo Viejo	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Moreno	86119070	-26.93878072	-62.957269556	Santiago del Estero
847	Patay	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Moreno	86119080	-26.840003666	-62.930519636	Santiago del Estero
848	Las Tinajas	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Moreno	86119050	-27.465716652	-62.917965662	Santiago del Estero
849	Libertad	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Moreno	86119060	-27.084892882	-63.070884075	Santiago del Estero
850	Alvear	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	General Alvear	18056010	-29.098839351	-56.55343584	Corrientes
851	Estación Torrent	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	General Alvear	18056020	-28.824361326	-56.469217051	Corrientes
852	Colonia Liebig's	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Ituzaingó	18084010	-27.913358189	-55.824239182	Corrientes
853	Ituzaingó	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Ituzaingó	18084020	-27.585100079	-56.68704524	Corrientes
854	San Antonio	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Ituzaingó	18084030	-27.508228835	-56.745235507	Corrientes
855	San Carlos	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Ituzaingó	18084040	-27.743622392	-55.898431681	Corrientes
856	Villa Olivari	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Ituzaingó	18084050	-27.633100432	-56.906305445	Corrientes
857	Colonia Carlos Pellegrini	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Martín	18147010	-28.537235688	-57.171350089	Corrientes
858	Loreto	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Miguel	18154010	-27.768426802	-57.275251811	Corrientes
859	José Rafael Gómez	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Santo Tomé	18168010	-28.230318628	-55.784409994	Corrientes
860	Garruchos	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Santo Tomé	18168020	-28.173741022	-55.650644328	Corrientes
861	Gobernador Igr. Valentín Virasoro	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Santo Tomé	18168030	-28.046807983	-56.009632486	Corrientes
862	Santo Tomé	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Santo Tomé	18168040	-28.549815807	-56.034811077	Corrientes
863	Azara	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Apóstoles	54007020	-28.06070793	-55.677070904	Misiones
864	Barrio Rural	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Apóstoles	54007025	-27.881124999	-55.78727577	Misiones
865	Estación Apóstoles	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Apóstoles	54007030	-27.911529116	-55.809218641	Misiones
866	Pindapoy	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Apóstoles	54007040	-27.749423151	-55.794778959	Misiones
867	Rincón de Azara	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Apóstoles	54007050	-28.113618892	-55.62953241	Misiones
868	San José	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Apóstoles	54007060	-27.769994402	-55.78030371	Misiones
869	Tres Capones	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Apóstoles	54007070	-28.004253111	-55.609404149	Misiones
870	Apóstoles	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Apóstoles	54007010	-27.914135934	-55.754857841	Misiones
871	Bonpland	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Candelaria	54021010	-27.485403777	-55.480094608	Misiones
872	Candelaria	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Candelaria	54021020	-27.461217918	-55.743963235	Misiones
873	Cerro Corá	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Candelaria	54021030	-27.511917191	-55.6096055	Misiones
874	Mártires	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Candelaria	54021050	-27.423131947	-55.377295144	Misiones
875	Profundidad	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Candelaria	54021060	-27.561719382	-55.704565397	Misiones
876	Puerto Santa Ana	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Candelaria	54021070	-27.335647449	-55.583127152	Misiones
877	Loreto	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Candelaria	54021040	-27.332945176	-55.522249458	Misiones
878	Santa Ana	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Candelaria	54021080	-27.369213784	-55.5817097	Misiones
879	Barrio del Lago	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Candelaria	54021005	-27.466521823	-55.798992971	Misiones
880	Garupá	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Capital	54028010	-27.483777107	-55.829701655	Misiones
881	Nemesio Parma	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Capital	54028020	-27.3564761	-56.017222676	Misiones
882	Posadas (Extensión)	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Capital	54028040	-27.452433675	-55.852711487	Misiones
883	Posadas	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Capital	54028030	-27.36642598	-55.893980275	Misiones
884	Barra Concepción	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Concepción	54035010	-28.116698228	-55.581515994	Misiones
885	Concepción de la Sierra	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Concepción	54035020	-27.98057839	-55.521588222	Misiones
886	La Corita	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Concepción	54035030	-27.892533777	-55.355554884	Misiones
887	Santa María	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Concepción	54035040	-27.934514129	-55.407334404	Misiones
888	Almafuerte	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Leandro N. Alem	54070010	-27.508117891	-55.403523665	Misiones
889	Caá - Yarí	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Leandro N. Alem	54070030	-27.484875306	-55.298960962	Misiones
890	Cerro Azul	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Leandro N. Alem	54070040	-27.633575241	-55.497415991	Misiones
891	Dos Arroyos	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Leandro N. Alem	54070050	-27.699075224	-55.251821768	Misiones
892	Gobernador López	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Leandro N. Alem	54070060	-27.666356574	-55.213470975	Misiones
893	Leandro N. Alem	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Leandro N. Alem	54070070	-27.603731651	-55.323619338	Misiones
894	Olegario V. Andrade	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Leandro N. Alem	54070080	-27.567586745	-55.502279967	Misiones
895	Villa Libertad	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Leandro N. Alem	54070090	-27.565435167	-55.320198096	Misiones
896	Arroyo del Medio	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Leandro N. Alem	54070020	-27.698256629	-55.404864102	Misiones
897	Colonia Alberdi	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Oberá	54091010	-27.360031099	-55.231326503	Misiones
898	Guaraní	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Oberá	54091060	-27.523176503	-55.157646129	Misiones
899	San Martín	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Oberá	54091110	-27.46604416	-55.275544957	Misiones
900	El Salto	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Oberá	54091040	-27.495194914	-55.198727955	Misiones
901	Domingo Savio	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Ignacio	54098030	-27.355431242	-55.338470349	Misiones
902	Itacaruaré	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Javier	54105020	-27.871400567	-55.262214015	Misiones
903	San Javier	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Javier	54105040	-27.869480117	-55.138715236	Misiones
904	Antofagasta de la Sierra	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Antofagasta de la Sierra	10028010	-26.059266635	-67.406551712	Catamarca
905	El Peñón	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Antofagasta de la Sierra	10028030	-26.4754473	-67.265208334	Catamarca
906	Los Nacimientos	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Antofagasta de la Sierra	10028040	-25.824638181	-67.371792918	Catamarca
907	Tolar Grande	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Los Andes	66105040	-24.589400771	-67.395204744	Salta
908	Santa María	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Rivadavia	66133080	-22.153600412	-62.808645039	Salta
909	Coronel Juan Solá	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Rivadavia	66133030	-23.470477961	-62.887905868	Salta
910	Pluma de Pato	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Rivadavia	66133060	-23.37124165	-63.096722764	Salta
911	Santa Victoria Este	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Rivadavia	66133100	-22.272730366	-62.71257788	Salta
912	Hito 1	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Rivadavia	66133035	-21.999710968	-62.82373828	Salta
913	Taco Pozo	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Almirante Brown	22007050	-25.61503513	-63.264857547	Chaco
914	Coronel Olleros	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Anta	66007050	-25.100544491	-64.221570608	Salta
915	El Quebrachal	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Anta	66007060	-25.331998582	-64.017649374	Salta
916	Gaona	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Anta	66007070	-25.241490819	-64.037217666	Salta
917	Joaquín V. González	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Anta	66007090	-25.117391395	-64.124773236	Salta
918	Nuestra Señora de Talavera	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Anta	66007130	-25.458991483	-63.779757916	Salta
919	Río del Valle	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Anta	66007150	-24.674798417	-64.201349993	Salta
920	Ceibalito	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Anta	66007020	-25.110234298	-64.275199746	Salta
921	Centro 25 de Junio	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Anta	66007030	-24.957298516	-63.854644051	Salta
922	Tolloche	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Anta	66007160	-25.525700834	-63.524319718	Salta
923	Macapillo	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Anta	66007120	-25.402826309	-63.9809716	Salta
924	San José de Orquera	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Metán	66112080	-25.26615673	-64.075885798	Salta
925	El Tunal	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Metán	66112020	-25.253500783	-64.397784812	Salta
926	El Galpón	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Metán	66112010	-25.380625186	-64.651619254	Salta
927	Urutaú	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Copo	86056090	-25.714277292	-63.042248469	Santiago del Estero
928	Rawson	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Rawson	26077030	-43.305223669	-65.103695732	Chubut
929	Arroyo Verde	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Biedma	26007010	-41.99630436	-65.293172387	Chubut
930	Puerto Madryn	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Biedma	26007020	-42.767281496	-65.036675588	Chubut
931	Puerto Pirámides	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Biedma	26007030	-42.572091061	-64.284162878	Chubut
932	Quintas El Mirador	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Biedma	26007040	-42.813969481	-65.039525105	Chubut
933	Reserva Area Protegida El Doradillo	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Biedma	26007050	-42.644504547	-65.040037713	Chubut
934	Gaiman	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Gaiman	26042030	-43.291616798	-65.498370867	Chubut
935	Playa Magagna	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Rawson	26077010	-43.381948267	-65.045502263	Chubut
936	Playa Unión	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Rawson	26077020	-43.321660695	-65.047880037	Chubut
937	Trelew	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Rawson	26077040	-43.253186751	-65.309380589	Chubut
938	Bahía Creek	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Adolfo Alsina	62007010	-41.083199924	-63.932601599	Río Negro
939	Guardia Mitre	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Adolfo Alsina	62007040	-40.425718841	-63.672254516	Río Negro
940	La Lobería	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Adolfo Alsina	62007050	-41.152726809	-63.125416155	Río Negro
941	San Javier	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Adolfo Alsina	62007080	-40.749798773	-63.26711411	Río Negro
942	El Juncal	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Adolfo Alsina	62007030	-40.807406055	-63.12328095	Río Negro
943	Pozo Salado	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Adolfo Alsina	62007070	-41.01275154	-64.162498025	Río Negro
944	General Conesa	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Conesa	62028020	-40.106186003	-64.453014106	Río Negro
945	Barrio Planta Compresora de Gas	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Conesa	62028030	-40.061929927	-64.474854427	Río Negro
946	Barrio Colonia Conesa	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Conesa	62028010	-40.151035948	-64.348591808	Río Negro
947	Sierra Grande	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Antonio	62077060	-41.605459945	-65.357023772	Río Negro
948	Playas Doradas	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Antonio	62077020	-41.631137904	-65.026596572	Río Negro
949	El Empalme	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Antonio	62077005	-40.711560851	-65.003725245	Río Negro
950	Las Grutas	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Antonio	62077010	-40.809087093	-65.088074006	Río Negro
951	Punta Colorada	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Antonio	62077040	-41.69443117	-65.029147413	Río Negro
952	Saco Viejo	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Antonio	62077045	-40.815251908	-64.757420379	Río Negro
953	San Antonio Oeste	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Antonio	62077050	-40.730132579	-64.938971075	Río Negro
954	Puerto San Antonio Este	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	San Antonio	62077030	-40.80434576	-64.880410586	Río Negro
955	Sierra Pailemán	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Valcheta	62084050	-41.190567914	-65.976100335	Río Negro
956	Arroyo Los Berros	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Valcheta	62084020	-41.434736288	-66.101232416	Río Negro
957	Valcheta	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Valcheta	62084060	-40.676351707	-66.166517029	Río Negro
958	Arroyo Ventana	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Valcheta	62084030	-41.665441347	-66.094247559	Río Negro
959	Aguada Cecilio	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Valcheta	62084010	-40.848940718	-65.842491127	Río Negro
960	Aguada San Roque	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Añelo	58014005	-37.998674784	-68.922908597	Neuquén
961	Añelo	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Añelo	58014010	-38.354255899	-68.787543077	Neuquén
962	San Patricio del Chañar	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Añelo	58014020	-38.625875533	-68.299895001	Neuquén
963	Arroyito	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Confluencia	58035010	-39.074437741	-68.57260718	Neuquén
964	Centenario	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Confluencia	58035030	-38.830156536	-68.121477474	Neuquén
965	Cutral Có	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Confluencia	58035040	-38.937911284	-69.229365812	Neuquén
966	Neuquén	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Confluencia	58035070	-38.951828821	-68.059181307	Neuquén
967	Plottier	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Confluencia	58035100	-38.952354872	-68.227147389	Neuquén
968	Senillosa	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Confluencia	58035110	-39.010092919	-68.425975934	Neuquén
969	Villa El Chocón	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Confluencia	58035120	-39.26154727	-68.778927738	Neuquén
970	Vista Alegre Sur	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Confluencia	58035140	-38.773029803	-68.135492124	Neuquén
971	Plaza Huincul	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Confluencia	58035090	-38.930123891	-69.207777891	Neuquén
972	El Sauce	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Picún Leufú	58098005	-39.479814747	-69.531148648	Neuquén
973	Picún Leufú	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Picún Leufú	58098020	-39.518627865	-69.291061135	Neuquén
974	Ramón M. Castro	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Zapala	58112030	-38.864329711	-69.744696092	Neuquén
975	Barrio Unión	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Avellaneda	62014010	-39.165407309	-66.146417036	Río Negro
976	Chelforó	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Avellaneda	62014020	-39.087718148	-66.520752012	Río Negro
977	Chimpay	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Avellaneda	62014030	-39.165398302	-66.146417017	Río Negro
978	Coronel Belisle	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Avellaneda	62014050	-39.186766186	-65.954793623	Río Negro
979	Darwin	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Avellaneda	62014060	-39.20295442	-65.739755674	Río Negro
980	Lamarque	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Avellaneda	62014070	-39.425154054	-65.702145063	Río Negro
981	Pomona	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Avellaneda	62014090	-39.487046135	-65.610796348	Río Negro
982	Luis Beltrán	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Avellaneda	62014080	-39.310705923	-65.763563806	Río Negro
983	Choele Choel	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	Avellaneda	62014040	-39.296355387	-65.657678676	Río Negro
984	Cerro Policía	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	El Cuy	62035020	-39.726274502	-68.491504663	Río Negro
985	Las Perlas	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	El Cuy	62035040	-38.982252433	-68.149754749	Río Negro
986	Valle Azul	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	El Cuy	62035080	-39.156312303	-66.787553459	Río Negro
987	Paso Córdova	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	El Cuy	62035070	-39.113858517	-67.626634099	Río Negro
988	El Cuy	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	El Cuy	62035030	-39.926094258	-68.342753852	Río Negro
989	Villa San Isidro	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	General Roca	62042570	-38.706695376	-68.17309382	Río Negro
990	Paso Córdova	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	General Roca	62042490	-39.106782381	-67.627370212	Río Negro
991	General Enrique Godoy	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	General Roca	62042430	-39.078447716	-67.157451918	Río Negro
992	Barrio Guerrico	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	General Roca	62042160	-39.017321119	-67.718435332	Río Negro
993	Barrio Unión	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	General Roca	62042350	-38.968428451	-67.947644368	Río Negro
994	Cinco Saltos	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	General Roca	62042390	-38.827560747	-68.066168133	Río Negro
995	Barrio Mar del Plata	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	General Roca	62042250	-39.089348457	-67.672944658	Río Negro
996	Barrio Norte	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	General Roca	62042280	-38.867395093	-68.018686216	Río Negro
997	Barrio La Herradura	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	General Roca	62042215	-39.041805795	-67.781482417	Río Negro
998	Barrio El Labrador	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	General Roca	62042120	-38.666885675	-68.242938549	Río Negro
999	Barrio Fátima	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	General Roca	62042147	-39.057331691	-67.47277958	Río Negro
1000	Barrio Costa Este	2026-11-08 23:05:59.631	2026-11-08 23:05:59.631	General Roca	62042090	-39.029185403	-67.810842242	Río Negro
1001	Allen	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General Roca	62042010	-38.979510657	-67.828021398	Río Negro
1002	Mainqué	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General Roca	62042480	-39.06424534	-67.30564485	Río Negro
1003	Barrio Santa Rita	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General Roca	62042340	-39.126374177	-67.102737658	Río Negro
1004	Barrio Moño Azul	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General Roca	62042265	-39.13584825	-66.894796965	Río Negro
1005	Barrio Destacamento	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General Roca	62042115	-37.693024348	-67.870281106	Río Negro
1006	Barrio Luisillo	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General Roca	62042245	-39.056199463	-67.34508935	Río Negro
1007	Paraje Arroyón (Bajo San Cayetano)	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General Roca	62042020	-38.726458925	-68.041166618	Río Negro
1008	Barrio Blanco	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General Roca	62042040	-39.035278069	-67.793092035	Río Negro
1009	Barrio Calle Ciega Nº 6	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General Roca	62042060	-39.049856418	-67.736804069	Río Negro
1010	Barrio Costa Oeste	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General Roca	62042110	-39.028074024	-67.840695046	Río Negro
1011	Barrio El Maruchito	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General Roca	62042130	-38.996282495	-67.761806412	Río Negro
1012	Barrio Frontera	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General Roca	62042150	-39.074272273	-67.705800123	Río Negro
1013	Puente Cero	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General Roca	62042240	-39.029116556	-67.49967737	Río Negro
1014	Barrio María Elvira	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General Roca	62042260	-38.99160831	-67.964760358	Río Negro
1015	Barrio Isla 10	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General Roca	62042170	-38.995476012	-67.917993632	Río Negro
1016	Barrio Santa Lucia	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General Roca	62042335	-39.033518341	-67.298695655	Río Negro
1017	Cipolletti	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General Roca	62042400	-38.938784771	-67.99550268	Río Negro
1018	General Fernández Oro	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General Roca	62042440	-38.954121067	-67.929226268	Río Negro
1019	General Roca	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General Roca	62042450	-39.026819847	-67.574836493	Río Negro
1020	Ingeniero Luis A. Huergo	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General Roca	62042460	-39.073240015	-67.238683819	Río Negro
1021	Villa Alberdi	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General Roca	62042530	-39.12861962	-67.046772204	Río Negro
1022	Villa Manzano	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General Roca	62042550	-38.680616389	-68.216022959	Río Negro
1023	Barrio Canale	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General Roca	62042070	-39.068851013	-67.638549461	Río Negro
1024	Barrio Chacra Monte	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General Roca	62042080	-39.051502734	-67.635734204	Río Negro
1025	Barrio Calle Ciega Nº 10	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General Roca	62042050	-39.022279673	-67.80341785	Río Negro
1026	Barrio El Petróleo	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General Roca	62042140	-39.062379018	-67.511576003	Río Negro
1027	Barrio Emergente	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General Roca	62042143	-39.001285533	-67.848819168	Río Negro
1028	Barrio La Costa	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General Roca	62042200	-39.092286421	-67.203356712	Río Negro
1029	Barrio La Defensa	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General Roca	62042210	-39.031124491	-67.387295988	Río Negro
1030	Barrio La Barda	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General Roca	62042180	-39.050801345	-67.217461405	Río Negro
1031	Barrio Porvenir	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General Roca	62042310	-39.044555911	-67.456947311	Río Negro
1032	Cervantes	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General Roca	62042370	-39.05396132	-67.394156969	Río Negro
1033	Chichinales	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General Roca	62042380	-39.114748466	-66.942250191	Río Negro
1034	Contralmirante Cordero	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General Roca	62042410	-38.757741745	-68.099668307	Río Negro
1035	Ferri	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General Roca	62042420	-38.887942832	-68.007524756	Río Negro
1036	Ingeniero Otto Krause	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General Roca	62042470	-39.107235286	-66.998116718	Río Negro
1037	Sargento Vidal	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General Roca	62042520	-38.686374123	-68.158614304	Río Negro
1038	Villa Regina	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General Roca	62042560	-39.094557598	-67.082395443	Río Negro
1039	Villa del Parque	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General Roca	62042540	-39.126138217	-66.997458349	Río Negro
1040	Chuchucaruana	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Ambato	10007010	-27.921750699	-65.838608336	Catamarca
1041	Colpes	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Ambato	10007020	-28.065491919	-65.812634343	Catamarca
1042	El Bolsón	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Ambato	10007030	-27.903904224	-65.88105266	Catamarca
1043	El Rodeo	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Ambato	10007040	-28.212696761	-65.876487369	Catamarca
1044	Huaycama	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Ambato	10007050	-28.119351367	-65.798462431	Catamarca
1045	La Puerta	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Ambato	10007060	-28.156345287	-65.79386763	Catamarca
1046	Las Chacritas	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Ambato	10007070	-27.688171836	-65.923748204	Catamarca
1047	Las Juntas	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Ambato	10007080	-28.098311288	-65.899236797	Catamarca
1048	Los Castillos	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Ambato	10007090	-27.959829804	-65.81280441	Catamarca
1049	Los Talas	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Ambato	10007100	-27.94153055	-65.868048514	Catamarca
1050	Los Varela	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Ambato	10007110	-27.931468298	-65.872020639	Catamarca
1051	Singuil	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Ambato	10007120	-27.804307993	-65.871198254	Catamarca
1052	El Alamito	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Andalgalá	10021050	-27.489888458	-66.020865975	Catamarca
1053	El Lindero	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Andalgalá	10021060	-27.466633812	-66.010752017	Catamarca
1054	Amadores	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Paclín	10077010	-28.262572132	-65.637347195	Catamarca
1055	La Higuera	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Paclín	10077040	-27.939660137	-65.697663598	Catamarca
1056	La Merced	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Paclín	10077050	-28.15440774	-65.659438546	Catamarca
1057	La Viña	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Paclín	10077060	-28.039283781	-65.596836076	Catamarca
1058	Las Lajas	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Paclín	10077070	-27.838159189	-65.729465357	Catamarca
1059	Monte Potrero	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Paclín	10077080	-28.179022699	-65.662754196	Catamarca
1060	San Antonio	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Paclín	10077100	-28.008461427	-65.71045785	Catamarca
1061	Villa de Balcozna	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Paclín	10077110	-27.882611761	-65.72781895	Catamarca
1062	Alijilán	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Santa Rosa	10098010	-28.179392472	-65.495387948	Catamarca
1063	Los Altos	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Santa Rosa	10098050	-28.045007041	-65.497636216	Catamarca
1064	Manantiales	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Santa Rosa	10098060	-28.143205244	-65.496786858	Catamarca
1065	Iltico	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Chicligasta	90021060	-27.335776235	-65.654431732	Tucumán
1066	Arcadia	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Chicligasta	90021030	-27.305917553	-65.576849289	Tucumán
1067	Alpachiri	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Chicligasta	90021010	-27.33578983	-65.757345372	Tucumán
1068	La Trinidad	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Chicligasta	90021070	-27.414285567	-65.516775095	Tucumán
1069	Alto Verde	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Chicligasta	90021020	-27.377626509	-65.608121658	Tucumán
1070	Concepción	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Chicligasta	90021050	-27.345920439	-65.592748303	Tucumán
1071	Medina	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Chicligasta	90021080	-27.421898265	-65.532877069	Tucumán
1072	Graneros	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Graneros	90035010	-27.649492167	-65.43942849	Tucumán
1073	Villa Belgrano	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Juan Bautista Alberdi	90042020	-27.530929795	-65.615804249	Tucumán
1074	Juan Bautista Alberdi	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Juan Bautista Alberdi	90042010	-27.585872921	-65.617296719	Tucumán
1075	La Cocha	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	La Cocha	90049010	-27.770010327	-65.588441347	Tucumán
1076	San José de La Cocha	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	La Cocha	90049020	-27.731220481	-65.583683815	Tucumán
1077	Los Sarmientos	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Río Chico	90077020	-27.414789854	-65.693197073	Tucumán
1078	Río Chico	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Río Chico	90077030	-27.480045124	-65.625135434	Tucumán
1079	Villa Clodomiro Hileret	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Río Chico	90077050	-27.474000553	-65.659146384	Tucumán
1080	Santa Ana	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Río Chico	90077040	-27.473624634	-65.685385286	Tucumán
1081	Aguilares	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Río Chico	90077010	-27.431628005	-65.614537995	Tucumán
1082	Santa Cruz	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Simoca	90091040	-27.389447167	-65.45807384	Tucumán
1083	Nueva Trinidad	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Simoca	90091030	-27.484511336	-65.491250933	Tucumán
1084	Andalgalá	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Andalgalá	10021020	-27.583018935	-66.315432685	Catamarca
1085	Chaquiago	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Andalgalá	10021030	-27.5478659	-66.326871612	Catamarca
1086	Choya	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Andalgalá	10021040	-27.521049284	-66.383842563	Catamarca
1087	El Potrero	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Andalgalá	10021070	-27.510158579	-66.328629961	Catamarca
1088	Colpes	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Pomán	10084030	-28.058637613	-66.197660571	Catamarca
1089	Rincón	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Pomán	10084080	-28.221344385	-66.143342205	Catamarca
1090	San Miguel	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Pomán	10084090	-28.140094861	-66.20255363	Catamarca
1091	Saujil	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Pomán	10084100	-28.174706235	-66.216045042	Catamarca
1092	Siján	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Pomán	10084110	-28.261493219	-66.224278498	Catamarca
1093	Colón	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Colón	06175010	-33.897126397	-61.099416362	Buenos Aires
1094	Sarasa	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Colón	06175040	-34.048093911	-61.201724347	Buenos Aires
1095	Arribeños	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General Arenales	06294010	-34.208391907	-61.355242095	Buenos Aires
1096	Ascensión	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General Arenales	06294020	-34.230952262	-61.103220978	Buenos Aires
1097	Estación Arenales	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General Arenales	06294030	-34.270885126	-61.293621674	Buenos Aires
1098	Ferré	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General Arenales	06294040	-34.122576493	-61.133385635	Buenos Aires
1099	General Arenales	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General Arenales	06294050	-34.303324003	-61.307033889	Buenos Aires
1100	Colonia San Ricardo	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General Pinto	06351010	-34.416282596	-61.92923459	Buenos Aires
1101	Germania	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General Pinto	06351030	-34.577042936	-62.047837206	Buenos Aires
1102	Gunther	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General Pinto	06351035	-34.592959918	-61.918892557	Buenos Aires
1103	Villa Roth	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General Pinto	06351050	-34.579584819	-62.171337418	Buenos Aires
1104	Fortín Tiburcio	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Junín	06413040	-34.34453606	-61.128501182	Buenos Aires
1105	Saforcada	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Junín	06413080	-34.572827866	-61.074208604	Buenos Aires
1106	Alberdi Viejo	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Leandro N. Alem	06462010	-34.439712754	-61.846574156	Buenos Aires
1107	Fortín Acha	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Leandro N. Alem	06462030	-34.342348395	-61.51518017	Buenos Aires
1108	Juan Bautista Alberdi	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Leandro N. Alem	06462040	-34.438516331	-61.812090154	Buenos Aires
1109	Leandro N. Alem	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Leandro N. Alem	06462050	-34.519573745	-61.391222423	Buenos Aires
1110	Vedia	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Leandro N. Alem	06462060	-34.497907178	-61.542310597	Buenos Aires
1111	Bermúdez	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Lincoln	06469030	-34.694623722	-61.328685069	Buenos Aires
1112	Del Campillo	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General Roca	14035010	-34.378854979	-64.497127781	Córdoba
1113	Estación Lecueder	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General Roca	14035020	-34.49608963	-64.810684472	Córdoba
1114	Hipólito Bouchard	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General Roca	14035030	-34.723874431	-63.507264674	Córdoba
1115	Huinca Renancó	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General Roca	14035040	-34.841318209	-64.374674242	Córdoba
1116	Italó	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General Roca	14035050	-34.790806122	-63.780357387	Córdoba
1117	Mattaldi	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General Roca	14035060	-34.481256593	-64.170696376	Córdoba
1118	Nicolás Bruzzone	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General Roca	14035070	-34.440420236	-64.341641314	Córdoba
1119	Onagoity	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General Roca	14035080	-34.772630654	-63.672154527	Córdoba
1120	Pincén	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General Roca	14035090	-34.838183615	-63.916563045	Córdoba
1121	Ranqueles	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General Roca	14035100	-34.842658642	-64.100317162	Córdoba
1122	Santa Magdalena	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General Roca	14035110	-34.518814618	-63.944039472	Córdoba
1123	Villa Huidobro	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General Roca	14035120	-34.840520614	-64.587100025	Córdoba
1124	Villa Sarmiento	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General Roca	14035130	-34.122853836	-64.725179356	Córdoba
1125	Villa Valeria	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General Roca	14035140	-34.341445816	-64.920814402	Córdoba
1126	Alejo Ledesma	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Marcos Juárez	14063010	-33.60539202	-62.625880988	Córdoba
1127	Arias	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Marcos Juárez	14063020	-33.642072923	-62.404119466	Córdoba
1128	General Levalle	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Presidente Roque Sáenz Peña	14084010	-34.007074795	-63.923476502	Córdoba
1129	La Cesira	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Presidente Roque Sáenz Peña	14084020	-33.953648091	-62.977302954	Córdoba
1130	Laboulaye	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Presidente Roque Sáenz Peña	14084030	-34.128632235	-63.390701706	Córdoba
1131	Leguizamón	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Presidente Roque Sáenz Peña	14084040	-34.204180124	-62.975847182	Córdoba
1132	Melo	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Presidente Roque Sáenz Peña	14084050	-34.34867548	-63.445150575	Córdoba
1133	Río Bamba	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Presidente Roque Sáenz Peña	14084060	-34.051372043	-63.733065523	Córdoba
1134	Rosales	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Presidente Roque Sáenz Peña	14084070	-34.171775958	-63.154026448	Córdoba
1135	San Joaquín	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Presidente Roque Sáenz Peña	14084080	-34.511729721	-63.708841822	Córdoba
1136	Serrano	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Presidente Roque Sáenz Peña	14084090	-34.470674327	-63.540286092	Córdoba
1137	Villa Rossi	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Presidente Roque Sáenz Peña	14084100	-34.297936597	-63.268538983	Córdoba
1138	Adelia María	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Río Cuarto	14098020	-33.632030388	-64.021678009	Córdoba
1139	Coronel Moldes	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Río Cuarto	14098100	-33.622728521	-64.59704814	Córdoba
1140	La Cautiva	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Río Cuarto	14098130	-33.979644967	-64.083456245	Córdoba
1141	Monte de los Gauchos	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Río Cuarto	14098210	-33.639086418	-63.88967283	Córdoba
1142	Tosquitas	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Río Cuarto	14098280	-33.819683625	-64.457670074	Córdoba
1143	Vicuña Mackenna	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Río Cuarto	14098290	-33.915641665	-64.389854557	Córdoba
1144	Washington	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Río Cuarto	14098320	-33.87373761	-64.689594004	Córdoba
1145	Aldea Santa María	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Unión	14182010	-33.699219434	-62.914657822	Córdoba
1146	Benjamín Gould	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Unión	14182070	-33.58746497	-62.728134879	Córdoba
1147	Canals	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Unión	14182080	-33.562172634	-62.885085615	Córdoba
1148	Pueblo Italiano	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Unión	14182220	-33.882410685	-62.840501662	Córdoba
1149	Viamonte	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Unión	14182270	-33.746051752	-63.097281627	Córdoba
1150	Quetrequén	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Rancul	42126060	-35.057046862	-64.523162794	La Pampa
1151	Rancul	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Rancul	42126070	-35.067769743	-64.68421613	La Pampa
1152	Adolfo Van Praet	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Realicó	42133010	-35.016672651	-64.035320074	La Pampa
1153	Damián Maisonave	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Realicó	42133030	-35.04142762	-64.385912335	La Pampa
1154	Justo Daract	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General Pedernera	74035030	-33.863374033	-65.178058414	San Luis
1155	Villa Salles	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General Pedernera	74035090	-33.840039922	-65.213558592	San Luis
1156	Juncal	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Constitución	82028120	-33.716280363	-61.050912152	Santa Fe
1157	San Francisco de Santa Fe	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General López	82042240	-33.588495306	-62.123902237	Santa Fe
1158	Chovet	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General López	82042080	-33.598994051	-61.603957106	Santa Fe
1159	Lazzarino	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General López	82042160	-34.165463773	-62.428120909	Santa Fe
1160	Aarón Castellanos	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General López	82042010	-34.332785549	-62.374082125	Santa Fe
1161	Chapuy	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General López	82042070	-33.800710184	-61.744313849	Santa Fe
1162	Venado Tuerto	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General López	82042290	-33.745499157	-61.968733525	Santa Fe
1163	Diego de Alvear	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General López	82042100	-34.372650343	-62.128215946	Santa Fe
1164	Hughes	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General López	82042130	-33.801201181	-61.336133209	Santa Fe
1165	Labordeboy	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General López	82042150	-33.717646028	-61.314076468	Santa Fe
1166	Rufino	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General López	82042220	-34.261872818	-62.711066603	Santa Fe
1167	Teodelina	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General López	82042280	-34.189573308	-61.526521596	Santa Fe
1168	San Eduardo	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General López	82042230	-33.871246213	-62.08892588	Santa Fe
1169	Berazategui	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Berazategui	06091010	-34.769791045	-58.226143186	Buenos Aires
1170	Berisso	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Berisso	06098010	-34.867460609	-57.888647926	Buenos Aires
1171	Altamirano	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Brandsen	06119010	-35.36100184	-58.151158063	Buenos Aires
1172	Barrio El Mirador	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Brandsen	06119015	-35.31453565	-58.04844448	Buenos Aires
1173	Barrio Las Golondrinas	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Brandsen	06119020	-35.001108305	-58.130547945	Buenos Aires
1174	Barrio Los Bosquecitos	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Brandsen	06119030	-35.10377538	-58.184868665	Buenos Aires
1175	Campos de Roca	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Brandsen	06119045	-35.116900336	-58.099268576	Buenos Aires
1176	Coronel Brandsen	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Brandsen	06119050	-35.167959414	-58.23733024	Buenos Aires
1177	Gómez	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Brandsen	06119060	-35.067542542	-58.166039505	Buenos Aires
1178	Jeppener	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Brandsen	06119070	-35.277703107	-58.198144564	Buenos Aires
1179	Oliden	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Brandsen	06119080	-35.184480827	-57.949075352	Buenos Aires
1180	Barrio Lomas Altas	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Chascomús	06218003	-35.584066171	-58.068194873	Buenos Aires
1181	Chascomús	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Chascomús	06218010	-35.579142668	-58.013673479	Buenos Aires
1182	Laguna Vitel	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Chascomús	06218015	-35.536778157	-58.142964648	Buenos Aires
1183	Manuel J. Cobo	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Lezama	06466020	-35.872865566	-57.896984339	Buenos Aires
1184	Villa Parque Girado	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Chascomús	06218030	-35.626850073	-58.014629349	Buenos Aires
1185	Ensenada	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Ensenada	06245010	-34.857507091	-57.907679521	Buenos Aires
1186	La Plata	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	La Plata	06441030	-34.921351918	-57.954502645	Buenos Aires
1187	Atalaya	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Magdalena	06505010	-35.024295217	-57.535489506	Buenos Aires
1188	General Mansilla	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Magdalena	06505020	-35.079721721	-57.746887024	Buenos Aires
1189	Los Naranjos	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Magdalena	06505030	-34.995099054	-57.70284464	Buenos Aires
1190	Magdalena	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Magdalena	06505040	-35.080739356	-57.517601894	Buenos Aires
1191	Vieytes	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Magdalena	06505060	-35.267464488	-57.57491978	Buenos Aires
1192	Alvarez Jonte	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Punta Indio	06655010	-35.321734804	-57.453964208	Buenos Aires
1193	Pipinas	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Punta Indio	06655030	-35.530197629	-57.328324293	Buenos Aires
1194	Punta Indio	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Punta Indio	06655040	-35.26856278	-57.247470489	Buenos Aires
1195	Verónica	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Punta Indio	06655050	-35.387409659	-57.33817161	Buenos Aires
1196	Avellaneda	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Avellaneda	06035010	-34.66269451	-58.365166856	Buenos Aires
1197	Lanús	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Lanús	06434010	-34.707555344	-58.391127728	Buenos Aires
1198	Quilmes	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Quilmes	06658010	-34.718858253	-58.26036531	Buenos Aires
1199	Cadret	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Carlos Casares	06147020	-35.771550096	-61.335777241	Buenos Aires
1200	Carlos Casares	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Carlos Casares	06147030	-35.622473748	-61.365495131	Buenos Aires
1201	Colonia Mauricio	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Carlos Casares	06147040	-35.524441328	-61.437092533	Buenos Aires
1202	La Sofía	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Carlos Casares	06147060	-35.699360761	-61.169438495	Buenos Aires
1203	Mauricio Hirsch	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Carlos Casares	06147070	-35.581573803	-61.526835555	Buenos Aires
1204	Moctezuma	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Carlos Casares	06147080	-35.477946511	-61.495764916	Buenos Aires
1205	Ordoqui	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Carlos Casares	06147090	-35.880570478	-61.160164897	Buenos Aires
1206	Santo Tomás	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Carlos Casares	06147095	-35.675319649	-61.510765902	Buenos Aires
1207	Smith	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Carlos Casares	06147100	-35.495367517	-61.592522428	Buenos Aires
1208	La Delfina	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General Viamonte	06385020	-34.943255642	-61.15866087	Buenos Aires
1209	Laplacette	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Junín	06413060	-34.723128738	-61.158266396	Buenos Aires
1210	El Dorado	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Leandro N. Alem	06462020	-34.652861582	-61.582908488	Buenos Aires
1211	Bayauca	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Lincoln	06469020	-34.86747108	-61.287290383	Buenos Aires
1212	Coronel Martínez de Hoz	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Lincoln	06469050	-35.330757064	-61.614305225	Buenos Aires
1213	El Triunfo	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Lincoln	06469060	-35.089830038	-61.518823847	Buenos Aires
1214	Lincoln	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Lincoln	06469080	-34.868176906	-61.529411302	Buenos Aires
1215	Triunvirato	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Lincoln	06469110	-34.675773723	-61.464991811	Buenos Aires
1216	Alfredo Demarchi	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	9 de Julio	06588010	-35.292355193	-61.405804516	Buenos Aires
1217	La Aurora	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	9 de Julio	06588050	-35.408707458	-61.207805466	Buenos Aires
1218	San Bernardo	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Pehuajó	06609090	-35.714918419	-61.649968964	Buenos Aires
1219	Camilo Aldao	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Marcos Juárez	14063030	-33.127586224	-62.094840853	Córdoba
1220	Capitán General Bernardo O'Higgins	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Marcos Juárez	14063040	-33.248256579	-62.268834589	Córdoba
1221	Cavanagh	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Marcos Juárez	14063050	-33.473764977	-62.338907063	Córdoba
1222	Colonia Barge	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Marcos Juárez	14063060	-33.258239392	-62.607524398	Córdoba
1223	Colonia Italiana	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Marcos Juárez	14063070	-33.311701758	-62.176462774	Córdoba
1224	Colonia Veinticinco	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Marcos Juárez	14063080	-32.887680942	-61.951744984	Córdoba
1225	Corral de Bustos	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Marcos Juárez	14063090	-33.283092854	-62.186542917	Córdoba
1226	Cruz Alta	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Marcos Juárez	14063100	-33.008399729	-61.80577928	Córdoba
1227	General Baldissera	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Marcos Juárez	14063110	-33.122080592	-62.302884168	Córdoba
1228	General Roca	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Marcos Juárez	14063120	-32.730877481	-61.915826671	Córdoba
1229	Guatimozín	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Marcos Juárez	14063130	-33.464287945	-62.43825531	Córdoba
1230	Inriville	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Marcos Juárez	14063140	-32.945647467	-62.23079086	Córdoba
1231	Isla Verde	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Marcos Juárez	14063150	-33.239697567	-62.401595801	Córdoba
1232	Leones	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Marcos Juárez	14063160	-32.659355269	-62.297267576	Córdoba
1233	Los Surgentes	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Marcos Juárez	14063170	-32.985269271	-62.02187431	Córdoba
1234	Marcos Juárez	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Marcos Juárez	14063180	-32.690636291	-62.101126519	Córdoba
1235	Monte Buey	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Marcos Juárez	14063190	-32.915637438	-62.454900955	Córdoba
1236	Saladillo	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Marcos Juárez	14063220	-32.933871255	-62.343711879	Córdoba
1237	Villa Elisa	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Marcos Juárez	14063230	-32.834757809	-62.295258965	Córdoba
1238	Bell Ville	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Unión	14182060	-32.630314282	-62.688793384	Córdoba
1239	Colonia Bismarck	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Unión	14182110	-33.301237046	-62.712646783	Córdoba
1240	Colonia Bremen	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Unión	14182120	-33.464254898	-62.731177162	Córdoba
1241	Justiniano Posse	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Unión	14182140	-32.883449727	-62.679613683	Córdoba
1242	Monte Leña	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Unión	14182160	-32.611282942	-62.589745258	Córdoba
1243	Monte Maíz	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Unión	14182170	-33.204245117	-62.600483085	Córdoba
1244	San Marcos	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Unión	14182250	-32.630235881	-62.484248004	Córdoba
1245	Villa Los Patos	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Unión	14182280	-32.766837625	-62.727135131	Córdoba
1246	Las Rosas	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Belgrano	82007040	-32.475050872	-61.576508166	Santa Fe
1247	Montes de Oca	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Belgrano	82007050	-32.566379802	-61.768458637	Santa Fe
1248	Armstrong	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Belgrano	82007010	-32.785289071	-61.603309914	Santa Fe
1249	Las Parejas	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Belgrano	82007030	-32.682949858	-61.522449016	Santa Fe
1250	Tortugas	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Belgrano	82007060	-32.747397014	-61.820988329	Santa Fe
1251	Arequito	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Caseros	82014010	-33.144800394	-61.469507176	Santa Fe
1252	Beravebú	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Caseros	82014030	-33.340843122	-61.862092192	Santa Fe
1253	Casilda	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Caseros	82014050	-33.044697648	-61.16420109	Santa Fe
1254	Los Molinos	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Caseros	82014090	-33.104479546	-61.325564051	Santa Fe
1255	Los Nogales	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Caseros	82014100	-33.140134857	-61.60465399	Santa Fe
1256	Los Quirquinchos	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Caseros	82014110	-33.374859482	-61.710492009	Santa Fe
1257	Sanford	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Caseros	82014130	-33.145987902	-61.277200092	Santa Fe
1258	Arteaga	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Caseros	82014020	-33.09268166	-61.792011234	Santa Fe
1259	San José de la Esquina	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Caseros	82014120	-33.112279904	-61.702663116	Santa Fe
1260	Villada	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Caseros	82014140	-33.34884921	-61.446620317	Santa Fe
1261	Gödeken	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Caseros	82014080	-33.400368608	-61.844338895	Santa Fe
1262	Bigand	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Caseros	82014040	-33.374036671	-61.184746849	Santa Fe
1263	Chañar Ladeado	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Caseros	82014070	-33.3261685	-62.035232169	Santa Fe
1264	Chabas	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Caseros	82014060	-33.245840044	-61.358851824	Santa Fe
1265	Alcorta	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Constitución	82028010	-33.538178109	-61.123927907	Santa Fe
1266	Bombal	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Constitución	82028040	-33.457974957	-61.318211541	Santa Fe
1267	Murphy	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General López	82042210	-33.642297777	-61.858335922	Santa Fe
1268	Maggiolo	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General López	82042170	-33.721098211	-62.246247828	Santa Fe
1269	Miguel Torres	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General López	82042200	-33.526461652	-61.465872691	Santa Fe
1270	Firmat	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General López	82042120	-33.458143516	-61.486210357	Santa Fe
1271	Cañada del Ucle	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General López	82042040	-33.40946693	-61.605596606	Santa Fe
1272	Amenábar	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General López	82042020	-34.133577975	-62.423387873	Santa Fe
1273	Carreras	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General López	82042060	-33.596144928	-61.310948718	Santa Fe
1274	Cafferata	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General López	82042030	-33.439537232	-62.086187733	Santa Fe
1275	La Chispa	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General López	82042140	-33.544204558	-61.97406405	Santa Fe
1276	Elortondo	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General López	82042110	-33.701983717	-61.61505796	Santa Fe
1277	Carmen	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General López	82042050	-33.730339413	-61.762269601	Santa Fe
1278	Melincué	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General López	82042190	-33.661143446	-61.456990115	Santa Fe
1279	María Teresa	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General López	82042180	-34.012721949	-61.914752002	Santa Fe
1280	Christophersen	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General López	82042090	-34.183107231	-62.025962263	Santa Fe
1281	Villa Cañás	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General López	82042300	-34.0042772	-61.605828285	Santa Fe
1282	Santa Isabel	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General López	82042270	-33.887658182	-61.69593733	Santa Fe
1283	Sancti Spiritu	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General López	82042260	-34.007725642	-62.241541295	Santa Fe
1284	Wheelwright	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General López	82042310	-33.792309432	-61.210695175	Santa Fe
1285	San Gregorio	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General López	82042250	-34.325378502	-62.035813241	Santa Fe
1286	Classon	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Iriondo	82056050	-32.462377352	-61.290395173	Santa Fe
1287	Correa	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Iriondo	82056070	-32.848617725	-61.254497344	Santa Fe
1288	Colonia Médici	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Iriondo	82056060	-32.597546425	-61.377965127	Santa Fe
1289	Cañada de Gómez	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Iriondo	82056030	-32.821216164	-61.395198681	Santa Fe
1290	Villa Eloísa	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Iriondo	82056150	-32.963888265	-61.55101352	Santa Fe
1291	Larguía	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Iriondo	82056080	-32.551983244	-61.218580648	Santa Fe
1292	Barrio Cicarelli	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Iriondo	82056010	-32.608308805	-61.32418585	Santa Fe
1293	Bustinza	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Iriondo	82056020	-32.738242639	-61.290819956	Santa Fe
1294	Totoras	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Iriondo	82056140	-32.58427249	-61.166699739	Santa Fe
1295	Carcarañá	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	San Lorenzo	82119030	-32.857385657	-61.151866653	Santa Fe
1296	Alberti	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Alberti	06021010	-35.031574623	-60.280286017	Buenos Aires
1297	Coronel Seguí	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Alberti	06021020	-34.867440052	-60.392971444	Buenos Aires
1298	Mechita	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Alberti	06021030	-35.067386109	-60.40342701	Buenos Aires
1299	Pla	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Alberti	06021040	-35.122895987	-60.221916141	Buenos Aires
1300	Villa Grisolía	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Alberti	06021050	-35.109999975	-60.070218183	Buenos Aires
1301	Villa María	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Alberti	06021060	-34.888225027	-60.347480481	Buenos Aires
1302	Villa Ortiz	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Alberti	06021070	-34.844536788	-60.306301146	Buenos Aires
1303	Bragado	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Bragado	06112010	-35.115566279	-60.48964999	Buenos Aires
1304	Comodoro Py	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Bragado	06112020	-35.322556975	-60.521379841	Buenos Aires
1305	General O'Brien	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Bragado	06112030	-34.90560966	-60.760500081	Buenos Aires
1306	Irala	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Bragado	06112040	-34.770203933	-60.69102175	Buenos Aires
1307	La Limpia	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Bragado	06112050	-35.080096033	-60.59119177	Buenos Aires
1308	Juan F. Salaberry	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Bragado	06112060	-35.061615483	-60.704754055	Buenos Aires
1309	Mechita	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Bragado	06112070	-35.073379033	-60.411816571	Buenos Aires
1310	Olascoaga	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Bragado	06112080	-35.237394402	-60.611072979	Buenos Aires
1311	Warnes	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Bragado	06112090	-34.910133671	-60.538952827	Buenos Aires
1312	Benitez	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Chivilcoy	06224005	-34.967143982	-60.127139795	Buenos Aires
1313	Chivilcoy	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Chivilcoy	06224010	-34.896895827	-60.019091374	Buenos Aires
1314	Emilio Ayarza	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Chivilcoy	06224020	-34.743727941	-60.039100433	Buenos Aires
1315	Gorostiaga	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Chivilcoy	06224030	-34.838800216	-59.866011587	Buenos Aires
1316	La Rica	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Chivilcoy	06224040	-34.973089626	-59.86141298	Buenos Aires
1317	Moquehuá	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Chivilcoy	06224050	-35.092209149	-59.775710501	Buenos Aires
1318	Ramón Biaus	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Chivilcoy	06224060	-35.087205618	-59.924373202	Buenos Aires
1319	San Sebastián	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Chivilcoy	06224070	-34.942976619	-59.702161747	Buenos Aires
1320	Baigorrita	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General Viamonte	06385010	-34.747804478	-60.98838606	Buenos Aires
1321	Los Toldos	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General Viamonte	06385030	-34.99997083	-61.038740008	Buenos Aires
1322	San Emilio	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General Viamonte	06385040	-35.030407526	-60.86607305	Buenos Aires
1323	Zavalía	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	General Viamonte	06385050	-34.895085561	-61.005615923	Buenos Aires
1324	Agustina	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Junín	06413020	-34.457840918	-61.066498103	Buenos Aires
1325	Junín	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Junín	06413050	-34.593941743	-60.946430969	Buenos Aires
1326	Morse	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Junín	06413070	-34.759710548	-60.840939011	Buenos Aires
1327	Antonio Carboni	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Lobos	06483010	-35.201045956	-59.345396108	Buenos Aires
1328	Elvira	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Lobos	06483020	-35.242751862	-59.485652094	Buenos Aires
1329	Mercedes	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Mercedes	06532020	-34.650733211	-59.43138744	Buenos Aires
1330	Morea	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	9 de Julio	06588080	-35.5545417	-60.56202544	Buenos Aires
1331	José Juan Almeyra	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Navarro	06574010	-34.921585167	-59.542229638	Buenos Aires
1332	Las Marianas	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Navarro	06574020	-35.052940266	-59.512702617	Buenos Aires
1333	Villa Moll	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Navarro	06574040	-35.077950187	-59.651870543	Buenos Aires
1334	Carlos María Naón	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	9 de Julio	06588020	-35.237150973	-60.823278755	Buenos Aires
1335	12 de Octubre	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	9 de Julio	06588030	-35.605166454	-60.919147323	Buenos Aires
1336	Dudignac	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	9 de Julio	06588040	-35.650267687	-60.709500831	Buenos Aires
1337	Manuel B. Gonnet	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	9 de Julio	06588060	-35.517995881	-61.001293512	Buenos Aires
1338	Marcelino Ugarte	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	9 de Julio	06588070	-35.351619835	-60.745070287	Buenos Aires
1339	Norumbega	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	9 de Julio	06588090	-35.53511906	-60.794391192	Buenos Aires
1340	9 de Julio	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	9 de Julio	06588100	-35.44393528	-60.884627485	Buenos Aires
1341	Patricios	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	9 de Julio	06588110	-35.441219366	-60.716549619	Buenos Aires
1342	Roque Pérez	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Roque Pérez	06693020	-35.400576306	-59.334832151	Buenos Aires
1343	Álvarez de Toledo	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Saladillo	06707010	-35.639373046	-59.631141208	Buenos Aires
1344	Cazón	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Saladillo	06707030	-35.577098851	-59.661947713	Buenos Aires
1345	Del Carril	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Saladillo	06707040	-35.508017217	-59.513716448	Buenos Aires
1346	Polvaredas	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Saladillo	06707050	-35.594554236	-59.506964574	Buenos Aires
1347	Saladillo	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Saladillo	06707060	-35.638838983	-59.779377033	Buenos Aires
1348	Cucullú	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	San Andrés de Giles	06728020	-34.443358063	-59.360220417	Buenos Aires
1349	San Andrés de Giles	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	San Andrés de Giles	06728040	-34.442377419	-59.447519178	Buenos Aires
1350	Villa Espil	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	San Andrés de Giles	06728060	-34.505355312	-59.338339388	Buenos Aires
1351	Suipacha	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Suipacha	06784020	-34.768814588	-59.686829355	Buenos Aires
1352	Agustín Mosconi	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	25 de Mayo	06854010	-35.740317051	-60.557071201	Buenos Aires
1353	Del Valle	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	25 de Mayo	06854020	-35.899891805	-60.73027537	Buenos Aires
1354	Ernestina	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	25 de Mayo	06854030	-35.26892091	-59.55713232	Buenos Aires
1355	Gobernador Ugarte	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	25 de Mayo	06854040	-35.163891611	-60.078919244	Buenos Aires
1356	Lucas Monteverde	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	25 de Mayo	06854050	-35.482362749	-59.985834588	Buenos Aires
1357	Norberto de la Riestra	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	25 de Mayo	06854060	-35.273331417	-59.775553067	Buenos Aires
1358	Pedernales	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	25 de Mayo	06854070	-35.262362657	-59.630676245	Buenos Aires
1359	San Enrique	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	25 de Mayo	06854080	-35.769842179	-60.350450153	Buenos Aires
1360	Valdés	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	25 de Mayo	06854090	-35.648041427	-60.465676142	Buenos Aires
1361	25 de Mayo	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	25 de Mayo	06854100	-35.432471083	-60.171559351	Buenos Aires
1362	Gan Gan	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Telsen	26105010	-42.522203256	-68.284137526	Chubut
1363	Telsen	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Telsen	26105020	-42.435530619	-66.943212967	Chubut
1364	Prahuaniyeu	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	9 de Julio	62049040	-41.338082737	-67.905085957	Río Negro
1365	Yaminué	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	9 de Julio	62049070	-40.977491952	-67.192348604	Río Negro
1366	Comicó	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	9 de Julio	62049010	-41.070695753	-67.478068383	Río Negro
1367	Sierra Colorada	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	9 de Julio	62049050	-40.587376618	-67.755604151	Río Negro
1368	Treneta	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	9 de Julio	62049060	-41.174356236	-66.99459834	Río Negro
1369	Ministro Ramos Mexía	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	9 de Julio	62049030	-40.507036909	-67.260615435	Río Negro
1370	Cona Niyeu	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	9 de Julio	62049020	-41.865589763	-66.938659677	Río Negro
1371	Nahuel Niyeu	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Valcheta	62084040	-40.504113479	-66.564687554	Río Negro
1372	El Caín	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	25 de Mayo	62091040	-41.667360982	-68.161312869	Río Negro
1373	Aguada de Guerra	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	25 de Mayo	62091010	-41.067886644	-68.381726431	Río Negro
1374	Pilquiniyeu	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	25 de Mayo	62091090	-41.83174926	-68.351258177	Río Negro
1375	Los Menucos	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	25 de Mayo	62091060	-40.842809977	-68.085920088	Río Negro
1376	El Fuerte	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Santa Bárbara	38070010	-24.260514435	-64.414125102	Jujuy
1377	El Talar	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Santa Bárbara	38070030	-23.556358523	-64.359888824	Jujuy
1378	Palma Sola	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Santa Bárbara	38070040	-23.977738241	-64.304561725	Jujuy
1379	Vinalito	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Santa Bárbara	38070070	-23.667918562	-64.41366011	Jujuy
1380	Las Lajitas	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Anta	66007100	-24.72740169	-64.19546598	Salta
1381	Luis Burela	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Anta	66007110	-24.388651762	-63.98786093	Salta
1382	Piquete Cabado	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Anta	66007140	-24.820849964	-64.177666902	Salta
1383	General Pizarro	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Anta	66007080	-24.227508611	-63.988559046	Salta
1384	Coronel Mollinedo	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Anta	66007040	-24.540008855	-64.100839344	Salta
1385	Apolinario Saravia	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Anta	66007010	-24.430777451	-63.994945361	Salta
1386	Urundel	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Orán	66126080	-23.55786418	-64.396929833	Salta
1387	Santa Rosa	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Rivadavia	66133090	-24.025178863	-63.082248328	Salta
1388	Rivadavia	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Rivadavia	66133070	-24.18497085	-62.888304914	Salta
1389	La Unión	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Rivadavia	66133040	-23.896891808	-63.197034766	Salta
1390	Los Soria	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Banda	86035120	-27.622367823	-64.370587447	Santiago del Estero
1391	Los Quiroga	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Banda	86035110	-27.652603128	-64.354954815	Santiago del Estero
1392	Abra Grande	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Banda	86035010	-27.29016477	-64.378175591	Santiago del Estero
1393	La Aurora	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Banda	86035080	-27.495940281	-64.230664955	Santiago del Estero
1394	Ardiles	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Banda	86035030	-27.412056165	-64.4993209	Santiago del Estero
1395	Antajé	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Banda	86035020	-27.622919466	-64.25460115	Santiago del Estero
1396	Chaupi Pozo	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Banda	86035050	-27.506932754	-64.41984074	Santiago del Estero
1397	La Dársena	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Banda	86035100	-27.69841995	-64.288342993	Santiago del Estero
1398	La Banda	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Banda	86035090	-27.730650252	-64.243360445	Santiago del Estero
1399	Simbolar	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Banda	86035130	-27.653810866	-64.193121956	Santiago del Estero
1400	Tramo 16	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Banda	86035140	-27.696674371	-64.167153233	Santiago del Estero
1401	Tramo 20	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Banda	86035150	-27.721181558	-64.118498703	Santiago del Estero
1402	Huyamampa	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Banda	86035070	-27.385665158	-64.295232224	Santiago del Estero
1403	Yanda	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Capital	86049130	-27.909317915	-64.230309873	Santiago del Estero
1404	Morales	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Capital	86049070	-27.676149165	-64.365385095	Santiago del Estero
1405	Puesto de San Antonio	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Capital	86049080	-27.663084421	-64.378593877	Santiago del Estero
1406	Santa María	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Capital	86049100	-27.9490888	-64.219	Santiago del Estero
1407	El Deán	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Capital	86049010	-27.714647017	-64.331287458	Santiago del Estero
1408	El Mojón	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Capital	86049020	-27.993623294	-64.208100722	Santiago del Estero
1409	Maquito	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Capital	86049060	-27.882859653	-64.208818698	Santiago del Estero
1410	Los Cardozos	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Capital	86049040	-27.91241663	-64.198126781	Santiago del Estero
1411	San Pedro	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Capital	86049090	-27.946215052	-64.164005457	Santiago del Estero
1412	Maco	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Capital	86049050	-27.87026325	-64.216593203	Santiago del Estero
1413	Vuelta de la Barranca	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Capital	86049120	-27.891498947	-64.195691476	Santiago del Estero
1414	El Zanjón	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Capital	86049030	-27.87095531	-64.243197095	Santiago del Estero
1415	Santiago del Estero	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Capital	86049110	-27.787684474	-64.259668067	Santiago del Estero
1416	Laprida	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Choya	86063050	-28.375631993	-64.530551717	Santiago del Estero
1417	Isca Yacu	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Jiménez	86091050	-27.028890765	-64.611526959	Santiago del Estero
1418	Gramilla	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Jiménez	86091040	-27.29663055	-64.610280949	Santiago del Estero
1419	El Charco	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Jiménez	86091020	-27.225768021	-64.700302714	Santiago del Estero
1420	Pozo Hondo	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Jiménez	86091070	-27.167065357	-64.490762815	Santiago del Estero
1421	Isca Yacu Semaul	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Jiménez	86091060	-27.046911717	-64.618394797	Santiago del Estero
1422	Villa San Martín (Est. Loreto)	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Loreto	86105010	-28.30098634	-64.184139286	Santiago del Estero
1423	Las Cejas	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Cruz Alta	90014090	-26.888409116	-64.741125891	Tucumán
1424	Chauchillas	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Río Hondo	86147020	-27.519359388	-64.559433828	Santiago del Estero
1425	El Sauzal	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Río Hondo	86147120	-27.488395043	-64.582025673	Santiago del Estero
1426	El Charco	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Río Hondo	86147040	-27.234888152	-64.697822026	Santiago del Estero
1427	Pozuelos	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Río Hondo	86147100	-27.305639498	-64.754936711	Santiago del Estero
1428	Rodeo de Valdez	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Río Hondo	86147110	-27.550193407	-64.512494906	Santiago del Estero
1429	Vinará	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Río Hondo	86147170	-27.378899451	-64.794601841	Santiago del Estero
1430	Los Núñez	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Río Hondo	86147080	-27.534220818	-64.528834572	Santiago del Estero
1431	Los Miranda	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Río Hondo	86147070	-27.468365483	-64.615191013	Santiago del Estero
1432	Gramilla	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Río Hondo	86147050	-27.298581705	-64.61321273	Santiago del Estero
1433	Villa Río Hondo	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Río Hondo	86147150	-27.595621247	-64.873436698	Santiago del Estero
1434	Villa Giménez	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Río Hondo	86147140	-27.570993392	-64.477409299	Santiago del Estero
1435	Termas de Río Hondo	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Río Hondo	86147130	-27.49863499	-64.860713292	Santiago del Estero
1436	Vilmer	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Robles	86161050	-27.785425238	-64.151488762	Santiago del Estero
1437	Ingeniero Forres	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Robles	86161040	-27.874566364	-63.977373294	Santiago del Estero
1438	Estación Robles	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	San Martín	86175020	-28.049080042	-63.991232497	Santiago del Estero
1439	Villa Nueva	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	San Martín	86175040	-28.302444561	-64.02022583	Santiago del Estero
1440	Sumamao	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Silípica	86189040	-28.169398353	-64.098894433	Santiago del Estero
1441	Árraga	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Silípica	86189010	-28.051291691	-64.223791382	Santiago del Estero
1442	Simbol	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Silípica	86189030	-28.10106904	-64.213570522	Santiago del Estero
1443	Nueva Francia	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Silípica	86189020	-28.17376477	-64.199983024	Santiago del Estero
1444	Ancasti	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Ancasti	10014010	-28.812644051	-65.500687721	Catamarca
1445	Anquincila	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Ancasti	10014020	-28.746688269	-65.546324415	Catamarca
1446	La Candelaria	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Ancasti	10014030	-28.694306915	-65.43144842	Catamarca
1447	La Majada	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Ancasti	10014040	-29.029166077	-65.546724614	Catamarca
1448	Capayán	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Capayán	10042030	-28.774595326	-66.046485108	Catamarca
1449	Chumbicha	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Capayán	10042040	-28.853193032	-66.237562517	Catamarca
1450	Colonia del Valle	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Capayán	10042050	-28.65360707	-65.867857701	Catamarca
1451	Colonia Nueva Coneta	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Capayán	10042060	-28.578714714	-65.836461064	Catamarca
1452	Concepción	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Capayán	10042070	-28.687098494	-66.065887543	Catamarca
1453	Coneta	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Capayán	10042080	-28.579299229	-65.8877987	Catamarca
1454	El Bañado	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Capayán	10042090	-28.621487758	-65.856478282	Catamarca
1455	Huillapima	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Capayán	10042100	-28.7260731	-65.978747567	Catamarca
1456	Los Angeles	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Capayán	10042110	-28.452143799	-65.950438117	Catamarca
1457	Miraflores	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Capayán	10042120	-28.598736656	-65.902167776	Catamarca
1458	San Pablo	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Capayán	10042140	-28.700192467	-66.037070675	Catamarca
1459	San Pedro	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Capayán	10042150	-28.746002599	-66.124659332	Catamarca
1460	Naicó	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Toay	42140010	-36.925725759	-64.405072888	La Pampa
1461	San Fernando del Valle de Catamarca	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Capital	10049030	-28.469013241	-65.778917352	Catamarca
1462	El Alto	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	El Alto	10056010	-28.310610964	-65.364444112	Catamarca
1463	Guayamba	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	El Alto	10056020	-28.343244067	-65.399654793	Catamarca
1464	Infanzón	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	El Alto	10056030	-28.579033525	-65.405000625	Catamarca
1465	Los Corrales	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	El Alto	10056040	-28.493405128	-65.325181016	Catamarca
1466	Tapso	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	El Alto	10056050	-28.40485789	-65.102730788	Catamarca
1467	Vilismán	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	El Alto	10056060	-28.497723671	-65.433100306	Catamarca
1468	Pomancillo Este	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Fray Mamerto Esquiú	10063020	-28.302562655	-65.719572558	Catamarca
1469	Pomancillo Oeste	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Fray Mamerto Esquiú	10063030	-28.304455029	-65.731799378	Catamarca
1470	San José	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Fray Mamerto Esquiú	10063040	-28.3875664	-65.700924753	Catamarca
1471	Villa Las Pirquitas	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Fray Mamerto Esquiú	10063050	-28.279903385	-65.732110638	Catamarca
1472	El Aybal	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	La Paz	10070020	-29.109330138	-65.36122102	Catamarca
1473	Icaño	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	La Paz	10070070	-28.919540473	-65.330165196	Catamarca
1474	Las Esquinas	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	La Paz	10070100	-28.737028792	-65.108928809	Catamarca
1475	Las Palmitas	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	La Paz	10070110	-28.637189289	-64.986114025	Catamarca
1476	Quirós	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	La Paz	10070120	-28.785887721	-65.110953707	Catamarca
1477	Ramblones	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	La Paz	10070130	-29.153957412	-65.398363941	Catamarca
1478	San Antonio	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	La Paz	10070150	-28.932482381	-65.09691698	Catamarca
1479	Palo Labrado	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Paclín	10077090	-28.321038581	-65.619347915	Catamarca
1480	Colana	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Pomán	10084020	-28.362396202	-66.159755741	Catamarca
1481	El Pajonal	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Pomán	10084040	-28.37214105	-66.295086458	Catamarca
1482	Mutquin	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Pomán	10084060	-28.314846954	-66.149014187	Catamarca
1483	Pomán	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Pomán	10084070	-28.395281144	-66.218286632	Catamarca
1484	El Portezuelo	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Valle Viejo	10112010	-28.470103363	-65.635601956	Catamarca
1485	Huaycama	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Valle Viejo	10112020	-28.517293087	-65.67650417	Catamarca
1486	Las Tejas	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Valle Viejo	10112030	-28.658682582	-65.783801545	Catamarca
1487	San Isidro	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Valle Viejo	10112040	-28.457753399	-65.724976045	Catamarca
1488	Santa Cruz	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Valle Viejo	10112050	-28.500922509	-65.664118479	Catamarca
1489	Ancaján	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Choya	86063010	-28.443893439	-64.929402351	Santiago del Estero
1490	Tapso	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Choya	86063080	-28.403754611	-65.096249433	Santiago del Estero
1491	Frías	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Choya	86063040	-28.637544186	-65.128728352	Santiago del Estero
1492	Villa La Punta	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Choya	86063090	-28.369725994	-64.794671997	Santiago del Estero
1493	Choya	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Choya	86063020	-28.496103427	-64.856284377	Santiago del Estero
1494	Estación La Punta	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Choya	86063030	-28.41029946	-64.755365957	Santiago del Estero
1495	San Pedro	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Choya	86063070	-28.468034242	-64.866976339	Santiago del Estero
1496	Villa Atamisqui	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Atamisqui	86021030	-28.496444045	-63.817328561	Santiago del Estero
1497	Estación Atamisqui	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Atamisqui	86021010	-28.493728905	-63.937446074	Santiago del Estero
1498	Medellín	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Atamisqui	86021020	-28.652341341	-63.785507444	Santiago del Estero
1499	Sumampa	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Quebrachos	86140020	-29.382556802	-63.474837161	Santiago del Estero
1500	Villa Ojo de Agua	2026-11-08 23:05:59.661	2026-11-08 23:05:59.661	Ojo de Agua	86126030	-29.502807384	-63.69496837	Santiago del Estero
1501	El 49	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Ojo de Agua	86126010	-29.050580659	-63.957935237	Santiago del Estero
1502	Ramírez de Velazco	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Quebrachos	86140010	-29.230952325	-63.47425428	Santiago del Estero
1503	Sumampa Viejo	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Quebrachos	86140030	-29.385103821	-63.434293611	Santiago del Estero
1504	Los Telares	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Salavina	86168020	-28.985075234	-63.450399707	Santiago del Estero
1505	Villa Salavina	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Salavina	86168030	-28.804316923	-63.429650574	Santiago del Estero
1506	Chilca Juliana	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Salavina	86168010	-28.797201837	-63.575344251	Santiago del Estero
1507	Brea Pozo	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	San Martín	86175010	-28.243852744	-63.953337339	Santiago del Estero
1508	Juan E. Barra	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Adolfo Gonzales Chaves	06014030	-37.820038607	-60.482055449	Buenos Aires
1509	Vásquez	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Adolfo Gonzales Chaves	06014040	-38.175801007	-60.169791056	Buenos Aires
1510	Ariel	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Azul	06049010	-36.5314223	-59.921751904	Buenos Aires
1511	Chillar	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Azul	06049040	-37.312803844	-59.985165667	Buenos Aires
1512	Benito Juárez	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Benito Juárez	06084020	-37.674284974	-59.804805184	Buenos Aires
1513	Energía	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Necochea	06581025	-38.55794328	-59.340811799	Buenos Aires
1514	Colonia Nievas	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Olavarría	06595030	-36.865323467	-60.082383424	Buenos Aires
1515	Olavarría	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Olavarría	06595070	-36.893842322	-60.323193714	Buenos Aires
1516	Santa Luisa	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Olavarría	06595090	-37.125659804	-60.416451013	Buenos Aires
1517	Sierra Chica	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Olavarría	06595100	-36.844883449	-60.226751826	Buenos Aires
1518	Balneario San Cayetano	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	San Cayetano	06742010	-38.748108275	-59.430469595	Buenos Aires
1519	Ochandío	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	San Cayetano	06742020	-38.35921193	-59.793272139	Buenos Aires
1520	San Cayetano	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	San Cayetano	06742030	-38.345789247	-59.606759879	Buenos Aires
1521	Gardey	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Tandil	06791030	-37.279725033	-59.362868818	Buenos Aires
1522	María Ignacia	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Tandil	06791040	-37.401384244	-59.505928794	Buenos Aires
1523	Claromecó	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Tres Arroyos	06833020	-38.85747512	-60.072799598	Buenos Aires
1524	Copetonas	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Tres Arroyos	06833030	-38.721440874	-60.451743721	Buenos Aires
1525	Micaela Cascallares	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Tres Arroyos	06833050	-38.494114342	-60.468351214	Buenos Aires
1526	Orense	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Tres Arroyos	06833060	-38.688273125	-59.780691445	Buenos Aires
1527	San Francisco de Bellocq	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Tres Arroyos	06833080	-38.689536391	-60.013936189	Buenos Aires
1528	Tres Arroyos	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Tres Arroyos	06833100	-38.377196696	-60.27521507	Buenos Aires
1529	Villa Rodríguez	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Tres Arroyos	06833110	-38.312396365	-60.231646703	Buenos Aires
1530	Concepción del Bermejo	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Almirante Brown	22007010	-26.600330586	-60.946176961	Chaco
1531	Los Frentones	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Almirante Brown	22007020	-26.407068009	-61.412880579	Chaco
1532	Pampa del Infierno	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Almirante Brown	22007030	-26.503558396	-61.176572447	Chaco
1533	Presidencia Roque Sáenz Peña	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Comandante Fernández	22021010	-26.790971775	-60.441248325	Chaco
1534	Charata	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Chacabuco	22028010	-27.217922303	-61.187347968	Chaco
1535	Gancedo	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	12 de Octubre	22036010	-27.487414446	-61.676696715	Chaco
1536	General Capdevila	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	12 de Octubre	22036020	-27.422571353	-61.476141509	Chaco
1537	General Pinedo	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	12 de Octubre	22036030	-27.325386156	-61.280998282	Chaco
1538	Mesón de Fierro	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	12 de Octubre	22036040	-27.429812575	-61.017099355	Chaco
1539	Pampa Landriel	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	12 de Octubre	22036050	-27.394683971	-61.102562709	Chaco
1540	Itín	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	2 de Abril	22039020	-27.487431931	-61.324482004	Chaco
1541	Corzuela	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	General Belgrano	22049010	-26.95130654	-60.970338269	Chaco
1542	Avia Terai	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Independencia	22070010	-26.686651675	-60.728030835	Chaco
1543	Campo Largo	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Independencia	22070020	-26.800310492	-60.839017867	Chaco
1544	Fortín Las Chuñas	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Independencia	22070030	-26.884353327	-60.909562968	Chaco
1545	Napenay	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Independencia	22070040	-26.729587113	-60.616776057	Chaco
1546	Tres Isletas	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Maipú	22091010	-26.340324562	-60.431261529	Chaco
1547	Las Breñas	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	9 de Julio	22105010	-27.086438454	-61.085822822	Chaco
1548	La Clotilde	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	O'Higgins	22112010	-27.177337111	-60.632669647	Chaco
1549	La Tigra	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	O'Higgins	22112020	-27.114230446	-60.587658205	Chaco
1550	San Bernardo	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	O'Higgins	22112030	-27.286719318	-60.712849173	Chaco
1551	Quitilipi	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Quitilipi	22133010	-26.87079068	-60.215199589	Chaco
1552	Villa El Palmar	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Quitilipi	22133020	-26.454504023	-60.164404877	Chaco
1553	Samuhú	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	San Lorenzo	22147010	-27.519107677	-60.394025971	Chaco
1554	Villa Berthet	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	San Lorenzo	22147020	-27.285322697	-60.415974493	Chaco
1555	Haumonia	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Tapenagá	22161030	-27.507639581	-60.178198749	Chaco
1556	Colonia Aborigen	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	25 de Mayo	22168010	-26.955888162	-60.202872864	Chaco
1557	Napalpí	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	25 de Mayo	22168030	-26.902500846	-60.129806202	Chaco
1558	General Vedia	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Bermejo	22014010	-26.937934158	-58.66197026	Chaco
1559	La Leonesa	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Bermejo	22014030	-27.038148723	-58.707248624	Chaco
1560	Las Palmas	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Bermejo	22014040	-27.048750965	-58.682396024	Chaco
1561	Puerto Bermejo Nuevo	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Bermejo	22014050	-26.907786353	-58.541700845	Chaco
1562	Puerto Bermejo Viejo	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Bermejo	22014060	-26.9269363	-58.509115707	Chaco
1563	Puerto Eva Perón	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Bermejo	22014070	-26.663700014	-58.632397225	Chaco
1564	Colonia Pastoril	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Formosa	34014010	-25.672693191	-58.261494859	Formosa
1565	Formosa	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Formosa	34014020	-26.185008983	-58.174896483	Formosa
1566	Gran Guardia	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Formosa	34014030	-25.862762272	-58.885728596	Formosa
1567	Mariano Boedo	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Formosa	34014040	-26.109324814	-58.487754375	Formosa
1568	Mojón de Fierro	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Formosa	34014050	-26.033189506	-58.049051	Formosa
1569	San Hilario	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Formosa	34014060	-26.029992112	-58.652255708	Formosa
1570	Banco Payaguá	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Laishi	34021010	-26.707422197	-58.338339819	Formosa
1571	General Lucio V. Mansilla	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Laishi	34021020	-26.657689509	-58.630460262	Formosa
1572	Herradura	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Laishi	34021030	-26.48984781	-58.311618191	Formosa
1573	San Francisco de Laishi	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Laishi	34021040	-26.243867035	-58.629613052	Formosa
1574	Tatané	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Laishi	34021050	-26.398152825	-58.357336954	Formosa
1575	Villa Escolar	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Laishi	34021060	-26.621916792	-58.669706677	Formosa
1576	Buena Vista	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Pilagás	34042010	-25.071500409	-58.385528602	Formosa
1577	El Espinillo	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Pilagás	34042020	-24.981482853	-58.552561591	Formosa
1578	Laguna Gallo	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Pilagás	34042030	-25.269085715	-58.742320087	Formosa
1579	Misión Tacaaglé	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Pilagás	34042040	-24.980999991	-58.819934389	Formosa
1580	Portón Negro	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Pilagás	34042050	-24.966091465	-58.742546184	Formosa
1581	Tres Lagunas	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Pilagás	34042060	-25.216124037	-58.513078609	Formosa
1582	Clorinda	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Pilcomayo	34049010	-25.286080881	-57.7224082	Formosa
1583	Laguna Blanca	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Pilcomayo	34049020	-25.126264296	-58.240457282	Formosa
1584	Laguna Naick-Neck	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Pilcomayo	34049030	-25.22273689	-58.12101582	Formosa
1585	Palma Sola	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Pilcomayo	34049040	-25.247972716	-57.976269482	Formosa
1586	Puerto Pilcomayo	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Pilcomayo	34049050	-25.372224407	-57.651606485	Formosa
1587	Riacho He-He	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Pilcomayo	34049060	-25.360656781	-58.279795911	Formosa
1588	Riacho Negro	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Pilcomayo	34049070	-25.423970866	-57.793279659	Formosa
1589	Siete Palmas	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Pilcomayo	34049080	-25.203691143	-58.332003225	Formosa
1590	Hermoso Campo	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	2 de Abril	22039010	-27.610016382	-61.344235858	Chaco
1591	Chorotis	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Fray Justo Santa María de Oro	22043010	-27.914644528	-61.401399313	Chaco
1592	Santa Sylvina	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Fray Justo Santa María de Oro	22043020	-27.831610977	-61.136000369	Chaco
1593	Venados Grandes	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Fray Justo Santa María de Oro	22043030	-27.816347945	-61.382884098	Chaco
1594	Coronel Du Graty	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Mayor Luis J. Fontana	22098010	-27.682213408	-60.904342213	Chaco
1595	Enrique Urien	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Mayor Luis J. Fontana	22098020	-27.556672395	-60.526967372	Chaco
1596	Villa Angela	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Mayor Luis J. Fontana	22098030	-27.576877556	-60.711125666	Chaco
1597	Gato Colorado	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	9 de Julio	82077020	-28.022389719	-61.18658218	Santa Fe
1598	Cañada Escobar	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Banda	86035040	-27.70849722	-64.023154751	Santiago del Estero
1599	Clodomira	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Banda	86035060	-27.580564285	-64.135225577	Santiago del Estero
1600	Villa Figueroa	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Figueroa	86070100	-27.721227928	-63.506563063	Santiago del Estero
1601	Vilelas	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Juan Felipe Ibarra	86098050	-27.961219785	-62.608938197	Santiago del Estero
1602	El Colorado	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Juan Felipe Ibarra	86098010	-27.914534351	-62.177357286	Santiago del Estero
1603	Roversi	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Moreno	86119110	-27.592326631	-61.943729679	Santiago del Estero
1604	Quimili	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Moreno	86119100	-27.644686248	-62.417370197	Santiago del Estero
1605	Beltrán	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Robles	86161010	-27.826833801	-64.058760101	Santiago del Estero
1606	Fernández	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Robles	86161030	-27.925315293	-63.894588379	Santiago del Estero
1607	Colonia El Simbolar	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Robles	86161020	-27.727566804	-63.858759666	Santiago del Estero
1608	Estación Taboada	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	San Martín	86175030	-28.008451724	-63.744409958	Santiago del Estero
1609	Garza	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Sarmiento	86182010	-28.152941114	-63.538873347	Santiago del Estero
1610	Villa Silípica	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Silípica	86189050	-28.108463743	-64.149598742	Santiago del Estero
1611	San Martín	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Capayán	10042130	-29.220623199	-65.774504452	Catamarca
1612	Casa de Piedra	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	La Paz	10070010	-29.604548136	-65.519736382	Catamarca
1613	El Bañado	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	La Paz	10070030	-29.194968606	-65.43727565	Catamarca
1614	El Divisadero	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	La Paz	10070040	-29.201527423	-65.45248378	Catamarca
1615	El Quimilo	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	La Paz	10070050	-29.899352076	-65.397904813	Catamarca
1616	Esquiú	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	La Paz	10070060	-29.378861011	-65.29026282	Catamarca
1617	La Dorada	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	La Paz	10070080	-29.244821162	-65.482548512	Catamarca
1618	La Guardia	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	La Paz	10070090	-29.556525947	-65.452925126	Catamarca
1619	Recreo	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	La Paz	10070140	-29.278860259	-65.058611479	Catamarca
1620	Aguas Calientes	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	El Carmen	38014010	-24.584432478	-64.923249881	Jujuy
1621	Barrio El Milagro	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	El Carmen	38014020	-24.463444197	-65.119204101	Jujuy
1622	Barrio La Unión	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	El Carmen	38014030	-24.404731632	-65.070459343	Jujuy
1623	El Carmen	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	El Carmen	38014040	-24.389285978	-65.261542319	Jujuy
1624	Los Lapachos	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	El Carmen	38014050	-24.476997979	-65.076720412	Jujuy
1625	Manantiales	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	El Carmen	38014060	-24.53430916	-64.976902513	Jujuy
1626	Monterrico	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	El Carmen	38014070	-24.442960445	-65.166093314	Jujuy
1627	Pampa Blanca	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	El Carmen	38014080	-24.535175926	-65.072552267	Jujuy
1628	Perico	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	El Carmen	38014090	-24.376047261	-65.118085779	Jujuy
1629	Puesto Viejo	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	El Carmen	38014100	-24.486338543	-64.964904373	Jujuy
1630	San Isidro	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	El Carmen	38014110	-24.556081198	-64.942066696	Jujuy
1631	San Juancito	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	El Carmen	38014120	-24.383312058	-64.99519055	Jujuy
1632	Guerrero	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Dr. Manuel Belgrano	38021010	-24.186451258	-65.448948163	Jujuy
1633	La Almona	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Dr. Manuel Belgrano	38021020	-24.259342879	-65.393957075	Jujuy
1634	León	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Dr. Manuel Belgrano	38021030	-24.035242032	-65.431831856	Jujuy
1635	Lozano	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Dr. Manuel Belgrano	38021040	-24.077605508	-65.408708914	Jujuy
1636	Ocloyas	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Dr. Manuel Belgrano	38021050	-23.944110041	-65.231701931	Jujuy
1637	San Salvador de Jujuy	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Dr. Manuel Belgrano	38021060	-24.185828671	-65.29948308	Jujuy
1638	Tesorero	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Dr. Manuel Belgrano	38021065	-23.948005183	-65.299563125	Jujuy
1639	Yala	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Dr. Manuel Belgrano	38021070	-24.119709941	-65.402072628	Jujuy
1640	Paulina	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Ledesma	38035100	-23.845065447	-64.740544449	Jujuy
1641	Calilegua	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Ledesma	38035040	-23.774568857	-64.770037042	Jujuy
1642	Bananal	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Ledesma	38035010	-23.566436339	-64.499212872	Jujuy
1643	Bermejito	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Ledesma	38035020	-23.788737712	-64.72993166	Jujuy
1644	Caimancito	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Ledesma	38035030	-23.739937475	-64.591600526	Jujuy
1645	Chalicán	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Ledesma	38035050	-24.069356524	-64.806403347	Jujuy
1646	Fraile Pintado	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Ledesma	38035060	-23.944116485	-64.803035335	Jujuy
1647	Libertad	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Ledesma	38035070	-23.762396325	-64.727269509	Jujuy
1648	Libertador General San Martín	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Ledesma	38035080	-23.815214953	-64.792855684	Jujuy
1649	Maíz Negro	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Ledesma	38035090	-23.951192934	-64.773730939	Jujuy
1650	Yuto	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Ledesma	38035110	-23.642801892	-64.471641954	Jujuy
1651	Carahunco	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Palpalá	38042010	-24.307748398	-65.082138021	Jujuy
1652	Centro Forestal	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Palpalá	38042020	-24.229027194	-65.178415284	Jujuy
1653	Palpalá	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Palpalá	38042040	-24.257893809	-65.213486764	Jujuy
1654	San Antonio	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	San Antonio	38056030	-24.370454676	-65.331696619	Jujuy
1655	El Ceibal	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	San Antonio	38056010	-24.298920017	-65.272248326	Jujuy
1656	Los Alisos	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	San Antonio	38056017	-24.268573631	-65.300295664	Jujuy
1657	Loteo Navea	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	San Antonio	38056020	-24.270281627	-65.275602275	Jujuy
1658	Nuestra Señora del Rosario	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	San Antonio	38056025	-24.317374127	-65.401742276	Jujuy
1659	La Manga	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	San Pedro	38063080	-24.191179999	-64.847623115	Jujuy
1660	El Acheral	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	San Pedro	38063040	-24.403155224	-64.800634194	Jujuy
1661	Arrayanal	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	San Pedro	38063010	-24.178567066	-64.840231354	Jujuy
1662	Arroyo Colorado	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	San Pedro	38063020	-24.337011395	-64.663056051	Jujuy
1663	Don Emilio	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	San Pedro	38063030	-24.317207715	-64.906764228	Jujuy
1664	El Puesto	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	San Pedro	38063050	-24.198110088	-64.789626482	Jujuy
1665	El Quemado	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	San Pedro	38063060	-24.104591121	-64.824024714	Jujuy
1666	La Esperanza	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	San Pedro	38063070	-24.224656083	-64.838539501	Jujuy
1667	La Mendieta	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	San Pedro	38063090	-24.31444589	-64.966779253	Jujuy
1668	Palos Blancos	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	San Pedro	38063110	-24.326989049	-64.945732637	Jujuy
1669	Piedritas	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	San Pedro	38063130	-24.295756149	-64.882177182	Jujuy
1670	Rodeito	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	San Pedro	38063140	-24.27154986	-64.769409779	Jujuy
1671	Rosario de Río Grande (ex Barro Negro)	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	San Pedro	38063150	-24.308524564	-64.931641726	Jujuy
1672	San Antonio	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	San Pedro	38063160	-24.218682844	-64.806787484	Jujuy
1673	San Lucas	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	San Pedro	38063170	-24.268441648	-64.864753507	Jujuy
1674	San Pedro	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	San Pedro	38063180	-24.231728279	-64.867816067	Jujuy
1675	El Piquete	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Santa Bárbara	38070020	-24.178433511	-64.679017441	Jujuy
1676	Puente Lavayén	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Santa Bárbara	38070050	-24.273138346	-64.705788827	Jujuy
1677	Santa Clara	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Santa Bárbara	38070060	-24.309370135	-64.661845869	Jujuy
1678	Juella	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Tilcara	38094030	-23.522661992	-65.400013751	Jujuy
1679	Huacalera	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Tilcara	38094020	-23.439038897	-65.350011327	Jujuy
1680	Maimará	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Tilcara	38094040	-23.624541034	-65.408815862	Jujuy
1681	Tilcara	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Tilcara	38094050	-23.576895159	-65.393372926	Jujuy
1682	Bárcena	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Tumbaya	38098010	-23.982234712	-65.452446088	Jujuy
1683	Puerta de Colorados	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Tumbaya	38098025	-23.571003147	-65.697124662	Jujuy
1684	Purmamarca	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Tumbaya	38098030	-23.746594489	-65.499200142	Jujuy
1685	Tumbaya	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Tumbaya	38098040	-23.857699038	-65.467558523	Jujuy
1686	Volcán	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Tumbaya	38098050	-23.917153342	-65.464047605	Jujuy
1687	Valle Grande	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Valle Grande	38105060	-23.475818565	-64.94676989	Jujuy
1688	Pampichuela	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Valle Grande	38105020	-23.554591595	-65.008179102	Jujuy
1689	San Francisco	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Valle Grande	38105030	-23.622082726	-64.95061868	Jujuy
1690	Valle Colorado	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Valle Grande	38105050	-23.413735347	-64.933419189	Jujuy
1691	Villa San Lorenzo	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Capital	66028060	-24.73122988	-65.486314409	Salta
1692	Salta	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Capital	66028050	-24.789272032	-65.410286036	Salta
1693	El Bordo	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	General Güemes	66049030	-24.659884422	-65.106470628	Salta
1694	Cobos	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	General Güemes	66049020	-24.736009882	-65.084726135	Salta
1695	Vaqueros	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	La Caldera	66077020	-24.696475385	-65.410619866	Salta
1696	La Caldera	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	La Caldera	66077010	-24.602693752	-65.380635169	Salta
1697	La Merced del Encón	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Rosario de Lerma	66147015	-24.872808923	-65.563222395	Salta
1698	La Silleta	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Rosario de Lerma	66147020	-24.874976031	-65.590480453	Salta
1699	Bahía Blanca	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Bahía Blanca	06056010	-38.717605091	-62.265446934	Buenos Aires
1700	Cabildo	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Bahía Blanca	06056020	-38.485152883	-61.893752163	Buenos Aires
1701	General Daniel Cerri	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Bahía Blanca	06056030	-38.719365546	-62.395308976	Buenos Aires
1702	Balneario Pehuen Co	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Coronel de Marina Leonardo Rosales	06182020	-38.999893567	-61.553664054	Buenos Aires
1703	Marisol	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Coronel Dorrego	06189020	-38.920511966	-60.534993315	Buenos Aires
1704	San Román	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Coronel Dorrego	06189080	-38.741809917	-61.538278643	Buenos Aires
1705	Lartigau	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Coronel Pringles	06196050	-38.447209317	-61.566887006	Buenos Aires
1706	Centinela del Mar	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	General Alvarado	06280005	-38.43660769	-58.219130297	Buenos Aires
1707	Balneario Sauce Grande	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Monte Hermoso	06553010	-38.99376182	-61.208011352	Buenos Aires
1708	Monte Hermoso	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Monte Hermoso	06553020	-38.986663249	-61.290928746	Buenos Aires
1709	Necochea - Quequén	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Necochea	06581040	-38.554460163	-58.73923682	Buenos Aires
1710	Ramón Santamarina	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Necochea	06581060	-38.449126632	-59.330507986	Buenos Aires
1711	Bahía San Blas	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Patagones	06602010	-40.554648117	-62.23676311	Buenos Aires
1712	Cardenal Cagliero	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Patagones	06602020	-40.65015578	-62.755627171	Buenos Aires
1713	Carmen de Patagones	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Patagones	06602030	-40.802515153	-62.983602186	Buenos Aires
1714	José B. Casas	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Patagones	06602040	-40.435320702	-62.544123049	Buenos Aires
1715	Juan A. Pradere	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Patagones	06602050	-39.602451577	-62.65279464	Buenos Aires
1716	Stroeder	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Patagones	06602060	-40.185829201	-62.620247659	Buenos Aires
1717	Villalonga	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Patagones	06602070	-39.917574035	-62.618770688	Buenos Aires
1718	Balneario Orense	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Tres Arroyos	06833010	-38.807442643	-59.737482196	Buenos Aires
1719	Reta	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Tres Arroyos	06833070	-38.894893983	-60.344858064	Buenos Aires
1720	Argerich	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Villarino	06875010	-38.770235558	-62.60295463	Buenos Aires
1721	Hilario Ascasubi	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Villarino	06875030	-39.375650448	-62.647369157	Buenos Aires
1722	Mayor Buratovich	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Villarino	06875050	-39.260869644	-62.615247469	Buenos Aires
1723	Médanos	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Villarino	06875060	-38.829264944	-62.693309604	Buenos Aires
1724	Pedro Luro	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Villarino	06875070	-39.501496871	-62.679828769	Buenos Aires
1725	Teniente Origone	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Villarino	06875080	-39.057809418	-62.570414559	Buenos Aires
1726	El Cóndor	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Adolfo Alsina	62007020	-41.04128575	-62.829010314	Río Negro
1727	Loteo Costa de Río	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Adolfo Alsina	62007060	-40.869804012	-62.920389149	Río Negro
1728	Viedma	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Adolfo Alsina	62007090	-40.80836773	-62.99492873	Río Negro
1729	Puerto Argentino	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Islas del Atlántico Sur	94021010	-51.693679127	-57.860855504	Tierra del Fuego, Antártida e Islas del Atlántico Sur
1730	Almirante Brown	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Almirante Brown	06028010	-34.79801384	-58.384329627	Buenos Aires
1731	Barrio Parque Las Acacias	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Brandsen	06119040	-35.098580859	-58.277254774	Buenos Aires
1732	Gobernador Udaondo	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Cañuelas	06134040	-35.302672673	-58.595979417	Buenos Aires
1733	Máximo Paz	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Cañuelas	06134050	-34.936869444	-58.618873605	Buenos Aires
1734	Esteban Echeverría	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Esteban Echeverría	06260010	-34.819389535	-58.465911896	Buenos Aires
1735	Ezeiza	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Ezeiza	06270010	-34.854393958	-58.524757807	Buenos Aires
1736	Florencio Varela	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Florencio Varela	06274010	-34.80443679	-58.279252772	Buenos Aires
1737	General Belgrano	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	General Belgrano	06301010	-35.765676199	-58.497163273	Buenos Aires
1738	Loma Verde	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	General Paz	06343020	-35.274009158	-58.403828253	Buenos Aires
1739	Ranchos	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	General Paz	06343030	-35.516405572	-58.318815518	Buenos Aires
1740	Villanueva	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	General Paz	06343040	-35.675306098	-58.433879052	Buenos Aires
1741	Lomas de Zamora	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Lomas de Zamora	06490010	-34.757283817	-58.402716798	Buenos Aires
1742	Presidente Perón	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Presidente Perón	06648010	-34.917771926	-58.379299537	Buenos Aires
1743	San Vicente	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	San Vicente	06778020	-35.024908874	-58.42405791	Buenos Aires
1744	Berón de Astrada	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Berón de Astrada	18014010	-27.550219206	-57.528414751	Corrientes
1745	Yahapé	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Berón de Astrada	18014020	-27.371446098	-57.655037355	Corrientes
1746	Corrientes	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Capital	18021020	-27.463345014	-58.839472846	Corrientes
1747	Riachuelo	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Capital	18021040	-27.580434938	-58.743116833	Corrientes
1748	San Cayetano	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Capital	18021050	-27.571208591	-58.695878654	Corrientes
1749	Concepción	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Concepción	18028010	-28.393200862	-57.886916862	Corrientes
1750	Santa Rosa	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Concepción	18028020	-28.267278912	-58.122724375	Corrientes
1751	Tabay	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Concepción	18028030	-28.308135913	-58.286865634	Corrientes
1752	Tatacua	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Concepción	18028040	-28.37591942	-58.321136161	Corrientes
1753	El Sombrero	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Empedrado	18042010	-27.703542822	-58.76860599	Corrientes
1754	Empedrado	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Empedrado	18042020	-27.950703029	-58.803095212	Corrientes
1755	Itá Ibaté	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	General Paz	18063010	-27.425876016	-57.338126807	Corrientes
1756	Lomas de Vallejos	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	General Paz	18063020	-27.737884627	-57.919896896	Corrientes
1757	Nuestra Señora del Rosario de Caá Catí	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	General Paz	18063030	-27.752150845	-57.621998156	Corrientes
1758	Palmar Grande	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	General Paz	18063040	-27.941267287	-57.900958206	Corrientes
1759	Itatí	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Itatí	18077010	-27.26921666	-58.242421269	Corrientes
1760	Ramada Paso	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Itatí	18077020	-27.366183933	-58.299624036	Corrientes
1761	Mburucuyá	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Mburucuyá	18098010	-28.046857582	-58.23030567	Corrientes
1762	Saladas	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Saladas	18126010	-28.255067029	-58.623726747	Corrientes
1763	San Lorenzo	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Saladas	18126020	-28.138098797	-58.768132414	Corrientes
1764	Ingenio Primer Correntino	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	San Cosme	18133010	-27.43364493	-58.6243084	Corrientes
1765	Paso de la Patria	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	San Cosme	18133020	-27.317374261	-58.572564148	Corrientes
1766	San Cosme	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	San Cosme	18133030	-27.370373364	-58.512513441	Corrientes
1767	Santa Ana	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	San Cosme	18133040	-27.455354998	-58.654760346	Corrientes
1768	San Luis del Palmar	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	San Luis del Palmar	18140010	-27.507698655	-58.556147715	Corrientes
1769	San Miguel	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	San Miguel	18154020	-27.998325926	-57.587311303	Corrientes
1770	Colonia Pando	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	San Roque	18161020	-28.52379744	-58.487585317	Corrientes
1771	San Roque	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	San Roque	18161050	-28.569303233	-58.705134985	Corrientes
1772	Isla del Cerrito	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Bermejo	22014020	-27.291499117	-58.619429488	Chaco
1773	Barrio de los Pescadores	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	1° de Mayo	22126010	-27.461060063	-58.867574061	Chaco
1774	Calingasta	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Calingasta	70021020	-31.334524027	-69.420703498	San Juan
1775	Tamberías	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Calingasta	70021030	-31.458098859	-69.421552695	San Juan
1776	Barreal - Villa Pituil	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Calingasta	70021010	-31.644735977	-69.472077947	San Juan
1777	Abra Pampa	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Cochinoca	38007020	-22.722692271	-65.697039178	Jujuy
1778	La Redonda	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Cochinoca	38007055	-22.528891929	-65.522273067	Jujuy
1779	Puesto del Marquéz	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Cochinoca	38007060	-22.536960665	-65.697462501	Jujuy
1780	Uquía	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Humahuaca	38028060	-23.30359271	-65.356079107	Jujuy
1781	Palca de Aparzo	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Humahuaca	38028043	-23.122405764	-65.134705889	Jujuy
1782	Aparzo	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Humahuaca	38028003	-23.099527083	-65.185770526	Jujuy
1783	Cianzo	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Humahuaca	38028007	-23.173204866	-65.158442371	Jujuy
1784	Coctaca	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Humahuaca	38028010	-23.154207728	-65.293503959	Jujuy
1785	El Aguilar	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Humahuaca	38028020	-23.213339178	-65.678927773	Jujuy
1786	Hipólito Yrigoyen	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Humahuaca	38028030	-22.978732536	-65.352660193	Jujuy
1787	Humahuaca	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Humahuaca	38028040	-23.205929513	-65.347453577	Jujuy
1788	Palca de Varas	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Humahuaca	38028045	-23.100325178	-65.110307837	Jujuy
1789	Rodero	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Humahuaca	38028047	-23.062366689	-65.326551464	Jujuy
1790	Tres Cruces	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Humahuaca	38028050	-22.918210554	-65.587585191	Jujuy
1791	Colonia San José	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Tilcara	38094010	-23.39268845	-65.345610822	Jujuy
1792	Caspalá	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Valle Grande	38105010	-23.36337184	-65.092438117	Jujuy
1793	Santa Ana	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Valle Grande	38105040	-23.355999005	-64.989155263	Jujuy
1794	Yavi	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Yavi	38112080	-22.130724484	-65.46253081	Jujuy
1795	Barrios	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Yavi	38112010	-22.247072172	-65.529268378	Jujuy
1796	Cangrejillos	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Yavi	38112020	-22.424232323	-65.580994619	Jujuy
1797	El Cóndor	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Yavi	38112030	-22.388319412	-65.337989848	Jujuy
1798	La Intermedia	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Yavi	38112040	-22.421172238	-65.701509753	Jujuy
1799	La Quiaca	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Yavi	38112050	-22.104451782	-65.596373475	Jujuy
1800	Llulluchayoc	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Yavi	38112060	-22.548789141	-65.387508562	Jujuy
1801	Pumahuasi	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Yavi	38112070	-22.289972823	-65.680073858	Jujuy
1802	Yavi Chico	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Yavi	38112090	-22.098939543	-65.45920144	Jujuy
1803	Pueblo Viejo	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Iruya	66070030	-22.836208013	-65.21553813	Salta
1804	Iruya	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Iruya	66070010	-22.792107338	-65.21628439	Salta
1805	Isla de Cañas	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Iruya	66070020	-22.899138979	-64.665199432	Salta
1806	Acoyte	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Santa Victoria	66161010	-22.28383024	-65.017674579	Salta
1807	Los Toldos	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Santa Victoria	66161030	-22.280369617	-64.698920887	Salta
1808	Santa Victoria	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Santa Victoria	66161070	-22.250444219	-64.964784803	Salta
1809	Poscaya	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Santa Victoria	66161050	-22.454405759	-65.083221766	Salta
1810	Nazareno	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Santa Victoria	66161040	-22.509476796	-65.102376383	Salta
1811	San Marcos	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Santa Victoria	66161060	-22.51544181	-65.112323901	Salta
1812	Campo La Cruz	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Santa Victoria	66161020	-22.498892335	-65.098018327	Salta
1813	Payogasta	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Cachi	66014020	-25.051434869	-66.102945197	Salta
1814	Cachi	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Cachi	66014010	-25.119967649	-66.161875924	Salta
1815	La Merced	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Cerrillos	66035020	-24.966945266	-65.489014182	Salta
1816	Cerrillos	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Cerrillos	66035010	-24.89581252	-65.487144817	Salta
1817	San Agustín	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Cerrillos	66035030	-24.995961589	-65.440814024	Salta
1818	Chicoana	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Chicoana	66042010	-25.102667289	-65.535047007	Salta
1819	Barrio Finca La Maroma	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Chicoana	66042003	-25.153321191	-65.439353087	Salta
1820	El Carril	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Chicoana	66042020	-25.076671906	-65.489236682	Salta
1821	Barrio La Rotonda	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Chicoana	66042005	-25.08263504	-65.537633497	Salta
1822	Barrio Santa Teresita	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Chicoana	66042007	-25.037119421	-65.572162585	Salta
1823	Campo Santo	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	General Güemes	66049010	-24.6829668	-65.104944715	Salta
1824	General Güemes	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	General Güemes	66049040	-24.674447207	-65.04659792	Salta
1825	Guachipas	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Guachipas	66063010	-25.522652966	-65.51002807	Salta
1826	La Poma	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	La Poma	66091020	-24.722564168	-66.200581705	Salta
1827	Cabra Corral	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	La Viña	66098020	-25.270643318	-65.332758127	Salta
1828	Coronel Moldes	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	La Viña	66098030	-25.280035817	-65.47846014	Salta
1829	La Viña	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	La Viña	66098040	-25.468117224	-65.565560967	Salta
1830	Talapampa	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	La Viña	66098050	-25.545560572	-65.556133128	Salta
1831	Ampascachi	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	La Viña	66098010	-25.352653217	-65.528229304	Salta
1832	Lumbreras	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Metán	66112030	-25.210271997	-64.927045901	Salta
1833	San José de Metán (Est. Metán)	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Metán	66112040	-25.497105506	-64.971059894	Salta
1834	Río Piedras	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Metán	66112070	-25.31432503	-64.910381683	Salta
1835	Molinos	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Molinos	66119020	-25.437227276	-66.294511802	Salta
1836	La Puerta	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Molinos	66119010	-25.280054955	-66.449909389	Salta
1837	Seclantás	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Molinos	66119030	-25.331758268	-66.244202461	Salta
1838	Rosario de Lerma	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Rosario de Lerma	66147030	-24.985826022	-65.578396911	Salta
1839	Campo Quijano	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Rosario de Lerma	66147010	-24.908133387	-65.64298302	Salta
1840	Carlos Tejedor	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Carlos Tejedor	06154010	-35.39148631	-62.419953461	Buenos Aires
1841	Colonia Seré	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Carlos Tejedor	06154020	-35.436470395	-62.727929128	Buenos Aires
1842	Curarú	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Carlos Tejedor	06154030	-35.640914059	-62.194703733	Buenos Aires
1843	Timote	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Carlos Tejedor	06154040	-35.34754722	-62.222942583	Buenos Aires
1844	Tres Algarrobos	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Carlos Tejedor	06154050	-35.195595821	-62.774409303	Buenos Aires
1845	Blaquier	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Florentino Ameghino	06277010	-34.63616331	-62.477770049	Buenos Aires
1846	Florentino Ameghino	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Florentino Ameghino	06277020	-34.845372421	-62.467156842	Buenos Aires
1847	Porvenir	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Florentino Ameghino	06277030	-34.950413361	-62.223737644	Buenos Aires
1848	General Pinto	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	General Pinto	06351020	-34.764331577	-61.891628075	Buenos Aires
1849	Villa Francia	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	General Pinto	06351040	-34.790121518	-62.201023203	Buenos Aires
1850	Banderaló	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	General Villegas	06392010	-35.014868405	-63.375961819	Buenos Aires
1851	Cañada Seca	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	General Villegas	06392020	-34.416817258	-62.960835761	Buenos Aires
1852	Coronel Charlone	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	General Villegas	06392030	-34.674016043	-63.369405538	Buenos Aires
1853	Emilio V. Bunge	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	General Villegas	06392040	-34.783513929	-63.195653814	Buenos Aires
1854	General Villegas	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	General Villegas	06392050	-35.032634265	-63.015025648	Buenos Aires
1855	Massey	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	General Villegas	06392060	-35.048966582	-63.122211965	Buenos Aires
1856	Pichincha	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	General Villegas	06392070	-34.579198478	-62.351630657	Buenos Aires
1857	Toay	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Toay	42140020	-36.673898048	-64.379789715	La Pampa
1858	Piedritas	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	General Villegas	06392080	-34.76721632	-62.98592021	Buenos Aires
1859	Santa Eleodora	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	General Villegas	06392090	-34.694508272	-62.695580542	Buenos Aires
1860	Santa Regina	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	General Villegas	06392100	-34.549560646	-63.173340456	Buenos Aires
1861	Villa Saboya	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	General Villegas	06392110	-34.459972213	-62.649274422	Buenos Aires
1862	Villa Sauze	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	General Villegas	06392120	-35.285857421	-63.36865216	Buenos Aires
1863	Arenaza	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Lincoln	06469010	-34.985021022	-61.77432129	Buenos Aires
1864	Carlos Salas	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Lincoln	06469040	-35.392337639	-61.992628437	Buenos Aires
1865	Las Toscas	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Lincoln	06469070	-35.364580921	-61.805550203	Buenos Aires
1866	Pasteur	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Lincoln	06469090	-35.141358508	-62.244158801	Buenos Aires
1867	Roberts	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Lincoln	06469100	-35.142912462	-61.970438933	Buenos Aires
1868	San Esteban	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Pehuajó	06609020	-35.731514314	-61.742242159	Buenos Aires
1869	Inocencio Sosa	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Pehuajó	06609035	-35.719429814	-62.109526755	Buenos Aires
1870	América	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Rivadavia	06679010	-35.489164048	-62.975891683	Buenos Aires
1871	Fortín Olavarría	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Rivadavia	06679020	-35.70262432	-63.024057448	Buenos Aires
1872	González Moreno	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Rivadavia	06679030	-35.555286642	-63.380291212	Buenos Aires
1873	Mira Pampa	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Rivadavia	06679040	-35.870194304	-63.37367163	Buenos Aires
1874	Roosevelt	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Rivadavia	06679050	-35.846899984	-63.290956351	Buenos Aires
1875	San Mauricio	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Rivadavia	06679060	-35.510773194	-63.188285295	Buenos Aires
1876	Sansinena	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Rivadavia	06679070	-35.274390818	-63.214325575	Buenos Aires
1877	Sundblad	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Rivadavia	06679080	-35.764548358	-63.140209344	Buenos Aires
1878	Trenque Lauquen	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Trenque Lauquen	06826050	-35.973335898	-62.732745053	Buenos Aires
1879	Ceballos	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Chapaleufú	42056020	-35.290785063	-63.77698721	La Pampa
1880	Bernardo Larroude	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Chapaleufú	42056010	-35.02594931	-63.582754454	La Pampa
1881	Coronel Hilario Lagos	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Chapaleufú	42056030	-35.024121555	-63.91207132	La Pampa
1882	Intendente Alvear	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Chapaleufú	42056040	-35.23467944	-63.592087436	La Pampa
1883	Sarah	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Chapaleufú	42056050	-35.028078931	-63.685933016	La Pampa
1884	Vértiz	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Chapaleufú	42056060	-35.427443782	-63.90998592	La Pampa
1885	Dorila	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Maracó	42105020	-35.776322951	-63.716840693	La Pampa
1886	Agustoni	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Maracó	42105010	-35.782070983	-63.39161443	La Pampa
1887	General Pico	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Maracó	42105030	-35.659300434	-63.757871729	La Pampa
1888	Speluzzi	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Maracó	42105040	-35.549708017	-63.820509711	La Pampa
1889	Trebolares	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Maracó	42105050	-35.584468828	-63.589077894	La Pampa
1890	Quemú Quemú	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Quemú Quemú	42119040	-36.054826981	-63.565940109	La Pampa
1891	Caleufú	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Rancul	42126010	-35.594491218	-64.558677161	La Pampa
1892	Parera	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Rancul	42126040	-35.146759722	-64.502308409	La Pampa
1893	Alta Italia	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Realicó	42133020	-35.334423692	-64.117141474	La Pampa
1894	Embajador Martini	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Realicó	42133040	-35.387348476	-64.282766943	La Pampa
1895	Falucho	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Realicó	42133050	-35.190726497	-64.107065219	La Pampa
1896	Ingeniero Luiggi	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Realicó	42133060	-35.388471149	-64.467370568	La Pampa
1897	Ojeda	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Realicó	42133070	-35.30694142	-64.006079893	La Pampa
1898	Realicó	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Realicó	42133080	-35.038214374	-64.246307522	La Pampa
1899	Arata	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Trenel	42147010	-35.639082134	-64.356363514	La Pampa
1900	Metileo	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Trenel	42147020	-35.774156864	-63.940631857	La Pampa
1901	Trenel	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Trenel	42147030	-35.698328528	-64.13328451	La Pampa
1902	Alto de los Quebrachos	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Cruz del Eje	14028010	-30.543284493	-65.036726706	Córdoba
1903	Guanaco Muerto	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Cruz del Eje	14028080	-30.478643717	-65.061599947	Córdoba
1904	La Batea	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Cruz del Eje	14028100	-30.372274191	-65.308150684	Córdoba
1905	Los Chañaritos	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Cruz del Eje	14028140	-30.557676819	-64.953746576	Córdoba
1906	Chuña	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Ischilín	14049030	-30.467074174	-64.670231173	Córdoba
1907	Deán Funes	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Ischilín	14049050	-30.424977177	-64.352739312	Córdoba
1908	Los Pozos	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Ischilín	14049080	-30.519180415	-64.252289256	Córdoba
1909	Olivares de San Nicolás	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Ischilín	14049090	-30.601226424	-64.855605521	Córdoba
1910	Quilino	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Ischilín	14049100	-30.214174175	-64.499368247	Córdoba
1911	San Pedro de Toyos	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Ischilín	14049110	-30.454212234	-64.444894985	Córdoba
1912	Cerro Colorado	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Río Seco	14112010	-30.095583847	-63.932161876	Córdoba
1913	Chañar Viejo	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Río Seco	14112020	-29.99840498	-63.85273423	Córdoba
1914	Eufrasio Loza	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Río Seco	14112030	-29.924738217	-63.590814803	Córdoba
1915	Gutemberg	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Río Seco	14112040	-29.720899995	-63.515152605	Córdoba
1916	Los Hoyos	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Río Seco	14112060	-29.802462609	-63.628246701	Córdoba
1917	Puesto de Castro	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Río Seco	14112070	-30.270528697	-63.426359575	Córdoba
1918	Rayo Cortado	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Río Seco	14112080	-30.072991401	-63.823602557	Córdoba
1919	San Pedro de Gütemberg	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Río Seco	14112090	-29.698365022	-63.560688021	Córdoba
1920	Santa Elena	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Río Seco	14112100	-30.115706858	-63.84290271	Córdoba
1921	Sebastián Elcano	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Río Seco	14112110	-30.160405514	-63.592489977	Córdoba
1922	Villa Candelaria	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Río Seco	14112120	-29.812910245	-63.355126119	Córdoba
1923	Villa de María	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Río Seco	14112130	-29.906523133	-63.722561971	Córdoba
1924	Caminiaga	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Sobremonte	14154010	-30.06748016	-64.050701811	Córdoba
1925	Chuña Huasi	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Sobremonte	14154030	-29.933707595	-64.112560351	Córdoba
1926	Pozo Nuevo	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Sobremonte	14154040	-29.578736309	-64.101494449	Córdoba
1927	San Francisco del Chañar	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Sobremonte	14154050	-29.786352909	-63.941697762	Córdoba
1928	Las Peñas	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Totoral	14168060	-30.563962858	-64.000266576	Córdoba
1929	Simbolar	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Totoral	14168100	-30.474412714	-63.984714007	Córdoba
1930	Churqui Cañada	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Tulumba	14175020	-30.173740807	-63.926890887	Córdoba
1931	El Rodeo	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Tulumba	14175030	-30.175238116	-63.864131194	Córdoba
1932	El Tuscal	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Tulumba	14175040	-29.764265156	-64.525429091	Córdoba
1933	Las Arrias	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Tulumba	14175050	-30.381745792	-63.596900356	Córdoba
1934	Lucio V. Mansilla	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Tulumba	14175060	-29.804523605	-64.711438053	Córdoba
1935	Rosario del Saladillo	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Tulumba	14175070	-30.43142827	-63.473941368	Córdoba
1936	San José de la Dormida	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Tulumba	14175080	-30.356269405	-63.950292815	Córdoba
1937	San José de las Salinas	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Tulumba	14175090	-30.006952106	-64.623939268	Córdoba
1938	San Pedro Norte	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Tulumba	14175100	-30.09108152	-64.154927138	Córdoba
1939	Villa Tulumba	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Tulumba	14175110	-30.395354235	-64.122308936	Córdoba
1940	Sol de Julio	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Ojo de Agua	86126020	-29.565328197	-63.457078784	Santiago del Estero
1941	Río Muerto	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Almirante Brown	22007040	-26.307126109	-61.655759435	Chaco
1942	El Sauzalito	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	General Güemes	22063030	-24.427972815	-61.68323252	Chaco
1943	Fuerte Esperanza	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	General Güemes	22063050	-25.160514418	-61.841372067	Chaco
1944	La Rinconada	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Bermejo	34007007	-23.494796161	-61.576653565	Formosa
1945	Pozo de Maza	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Bermejo	34007030	-23.570321915	-61.708060029	Formosa
1946	Vaca Perdida	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Bermejo	34007050	-23.499587643	-61.648426828	Formosa
1947	Ingeniero Guillermo N. Juárez	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Matacos	34028010	-23.90373915	-61.842429269	Formosa
1948	El Potrillo	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Ramón Lista	34063010	-23.16244021	-62.008962864	Formosa
1949	General Mosconi	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Ramón Lista	34063020	-23.183829531	-62.306572015	Formosa
1950	El Quebracho	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Ramón Lista	34063030	-23.342517804	-61.871584013	Formosa
1951	Alto de la Sierra	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Rivadavia	66133010	-22.739952615	-62.498021316	Salta
1952	Capitán Juan Pagé	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Rivadavia	66133020	-23.688308992	-62.376247127	Salta
1953	Los Blancos	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Rivadavia	66133050	-23.609415223	-62.594788379	Salta
1954	Coronel Manuel L. Rico	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Alberdi	86014020	-26.38574131	-61.812284484	Santiago del Estero
1955	Donadeu	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Alberdi	86014030	-26.725264947	-62.720730229	Santiago del Estero
1956	Campo Gallo	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Alberdi	86014010	-26.583952542	-62.847050151	Santiago del Estero
1957	Los Pirpintos	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Copo	86056030	-26.131679505	-62.064365218	Santiago del Estero
1958	Monte Quemado	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Copo	86056050	-25.803569594	-62.830131952	Santiago del Estero
1959	Los Tigres	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Copo	86056040	-25.909211697	-62.591202459	Santiago del Estero
1960	El Caburé	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Copo	86056010	-26.015884209	-62.334173398	Santiago del Estero
1961	Hernán Mejía Miraval	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Moreno	86119040	-27.177183761	-62.469650185	Santiago del Estero
1962	Pueblo Pablo Torelo	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Moreno	86119090	-27.327815005	-62.225192918	Santiago del Estero
1963	Alhuampa	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Moreno	86119020	-27.127546164	-62.547599144	Santiago del Estero
1964	Hasse	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Moreno	86119030	-27.066833474	-62.647245672	Santiago del Estero
1965	Weisburd	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Moreno	86119130	-27.31890121	-62.585042016	Santiago del Estero
1966	Aerolito	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Moreno	86119010	-27.234196881	-62.378765675	Santiago del Estero
1967	Tintina	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Moreno	86119120	-27.026289876	-62.706405354	Santiago del Estero
1968	Amboy	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Calamuchita	14007010	-32.174579284	-64.573243646	Córdoba
1969	Arroyo San Antonio	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Calamuchita	14007020	-32.25622512	-64.607798047	Córdoba
1970	Cañada del Sauce	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Calamuchita	14007030	-32.367960087	-64.645426112	Córdoba
1971	El Corcovado - El Torreón	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Calamuchita	14007050	-32.14043434	-64.503477855	Córdoba
1972	El Durazno	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Calamuchita	14007055	-32.169801031	-64.773885151	Córdoba
1973	Embalse	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Calamuchita	14007060	-32.206746995	-64.40064261	Córdoba
1974	La Cruz	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Calamuchita	14007070	-32.303113598	-64.483041443	Córdoba
1975	La Cumbrecita	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Calamuchita	14007080	-31.899787854	-64.773166839	Córdoba
1976	Las Bajadas	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Calamuchita	14007090	-32.096159139	-64.330074291	Córdoba
1977	Las Caleras	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Calamuchita	14007100	-32.388803244	-64.521435805	Córdoba
1978	Los Cóndores	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Calamuchita	14007110	-32.321125968	-64.280742286	Córdoba
1979	Los Molinos	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Calamuchita	14007120	-31.854862434	-64.378931203	Córdoba
1980	Los Reartes	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Calamuchita	14007130	-31.918307888	-64.575821001	Córdoba
1981	Lutti	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Calamuchita	14007140	-32.318498273	-64.746985901	Córdoba
1982	Parque Calmayo	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Calamuchita	14007160	-32.02546988	-64.464679067	Córdoba
1983	Río de los Sauces	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Calamuchita	14007170	-32.528642164	-64.58868756	Córdoba
1984	San Agustín	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Calamuchita	14007180	-31.97762234	-64.375585682	Córdoba
1985	San Ignacio (Loteo San Javier)	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Calamuchita	14007190	-32.165905283	-64.517909727	Córdoba
1986	Santa Rosa de Calamuchita	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Calamuchita	14007210	-32.064378008	-64.539561962	Córdoba
1987	Segunda Usina	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Calamuchita	14007220	-32.1650007	-64.379184128	Córdoba
1988	Solar de los Molinos	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Calamuchita	14007230	-31.828275356	-64.521302493	Córdoba
1989	Merlo	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Junín	74049060	-32.34263514	-65.013732534	San Luis
1990	Villa Alpina	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Calamuchita	14007240	-31.956360004	-64.813456486	Córdoba
1991	Villa Amancay	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Calamuchita	14007250	-32.186184046	-64.567389214	Córdoba
1992	Villa Berna	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Calamuchita	14007260	-31.911000044	-64.726343683	Córdoba
1993	Villa Ciudad Parque Los Reartes	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Calamuchita	14007270	-31.912066443	-64.530613522	Córdoba
1994	Villa del Dique	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Calamuchita	14007290	-32.176351223	-64.456938495	Córdoba
1995	Villa El Tala	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Calamuchita	14007300	-32.252714933	-64.584117858	Córdoba
1996	Villa General Belgrano	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Calamuchita	14007310	-31.976492814	-64.559053659	Córdoba
1997	Villa La Rivera	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Calamuchita	14007320	-32.266632505	-64.524715383	Córdoba
1998	Villa Quillinzo	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Calamuchita	14007330	-32.236547432	-64.513604106	Córdoba
1999	Villa Rumipal	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Calamuchita	14007340	-32.189383276	-64.479205883	Córdoba
2000	Villa Yacanto	2026-11-08 23:05:59.691	2026-11-08 23:05:59.691	Calamuchita	14007360	-32.103594962	-64.754522347	Córdoba
2001	Alcira Gigena	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Río Cuarto	14098030	-32.75882923	-64.334033416	Córdoba
2002	Alpa Corral	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Río Cuarto	14098040	-32.692112408	-64.723596602	Córdoba
2003	Berrotarán	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Río Cuarto	14098050	-32.452841735	-64.387939111	Córdoba
2004	Coronel Baigorria	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Río Cuarto	14098090	-32.847404529	-64.361077012	Córdoba
2005	Elena	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Río Cuarto	14098110	-32.570393963	-64.393904926	Córdoba
2006	Las Albahacas	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Río Cuarto	14098160	-32.88840918	-64.844842472	Córdoba
2007	Villa El Chacay	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Río Cuarto	14098300	-32.892555418	-64.867955226	Córdoba
2008	Arroyo Los Patos	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	San Alberto	14126020	-31.762599051	-65.004348905	Córdoba
2009	Las Calles	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	San Alberto	14126050	-31.82404385	-64.971425081	Córdoba
2010	Las Rabonas	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	San Alberto	14126070	-31.853561746	-64.979880403	Córdoba
2011	Mina Clavero	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	San Alberto	14126090	-31.729427643	-65.005000339	Córdoba
2012	Nono	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	San Alberto	14126110	-31.797204699	-65.002498778	Córdoba
2013	San Pedro	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	San Alberto	14126160	-31.936473985	-65.21886785	Córdoba
2014	Sauce Arriba	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	San Alberto	14126180	-31.912673226	-65.166934481	Córdoba
2015	Villa Cura Brochero	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	San Alberto	14126200	-31.706460725	-65.018606389	Córdoba
2016	Villa Sarmiento	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	San Alberto	14126210	-31.936241107	-65.193098314	Córdoba
2017	Conlara	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	San Javier	14133010	-32.077353468	-65.229460448	Córdoba
2018	La Paz	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	San Javier	14133060	-32.217525316	-65.048264539	Córdoba
2019	La Población	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	San Javier	14133070	-32.066252611	-65.029617254	Córdoba
2020	La Travesía	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	San Javier	14133090	-32.114557231	-65.043683466	Córdoba
2021	Las Tapias	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	San Javier	14133100	-31.953053644	-65.097966111	Córdoba
2022	Los Hornillos	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	San Javier	14133120	-31.903342468	-64.989754936	Córdoba
2023	Luyaba	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	San Javier	14133150	-32.149721185	-65.058482569	Córdoba
2024	San Javier y Yacanto	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	San Javier	14133170	-32.026469651	-65.030268367	Córdoba
2025	Villa de las Rosas	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	San Javier	14133190	-31.947086539	-65.052115338	Córdoba
2026	Villa La Viña	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	San Javier	14133210	-31.872041045	-65.035468367	Córdoba
2027	Anisacate	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Santa María	14147020	-31.725502527	-64.414068999	Córdoba
2028	Despeñaderos	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Santa María	14147080	-31.814280553	-64.294775003	Córdoba
2029	Dique Chico	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Santa María	14147090	-31.745849116	-64.365810859	Córdoba
2030	José de la Quintana	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Santa María	14147115	-31.80267143	-64.4145833	Córdoba
2031	La Boca del Río	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Santa María	14147120	-31.839975351	-64.437936692	Córdoba
2032	La Paisanita	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Santa María	14147150	-31.720939824	-64.48192749	Córdoba
2033	La Rancherita y Las Cascadas	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Santa María	14147170	-31.754829253	-64.459039075	Córdoba
2034	La Serranita	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Santa María	14147180	-31.735666229	-64.45561019	Córdoba
2035	Monte Ralo	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Santa María	14147220	-31.910722778	-64.239942287	Córdoba
2036	Potrero de Garay	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Santa María	14147230	-31.780095827	-64.545377626	Córdoba
2037	San Clemente	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Santa María	14147250	-31.714514959	-64.628280187	Córdoba
2038	Valle de Anisacate	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Santa María	14147300	-31.729956401	-64.420213745	Córdoba
2039	Villa Ciudad de América	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Santa María	14147310	-31.791879762	-64.508654756	Córdoba
2040	Villa La Bolsa	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Santa María	14147330	-31.729659249	-64.42945142	Córdoba
2041	Villa Los Aromos	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Santa María	14147340	-31.734487986	-64.439068948	Córdoba
2042	Villa San Isidro	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Santa María	14147360	-31.825925434	-64.383554476	Córdoba
2043	Almafuerte	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Tercero Arriba	14161010	-32.192390466	-64.255745208	Córdoba
2044	Concarán	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Chacabuco	74028010	-32.560876404	-65.244547331	San Luis
2045	Villa del Carmen	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Chacabuco	74028080	-32.939954661	-65.038880335	San Luis
2046	Cortaderas	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Chacabuco	74028020	-32.505257531	-64.992153159	San Luis
2047	Papagayos	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Chacabuco	74028040	-32.675103211	-64.988949678	San Luis
2048	Carpintería	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Junín	74049010	-32.410102689	-65.009919409	San Luis
2049	Los Molles	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Junín	74049050	-32.438599752	-65.0097622	San Luis
2050	Córdoba	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Capital	14014010	-31.416804475	-64.183606532	Córdoba
2051	Colonia Caroya	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Colón	14021050	-31.022055587	-64.061712868	Córdoba
2052	Colonia Tirolesa	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Colón	14021060	-31.237276187	-64.066295789	Córdoba
2053	Colonia Vicente Agüero	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Colón	14021070	-31.028521686	-64.018682793	Córdoba
2054	Villa Corazón de María	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Colón	14021075	-31.443991353	-63.995764764	Córdoba
2055	General Paz	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Colón	14021130	-31.134480643	-64.140150624	Córdoba
2056	Jesús María	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Colón	14021140	-30.976130936	-64.095793168	Córdoba
2057	La Puerta	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Colón	14021170	-31.143164257	-64.041265742	Córdoba
2058	Malvinas Argentinas	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Colón	14021190	-31.374253576	-64.053691733	Córdoba
2059	Mi Granja	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Colón	14021210	-31.355350007	-64.003189418	Córdoba
2060	Tinoco	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Colón	14021270	-31.124507498	-63.891795267	Córdoba
2061	Parque Norte - Ciudad de los Niños - Guiñazú Norte	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Colón	14021310	-31.312414626	-64.176190867	Córdoba
2062	Villa Los Llanos - Juárez Celman	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Colón	14021320	-31.275729827	-64.1646158	Córdoba
2063	Atahona	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Río Primero	14105010	-30.902967427	-63.706329494	Córdoba
2064	Cañada de Machado	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Río Primero	14105020	-31.429720387	-63.587725916	Córdoba
2065	Capilla de los Remedios	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Río Primero	14105030	-31.430555885	-63.832425211	Córdoba
2066	Chalacea	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Río Primero	14105040	-30.760396666	-63.561242339	Córdoba
2067	Colonia Las Cuatro Esquinas	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Río Primero	14105050	-31.208548036	-63.22296867	Córdoba
2068	Diego de Rojas	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Río Primero	14105060	-31.028540066	-63.338383223	Córdoba
2069	El Alcalde	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Río Primero	14105070	-31.116407938	-63.601616285	Córdoba
2070	El Crispín	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Río Primero	14105080	-31.017606725	-63.605351168	Córdoba
2071	Esquina	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Río Primero	14105090	-31.077912152	-63.793640549	Córdoba
2072	Kilómetro 658	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Río Primero	14105100	-31.368848622	-63.530628418	Córdoba
2073	La Posta	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Río Primero	14105120	-30.565574782	-63.516964065	Córdoba
2074	La Puerta	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Río Primero	14105130	-30.893342948	-63.254825453	Córdoba
2075	La Quinta	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Río Primero	14105140	-31.061901912	-63.15132661	Córdoba
2076	Las Gramillas	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Río Primero	14105150	-31.131793821	-63.227884729	Córdoba
2077	Las Saladas	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Río Primero	14105160	-30.759600883	-63.204275808	Córdoba
2078	Maquinista Gallini	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Río Primero	14105170	-30.908601789	-63.531607624	Córdoba
2079	Monte del Rosario	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Río Primero	14105180	-30.982267214	-63.601830375	Córdoba
2080	Montecristo	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Río Primero	14105190	-31.34198602	-63.947225299	Córdoba
2081	Obispo Trejo	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Río Primero	14105200	-30.781292395	-63.410365749	Córdoba
2082	Piquillín	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Río Primero	14105210	-31.300599739	-63.757673055	Córdoba
2083	Plaza de Mercedes	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Río Primero	14105220	-30.978355107	-63.260688235	Córdoba
2084	Pueblo Comechingones	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Río Primero	14105230	-31.171488727	-63.60532599	Córdoba
2085	Río Primero	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Río Primero	14105240	-31.333871791	-63.618572375	Córdoba
2086	Sagrada Familia	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Río Primero	14105250	-31.28932729	-63.445433354	Córdoba
2087	Santa Rosa de Río Primero	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Río Primero	14105260	-31.153527657	-63.399412602	Córdoba
2088	Calchín	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Río Segundo	14119010	-31.668857135	-63.199043019	Córdoba
2089	Calchín Oeste	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Río Segundo	14119020	-31.862548935	-63.277785993	Córdoba
2090	Capilla del Carmen	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Río Segundo	14119030	-31.507679646	-63.343145043	Córdoba
2091	Colazo	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Río Segundo	14119050	-31.964561431	-63.382678348	Córdoba
2092	Colonia Videla	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Río Segundo	14119060	-31.917276973	-63.503508079	Córdoba
2093	Costasacate	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Río Segundo	14119070	-31.645319233	-63.75886866	Córdoba
2094	Impira	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Río Segundo	14119080	-31.798473811	-63.650083467	Córdoba
2095	Laguna Larga	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Río Segundo	14119090	-31.775699453	-63.80032654	Córdoba
2096	Las Junturas	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Río Segundo	14119100	-31.831396212	-63.450636575	Córdoba
2097	Los Chañaritos	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Río Segundo	14119110	-31.40252991	-63.330501319	Córdoba
2098	Luque	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Río Segundo	14119120	-31.647726289	-63.34508172	Córdoba
2099	Manfredi	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Río Segundo	14119130	-31.84575732	-63.747558013	Córdoba
2100	Matorrales	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Río Segundo	14119140	-31.714710564	-63.510718351	Córdoba
2101	Oncativo	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Río Segundo	14119150	-31.913432104	-63.682021405	Córdoba
2102	Pilar	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Río Segundo	14119160	-31.681265237	-63.88239584	Córdoba
2103	Rincón	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Río Segundo	14119180	-31.595859647	-63.617020431	Córdoba
2104	Río Segundo	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Río Segundo	14119190	-31.650152759	-63.911862843	Córdoba
2105	Santiago Temple	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Río Segundo	14119200	-31.385985415	-63.419637503	Córdoba
2106	Villa del Rosario	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Río Segundo	14119210	-31.5541005	-63.535697319	Córdoba
2107	Tránsito	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	San Justo	14140400	-31.424342692	-63.193560455	Córdoba
2108	Villa del Tránsito	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	San Justo	14140430	-31.448178731	-63.194303779	Córdoba
2109	Caseros Centro	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Santa María	14147060	-31.531099203	-64.160014358	Córdoba
2110	Lozada	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Santa María	14147200	-31.64967812	-64.089704446	Córdoba
2111	Socavones	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Santa María	14147270	-31.533046951	-64.143508235	Córdoba
2112	Toledo	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Santa María	14147280	-31.553783809	-64.007370952	Córdoba
2113	Colonia Almada	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Tercero Arriba	14161020	-32.03502468	-63.864784578	Córdoba
2114	Corralito	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Tercero Arriba	14161030	-32.023723206	-64.191990504	Córdoba
2115	Los Zorros	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Tercero Arriba	14161100	-32.044972804	-63.202240247	Córdoba
2116	Oliva	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Tercero Arriba	14161110	-32.038258607	-63.570676452	Córdoba
2117	Candelaria Sur	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Totoral	14168010	-30.838967446	-63.801268051	Córdoba
2118	Cañada de Luque	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Totoral	14168020	-30.735237543	-63.723971029	Córdoba
2119	Capilla de Sitón	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Totoral	14168030	-30.57368678	-63.653712457	Córdoba
2120	Los Mistoles	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Totoral	14168070	-30.626687202	-63.886117287	Córdoba
2121	Sarmiento	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Totoral	14168090	-30.774471197	-64.109502906	Córdoba
2122	Sinsacate	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Totoral	14168110	-30.942929273	-64.094032941	Córdoba
2123	Villa del Totoral	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Totoral	14168120	-30.704621872	-64.068141444	Córdoba
2124	Bowen	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	General Alvear	50014010	-35.000348599	-67.510340476	Mendoza
2125	Carmensa	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	General Alvear	50014020	-35.14808103	-67.655274967	Mendoza
2126	General Alvear	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	General Alvear	50014030	-34.977471584	-67.69618281	Mendoza
2127	Los Compartos	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	General Alvear	50014040	-34.977858624	-67.651170701	Mendoza
2128	Desaguadero	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	La Paz	50042010	-33.402538663	-67.155499706	Mendoza
2129	Villa Antigua	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	La Paz	50042030	-33.465140459	-67.593874925	Mendoza
2130	La Paz	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	La Paz	50042020	-33.461695637	-67.552276812	Mendoza
2131	Real del Padre	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	San Rafael	50105190	-34.842532067	-67.768924866	Mendoza
2132	La Calera	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Belgrano	74014010	-32.863433167	-66.849528929	San Luis
2133	Villa de la Quebrada	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Belgrano	74014030	-33.016021165	-66.288056649	San Luis
2134	Nogolí	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Belgrano	74014020	-32.91866741	-66.324714581	San Luis
2135	Estancia Grande	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Coronel Pringles	74021025	-33.189597863	-66.152599472	San Luis
2136	El Trapiche	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Coronel Pringles	74021020	-33.109236459	-66.063069241	San Luis
2137	La Toma	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Coronel Pringles	74021060	-33.054496729	-65.621375639	San Luis
2138	Saladillo	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Coronel Pringles	74021090	-33.202471528	-65.855323757	San Luis
2139	La Florida	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Coronel Pringles	74021050	-33.116731643	-66.003452803	San Luis
2140	San José del Morro	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	General Pedernera	74035060	-33.212344139	-65.491184133	San Luis
2141	Villa Mercedes	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	General Pedernera	74035070	-33.674470984	-65.46219778	San Luis
2142	Villa Reynolds	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	General Pedernera	74035080	-33.720962439	-65.383626249	San Luis
2143	Unión	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Gobernador Dupuy	74042140	-35.153783082	-65.946151682	San Luis
2144	Nación Ranquel	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	General Pedernera	74035055	-34.608227301	-65.716984934	San Luis
2145	Juan Llerena	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	General Pedernera	74035020	-33.280768727	-65.613960957	San Luis
2146	Lavaisse	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	General Pedernera	74035050	-33.822840925	-65.426491915	San Luis
2147	Nahuel Mapá	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Gobernador Dupuy	74042110	-34.785738803	-66.176330564	San Luis
2148	Buena Esperanza	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Gobernador Dupuy	74042050	-34.757888445	-65.253589203	San Luis
2149	Fortín El Patria	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Gobernador Dupuy	74042060	-34.772469056	-65.522757778	San Luis
2150	Fortuna	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Gobernador Dupuy	74042070	-35.130700428	-65.38309285	San Luis
2151	Nueva Galia	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Gobernador Dupuy	74042130	-35.115181075	-65.258733995	San Luis
2152	Navia	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Gobernador Dupuy	74042120	-34.774862985	-66.586441832	San Luis
2153	Batavia	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Gobernador Dupuy	74042040	-34.778346253	-65.69004896	San Luis
2154	Bagual	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Gobernador Dupuy	74042030	-35.143044624	-65.56988317	San Luis
2155	Potrero de los Funes	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Juan Martín de Pueyrredón	74056120	-33.217398192	-66.231269585	San Luis
2156	Alto Pelado	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Juan Martín de Pueyrredón	74056010	-33.837028822	-66.13907334	San Luis
2157	Cazador	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Juan Martín de Pueyrredón	74056050	-33.854770633	-66.369078543	San Luis
2158	Mosmota	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Juan Martín de Pueyrredón	74056110	-33.671178592	-66.972013852	San Luis
2159	Zanjitas	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Juan Martín de Pueyrredón	74056160	-33.804980729	-66.415049043	San Luis
2160	La Punta	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Juan Martín de Pueyrredón	74056105	-33.183675136	-66.312480949	San Luis
2161	Beazley	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Juan Martín de Pueyrredón	74056040	-33.757483866	-66.64467913	San Luis
2162	Alto Pencoso	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Juan Martín de Pueyrredón	74056020	-33.432932478	-66.92594294	San Luis
2163	Paso Grande	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Libertador General San Martín	74063050	-32.87732241	-65.635054992	San Luis
2164	Gobernador Duval	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Curacó	42042010	-38.742942079	-66.435428074	La Pampa
2165	Puelches	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Curacó	42042020	-38.146302088	-65.914040626	La Pampa
2166	Algarrobo del Águila	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Chical Co	42063010	-36.398084405	-67.144491462	La Pampa
2167	Limay Mahuida	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Limay Mahuida	42091020	-37.15983037	-66.675123682	La Pampa
2168	Victorica	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Loventué	42098050	-36.216536869	-65.437086415	La Pampa
2169	Puelén	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Puelén	42112010	-37.344173692	-67.619557426	La Pampa
2170	Casa de Piedra	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Puelén	42112005	-38.154552595	-67.152497411	La Pampa
2171	25 de Mayo	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Puelén	42112020	-37.774908489	-67.713540376	La Pampa
2172	Chacharramendi	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Utracán	42154020	-37.332042541	-65.651623658	La Pampa
2173	Agua Escondida	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Malargüe	50077010	-36.154925366	-68.300848818	Mendoza
2174	Mari Menuco	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Confluencia	58035060	-38.54135831	-68.545169718	Neuquén
2175	Vista Alegre Norte	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Confluencia	58035130	-38.734183066	-68.17282303	Neuquén
2176	Rincón de los Sauces	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Pehuenches	58091040	-37.390179487	-68.92518756	Neuquén
2177	Octavio Pico	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Pehuenches	58091030	-37.5896262	-68.258276273	Neuquén
2178	Barrio Pinar	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	General Roca	62042297	-37.679533856	-67.873696853	Río Negro
2179	Catriel	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	General Roca	62042360	-37.875520978	-67.794510606	Río Negro
2180	Península Ruca Co	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	General Roca	62042500	-38.701701572	-68.028233032	Río Negro
2181	Barda del Medio	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	General Roca	62042030	-38.725635425	-68.155895022	Río Negro
2182	General Mosconi	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	General José de San Martín	66056110	-22.596168608	-63.810999383	Salta
2183	Padre Lozano	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	General José de San Martín	66056180	-23.218439113	-63.844126509	Salta
2184	Tobantirenda	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	General José de San Martín	66056230	-22.148080278	-63.712941162	Salta
2185	Coronel Cornejo	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	General José de San Martín	66056070	-22.736903693	-63.818896507	Salta
2186	Campichuelo	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	General José de San Martín	66056030	-23.110854321	-63.999651054	Salta
2187	Tartagal	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	General José de San Martín	66056220	-22.516818326	-63.805604918	Salta
2188	Carboncito	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	General José de San Martín	66056060	-23.236096225	-63.769112913	Salta
2189	Aguaray	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	General José de San Martín	66056010	-22.244872658	-63.735334409	Salta
2190	Campo Durán	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	General José de San Martín	66056040	-22.200731988	-63.675741385	Salta
2191	Capiazuti	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	General José de San Martín	66056050	-22.203429087	-63.719653719	Salta
2192	Dragones	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	General José de San Martín	66056080	-23.248755204	-63.341024859	Salta
2193	General Ballivián	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	General José de San Martín	66056100	-22.93589062	-63.861256936	Salta
2194	Hickman	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	General José de San Martín	66056120	-23.212451801	-63.566606625	Salta
2195	Misión Kilómetro 6	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	General José de San Martín	66056150	-22.513460593	-63.753249437	Salta
2196	Pacará	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	General José de San Martín	66056170	-22.450078226	-63.442005416	Salta
2197	Piquirenda	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	General José de San Martín	66056190	-22.325044353	-63.753306334	Salta
2198	Tranquitas	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	General José de San Martín	66056240	-22.406223277	-63.775362194	Salta
2199	Embarcación	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	General José de San Martín	66056090	-23.2104201	-64.097246324	Salta
2200	Misión Chaqueña	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	General José de San Martín	66056130	-23.262247452	-63.739286562	Salta
2201	Profesor Salvador Mazza	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	General José de San Martín	66056200	-22.051657003	-63.691892774	Salta
2202	Yacuy	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	General José de San Martín	66056250	-22.369317329	-63.768479018	Salta
2203	Aguas Blancas	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Orán	66126010	-22.737117794	-64.353250927	Salta
2204	El Tabacal	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Orán	66126030	-23.253484703	-64.24575991	Salta
2205	Colonia Santa Rosa	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Orán	66126020	-23.394295345	-64.425578583	Salta
2206	Hipólito Yrigoyen	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Orán	66126040	-23.244343148	-64.276552631	Salta
2207	San Ramón de la Nueva Orán	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Orán	66126070	-23.136088719	-64.322927012	Salta
2208	Pichanal	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Orán	66126060	-23.324591293	-64.225303427	Salta
2209	El Salado	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Tinogasta	10105100	-28.304519241	-67.247376566	Catamarca
2210	Estación Mazán	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Arauco	46007040	-28.677702419	-66.490926059	La Rioja
2211	Aimogasta	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Arauco	46007010	-28.553760255	-66.813432971	La Rioja
2212	Bañado de los Pantanos	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Arauco	46007030	-28.378555807	-66.830578062	La Rioja
2213	Termas de Santa Teresita	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Arauco	46007045	-28.590538439	-66.555390495	La Rioja
2214	Villa Mazán	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Arauco	46007050	-28.664103637	-66.544474061	La Rioja
2215	La Rioja	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Capital	46014010	-29.412884219	-66.855827978	La Rioja
2216	Aminga	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Castro Barros	46021010	-28.847765303	-66.930496598	La Rioja
2217	Anillaco	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Castro Barros	46021020	-28.806531699	-66.941382012	La Rioja
2218	Anjullón	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Castro Barros	46021030	-28.723847225	-66.923384056	La Rioja
2219	Chuquis	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Castro Barros	46021040	-28.890955989	-66.971627958	La Rioja
2220	Los Molinos	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Castro Barros	46021050	-28.746226075	-66.932643305	La Rioja
2221	Pinchas	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Castro Barros	46021060	-28.934786715	-66.961168106	La Rioja
2222	San Pedro	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Castro Barros	46021070	-28.661723326	-66.923015472	La Rioja
2223	Santa Vera Cruz	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Castro Barros	46021080	-28.675748753	-66.96055836	La Rioja
2224	Pagancillo	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	General Felipe Varela	46028040	-29.541568588	-68.099937334	La Rioja
2225	Aicuñá	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	General Felipe Varela	46028010	-29.472786903	-67.774606099	La Rioja
2226	Los Palacios	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	General Felipe Varela	46028030	-29.369304386	-68.235541798	La Rioja
2227	Villa Unión	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	General Felipe Varela	46028050	-29.317755337	-68.227748381	La Rioja
2228	Chamical	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Chamical	46035010	-30.359439884	-66.312658278	La Rioja
2229	Polco	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Chamical	46035020	-30.405421549	-66.367993694	La Rioja
2230	Colonia Vichigasta	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Chilecito	46042050	-29.449555581	-67.487670434	La Rioja
2231	Nonogasta	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Chilecito	46042090	-29.302209442	-67.506190766	La Rioja
2232	Chilecito	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Chilecito	46042010	-29.165105059	-67.495215273	La Rioja
2233	Colonia Anguinán	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Chilecito	46042020	-29.250576739	-67.44382953	La Rioja
2234	Colonia Malligasta	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Chilecito	46042040	-29.198064066	-67.398172502	La Rioja
2235	Guanchín	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Chilecito	46042060	-29.190241169	-67.637758228	La Rioja
2236	Malligasta	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Chilecito	46042070	-29.176454437	-67.434890405	La Rioja
2237	Miranda	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Chilecito	46042080	-29.339190428	-67.662478232	La Rioja
2238	San Nicolás	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Chilecito	46042100	-29.115036827	-67.473599052	La Rioja
2239	Santa Florentina	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Chilecito	46042110	-29.129321672	-67.556136598	La Rioja
2240	Sañogasta	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Chilecito	46042120	-29.322209459	-67.602829071	La Rioja
2241	Tilimuqui	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Chilecito	46042130	-29.143368902	-67.425388112	La Rioja
2242	Vichigasta	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Chilecito	46042140	-29.485263251	-67.506777362	La Rioja
2243	Angulos	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Famatina	46049020	-28.655655475	-67.652249652	La Rioja
2244	Chañarmuyo	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Famatina	46049060	-28.603193693	-67.58317954	La Rioja
2245	Alto Carrizal	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Famatina	46049010	-28.866735554	-67.571419803	La Rioja
2246	Antinaco	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Famatina	46049030	-28.819342176	-67.314855039	La Rioja
2247	Bajo Carrizal	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Famatina	46049040	-28.888064096	-67.564132997	La Rioja
2248	Campanas	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Famatina	46049050	-28.552580093	-67.627881982	La Rioja
2249	Famatina	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Famatina	46049070	-28.925049358	-67.519593171	La Rioja
2250	La Cuadra	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Famatina	46049080	-28.468245449	-67.692308183	La Rioja
2251	Pituil	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Famatina	46049090	-28.575978248	-67.449093705	La Rioja
2252	Plaza Vieja	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Famatina	46049100	-28.965459531	-67.516236552	La Rioja
2253	Santa Cruz	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Famatina	46049110	-28.483879008	-67.693729048	La Rioja
2254	Santo Domingo	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Famatina	46049120	-28.554375761	-67.671993414	La Rioja
2255	Punta de los Llanos	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Ángel Vicente Peñaloza	46056010	-30.154411478	-66.546737943	La Rioja
2256	Tama	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Ángel Vicente Peñaloza	46056020	-30.506616608	-66.528931275	La Rioja
2257	Villa Castelli	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	General Lamadrid	46077010	-29.020142239	-68.229483123	La Rioja
2258	Jagüé	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Vinchina	46098010	-28.663721178	-68.385740542	La Rioja
2259	Villa San José de Vinchina	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Vinchina	46098020	-28.753697102	-68.20484481	La Rioja
2260	Amaná	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Independencia	46105010	-30.054637492	-67.504436295	La Rioja
2261	Patquía	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Independencia	46105020	-30.048146523	-66.879716562	La Rioja
2262	Salicas - San Blas	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	San Blas de Los Sauces	46119010	-28.373841148	-67.070608418	La Rioja
2263	Villa Sanagasta	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Sanagasta	46126010	-29.282281469	-67.020947168	La Rioja
2264	Usno	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Valle Fértil	70119050	-30.567073513	-67.542055732	San Juan
2265	Los Baldecitos	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Valle Fértil	70119040	-30.221542969	-67.695393362	San Juan
2266	Balde del Rosario	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Valle Fértil	70119020	-30.320938368	-67.696835232	San Juan
2267	Perugorría	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Curuzú Cuatiá	18035030	-29.340847876	-58.608203653	Corrientes
2268	Carolina	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Goya	18070010	-29.150277134	-59.181793381	Corrientes
2269	Goya	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Goya	18070020	-29.140076381	-59.259891257	Corrientes
2270	Cruz de los Milagros	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Lavalle	18091010	-28.836123823	-59.00600514	Corrientes
2271	Gobernador Juan E. Martínez	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Lavalle	18091020	-28.912338712	-58.936103106	Corrientes
2272	Lavalle	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Lavalle	18091030	-29.023331219	-59.179154266	Corrientes
2273	Santa Lucía	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Lavalle	18091040	-28.989852248	-59.100762554	Corrientes
2274	Villa Córdoba	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Lavalle	18091050	-28.991656545	-59.075188997	Corrientes
2275	Yatayti Calle	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Lavalle	18091060	-29.028312566	-58.912232686	Corrientes
2276	Felipe Yofré	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Mercedes	18105010	-29.106830626	-58.339630558	Corrientes
2277	Mercedes	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Mercedes	18105030	-29.184692808	-58.073531767	Corrientes
2278	Guaviraví	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	San Martín	18147020	-29.367257277	-56.829729487	Corrientes
2279	La Cruz	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	San Martín	18147030	-29.178629127	-56.63829499	Corrientes
2280	Yapeyú	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	San Martín	18147040	-29.470897872	-56.815066049	Corrientes
2281	Chavarría	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	San Roque	18161010	-28.955255712	-58.571767462	Corrientes
2282	9 de Julio	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	San Roque	18161030	-28.84077716	-58.830085717	Corrientes
2283	Pedro R. Fernández	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	San Roque	18161040	-28.746340249	-58.65413822	Corrientes
2284	La Rinconada	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Río Seco	14112050	-30.18400405	-62.945668985	Córdoba
2285	Malbrán	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Aguirre	86007030	-29.349178439	-62.441769553	Santiago del Estero
2286	Casares	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Aguirre	86007020	-28.948138845	-62.800102806	Santiago del Estero
2287	Villa General Mitre	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Aguirre	86007040	-29.141753807	-62.654548467	Santiago del Estero
2288	Lugones	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Avellaneda	86028040	-28.336351612	-63.339329711	Santiago del Estero
2289	Herrera	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Avellaneda	86028020	-28.482914382	-63.066237819	Santiago del Estero
2290	Villa Mailín	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Avellaneda	86028060	-28.482600684	-63.276050818	Santiago del Estero
2291	Real Sayana	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Avellaneda	86028050	-28.814689875	-62.843062739	Santiago del Estero
2292	Colonia Dora	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Avellaneda	86028010	-28.604023223	-62.95041814	Santiago del Estero
2293	Icaño	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Avellaneda	86028030	-28.681477284	-62.881180111	Santiago del Estero
2294	Averías	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	General Taboada	86077020	-28.747614711	-62.450701386	Santiago del Estero
2295	Estación Tacañitas	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	General Taboada	86077030	-28.62653829	-62.60691807	Santiago del Estero
2296	Añatuya	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	General Taboada	86077010	-28.460203351	-62.833542468	Santiago del Estero
2297	Villa Unión	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Mitre	86112010	-29.413622968	-62.790403928	Santiago del Estero
2298	Copo Quile	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Rosario de la Frontera	66140020	-26.011264859	-64.671151252	Salta
2299	El Potrero	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Rosario de la Frontera	66140040	-26.047172816	-64.64478319	Salta
2300	Antillá	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Rosario de la Frontera	66140010	-26.119576607	-64.593399169	Salta
2301	San Felipe	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Rosario de la Frontera	66140060	-25.717521847	-64.836827528	Salta
2302	Santos Lugares	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Alberdi	86014050	-26.690598138	-63.55921045	Santiago del Estero
2303	San José del Boquerón	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Copo	86056080	-26.119210389	-63.704038251	Santiago del Estero
2304	El Bobadal	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Jiménez	86091010	-26.724041906	-64.396364883	Santiago del Estero
2305	El Arenal	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Jiménez	86091005	-26.770692324	-64.602874475	Santiago del Estero
2306	El Rincón	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Jiménez	86091030	-26.723644116	-64.445591832	Santiago del Estero
2307	San Pedro	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Jiménez	86091080	-26.743619738	-64.391226927	Santiago del Estero
2308	Rapelli	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Pellegrini	86133050	-26.393318495	-64.505051276	Santiago del Estero
2309	Nueva Esperanza	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Pellegrini	86133030	-26.200185358	-64.240017551	Santiago del Estero
2310	Pozo Betbeder	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Pellegrini	86133040	-26.40980926	-64.337061103	Santiago del Estero
2311	Las Delicias	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Pellegrini	86133020	-26.676914487	-64.005896675	Santiago del Estero
2312	Santo Domingo	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Pellegrini	86133060	-26.216364113	-63.777496279	Santiago del Estero
2313	El Mojón	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Pellegrini	86133010	-26.09273929	-64.309154398	Santiago del Estero
2314	Villa Burruyacú	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Burruyacú	90007100	-26.500473448	-64.743672253	Tucumán
2315	7 de Abril	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Burruyacú	90007080	-26.288189418	-64.501376264	Tucumán
2316	Piedrabuena	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Burruyacú	90007070	-26.738347334	-64.648161101	Tucumán
2317	Garmendia	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Burruyacú	90007040	-26.568539613	-64.557527327	Tucumán
2318	Villa Benjamín Aráoz	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Burruyacú	90007090	-26.556059988	-64.797717572	Tucumán
2319	Doblas	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Atreucó	42007010	-37.15047026	-64.011525376	La Pampa
2320	Miguel Riglos	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Atreucó	42007030	-36.856394935	-63.687825606	La Pampa
2321	La Adela	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Caleu Caleu	42014020	-38.985330267	-64.090534318	La Pampa
2322	Anguil	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Capital	42021010	-36.52683804	-64.011702843	La Pampa
2323	Santa Rosa	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Capital	42021020	-36.620401195	-64.290630036	La Pampa
2324	Eduardo Castex	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Conhelo	42035020	-35.916063084	-64.295575748	La Pampa
2325	Winifreda	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Conhelo	42035060	-36.227465675	-64.233507343	La Pampa
2326	Conhelo	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Conhelo	42035010	-36.000531872	-64.5985082	La Pampa
2327	Mauricio Mayer	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Conhelo	42035030	-36.211535014	-64.033135808	La Pampa
2328	Monte Nievas	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Conhelo	42035040	-35.861584512	-64.153174325	La Pampa
2329	Rucanelo	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Conhelo	42035050	-36.041797074	-64.835721092	La Pampa
2330	Perú	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Guatraché	42070040	-37.661208179	-64.139246013	La Pampa
2331	Alpachiri	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Guatraché	42070010	-37.376833032	-63.773233062	La Pampa
2332	Abramo	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Hucal	42077010	-37.896563792	-63.850434502	La Pampa
2333	General San Martín	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Hucal	42077030	-37.978881474	-63.603493006	La Pampa
2334	Hucal	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Hucal	42077040	-37.791142028	-64.025253659	La Pampa
2335	Cuchillo Co	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Lihuel Calel	42084010	-38.333678475	-64.642252696	La Pampa
2336	Telén	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Loventué	42098040	-36.264278421	-65.511173929	La Pampa
2337	Carro Quemado	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Loventué	42098010	-36.474925731	-65.344656492	La Pampa
2338	Loventué	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Loventué	42098020	-36.188895393	-65.289332461	La Pampa
2339	Luan Toro	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Loventué	42098030	-36.203952675	-65.099651136	La Pampa
2340	Colonia San José	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Quemú Quemú	42119020	-36.117051446	-63.904070861	La Pampa
2341	Villa Mirasol	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Quemú Quemú	42119060	-36.076368862	-63.886324148	La Pampa
2342	Ingeniero Foster	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Rancul	42126020	-35.703461222	-65.102967862	La Pampa
2343	La Maruja	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Rancul	42126030	-35.67387896	-64.942139647	La Pampa
2344	Pichi Huinca	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Rancul	42126050	-35.648606694	-64.769781949	La Pampa
2345	Cachirulo	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Toay	42140005	-36.747396152	-64.367390702	La Pampa
2346	Quehué	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Utracán	42154050	-37.12182235	-64.51517673	La Pampa
2347	Ataliva Roca	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Utracán	42154010	-37.031809218	-64.285339598	La Pampa
2348	Colonia Santa María	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Utracán	42154030	-37.494790658	-64.224116759	La Pampa
2349	General Acha	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Utracán	42154040	-37.378212777	-64.604218734	La Pampa
2350	Unanué	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Utracán	42154060	-37.544152276	-64.351256122	La Pampa
2351	Río Colorado	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Pichi Mahuida	62063020	-38.9908343	-64.095825075	Río Negro
2352	Pichi Mahuida	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Pichi Mahuida	62063017	-38.831969747	-64.9340278	Río Negro
2353	Salto Andersen	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Pichi Mahuida	62063060	-38.823999055	-64.820730936	Río Negro
2354	Anchorena	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Gobernador Dupuy	74042010	-35.675709553	-65.424639083	San Luis
2355	Arizona	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Gobernador Dupuy	74042020	-35.725078491	-65.320487582	San Luis
2356	Colonia Victoria	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Eldorado	54042010	-26.333687024	-54.624609626	Misiones
2357	María Magdalena	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Eldorado	54042030	-26.237282954	-54.602896419	Misiones
2358	Nueva Delicia	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Eldorado	54042035	-26.181728708	-54.591216449	Misiones
2359	9 de Julio Kilómetro 28	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Eldorado	54042040	-26.430280529	-54.466472426	Misiones
2360	9 de Julio Kilómetro 20	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Eldorado	54042050	-26.414716415	-54.495858794	Misiones
2361	Pueblo Nuevo	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Eldorado	54042055	-26.243414744	-54.591222969	Misiones
2362	Puerto Mado	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Eldorado	54042060	-26.229744172	-54.623547911	Misiones
2363	Puerto Pinares	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Eldorado	54042070	-26.427338969	-54.682964258	Misiones
2364	Valle Hermoso	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Eldorado	54042090	-26.384422433	-54.463462173	Misiones
2365	Villa Roulet	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Eldorado	54042100	-26.442368819	-54.640468772	Misiones
2366	Santiago de Liniers	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Eldorado	54042080	-26.40118992	-54.415647354	Misiones
2367	Eldorado	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Eldorado	54042020	-26.408876964	-54.60705304	Misiones
2368	Comandante Andresito	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	General Manuel Belgrano	54049010	-25.667164844	-54.049861747	Misiones
2369	Caburei	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	General Manuel Belgrano	54049025	-25.68213426	-54.141360061	Misiones
2370	Dos Hermanas	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	General Manuel Belgrano	54049030	-26.293079427	-53.756929936	Misiones
2371	Integración	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	General Manuel Belgrano	54049040	-25.770961345	-53.855180906	Misiones
2372	Puerto Andresito	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	General Manuel Belgrano	54049045	-25.596214401	-54.002414243	Misiones
2373	Puerto Deseado	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	General Manuel Belgrano	54049047	-25.785836198	-54.038953983	Misiones
2374	San Antonio	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	General Manuel Belgrano	54049050	-26.057370901	-53.734119528	Misiones
2375	Piñalito Norte	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	General Manuel Belgrano	54049043	-25.933114576	-53.932962201	Misiones
2376	Bernardo de Irigoyen	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	General Manuel Belgrano	54049020	-26.255330197	-53.646734574	Misiones
2377	Puerto Libertad	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Iguazú	54063020	-25.921468152	-54.584317606	Misiones
2378	Puerto Iguazú	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Iguazú	54063030	-25.597210098	-54.577223001	Misiones
2379	Villa Cooperativa	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Iguazú	54063035	-25.944195774	-54.544941067	Misiones
2380	Puerto Esperanza	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Iguazú	54063010	-26.020612398	-54.615201171	Misiones
2381	Colonia Wanda	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Iguazú	54063040	-25.973366376	-54.563039701	Misiones
2382	Barrio Cuatro Bocas	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Montecarlo	54084003	-26.550296954	-54.68054517	Misiones
2383	Barrio Guatambu	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Montecarlo	54084005	-26.60552401	-54.69870744	Misiones
2384	Bario Ita	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Montecarlo	54084007	-26.5295241	-54.706804918	Misiones
2385	Laharrague	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Montecarlo	54084020	-26.53539118	-54.649738878	Misiones
2386	Montecarlo	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Montecarlo	54084030	-26.56665372	-54.766126798	Misiones
2387	Piray Kilómetro 18	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Montecarlo	54084040	-26.516051107	-54.591418606	Misiones
2388	Villa Parodi	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Montecarlo	54084070	-26.498904587	-54.678301269	Misiones
2389	Puerto Piray	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Montecarlo	54084050	-26.467338607	-54.718026749	Misiones
2390	Piñalito Sur	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	San Pedro	54112030	-26.426102248	-53.84143004	Misiones
2391	San Pedro	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	San Pedro	54112040	-26.625531405	-54.116301908	Misiones
2392	Tobuna	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	San Pedro	54112050	-26.469972895	-53.89112617	Misiones
2393	Cruce Caballero	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	San Pedro	54112010	-26.54209914	-53.941879089	Misiones
2394	Guandacol	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	General Felipe Varela	46028020	-29.525240142	-68.562746154	La Rioja
2395	Angualasto	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Iglesia	70049010	-30.057247494	-69.174124635	San Juan
2396	Pismanta	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Iglesia	70049050	-30.280225404	-69.22794667	San Juan
2397	Rodeo	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Iglesia	70049060	-30.21015899	-69.131594182	San Juan
2398	Tudcum	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Iglesia	70049070	-30.188156041	-69.270738713	San Juan
2399	Iglesia	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Iglesia	70049030	-30.411056912	-69.223702082	San Juan
2400	Las Flores	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Iglesia	70049040	-30.322485159	-69.204300813	San Juan
2401	Pampa Vieja	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Jáchal	70056060	-30.218139634	-68.688163453	San Juan
2402	Niquivil	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Jáchal	70056050	-30.408903787	-68.691347018	San Juan
2403	Villa Malvinas Argentinas	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Jáchal	70056100	-30.222074254	-68.733909208	San Juan
2404	San José de Jáchal	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Jáchal	70056080	-30.241746076	-68.746456479	San Juan
2405	Gran China	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Jáchal	70056020	-30.12035846	-68.728187717	San Juan
2406	El Médano	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Jáchal	70056010	-30.127014454	-68.681440327	San Juan
2407	San Isidro	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Jáchal	70056070	-30.141216027	-68.705885621	San Juan
2408	Tamberías	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Jáchal	70056090	-30.183024024	-68.726012501	San Juan
2409	Villa Mercedes	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Jáchal	70056110	-30.108374383	-68.703200258	San Juan
2410	Huaco	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Jáchal	70056030	-30.157754601	-68.482427596	San Juan
2411	Amanao	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Andalgalá	10021010	-27.53497313	-66.505336894	Catamarca
2412	Barranca Larga	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Belén	10035010	-26.982863601	-66.73906362	Catamarca
2413	Belén	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Belén	10035020	-27.649529254	-67.026316606	Catamarca
2414	Cóndor Huasi	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Belén	10035030	-27.493250806	-67.102088563	Catamarca
2415	Corral Quemado	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Belén	10035040	-27.144801068	-66.944758604	Catamarca
2416	El Durazno	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Belén	10035050	-27.247233272	-67.032218894	Catamarca
2417	Farallón Negro	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Belén	10035060	-27.304162374	-66.682243063	Catamarca
2418	Hualfín	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Belén	10035070	-27.224766793	-66.833999277	Catamarca
2419	Jacipunco	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Belén	10035080	-27.242435068	-67.00835087	Catamarca
2420	La Puntilla	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Belén	10035090	-27.685016844	-66.993662112	Catamarca
2421	Las Juntas	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Belén	10035100	-27.535958633	-67.117313312	Catamarca
2422	Londres	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Belén	10035110	-27.712565859	-67.135512149	Catamarca
2423	Los Nacimientos	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Belén	10035120	-27.164345821	-66.735515411	Catamarca
2424	Puerta de Corral Quemado	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Belén	10035130	-27.227608827	-66.932820508	Catamarca
2425	Puerta de San José	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Belén	10035140	-27.548030426	-67.005240538	Catamarca
2426	Villa Vil	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Belén	10035150	-27.093516712	-66.822059796	Catamarca
2427	Anillaco	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Tinogasta	10105010	-27.908814253	-67.621922618	Catamarca
2428	Copacabana	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Tinogasta	10105050	-28.176530983	-67.488018705	Catamarca
2429	El Puesto	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Tinogasta	10105090	-27.955033347	-67.63367979	Catamarca
2430	Fiambalá	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Tinogasta	10105110	-27.692193352	-67.618906389	Catamarca
2431	Medanitos	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Tinogasta	10105130	-27.524240463	-67.591287799	Catamarca
2432	Palo Blanco	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Tinogasta	10105140	-27.334929203	-67.754981184	Catamarca
2433	Saujil	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Tinogasta	10105160	-27.570873215	-67.62199421	Catamarca
2434	Tinogasta	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Tinogasta	10105180	-28.065561631	-67.564368979	Catamarca
2435	El Jardín	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	La Candelaria	66084010	-26.079568398	-65.393091519	Salta
2436	El Tala	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	La Candelaria	66084020	-26.112211595	-65.277838621	Salta
2437	La Candelaria	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	La Candelaria	66084030	-26.127343301	-65.051322103	Salta
2438	Rosario de la Frontera	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Rosario de la Frontera	66140050	-25.798563422	-64.973858091	Salta
2439	El Naranjo	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Rosario de la Frontera	66140030	-25.722202714	-65.013832095	Salta
2440	Macomitas	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Burruyacú	90007060	-26.730461086	-65.010723352	Tucumán
2441	El Naranjo	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Burruyacú	90007030	-26.661741843	-65.048804621	Tucumán
2442	El Chañar	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Burruyacú	90007020	-26.757358499	-65.067964533	Tucumán
2443	Villa Padre Monti	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Burruyacú	90007110	-26.510534931	-64.994619008	Tucumán
2444	Barrio Mutual San Martín	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Tafí Viejo	90105030	-26.718014789	-65.225378256	Tucumán
2445	El Cadillal	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Tafí Viejo	90105070	-26.631866154	-65.207106215	Tucumán
2446	Tafí Viejo	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Tafí Viejo	90105080	-26.729982822	-65.262843936	Tucumán
2447	Villa de Trancas	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Trancas	90112030	-26.230908163	-65.283446639	Tucumán
2448	San Pedro de Colalao	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Trancas	90112020	-26.234960848	-65.494765768	Tucumán
2449	Choromoro	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Trancas	90112010	-26.4112743	-65.319956994	Tucumán
2450	Villa Carmela	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Yerba Buena	90119020	-26.767972753	-65.272409063	Tucumán
2451	Colonia San Miguel Arcángel	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Adolfo Alsina	06007020	-37.44901788	-63.11715636	Buenos Aires
2452	Delfín Huergo	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Adolfo Alsina	06007030	-37.32110752	-63.234384727	Buenos Aires
2453	Esteban Agustín Gascón	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Adolfo Alsina	06007050	-37.455836511	-63.25431155	Buenos Aires
2454	La Pala	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Adolfo Alsina	06007060	-36.663920357	-63.366465604	Buenos Aires
2455	Maza	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Adolfo Alsina	06007070	-36.800316053	-63.339281172	Buenos Aires
2456	Rivera	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Adolfo Alsina	06007080	-37.160596744	-63.241789724	Buenos Aires
2457	Yutuyaco	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Adolfo Alsina	06007110	-36.987320407	-63.132027906	Buenos Aires
2458	Juan F. Ibarra	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Bolívar	06105020	-36.34714827	-61.254035044	Buenos Aires
2459	Paula	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Bolívar	06105040	-36.503570818	-61.024831384	Buenos Aires
2460	Pirovano	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Bolívar	06105050	-36.510157487	-61.555518995	Buenos Aires
2461	El Pensamiento	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Coronel Pringles	06196030	-38.216477789	-61.314888842	Buenos Aires
2462	Indio Rico	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Coronel Pringles	06196040	-38.330445704	-60.885241835	Buenos Aires
2463	Coronel Suárez	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Coronel Suárez	06203020	-37.458528918	-61.932893831	Buenos Aires
2464	Huanguelén	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Coronel Suárez	06203050	-37.058875263	-61.932541117	Buenos Aires
2465	Villa La Arcadia	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Coronel Suárez	06203100	-38.137030131	-61.78736281	Buenos Aires
2466	Daireaux	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Daireaux	06231030	-36.599632936	-61.747542406	Buenos Aires
2467	La Colina	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	General La Madrid	06322020	-37.359386906	-61.535744907	Buenos Aires
2468	Las Martinetas	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	General La Madrid	06322030	-37.199198589	-61.122549744	Buenos Aires
2469	Líbano	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	General La Madrid	06322040	-37.532154726	-61.285266621	Buenos Aires
2470	Arroyo Venado	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Guaminí	06399010	-37.082157219	-62.540308804	Buenos Aires
2471	Guaminí	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Guaminí	06399040	-37.010920943	-62.422249738	Buenos Aires
2472	Laprida	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Laprida	06448010	-37.544226005	-60.801027326	Buenos Aires
2473	Pueblo Nuevo	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Laprida	06448020	-37.523701213	-60.774082604	Buenos Aires
2474	Pueblo San Jorge	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Laprida	06448030	-37.228861355	-60.961042342	Buenos Aires
2475	Blancagrande	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Olavarría	06595010	-36.534532454	-60.885392737	Buenos Aires
2476	Espigas	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Olavarría	06595050	-36.412958282	-60.673148957	Buenos Aires
2477	Magdala	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Pehuajó	06609050	-36.084476688	-61.722329392	Buenos Aires
2478	Mones Cazón	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Pehuajó	06609060	-36.227749125	-62.006738621	Buenos Aires
2479	Bocayuva	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Pellegrini	06616010	-36.206099536	-63.077533215	Buenos Aires
2480	De Bary	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Pellegrini	06616020	-36.340501894	-63.259674075	Buenos Aires
2481	Pellegrini	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Pellegrini	06616030	-36.267914188	-63.1647219	Buenos Aires
2482	Azopardo	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Puán	06651010	-37.704214793	-62.901286008	Buenos Aires
2483	Bordenave	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Puán	06651020	-37.805514709	-63.043373578	Buenos Aires
2484	Darregueira	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Puán	06651030	-37.689452998	-63.16102681	Buenos Aires
2485	Estela	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Puán	06651050	-38.109915223	-62.914783052	Buenos Aires
2486	Felipe Solá	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Puán	06651060	-38.009240659	-62.822420697	Buenos Aires
2487	López Lecube	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Puán	06651070	-38.119493981	-62.726206118	Buenos Aires
2488	Puán	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Puán	06651080	-37.548095016	-62.768336468	Buenos Aires
2489	San Germán	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Puán	06651090	-38.301759057	-62.981284931	Buenos Aires
2490	Villa Iris	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Puán	06651110	-38.171752954	-63.235342905	Buenos Aires
2491	Colonia San Martín	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Saavedra	06700020	-37.97686342	-62.332483625	Buenos Aires
2492	Dufaur	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Saavedra	06700030	-37.942811479	-62.283088645	Buenos Aires
2493	Espartillar	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Saavedra	06700040	-37.361125596	-62.433850469	Buenos Aires
2494	Saavedra	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Saavedra	06700070	-37.761376909	-62.348638891	Buenos Aires
2495	Quenumá	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Salliqueló	06721010	-36.569343012	-63.08811076	Buenos Aires
2496	Salliqueló	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Salliqueló	06721020	-36.751513384	-62.959131142	Buenos Aires
2497	Chasicó	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Tornquist	06819010	-38.337332028	-62.644585207	Buenos Aires
2498	Saldungaray	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Tornquist	06819020	-38.205223596	-61.76962818	Buenos Aires
2499	Tornquist	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Tornquist	06819040	-38.101281418	-62.222954326	Buenos Aires
2500	Villa Ventana	2026-11-08 23:05:59.723	2026-11-08 23:05:59.723	Tornquist	06819070	-38.081944343	-61.92980529	Buenos Aires
2501	Trongé	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Trenque Lauquen	06826060	-36.463173212	-62.484727264	Buenos Aires
2502	Tres Lomas	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Tres Lomas	06847020	-36.459189328	-62.862576171	Buenos Aires
2503	Rolón	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Atreucó	42007040	-37.166579495	-63.415025086	La Pampa
2504	Macachín	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Atreucó	42007020	-37.13697913	-63.666738846	La Pampa
2505	Tomás M. Anchorena	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Atreucó	42007050	-36.840340864	-63.524822016	La Pampa
2506	Uriburu	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Catriló	42028040	-36.506320244	-63.860108974	La Pampa
2507	Catriló	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Catriló	42028010	-36.406677774	-63.423337095	La Pampa
2508	La Gloria	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Catriló	42028020	-36.508384139	-63.74310853	La Pampa
2509	Lonquimay	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Catriló	42028030	-36.466407933	-63.623614547	La Pampa
2510	General Manuel J. Campos	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Guatraché	42070020	-37.461454343	-63.585757519	La Pampa
2511	Guatraché	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Guatraché	42070030	-37.67072693	-63.535760653	La Pampa
2512	Santa Teresa	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Guatraché	42070050	-37.574787179	-63.431318402	La Pampa
2513	Bernasconi	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Hucal	42077020	-37.90225262	-63.74295358	La Pampa
2514	Jacinto Aráuz	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Hucal	42077050	-38.082874555	-63.429437831	La Pampa
2515	Miguel Cané	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Quemú Quemú	42119030	-36.157183735	-63.512597853	La Pampa
2516	Colonia Barón	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Quemú Quemú	42119010	-36.15361003	-63.85520472	La Pampa
2517	Relmo	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Quemú Quemú	42119050	-36.256504512	-63.448089295	La Pampa
2518	Abdón Castro Tolay	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Cochinoca	38007010	-23.342641372	-66.089744998	Jujuy
2519	Agua de Castilla	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Cochinoca	38007035	-23.217512301	-65.806865462	Jujuy
2520	Casabindo	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Cochinoca	38007040	-22.986827916	-66.03292615	Jujuy
2521	Cochinoca	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Cochinoca	38007050	-22.745353774	-65.896077336	Jujuy
2522	Quebraleña	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Cochinoca	38007063	-23.286231168	-65.769884805	Jujuy
2523	Quera	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Cochinoca	38007067	-23.10082688	-65.763575957	Jujuy
2524	Rinconadillas	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Cochinoca	38007070	-23.385501256	-65.957052342	Jujuy
2525	San Francisco de Alfarcito	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Cochinoca	38007080	-23.319842977	-65.973953698	Jujuy
2526	Santa Ana de la Puna	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Cochinoca	38007085	-23.126210411	-66.053166655	Jujuy
2527	Santuario de Tres Pozos	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Cochinoca	38007090	-23.532666814	-65.962601299	Jujuy
2528	Tambillos	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Cochinoca	38007095	-22.897096889	-65.962885023	Jujuy
2529	Tusaquillas	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Cochinoca	38007100	-23.189291006	-65.987514044	Jujuy
2530	Lagunillas de Farallón	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Rinconada	38049010	-22.462145248	-66.627967586	Jujuy
2531	Casa Colorada	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Rinconada	38049003	-22.325940637	-66.283946151	Jujuy
2532	Coyaguaima	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Rinconada	38049007	-22.769417341	-66.440907644	Jujuy
2533	Liviara	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Rinconada	38049020	-22.52106523	-66.33768306	Jujuy
2534	Loma Blanca	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Rinconada	38049025	-22.472262739	-66.484107555	Jujuy
2535	Nuevo Pirquitas	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Rinconada	38049030	-22.687955422	-66.456375668	Jujuy
2536	Orosmayo	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Rinconada	38049035	-22.556887591	-66.356787167	Jujuy
2537	Rinconada	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Rinconada	38049040	-22.4407002	-66.16715051	Jujuy
2538	Cieneguillas	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Santa Catalina	38077030	-22.100628977	-65.86682231	Jujuy
2539	Misarrumi	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Santa Catalina	38077060	-22.259912244	-66.367987167	Jujuy
2540	Casira	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Santa Catalina	38077010	-21.977680938	-65.896059523	Jujuy
2541	Ciénega de Paicone	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Santa Catalina	38077020	-22.178561881	-66.412569134	Jujuy
2542	Cusi Cusi	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Santa Catalina	38077040	-22.340338272	-66.493487093	Jujuy
2543	El Angosto	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Santa Catalina	38077045	-21.876801534	-66.18856281	Jujuy
2544	La Ciénega	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Santa Catalina	38077050	-21.962300012	-66.262741633	Jujuy
2545	Oratorio	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Santa Catalina	38077070	-22.098918212	-66.132468655	Jujuy
2546	Paicone	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Santa Catalina	38077080	-22.219546777	-66.424977404	Jujuy
2547	San Juan de Oros	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Santa Catalina	38077090	-22.225686701	-66.248745385	Jujuy
2548	Santa Catalina	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Santa Catalina	38077100	-21.94710868	-66.051768431	Jujuy
2549	Yoscaba	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Santa Catalina	38077110	-22.166953963	-66.024578042	Jujuy
2550	Olaroz Chico	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Susques	38084060	-23.393670145	-66.803092208	Jujuy
2551	Susques	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Susques	38084100	-23.397540583	-66.367350613	Jujuy
2552	Huáncar	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Susques	38084040	-23.564098731	-66.409950175	Jujuy
2553	Catua	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Susques	38084010	-23.870126941	-67.004496869	Jujuy
2554	Coranzuli	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Susques	38084020	-23.013785241	-66.366647572	Jujuy
2555	El Toro	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Susques	38084030	-23.083419667	-66.702216926	Jujuy
2556	Jama	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Susques	38084045	-23.239863442	-67.018100442	Jujuy
2557	Mina Providencia	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Susques	38084050	-23.26292392	-66.798517789	Jujuy
2558	Olacapato	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Susques	38084055	-24.114148661	-66.719369464	Jujuy
2559	Pastos Chicos	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Susques	38084070	-23.765991183	-66.437379121	Jujuy
2560	Puesto Sey	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Susques	38084080	-23.945562486	-66.48826389	Jujuy
2561	San Juan de Quillaqués	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Susques	38084090	-23.230693154	-66.34277692	Jujuy
2562	El Moreno	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Tumbaya	38098020	-23.853706118	-65.831796631	Jujuy
2563	Cobres	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	La Poma	66091010	-23.650504079	-66.288571502	Salta
2564	Santa Rosa de los Pastos Grandes	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Los Andes	66105030	-24.467615273	-66.673566459	Salta
2565	Olacapato	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Los Andes	66105010	-24.137486432	-66.718826415	Salta
2566	San Antonio de los Cobres	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Los Andes	66105020	-24.216144277	-66.321064486	Salta
2567	Presidencia Roca	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Libertador General San Martín	22084070	-26.143715381	-59.59502918	Chaco
2568	Bartolomé de las Casas	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Patiño	34035010	-25.408047924	-59.570759592	Formosa
2569	Colonia Sarmiento	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Patiño	34035020	-24.643921202	-59.434058606	Formosa
2570	Comandante Fontana	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Patiño	34035030	-25.330640381	-59.680989769	Formosa
2571	El Recreo	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Patiño	34035040	-25.040780484	-59.294241636	Formosa
2572	Fortín Sargento 1º Leyes	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Patiño	34035070	-24.55411179	-59.385116205	Formosa
2573	Pirané	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Pirané	34056040	-25.732649819	-59.109808063	Formosa
2574	Villa General Güemes	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Patiño	34035160	-24.755783305	-59.48851006	Formosa
2575	Villa General Manuel Belgrano	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Patiño	34035170	-24.938533856	-59.026389294	Formosa
2576	Colonia Campo Villafañe	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Pirané	34056010	-26.204686883	-59.080025184	Formosa
2577	Palo Santo	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Pirané	34056030	-25.564593878	-59.337719095	Formosa
2578	Villa Kilómetro 213	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Pirané	34056050	-26.187165695	-59.367155479	Formosa
2579	Lucas González	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Nogoyá	30077060	-32.384393729	-59.530847043	Entre Ríos
2580	Altamirano Sur	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Tala	30091010	-32.087780098	-59.174731601	Entre Ríos
2581	Durazno	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Tala	30091020	-31.985880782	-59.279294025	Entre Ríos
2582	Gobernador Echagüe	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Tala	30091040	-32.393372197	-59.275889643	Entre Ríos
2583	Gobernador Solá	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Tala	30091060	-32.336522574	-59.372785344	Entre Ríos
2584	Guardamonte	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Tala	30091070	-32.081145325	-59.305953641	Entre Ríos
2585	Las Guachas	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Tala	30091080	-32.470218809	-59.172925916	Entre Ríos
2586	Maciá	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Tala	30091090	-32.174684219	-59.397970453	Entre Ríos
2587	Rosario del Tala	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Tala	30091100	-32.300675506	-59.139066804	Entre Ríos
2588	Basavilbaso	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Uruguay	30098010	-32.372159979	-58.878671817	Entre Ríos
2589	Las Moscas	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Uruguay	30098070	-32.092103266	-58.957514648	Entre Ríos
2590	Líbaros	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Uruguay	30098080	-32.26189544	-58.90695289	Entre Ríos
2591	Rocamora	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Uruguay	30098110	-32.344663629	-58.973009669	Entre Ríos
2592	Santa Anita	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Uruguay	30098120	-32.174416618	-58.785975864	Entre Ríos
2593	Villa Mantero	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Uruguay	30098130	-32.398361829	-58.746018695	Entre Ríos
2594	Villa San Marcial (Est. Gobernador Urquiza)	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Uruguay	30098150	-32.180068914	-58.928538084	Entre Ríos
2595	Estación Raíces	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Villaguay	30113010	-31.908551727	-59.261232719	Entre Ríos
2596	Ingeniero Miguel Sajaroff	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Villaguay	30113020	-31.956885993	-58.849488779	Entre Ríos
2597	Paso de la Laguna	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Villaguay	30113050	-31.803520452	-59.159807935	Entre Ríos
2598	Villa Clara	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Villaguay	30113060	-31.829799034	-58.821609898	Entre Ríos
2599	Villa Domínguez	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Villaguay	30113070	-31.986288895	-58.961532847	Entre Ríos
2600	Villaguay	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Villaguay	30113080	-31.867637571	-59.026885213	Entre Ríos
2601	La Para	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Río Primero	14105110	-30.894130531	-63.001396303	Córdoba
2602	Villa Fontana	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Río Primero	14105270	-30.893707695	-63.117152941	Córdoba
2603	Altos de Chipión	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Justo	14140020	-30.957180513	-62.338368627	Córdoba
2604	Arroyito	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Justo	14140030	-31.419229766	-63.050702589	Córdoba
2605	Balnearia	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Justo	14140040	-31.012851397	-62.665374089	Córdoba
2606	Brinkmann	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Justo	14140050	-30.866479579	-62.043106735	Córdoba
2607	Colonia Anita	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Justo	14140060	-31.119928186	-62.234322997	Córdoba
2608	Colonia Las Pichanas	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Justo	14140080	-31.245622019	-62.925319084	Córdoba
2609	Colonia Marina	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Justo	14140090	-31.248760006	-62.363905954	Córdoba
2610	Colonia Prosperidad	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Justo	14140100	-31.628704306	-62.365339862	Córdoba
2611	Colonia San Bartolomé	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Justo	14140110	-31.527908367	-62.723704084	Córdoba
2612	Colonia San Pedro	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Justo	14140120	-30.783090824	-61.917929238	Córdoba
2613	Colonia Santa María	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Justo	14140130	-31.607881203	-62.428503145	Córdoba
2614	Colonia Valtelina	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Justo	14140140	-31.053662728	-62.234464022	Córdoba
2615	Colonia Vignaud	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Justo	14140150	-30.841419162	-61.956613651	Córdoba
2616	Devoto	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Justo	14140160	-31.401782158	-62.306222698	Córdoba
2617	El Arañado	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Justo	14140170	-31.743034525	-62.889626755	Córdoba
2618	El Fuertecito	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Justo	14140190	-31.403706313	-62.973701244	Córdoba
2619	El Tío	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Justo	14140200	-31.385420521	-62.828197702	Córdoba
2620	Estación Luxardo	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Justo	14140210	-31.305184758	-62.133753979	Córdoba
2621	Colonia Iturraspe	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Justo	14140215	-31.207836269	-62.110310103	Córdoba
2622	Freyre	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Justo	14140220	-31.164572258	-62.096318845	Córdoba
2623	La Francia	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Justo	14140230	-31.40629587	-62.633217539	Córdoba
2624	La Paquita	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Justo	14140240	-30.909289745	-62.216112314	Córdoba
2625	La Tordilla	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Justo	14140250	-31.23653777	-63.061080501	Córdoba
2626	Marull	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Justo	14140280	-30.993864965	-62.825338477	Córdoba
2627	Miramar	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Justo	14140290	-30.91515318	-62.675009545	Córdoba
2628	Morteros	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Justo	14140300	-30.710667779	-62.007236458	Córdoba
2629	Plaza Luxardo	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Justo	14140310	-31.301747989	-62.229167344	Córdoba
2630	Plaza San Francisco	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Justo	14140320	-31.371136641	-62.09818964	Córdoba
2631	Porteña	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Justo	14140330	-31.014049314	-62.062044534	Córdoba
2632	Quebracho Herrado	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Justo	14140340	-31.549013741	-62.224956686	Córdoba
2633	Sacanta	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Justo	14140350	-31.663398253	-63.047961379	Córdoba
2634	San Francisco	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Justo	14140360	-31.424938943	-62.083876734	Córdoba
2635	Saturnino María Laspiur	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Justo	14140370	-31.703481693	-62.483462241	Córdoba
2636	Seeber	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Justo	14140380	-30.925725472	-61.974159336	Córdoba
2637	Toro Pujio	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Justo	14140390	-31.108904932	-62.987027697	Córdoba
2638	Villa Concepción del Tío	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Justo	14140420	-31.322100174	-62.813998095	Córdoba
2639	Villa San Esteban	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Justo	14140440	-31.633775408	-62.897066225	Córdoba
2640	Colonia Raquel	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Castellanos	82021120	-30.836834428	-61.488042998	Santa Fe
2641	Villa San José	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Castellanos	82021410	-31.336665808	-61.621579192	Santa Fe
2642	Zenón Pereyra	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Castellanos	82021430	-31.560095315	-61.896236275	Santa Fe
2643	Estación Saguier	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Castellanos	82021170	-31.31627317	-61.696209027	Santa Fe
2644	Eustolia	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Castellanos	82021190	-31.576622654	-61.783534187	Santa Fe
2645	Garibaldi	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Castellanos	82021210	-31.649452585	-61.805867845	Santa Fe
2646	Ataliva	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Castellanos	82021030	-30.996267611	-61.431909257	Santa Fe
2647	Bella Italia	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Castellanos	82021070	-31.283208041	-61.409257777	Santa Fe
2648	Vila	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Castellanos	82021390	-31.190530472	-61.832903433	Santa Fe
2649	Esmeralda	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Castellanos	82021150	-31.612968991	-61.932872239	Santa Fe
2650	Tacural	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Castellanos	82021380	-30.846265297	-61.59174895	Santa Fe
2651	Josefina	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Castellanos	82021230	-31.406301897	-61.991956193	Santa Fe
2652	María Juana	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Castellanos	82021250	-31.67560822	-61.751679502	Santa Fe
2653	Plaza Clucellas	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Castellanos	82021270	-31.452680946	-61.706783342	Santa Fe
2654	San Antonio	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Castellanos	82021330	-31.212319675	-61.724745119	Santa Fe
2655	Susana	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Castellanos	82021370	-31.35576005	-61.515779945	Santa Fe
2656	Villa Josefina	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Castellanos	82021400	-31.440752583	-62.02624284	Santa Fe
2657	Virginia	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Castellanos	82021420	-30.73950056	-61.340126292	Santa Fe
2658	Lehmann	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Castellanos	82021240	-31.125373024	-61.452378576	Santa Fe
2659	Rafaela	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Castellanos	82021310	-31.252667533	-61.49166156	Santa Fe
2660	Ramona	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Castellanos	82021320	-31.091856396	-61.902472287	Santa Fe
2661	San Vicente	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Castellanos	82021340	-31.699160362	-61.567374013	Santa Fe
2662	Pueblo Marini	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Castellanos	82021300	-31.038725665	-61.88938202	Santa Fe
2663	Nueva Lehmann	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Castellanos	82021260	-31.118904986	-61.515198965	Santa Fe
2664	Presidente Roca	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Castellanos	82021290	-31.212176108	-61.613522422	Santa Fe
2665	Humberto Primo	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Castellanos	82021220	-30.868332801	-61.347942837	Santa Fe
2666	Castellanos	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Castellanos	82021080	-31.20885937	-61.724231167	Santa Fe
2667	Eusebia y Carolina	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Castellanos	82021180	-30.947727782	-61.856075857	Santa Fe
2668	Frontera	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Castellanos	82021200	-31.426463302	-62.059209345	Santa Fe
2669	Egusquiza	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Castellanos	82021140	-31.095454412	-61.627924813	Santa Fe
2670	Colonia Bicha	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Castellanos	82021090	-30.854129552	-61.849535459	Santa Fe
2671	Estación Clucellas	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Castellanos	82021160	-31.524108222	-61.718355133	Santa Fe
2672	Colonia Cello	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Castellanos	82021100	-31.432128799	-61.841375042	Santa Fe
2673	Coronel Fraga	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Castellanos	82021130	-31.174469175	-61.917483026	Santa Fe
2674	Colonia Margarita	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Castellanos	82021110	-31.685992475	-61.647722614	Santa Fe
2675	Bauer y Sigel	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Castellanos	82021060	-31.271558704	-61.943017604	Santa Fe
2676	Aldao	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Castellanos	82021010	-30.980576882	-61.743253033	Santa Fe
2677	Angélica	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Castellanos	82021020	-31.550731817	-61.546338555	Santa Fe
2678	Barrios Acapulco y Veracruz	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Castellanos	82021050	-31.415400689	-62.058620606	Santa Fe
2679	Aurelia	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Castellanos	82021040	-31.419651196	-61.422461823	Santa Fe
2680	Plaza Saguier	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Castellanos	82021280	-31.324284368	-61.66805393	Santa Fe
2681	Sunchales	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Castellanos	82021360	-30.945077034	-61.560662139	Santa Fe
2682	Santa Clara de Saguier	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Castellanos	82021350	-31.335748809	-61.817838486	Santa Fe
2683	Sa Pereyra	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Las Colonias	82070210	-31.57045581	-61.376534144	Santa Fe
2684	Pilar	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Las Colonias	82070170	-31.44041069	-61.259598056	Santa Fe
2685	San Jerónimo del Sauce	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Las Colonias	82070260	-31.609029308	-61.141353895	Santa Fe
2686	Nuevo Torino	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Las Colonias	82070160	-31.345007458	-61.235134582	Santa Fe
2687	San Mariano	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Las Colonias	82070280	-31.668413073	-61.347442643	Santa Fe
2688	Santa Clara de Buena Vista	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Las Colonias	82070290	-31.762372441	-61.315799002	Santa Fe
2689	Felicia	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Las Colonias	82070060	-31.244546373	-61.212186497	Santa Fe
2690	Sarmiento	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Las Colonias	82070310	-31.058806815	-61.16719748	Santa Fe
2691	Moisés Ville	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Cristóbal	82091180	-30.715584856	-61.469507799	Santa Fe
2692	Palacios	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Cristóbal	82091210	-30.708584246	-61.622652425	Santa Fe
2693	Crispi	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Martín	82126060	-31.739847034	-62.037592663	Santa Fe
2694	Sastre	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Martín	82126160	-31.76757528	-61.828876261	Santa Fe
2695	Castelar	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Martín	82126040	-31.668567931	-62.090135566	Santa Fe
2696	Aldea Brasilera	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Diamante	30021010	-31.889833171	-60.590793265	Entre Ríos
2697	Aldea Grapschental	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Diamante	30021015	-31.960518768	-60.498983753	Entre Ríos
2698	Aldea Protestante	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Diamante	30021020	-32.029302789	-60.561808131	Entre Ríos
2699	Aldea Salto	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Diamante	30021030	-31.924833218	-60.547351891	Entre Ríos
2700	Aldea San Francisco	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Diamante	30021040	-31.961226667	-60.635259938	Entre Ríos
2701	Aldea Spatzenkutter	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Diamante	30021050	-31.946179035	-60.580862734	Entre Ríos
2702	Aldea Valle María	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Diamante	30021060	-31.990092366	-60.587726231	Entre Ríos
2703	Colonia Ensayo	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Diamante	30021070	-31.86518817	-60.574690249	Entre Ríos
2704	Diamante	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Diamante	30021080	-32.070757252	-60.638208336	Entre Ríos
2705	Estación Camps	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Diamante	30021090	-32.112516236	-60.227288922	Entre Ríos
2706	General Alvear	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Diamante	30021100	-31.945514885	-60.680121898	Entre Ríos
2707	General Racedo (El Carmen)	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Diamante	30021110	-31.979149051	-60.405666327	Entre Ríos
2708	General Ramírez	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Diamante	30021120	-32.177268137	-60.201646736	Entre Ríos
2709	La Juanita	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Diamante	30021123	-31.875048407	-60.648956079	Entre Ríos
2710	Las Jaulas	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Diamante	30021127	-31.827043378	-60.60531814	Entre Ríos
2711	Paraje La Virgen	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Diamante	30021130	-31.916638558	-60.653609235	Entre Ríos
2712	Puerto Las Cuevas	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Diamante	30021140	-32.32870769	-60.48650118	Entre Ríos
2713	Villa Libertador San Martín	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Diamante	30021150	-32.073442183	-60.465916522	Entre Ríos
2714	Aranguren	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Nogoyá	30077010	-32.245775516	-60.158350574	Entre Ríos
2715	Betbeder	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Nogoyá	30077020	-32.372179763	-59.928407834	Entre Ríos
2716	Don Cristóbal	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Nogoyá	30077030	-32.071354187	-59.994730981	Entre Ríos
2717	Febré	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Nogoyá	30077040	-32.475267675	-59.918901078	Entre Ríos
2718	Hernández	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Nogoyá	30077050	-32.338271417	-60.032126119	Entre Ríos
2719	Nogoyá	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Nogoyá	30077070	-32.398961525	-59.787695342	Entre Ríos
2720	XX de Setiembre	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Nogoyá	30077080	-32.385918828	-59.66222063	Entre Ríos
2721	Aldea María Luisa	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Paraná	30084010	-31.883851698	-60.410506328	Entre Ríos
2722	Aldea San Juan	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Paraná	30084015	-31.996719561	-60.358160358	Entre Ríos
2723	Aldea San Rafael	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Paraná	30084020	-31.957411232	-60.254630645	Entre Ríos
2724	Aldea Santa Rosa	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Paraná	30084040	-32.013160116	-60.239209953	Entre Ríos
2725	Colonia Avellaneda	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Paraná	30084060	-31.762649294	-60.411981206	Entre Ríos
2726	Colonia Crespo	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Paraná	30084065	-31.68288122	-60.231081888	Entre Ríos
2727	Crespo	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Paraná	30084070	-32.030759507	-60.306092049	Entre Ríos
2728	El Palenque	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Paraná	30084080	-31.653756741	-60.166616458	Entre Ríos
2729	El Ramblón	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Paraná	30084095	-31.846876483	-60.101252123	Entre Ríos
2730	La Picada	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Paraná	30084120	-31.725004529	-60.297549106	Entre Ríos
2731	Las Tunas	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Paraná	30084130	-31.868596561	-59.728864073	Entre Ríos
2732	María Grande	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Paraná	30084140	-31.662807499	-59.904014596	Entre Ríos
2733	Oro Verde	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Paraná	30084150	-31.8227547	-60.51753343	Entre Ríos
2734	Paraná	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Paraná	30084160	-31.740160162	-60.527426049	Entre Ríos
2735	San Benito	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Paraná	30084200	-31.783022339	-60.441459312	Entre Ríos
2736	Sauce Montrull	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Paraná	30084210	-31.744808813	-60.355757337	Entre Ríos
2737	Sauce Pinto	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Paraná	30084220	-31.843082336	-60.371600721	Entre Ríos
2738	Seguí	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Paraná	30084230	-31.954339772	-60.125650552	Entre Ríos
2739	Sosa	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Paraná	30084240	-31.736233298	-59.91113589	Entre Ríos
2740	Tabossi	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Paraná	30084250	-31.801659589	-59.93595294	Entre Ríos
2741	Tezanos Pinto	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Paraná	30084260	-31.871698599	-60.494414737	Entre Ríos
2742	Viale	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Paraná	30084270	-31.872109033	-60.012951248	Entre Ríos
2743	Villa Fontana	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Paraná	30084280	-31.905343317	-60.473694155	Entre Ríos
2744	Villa Gdor. Luis F. Etchevehere	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Paraná	30084290	-31.93506991	-60.427167661	Entre Ríos
2745	Villa Urquiza	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Paraná	30084300	-31.649521209	-60.376895909	Entre Ríos
2746	Antelo	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Victoria	30105010	-32.53354175	-60.035452775	Entre Ríos
2747	Molino Doll	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Victoria	30105040	-32.306824974	-60.423089443	Entre Ríos
2748	Victoria	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Victoria	30105060	-32.621605823	-60.157953952	Entre Ríos
2749	Serodino	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Iriondo	82056130	-32.603740815	-60.947400636	Santa Fe
2750	Villa La Rivera (Oliveros)	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Iriondo	82056160	-32.634973064	-60.820226567	Santa Fe
2751	Villa La Rivera (Pueblo Andino)	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Iriondo	82056170	-32.638865936	-60.822665216	Santa Fe
2752	Pueblo Andino	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Iriondo	82056110	-32.669942108	-60.875378374	Santa Fe
2753	Salto Grande	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Iriondo	82056120	-32.666058803	-61.088208098	Santa Fe
2754	Carrizales	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Iriondo	82056040	-32.508738933	-61.032203576	Santa Fe
2755	Oliveros	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Iriondo	82056100	-32.573933426	-60.854642319	Santa Fe
2756	Lucio V. López	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Iriondo	82056090	-32.715396241	-61.017458827	Santa Fe
2757	Santa Fe	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	La Capital	82063170	-31.657474953	-60.710478441	Santa Fe
2758	Santo Tomé	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	La Capital	82063180	-31.663018754	-60.761722306	Santa Fe
2759	Sauce Viejo	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	La Capital	82063190	-31.771093503	-60.837143685	Santa Fe
2760	San Carlos Norte	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Las Colonias	82070240	-31.673544579	-61.074767025	Santa Fe
2761	Plaza Matilde	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Las Colonias	82070180	-31.796266884	-61.01001349	Santa Fe
2762	San Agustín	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Las Colonias	82070220	-31.682873649	-60.940635723	Santa Fe
2763	San Carlos Sud	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Las Colonias	82070250	-31.760820285	-61.100577845	Santa Fe
2764	San Carlos Centro	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Las Colonias	82070230	-31.72658762	-61.090730135	Santa Fe
2765	Matilde	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Las Colonias	82070150	-31.791578104	-60.979945396	Santa Fe
2766	Granadero Baigorria	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Rosario	82084160	-32.861830506	-60.70633324	Santa Fe
2767	Ibarlucea	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Rosario	82084170	-32.85186411	-60.785479908	Santa Fe
2768	Funes	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Rosario	82084140	-32.920864509	-60.81143629	Santa Fe
2769	Gálvez	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Jerónimo	82105130	-32.030281753	-61.224328628	Santa Fe
2770	Gessler	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Jerónimo	82105140	-31.874298951	-61.12686402	Santa Fe
2771	Puerto Aragón	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Jerónimo	82105210	-32.242952198	-60.923312581	Santa Fe
2772	Monje	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Jerónimo	82105200	-32.360370427	-60.942830274	Santa Fe
2773	Larrechea	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Jerónimo	82105160	-31.935414926	-61.045751646	Santa Fe
2774	San Eugenio	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Jerónimo	82105220	-32.076171757	-61.115798786	Santa Fe
2775	Coronda	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Jerónimo	82105090	-31.974484813	-60.916091917	Santa Fe
2776	San Genaro	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Jerónimo	82105240	-32.371651348	-61.359944034	Santa Fe
2777	Maciel	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Jerónimo	82105190	-32.456841756	-60.892460199	Santa Fe
2778	Desvío Arijón	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Jerónimo	82105100	-31.870551333	-60.889246045	Santa Fe
2779	Bernardo de Irigoyen	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Jerónimo	82105060	-32.169683404	-61.156687488	Santa Fe
2780	Arocena	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Jerónimo	82105010	-32.082486532	-60.976814467	Santa Fe
2781	Balneario Monje	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Jerónimo	82105020	-32.334040252	-60.876548368	Santa Fe
2782	Centeno	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Jerónimo	82105080	-32.2960243	-61.407247569	Santa Fe
2783	López	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Jerónimo	82105180	-31.904815997	-61.277753876	Santa Fe
2784	Barrio El Pacaá - Barrio Comipini	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Jerónimo	82105050	-32.128576179	-60.930556832	Santa Fe
2785	Loma Alta	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Jerónimo	82105170	-31.96195712	-61.176711321	Santa Fe
2786	Barrio Caima	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Jerónimo	82105040	-31.837920072	-60.865032589	Santa Fe
2787	Irigoyen	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Jerónimo	82105150	-32.158147325	-61.110229851	Santa Fe
2788	Barrancas	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Jerónimo	82105030	-32.234580757	-60.983514923	Santa Fe
2789	Díaz	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Jerónimo	82105110	-32.370580822	-61.086448415	Santa Fe
2790	Casalegno	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Jerónimo	82105070	-32.263008471	-61.126468041	Santa Fe
2791	San Fabián	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Jerónimo	82105230	-32.137926717	-60.983122613	Santa Fe
2792	Gaboto	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Jerónimo	82105120	-32.432524427	-60.817814409	Santa Fe
2793	San Jerónimo Sud	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Lorenzo	82119120	-32.879398784	-61.027695155	Santa Fe
2794	San Lorenzo	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Lorenzo	82119130	-32.747261404	-60.73568746	Santa Fe
2795	Villa Elvira	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Lorenzo	82119150	-32.641338202	-60.818275778	Santa Fe
2796	Ricardone	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Lorenzo	82119100	-32.770632551	-60.784071882	Santa Fe
2797	Capitán Bermúdez	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Lorenzo	82119020	-32.826456238	-60.716155755	Santa Fe
2798	Timbúes	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Lorenzo	82119140	-32.667812155	-60.793646441	Santa Fe
2799	Puerto General San Martín	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Lorenzo	82119080	-32.71603864	-60.73139389	Santa Fe
2800	Aldao	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Lorenzo	82119010	-32.704476159	-60.815902776	Santa Fe
2801	Fray Luis Beltrán	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Lorenzo	82119050	-32.78154811	-60.731011469	Santa Fe
2802	Roldán	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Lorenzo	82119110	-32.898143152	-60.909647448	Santa Fe
2803	Luis Palacios	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Lorenzo	82119070	-32.782339978	-60.90458177	Santa Fe
2804	Colonia Belgrano	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Martín	82126050	-31.909451031	-61.400918585	Santa Fe
2805	Wildermuth	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Martín	82126180	-31.944834106	-61.401333649	Santa Fe
2806	Bajo Hondo	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Coronel de Marina Leonardo Rosales	06182010	-38.762796487	-61.920512874	Buenos Aires
2807	Punta Alta	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Coronel de Marina Leonardo Rosales	06182030	-38.880458219	-62.074996636	Buenos Aires
2808	Aparicio	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Coronel Dorrego	06189010	-38.621072356	-60.882815103	Buenos Aires
2809	Coronel Dorrego	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Coronel Dorrego	06189030	-38.718799875	-61.288360247	Buenos Aires
2810	El Perdido	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Coronel Dorrego	06189040	-38.677259659	-61.086179168	Buenos Aires
2811	Faro	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Coronel Dorrego	06189050	-38.796524605	-61.070387709	Buenos Aires
2812	Irene	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Coronel Dorrego	06189060	-38.554575533	-60.696298249	Buenos Aires
2813	Oriente	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Coronel Dorrego	06189070	-38.744398789	-60.609362577	Buenos Aires
2814	Paraje La Ruta	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Coronel Dorrego	06189075	-38.652348646	-60.865910124	Buenos Aires
2815	Country Los Medanos	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Villarino	06875025	-38.844353412	-62.73690198	Buenos Aires
2816	Juan Cousté	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Villarino	06875040	-38.894442235	-63.140734764	Buenos Aires
2817	Anzoátegui	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Caleu Caleu	42014010	-38.963052677	-63.860888246	La Pampa
2818	Barrio Esperanza	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Pichi Mahuida	62063005	-39.045383456	-63.997195292	Río Negro
2819	Colonia Juliá y Echarren	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Pichi Mahuida	62063010	-39.034559154	-64.028466932	Río Negro
2820	Juventud Unida	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Pichi Mahuida	62063013	-39.017720575	-64.065801826	Río Negro
2821	Astra	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Escalante	26021010	-45.732039771	-67.49199595	Chubut
2822	Bahía Bustamante	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Escalante	26021020	-45.12830193	-66.536646262	Chubut
2823	Comodoro Rivadavia	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Escalante	26021030	-45.865418147	-67.482159774	Chubut
2824	Rada Tilly	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Escalante	26021050	-45.92496645	-67.553724437	Chubut
2825	Dique Florentino Ameghino	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Gaiman	26042010	-43.699068408	-66.471325556	Chubut
2826	Dolavon	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Gaiman	26042020	-43.307978842	-65.709872277	Chubut
2827	28 de Julio	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Gaiman	26042040	-43.389222163	-65.840426478	Chubut
2828	El Escorial	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Gastre	26049020	-43.089762802	-68.539867671	Chubut
2829	El Mirasol	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Mártires	26063010	-43.283655209	-67.761428271	Chubut
2830	Las Plumas	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Mártires	26063020	-43.721624883	-67.284237797	Chubut
2831	Los Altares	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Paso de Indios	26070020	-43.88611468	-68.411643996	Chubut
2832	Paso de Indios	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Paso de Indios	26070030	-43.864386006	-69.046586174	Chubut
2833	Sarmiento	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Sarmiento	26091020	-45.58686791	-69.068940961	Chubut
2834	Comandante Luis Piedrabuena	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Corpen Aike	78007010	-49.985576992	-68.909299297	Santa Cruz
2835	Puerto Santa Cruz	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Corpen Aike	78007020	-50.018658749	-68.521364232	Santa Cruz
2836	Jaramillo	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Deseado	78014040	-47.184028411	-67.144724008	Santa Cruz
2837	Cañadón Seco	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Deseado	78014020	-46.561534169	-67.610632755	Santa Cruz
2838	Las Heras	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Deseado	78014060	-46.541313529	-68.932272491	Santa Cruz
2839	Puerto Deseado	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Deseado	78014080	-47.751719409	-65.900948727	Santa Cruz
2840	Pico Truncado	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Deseado	78014070	-46.799420176	-67.95785168	Santa Cruz
2841	Tellier	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Deseado	78014090	-47.649030825	-66.040043277	Santa Cruz
2842	Koluel Kaike	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Deseado	78014050	-46.716815393	-68.223580908	Santa Cruz
2843	Caleta Olivia	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Deseado	78014010	-46.447846523	-67.522740902	Santa Cruz
2844	Fitz Roy	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Deseado	78014030	-47.026347789	-67.247396841	Santa Cruz
2845	Río Gallegos	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Güer Aike	78021040	-51.623463266	-69.215864533	Santa Cruz
2846	Puerto San Julián	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Magallanes	78042010	-49.314086297	-67.719744221	Santa Cruz
2847	Gobernador Gregores	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Río Chico	78049020	-48.750897337	-70.24851966	Santa Cruz
2848	San Nicolás de los Arroyos	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Nicolás	06763050	-33.327581039	-60.217058045	Buenos Aires
2849	Barrio Mitre	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Constitución	82028030	-33.251723013	-60.38883548	Santa Fe
2850	La Vanguardia	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Constitución	82028130	-33.357997655	-60.657374548	Santa Fe
2851	Empalme Villa Constitución	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Constitución	82028070	-33.261169076	-60.379604726	Santa Fe
2852	Godoy	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Constitución	82028100	-33.367191002	-60.509301699	Santa Fe
2853	Pavón	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Constitución	82028150	-33.242900662	-60.407112415	Santa Fe
2854	Barrio Arroyo del Medio	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Constitución	82028020	-33.283614422	-60.271423804	Santa Fe
2855	Theobald	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Constitución	82028220	-33.310977361	-60.312373215	Santa Fe
2856	Villa Constitución	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Constitución	82028230	-33.227270027	-60.329749816	Santa Fe
2857	Rueda	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Constitución	82028180	-33.335935158	-60.458780719	Santa Fe
2858	Pavón Arriba	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Constitución	82028160	-33.311588517	-60.824298558	Santa Fe
2859	Pueblo Esther	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Rosario	82084230	-33.072293033	-60.574993569	Santa Fe
2860	Arroyo Seco	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Rosario	82084070	-33.158138521	-60.511938219	Santa Fe
2861	Los Muchachos - La Alborada	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Rosario	82084190	-33.090297933	-60.736330044	Santa Fe
2862	Villa Amelia	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Rosario	82084290	-33.175907959	-60.664101151	Santa Fe
2863	Villa del Plata	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Rosario	82084300	-33.126294569	-60.706921673	Santa Fe
2864	Arbilla	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Rosario	82084050	-33.091065759	-60.698477648	Santa Fe
2865	Álvarez	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Rosario	82084030	-33.128090119	-60.806189982	Santa Fe
2866	Alvear	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Rosario	82084040	-33.057841175	-60.619843473	Santa Fe
2867	El Caramelo	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Rosario	82084120	-33.128516221	-60.713401087	Santa Fe
2868	Carmen del Sauce	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Rosario	82084080	-33.236026673	-60.811771058	Santa Fe
2869	Albarellos	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Rosario	82084020	-33.239538678	-60.636760641	Santa Fe
2870	Pueblo Muñóz	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Rosario	82084240	-33.17204632	-60.898073763	Santa Fe
2871	Arminda	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Rosario	82084060	-33.263575925	-60.967881949	Santa Fe
2872	Monte Flores	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Rosario	82084200	-33.076337757	-60.633435017	Santa Fe
2873	Acébal	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Rosario	82084010	-33.241763958	-60.83648037	Santa Fe
2874	Puerto Arroyo Seco	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Rosario	82084260	-33.130415387	-60.505845853	Santa Fe
2875	Fighiera	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Rosario	82084130	-33.193862118	-60.469438049	Santa Fe
2876	Piñero	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Rosario	82084220	-33.10913966	-60.79611239	Santa Fe
2877	Coronel Rodolfo S. Domínguez	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Rosario	82084100	-33.183704879	-60.721981056	Santa Fe
2878	Pérez	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Rosario	82084210	-32.998872169	-60.769868612	Santa Fe
2879	Kilómetro 101	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Rosario	82084180	-33.058789857	-60.684972315	Santa Fe
2880	Soldini	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Rosario	82084280	-33.027584022	-60.756754849	Santa Fe
2881	Pueblo Uranga	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Rosario	82084250	-33.26603727	-60.705249593	Santa Fe
2882	Zavalla	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Rosario	82084320	-33.019631886	-60.878497011	Santa Fe
2883	Coronel Bogado	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Rosario	82084090	-33.315854534	-60.602677216	Santa Fe
2884	Cuatro Esquinas	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Rosario	82084110	-33.244261433	-60.764324899	Santa Fe
2885	General Lagos	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Rosario	82084150	-33.110043043	-60.564557843	Santa Fe
2886	Rosario	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Rosario	82084270	-32.947213384	-60.633175576	Santa Fe
2887	Villa Gobernador Gálvez	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Rosario	82084310	-33.025131924	-60.633689288	Santa Fe
2888	Villa Mugueta	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Lorenzo	82119160	-33.311964956	-61.056294656	Santa Fe
2889	Pujato	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Lorenzo	82119090	-33.01764822	-61.043053541	Santa Fe
2890	Coronel Arnold	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Lorenzo	82119040	-33.106020936	-60.966809694	Santa Fe
2891	Fuentes	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Lorenzo	82119060	-33.172495667	-61.07413011	Santa Fe
2892	Paso Viejo	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Cruz del Eje	14028160	-30.767438455	-65.190431099	Córdoba
2893	Serrezuela	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Cruz del Eje	14028180	-30.638772415	-65.38874113	Córdoba
2894	Tuclame	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Cruz del Eje	14028190	-30.746591448	-65.23562126	Córdoba
2895	La Playa	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Minas	14070050	-31.009668976	-65.3612672	Córdoba
2896	Ciénaga del Coro	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Minas	14070010	-31.042421887	-65.283525095	Córdoba
2897	El Chacho	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Minas	14070020	-30.800382636	-65.656404221	Córdoba
2898	Estancia de Guadalupe	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Minas	14070030	-31.130075737	-65.215975468	Córdoba
2899	Guasapampa	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Minas	14070040	-31.101592949	-65.329209345	Córdoba
2900	Talaini	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Minas	14070070	-31.249850218	-65.169287078	Córdoba
2901	Tosno	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Minas	14070080	-30.959873819	-65.310397267	Córdoba
2902	Chancani	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Pocho	14077010	-31.415963635	-65.451253237	Córdoba
2903	Las Palmas	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Pocho	14077020	-31.377775939	-65.289836231	Córdoba
2904	Villa de Pocho	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Pocho	14077080	-31.490157577	-65.280950546	Córdoba
2905	San Martín	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Alberto	14126150	-31.885536035	-65.477466618	Córdoba
2906	San Vicente	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Alberto	14126170	-31.85055697	-65.429474357	Córdoba
2907	Los Cerrillos	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Javier	14133110	-31.9726992	-65.444638225	Córdoba
2908	San José	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Javier	14133180	-31.956501268	-65.3118043	Córdoba
2909	Villa Dolores	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Javier	14133200	-31.944976763	-65.190239696	Córdoba
2910	Castro Barros	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	General Belgrano	46063010	-30.578893736	-65.727110293	La Rioja
2911	Los Cajones	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Junín	74049040	-32.024043929	-65.372505193	San Luis
2912	Lafinur	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Junín	74049030	-32.062581975	-65.350141542	San Luis
2913	Talita	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Junín	74049080	-32.248952357	-65.583238234	San Luis
2914	Santa Rosa del Conlara	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Junín	74049070	-32.342833348	-65.208905898	San Luis
2915	Las Aguadas	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Libertador General San Martín	74063020	-32.375884353	-65.501135014	San Luis
2916	Conscripto Bernardi	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Federal	30035010	-31.046243815	-59.086722666	Entre Ríos
2917	Aldea San Isidro (El Cimarrón)	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Federal	30035020	-30.974102305	-58.996413544	Entre Ríos
2918	Federal	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Federal	30035030	-30.956214281	-58.779587505	Entre Ríos
2919	Sauce de Luna	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Federal	30035050	-31.239523266	-59.217371084	Entre Ríos
2920	San Víctor	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Feliciano	30042020	-30.485189962	-59.02834138	Entre Ríos
2921	Alcaraz	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	La Paz	30070005	-31.457365346	-59.598572312	Entre Ríos
2922	Bovril	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	La Paz	30070010	-31.343579683	-59.446389766	Entre Ríos
2923	Colonia Avigdor	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	La Paz	30070020	-31.1831955	-59.408237281	Entre Ríos
2924	El Solar	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	La Paz	30070030	-31.179544085	-59.733134063	Entre Ríos
2925	La Paz	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	La Paz	30070040	-30.740476624	-59.644301279	Entre Ríos
2926	Piedras Blancas	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	La Paz	30070050	-31.185006148	-59.949957714	Entre Ríos
2927	San Gustavo	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	La Paz	30070070	-30.690287748	-59.394984294	Entre Ríos
2928	Santa Elena	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	La Paz	30070080	-30.944460002	-59.789121291	Entre Ríos
2929	Sir Leonard	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	La Paz	30070090	-31.388921151	-59.501061936	Entre Ríos
2930	Aldea Santa María	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Paraná	30084030	-31.611332991	-60.006886951	Entre Ríos
2931	El Pingo	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Paraná	30084090	-31.582967604	-59.890848298	Entre Ríos
2932	Hasenkamp	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Paraná	30084100	-31.512168875	-59.835282789	Entre Ríos
2933	Hernandarias	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Paraná	30084110	-31.230008248	-59.988286446	Entre Ríos
2934	Pueblo Bellocq (Las Garzas)	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Paraná	30084170	-31.427426874	-59.744493262	Entre Ríos
2935	Pueblo Brugo	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Paraná	30084180	-31.387329093	-60.091814125	Entre Ríos
2936	Pueblo General San Martín	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Paraná	30084190	-31.458360874	-60.169052456	Entre Ríos
2937	Helvecia	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Garay	82035020	-31.102358366	-60.088892157	Santa Fe
2938	Santa Rosa de Calchines	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Garay	82035050	-31.420386333	-60.332683108	Santa Fe
2939	Cayastá	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Garay	82035010	-31.200750661	-60.159353791	Santa Fe
2940	Los Zapallos	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Garay	82035030	-31.492003054	-60.428977487	Santa Fe
2941	Saladero Mariano Cabal	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Garay	82035040	-30.880605099	-60.035242547	Santa Fe
2942	Arroyo Leyes	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	La Capital	82063030	-31.558725564	-60.517508005	Santa Fe
2943	Paraje Chaco Chico	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	La Capital	82063120	-31.56650715	-60.661519542	Santa Fe
2944	Laguna Paiva	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	La Capital	82063080	-31.307357755	-60.659922468	Santa Fe
2945	Campo Andino	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	La Capital	82063050	-31.239054918	-60.529807032	Santa Fe
2946	Nelson	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	La Capital	82063110	-31.265832506	-60.7644508	Santa Fe
2947	Llambi Campbell	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	La Capital	82063090	-31.184183474	-60.74768043	Santa Fe
2948	Angel Gallardo	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	La Capital	82063010	-31.555826315	-60.678416469	Santa Fe
2949	Emilia	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	La Capital	82063070	-31.059019116	-60.744908207	Santa Fe
2950	Rincón Potrero	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	La Capital	82063150	-31.528997202	-60.479997067	Santa Fe
2951	San José del Rincón	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	La Capital	82063160	-31.606505912	-60.567441943	Santa Fe
2952	Villa Laura	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	La Capital	82063200	-31.372064899	-60.66229261	Santa Fe
2953	Recreo	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	La Capital	82063140	-31.49089311	-60.73544887	Santa Fe
2954	Arroyo Aguiar	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	La Capital	82063020	-31.432087138	-60.667931227	Santa Fe
2955	Monte Vera	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	La Capital	82063100	-31.516801566	-60.678676504	Santa Fe
2956	Paraje La Costa	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	La Capital	82063130	-31.515355416	-60.613211484	Santa Fe
2957	Candioti	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	La Capital	82063060	-31.401390352	-60.748981611	Santa Fe
2958	Cabal	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	La Capital	82063040	-31.103990753	-60.727151845	Santa Fe
2959	Empalme San Carlos	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Las Colonias	82070040	-31.547704815	-60.813712665	Santa Fe
2960	Esperanza	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Las Colonias	82070050	-31.448890097	-60.930152876	Santa Fe
2961	Grutly	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Las Colonias	82070080	-31.268690116	-61.071972168	Santa Fe
2962	Cavour	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Las Colonias	82070010	-31.364804459	-61.0165432	Santa Fe
2963	Las Tunas	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Las Colonias	82070130	-31.571890246	-60.996131603	Santa Fe
2964	Humboldt	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Las Colonias	82070100	-31.400858425	-61.082298172	Santa Fe
2965	María Luisa	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Las Colonias	82070140	-31.010843839	-60.910761578	Santa Fe
2966	Providencia	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Las Colonias	82070200	-30.982740314	-61.021127137	Santa Fe
2967	Jacinto L. Aráuz	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Las Colonias	82070110	-30.734298215	-60.975553325	Santa Fe
2968	Santo Domingo	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Las Colonias	82070300	-31.120466213	-60.887993951	Santa Fe
2969	Cululú	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Las Colonias	82070020	-31.206092138	-60.930019008	Santa Fe
2970	Progreso	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Las Colonias	82070190	-31.1378669	-60.989642227	Santa Fe
2971	La Pelada	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Las Colonias	82070120	-30.866241488	-60.968292585	Santa Fe
2972	San Jerónimo Norte	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Las Colonias	82070270	-31.552707917	-61.077923536	Santa Fe
2973	Franck	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Las Colonias	82070070	-31.587189684	-60.938340404	Santa Fe
2974	Hipatía	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Las Colonias	82070090	-31.125576584	-61.033006408	Santa Fe
2975	Elisa	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Las Colonias	82070030	-30.694492683	-61.049400274	Santa Fe
2976	Villa Saralegui	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Cristóbal	82091270	-30.540840937	-60.746778975	Santa Fe
2977	Soledad	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Cristóbal	82091250	-30.619649247	-60.914513768	Santa Fe
2978	San Javier	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Javier	82098060	-30.581667539	-59.928100523	Santa Fe
2979	Cacique Ariacaiquín	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Javier	82098020	-30.656342437	-60.229808156	Santa Fe
2980	La Brava	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Javier	82098040	-30.447781739	-60.140936695	Santa Fe
2981	Ramayón	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Justo	82112110	-30.671950034	-60.505951998	Santa Fe
2982	Silva	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Justo	82112150	-30.44730089	-60.430562562	Santa Fe
2983	San Justo	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Justo	82112130	-30.789171151	-60.593300591	Santa Fe
2984	Esther	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Justo	82112040	-31.040692586	-60.6451918	Santa Fe
2985	Marcelino Escalada	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Justo	82112080	-30.58093514	-60.468307556	Santa Fe
2986	Angeloni	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Justo	82112010	-30.855665886	-60.650175532	Santa Fe
2987	Naré	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Justo	82112090	-30.948776173	-60.467036125	Santa Fe
2988	Videla	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Justo	82112170	-30.942921848	-60.657012597	Santa Fe
2989	San Bernardo	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Justo	82112120	-30.889177536	-60.573977216	Santa Fe
2990	Cayastacito	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Justo	82112020	-31.112809702	-60.579878395	Santa Fe
2991	Bouquet	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Belgrano	82007020	-32.423631502	-61.88973606	Santa Fe
2992	Arroyo Algodón	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	General San Martín	14042010	-32.201187006	-63.16512476	Córdoba
2993	La Playosa	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	General San Martín	14042080	-32.097001584	-63.034350873	Córdoba
2994	Silvio Pellico	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	General San Martín	14042130	-32.249625296	-62.93088116	Córdoba
2995	Saira	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Marcos Juárez	14063210	-32.409712987	-62.102348922	Córdoba
2996	Carrilobo	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Río Segundo	14119040	-31.873714881	-63.117398136	Córdoba
2997	Pozo del Molle	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	Río Segundo	14119170	-32.021336576	-62.919308799	Córdoba
2998	Alicia	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Justo	14140010	-31.938847228	-62.464245769	Córdoba
2999	El Fortín	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Justo	14140180	-31.966920207	-62.300176296	Córdoba
3000	Las Varas	2026-11-08 23:05:59.755	2026-11-08 23:05:59.755	San Justo	14140260	-31.802437611	-62.616597453	Córdoba
3001	Las Varillas	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	San Justo	14140270	-31.870384794	-62.71966478	Córdoba
3002	Alto Alegre	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Unión	14182020	-32.344688717	-62.884913584	Córdoba
3003	Ana Zumarán	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Unión	14182030	-32.390952848	-63.057232438	Córdoba
3004	Chilibroste	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Unión	14182090	-32.332692033	-62.510795668	Córdoba
3005	Cintra	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Unión	14182100	-32.30633182	-62.651606075	Córdoba
3006	Noetinger	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Unión	14182190	-32.366022494	-62.307174837	Córdoba
3007	San Antonio de Litín	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Unión	14182240	-32.213580739	-62.63132888	Córdoba
3008	Landeta	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	San Martín	82126080	-32.012754071	-62.06228099	Santa Fe
3009	Traill	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	San Martín	82126170	-31.921522362	-61.702627127	Santa Fe
3010	Piamonte	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	San Martín	82126130	-32.14392576	-61.980441593	Santa Fe
3011	Las Petacas	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	San Martín	82126100	-31.821185928	-62.110499381	Santa Fe
3012	Las Bandurrias	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	San Martín	82126090	-32.197475347	-61.492279018	Santa Fe
3013	San Martín de las Escobas	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	San Martín	82126150	-31.857863512	-61.569620354	Santa Fe
3014	Los Cardos	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	San Martín	82126110	-32.322261344	-61.631586341	Santa Fe
3015	Cañada Rosquín	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	San Martín	82126010	-32.054368292	-61.601859243	Santa Fe
3016	Casas	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	San Martín	82126030	-32.125633653	-61.539842909	Santa Fe
3017	María Susana	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	San Martín	82126120	-32.266977408	-61.905867844	Santa Fe
3018	El Trébol	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	San Martín	82126070	-32.198041432	-61.701915596	Santa Fe
3019	San Jorge	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	San Martín	82126140	-31.896153096	-61.859653304	Santa Fe
3020	Carlos Pellegrini	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	San Martín	82126020	-32.050451788	-61.782730951	Santa Fe
3021	Buenos Aires Chico	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Cushamen	26014010	-42.066968043	-71.214813982	Chubut
3022	Cholila	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Cushamen	26014020	-42.511351143	-71.431134384	Chubut
3023	Costa del Chubut	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Cushamen	26014025	-42.603935018	-70.457030292	Chubut
3024	Cushamen Centro	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Cushamen	26014030	-42.173017612	-70.661397788	Chubut
3025	El Hoyo	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Cushamen	26014040	-42.064050303	-71.519143292	Chubut
3026	El Maitén	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Cushamen	26014050	-42.05032089	-71.167787457	Chubut
3027	Epuyén	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Cushamen	26014060	-42.229226035	-71.371059779	Chubut
3028	Fofo Cahuel	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Cushamen	26014065	-42.408211663	-70.530714862	Chubut
3029	Gualjaina	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Cushamen	26014070	-42.723832262	-70.537720017	Chubut
3030	Lago Epuyén	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Cushamen	26014080	-42.216890434	-71.429670892	Chubut
3031	Lago Puelo	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Cushamen	26014090	-42.060132162	-71.597140032	Chubut
3032	Leleque	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Cushamen	26014100	-42.412947255	-71.071151709	Chubut
3033	Aldea Escolar (Los Rápidos)	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Futaleufú	26035010	-43.133019601	-71.550982828	Chubut
3034	Corcovado	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Futaleufú	26035020	-43.539302185	-71.468855332	Chubut
3035	Esquel	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Futaleufú	26035030	-42.91732071	-71.321572554	Chubut
3036	Lago Rosario	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Futaleufú	26035040	-43.247160399	-71.348946811	Chubut
3037	Los Cipreses	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Futaleufú	26035050	-43.183358362	-71.641603536	Chubut
3038	Trevelín	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Futaleufú	26035060	-43.079161352	-71.464032921	Chubut
3039	Villa Futalaufquen	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Futaleufú	26035070	-42.89384961	-71.617489444	Chubut
3040	Blancuntre	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Gastre	26049010	-42.620060668	-68.904304619	Chubut
3041	Gastre	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Gastre	26049030	-42.26319813	-69.222143804	Chubut
3042	Lagunita Salada	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Gastre	26049040	-42.742232747	-69.14900587	Chubut
3043	Yala Laubat	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Gastre	26049050	-42.759145121	-68.867552327	Chubut
3044	Aldea Epulef	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Languiñeo	26056010	-43.320822744	-69.692293161	Chubut
3045	Carrenleufú	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Languiñeo	26056020	-43.587897929	-71.702134687	Chubut
3046	Colan Conhué	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Languiñeo	26056030	-43.241370273	-69.930334884	Chubut
3047	Paso del Sapo	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Languiñeo	26056040	-42.735115873	-69.608153689	Chubut
3048	Tecka	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Languiñeo	26056050	-43.492864944	-70.81078074	Chubut
3049	Cerro Cóndor	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Paso de Indios	26070010	-43.419784606	-69.164267673	Chubut
3050	Villa La Angostura	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Los Lagos	58070010	-40.762995839	-71.641001922	Neuquén
3051	Colonia Suiza	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Bariloche	62021020	-41.094534261	-71.508613974	Río Negro
3052	El Foyel	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Bariloche	62021040	-41.653900371	-71.46008482	Río Negro
3053	Mallín Ahogado	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Bariloche	62021047	-41.839633275	-71.504412388	Río Negro
3054	Río Villegas	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Bariloche	62021050	-41.577855946	-71.502513175	Río Negro
3055	San Carlos de Bariloche	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Bariloche	62021060	-41.134196685	-71.310958312	Río Negro
3056	Villa Mascardi	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Bariloche	62021110	-41.349553642	-71.50904163	Río Negro
3057	Villa Catedral	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Bariloche	62021080	-41.167621499	-71.440213727	Río Negro
3058	El Bolsón	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Bariloche	62021030	-41.965021628	-71.53436359	Río Negro
3059	Mamuel Choique	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Ñorquinco	62056020	-41.772465114	-70.138070873	Río Negro
3060	Río Chico	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Ñorquinco	62056050	-41.710292506	-70.476724137	Río Negro
3061	Ñorquincó	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Ñorquinco	62056030	-41.848928085	-70.898215235	Río Negro
3062	Ojos de Agua	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Ñorquinco	62056040	-41.556351202	-69.869368331	Río Negro
3063	Las Bayas	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Ñorquinco	62056010	-41.456079605	-70.669332664	Río Negro
3064	Laguna Blanca	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Pilcaniyeu	62070030	-40.722024053	-69.841695897	Río Negro
3065	Villa Llanquín	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Pilcaniyeu	62070080	-40.894560321	-71.036667452	Río Negro
3066	Dina Huapi	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Pilcaniyeu	62070020	-41.073719812	-71.157491154	Río Negro
3067	Cañadón Chileno	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Pilcaniyeu	62070005	-40.888954133	-70.023767324	Río Negro
3068	Comallo	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Pilcaniyeu	62070010	-41.030047592	-70.26932323	Río Negro
3069	Ñirihuau	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Pilcaniyeu	62070040	-41.087387458	-71.141784986	Río Negro
3070	Pilcaniyeu	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Pilcaniyeu	62070060	-41.122639494	-70.721587284	Río Negro
3071	Pilquiniyeu del Limay	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Pilcaniyeu	62070070	-40.516231176	-70.025849977	Río Negro
3072	Colan Conhue	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	25 de Mayo	62091030	-40.668548037	-69.106695169	Río Negro
3073	Clemente Onelli	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	25 de Mayo	62091020	-41.246399604	-70.032710155	Río Negro
3074	Ingeniero Jacobacci	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	25 de Mayo	62091050	-41.330598145	-69.547063621	Río Negro
3075	Maquinchao	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	25 de Mayo	62091070	-41.250225874	-68.698254765	Río Negro
3076	Rojas	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Rojas	06686060	-34.197742429	-60.733700695	Buenos Aires
3077	Irineo Portela	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Baradero	06070020	-33.979830383	-59.670121708	Buenos Aires
3078	Santa Coloma	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Baradero	06070030	-34.060871235	-59.560215964	Buenos Aires
3079	Arrecifes	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Arrecifes	06077010	-34.067514908	-60.108691585	Buenos Aires
3080	Viña	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Arrecifes	06077030	-33.99237915	-60.226418357	Buenos Aires
3081	Capitán Sarmiento	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Capitán Sarmiento	06140010	-34.171279849	-59.79359868	Buenos Aires
3082	La Luisa	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Capitán Sarmiento	06140020	-34.129565279	-59.926418212	Buenos Aires
3083	Carmen de Areco	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Carmen de Areco	06161010	-34.376662079	-59.822696533	Buenos Aires
3084	Pueblo Gouin	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Carmen de Areco	06161020	-34.493558355	-59.801354666	Buenos Aires
3085	Tres Sargentos	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Carmen de Areco	06161030	-34.466563318	-59.999450348	Buenos Aires
3086	Villa Manuel Pomar	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Colón	06175020	-33.913366074	-60.942327512	Buenos Aires
3087	Pearson	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Colón	06175030	-33.653288319	-60.893058388	Buenos Aires
3088	Castilla	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Chacabuco	06210010	-34.613315095	-59.906128241	Buenos Aires
3089	Chacabuco	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Chacabuco	06210020	-34.642025986	-60.471236531	Buenos Aires
3090	Los Angeles	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Chacabuco	06210030	-34.457145308	-60.180292084	Buenos Aires
3091	O'Higgins	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Chacabuco	06210040	-34.585549565	-60.699887552	Buenos Aires
3092	Rawson	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Chacabuco	06210050	-34.60508472	-60.066825041	Buenos Aires
3093	La Angelita	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	General Arenales	06294060	-34.26179394	-60.966108008	Buenos Aires
3094	Agustín Roca	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Junín	06413010	-34.507254035	-60.864898816	Buenos Aires
3095	Paraje La Agraria	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Junín	06413055	-34.657277802	-60.848531659	Buenos Aires
3096	Acevedo	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Pergamino	06623010	-33.755038503	-60.439959294	Buenos Aires
3097	Fontezuela	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Pergamino	06623020	-33.912063973	-60.460033344	Buenos Aires
3098	Guerrico	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Pergamino	06623030	-33.676129253	-60.400165145	Buenos Aires
3099	Juan A. de la Peña	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Pergamino	06623040	-33.831381544	-60.487968996	Buenos Aires
3100	Juan Anchorena	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Pergamino	06623050	-33.924309504	-60.382839664	Buenos Aires
3101	La Violeta	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Pergamino	06623060	-33.733064625	-60.168512208	Buenos Aires
3102	Manuel Ocampo	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Pergamino	06623070	-33.76499642	-60.651036602	Buenos Aires
3103	Mariano Benítez	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Pergamino	06623080	-33.707847096	-60.583422006	Buenos Aires
3104	Mariano H. Alfonzo	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Pergamino	06623090	-33.913508534	-60.837125464	Buenos Aires
3105	Pergamino	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Pergamino	06623100	-33.891109145	-60.574586193	Buenos Aires
3106	Pinzón	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Pergamino	06623110	-33.993284658	-60.730661398	Buenos Aires
3107	Rancagua	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Pergamino	06623120	-34.029793347	-60.502815465	Buenos Aires
3108	Villa Angélica	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Pergamino	06623130	-33.66370177	-60.708579962	Buenos Aires
3109	Villa San José	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Pergamino	06623140	-34.091667931	-60.413503796	Buenos Aires
3110	El Paraíso	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Ramallo	06665010	-33.570424022	-59.978028422	Buenos Aires
3111	Las Bahamas	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Ramallo	06665020	-33.637675011	-59.988854776	Buenos Aires
3112	Pérez Millán	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Ramallo	06665030	-33.770193926	-60.093741052	Buenos Aires
3113	Ramallo	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Ramallo	06665040	-33.485202118	-60.004438424	Buenos Aires
3114	Villa General Savio	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Ramallo	06665050	-33.43597798	-60.146449766	Buenos Aires
3115	La Beba	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Rojas	06686010	-34.1541391	-61.011284299	Buenos Aires
3116	Las Carabelas	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Rojas	06686020	-34.036874525	-60.867621194	Buenos Aires
3117	Los Indios	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Rojas	06686030	-34.371815485	-60.654074924	Buenos Aires
3118	Rafael Obligado	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Rojas	06686040	-34.35964571	-60.783789954	Buenos Aires
3119	Roberto Cano	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Rojas	06686050	-34.087718857	-60.667679781	Buenos Aires
3120	Sol de Mayo	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Rojas	06686070	-34.268970216	-60.872256472	Buenos Aires
3121	Villa Manuel Pomar	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Rojas	06686080	-33.915451901	-60.938344242	Buenos Aires
3122	Obligado	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	San Pedro	06770020	-33.596812	-59.817693641	Buenos Aires
3123	Arroyo Dulce	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Salto	06714010	-34.101388486	-60.408777338	Buenos Aires
3124	Berdier	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Salto	06714020	-34.397934196	-60.259570552	Buenos Aires
3125	Gahan	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Salto	06714030	-34.338233004	-60.101214958	Buenos Aires
3126	Inés Indart	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Salto	06714040	-34.396292547	-60.536849652	Buenos Aires
3127	La Invencible	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Salto	06714050	-34.267018129	-60.385802821	Buenos Aires
3128	Salto	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Salto	06714060	-34.291746314	-60.254502488	Buenos Aires
3129	Franklin	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	San Andrés de Giles	06728030	-34.609116607	-59.629935034	Buenos Aires
3130	Duggan	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	San Antonio de Areco	06735010	-34.207382186	-59.637022182	Buenos Aires
3131	Conesa	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	San Nicolás	06763010	-33.5958038	-60.355741199	Buenos Aires
3132	Erezcano	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	San Nicolás	06763020	-33.523462782	-60.316628018	Buenos Aires
3133	General Rojo	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	San Nicolás	06763030	-33.474726109	-60.28732209	Buenos Aires
3134	Villa Esperanza	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	San Nicolás	06763060	-33.421383409	-60.260363297	Buenos Aires
3135	Gobernador Castro	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	San Pedro	06770010	-33.65901363	-59.868477682	Buenos Aires
3136	Ingeniero Moneta	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	San Pedro	06770015	-33.930690027	-59.749458854	Buenos Aires
3137	Pueblo Doyle	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	San Pedro	06770030	-33.901813792	-59.819004015	Buenos Aires
3138	Río Tala	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	San Pedro	06770040	-33.769292781	-59.639484532	Buenos Aires
3139	San Pedro	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	San Pedro	06770050	-33.675948032	-59.663015814	Buenos Aires
3140	Santa Lucía	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	San Pedro	06770060	-33.88094411	-59.874202144	Buenos Aires
3141	General Rivas	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Suipacha	06784010	-34.60843497	-59.750166284	Buenos Aires
3142	Máximo Paz	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Constitución	82028140	-33.483177504	-60.956104819	Santa Fe
3143	Juan B. Molina	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Constitución	82028110	-33.493837219	-60.510784435	Santa Fe
3144	Cañada Rica	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Constitución	82028050	-33.516017756	-60.610105145	Santa Fe
3145	General Gelly	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Constitución	82028090	-33.600176275	-60.597913976	Santa Fe
3146	Peyrano	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Constitución	82028170	-33.537779916	-60.799718206	Santa Fe
3147	Cepeda	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Constitución	82028060	-33.398178837	-60.623914907	Santa Fe
3148	Stephenson	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Constitución	82028210	-33.414340993	-60.559423243	Santa Fe
3149	Sargento Cabral	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Constitución	82028200	-33.431334926	-60.629286566	Santa Fe
3150	Santa Teresa	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Constitución	82028190	-33.436646695	-60.790487549	Santa Fe
3151	Bella Vista	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Bella Vista	18007010	-28.507683212	-59.045217289	Corrientes
3152	La Sarita	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	General Obligado	82049100	-28.972829032	-59.848837173	Santa Fe
3153	Los Laureles	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	General Obligado	82049140	-29.368647813	-59.736191715	Santa Fe
3154	Avellaneda	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	General Obligado	82049020	-29.117521481	-59.658472079	Santa Fe
3155	El Araza	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	General Obligado	82049040	-29.132999698	-59.947582009	Santa Fe
3156	Reconquista	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	General Obligado	82049180	-29.14451733	-59.643547899	Santa Fe
3157	San Antonio de Obligado	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	General Obligado	82049190	-28.384253452	-59.264387725	Santa Fe
3158	Arroyo Ceibal	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	General Obligado	82049010	-28.723081244	-59.477697687	Santa Fe
3159	Guadalupe Norte	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	General Obligado	82049070	-28.945053598	-59.563625931	Santa Fe
3160	Ingeniero Chanourdie	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	General Obligado	82049080	-28.759812528	-59.577233272	Santa Fe
3161	Lanteri	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	General Obligado	82049110	-28.840006734	-59.635194281	Santa Fe
3162	Tacuarendí	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	General Obligado	82049200	-28.417846866	-59.257225992	Santa Fe
3163	La Isleta	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	General Obligado	82049090	-28.492169558	-59.294192675	Santa Fe
3164	Malabrigo	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	General Obligado	82049150	-29.348795563	-59.969905258	Santa Fe
3165	Paraje San Manuel	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	General Obligado	82049160	-28.873609297	-59.865981259	Santa Fe
3166	Villa Ana	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	General Obligado	82049210	-28.492662372	-59.613328565	Santa Fe
3167	Las Toscas	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	General Obligado	82049130	-28.354892836	-59.259301675	Santa Fe
3168	Villa Ocampo	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	General Obligado	82049230	-28.486772613	-59.354747325	Santa Fe
3169	Las Garzas	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	General Obligado	82049120	-28.847137374	-59.499654596	Santa Fe
3170	Berna	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	General Obligado	82049030	-29.272668015	-59.845311095	Santa Fe
3171	Puerto Reconquista	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	General Obligado	82049170	-29.233753298	-59.581040112	Santa Fe
3172	Toba	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Vera	82133160	-29.268163526	-60.171541447	Santa Fe
3173	Fortín Olmos	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Vera	82133040	-29.05695372	-60.412898601	Santa Fe
3174	Intiyaco	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Vera	82133070	-28.674865683	-60.070701237	Santa Fe
3175	Pueblo Santa Lucía	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Vera	82133140	-29.281917076	-60.402675587	Santa Fe
3176	Pozo de los Indios	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Vera	82133130	-28.94513262	-60.252004069	Santa Fe
3177	Tartagal	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Vera	82133150	-28.671054465	-59.848085638	Santa Fe
3178	Garabato	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Vera	82133050	-28.954490088	-60.135076762	Santa Fe
3179	Kilómetro 115	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Vera	82133080	-28.824760144	-60.223405171	Santa Fe
3180	Colmena	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Vera	82133030	-28.76250029	-60.091090766	Santa Fe
3181	Cañada Ombú	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Vera	82133020	-28.309129845	-59.983554195	Santa Fe
3182	Golondrina	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Vera	82133060	-28.556375472	-60.024787423	Santa Fe
3183	Paraje 29	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Vera	82133120	-29.108224532	-60.239286264	Santa Fe
3184	Esquina	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Esquina	18049010	-30.014607065	-59.529518735	Corrientes
3185	Pueblo Libertador	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Esquina	18049020	-30.220105734	-59.389758208	Corrientes
3186	Sauce	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Sauce	18175010	-30.085534717	-58.787280777	Corrientes
3187	San José de Feliciano	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Feliciano	30042010	-30.385443736	-58.750257275	Entre Ríos
3188	Romang	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	San Javier	82098050	-29.499597898	-59.747702385	Santa Fe
3189	Alejandra	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	San Javier	82098010	-29.909209629	-59.826868623	Santa Fe
3190	Colonia Durán	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	San Javier	82098030	-29.558119278	-59.926592349	Santa Fe
3191	Pedro Gómez Cello	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	San Justo	82112100	-30.038474096	-60.315243395	Santa Fe
3192	San Martín Norte	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	San Justo	82112140	-30.345714262	-60.303514348	Santa Fe
3193	Gobernador Crespo	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	San Justo	82112050	-30.362953549	-60.400239784	Santa Fe
3194	Colonia Dolores	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	San Justo	82112030	-30.382384558	-60.330486071	Santa Fe
3195	Vera y Pintado	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	San Justo	82112160	-30.144270055	-60.338807685	Santa Fe
3196	La Penca y Caraguatá	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	San Justo	82112070	-30.346723383	-60.52124935	Santa Fe
3197	La Criolla	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	San Justo	82112060	-30.2236712	-60.363604278	Santa Fe
3198	La Gallareta	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Vera	82133090	-29.586275929	-60.378224142	Santa Fe
3199	Calchaquí	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Vera	82133010	-29.888009295	-60.283116146	Santa Fe
3200	Vera	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Vera	82133170	-29.459228624	-60.214771946	Santa Fe
3201	Margarita	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Vera	82133110	-29.687649602	-60.253184395	Santa Fe
3202	Baradero	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Baradero	06070010	-33.807072775	-59.502227835	Buenos Aires
3203	Villa Alsina	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Baradero	06070040	-33.907660918	-59.390649065	Buenos Aires
3204	Azcuénaga	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	San Andrés de Giles	06728010	-34.3665476	-59.375480678	Buenos Aires
3205	San Antonio de Areco	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	San Antonio de Areco	06735020	-34.243638134	-59.473652344	Buenos Aires
3206	Villa Lía	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	San Antonio de Areco	06735030	-34.123200256	-59.430482448	Buenos Aires
3207	La Escondida	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	General Donovan	22056010	-27.105348615	-59.446376942	Chaco
3208	La Verde	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	General Donovan	22056020	-27.13041799	-59.376198307	Chaco
3209	Lapachito	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	General Donovan	22056030	-27.159332498	-59.385415442	Chaco
3210	Makallé	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	General Donovan	22056040	-27.205784921	-59.287086096	Chaco
3211	Colonia Popular	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Libertad	22077010	-27.275191873	-59.151475692	Chaco
3212	Estación General Obligado	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Libertad	22077020	-27.411626261	-59.419345904	Chaco
3213	Laguna Blanca	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Libertad	22077030	-27.255430438	-59.233015804	Chaco
3214	Puerto Tirol	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Libertad	22077040	-27.374041191	-59.089276165	Chaco
3215	Ciervo Petiso	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Libertador General San Martín	22084010	-26.58014248	-59.630033802	Chaco
3216	General José de San Martín	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Libertador General San Martín	22084020	-26.53630236	-59.341321005	Chaco
3217	La Eduvigis	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Libertador General San Martín	22084030	-26.836461812	-59.06232062	Chaco
3218	Laguna Limpia	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Libertador General San Martín	22084040	-26.49583991	-59.680356876	Chaco
3219	Pampa Almirón	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Libertador General San Martín	22084050	-26.701149341	-59.124045076	Chaco
3220	Selvas del Río de Oro	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Libertador General San Martín	22084080	-26.802352746	-58.957026617	Chaco
3221	Presidencia de la Plaza	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Presidencia de la Plaza	22119010	-26.998643135	-59.846377278	Chaco
3222	Colonia Benítez	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	1° de Mayo	22126020	-27.332600742	-58.94638942	Chaco
3223	Margarita Belén	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	1° de Mayo	22126030	-27.25905683	-58.97055474	Chaco
3224	Barranqueras	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	San Fernando	22140010	-27.485106066	-58.930736264	Chaco
3225	Basail	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	San Fernando	22140020	-27.887604312	-59.281472031	Chaco
3226	Colonia Baranda	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	San Fernando	22140030	-27.559706609	-59.307924279	Chaco
3227	Fontana	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	San Fernando	22140040	-27.420237403	-59.037391255	Chaco
3228	Puerto Vilelas	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	San Fernando	22140050	-27.510839145	-58.941715912	Chaco
3229	Resistencia	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	San Fernando	22140060	-27.451075711	-58.986483529	Chaco
3230	Capitán Solari	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Sargento Cabral	22154010	-26.802387809	-59.557083235	Chaco
3231	Colonia Elisa	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Sargento Cabral	22154020	-26.931635789	-59.518811427	Chaco
3232	Colonias Unidas	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Sargento Cabral	22154030	-26.698348379	-59.632210065	Chaco
3233	Ingeniero Barbet	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Sargento Cabral	22154040	-27.002424706	-59.482623088	Chaco
3234	Las Garcitas	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Sargento Cabral	22154050	-26.618067785	-59.799042317	Chaco
3235	Charadai	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Tapenagá	22161010	-27.652364422	-59.860350732	Chaco
3236	Cote Lai	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Tapenagá	22161020	-27.531429368	-59.575050061	Chaco
3237	Horquilla	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Tapenagá	22161040	-27.542386472	-59.955783014	Chaco
3238	La Sabana	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Tapenagá	22161050	-27.871450788	-59.936859222	Chaco
3239	Machagai	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	25 de Mayo	22168020	-26.926134761	-60.048419412	Chaco
3240	El Colorado	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Pirané	34056020	-26.309061021	-59.372308046	Formosa
3241	Florencia	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	General Obligado	82049060	-28.040631816	-59.218014756	Santa Fe
3242	El Rabón	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	General Obligado	82049050	-28.22117761	-59.264219897	Santa Fe
3243	Villa Guillermina	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	General Obligado	82049220	-28.244524353	-59.45148129	Santa Fe
3244	Los Amores	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Vera	82133100	-28.101820591	-59.977963605	Santa Fe
3245	Doctor Oscar Atilio Viglione (Frontera de Río Pico)	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Tehuelches	26098010	-44.191367335	-71.664220683	Chubut
3246	Gobernador Costa	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Tehuelches	26098020	-44.048706629	-70.599024094	Chubut
3247	José de San Martín	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Tehuelches	26098030	-44.051465314	-70.470741351	Chubut
3248	Río Pico	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Tehuelches	26098040	-44.179354878	-71.368318108	Chubut
3249	El Turbio	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Güer Aike	78021010	-51.680918613	-72.088496268	Santa Cruz
3250	Yacimientos Río Turbio	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Güer Aike	78021070	-51.53642264	-72.337854905	Santa Cruz
3251	28 de Noviembre	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Güer Aike	78021060	-51.579613896	-72.211640393	Santa Cruz
3252	Julia Dufour	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Güer Aike	78021020	-51.547287148	-72.239044068	Santa Cruz
3253	Rospentek	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Güer Aike	78021050	-51.66536592	-72.145472483	Santa Cruz
3254	El Chaltén	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Lago Argentino	78028020	-49.332824656	-72.88591142	Santa Cruz
3255	El Calafate	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Lago Argentino	78028010	-50.33802954	-72.260665242	Santa Cruz
3256	Tres Lagos	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Lago Argentino	78028030	-49.597910204	-71.44674679	Santa Cruz
3257	Los Antiguos	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Lago Buenos Aires	78035010	-46.551075658	-71.631270811	Santa Cruz
3258	Perito Moreno	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Lago Buenos Aires	78035020	-46.593816968	-70.929911675	Santa Cruz
3259	Bajo Caracoles	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Río Chico	78049010	-47.443172501	-70.926882673	Santa Cruz
3260	Hipólito Yrigoyen	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Río Chico	78049030	-47.565662519	-71.742848247	Santa Cruz
3261	Las Cuevas	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Las Heras	50049040	-32.813948303	-70.048955265	Mendoza
3262	Las Heras	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Las Heras	50049050	-32.850341602	-68.840520402	Mendoza
3263	Los Penitentes	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Las Heras	50049060	-32.841526856	-69.842273396	Mendoza
3264	Polvaredas	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Las Heras	50049080	-32.794879313	-69.653546415	Mendoza
3265	Punta de Vacas	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Las Heras	50049100	-32.855779882	-69.763214091	Mendoza
3266	Uspallata	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Las Heras	50049110	-32.591132849	-69.347832501	Mendoza
3267	Puente del Inca	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Las Heras	50049090	-32.824552649	-69.909969776	Mendoza
3268	Jocolí	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Las Heras	50049030	-32.587124197	-68.668678921	Mendoza
3269	Barrio La Palmera	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Lavalle	50056030	-32.701967698	-68.540094593	Mendoza
3270	El Paramillo	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Lavalle	50056090	-32.781222126	-68.533811174	Mendoza
3271	El Vergel	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Lavalle	50056100	-32.758805288	-68.634111889	Mendoza
3272	Jocolí Viejo	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Lavalle	50056130	-32.708159423	-68.673425058	Mendoza
3273	Jocolí	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Lavalle	50056120	-32.581214132	-68.665144701	Mendoza
3274	Barrio Lagunas de Bartoluzzi	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Lavalle	50056050	-32.612447974	-68.562233766	Mendoza
3275	Agrelo	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Luján de Cuyo	50063010	-33.120289001	-68.889120121	Mendoza
3276	Cacheuta	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Luján de Cuyo	50063030	-33.013145516	-69.118972855	Mendoza
3277	El Carrizal	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Luján de Cuyo	50063050	-33.319611322	-68.756545484	Mendoza
3278	El Salto	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Luján de Cuyo	50063060	-32.95974492	-69.264859585	Mendoza
3279	Las Vegas	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Luján de Cuyo	50063080	-33.014749232	-69.272245261	Mendoza
3280	Potrerillos	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Luján de Cuyo	50063110	-32.962320997	-69.201047146	Mendoza
3281	Las Compuertas	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Luján de Cuyo	50063070	-33.03742905	-68.98321446	Mendoza
3282	Barrio Jesús de Nazaret	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Maipú	50070020	-33.00956573	-68.716108548	Mendoza
3283	El Pedregal	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Maipú	50070040	-32.858496622	-68.64976573	Mendoza
3284	Fray Luis Beltrán	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Maipú	50070050	-33.003995979	-68.664451456	Mendoza
3285	Maipú	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Maipú	50070060	-32.984619782	-68.788209018	Mendoza
3286	Cruz de Piedra	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Maipú	50070030	-33.030244514	-68.780417039	Mendoza
3287	Barrio Rivadavia	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Rivadavia	50084030	-33.231606567	-68.476835912	Mendoza
3288	El Mirador	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Rivadavia	50084040	-33.290301023	-68.339314382	Mendoza
3289	La Esperanza	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Rivadavia	50084060	-33.320034681	-68.329795356	Mendoza
3290	La Florida	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Rivadavia	50084070	-33.265587337	-68.456515098	Mendoza
3291	La Libertad	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Rivadavia	50084080	-33.212266877	-68.507842267	Mendoza
3292	Los Árboles	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Rivadavia	50084090	-33.183249565	-68.566536678	Mendoza
3293	Mundo Nuevo	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Rivadavia	50084120	-33.175177714	-68.427608253	Mendoza
3294	La Central	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Rivadavia	50084050	-33.273166743	-68.315311998	Mendoza
3295	Barrio La Estación	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	San Martín	50098045	-33.154885983	-68.355539156	Mendoza
3296	El Espino	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	San Martín	50098073	-33.074887419	-68.39683195	Mendoza
3297	Nueva California	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	San Martín	50098090	-32.749518817	-68.324124205	Mendoza
3298	Tres Porteñas	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	San Martín	50098110	-32.899366465	-68.388554787	Mendoza
3299	Barrio María Auxiliadora	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Santa Rosa	50112020	-33.243945328	-68.173557957	Mendoza
3300	Cordón del Plata	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Tupungato	50126020	-33.462430458	-69.143259066	Mendoza
3301	La Arboleda	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Tupungato	50126040	-33.361460969	-69.119603114	Mendoza
3302	El Peral	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Tupungato	50126030	-33.367134456	-69.184087744	Mendoza
3303	Tupungato	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Tupungato	50126060	-33.372840907	-69.147574286	Mendoza
3304	Leandro N. Alem	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Ayacucho	74007030	-32.486256954	-66.053015683	San Luis
3305	San Francisco del Monte de Oro	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Ayacucho	74007070	-32.600346448	-66.127087551	San Luis
3306	Quines	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Ayacucho	74007050	-32.232855872	-65.805036686	San Luis
3307	Luján	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Ayacucho	74007040	-32.364571454	-65.93315791	San Luis
3308	Villa General Roca	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Belgrano	74014040	-32.665941391	-66.4507847	San Luis
3309	Carolina	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Coronel Pringles	74021010	-32.810802226	-66.091951945	San Luis
3310	Riocito	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Coronel Pringles	74021070	-33.094703889	-65.992817604	San Luis
3311	Fraga	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Coronel Pringles	74021030	-33.50208707	-65.792647779	San Luis
3312	Salinas del Bebedero	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Juan Martín de Pueyrredón	74056130	-33.501381895	-66.651458684	San Luis
3313	Jarilla	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Juan Martín de Pueyrredón	74056090	-33.396447543	-67.026578606	San Luis
3314	San Luis	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Juan Martín de Pueyrredón	74056150	-33.302086483	-66.336854574	San Luis
3315	Desaguadero	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Juan Martín de Pueyrredón	74056070	-33.406008872	-67.149399439	San Luis
3316	San Jerónimo	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Juan Martín de Pueyrredón	74056140	-33.138049293	-66.524025634	San Luis
3317	Chosmes	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Juan Martín de Pueyrredón	74056060	-33.403979611	-66.803550366	San Luis
3318	El Volcán	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Juan Martín de Pueyrredón	74056080	-33.253100147	-66.175161305	San Luis
3319	Juana Koslay	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Juan Martín de Pueyrredón	74056100	-33.288899331	-66.266635977	San Luis
3320	Balde	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Juan Martín de Pueyrredón	74056030	-33.341055433	-66.621697262	San Luis
3321	Villa de Praga	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Libertador General San Martín	74063080	-32.533336699	-65.64585986	San Luis
3322	Potrerillo	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Libertador General San Martín	74063060	-32.675558943	-65.649748362	San Luis
3323	San Martín	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Libertador General San Martín	74063070	-32.410603795	-65.675711642	San Luis
3324	La Vertiente	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Libertador General San Martín	74063010	-32.797109364	-65.756295301	San Luis
3325	Las Lagunas	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Libertador General San Martín	74063040	-32.628058077	-65.548598128	San Luis
3326	Las Chacras	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Libertador General San Martín	74063030	-32.562538171	-65.776902296	San Luis
3327	Achiras	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Río Cuarto	14098010	-33.174447162	-64.992061814	Córdoba
3328	Bulnes	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Río Cuarto	14098060	-33.505926178	-64.678218671	Córdoba
3329	Chaján	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Río Cuarto	14098070	-33.555629987	-65.002654735	Córdoba
3330	La Carolina	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Río Cuarto	14098120	-33.186844322	-64.72511288	Córdoba
3331	La Gilda	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Río Cuarto	14098140	-33.208161319	-64.258443992	Córdoba
3332	Las Higueras	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Río Cuarto	14098170	-33.089803876	-64.285362307	Córdoba
3333	Las Vertientes	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Río Cuarto	14098190	-33.28344479	-64.577712485	Córdoba
3334	Malena	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Río Cuarto	14098200	-33.490405582	-64.430878654	Córdoba
3335	Río Cuarto	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Río Cuarto	14098230	-33.123836934	-64.349003218	Córdoba
3336	Sampacho	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Río Cuarto	14098240	-33.384022758	-64.722878268	Córdoba
3337	San Basilio	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Río Cuarto	14098250	-33.498548484	-64.314731948	Córdoba
3338	Santa Catalina Holmberg	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Río Cuarto	14098260	-33.205189971	-64.437828682	Córdoba
3339	Suco	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Río Cuarto	14098270	-33.43999215	-64.830882263	Córdoba
3340	Naschel	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Chacabuco	74028030	-32.915223033	-65.375927714	San Luis
3341	Tilisarao	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Chacabuco	74028070	-32.731249918	-65.291340689	San Luis
3342	Villa Larca	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Chacabuco	74028090	-32.617444091	-64.981461227	San Luis
3343	San Pablo	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Chacabuco	74028060	-32.661195937	-65.305583691	San Luis
3344	Renca	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Chacabuco	74028050	-32.771591331	-65.364468835	San Luis
3345	Juan Jorba	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	General Pedernera	74035010	-33.613170493	-65.272184931	San Luis
3346	La Punilla	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	General Pedernera	74035040	-33.143884065	-65.090057009	San Luis
3347	Ciudad de Buenos Aires	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Comuna 2	02014010	-34.608416378	-58.372134681	Ciudad Autónoma de Buenos Aires
3348	Río Grande	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Río Grande	94008010	-53.786326089	-67.696328136	Tierra del Fuego, Antártida e Islas del Atlántico Sur
3349	Ushuaia	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Ushuaia	94015020	-54.807403982	-68.303757178	Tierra del Fuego, Antártida e Islas del Atlántico Sur
3350	Laguna Escondida	2026-11-08 23:05:59.786	2026-11-08 23:05:59.786	Ushuaia	94015010	-54.640783266	-67.762904529	Tierra del Fuego, Antártida e Islas del Atlántico Sur
\.


--
-- Data for Name: Pabellon; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Pabellon" (id_pabellon, numero, nombre, descripcion, created_at, updated_at) FROM stdin;
1	1	Pabellón Peregrina Zárate	Pabellón central de artesanos textiles y tradicionales	2026-11-08 23:05:23.896	2026-11-08 23:05:23.896
\.


--
-- Data for Name: Producto; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Producto" (id_producto, id_artesano, id_categoria, nombre, descripcion, precio, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: Rol; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Rol" (id_rol, nombre, descripcion, created_at, updated_at) FROM stdin;
1	Postulante	Usuario registrado o postulante pendiente de evaluación	2026-11-08 23:05:23.879	2026-11-08 23:05:23.879
2	Administrador	Administrador general de la plataforma Poncho Digital	2026-11-08 23:05:23.882	2026-11-08 23:05:23.882
3	Artesano	Artesano aprobado y habilitado para publicar productos	2026-11-08 23:05:23.883	2026-11-08 23:05:23.883
\.


--
-- Data for Name: Rubro; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Rubro" (id_rubro, nombre, descripcion, created_at, updated_at) FROM stdin;
1	Textil	Tejidos tradicionales en fibra de vicuña, llama y oveja	2026-11-08 23:05:23.885	2026-11-08 23:05:23.885
2	Cerámica	Alfarería y cerámica arqueológica y contemporánea	2026-11-08 23:05:23.887	2026-11-08 23:05:23.887
3	Cestería y Fibra Vegetal	Tejidos en simbol, palma y totora	2026-11-08 23:05:23.888	2026-11-08 23:05:23.888
4	Orfebrería y Platería	Joyería en plata, alpaca y rodocrosita	2026-11-08 23:05:23.889	2026-11-08 23:05:23.889
5	Cuero y Talabartería	Trabajos tradicionales en cuero crudo y curtido	2026-11-08 23:05:23.89	2026-11-08 23:05:23.89
\.


--
-- Data for Name: Solicitud; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Solicitud" (id_solicitud, id_artesano, estado, motivo_rechazo, observaciones, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: Stand; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Stand" (id_stand, id_zona, numero, descripcion, created_at, updated_at) FROM stdin;
1	1	101	Stand artesanal N° 101	2026-11-08 23:05:23.901	2026-11-08 23:05:23.901
2	1	102	Stand artesanal N° 102	2026-11-08 23:05:23.903	2026-11-08 23:05:23.903
3	1	103	Stand artesanal N° 103	2026-11-08 23:05:23.904	2026-11-08 23:05:23.904
4	1	104	Stand artesanal N° 104	2026-11-08 23:05:23.904	2026-11-08 23:05:23.904
5	1	105	Stand artesanal N° 105	2026-11-08 23:05:23.905	2026-11-08 23:05:23.905
\.


--
-- Data for Name: TokenRevocado; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."TokenRevocado" (jti, "venceEn", "createdAt") FROM stdin;
\.


--
-- Data for Name: Usuario; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Usuario" (id_usuario, email, "passwordHash", id_rol, created_at, updated_at, nombre, activo) FROM stdin;
315c66fe-7daf-4c8b-b3d3-7532dd0b2b87	admin@ponchodigital.gob.ar	$2b$10$Cqgm39h9MzZjnHGP3Oldr.Rkwi7RZuoT7/DsoLIwq7vexHtMxyuI.	2	2026-11-08 23:05:23.964	2026-11-08 23:05:23.964	Administrador Poncho Digital	t
\.


--
-- Data for Name: Zona; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Zona" (id_zona, id_pabellon, numero, nombre, descripcion, created_at, updated_at) FROM stdin;
1	1	1	Sector Norte - Textil	Sector destinado a tejedores tradicionales	2026-11-08 23:05:23.899	2026-11-08 23:05:23.899
\.


--
-- Data for Name: _prisma_migrations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) FROM stdin;
d1cdd9b7-48e7-460f-9e7f-4f9afd02362a	22e4be4721324c9fd39b7cfc51bc2a864a0156faf1f4fbb13715694250030428	2026-11-08 20:04:34.722824-03	20261001234238_init	\N	\N	2026-11-08 20:04:34.658544-03	1
2d750663-3c37-4b17-98c8-c2b13417bdfa	7d9018f1f2b7eca0de4f766133cac9b0568db06751648552fb7dd906b2adf342	2026-11-08 20:04:34.728313-03	20261015000553_agregar_tokens_revocados	\N	\N	2026-11-08 20:04:34.72328-03	1
32149aaf-e145-4a4e-ae74-a2d90741037f	7d24e1796b622c200137c370dbd8e3e5836cab0561a76b7cdcbd2304d3024bab	2026-11-08 20:04:34.730317-03	20261015004809_add_nombre_usuario_and_token_revocado	\N	\N	2026-11-08 20:04:34.728825-03	1
1289f838-42aa-40bb-8702-a82e5b57cc17	7410ba4ed4eecc445adf2d12fdc0513c9b5282c840a3b0679bfc4c47baa0ad90	2026-11-08 20:04:34.732401-03	20261015004923_make_nombre_required	\N	\N	2026-11-08 20:04:34.730804-03	1
1b8e6293-5d20-47c1-b5e7-79048a10775e	c168e817ccfebdf28da0650b37cac7be4dedba51d80693c5cd4f96049b76b8b4	2026-11-08 20:04:34.741889-03	20261026214352_add_activo_and_solicitud	\N	\N	2026-11-08 20:04:34.732854-03	1
4e51560e-b0f9-4665-88a9-f7326194bc02	109cc24271497a1b1aaaa65404d57f9a03b4f93755af641c4d67b734d6b866b5	2026-11-08 20:04:34.746888-03	20261108082800_agregar_catalogo_georef_localidades	\N	\N	2026-11-08 20:04:34.742267-03	1
\.


--
-- Name: Artesano_id_artesano_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."Artesano_id_artesano_seq"', 1, false);


--
-- Name: Categoria_id_categoria_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."Categoria_id_categoria_seq"', 4, true);


--
-- Name: Inscripcion_id_inscripcion_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."Inscripcion_id_inscripcion_seq"', 1, false);


--
-- Name: Localidad_id_localidad_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."Localidad_id_localidad_seq"', 3350, true);


--
-- Name: Pabellon_id_pabellon_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."Pabellon_id_pabellon_seq"', 1, true);


--
-- Name: Producto_id_producto_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."Producto_id_producto_seq"', 1, false);


--
-- Name: Rol_id_rol_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."Rol_id_rol_seq"', 3, true);


--
-- Name: Rubro_id_rubro_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."Rubro_id_rubro_seq"', 5, true);


--
-- Name: Solicitud_id_solicitud_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."Solicitud_id_solicitud_seq"', 1, false);


--
-- Name: Stand_id_stand_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."Stand_id_stand_seq"', 5, true);


--
-- Name: Zona_id_zona_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."Zona_id_zona_seq"', 1, true);


--
-- Name: Artesano Artesano_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Artesano"
    ADD CONSTRAINT "Artesano_pkey" PRIMARY KEY (id_artesano);


--
-- Name: Categoria Categoria_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Categoria"
    ADD CONSTRAINT "Categoria_pkey" PRIMARY KEY (id_categoria);


--
-- Name: Inscripcion Inscripcion_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Inscripcion"
    ADD CONSTRAINT "Inscripcion_pkey" PRIMARY KEY (id_inscripcion);


--
-- Name: Localidad Localidad_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Localidad"
    ADD CONSTRAINT "Localidad_pkey" PRIMARY KEY (id_localidad);


--
-- Name: Pabellon Pabellon_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Pabellon"
    ADD CONSTRAINT "Pabellon_pkey" PRIMARY KEY (id_pabellon);


--
-- Name: Producto Producto_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Producto"
    ADD CONSTRAINT "Producto_pkey" PRIMARY KEY (id_producto);


--
-- Name: Rol Rol_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Rol"
    ADD CONSTRAINT "Rol_pkey" PRIMARY KEY (id_rol);


--
-- Name: Rubro Rubro_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Rubro"
    ADD CONSTRAINT "Rubro_pkey" PRIMARY KEY (id_rubro);


--
-- Name: Solicitud Solicitud_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Solicitud"
    ADD CONSTRAINT "Solicitud_pkey" PRIMARY KEY (id_solicitud);


--
-- Name: Stand Stand_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Stand"
    ADD CONSTRAINT "Stand_pkey" PRIMARY KEY (id_stand);


--
-- Name: TokenRevocado TokenRevocado_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."TokenRevocado"
    ADD CONSTRAINT "TokenRevocado_pkey" PRIMARY KEY (jti);


--
-- Name: Usuario Usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Usuario"
    ADD CONSTRAINT "Usuario_pkey" PRIMARY KEY (id_usuario);


--
-- Name: Zona Zona_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Zona"
    ADD CONSTRAINT "Zona_pkey" PRIMARY KEY (id_zona);


--
-- Name: _prisma_migrations _prisma_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);


--
-- Name: Artesano_dni_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "Artesano_dni_key" ON public."Artesano" USING btree (dni);


--
-- Name: Artesano_id_usuario_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "Artesano_id_usuario_key" ON public."Artesano" USING btree (id_usuario);


--
-- Name: Localidad_departamento_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "Localidad_departamento_idx" ON public."Localidad" USING btree (departamento);


--
-- Name: Localidad_id_georef_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "Localidad_id_georef_key" ON public."Localidad" USING btree (id_georef);


--
-- Name: Localidad_nombre_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "Localidad_nombre_idx" ON public."Localidad" USING btree (nombre);


--
-- Name: Localidad_provincia_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "Localidad_provincia_idx" ON public."Localidad" USING btree (provincia);


--
-- Name: Usuario_email_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "Usuario_email_key" ON public."Usuario" USING btree (email);


--
-- Name: Artesano Artesano_id_localidad_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Artesano"
    ADD CONSTRAINT "Artesano_id_localidad_fkey" FOREIGN KEY (id_localidad) REFERENCES public."Localidad"(id_localidad) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Artesano Artesano_id_rubro_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Artesano"
    ADD CONSTRAINT "Artesano_id_rubro_fkey" FOREIGN KEY (id_rubro) REFERENCES public."Rubro"(id_rubro) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Artesano Artesano_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Artesano"
    ADD CONSTRAINT "Artesano_id_usuario_fkey" FOREIGN KEY (id_usuario) REFERENCES public."Usuario"(id_usuario) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Inscripcion Inscripcion_id_artesano_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Inscripcion"
    ADD CONSTRAINT "Inscripcion_id_artesano_fkey" FOREIGN KEY (id_artesano) REFERENCES public."Artesano"(id_artesano) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Inscripcion Inscripcion_id_stand_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Inscripcion"
    ADD CONSTRAINT "Inscripcion_id_stand_fkey" FOREIGN KEY (id_stand) REFERENCES public."Stand"(id_stand) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Producto Producto_id_artesano_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Producto"
    ADD CONSTRAINT "Producto_id_artesano_fkey" FOREIGN KEY (id_artesano) REFERENCES public."Artesano"(id_artesano) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Producto Producto_id_categoria_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Producto"
    ADD CONSTRAINT "Producto_id_categoria_fkey" FOREIGN KEY (id_categoria) REFERENCES public."Categoria"(id_categoria) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Solicitud Solicitud_id_artesano_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Solicitud"
    ADD CONSTRAINT "Solicitud_id_artesano_fkey" FOREIGN KEY (id_artesano) REFERENCES public."Artesano"(id_artesano) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Stand Stand_id_zona_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Stand"
    ADD CONSTRAINT "Stand_id_zona_fkey" FOREIGN KEY (id_zona) REFERENCES public."Zona"(id_zona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Usuario Usuario_id_rol_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Usuario"
    ADD CONSTRAINT "Usuario_id_rol_fkey" FOREIGN KEY (id_rol) REFERENCES public."Rol"(id_rol) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Zona Zona_id_pabellon_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Zona"
    ADD CONSTRAINT "Zona_id_pabellon_fkey" FOREIGN KEY (id_pabellon) REFERENCES public."Pabellon"(id_pabellon) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- PostgreSQL database dump complete
--

\unrestrict CPH9Y05PeSdTIddbws5QPXwdgeGeJCb0D37fL3mct0WgBClM5k3Qo8foOzmkwYM

