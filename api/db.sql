--
-- libellus_apiQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

DROP DATABASE libellus;
--
-- Name: libellus; Type: DATABASE; Schema: -; Owner: geekuillaume
--

CREATE DATABASE libellus WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8';


ALTER DATABASE libellus OWNER TO libellus_api;

\connect libellus

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: libellus_api
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO libellus_api;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: libellus_api
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
-- Name: classes; Type: TABLE; Schema: public; Owner: libellus_api; Tablespace:
--

CREATE TABLE classes (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    code character varying(255) NOT NULL,
    slot character varying(255) NOT NULL,
    room character varying(255),
    section character varying(255),
    "time" json,
    description text,
    enrollment integer,
    capacity integer,
    "detailsUpdatedAt" timestamp with time zone,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    "subjectId" integer,
    "teacherId" integer,
    "termId" integer
);


ALTER TABLE classes OWNER TO libellus_api;

--
-- Name: classes_id_seq; Type: SEQUENCE; Schema: public; Owner: libellus_api
--

CREATE SEQUENCE classes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE classes_id_seq OWNER TO libellus_api;

--
-- Name: classes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: libellus_api
--

ALTER SEQUENCE classes_id_seq OWNED BY classes.id;


--
-- Name: subjects; Type: TABLE; Schema: public; Owner: libellus_api; Tablespace:
--

