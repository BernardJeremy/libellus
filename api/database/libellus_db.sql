--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

ALTER TABLE ONLY public.schedule DROP CONSTRAINT schedule_fk_class_fkey;
ALTER TABLE ONLY public.class DROP CONSTRAINT class_fk_term_fkey;
ALTER TABLE ONLY public.class DROP CONSTRAINT class_fk_teacher_fkey;
ALTER TABLE ONLY public.class DROP CONSTRAINT class_fk_subject_fkey;
ALTER TABLE ONLY public.term DROP CONSTRAINT term_pkey;
ALTER TABLE ONLY public.teacher DROP CONSTRAINT teacher_pkey;
ALTER TABLE ONLY public.subject DROP CONSTRAINT subject_pkey;
ALTER TABLE ONLY public.schedule DROP CONSTRAINT schedule_pkey;
ALTER TABLE ONLY public.class DROP CONSTRAINT class_pkey;
ALTER TABLE public.term ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.teacher ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.subject ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.schedule ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.class ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE public.term_id_seq;
DROP TABLE public.term;
DROP SEQUENCE public.teacher_id_seq;
DROP TABLE public.teacher;
DROP SEQUENCE public.subject_id_seq;
DROP TABLE public.subject;
DROP SEQUENCE public.schedule_id_seq;
DROP TABLE public.schedule;
DROP SEQUENCE public.class_id_seq;
DROP TABLE public.class;
DROP EXTENSION plpgsql;
DROP SCHEMA public;
--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: class; Type: TABLE; Schema: public; Owner: dev; Tablespace: 
--

CREATE TABLE class (
    id integer NOT NULL,
    fk_teacher integer,
    fk_subject integer,
    code integer,
    name character varying(100),
    number integer,
    enrollment integer,
    room character varying(100),
    description text,
    open boolean,
    total_capacity integer,
    section text,
    wait_list integer,
    fk_term integer
);


ALTER TABLE class OWNER TO dev;

--
-- Name: class_id_seq; Type: SEQUENCE; Schema: public; Owner: dev
--

CREATE SEQUENCE class_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE class_id_seq OWNER TO dev;

--
-- Name: class_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dev
--

ALTER SEQUENCE class_id_seq OWNED BY class.id;


--
-- Name: schedule; Type: TABLE; Schema: public; Owner: dev; Tablespace: 
--

CREATE TABLE schedule (
    id integer NOT NULL,
    day character(3),
    start character(5),
    finish character(5),
    fk_class integer NOT NULL
);


ALTER TABLE schedule OWNER TO dev;

--
-- Name: schedule_id_seq; Type: SEQUENCE; Schema: public; Owner: dev
--

CREATE SEQUENCE schedule_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE schedule_id_seq OWNER TO dev;

--
-- Name: schedule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dev
--

ALTER SEQUENCE schedule_id_seq OWNED BY schedule.id;


--
-- Name: subject; Type: TABLE; Schema: public; Owner: dev; Tablespace: 
--

CREATE TABLE subject (
    id integer NOT NULL,
    name character varying(100),
    code character varying(50)
);


ALTER TABLE subject OWNER TO dev;

--
-- Name: subject_id_seq; Type: SEQUENCE; Schema: public; Owner: dev
--

CREATE SEQUENCE subject_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE subject_id_seq OWNER TO dev;

--
-- Name: subject_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dev
--

ALTER SEQUENCE subject_id_seq OWNED BY subject.id;


--
-- Name: teacher; Type: TABLE; Schema: public; Owner: dev; Tablespace: 
--

CREATE TABLE teacher (
    id integer NOT NULL,
    name character varying(100),
    rate numeric,
    rate_link character varying(100)
);


ALTER TABLE teacher OWNER TO dev;

--
-- Name: teacher_id_seq; Type: SEQUENCE; Schema: public; Owner: dev
--

CREATE SEQUENCE teacher_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE teacher_id_seq OWNER TO dev;

--
-- Name: teacher_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dev
--

ALTER SEQUENCE teacher_id_seq OWNED BY teacher.id;


--
-- Name: term; Type: TABLE; Schema: public; Owner: dev; Tablespace: 
--

