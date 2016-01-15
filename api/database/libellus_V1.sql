--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.0
-- Dumped by pg_dump version 9.5.0

-- Started on 2016-01-15 09:33:16

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 186 (class 3079 OID 12355)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2133 (class 0 OID 0)
-- Dependencies: 186
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 185 (class 1259 OID 24622)
-- Name: class; Type: TABLE; Schema: public; Owner: postgres
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
    "time" character varying(100),
    days character varying(100),
    open boolean,
    total_capacity integer,
    section character varying(50)[],
    wait_list integer
);


ALTER TABLE class OWNER TO postgres;

--
-- TOC entry 184 (class 1259 OID 24620)
-- Name: class_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE class_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE class_id_seq OWNER TO postgres;

--
-- TOC entry 2134 (class 0 OID 0)
-- Dependencies: 184
-- Name: class_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE class_id_seq OWNED BY class.id;


--
-- TOC entry 183 (class 1259 OID 24593)
-- Name: subject; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE subject (
    id integer NOT NULL,
    name character varying(100),
    code character varying(50)
);


ALTER TABLE subject OWNER TO postgres;

--
-- TOC entry 182 (class 1259 OID 24591)
-- Name: subject_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE subject_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE subject_id_seq OWNER TO postgres;

--
-- TOC entry 2135 (class 0 OID 0)
-- Dependencies: 182
-- Name: subject_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE subject_id_seq OWNED BY subject.id;


--
-- TOC entry 181 (class 1259 OID 24580)
-- Name: teacher; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE teacher (
    id integer NOT NULL,
    name character varying(100),
    rate numeric,
    rate_link character varying(100)
);


ALTER TABLE teacher OWNER TO postgres;

--
-- TOC entry 180 (class 1259 OID 24578)
-- Name: teacher_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE teacher_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE teacher_id_seq OWNER TO postgres;

--
-- TOC entry 2136 (class 0 OID 0)
-- Dependencies: 180
-- Name: teacher_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE teacher_id_seq OWNED BY teacher.id;


--
-- TOC entry 1997 (class 2604 OID 24625)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY class ALTER COLUMN id SET DEFAULT nextval('class_id_seq'::regclass);


--
-- TOC entry 1996 (class 2604 OID 24596)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY subject ALTER COLUMN id SET DEFAULT nextval('subject_id_seq'::regclass);


--
-- TOC entry 1995 (class 2604 OID 24583)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY teacher ALTER COLUMN id SET DEFAULT nextval('teacher_id_seq'::regclass);


--
-- TOC entry 2125 (class 0 OID 24622)
-- Dependencies: 185
-- Data for Name: class; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY class (id, fk_teacher, fk_subject, code, name, number, enrollment, room, description, "time", days, open, total_capacity, section, wait_list) FROM stdin;
\.


--
-- TOC entry 2137 (class 0 OID 0)
-- Dependencies: 184
-- Name: class_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('class_id_seq', 1, false);


--
-- TOC entry 2123 (class 0 OID 24593)
-- Dependencies: 183
-- Data for Name: subject; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY subject (id, name, code) FROM stdin;
\.


--
-- TOC entry 2138 (class 0 OID 0)
-- Dependencies: 182
-- Name: subject_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('subject_id_seq', 1, false);


--
-- TOC entry 2121 (class 0 OID 24580)
-- Dependencies: 181
-- Data for Name: teacher; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY teacher (id, name, rate, rate_link) FROM stdin;
\.


--
-- TOC entry 2139 (class 0 OID 0)
-- Dependencies: 180
-- Name: teacher_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('teacher_id_seq', 1, false);


--
-- TOC entry 2003 (class 2606 OID 24630)
-- Name: class_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY class
    ADD CONSTRAINT class_pkey PRIMARY KEY (id);


--
-- TOC entry 2001 (class 2606 OID 24598)
-- Name: subject_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY subject
    ADD CONSTRAINT subject_pkey PRIMARY KEY (id);


--
-- TOC entry 1999 (class 2606 OID 24588)
-- Name: teacher_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY teacher
    ADD CONSTRAINT teacher_pkey PRIMARY KEY (id);


--
-- TOC entry 2005 (class 2606 OID 24636)
-- Name: class_fk_subject_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY class
    ADD CONSTRAINT class_fk_subject_fkey FOREIGN KEY (fk_subject) REFERENCES subject(id);


--
-- TOC entry 2004 (class 2606 OID 24631)
-- Name: class_fk_teacher_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY class
    ADD CONSTRAINT class_fk_teacher_fkey FOREIGN KEY (fk_teacher) REFERENCES teacher(id);


--
-- TOC entry 2132 (class 0 OID 0)
-- Dependencies: 5
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2016-01-15 09:33:16

--
-- PostgreSQL database dump complete
--