CREATE TABLE subjects (
    id integer NOT NULL,
    name character varying(255),
    code character varying(255),
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE subjects OWNER TO libellus_api;

--
-- Name: subjects_id_seq; Type: SEQUENCE; Schema: public; Owner: libellus_api
--

CREATE SEQUENCE subjects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE subjects_id_seq OWNER TO libellus_api;

--
-- Name: subjects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: libellus_api
--

ALTER SEQUENCE subjects_id_seq OWNED BY subjects.id;


--
-- Name: teachers; Type: TABLE; Schema: public; Owner: libellus_api; Tablespace:
--

CREATE TABLE teachers (
    id integer NOT NULL,
    name character varying(255),
    rate double precision,
    "rateLink" character varying(255),
    "rateLastUpdated" timestamp with time zone,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE teachers OWNER TO libellus_api;

--
-- Name: teachers_id_seq; Type: SEQUENCE; Schema: public; Owner: libellus_api
--

CREATE SEQUENCE teachers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE teachers_id_seq OWNER TO libellus_api;

--
-- Name: teachers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: libellus_api
--

ALTER SEQUENCE teachers_id_seq OWNED BY teachers.id;


--
-- Name: terms; Type: TABLE; Schema: public; Owner: libellus_api; Tablespace:
--

CREATE TABLE terms (
    id integer NOT NULL,
    name character varying(255),
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE terms OWNER TO libellus_api;

--
-- Name: terms_id_seq; Type: SEQUENCE; Schema: public; Owner: libellus_api
--

CREATE SEQUENCE terms_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE terms_id_seq OWNER TO libellus_api;

--
-- Name: terms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: libellus_api
--

ALTER SEQUENCE terms_id_seq OWNED BY terms.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: libellus_api
--

ALTER TABLE ONLY classes ALTER COLUMN id SET DEFAULT nextval('classes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: libellus_api
--

ALTER TABLE ONLY subjects ALTER COLUMN id SET DEFAULT nextval('subjects_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: libellus_api
--

ALTER TABLE ONLY teachers ALTER COLUMN id SET DEFAULT nextval('teachers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: libellus_api
--

ALTER TABLE ONLY terms ALTER COLUMN id SET DEFAULT nextval('terms_id_seq'::regclass);


--
-- Data for Name: classes; Type: TABLE DATA; Schema: public; Owner: libellus_api
--

COPY classes (id, name, code, slot, room, section, "time", description, enrollment, capacity, "detailsUpdatedAt", "createdAt", "updatedAt", "subjectId", "teacherId", "termId") FROM stdin;
18	Beginning Web Design	110	2792	ECS  Room 404	01-SEM	[{"day":"Mon","start":"09:00","end":"09:50"}]	Introduction to HTML and CSS using modern tools, following the W3C guidelines for coding. Web sites designed with usability and accessibility principles implemented. Overview of graphics, video, sound, JavaScript and Dreamweaver.\nLetter grade only (A-F). (Lecture 2 hours, laboratory 3 hours).\t\nEffective Spring 2012.	24	25	2016-01-17 17:54:44.4-08	2016-01-17 17:53:03.935-08	2016-01-17 20:03:53.489-08	1	6	1
21	Introduction to Programming and Problem Solving	174	8199	ECS  Room 413	16-LAB	[{"day":"Tue","start":"19:00","end":"20:15"},{"day":"Thu","start":"19:00","end":"20:15"}]	Prerequisites:  CECS 100 and MATH 113 (or equivalent) with a grade of "C" or better .\nIntroduction to basic concepts of computer science and fundamental techniques for solving problems using the Java programming language. Structured problem solving, object-oriented programming, programming style. Applications to numerical and non-numerical problems. \nLetter grade only (A-F). (Lecture 2 hours, laboratory 3 hours.) \nEffective Fall 2012.	20	25	2016-01-17 17:55:01.512-08	2016-01-17 17:53:03.939-08	2016-01-17 20:03:53.49-08	1	7	1
24	Computer Logic Design I	201	5425	VEC  Room 330	05-SEM	[{"day":"Fri","start":"08:00","end":"09:40"}]	Prerequisite: MATH 113 or equivalent with a grade of "C" or better .\nBasic topics in combinational and sequential switching circuits with applications to the design of digital libellus_apiices.  Introduction to Electronic Design Automation (EDA) tools. Laboratory projects with Field Programmable Gate Arrays (FPGA).(Lecture 2 hours, lab 3 hours.) Letter grade only (A-F).  \nEffective Fall 2012.	20	25	2016-01-17 17:55:21.226-08	2016-01-17 17:53:03.941-08	2016-01-17 20:03:53.49-08	1	9	1
25	Computer Logic Design I	201	5426	ECS  Room 411	06-LAB	[{"day":"Fri","start":"10:00","end":"12:30"}]	Prerequisite: MATH 113 or equivalent with a grade of "C" or better .\nBasic topics in combinational and sequential switching circuits with applications to the design of digital libellus_apiices.  Introduction to Electronic Design Automation (EDA) tools. Laboratory projects with Field Programmable Gate Arrays (FPGA).(Lecture 2 hours, lab 3 hours.) Letter grade only (A-F).  \nEffective Fall 2012.	20	25	2016-01-17 18:02:04.292-08	2016-01-17 17:53:03.942-08	2016-01-17 20:03:53.49-08	1	9	1
29	Computer Logic Design I	201	8201	ECS  Room 412	14-LAB	[{"day":"Mon","start":"18:00","end":"19:15"},{"day":"Wed","start":"18:00","end":"19:15"}]	Prerequisite: MATH 113 or equivalent with a grade of "C" or better .\nBasic topics in combinational and sequential switching circuits with applications to the design of digital libellus_apiices.  Introduction to Electronic Design Automation (EDA) tools. Laboratory projects with Field Programmable Gate Arrays (FPGA).(Lecture 2 hours, lab 3 hours.) Letter grade only (A-F).  \nEffective Fall 2012.	21	25	2016-01-17 18:02:28.847-08	2016-01-17 17:53:03.947-08	2016-01-17 20:03:53.491-08	1	11	1
32	Discrete Structures with Computing Applications	228	8205	ECS  Room 413	08-LAB	[{"day":"Tue","start":"20:30","end":"21:45"},{"day":"Thu","start":"20:30","end":"21:45"}]	Prerequisites:  CECS 174 and MATH 113 or equivalent with a grade of "C" or better .\nAn introduction to discrete mathematics with applications towards computing. Topics include sets, functions, logic, relations, graphs, trees, recursion, combinatorics, and mathematical reasoning. \nLetter grade only (A-F). (Lecture 2 hours, laboratory/problem session 3 hours.)  Effective Fall 2012.	13	25	2016-01-17 18:02:47.543-08	2016-01-17 17:53:03.95-08	2016-01-17 20:03:53.491-08	1	12	1
34	Discrete Structures with Computing Applications II	229	10198	ECS  Room 403	04-LAB	[{"day":"Mon","start":"18:00","end":"19:15"},{"day":"Wed","start":"18:00","end":"19:15"}]	Prerequisites: MATH 123 and CECS 228 both with a Grade of "C" or better\nThis is the second course in a two-course sequence in computing applications of discrete structures. Topics include applications of computer arithmetic and matrices in computer systems. Programming assignments in Python will be provided. \nLetter grade only (A-F). (Lecture 2 hours, Laboratory 3 hours)	23	25	2016-01-17 18:08:18.021-08	2016-01-17 17:53:03.951-08	2016-01-17 20:03:53.492-08	1	5	1
35	Discrete Structures with Computing Applications II	229	10840	ECS  Room 204	07-SEM	[{"day":"Mon","start":"15:00","end":"15:50"},{"day":"Wed","start":"15:00","end":"15:50"}]	Prerequisites: MATH 123 and CECS 228 both with a Grade of "C" or better\nThis is the second course in a two-course sequence in computing applications of discrete structures. Topics include applications of computer arithmetic and matrices in computer systems. Programming assignments in Python will be provided. \nLetter grade only (A-F). (Lecture 2 hours, Laboratory 3 hours)	8	25	2016-01-17 18:08:24.3-08	2016-01-17 17:53:03.951-08	2016-01-17 20:03:53.492-08	1	13	1
119	Advanced Operating Systems	626	6812	SPA  Room 109	02-SEM	[{"day":"Tue","start":"17:00","end":"18:15"},{"day":"Thu","start":"17:00","end":"18:15"}]	Prerequisites: CECS 228 and 326 with a grade of "C" or better.\nTheoretical foundations of concepts applied in the design of operating systems. Control of concurrent processes, deadlocks, mutual exclusion, virtual memory, resource management and scheduling. \nMaster's students register in CECS 526 or 626; Ph.D. students register in CECS 626. Additional projects required for CECS 626. (Lecture-problems 3 hours.) Letter grade only (A-F).  Effective Fall 2012.	25	48	2016-01-17 18:54:03.124-08	2016-01-17 17:53:04.037-08	2016-01-17 20:03:53.516-08	1	44	1
120	Advanced Analysis of Algorithms	628	4066	VEC  Room 330	01-SEM	[{"day":"Mon","start":"19:00","end":"20:15"},{"day":"Wed","start":"19:00","end":"20:15"}]	Prerequisites: CECS 328, MATH 380 or EE 380 with a grade of "C" or better.\nTheoretical analysis of algorithms. Divide and conquer, dynamic programming and greedy algorithms; basic search and traversal techniques including search trees; sorting; matrix manipulations; NP-completeness. \nMaster's students register in CECS 528 or 628; Ph.D. students register in CECS 628. Additional projects required for CECS 628. (Lecture-problems 3 hours.) Letter grade only (A-F). Effective Fall 2012.	23	26	2016-01-17 18:54:13.13-08	2016-01-17 17:53:04.038-08	2016-01-17 20:03:53.516-08	1	41	1
137	Directed Research	697	9074	TBA	18-SUP	[]	\N	\N	\N	\N	2016-01-17 17:53:04.06-08	2016-01-17 20:03:53.524-08	1	39	1
47	Design of Dynamic Web Sites	300	10926	ECS  Room 413	03-SEM	[{"day":"Fri","start":"10:00","end":"11:40"}]	Prerequisite: CECS 200 with a grade of "C" or better. \nDynamic Web design using modern tools. Creation of domains, using hosting services and content management systems. Website portability, usability and accessibility.\nLetter grade only (A-F). (Lecture 2 hours, laboratory 3 hours).\nEffective Fall 2012.	24	25	2016-01-17 18:10:14.143-08	2016-01-17 17:53:03.962-08	2016-01-17 20:03:53.495-08	1	17	1
52	Computer Logic Design II	301	8242	ECS  Room 416	04-LAB	[{"day":"Tue","start":"15:00","end":"16:15"},{"day":"Thu","start":"15:00","end":"16:15"}]	Prerequisites: CECS 174, 201 with a grade of "C" or better.  Sequential logic emphasizing Finite State Machine design & analysis, timing analysis of sequential logic, Introduction to Data Path, Control and Memory. Use of Electronic Design Automation (EDA) tools for design, simulation, verification. Laboratory projects with Field Programmable Gate Arrays (FPGA's). (Lecture 2 hours, laboratory 3 hours) Letter grade only (A-F).  Effective Fall 2014.	8	25	2016-01-17 18:12:00.853-08	2016-01-17 17:53:03.966-08	2016-01-17 20:03:53.495-08	1	19	1
57	Operating Systems	326	1214	VEC  Room 330	03-SEM	[{"day":"Tue","start":"09:30","end":"10:20"},{"day":"Thu","start":"09:30","end":"10:20"}]	Prerequisite(s):  CECS 282 and either 285 or 346 all with a grade of "C" or better. \nThe structure and functions of operating systems. Interrupt handling, processes and interprocess communication, memory management, resource scheduling, information sharing and protection. Project implementation in C/C++.  \n(Lecture 2 hours, laboratory 3 hours.) Letter grade only (A-F).  \nEffective Fall 2012.	23	25	2016-01-17 18:12:33.205-08	2016-01-17 17:53:03.97-08	2016-01-17 20:03:53.496-08	1	23	1
63	Data Structures and Algorithms	328	9965	SPA  Room 104	09-SEM	[{"day":"Mon","start":"17:30","end":"18:20"},{"day":"Wed","start":"17:30","end":"18:20"}]	Prerequisite: CECS 228 with a grade of "C" or better. Corequisite: CECS 277. \nA broad view of data structures and the structure-preserving operations on them. Abstract data types, algorithms, complexity. Programming projects to exemplify these concepts. \n(Lecture 2 hours, laboratory 3 hours.) Letter grade only (A-F). Effective Fall 2012.	11	25	2016-01-17 18:13:13.835-08	2016-01-17 17:53:03.975-08	2016-01-17 20:03:53.498-08	1	22	1
68	Computers and Networks	410	11103	PH1  Room 112	02-LAB	[{"day":"Tue","start":"19:30","end":"20:45"}]	Prerequisite: Course design assumes familiarity with computers. \nGain practical, hands-on experience in installing hardware and software on a PC. Learn what a computer network is and how it is similar to the telephone network. Learn the parts that make up a computer and a network. \n(Lecture 2 hours, laboratory 3 hours.) Letter grade only (A-F).	0	25	2016-01-17 18:13:48.118-08	2016-01-17 17:53:03.981-08	2016-01-17 20:03:53.5-08	1	26	1
78	Computer Architecture	440	10176	ECS  Room 411	06-LAB	[{"day":"Mon","start":"11:00","end":"12:15"},{"day":"Wed","start":"11:00","end":"12:15"}]	Prerequisite: CECS 346 with a grade of "C" or better.  Review of logic design. Register transfer and micro-operations. Basic computer organization. Central processor organization. Microprogram control organization. Arithmetic processor design. Arithmetic algorithms. Input-output organization. Memory organization.  (Lecture 2 hours, laboratory 3 hours.) Letter grade only (A-F).  Effective Fall 2012.	0	1	2016-01-17 18:15:37.585-08	2016-01-17 17:53:03.991-08	2016-01-17 20:03:53.502-08	1	19	1
118	Advanced Operating Systems	626	4928	ECS  Room 308	01-SEM	[{"day":"Tue","start":"12:30","end":"13:45"},{"day":"Thu","start":"12:30","end":"13:45"}]	Prerequisites: CECS 228 and 326 with a grade of "C" or better.\nTheoretical foundations of concepts applied in the design of operating systems. Control of concurrent processes, deadlocks, mutual exclusion, virtual memory, resource management and scheduling. \nMaster's students register in CECS 526 or 626; Ph.D. students register in CECS 626. Additional projects required for CECS 626. (Lecture-problems 3 hours.) Letter grade only (A-F).  Effective Fall 2012.	25	26	2016-01-17 18:53:43.423-08	2016-01-17 17:53:04.037-08	2016-01-17 20:03:53.516-08	1	44	1
92	Application Programming Using .NET	475	2407	ECS  Room 412	02-LAB	[{"day":"Tue","start":"09:00","end":"10:15"},{"day":"Thu","start":"09:00","end":"10:15"}]	Prerequisite: CECS 343  with a grade of "C" or better.  \nIntroduction to enterprise application libellus_apielopment utilizing the .NET environment. Topics include object-oriented design, events, databases, multithreading, web server applications, web services and cloud computing. Individual projects as well as a team project required.\nLetter grade only (A-F). (Lecture 2 hours, laboratory 3 hours.)	20	25	2016-01-17 18:49:30.939-08	2016-01-17 17:53:04.007-08	2016-01-17 20:03:53.506-08	1	31	1
132	Selected Topics in Computer Science	690	8293	ECS  Room 302	01-SEM	[{"day":"Mon","start":"17:30","end":"18:45"},{"day":"Wed","start":"17:30","end":"18:45"}]	Prerequisites: Graduate standing and consent of instructor.\nEach offering is based on an area in computer science and technology in which recent advances have been made. \nMaster's students register in CECS 590 or 690; Ph.D. students register in CECS 690. Additional projects required for CECS 690. (Lecture-problems 3 hours.) May be repeated to a maximum of 6 units with consent of department. Letter grade only (A-F).	9	26	2016-01-17 18:56:23.169-08	2016-01-17 17:53:04.054-08	2016-01-17 20:03:53.523-08	1	40	1
84	Microprocessors and Controllers III	447	5993	ECS  Room 411	02-LAB	[{"day":"Tue","start":"13:30","end":"14:45"},{"day":"Thu","start":"13:30","end":"14:45"}]	Prerequisite: CECS 347 with a grade of "C" or better. \nEmbedded system applications and techniques. Real-time multi-tasking systems, schedulers, kernels, and operating systems for embedded processors. Advanced I/O technologies - CAN, I2C, Ethernet. Embedded Internet applications. Polling vs. interrupt handling. Lab implementation of embedded designs and hardware-assisted debugging. \n(Lecture 2 hours, laboratory 3 hours.) Letter grade only (A-F). Effective Fall 2012.	20	25	2016-01-17 18:16:18.902-08	2016-01-17 17:53:03.998-08	2016-01-17 20:03:53.503-08	1	30	1
97	Computer Engineering Senior Project II	490B	5393	VEC  Room 402	01-SEM	[{"day":"Mon","start":"19:00","end":"19:50"},{"day":"Wed","start":"19:00","end":"19:50"}]	Prerequisites: CECS 490A or CECS 491 and consent of the instructor.  Second of a two-semester capstone senior project in computer engineering that fulfills GE integrative learning. Student teams will build, program and verify operation of project started in prior design course.  Student teams must submit a written report, give an oral multimedia presentation and provide a working demonstration.(Lecture 2 hours, laboratory 3 hours) Letter Grade Only (A-F). Effective Fall 2014.	29	35	2016-01-17 18:50:06.53-08	2016-01-17 17:53:04.013-08	2016-01-17 20:03:53.509-08	1	38	1
46	Object Oriented Application libellus_apielopment	277	6322	ECS  Room 403	06-LAB	[{"day":"Mon","start":"16:00","end":"17:15"},{"day":"Wed","start":"16:00","end":"17:15"}]	Prerequisite: CECS 274 with a grade of "C" or better .  Advanced introduction to the fundamentals of computer science and software engineering methodology. Advanced programming techniques and design methodology typically used in large programming projects using the Java programming language.  (Lecture 2 hours, laboratory 3 hours.) Letter grade only (A-F).  Effective Fall 2012.	20	25	2016-01-17 18:10:03.344-08	2016-01-17 17:53:03.961-08	2016-01-17 20:03:53.494-08	1	16	1
51	Computer Logic Design II	301	6159	ET  Room 229	03-SEM	[{"day":"Tue","start":"14:00","end":"14:50"},{"day":"Thu","start":"14:00","end":"14:50"}]	Prerequisites: CECS 174, 201 with a grade of "C" or better.  Sequential logic emphasizing Finite State Machine design & analysis, timing analysis of sequential logic, Introduction to Data Path, Control and Memory. Use of Electronic Design Automation (EDA) tools for design, simulation, verification. Laboratory projects with Field Programmable Gate Arrays (FPGA's). (Lecture 2 hours, laboratory 3 hours) Letter grade only (A-F).  Effective Fall 2014.	8	25	2016-01-17 18:11:54.359-08	2016-01-17 17:53:03.965-08	2016-01-17 20:03:53.495-08	1	19	1
56	Database Fundamentals	323	9961	ECS  Room 416	10-LAB	[{"day":"Mon","start":"19:30","end":"20:45"},{"day":"Wed","start":"19:30","end":"20:45"}]	Prerequisites: CECS 228 and CECS 277 or CECS 282 all with a grade of C or better. \nFundamental topics on database management. Topics include entity-relationship models, database design, data definition language, the relational model, data manipulation language, database application programming and normalization. \nLetter grade only (A-F). (Lecture 2 hours, laboratory 3 hours.)  Effective Fall 2014.	4	25	2016-01-17 18:12:26.176-08	2016-01-17 17:53:03.97-08	2016-01-17 20:03:53.496-08	1	20	1
62	Data Structures and Algorithms	328	8256	ECS  Room 404	08-LAB	[{"day":"Fri","start":"13:00","end":"15:30"}]	Prerequisite: CECS 228 with a grade of "C" or better. Corequisite: CECS 277. \nA broad view of data structures and the structure-preserving operations on them. Abstract data types, algorithms, complexity. Programming projects to exemplify these concepts. \n(Lecture 2 hours, laboratory 3 hours.) Letter grade only (A-F). Effective Fall 2012.	19	25	2016-01-17 18:13:06.715-08	2016-01-17 17:53:03.974-08	2016-01-17 20:03:53.498-08	1	22	1
72	Analysis of Algorithms	428	5839	ECS  Room 414	02-LAB	[{"day":"Tue","start":"10:30","end":"11:45"},{"day":"Thu","start":"10:30","end":"11:45"}]	Prerequisite: CECS 328 with a grade of "C" or better. \nApplications of standard combinatorial techniques to applied programming problems. Rigorous analysis of correctness/complexity of algorithms. Advanced graph algorithms are emphasized. Topics include shortest paths on graphs, sorting, string matching, union find problem, divide-and-conquer technique, and weighted-edge problem. \n(Lecture 2 hours, laboratory 3 hours.) Letter grade only (A-F). Effective Fall 2012.	19	25	2016-01-17 18:14:15.334-08	2016-01-17 17:53:03.985-08	2016-01-17 20:03:53.501-08	1	28	1
77	Computer Architecture	440	10175	VEC  Room 419	05-SEM	[{"day":"Mon","start":"10:00","end":"10:50"},{"day":"Wed","start":"10:00","end":"10:50"}]	Prerequisite: CECS 346 with a grade of "C" or better.  Review of logic design. Register transfer and micro-operations. Basic computer organization. Central processor organization. Microprogram control organization. Arithmetic processor design. Arithmetic algorithms. Input-output organization. Memory organization.  (Lecture 2 hours, laboratory 3 hours.) Letter grade only (A-F).  Effective Fall 2012.	0	1	2016-01-17 18:14:54.855-08	2016-01-17 17:53:03.99-08	2016-01-17 20:03:53.501-08	1	19	1
83	Microprocessors and Controllers III	447	5992	VEC  Room 330	01-SEM	[{"day":"Tue","start":"12:30","end":"13:20"},{"day":"Thu","start":"12:30","end":"13:20"}]	Prerequisite: CECS 347 with a grade of "C" or better. \nEmbedded system applications and techniques. Real-time multi-tasking systems, schedulers, kernels, and operating systems for embedded processors. Advanced I/O technologies - CAN, I2C, Ethernet. Embedded Internet applications. Polling vs. interrupt handling. Lab implementation of embedded designs and hardware-assisted debugging. \n(Lecture 2 hours, laboratory 3 hours.) Letter grade only (A-F). Effective Fall 2012.	20	25	2016-01-17 18:16:07.171-08	2016-01-17 17:53:03.998-08	2016-01-17 20:03:53.503-08	1	30	1
91	Application Programming Using .NET	475	1217	ECS  Room 302	01-SEM	[{"day":"Tue","start":"08:00","end":"08:50"},{"day":"Thu","start":"08:00","end":"08:50"}]	Prerequisite: CECS 343  with a grade of "C" or better.  \nIntroduction to enterprise application libellus_apielopment utilizing the .NET environment. Topics include object-oriented design, events, databases, multithreading, web server applications, web services and cloud computing. Individual projects as well as a team project required.\nLetter grade only (A-F). (Lecture 2 hours, laboratory 3 hours.)	20	25	2016-01-17 18:49:24.682-08	2016-01-17 17:53:04.006-08	2016-01-17 20:03:53.506-08	1	31	1
67	Computers and Networks	410	11102	PH1  Room 112	01-SEM	[{"day":"Tue","start":"18:30","end":"19:20"}]	Prerequisite: Course design assumes familiarity with computers. \nGain practical, hands-on experience in installing hardware and software on a PC. Learn what a computer network is and how it is similar to the telephone network. Learn the parts that make up a computer and a network. \n(Lecture 2 hours, laboratory 3 hours.) Letter grade only (A-F).	0	25	2016-01-17 18:13:40.793-08	2016-01-17 17:53:03.98-08	2016-01-17 20:03:53.499-08	1	26	1
101	Distributed and Cloud Computing Project I	492A	8660	HSCI Room 101	01-SEM	[{"day":"Tue","start":"19:30","end":"20:20"},{"day":"Thu","start":"19:30","end":"20:20"}]	Prerequisites: ENGR 350, CECS 327 and  343 all with a grade "C" or better.\nFirst course in a two-course capstone design sequence. Design of a distributed or cloud computing application. Design experience, including detailed requirement analysis, design decisions, teamwork, written reports and oral presentation.\nLetter grade only (A-F). (Lecture 2 hours, laboratory 3 hours)	18	25	2016-01-17 18:50:42.579-08	2016-01-17 17:53:04.018-08	2016-01-17 20:03:53.51-08	1	34	1
121	Advanced Analysis of Algorithms	628	6815	ECS  Room 302	02-SEM	[{"day":"Fri","start":"10:00","end":"12:45"}]	Prerequisites: CECS 328, MATH 380 or EE 380 with a grade of "C" or better.\nTheoretical analysis of algorithms. Divide and conquer, dynamic programming and greedy algorithms; basic search and traversal techniques including search trees; sorting; matrix manipulations; NP-completeness. \nMaster's students register in CECS 528 or 628; Ph.D. students register in CECS 628. Additional projects required for CECS 628. (Lecture-problems 3 hours.) Letter grade only (A-F). Effective Fall 2012.	19	26	2016-01-17 18:54:23.28-08	2016-01-17 17:53:04.045-08	2016-01-17 20:03:53.516-08	1	41	1
138	Thesis or Industrial Project	698	1229	TBA	01-SUP	[]	\N	\N	\N	\N	2016-01-17 17:53:04.06-08	2016-01-17 20:03:53.524-08	1	4	1
139	Thesis or Industrial Project	698	7365	TBA	17-SUP	[]	\N	\N	\N	\N	2016-01-17 17:53:04.06-08	2016-01-17 20:03:53.524-08	1	39	1
53	Database Fundamentals	323	8253	VEC  Room 331	07-SEM	[{"day":"Mon","start":"17:00","end":"17:50"},{"day":"Wed","start":"17:00","end":"17:50"}]	Prerequisites: CECS 228 and CECS 277 or CECS 282 all with a grade of C or better. \nFundamental topics on database management. Topics include entity-relationship models, database design, data definition language, the relational model, data manipulation language, database application programming and normalization. \nLetter grade only (A-F). (Lecture 2 hours, laboratory 3 hours.)  Effective Fall 2014.	23	25	2016-01-17 18:12:07.066-08	2016-01-17 17:53:03.966-08	2016-01-17 20:03:53.496-08	1	18	1
58	Operating Systems	326	2404	ECS  Room 416	04-LAB	[{"day":"Tue","start":"10:30","end":"11:45"},{"day":"Thu","start":"10:30","end":"11:45"}]	Prerequisite(s):  CECS 282 and either 285 or 346 all with a grade of "C" or better. \nThe structure and functions of operating systems. Interrupt handling, processes and interprocess communication, memory management, resource scheduling, information sharing and protection. Project implementation in C/C++.  \n(Lecture 2 hours, laboratory 3 hours.) Letter grade only (A-F).  \nEffective Fall 2012.	23	25	2016-01-17 18:12:39.44-08	2016-01-17 17:53:03.971-08	2016-01-17 20:03:53.497-08	1	23	1
61	Data Structures and Algorithms	328	8255	ECS  Room 308	07-SEM	[{"day":"Fri","start":"11:00","end":"12:40"}]	Prerequisite: CECS 228 with a grade of "C" or better. Corequisite: CECS 277. \nA broad view of data structures and the structure-preserving operations on them. Abstract data types, algorithms, complexity. Programming projects to exemplify these concepts. \n(Lecture 2 hours, laboratory 3 hours.) Letter grade only (A-F). Effective Fall 2012.	19	25	2016-01-17 18:13:00.132-08	2016-01-17 17:53:03.974-08	2016-01-17 20:03:53.498-08	1	22	1
66	Selected Topics in Computer Science	406	8269	ECS  Room 413	02-LAB	[{"day":"Mon","start":"17:00","end":"18:15"},{"day":"Wed","start":"17:00","end":"18:15"}]	Prerequisite: Senior standing in the computer science major. \nEach offering is based upon an area of computer science and technology in which recent advances have been made. \nRepeatable to a maximum of 6 units with different topics in different semesters. (Lecture 2 hours, laboratory 3 hours.) Letter grade only (A-F).\nEffective Fall 2004.	8	25	2016-01-17 18:13:33.98-08	2016-01-17 17:53:03.98-08	2016-01-17 20:03:53.499-08	1	24	1
74	Computer Architecture	440	8951	ECS  Room 411	02-LAB	[{"day":"Mon","start":"11:00","end":"12:15"},{"day":"Wed","start":"11:00","end":"12:15"}]	Prerequisite: CECS 346 with a grade of "C" or better.  Review of logic design. Register transfer and micro-operations. Basic computer organization. Central processor organization. Microprogram control organization. Arithmetic processor design. Arithmetic algorithms. Input-output organization. Memory organization.  (Lecture 2 hours, laboratory 3 hours.) Letter grade only (A-F).  Effective Fall 2012.	11	25	2016-01-17 18:14:28.35-08	2016-01-17 17:53:03.987-08	2016-01-17 20:03:53.501-08	1	19	1
79	Compiler Construction	444	10931	VEC  Room 402	01-SEM	[{"day":"Fri","start":"10:00","end":"11:40"}]	Prerequisites: CECS 285 and 328 with a grade of "C" or better .  Syntax directed compiler study. Organization of a compiler and overall design: parsing, semantic analysis, optimization and code generation.  (Lecture 2 hours, laboratory 3 hours.) Letter grade only (A-F).  Effective Fall 2012.	9	25	2016-01-17 18:15:43.673-08	2016-01-17 17:53:03.991-08	2016-01-17 20:03:53.502-08	1	29	1
85	Mobile Application libellus_apielopment	453	8270	VEC  Room 331	01-SEM	[{"day":"Fri","start":"08:00","end":"09:40"}]	Prerequisite: CECS 328  with a grade of "C" or better or consent of the instructor.\nLanguages and application programming interfaces for mobile libellus_apiice platforms. libellus_apielopment of thick and thin client applications for mobile libellus_apiices.\nLetter grade only (A-F). (Lecture 2 hours, Laboratory 3 hours)\nEffective Fall 2012.	6	25	2016-01-17 18:16:25.809-08	2016-01-17 17:53:03.999-08	2016-01-17 20:03:53.504-08	1	33	1
88	Introduction to Game Programming	455	3395	ECS  Room 416	02-LAB	[{"day":"Mon","start":"14:00","end":"15:15"},{"day":"Wed","start":"14:00","end":"15:15"}]	Prerequisite: CECS 328 with a grade of "C" or better or consent of instructor. \nIntroduction to game programming and graphics. -Slow- games. Real-time games with no adversary. Adversarial real-time games in 2-D. \n(Lecture 2 hours, laboratory 3 hours.) Letter grade only (A-F).\n Effective Fall 2012.	13	25	2016-01-17 18:49:06.998-08	2016-01-17 17:53:04.002-08	2016-01-17 20:03:53.505-08	1	28	1
93	System & Network Administration	476	4300	ECS  Room 405	01-SEM	[{"day":"Tue","start":"17:00","end":"17:50"},{"day":"Thu","start":"17:00","end":"17:50"}]	Prerequisite: CECS 326 or 362 with a grade of "C" or better.\nIntroduction to the management and administration of Unix systems and TCP/IP networks. Managing users, local and network file systems, electronic mail, print queues. Establishing and managing a network.  (Lecture 2 hours, laboratory 3 hours.) Letter grade only (A-F).\nEffective Fall 2012.	15	25	2016-01-17 18:49:36.886-08	2016-01-17 17:53:04.008-08	2016-01-17 20:03:53.507-08	1	36	1
104	Computational Physiology	495	10054	VEC  Room 501	02-LAB	[{"day":"Mon","start":"16:00","end":"17:15"},{"day":"Wed","start":"16:00","end":"17:15"}]	Prerequisite: E E 380 with a grade of "C" or better\nThis course will introduce students to cardiovascular (heart) and cerebrovascular (brain) systems and signals, and the computational methods to analyze related signals, and detect/predict a physiological event of interest. \nCECS 495 same course as EE 495. CECS 495 not open for credit to students with credit in EE 495 .\nLetter Grade only (A-F). (Lecture 2 hours, Laboratory 3 hours)	5	10	2016-01-17 18:51:09.878-08	2016-01-17 17:53:04.019-08	2016-01-17 20:03:53.511-08	1	39	1
116	Database Architecture	621	10070	VEC  Room 419	01-SEM	[{"day":"Fri","start":"13:00","end":"15:30"}]	Prerequisites: CECS 328 and 323 (or 421)  all with a grade of "C" or better.\nRelational database design theory-a rigorous approach. Security, recovery, transaction management, distributed databases and query optimization. \nMaster's students register in CECS 521 or 621; Ph.D. students register in CECS 621. Additional projects required for CECS 621. (Lecture-problems 3 hours.) Letter grade only (A-F). Effective Fall 2012.	25	25	2016-01-17 18:53:25.421-08	2016-01-17 17:53:04.036-08	2016-01-17 20:03:53.515-08	1	33	1
135	Directed Research	697	7366	TBA	16-SUP	[]	Prerequisite: Classified Graduate standing. \nTheoretical and experimental problems in computer science and engineering requiring extensive research.  Advancement to candidacy and program GPA of at least 3.0 are required. Graduate advisor and project supervisor must be consulted prior to registration. Independent Study.\n Letter grade only (A-F). \nEffective Fall 2012.	0	1	2016-01-17 18:56:45.772-08	2016-01-17 17:53:04.055-08	2016-01-17 20:03:53.523-08	1	13	1
44	Object Oriented Programming and Data Structures	274	9065	ECS  Room 416	14-LAB	[{"day":"Tue","start":"20:30","end":"21:45"},{"day":"Thu","start":"20:30","end":"21:45"}]	Prerequisite: CECS 174 with a grade of "C" or better.\nDisciplined methods of design, coding and testing using the Java programming language. Data abstraction, object-oriented design. Introduction to data structures (linked lists, stacks, queues and trees.) Recursion. Sorting and searching.  (Lecture 2 hours, laboratory 3 hours.) Letter grade only (A-F).\nEffective Fall 2012.	4	25	2016-01-17 18:09:44.603-08	2016-01-17 17:53:03.959-08	2016-01-17 20:03:53.494-08	1	18	1
49	Computer Logic Design II	301	1210	VEC  Room 518	01-SEM	[{"day":"Mon","start":"15:00","end":"15:50"},{"day":"Wed","start":"15:00","end":"15:50"}]	Prerequisites: CECS 174, 201 with a grade of "C" or better.  Sequential logic emphasizing Finite State Machine design & analysis, timing analysis of sequential logic, Introduction to Data Path, Control and Memory. Use of Electronic Design Automation (EDA) tools for design, simulation, verification. Laboratory projects with Field Programmable Gate Arrays (FPGA's). (Lecture 2 hours, laboratory 3 hours) Letter grade only (A-F).  Effective Fall 2014.	23	25	2016-01-17 18:11:41.301-08	2016-01-17 17:53:03.963-08	2016-01-17 20:03:53.495-08	1	19	1
59	Operating Systems	326	6788	VEC  Room 518	07-SEM	[{"day":"Mon","start":"17:30","end":"18:20"},{"day":"Wed","start":"17:30","end":"18:20"}]	Prerequisite(s):  CECS 282 and either 285 or 346 all with a grade of "C" or better. \nThe structure and functions of operating systems. Interrupt handling, processes and interprocess communication, memory management, resource scheduling, information sharing and protection. Project implementation in C/C++.  \n(Lecture 2 hours, laboratory 3 hours.) Letter grade only (A-F).  \nEffective Fall 2012.	15	25	2016-01-17 18:12:46.056-08	2016-01-17 17:53:03.971-08	2016-01-17 20:03:53.497-08	1	21	1
70	Organization of Programming Lang	424	11005	ECS  Room 414	06-LAB	[{"day":"Fri","start":"12:00","end":"14:45"}]	Prerequisites: CECS 326 and 328 with a grade of "C" or better. \nUnderstanding the variety of programming languages and the design trade-offs between current programming language paradigms. Comparison of programming languages in their design, implementation, and run-time supports. Includes programming projects. \n(Lecture 2 hours, laboratory 3 hours.) Letter grade only (A-F).\nEffective Fall 2012.	11	25	2016-01-17 18:14:02.203-08	2016-01-17 17:53:03.982-08	2016-01-17 20:03:53.5-08	1	25	1
80	Compiler Construction	444	10932	ECS  Room 405	02-LAB	[{"day":"Fri","start":"12:00","end":"14:45"}]	Prerequisites: CECS 285 and 328 with a grade of "C" or better .  Syntax directed compiler study. Organization of a compiler and overall design: parsing, semantic analysis, optimization and code generation.  (Lecture 2 hours, laboratory 3 hours.) Letter grade only (A-F).  Effective Fall 2012.	9	25	2016-01-17 18:15:49.647-08	2016-01-17 17:53:03.992-08	2016-01-17 20:03:53.502-08	1	29	1
86	Mobile Application libellus_apielopment	453	8271	ECS  Room 403	02-LAB	[{"day":"Fri","start":"10:00","end":"12:30"}]	Prerequisite: CECS 328  with a grade of "C" or better or consent of the instructor.\nLanguages and application programming interfaces for mobile libellus_apiice platforms. libellus_apielopment of thick and thin client applications for mobile libellus_apiices.\nLetter grade only (A-F). (Lecture 2 hours, Laboratory 3 hours)\nEffective Fall 2012.	6	25	2016-01-17 18:16:32.472-08	2016-01-17 17:53:04.001-08	2016-01-17 20:03:53.504-08	1	33	1
89	Hardware Software Co-design	461	6190	VEC  Room 402	01-SEM	[{"day":"Tue","start":"09:30","end":"10:20"},{"day":"Thu","start":"09:30","end":"10:20"}]	Prerequisite: CECS 341 or 440 with a grade of "C" or better .  Introduction to top-down methods for hardware/software system-on-chip co-design.  Design flow system specification, software implementation, hardware synthesis, system design, and verification.  Process optimization with various design decisions emphasized.  Projects/case studies using system-level design methods and tools.  Additional projects required for CECS 561.  (Lecture 2 hours, laboratory  3 hours.)  Letter grade only (A-F).  Effective Fall 2012.	15	25	2016-01-17 18:49:12.633-08	2016-01-17 17:53:04.003-08	2016-01-17 20:03:53.506-08	1	32	1
94	System & Network Administration	476	4301	ECS  Room 405	02-LAB	[{"day":"Tue","start":"18:00","end":"19:15"},{"day":"Thu","start":"18:00","end":"19:15"}]	Prerequisite: CECS 326 or 362 with a grade of "C" or better.\nIntroduction to the management and administration of Unix systems and TCP/IP networks. Managing users, local and network file systems, electronic mail, print queues. Establishing and managing a network.  (Lecture 2 hours, laboratory 3 hours.) Letter grade only (A-F).\nEffective Fall 2012.	15	25	2016-01-17 18:49:42.762-08	2016-01-17 17:53:04.008-08	2016-01-17 20:03:53.507-08	1	36	1
105	Computer Science Problem Solving	496	10676	ECS  Room 204	02-SEM	[{"day":"Mon","start":"19:30","end":"20:20"}]	Prerequisites: CECS 274 with a grade of "C" or better and consent of instructor. \nA study of problem solving in Computer Science. Discussion of the theory necessary to solve computer science problems as well as the solutions to the problems. Problems studied will involve applications of graph theory, data structures, recursion, and algorithms. The aim of the course is to enhance the student's problem solving ability. \n(Lecture 1 hour.) May be repeated to a maximum of 6 units in different semesters. Letter grade only (A-F).	11	20	2016-01-17 18:51:23.125-08	2016-01-17 17:53:04.02-08	2016-01-17 20:03:53.511-08	1	14	1
117	Adv Topics in Programming Lang	624	10072	VEC  Room 418	01-SEM	[{"day":"Tue","start":"12:30","end":"13:45"},{"day":"Thu","start":"12:30","end":"13:45"}]	Prerequisite: CECS 424 with a grade of "C" or better.\nIntensive study of languages of current interest which support object-oriented, client-server, and multimedia applications (e.g. JAVA). \nMaster's students register in CECS 524 or 624; Ph.D. students register in CECS 624. Additional projects required for CECS 624. (Lecture-problems 3 hours.) Letter grade only (A-F). Effective Fall 2012.	25	26	2016-01-17 18:53:34.681-08	2016-01-17 17:53:04.036-08	2016-01-17 20:03:53.515-08	1	43	1
131	Topics Distributed Computer Syst	674	10077	ECS  Room 204	01-SEM	[{"day":"Tue","start":"14:00","end":"15:15"},{"day":"Thu","start":"14:00","end":"15:15"}]	Prerequisite: CECS 526 or 572 or 626 or 672 with a grade of "C" or better.  (Master's students register in CECS 574; Ph.D. students register in CECS 674.) Network operating systems vs distributed operating systems, research and design issues of distributed operating systems, resources and resource management in distributed systems, communication security and user authentication. \nAdditional projects required for Ph.D. students. (Lecture-problems 3 hours.) Letter grade only (A-F). Effective Fall 2012.	15	26	2016-01-17 18:56:15.422-08	2016-01-17 17:53:04.054-08	2016-01-17 20:03:53.522-08	1	42	1
140	Thesis or Industrial Project	698	9075	TBA	18-SUP	[]	\N	\N	\N	\N	2016-01-17 17:53:04.061-08	2016-01-17 20:03:53.524-08	1	13	1
55	Database Fundamentals	323	9960	ECS  Room 308	09-SEM	[{"day":"Mon","start":"18:30","end":"19:20"},{"day":"Wed","start":"18:30","end":"19:20"}]	Prerequisites: CECS 228 and CECS 277 or CECS 282 all with a grade of C or better. \nFundamental topics on database management. Topics include entity-relationship models, database design, data definition language, the relational model, data manipulation language, database application programming and normalization. \nLetter grade only (A-F). (Lecture 2 hours, laboratory 3 hours.)  Effective Fall 2014.	4	25	2016-01-17 18:12:19.93-08	2016-01-17 17:53:03.967-08	2016-01-17 20:03:53.496-08	1	20	1
60	Operating Systems	326	6789	ECS  Room 414	08-LAB	[{"day":"Mon","start":"18:30","end":"19:45"},{"day":"Wed","start":"18:30","end":"19:45"}]	Prerequisite(s):  CECS 282 and either 285 or 346 all with a grade of "C" or better. \nThe structure and functions of operating systems. Interrupt handling, processes and interprocess communication, memory management, resource scheduling, information sharing and protection. Project implementation in C/C++.  \n(Lecture 2 hours, laboratory 3 hours.) Letter grade only (A-F).  \nEffective Fall 2012.	15	25	2016-01-17 18:12:52.815-08	2016-01-17 17:53:03.972-08	2016-01-17 20:03:53.497-08	1	21	1
65	Selected Topics in Computer Science	406	8268	ECS  Room 308	01-SEM	[{"day":"Mon","start":"16:00","end":"16:50"},{"day":"Wed","start":"16:00","end":"16:50"}]	Prerequisite: Senior standing in the computer science major. \nEach offering is based upon an area of computer science and technology in which recent advances have been made. \nRepeatable to a maximum of 6 units with different topics in different semesters. (Lecture 2 hours, laboratory 3 hours.) Letter grade only (A-F).\nEffective Fall 2004.	8	25	2016-01-17 18:13:27.26-08	2016-01-17 17:53:03.976-08	2016-01-17 20:03:53.499-08	1	24	1
71	Analysis of Algorithms	428	5838	ECS  Room 308	01-SEM	[{"day":"Tue","start":"09:30","end":"10:20"},{"day":"Thu","start":"09:30","end":"10:20"}]	Prerequisite: CECS 328 with a grade of "C" or better. \nApplications of standard combinatorial techniques to applied programming problems. Rigorous analysis of correctness/complexity of algorithms. Advanced graph algorithms are emphasized. Topics include shortest paths on graphs, sorting, string matching, union find problem, divide-and-conquer technique, and weighted-edge problem. \n(Lecture 2 hours, laboratory 3 hours.) Letter grade only (A-F). Effective Fall 2012.	19	25	2016-01-17 18:14:08.564-08	2016-01-17 17:53:03.985-08	2016-01-17 20:03:53.501-08	1	28	1
81	Software Design and Architecture	445	10989	ECS  Room 308	01-SEM	[{"day":"Tue","start":"11:00","end":"11:50"},{"day":"Thu","start":"11:00","end":"11:50"}]	Prerequisites: CECS 343 with a grade of "C" or better and Senior status. An in-depth look at software design, design patterns, frameworks, architectures and middleware architectures. Component based design including COM, Corba, and .Net. Fundamentals of software metrics, measuring software qualities. Basics of software evolution, reengineering, and reverse engineering. A semester long team project. \n(Lecture 2 hours, laboratory 3 hours.) Letter grade only (A-F).\nEffective Fall 2012.	1	25	2016-01-17 18:15:55.613-08	2016-01-17 17:53:03.997-08	2016-01-17 20:03:53.502-08	1	1	1
87	Introduction to Game Programming	455	3394	VEC  Room 331	01-SEM	[{"day":"Mon","start":"13:00","end":"13:50"},{"day":"Wed","start":"13:00","end":"13:50"}]	Prerequisite: CECS 328 with a grade of "C" or better or consent of instructor. \nIntroduction to game programming and graphics. -Slow- games. Real-time games with no adversary. Adversarial real-time games in 2-D. \n(Lecture 2 hours, laboratory 3 hours.) Letter grade only (A-F).\n Effective Fall 2012.	13	25	2016-01-17 18:16:39.003-08	2016-01-17 17:53:04.002-08	2016-01-17 20:03:53.505-08	1	28	1
115	Selected Topics in Computer Science	590	11000	VEC  Room 402	03-SEM	[{"day":"Fri","start":"15:00","end":"17:45"}]	Prerequisites: Graduate standing and consent of instructor. \nEach offering is based on an area in computer science and technology in which recent advances have been made. \nMaster's students register in CECS 590 or 690; Ph.D. students register in CECS 690. Additional projects required for CECS 690. (Lecture-problems 3 hours.) May be repeated to a maximum of 6 units with consent of department. Letter grade only (A-F).	7	26	2016-01-17 18:53:16.226-08	2016-01-17 17:53:04.031-08	2016-01-17 20:03:53.514-08	1	25	1
124	Software Architecture	645	8282	VEC  Room 402	02-SEM	[{"day":"Tue","start":"19:30","end":"20:45"},{"day":"Thu","start":"19:30","end":"20:45"}]	Prerequisite: CECS 543 with a grade of "C" or better.\nIncludes architectural styles, pipes and filters, data abstraction and object-oriented organization, event-based, implicit invocation, layered systems, repositories, interpreters, process control, distributed processes, domain-specific software & heterogeneous architectures. Component-based design patterns & case studies. \nAdditional projects required for CECS 645. Letter grade only (A-F). \n(Lecture-problems 3 hours)	25	26	2016-01-17 18:54:59.274-08	2016-01-17 17:53:04.046-08	2016-01-17 20:03:53.517-08	1	35	1
90	Hardware Software Co-design	461	6191	ECS  Room 411	02-LAB	[{"day":"Tue","start":"10:30","end":"11:45"},{"day":"Thu","start":"10:30","end":"11:45"}]	Prerequisite: CECS 341 or 440 with a grade of "C" or better .  Introduction to top-down methods for hardware/software system-on-chip co-design.  Design flow system specification, software implementation, hardware synthesis, system design, and verification.  Process optimization with various design decisions emphasized.  Projects/case studies using system-level design methods and tools.  Additional projects required for CECS 561.  (Lecture 2 hours, laboratory  3 hours.)  Letter grade only (A-F).  Effective Fall 2012.	15	25	2016-01-17 18:49:18.807-08	2016-01-17 17:53:04.003-08	2016-01-17 20:03:53.506-08	1	32	1
103	Computational Physiology	495	10052	SPA  Room 108	01-SEM	[{"day":"Mon","start":"15:00","end":"15:50"},{"day":"Wed","start":"15:00","end":"15:50"}]	Prerequisite: E E 380 with a grade of "C" or better\nThis course will introduce students to cardiovascular (heart) and cerebrovascular (brain) systems and signals, and the computational methods to analyze related signals, and detect/predict a physiological event of interest. \nCECS 495 same course as EE 495. CECS 495 not open for credit to students with credit in EE 495 .\nLetter Grade only (A-F). (Lecture 2 hours, Laboratory 3 hours)	5	10	2016-01-17 18:51:00.824-08	2016-01-17 17:53:04.019-08	2016-01-17 20:03:53.511-08	1	39	1
13	Critical Thinking in the Digital Information Age	100	8158	VEC  Room 518	17-SEM	[{"day":"Mon","start":"19:00","end":"19:50"},{"day":"Wed","start":"19:00","end":"19:50"}]	Prerequisite/Corequisite: ENGL 100 or its equivalent or GE Area A1.\nThis course will help students to libellus_apielop their critical thinking skills using technical software. The main topics will include: identifying engineering issues for investigation, libellus_apieloping planning and problem solving strategies, locating pertinent information and examples, critically analyzing these sources, forming and testing hypotheses, synthesizing and organizing results for effective communication, and libellus_apieloping transferable problem solving skills. (Lecture 2 hours, laboratory 3 hours)  Letter grade only (A-F).\nEffective Summer 2010.	10	25	2016-01-17 17:54:15.177-08	2016-01-17 17:53:03.929-08	2016-01-17 20:03:53.486-08	1	4	1
19	Beginning Web Design	110	2793	ECS  Room 404	02-LAB	[{"day":"Mon","start":"10:00","end":"11:15"}]	Introduction to HTML and CSS using modern tools, following the W3C guidelines for coding. Web sites designed with usability and accessibility principles implemented. Overview of graphics, video, sound, JavaScript and Dreamweaver.\nLetter grade only (A-F). (Lecture 2 hours, laboratory 3 hours).\t\nEffective Spring 2012.	24	25	2016-01-17 17:54:50.085-08	2016-01-17 17:53:03.936-08	2016-01-17 20:03:53.489-08	1	6	1
123	Software Architecture	645	4818	VEC  Room 519	01-SEM	[{"day":"Mon","start":"14:00","end":"15:15"},{"day":"Wed","start":"14:00","end":"15:15"}]	Prerequisite: CECS 543 with a grade of "C" or better.\nIncludes architectural styles, pipes and filters, data abstraction and object-oriented organization, event-based, implicit invocation, layered systems, repositories, interpreters, process control, distributed processes, domain-specific software & heterogeneous architectures. Component-based design patterns & case studies. \nAdditional projects required for CECS 645. Letter grade only (A-F). \n(Lecture-problems 3 hours)	25	26	2016-01-17 18:54:40.116-08	2016-01-17 17:53:04.046-08	2016-01-17 20:03:53.517-08	1	35	1
1	Critical Thinking in the Digital Information Age	100	4800	VEC  Room 402	03-SEM	[{"day":"Mon","start":"08:00","end":"08:50"},{"day":"Wed","start":"08:00","end":"08:50"}]	Prerequisite/Corequisite: ENGL 100 or its equivalent or GE Area A1.\nThis course will help students to libellus_apielop their critical thinking skills using technical software. The main topics will include: identifying engineering issues for investigation, libellus_apieloping planning and problem solving strategies, locating pertinent information and examples, critically analyzing these sources, forming and testing hypotheses, synthesizing and organizing results for effective communication, and libellus_apieloping transferable problem solving skills. (Lecture 2 hours, laboratory 3 hours)  Letter grade only (A-F).\nEffective Summer 2010.	10	25	2016-01-17 20:03:55.73-08	2016-01-17 17:53:03.916-08	2016-01-17 20:03:55.731-08	1	2	1
16	Critical Thinking in the Digital Information Age	100	8163	ECS  Room 407	22-LAB	[{"day":"Tue","start":"19:00","end":"20:15"},{"day":"Thu","start":"19:00","end":"20:15"}]	Prerequisite/Corequisite: ENGL 100 or its equivalent or GE Area A1.\nThis course will help students to libellus_apielop their critical thinking skills using technical software. The main topics will include: identifying engineering issues for investigation, libellus_apieloping planning and problem solving strategies, locating pertinent information and examples, critically analyzing these sources, forming and testing hypotheses, synthesizing and organizing results for effective communication, and libellus_apieloping transferable problem solving skills. (Lecture 2 hours, laboratory 3 hours)  Letter grade only (A-F).\nEffective Summer 2010.	10	25	2016-01-17 17:54:32.744-08	2016-01-17 17:53:03.934-08	2016-01-17 20:03:53.487-08	1	5	1
17	Introduction to Computer Engineering and Computer Science	105	8606	ECS  Room 105	02-SEM	[{"day":"Fri","start":"10:00","end":"10:50"}]	Prerequisite: None. Introduction to the fields of computer engineering and computer science. Current and future trends and challenges in various fields of computing.  Social, ethical and economical issues related to computing technology. Exploration of career and professional libellus_apielopment opportunities.   (Lecture 1 hour).  Letter grade only (A-F).  Effective Spring 2007.	177	180	2016-01-17 17:54:38.426-08	2016-01-17 17:53:03.935-08	2016-01-17 20:03:53.488-08	1	8	1
20	Introduction to Programming and Problem Solving	174	7162	ECS  Room 306	13-SEM	[{"day":"Tue","start":"15:30","end":"16:20"},{"day":"Thu","start":"15:30","end":"16:20"}]	Prerequisites:  CECS 100 and MATH 113 (or equivalent) with a grade of "C" or better .\nIntroduction to basic concepts of computer science and fundamental techniques for solving problems using the Java programming language. Structured problem solving, object-oriented programming, programming style. Applications to numerical and non-numerical problems. \nLetter grade only (A-F). (Lecture 2 hours, laboratory 3 hours.) \nEffective Fall 2012.	70	75	2016-01-17 17:54:55.647-08	2016-01-17 17:53:03.936-08	2016-01-17 20:03:53.489-08	1	7	1
122	Adv Computer Architecture II	631	4601	VEC  Room 330	01-SEM	[{"day":"Tue","start":"18:30","end":"19:45"},{"day":"Thu","start":"18:30","end":"19:45"}]	Prerequisite: CECS 530 with a grade of "C" or better.\nAdvanced computer architecture with emphasis on parallel processing. Vector processors and multiprocessor systems. Dataflow computation. RISC/CISC. Hypercube. Parallel software. Applications in artificial intelligence, signal/image processing, neural network and optical computing. \nMaster's students register in CECS 531 or 631; Ph.D. students register in CECS 631. Additional projects required for CECS 631. (Lecture-problems 3 hours.) Letter grade only (A-F). Effective Fall 2012.	10	26	2016-01-17 18:54:31.564-08	2016-01-17 17:53:04.045-08	2016-01-17 20:03:53.517-08	1	27	1
28	Computer Logic Design I	201	8200	SPA  Room 107	13-SEM	[{"day":"Mon","start":"17:00","end":"17:50"},{"day":"Wed","start":"17:00","end":"17:50"}]	Prerequisite: MATH 113 or equivalent with a grade of "C" or better .\nBasic topics in combinational and sequential switching circuits with applications to the design of digital libellus_apiices.  Introduction to Electronic Design Automation (EDA) tools. Laboratory projects with Field Programmable Gate Arrays (FPGA).(Lecture 2 hours, lab 3 hours.) Letter grade only (A-F).  \nEffective Fall 2012.	21	25	2016-01-17 18:02:22.934-08	2016-01-17 17:53:03.947-08	2016-01-17 20:03:53.491-08	1	11	1
22	Intermediate Web Design	200	9885	ECS  Room 404	01-SEM	[{"day":"Wed","start":"09:00","end":"09:50"}]	Prerequisite: CECS 110 with a grade of "C" or better. Pre- or Corequisite: CECS 100.\nIntermediate HTML and CSS using Dreamweaver, following the W3C guidelines for coding. Web sites designed with usability and accessibility principles implemented.\nLetter grade only (A-F). (Lecture 2 hours, laboratory 3 hours).\nEffective Spring 2012.	16	25	2016-01-17 17:55:07.506-08	2016-01-17 17:53:03.94-08	2016-01-17 20:03:53.49-08	1	6	1
23	Intermediate Web Design	200	9886	ECS  Room 404	02-LAB	[{"day":"Wed","start":"10:00","end":"11:15"}]	Prerequisite: CECS 110 with a grade of "C" or better. Pre- or Corequisite: CECS 100.\nIntermediate HTML and CSS using Dreamweaver, following the W3C guidelines for coding. Web sites designed with usability and accessibility principles implemented.\nLetter grade only (A-F). (Lecture 2 hours, laboratory 3 hours).\nEffective Spring 2012.	16	25	2016-01-17 17:55:13.568-08	2016-01-17 17:53:03.941-08	2016-01-17 20:03:53.49-08	1	6	1
30	Digital Information Age	202	9896	VEC  Room 519	01-SEM	[{"day":"Mon","start":"15:30","end":"16:45"},{"day":"Wed","start":"15:30","end":"16:45"}]	Prerequisite: Completion of GE foundation requirements. \nThe introduction and use of common-place digital and electronic libellus_apiices and how this technology affects our society. Topics include advances in 3D imaging, 3D printing, Processors, Memory, Security and Privacy. (Lecture 3 hours) Letter grade only (A-F). \n(Lecture 3 hours) Letter grade only (A-F). \nEffective Fall 2014.	17	25	2016-01-17 18:02:35.043-08	2016-01-17 17:53:03.948-08	2016-01-17 20:03:53.491-08	1	8	1
125	Fault Tolerant Computing Systems	646	8284	ECS  Room 302	01-SEM	[{"day":"Mon","start":"20:00","end":"21:15"},{"day":"Wed","start":"20:00","end":"21:15"}]	Prerequisite(s): CECS 341 or 440 with a grade of C or better. \nFault tolerant techniques are studied as tools to assure the reliability and continuous availability of computing systems. Case studies of modern fault tolerant systems reviewed. Software fault tolerant systems studied as alternatives to verification and validation approaches to software reliability. \nMaster's students register in CECS 546 or 646; Ph.D. students register in CECS 646. Additional projects required for CECS 646. (Lecture-problems 3 hours.) Letter grade only (A-F). Effective through Summer 2014.	25	26	2016-01-17 18:55:08.572-08	2016-01-17 17:53:04.047-08	2016-01-17 20:03:53.517-08	1	21	1
126	Advanced Artificial Intelligence	651	4830	VEC  Room 402	01-SEM	[{"day":"Mon","start":"17:30","end":"18:45"},{"day":"Wed","start":"17:30","end":"18:45"}]	Prerequisite: CECS 451 with a grade of "C" or better.\nAdvanced concepts in artificial intelligence. Topics include knowledge acquisition and representation, fuzzy logic, logical reasoning, multi-sensor integration, Dempster-Shafer's theory of evidential reasoning, real-time expert systems and neural networks. \nMaster's students register in CECS 551 or 651; Ph.D. students register in CECS 651. Additional projects required for CECS 651. (Lecture-problems 3 hours.) Letter grade only (A-F). Effective Fall 2012.	18	26	2016-01-17 18:55:17.973-08	2016-01-17 17:53:04.049-08	2016-01-17 20:03:53.518-08	1	41	1
3	Critical Thinking in the Digital Information Age	100	4803	ECS  Room 404	06-LAB	[{"day":"Tue","start":"12:00","end":"13:15"},{"day":"Thu","start":"12:00","end":"13:15"}]	Prerequisite/Corequisite: ENGL 100 or its equivalent or GE Area A1.\nThis course will help students to libellus_apielop their critical thinking skills using technical software. The main topics will include: identifying engineering issues for investigation, libellus_apieloping planning and problem solving strategies, locating pertinent information and examples, critically analyzing these sources, forming and testing hypotheses, synthesizing and organizing results for effective communication, and libellus_apieloping transferable problem solving skills. (Lecture 2 hours, laboratory 3 hours)  Letter grade only (A-F).\nEffective Summer 2010.	24	25	2016-01-17 20:04:13.289-08	2016-01-17 17:53:03.917-08	2016-01-17 20:04:13.289-08	1	2	1
27	Computer Logic Design I	201	5991	ECS  Room 411	10-LAB	[{"day":"Mon","start":"20:00","end":"21:15"},{"day":"Wed","start":"20:00","end":"21:15"}]	Prerequisite: MATH 113 or equivalent with a grade of "C" or better .\nBasic topics in combinational and sequential switching circuits with applications to the design of digital libellus_apiices.  Introduction to Electronic Design Automation (EDA) tools. Laboratory projects with Field Programmable Gate Arrays (FPGA).(Lecture 2 hours, lab 3 hours.) Letter grade only (A-F).  \nEffective Fall 2012.	20	25	2016-01-17 18:02:16.7-08	2016-01-17 17:53:03.946-08	2016-01-17 20:03:53.491-08	1	10	1
7	Critical Thinking in the Digital Information Age	100	6266	VEC  Room 418	09-SEM	[{"day":"Tue","start":"08:00","end":"08:50"},{"day":"Thu","start":"08:00","end":"08:50"}]	Prerequisite/Corequisite: ENGL 100 or its equivalent or GE Area A1.\nThis course will help students to libellus_apielop their critical thinking skills using technical software. The main topics will include: identifying engineering issues for investigation, libellus_apieloping planning and problem solving strategies, locating pertinent information and examples, critically analyzing these sources, forming and testing hypotheses, synthesizing and organizing results for effective communication, and libellus_apieloping transferable problem solving skills. (Lecture 2 hours, laboratory 3 hours)  Letter grade only (A-F).\nEffective Summer 2010.	11	25	2016-01-17 20:04:30.449-08	2016-01-17 17:53:03.923-08	2016-01-17 20:04:30.449-08	1	1	1
127	Machine Vision	653	5843	VEC  Room 402	01-SEM	[{"day":"Tue","start":"18:30","end":"19:20"},{"day":"Thu","start":"18:30","end":"19:20"}]	Prerequisite: Graduate standing in engineering or computer science. \nDiscussion and laboratory implementation of current research in vision and image understanding. Topics include image formation, early processing, segmentation, relational structures in 2-D and 3-D, motion, stereo, 3-D reconstruction, morphological methods and computer architecture for machine vision. \nMaster's students register in CECS 553 or 653; Ph.D. students register in CECS 653. Additional projects required for CECS 653. (Lecture-problems 2 hours, laboratory 3 hours.) Letter grade only (A-F).	25	26	2016-01-17 18:55:28.862-08	2016-01-17 17:53:04.05-08	2016-01-17 20:03:53.518-08	1	21	1
128	Machine Vision	653	5844	ECS  Room 411	02-LAB	[{"day":"Tue","start":"19:30","end":"20:45"},{"day":"Thu","start":"19:30","end":"20:45"}]	Prerequisite: Graduate standing in engineering or computer science. \nDiscussion and laboratory implementation of current research in vision and image understanding. Topics include image formation, early processing, segmentation, relational structures in 2-D and 3-D, motion, stereo, 3-D reconstruction, morphological methods and computer architecture for machine vision. \nMaster's students register in CECS 553 or 653; Ph.D. students register in CECS 653. Additional projects required for CECS 653. (Lecture-problems 2 hours, laboratory 3 hours.) Letter grade only (A-F).	25	26	2016-01-17 18:55:36.814-08	2016-01-17 17:53:04.05-08	2016-01-17 20:03:53.519-08	1	21	1
10	Critical Thinking in the Digital Information Age	100	3636	ECS  Room 404	12-LAB	[{"day":"Tue","start":"15:00","end":"16:15"},{"day":"Thu","start":"15:00","end":"16:15"}]	Prerequisite/Corequisite: ENGL 100 or its equivalent or GE Area A1.\nThis course will help students to libellus_apielop their critical thinking skills using technical software. The main topics will include: identifying engineering issues for investigation, libellus_apieloping planning and problem solving strategies, locating pertinent information and examples, critically analyzing these sources, forming and testing hypotheses, synthesizing and organizing results for effective communication, and libellus_apieloping transferable problem solving skills. (Lecture 2 hours, laboratory 3 hours)  Letter grade only (A-F).\nEffective Summer 2010.	23	25	2016-01-17 17:53:57.482-08	2016-01-17 17:53:03.924-08	2016-01-17 20:03:53.485-08	1	3	1
15	Critical Thinking in the Digital Information Age	100	8162	VEC  Room 519	21-SEM	[{"day":"Tue","start":"18:00","end":"18:50"},{"day":"Thu","start":"18:00","end":"18:50"}]	Prerequisite/Corequisite: ENGL 100 or its equivalent or GE Area A1.\nThis course will help students to libellus_apielop their critical thinking skills using technical software. The main topics will include: identifying engineering issues for investigation, libellus_apieloping planning and problem solving strategies, locating pertinent information and examples, critically analyzing these sources, forming and testing hypotheses, synthesizing and organizing results for effective communication, and libellus_apieloping transferable problem solving skills. (Lecture 2 hours, laboratory 3 hours)  Letter grade only (A-F).\nEffective Summer 2010.	10	25	2016-01-17 17:54:26.788-08	2016-01-17 17:53:03.93-08	2016-01-17 20:03:53.487-08	1	5	1
31	Discrete Structures with Computing Applications	228	8204	SPA  Room 109	07-SEM	[{"day":"Tue","start":"19:30","end":"20:20"},{"day":"Thu","start":"19:30","end":"20:20"}]	Prerequisites:  CECS 174 and MATH 113 or equivalent with a grade of "C" or better .\nAn introduction to discrete mathematics with applications towards computing. Topics include sets, functions, logic, relations, graphs, trees, recursion, combinatorics, and mathematical reasoning. \nLetter grade only (A-F). (Lecture 2 hours, laboratory/problem session 3 hours.)  Effective Fall 2012.	13	25	2016-01-17 18:02:41.557-08	2016-01-17 17:53:03.95-08	2016-01-17 20:03:53.491-08	1	12	1
33	Discrete Structures with Computing Applications II	229	10197	SPA  Room 211	03-SEM	[{"day":"Mon","start":"17:00","end":"17:50"},{"day":"Wed","start":"17:00","end":"17:50"}]	Prerequisites: MATH 123 and CECS 228 both with a Grade of "C" or better\nThis is the second course in a two-course sequence in computing applications of discrete structures. Topics include applications of computer arithmetic and matrices in computer systems. Programming assignments in Python will be provided. \nLetter grade only (A-F). (Lecture 2 hours, Laboratory 3 hours)	23	25	2016-01-17 18:02:54.205-08	2016-01-17 17:53:03.951-08	2016-01-17 20:03:53.492-08	1	5	1
4	Critical Thinking in the Digital Information Age	100	4802	VEC  Room 402	05-SEM	[{"day":"Tue","start":"11:00","end":"11:50"},{"day":"Thu","start":"11:00","end":"11:50"}]	Prerequisite/Corequisite: ENGL 100 or its equivalent or GE Area A1.\nThis course will help students to libellus_apielop their critical thinking skills using technical software. The main topics will include: identifying engineering issues for investigation, libellus_apieloping planning and problem solving strategies, locating pertinent information and examples, critically analyzing these sources, forming and testing hypotheses, synthesizing and organizing results for effective communication, and libellus_apieloping transferable problem solving skills. (Lecture 2 hours, laboratory 3 hours)  Letter grade only (A-F).\nEffective Summer 2010.	24	25	2016-01-17 20:04:07.364-08	2016-01-17 17:53:03.918-08	2016-01-17 20:04:07.364-08	1	2	1
8	Critical Thinking in the Digital Information Age	100	6267	ECS  Room 403	10-LAB	[{"day":"Tue","start":"09:00","end":"10:15"},{"day":"Thu","start":"09:00","end":"10:15"}]	Prerequisite/Corequisite: ENGL 100 or its equivalent or GE Area A1.\nThis course will help students to libellus_apielop their critical thinking skills using technical software. The main topics will include: identifying engineering issues for investigation, libellus_apieloping planning and problem solving strategies, locating pertinent information and examples, critically analyzing these sources, forming and testing hypotheses, synthesizing and organizing results for effective communication, and libellus_apieloping transferable problem solving skills. (Lecture 2 hours, laboratory 3 hours)  Letter grade only (A-F).\nEffective Summer 2010.	11	25	2016-01-17 20:04:36.009-08	2016-01-17 17:53:03.923-08	2016-01-17 20:04:36.01-08	1	1	1
9	Critical Thinking in the Digital Information Age	100	3393	ECS  Room 302	11-SEM	[{"day":"Tue","start":"14:00","end":"14:50"},{"day":"Thu","start":"14:00","end":"14:50"}]	Prerequisite/Corequisite: ENGL 100 or its equivalent or GE Area A1.\nThis course will help students to libellus_apielop their critical thinking skills using technical software. The main topics will include: identifying engineering issues for investigation, libellus_apieloping planning and problem solving strategies, locating pertinent information and examples, critically analyzing these sources, forming and testing hypotheses, synthesizing and organizing results for effective communication, and libellus_apieloping transferable problem solving skills. (Lecture 2 hours, laboratory 3 hours)  Letter grade only (A-F).\nEffective Summer 2010.	23	25	2016-01-17 20:04:41.726-08	2016-01-17 17:53:03.924-08	2016-01-17 20:04:41.726-08	1	3	1
64	Data Structures and Algorithms	328	9966	ECS  Room 405	10-LAB	[{"day":"Mon","start":"18:30","end":"19:45"},{"day":"Wed","start":"18:30","end":"19:45"}]	Prerequisite: CECS 228 with a grade of "C" or better. Corequisite: CECS 277. \nA broad view of data structures and the structure-preserving operations on them. Abstract data types, algorithms, complexity. Programming projects to exemplify these concepts. \n(Lecture 2 hours, laboratory 3 hours.) Letter grade only (A-F). Effective Fall 2012.	11	25	2016-01-17 18:13:20.936-08	2016-01-17 17:53:03.975-08	2016-01-17 20:03:53.498-08	1	22	1
69	Organization of Programming Lang	424	11004	VEC  Room 418	05-SEM	[{"day":"Fri","start":"10:00","end":"11:40"}]	Prerequisites: CECS 326 and 328 with a grade of "C" or better. \nUnderstanding the variety of programming languages and the design trade-offs between current programming language paradigms. Comparison of programming languages in their design, implementation, and run-time supports. Includes programming projects. \n(Lecture 2 hours, laboratory 3 hours.) Letter grade only (A-F).\nEffective Fall 2012.	11	25	2016-01-17 18:13:55.656-08	2016-01-17 17:53:03.982-08	2016-01-17 20:03:53.5-08	1	25	1
129	Advanced Computer Networking	672	10763	ECS  Room 302	03-SEM	[{"day":"Sat","start":"10:00","end":"12:45"}]	Prerequisite(s): CECS 474 with a grade of C or better.\nAdvanced concepts in computer network theory and practice. Computer network design and standards for local area networks (LANs) and wide area networks (WANs). Computer network configuration and performance issues.  Masters students register in CECS 572 or 672; Ph.D. students register in CECS 672. Additional projects required for CECS 672. (Lecture-problems 3 hours.) Letter grade only (A-F).  Effective Fall 2014.	20	22	2016-01-17 18:55:52.808-08	2016-01-17 17:53:04.051-08	2016-01-17 20:03:53.522-08	1	45	1
12	Critical Thinking in the Digital Information Age	100	6314	ECS  Room 404	14-LAB	[{"day":"Mon","start":"12:00","end":"13:15"},{"day":"Wed","start":"12:00","end":"13:15"}]	Prerequisite/Corequisite: ENGL 100 or its equivalent or GE Area A1.\nThis course will help students to libellus_apielop their critical thinking skills using technical software. The main topics will include: identifying engineering issues for investigation, libellus_apieloping planning and problem solving strategies, locating pertinent information and examples, critically analyzing these sources, forming and testing hypotheses, synthesizing and organizing results for effective communication, and libellus_apieloping transferable problem solving skills. (Lecture 2 hours, laboratory 3 hours)  Letter grade only (A-F).\nEffective Summer 2010.	23	25	2016-01-17 17:54:09.118-08	2016-01-17 17:53:03.928-08	2016-01-17 20:03:53.486-08	1	1	1
39	Object Oriented Programming and Data Structures	274	9953	ECS  Room 416	09-SEM	[{"day":"Tue","start":"08:00","end":"08:50"},{"day":"Thu","start":"08:00","end":"08:50"}]	Prerequisite: CECS 174 with a grade of "C" or better.\nDisciplined methods of design, coding and testing using the Java programming language. Data abstraction, object-oriented design. Introduction to data structures (linked lists, stacks, queues and trees.) Recursion. Sorting and searching.  (Lecture 2 hours, laboratory 3 hours.) Letter grade only (A-F).\nEffective Fall 2012.	15	25	2016-01-17 18:08:50.614-08	2016-01-17 17:53:03.955-08	2016-01-17 20:03:53.493-08	1	15	1
73	Computer Architecture	440	8950	VEC  Room 419	01-SEM	[{"day":"Mon","start":"10:00","end":"10:50"},{"day":"Wed","start":"10:00","end":"10:50"}]	Prerequisite: CECS 346 with a grade of "C" or better.  Review of logic design. Register transfer and micro-operations. Basic computer organization. Central processor organization. Microprogram control organization. Arithmetic processor design. Arithmetic algorithms. Input-output organization. Memory organization.  (Lecture 2 hours, laboratory 3 hours.) Letter grade only (A-F).  Effective Fall 2012.	11	25	2016-01-17 18:14:21.925-08	2016-01-17 17:53:03.986-08	2016-01-17 20:03:53.501-08	1	19	1
75	Computer Architecture	440	10016	VEC  Room 418	03-SEM	[{"day":"Tue","start":"15:30","end":"16:20"},{"day":"Thu","start":"15:30","end":"16:20"}]	Prerequisite: CECS 346 with a grade of "C" or better.  Review of logic design. Register transfer and micro-operations. Basic computer organization. Central processor organization. Microprogram control organization. Arithmetic processor design. Arithmetic algorithms. Input-output organization. Memory organization.  (Lecture 2 hours, laboratory 3 hours.) Letter grade only (A-F).  Effective Fall 2012.	9	25	2016-01-17 18:14:35.306-08	2016-01-17 17:53:03.987-08	2016-01-17 20:03:53.501-08	1	27	1
2	Critical Thinking in the Digital Information Age	100	4801	ECS  Room 403	04-LAB	[{"day":"Mon","start":"09:00","end":"10:15"},{"day":"Wed","start":"09:00","end":"10:15"}]	Prerequisite/Corequisite: ENGL 100 or its equivalent or GE Area A1.\nThis course will help students to libellus_apielop their critical thinking skills using technical software. The main topics will include: identifying engineering issues for investigation, libellus_apieloping planning and problem solving strategies, locating pertinent information and examples, critically analyzing these sources, forming and testing hypotheses, synthesizing and organizing results for effective communication, and libellus_apieloping transferable problem solving skills. (Lecture 2 hours, laboratory 3 hours)  Letter grade only (A-F).\nEffective Summer 2010.	10	25	2016-01-17 20:04:01.386-08	2016-01-17 17:53:03.917-08	2016-01-17 20:04:01.386-08	1	2	1
36	Discrete Structures with Computing Applications II	229	10841	ECS  Room 407	08-LAB	[{"day":"Mon","start":"16:00","end":"17:15"},{"day":"Wed","start":"16:00","end":"17:15"}]	Prerequisites: MATH 123 and CECS 228 both with a Grade of "C" or better\nThis is the second course in a two-course sequence in computing applications of discrete structures. Topics include applications of computer arithmetic and matrices in computer systems. Programming assignments in Python will be provided. \nLetter grade only (A-F). (Lecture 2 hours, Laboratory 3 hours)	8	25	2016-01-17 18:08:30.833-08	2016-01-17 17:53:03.953-08	2016-01-17 20:03:53.492-08	1	13	1
37	Object Oriented Programming and Data Structures	274	3916	VEC  Room 519	05-SEM	[{"day":"Tue","start":"17:00","end":"17:50"},{"day":"Thu","start":"17:00","end":"17:50"}]	Prerequisite: CECS 174 with a grade of "C" or better.\nDisciplined methods of design, coding and testing using the Java programming language. Data abstraction, object-oriented design. Introduction to data structures (linked lists, stacks, queues and trees.) Recursion. Sorting and searching.  (Lecture 2 hours, laboratory 3 hours.) Letter grade only (A-F).\nEffective Fall 2012.	22	25	2016-01-17 18:08:37.556-08	2016-01-17 17:53:03.954-08	2016-01-17 20:03:53.492-08	1	14	1
38	Object Oriented Programming and Data Structures	274	3917	ECS  Room 403	06-LAB	[{"day":"Tue","start":"18:00","end":"19:15"},{"day":"Thu","start":"18:00","end":"19:15"}]	Prerequisite: CECS 174 with a grade of "C" or better.\nDisciplined methods of design, coding and testing using the Java programming language. Data abstraction, object-oriented design. Introduction to data structures (linked lists, stacks, queues and trees.) Recursion. Sorting and searching.  (Lecture 2 hours, laboratory 3 hours.) Letter grade only (A-F).\nEffective Fall 2012.	22	25	2016-01-17 18:08:44.139-08	2016-01-17 17:53:03.954-08	2016-01-17 20:03:53.492-08	1	14	1
41	Object Oriented Programming and Data Structures	274	8214	ECS  Room 302	11-SEM	[{"day":"Fri","start":"13:00","end":"14:40"}]	Prerequisite: CECS 174 with a grade of "C" or better.\nDisciplined methods of design, coding and testing using the Java programming language. Data abstraction, object-oriented design. Introduction to data structures (linked lists, stacks, queues and trees.) Recursion. Sorting and searching.  (Lecture 2 hours, laboratory 3 hours.) Letter grade only (A-F).\nEffective Fall 2012.	16	25	2016-01-17 18:09:10.201-08	2016-01-17 17:53:03.957-08	2016-01-17 20:03:53.493-08	1	18	1
82	Software Design and Architecture	445	10990	ECS  Room 411	02-LAB	[{"day":"Tue","start":"12:00","end":"13:15"},{"day":"Thu","start":"12:00","end":"13:15"}]	Prerequisites: CECS 343 with a grade of "C" or better and Senior status. An in-depth look at software design, design patterns, frameworks, architectures and middleware architectures. Component based design including COM, Corba, and .Net. Fundamentals of software metrics, measuring software qualities. Basics of software evolution, reengineering, and reverse engineering. A semester long team project. \n(Lecture 2 hours, laboratory 3 hours.) Letter grade only (A-F).\nEffective Fall 2012.	1	25	2016-01-17 18:16:01.188-08	2016-01-17 17:53:03.997-08	2016-01-17 20:03:53.502-08	1	1	1
130	Advanced Computer Networking	672	10765	ECS  Room 302	04-SEM	[{"day":"Sat","start":"13:00","end":"15:45"}]	Prerequisite(s): CECS 474 with a grade of C or better.\nAdvanced concepts in computer network theory and practice. Computer network design and standards for local area networks (LANs) and wide area networks (WANs). Computer network configuration and performance issues.  Masters students register in CECS 572 or 672; Ph.D. students register in CECS 672. Additional projects required for CECS 672. (Lecture-problems 3 hours.) Letter grade only (A-F).  Effective Fall 2014.	20	22	2016-01-17 18:56:08.513-08	2016-01-17 17:53:04.051-08	2016-01-17 20:03:53.522-08	1	45	1
6	Critical Thinking in the Digital Information Age	100	5174	ECS  Room 405	08-LAB	[{"day":"Tue","start":"09:00","end":"10:15"},{"day":"Thu","start":"09:00","end":"10:15"}]	Prerequisite/Corequisite: ENGL 100 or its equivalent or GE Area A1.\nThis course will help students to libellus_apielop their critical thinking skills using technical software. The main topics will include: identifying engineering issues for investigation, libellus_apieloping planning and problem solving strategies, locating pertinent information and examples, critically analyzing these sources, forming and testing hypotheses, synthesizing and organizing results for effective communication, and libellus_apieloping transferable problem solving skills. (Lecture 2 hours, laboratory 3 hours)  Letter grade only (A-F).\nEffective Summer 2010.	9	25	2016-01-17 20:04:24.734-08	2016-01-17 17:53:03.922-08	2016-01-17 20:04:24.734-08	1	2	1
40	Object Oriented Programming and Data Structures	274	9954	ECS  Room 416	10-LAB	[{"day":"Tue","start":"09:00","end":"10:15"},{"day":"Thu","start":"09:00","end":"10:15"}]	Prerequisite: CECS 174 with a grade of "C" or better.\nDisciplined methods of design, coding and testing using the Java programming language. Data abstraction, object-oriented design. Introduction to data structures (linked lists, stacks, queues and trees.) Recursion. Sorting and searching.  (Lecture 2 hours, laboratory 3 hours.) Letter grade only (A-F).\nEffective Fall 2012.	15	25	2016-01-17 18:09:00.197-08	2016-01-17 17:53:03.955-08	2016-01-17 20:03:53.493-08	1	15	1
5	Critical Thinking in the Digital Information Age	100	5173	VEC  Room 519	07-SEM	[{"day":"Tue","start":"08:00","end":"08:50"},{"day":"Thu","start":"08:00","end":"08:50"}]	Prerequisite/Corequisite: ENGL 100 or its equivalent or GE Area A1.\nThis course will help students to libellus_apielop their critical thinking skills using technical software. The main topics will include: identifying engineering issues for investigation, libellus_apieloping planning and problem solving strategies, locating pertinent information and examples, critically analyzing these sources, forming and testing hypotheses, synthesizing and organizing results for effective communication, and libellus_apieloping transferable problem solving skills. (Lecture 2 hours, laboratory 3 hours)  Letter grade only (A-F).\nEffective Summer 2010.	9	25	2016-01-17 20:04:19.031-08	2016-01-17 17:53:03.918-08	2016-01-17 20:04:19.031-08	1	2	1
45	Object Oriented Application libellus_apielopment	277	6321	VEC  Room 402	05-SEM	[{"day":"Mon","start":"15:00","end":"15:50"},{"day":"Wed","start":"15:00","end":"15:50"}]	Prerequisite: CECS 274 with a grade of "C" or better .  Advanced introduction to the fundamentals of computer science and software engineering methodology. Advanced programming techniques and design methodology typically used in large programming projects using the Java programming language.  (Lecture 2 hours, laboratory 3 hours.) Letter grade only (A-F).  Effective Fall 2012.	20	25	2016-01-17 18:09:53.453-08	2016-01-17 17:53:03.959-08	2016-01-17 20:03:53.494-08	1	16	1
95	Introduction to Computer Security	478	10833	VEC  Room 418	03-SEM	[{"day":"Tue","start":"09:30","end":"10:20"},{"day":"Thu","start":"09:30","end":"10:20"}]	Prerequisite: CECS 328 with a grade of "C" or better.\nControlling the risk of computer security.  Security threats and vulnerabilities in the libellus_apielopment and use of computer systems.  Tools and controls that can reduce or block these threats.  Law, privacy and ethics.  Additional projects required for CECS 578.  \n(Lecture 2 hours, laboratory  3 hours.)  Letter grade only (A-F).	9	25	2016-01-17 18:49:48.84-08	2016-01-17 17:53:04.01-08	2016-01-17 20:03:53.508-08	1	37	1
98	Computer Engineering Senior Project II	490B	8265	ECS  Room 405	02-LAB	[{"day":"Mon","start":"20:00","end":"21:15"},{"day":"Wed","start":"20:00","end":"21:15"}]	Prerequisites: CECS 490A or CECS 491 and consent of the instructor.  Second of a two-semester capstone senior project in computer engineering that fulfills GE integrative learning. Student teams will build, program and verify operation of project started in prior design course.  Student teams must submit a written report, give an oral multimedia presentation and provide a working demonstration.(Lecture 2 hours, laboratory 3 hours) Letter Grade Only (A-F). Effective Fall 2014.	29	35	2016-01-17 18:50:15.285-08	2016-01-17 17:53:04.013-08	2016-01-17 20:03:53.509-08	1	38	1
100	Software Engineering Project II	491B	10027	ECS  Room 404	02-LAB	[{"day":"Tue","start":"18:00","end":"19:15"},{"day":"Thu","start":"18:00","end":"19:15"}]	Prerequisite: CECS 491A with a grade "C" or better.\nSecond course in a two-course capstone design sequence that fulfills integrative learning. Implementation, testing, packaging and deployment of the system designed in CECS 491A emphasizing written communication, teamwork and the Object-Oriented Methodology. \nLetter grade only (A-F). (Lecture 2 hours, laboratory 3 hours)	15	25	2016-01-17 18:50:34.475-08	2016-01-17 17:53:04.015-08	2016-01-17 20:03:53.51-08	1	35	1
102	Distributed and Cloud Computing Project I	492A	8661	ECS  Room 412	02-LAB	[{"day":"Tue","start":"20:30","end":"21:45"},{"day":"Thu","start":"20:30","end":"21:45"}]	Prerequisites: ENGR 350, CECS 327 and  343 all with a grade "C" or better.\nFirst course in a two-course capstone design sequence. Design of a distributed or cloud computing application. Design experience, including detailed requirement analysis, design decisions, teamwork, written reports and oral presentation.\nLetter grade only (A-F). (Lecture 2 hours, laboratory 3 hours)	18	25	2016-01-17 18:50:50.575-08	2016-01-17 17:53:04.018-08	2016-01-17 20:03:53.511-08	1	34	1
106	Advanced Analysis of Algorithms	528	4065	VEC  Room 330	01-SEM	[{"day":"Mon","start":"19:00","end":"20:15"},{"day":"Wed","start":"19:00","end":"20:15"}]	Prerequisites: CECS 328, MATH 380 or EE 380 with a grade of "C" or better.\nTheoretical analysis of algorithms. Divide and conquer, dynamic programming and greedy algorithms; basic search and traversal techniques including search trees; sorting; matrix manipulations; NP-completeness. \nMaster's students register in CECS 528 or 628; Ph.D. students register in CECS 628. Additional projects required for CECS 628. (Lecture/problems 3 hours.) Letter grade only (A-F). Effective Fall 2012.	23	26	2016-01-17 18:51:30.287-08	2016-01-17 17:53:04.022-08	2016-01-17 20:03:53.511-08	1	41	1
107	Advanced Analysis of Algorithms	528	6813	ECS  Room 302	02-SEM	[{"day":"Fri","start":"10:00","end":"12:45"}]	Prerequisites: CECS 328, MATH 380 or EE 380 with a grade of "C" or better.\nTheoretical analysis of algorithms. Divide and conquer, dynamic programming and greedy algorithms; basic search and traversal techniques including search trees; sorting; matrix manipulations; NP-completeness. \nMaster's students register in CECS 528 or 628; Ph.D. students register in CECS 628. Additional projects required for CECS 628. (Lecture/problems 3 hours.) Letter grade only (A-F). Effective Fall 2012.	19	26	2016-01-17 18:51:37.931-08	2016-01-17 17:53:04.023-08	2016-01-17 20:03:53.512-08	1	41	1
108	Adv Computer Architecture II	531	4600	VEC  Room 330	01-SEM	[{"day":"Tue","start":"18:30","end":"19:45"},{"day":"Thu","start":"18:30","end":"19:45"}]	Prerequisite: CECS 530 with a grade of "C" or better.\nAdvanced computer architecture with emphasis on parallel processing. Vector processors and multiprocessor systems. Dataflow computation. RISC/CISC. Hypercube. Parallel software. Applications in artificial intelligence, signal/image processing, neural network and optical computing. \nMaster's students register in CECS 531 or 631; Ph.D. students register in CECS 631. Additional projects required for CECS 631. (Lecture-problems 3 hours.) Letter grade only (A-F). Effective Fall 2012.	10	26	2016-01-17 18:51:51.68-08	2016-01-17 17:53:04.024-08	2016-01-17 20:03:53.512-08	1	27	1
109	Advanced Artificial Intelligence	551	4829	VEC  Room 402	01-SEM	[{"day":"Mon","start":"17:30","end":"18:45"},{"day":"Wed","start":"17:30","end":"18:45"}]	Prerequisite: CECS 451  with a grade of "C" or better. \nAdvanced concepts in artificial intelligence. Topics include knowledge acquisition and representation, fuzzy logic, logical reasoning, multi-sensor integration, Dempster-Shafer's theory of evidential reasoning, real-time expert systems and neural networks. \nMaster's students register in CECS 551 or 651; Ph.D. students register in CECS 651.Additional projects required for CECS 651. (Lecture-problems 3 hours.) Letter grade only (A-F). Effective Fall 2012.	18	26	2016-01-17 18:52:03.483-08	2016-01-17 17:53:04.024-08	2016-01-17 20:03:53.513-08	1	41	1
11	Critical Thinking in the Digital Information Age	100	6313	VEC  Room 418	13-SEM	[{"day":"Mon","start":"11:00","end":"11:50"},{"day":"Wed","start":"11:00","end":"11:50"}]	Prerequisite/Corequisite: ENGL 100 or its equivalent or GE Area A1.\nThis course will help students to libellus_apielop their critical thinking skills using technical software. The main topics will include: identifying engineering issues for investigation, libellus_apieloping planning and problem solving strategies, locating pertinent information and examples, critically analyzing these sources, forming and testing hypotheses, synthesizing and organizing results for effective communication, and libellus_apieloping transferable problem solving skills. (Lecture 2 hours, laboratory 3 hours)  Letter grade only (A-F).\nEffective Summer 2010.	23	25	2016-01-17 17:54:03.211-08	2016-01-17 17:53:03.927-08	2016-01-17 20:03:53.485-08	1	1	1
14	Critical Thinking in the Digital Information Age	100	8159	ECS  Room 404	18-LAB	[{"day":"Mon","start":"20:00","end":"21:15"},{"day":"Wed","start":"20:00","end":"21:15"}]	Prerequisite/Corequisite: ENGL 100 or its equivalent or GE Area A1.\nThis course will help students to libellus_apielop their critical thinking skills using technical software. The main topics will include: identifying engineering issues for investigation, libellus_apieloping planning and problem solving strategies, locating pertinent information and examples, critically analyzing these sources, forming and testing hypotheses, synthesizing and organizing results for effective communication, and libellus_apieloping transferable problem solving skills. (Lecture 2 hours, laboratory 3 hours)  Letter grade only (A-F).\nEffective Summer 2010.	10	25	2016-01-17 17:54:20.86-08	2016-01-17 17:53:03.929-08	2016-01-17 20:03:53.486-08	1	4	1
26	Computer Logic Design I	201	5990	VEC  Room 418	09-SEM	[{"day":"Mon","start":"19:00","end":"19:50"},{"day":"Wed","start":"19:00","end":"19:50"}]	Prerequisite: MATH 113 or equivalent with a grade of "C" or better .\nBasic topics in combinational and sequential switching circuits with applications to the design of digital libellus_apiices.  Introduction to Electronic Design Automation (EDA) tools. Laboratory projects with Field Programmable Gate Arrays (FPGA).(Lecture 2 hours, lab 3 hours.) Letter grade only (A-F).  \nEffective Fall 2012.	20	25	2016-01-17 18:02:10.142-08	2016-01-17 17:53:03.946-08	2016-01-17 20:03:53.491-08	1	10	1
112	Topics Distributed Computer Syst	574	10076	ECS  Room 204	01-SEM	[{"day":"Tue","start":"14:00","end":"15:15"},{"day":"Thu","start":"14:00","end":"15:15"}]	Prerequisite: CECS 526 or 572 or 626 or 672  with a grade of "C" or better.  (Master's students register in CECS 574; Ph.D. students register in CECS 674.) Network operating systems vs distributed operating systems, research and design issues of distributed operating systems, resources and resource management in distributed systems, communication security and user authentication. \nAdditional projects required for Ph.D. students. (Lecture-problems 3 hours.) Letter grade only (A-F). Effective Fall 2012.	15	26	2016-01-17 18:52:39.581-08	2016-01-17 17:53:04.028-08	2016-01-17 20:03:53.514-08	1	42	1
113	Selected Topics in Computer Science	590	8292	ECS  Room 302	01-SEM	[{"day":"Mon","start":"17:30","end":"18:45"},{"day":"Wed","start":"17:30","end":"18:45"}]	Prerequisites: Graduate standing and consent of instructor. \nEach offering is based on an area in computer science and technology in which recent advances have been made. \nMaster's students register in CECS 590 or 690; Ph.D. students register in CECS 690. Additional projects required for CECS 690. (Lecture-problems 3 hours.) May be repeated to a maximum of 6 units with consent of department. Letter grade only (A-F).	9	26	2016-01-17 18:52:47.984-08	2016-01-17 17:53:04.029-08	2016-01-17 20:03:53.514-08	1	40	1
114	Selected Topics in Computer Science	590	10078	VEC  Room 401	02-SEM	[{"day":"Mon","start":"09:30","end":"10:45"},{"day":"Wed","start":"09:30","end":"10:45"}]	Prerequisites: Graduate standing and consent of instructor. \nEach offering is based on an area in computer science and technology in which recent advances have been made. \nMaster's students register in CECS 590 or 690; Ph.D. students register in CECS 690. Additional projects required for CECS 690. (Lecture-problems 3 hours.) May be repeated to a maximum of 6 units with consent of department. Letter grade only (A-F).	1	26	2016-01-17 18:52:57.282-08	2016-01-17 17:53:04.03-08	2016-01-17 20:03:53.514-08	1	24	1
133	Selected Topics in Computer Science	690	10079	VEC  Room 401	02-SEM	[{"day":"Mon","start":"09:30","end":"10:45"},{"day":"Wed","start":"09:30","end":"10:45"}]	Prerequisites: Graduate standing and consent of instructor.\nEach offering is based on an area in computer science and technology in which recent advances have been made. \nMaster's students register in CECS 590 or 690; Ph.D. students register in CECS 690. Additional projects required for CECS 690. (Lecture-problems 3 hours.) May be repeated to a maximum of 6 units with consent of department. Letter grade only (A-F).	1	26	2016-01-17 18:56:30.769-08	2016-01-17 17:53:04.055-08	2016-01-17 20:03:53.523-08	1	24	1
134	Selected Topics in Computer Science	690	11001	VEC  Room 402	03-SEM	[{"day":"Fri","start":"15:00","end":"17:45"}]	Prerequisites: Graduate standing and consent of instructor.\nEach offering is based on an area in computer science and technology in which recent advances have been made. \nMaster's students register in CECS 590 or 690; Ph.D. students register in CECS 690. Additional projects required for CECS 690. (Lecture-problems 3 hours.) May be repeated to a maximum of 6 units with consent of department. Letter grade only (A-F).	7	26	2016-01-17 18:56:37.813-08	2016-01-17 17:53:04.055-08	2016-01-17 20:03:53.523-08	1	25	1
136	Directed Research	697	9073	TBA	17-SUP	[]	Prerequisite: Classified Graduate standing. \nTheoretical and experimental problems in computer science and engineering requiring extensive research.  Advancement to candidacy and program GPA of at least 3.0 are required. Graduate advisor and project supervisor must be consulted prior to registration. Independent Study.\n Letter grade only (A-F). \nEffective Fall 2012.	1	2	2016-01-17 18:56:52.774-08	2016-01-17 17:53:04.059-08	2016-01-17 20:03:53.523-08	1	40	1
42	Object Oriented Programming and Data Structures	274	8215	ECS  Room 416	12-LAB	[{"day":"Fri","start":"15:00","end":"17:30"}]	Prerequisite: CECS 174 with a grade of "C" or better.\nDisciplined methods of design, coding and testing using the Java programming language. Data abstraction, object-oriented design. Introduction to data structures (linked lists, stacks, queues and trees.) Recursion. Sorting and searching.  (Lecture 2 hours, laboratory 3 hours.) Letter grade only (A-F).\nEffective Fall 2012.	16	25	2016-01-17 18:09:22.843-08	2016-01-17 17:53:03.958-08	2016-01-17 20:03:53.493-08	1	18	1
54	Database Fundamentals	323	8254	ECS  Room 407	08-LAB	[{"day":"Mon","start":"18:00","end":"19:15"},{"day":"Wed","start":"18:00","end":"19:15"}]	Prerequisites: CECS 228 and CECS 277 or CECS 282 all with a grade of C or better. \nFundamental topics on database management. Topics include entity-relationship models, database design, data definition language, the relational model, data manipulation language, database application programming and normalization. \nLetter grade only (A-F). (Lecture 2 hours, laboratory 3 hours.)  Effective Fall 2014.	23	25	2016-01-17 18:12:13.549-08	2016-01-17 17:53:03.967-08	2016-01-17 20:03:53.496-08	1	18	1
110	Hardware/Software Co-design	561	10131	VEC  Room 402	01-SEM	[{"day":"Tue","start":"09:30","end":"10:20"},{"day":"Thu","start":"09:30","end":"10:20"}]	Prerequisite: CECS 341 or 440 with a grade of "C" or better.  Introduction to top-down methods for hardware/software system-on-chip co-design.  Design flow  system specification, software implementation, hardware synthesis, system design, and verification.  Process optimization with various design decisions emphasized.  Projects/case studies using system-level design methods and tools.  Additional projects required for CECS 561.  (Lecture 2 hours, laboratory  3 hours.)  Letter grade only (A-F).  Effective Fall 2012.	15	25	2016-01-17 18:52:12.629-08	2016-01-17 17:53:04.025-08	2016-01-17 20:03:53.513-08	1	32	1
43	Object Oriented Programming and Data Structures	274	9064	ECS  Room 308	13-SEM	[{"day":"Tue","start":"19:30","end":"20:20"},{"day":"Thu","start":"19:30","end":"20:20"}]	Prerequisite: CECS 174 with a grade of "C" or better.\nDisciplined methods of design, coding and testing using the Java programming language. Data abstraction, object-oriented design. Introduction to data structures (linked lists, stacks, queues and trees.) Recursion. Sorting and searching.  (Lecture 2 hours, laboratory 3 hours.) Letter grade only (A-F).\nEffective Fall 2012.	4	25	2016-01-17 18:09:36.198-08	2016-01-17 17:53:03.958-08	2016-01-17 20:03:53.493-08	1	18	1
111	Hardware/Software Co-design	561	10130	ECS  Room 411	02-LAB	[{"day":"Tue","start":"10:30","end":"11:45"},{"day":"Thu","start":"10:30","end":"11:45"}]	Prerequisite: CECS 341 or 440 with a grade of "C" or better.  Introduction to top-down methods for hardware/software system-on-chip co-design.  Design flow  system specification, software implementation, hardware synthesis, system design, and verification.  Process optimization with various design decisions emphasized.  Projects/case studies using system-level design methods and tools.  Additional projects required for CECS 561.  (Lecture 2 hours, laboratory  3 hours.)  Letter grade only (A-F).  Effective Fall 2012.	15	25	2016-01-17 18:52:30.628-08	2016-01-17 17:53:04.028-08	2016-01-17 20:03:53.513-08	1	32	1
48	Design of Dynamic Web Sites	300	10927	ECS  Room 413	04-LAB	[{"day":"Fri","start":"12:00","end":"14:45"}]	Prerequisite: CECS 200 with a grade of "C" or better. \nDynamic Web design using modern tools. Creation of domains, using hosting services and content management systems. Website portability, usability and accessibility.\nLetter grade only (A-F). (Lecture 2 hours, laboratory 3 hours).\nEffective Fall 2012.	24	25	2016-01-17 18:10:25.541-08	2016-01-17 17:53:03.962-08	2016-01-17 20:03:53.495-08	1	17	1
50	Computer Logic Design II	301	2400	ECS  Room 416	02-LAB	[{"day":"Mon","start":"16:00","end":"17:15"},{"day":"Wed","start":"16:00","end":"17:15"}]	Prerequisites: CECS 174, 201 with a grade of "C" or better.  Sequential logic emphasizing Finite State Machine design & analysis, timing analysis of sequential logic, Introduction to Data Path, Control and Memory. Use of Electronic Design Automation (EDA) tools for design, simulation, verification. Laboratory projects with Field Programmable Gate Arrays (FPGA's). (Lecture 2 hours, laboratory 3 hours) Letter grade only (A-F).  Effective Fall 2014.	23	25	2016-01-17 18:11:47.645-08	2016-01-17 17:53:03.963-08	2016-01-17 20:03:53.495-08	1	19	1
76	Computer Architecture	440	10017	ECS  Room 412	04-LAB	[{"day":"Tue","start":"16:30","end":"17:45"},{"day":"Thu","start":"16:30","end":"17:45"}]	Prerequisite: CECS 346 with a grade of "C" or better.  Review of logic design. Register transfer and micro-operations. Basic computer organization. Central processor organization. Microprogram control organization. Arithmetic processor design. Arithmetic algorithms. Input-output organization. Memory organization.  (Lecture 2 hours, laboratory 3 hours.) Letter grade only (A-F).  Effective Fall 2012.	9	25	2016-01-17 18:14:47.873-08	2016-01-17 17:53:03.99-08	2016-01-17 20:03:53.501-08	1	27	1
96	Introduction to Computer Security	478	10834	ECS  Room 403	04-LAB	[{"day":"Tue","start":"10:30","end":"11:45"},{"day":"Thu","start":"10:30","end":"11:45"}]	Prerequisite: CECS 328 with a grade of "C" or better.\nControlling the risk of computer security.  Security threats and vulnerabilities in the libellus_apielopment and use of computer systems.  Tools and controls that can reduce or block these threats.  Law, privacy and ethics.  Additional projects required for CECS 578.  \n(Lecture 2 hours, laboratory  3 hours.)  Letter grade only (A-F).	9	25	2016-01-17 18:49:58.032-08	2016-01-17 17:53:04.012-08	2016-01-17 20:03:53.508-08	1	37	1
99	Software Engineering Project II	491B	10026	ECS  Room 302	01-SEM	[{"day":"Tue","start":"17:00","end":"17:50"},{"day":"Thu","start":"17:00","end":"17:50"}]	Prerequisite: CECS 491A with a grade "C" or better.\nSecond course in a two-course capstone design sequence that fulfills integrative learning. Implementation, testing, packaging and deployment of the system designed in CECS 491A emphasizing written communication, teamwork and the Object-Oriented Methodology. \nLetter grade only (A-F). (Lecture 2 hours, laboratory 3 hours)	15	25	2016-01-17 18:50:25.581-08	2016-01-17 17:53:04.014-08	2016-01-17 20:03:53.51-08	1	35	1
\.


--
-- Name: classes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: libellus_api
--

SELECT pg_catalog.setval('classes_id_seq', 140, true);


--
-- Data for Name: subjects; Type: TABLE DATA; Schema: public; Owner: libellus_api
--

COPY subjects (id, name, code, "createdAt", "updatedAt") FROM stdin;
1	Computer Engr & Computer Sci	CECS	2016-01-17 17:53:03.567-08	2016-01-17 17:53:03.567-08
\.


--
-- Name: subjects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: libellus_api
--

SELECT pg_catalog.setval('subjects_id_seq', 1, true);


--
-- Data for Name: teachers; Type: TABLE DATA; Schema: public; Owner: libellus_api
--

COPY teachers (id, name, rate, "rateLink", "rateLastUpdated", "createdAt", "updatedAt") FROM stdin;
1	Hubert Huynh	\N	\N	\N	2016-01-17 17:53:03.566-08	2016-01-17 17:53:03.566-08
4	Staff	\N	\N	\N	2016-01-17 17:53:03.587-08	2016-01-17 17:53:03.587-08
10	Daniel Cregg	\N	\N	\N	2016-01-17 17:53:03.606-08	2016-01-17 17:53:03.606-08
15	Katherine Varela	\N	\N	\N	2016-01-17 17:53:03.623-08	2016-01-17 17:53:03.623-08
23	Ratana Ngo	\N	\N	\N	2016-01-17 17:53:03.641-08	2016-01-17 17:53:03.641-08
27	Michael Chelian	\N	\N	\N	2016-01-17 17:53:03.655-08	2016-01-17 17:53:03.655-08
32	Min He	\N	\N	\N	2016-01-17 17:53:03.667-08	2016-01-17 17:53:03.667-08
35	Frank Murgolo	\N	\N	\N	2016-01-17 17:53:03.674-08	2016-01-17 17:53:03.674-08
40	Birgit Penzenstadler	\N	\N	\N	2016-01-17 17:53:03.685-08	2016-01-17 17:53:03.685-08
2	Elleni Wolde	\N	\N	\N	2016-01-17 17:53:03.567-08	2016-01-17 17:53:03.567-08
3	Maria Laurent-Rice	\N	\N	\N	2016-01-17 17:53:03.565-08	2016-01-17 17:53:03.565-08
5	Tyler Nguyen	\N	\N	\N	2016-01-17 17:53:03.587-08	2016-01-17 17:53:03.587-08
6	Roni Allen	\N	\N	\N	2016-01-17 17:53:03.59-08	2016-01-17 17:53:03.59-08
7	Alvaro Monge	\N	\N	\N	2016-01-17 17:53:03.59-08	2016-01-17 17:53:03.59-08
8	Rezvan Ramezani	\N	\N	\N	2016-01-17 17:53:03.591-08	2016-01-17 17:53:03.591-08
9	Brian Lojeck	\N	\N	\N	2016-01-17 17:53:03.605-08	2016-01-17 17:53:03.605-08
11	Rodney Schaerer	\N	\N	\N	2016-01-17 17:53:03.607-08	2016-01-17 17:53:03.607-08
12	Karen Yang	\N	\N	\N	2016-01-17 17:53:03.609-08	2016-01-17 17:53:03.609-08
13	Mehrdad Aliasgari	\N	\N	\N	2016-01-17 17:53:03.609-08	2016-01-17 17:53:03.609-08
14	Steven Gold	\N	\N	\N	2016-01-17 17:53:03.623-08	2016-01-17 17:53:03.623-08
16	Susan Nachawati	\N	\N	\N	2016-01-17 17:53:03.626-08	2016-01-17 17:53:03.626-08
17	David Winter	\N	\N	\N	2016-01-17 17:53:03.625-08	2016-01-17 17:53:03.625-08
18	David Brown	\N	\N	\N	2016-01-17 17:53:03.627-08	2016-01-17 17:53:03.627-08
19	Robert Allison	\N	\N	\N	2016-01-17 17:53:03.638-08	2016-01-17 17:53:03.638-08
20	Samuel Stokes	\N	\N	\N	2016-01-17 17:53:03.638-08	2016-01-17 17:53:03.638-08
21	Thinh Nguyen	\N	\N	\N	2016-01-17 17:53:03.64-08	2016-01-17 17:53:03.64-08
22	Pouye Sedighian	\N	\N	\N	2016-01-17 17:53:03.641-08	2016-01-17 17:53:03.641-08
24	Bo Fu	\N	\N	\N	2016-01-17 17:53:03.652-08	2016-01-17 17:53:03.652-08
25	Roman Tankelevich	\N	\N	\N	2016-01-17 17:53:03.653-08	2016-01-17 17:53:03.653-08
26	Leonardo Rodriguez	\N	\N	\N	2016-01-17 17:53:03.652-08	2016-01-17 17:53:03.652-08
28	Darin Goldstein	\N	\N	\N	2016-01-17 17:53:03.655-08	2016-01-17 17:53:03.655-08
29	Sen Wang	\N	\N	\N	2016-01-17 17:53:03.661-08	2016-01-17 17:53:03.661-08
30	Ashkan Eghbal	\N	\N	\N	2016-01-17 17:53:03.662-08	2016-01-17 17:53:03.662-08
31	Phuong Nguyen	\N	\N	\N	2016-01-17 17:53:03.666-08	2016-01-17 17:53:03.666-08
33	Ramin Moazzeni	\N	\N	\N	2016-01-17 17:53:03.668-08	2016-01-17 17:53:03.668-08
34	Maged Boctor	\N	\N	\N	2016-01-17 17:53:03.675-08	2016-01-17 17:53:03.675-08
36	Nathan Pickrell	\N	\N	\N	2016-01-17 17:53:03.676-08	2016-01-17 17:53:03.676-08
37	Anthony Giacalone	\N	\N	\N	2016-01-17 17:53:03.676-08	2016-01-17 17:53:03.676-08
38	Brewer Ward	\N	\N	\N	2016-01-17 17:53:03.677-08	2016-01-17 17:53:03.677-08
39	Shadnaz Asgari	\N	\N	\N	2016-01-17 17:53:03.683-08	2016-01-17 17:53:03.683-08
41	Todd Ebert	\N	\N	\N	2016-01-17 17:53:03.685-08	2016-01-17 17:53:03.685-08
42	Oscar Morales Ponce	\N	\N	\N	2016-01-17 17:53:03.686-08	2016-01-17 17:53:03.686-08
43	Michael Hoffman	\N	\N	\N	2016-01-17 17:53:03.687-08	2016-01-17 17:53:03.687-08
44	Shui-Fung Lam	\N	\N	\N	2016-01-17 17:53:03.691-08	2016-01-17 17:53:03.691-08
45	Jose Tamayo	\N	\N	\N	2016-01-17 17:53:03.693-08	2016-01-17 17:53:03.693-08
\.


--
-- Name: teachers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: libellus_api
--

SELECT pg_catalog.setval('teachers_id_seq', 45, true);


--
-- Data for Name: terms; Type: TABLE DATA; Schema: public; Owner: libellus_api
--

COPY terms (id, name, "createdAt", "updatedAt") FROM stdin;
1	Spring 2016	2016-01-17 17:53:03.555-08	2016-01-17 17:53:03.555-08
\.


--
-- Name: terms_id_seq; Type: SEQUENCE SET; Schema: public; Owner: libellus_api
--

SELECT pg_catalog.setval('terms_id_seq', 1, true);


--
-- Name: classes_pkey; Type: CONSTRAINT; Schema: public; Owner: libellus_api; Tablespace:
--

ALTER TABLE ONLY classes
    ADD CONSTRAINT classes_pkey PRIMARY KEY (id);


--
-- Name: subjects_pkey; Type: CONSTRAINT; Schema: public; Owner: libellus_api; Tablespace:
--

ALTER TABLE ONLY subjects
    ADD CONSTRAINT subjects_pkey PRIMARY KEY (id);


--
-- Name: teachers_pkey; Type: CONSTRAINT; Schema: public; Owner: libellus_api; Tablespace:
--

ALTER TABLE ONLY teachers
    ADD CONSTRAINT teachers_pkey PRIMARY KEY (id);


--
-- Name: terms_pkey; Type: CONSTRAINT; Schema: public; Owner: libellus_api; Tablespace:
--

ALTER TABLE ONLY terms
    ADD CONSTRAINT terms_pkey PRIMARY KEY (id);


--
-- Name: classes_subjectId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: libellus_api
--

ALTER TABLE ONLY classes
    ADD CONSTRAINT "classes_subjectId_fkey" FOREIGN KEY ("subjectId") REFERENCES subjects(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: classes_teacherId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: libellus_api
--

ALTER TABLE ONLY classes
    ADD CONSTRAINT "classes_teacherId_fkey" FOREIGN KEY ("teacherId") REFERENCES teachers(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: classes_termId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: libellus_api
--

ALTER TABLE ONLY classes
    ADD CONSTRAINT "classes_termId_fkey" FOREIGN KEY ("termId") REFERENCES terms(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: public; Type: ACL; Schema: -; Owner: libellus_api
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM libellus_api;
GRANT ALL ON SCHEMA public TO libellus_api;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- libellus_apiQL database dump complete
--