CREATE TABLE term (
    id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE term OWNER TO dev;

--
-- Name: term_id_seq; Type: SEQUENCE; Schema: public; Owner: dev
--

CREATE SEQUENCE term_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE term_id_seq OWNER TO dev;

--
-- Name: term_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dev
--

ALTER SEQUENCE term_id_seq OWNED BY term.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: dev
--

ALTER TABLE ONLY class ALTER COLUMN id SET DEFAULT nextval('class_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: dev
--

ALTER TABLE ONLY schedule ALTER COLUMN id SET DEFAULT nextval('schedule_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: dev
--

ALTER TABLE ONLY subject ALTER COLUMN id SET DEFAULT nextval('subject_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: dev
--

ALTER TABLE ONLY teacher ALTER COLUMN id SET DEFAULT nextval('teacher_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: dev
--

ALTER TABLE ONLY term ALTER COLUMN id SET DEFAULT nextval('term_id_seq'::regclass);


--
-- Data for Name: class; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY class (id, fk_teacher, fk_subject, code, name, number, enrollment, room, description, open, total_capacity, section, wait_list, fk_term) FROM stdin;
1	1	1	328	Operating System	2564	14	VEC-115	Some explanation about system call and OS management	t	21	SEM001	0	1
2	1	1	328	Operating System	2564	14	VEC-115	Some explanation about system call and OS management	t	21	\N	0	2
\.


--
-- Name: class_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dev
--

SELECT pg_catalog.setval('class_id_seq', 2, true);


--
-- Data for Name: schedule; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY schedule (id, day, start, finish, fk_class) FROM stdin;
6	FRY	10:00	12:15	2
2	MON	10:30	12:30	1
3	WED	15:00	18:15	1
\.


--
-- Name: schedule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dev
--

SELECT pg_catalog.setval('schedule_id_seq', 6, true);


--
-- Data for Name: subject; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY subject (id, name, code) FROM stdin;
1	Computer Eng & Computer Sci	CECS
2	American Language Institute	ALI
3	Econnomics	ECON
\.


--
-- Name: subject_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dev
--

SELECT pg_catalog.setval('subject_id_seq', 3, true);


--
-- Data for Name: teacher; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY teacher (id, name, rate, rate_link) FROM stdin;
1	Brian Velasquez	4.2	https://www.ratemyprofessors.com
2	Sivir Johnson	2.8	https://www.ratemyprofessors.com
\.


--
-- Name: teacher_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dev
--

SELECT pg_catalog.setval('teacher_id_seq', 2, true);


--
-- Data for Name: term; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY term (id, name) FROM stdin;
1	Spring 2016
2	Winter 2016
\.


--
-- Name: term_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dev
--

SELECT pg_catalog.setval('term_id_seq', 2, true);


--
-- Name: class_pkey; Type: CONSTRAINT; Schema: public; Owner: dev; Tablespace: 
--

ALTER TABLE ONLY class
    ADD CONSTRAINT class_pkey PRIMARY KEY (id);


--
-- Name: schedule_pkey; Type: CONSTRAINT; Schema: public; Owner: dev; Tablespace: 
--

ALTER TABLE ONLY schedule
    ADD CONSTRAINT schedule_pkey PRIMARY KEY (id);


--
-- Name: subject_pkey; Type: CONSTRAINT; Schema: public; Owner: dev; Tablespace: 
--

ALTER TABLE ONLY subject
    ADD CONSTRAINT subject_pkey PRIMARY KEY (id);


--
-- Name: teacher_pkey; Type: CONSTRAINT; Schema: public; Owner: dev; Tablespace: 
--

ALTER TABLE ONLY teacher
    ADD CONSTRAINT teacher_pkey PRIMARY KEY (id);


--
-- Name: term_pkey; Type: CONSTRAINT; Schema: public; Owner: dev; Tablespace: 
--

ALTER TABLE ONLY term
    ADD CONSTRAINT term_pkey PRIMARY KEY (id);


--
-- Name: class_fk_subject_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY class
    ADD CONSTRAINT class_fk_subject_fkey FOREIGN KEY (fk_subject) REFERENCES subject(id);


--
-- Name: class_fk_teacher_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY class
    ADD CONSTRAINT class_fk_teacher_fkey FOREIGN KEY (fk_teacher) REFERENCES teacher(id);


--
-- Name: class_fk_term_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY class
    ADD CONSTRAINT class_fk_term_fkey FOREIGN KEY (fk_term) REFERENCES term(id);


--
-- Name: schedule_fk_class_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY schedule
    ADD CONSTRAINT schedule_fk_class_fkey FOREIGN KEY (fk_class) REFERENCES class(id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

