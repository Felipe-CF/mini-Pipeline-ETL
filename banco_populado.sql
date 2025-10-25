--
-- PostgreSQL database dump
--

-- Dumped from database version 17.0
-- Dumped by pg_dump version 17.0

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories (
    category_id integer NOT NULL,
    category_name character varying(100) NOT NULL,
    filter_id integer NOT NULL
);


ALTER TABLE public.categories OWNER TO postgres;

--
-- Name: categories_category_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categories_category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.categories_category_id_seq OWNER TO postgres;

--
-- Name: categories_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categories_category_id_seq OWNED BY public.categories.category_id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    product_id integer NOT NULL,
    product_id_url character varying(255) NOT NULL,
    product_name character varying(255) NOT NULL,
    product_url text NOT NULL,
    part_number character varying(100) NOT NULL,
    brand_name character varying(100) NOT NULL,
    product_price numeric(16,2) NOT NULL,
    filter_id integer,
    photo_url text NOT NULL,
    stock_quantity integer DEFAULT 0,
    product_gross_weight numeric(16,2) NOT NULL,
    product_width numeric(16,2) NOT NULL,
    product_length numeric(16,2) NOT NULL,
    warranty character varying(255) NOT NULL,
    material character varying(255) NOT NULL
);


ALTER TABLE public.products OWNER TO postgres;

--
-- Name: products_product_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.products_product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.products_product_id_seq OWNER TO postgres;

--
-- Name: products_product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.products_product_id_seq OWNED BY public.products.product_id;


--
-- Name: categories category_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories ALTER COLUMN category_id SET DEFAULT nextval('public.categories_category_id_seq'::regclass);


--
-- Name: products product_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products ALTER COLUMN product_id SET DEFAULT nextval('public.products_product_id_seq'::regclass);


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categories (category_id, category_name, filter_id) FROM stdin;
1	FREIOS	1
2	MOTOR	2
3	SUSPENSÃO E DIREÇÃO	3
4	SISTEMA ELÉTRICO	4
5	TRANSMISSÃO	5
6	FILTROS	6
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products (product_id, product_id_url, product_name, product_url, part_number, brand_name, product_price, filter_id, photo_url, stock_quantity, product_gross_weight, product_width, product_length, warranty, material) FROM stdin;
1	f5a28cfb-9c1d-401d-831c-2cfaedecf08e	BATERIA AUTOMOTIVA	https://api.devmka.online/products/f5a28cfb-9c1d-401d-831c-2cfaedecf08e	MN797-3466G	ACDELCO	1258.44	1	https://picsum.photos/seed/MN797-3466G/200/300	80	10.71	25.70	66.10	Aço Carbono 	12
3	1f426610-cf10-4a93-90be-450b235800cd	AMORTECEDOR DIANTEIRO	https://api.devmka.online/products/1f426610-cf10-4a93-90be-450b235800cd	RS121-7061F	MONROE	81.99	1	https://picsum.photos/seed/RS121-7061F/200/300	173	11.06	46.70	69.20	Cerâmica 	12
4	832ca072-277d-4cab-b86f-ecdd97a70e12	FILTRO DE ÓLEO	https://api.devmka.online/products/832ca072-277d-4cab-b86f-ecdd97a70e12	UX194-2319D	BOSCH	378.70	1	https://picsum.photos/seed/UX194-2319D/200/300	176	13.89	18.40	55.50	Aço Carbono 	12
5	76d32187-e949-4159-b82d-62a85de055fc	BICO INJETOR	https://api.devmka.online/products/76d32187-e949-4159-b82d-62a85de055fc	LW306-3754K	BOSCH	802.07	1	https://picsum.photos/seed/LW306-3754K/200/300	74	11.09	34.40	28.90	Borracha Sintética 	12
7	79e76da4-1968-4adf-bd21-3364dc9fad9c	FILTRO DE AR DO MOTOR	https://api.devmka.online/products/79e76da4-1968-4adf-bd21-3364dc9fad9c	AP484-9890D	BOSCH	1234.79	1	https://picsum.photos/seed/AP484-9890D/200/300	69	4.03	28.20	21.10	Borracha Sintética 	12
8	55463ee5-e342-49c4-b22e-49b4f1e304bc	FILTRO DE COMBUSTÍVEL	https://api.devmka.online/products/55463ee5-e342-49c4-b22e-49b4f1e304bc	MY930-8140D	MARELLI	905.61	1	https://picsum.photos/seed/MY930-8140D/200/300	30	3.51	24.80	93.60	Cerâmica 	12
10	4ba48397-0258-4e6d-8f15-3749fa7b1c21	SONDA LAMBDA	https://api.devmka.online/products/4ba48397-0258-4e6d-8f15-3749fa7b1c21	AD104-3390R	NGK	1069.59	1	https://picsum.photos/seed/AD104-3390R/200/300	2	2.92	14.10	71.50	Alumínio 	12
11	d229239e-3484-491c-9ba4-e0a4e81f137b	ALTERNADOR	https://api.devmka.online/products/d229239e-3484-491c-9ba4-e0a4e81f137b	RA803-3997O	BREMBO	1445.00	1	https://picsum.photos/seed/RA803-3997O/200/300	158	9.65	39.90	84.60	Aço Carbono 	12
14	b59898f0-8699-45f6-826d-9c6429bbe170	JUNTA HOMOCINÉTICA	https://api.devmka.online/products/b59898f0-8699-45f6-826d-9c6429bbe170	ES367-6816S	MONROE	229.64	1	https://picsum.photos/seed/ES367-6816S/200/300	82	1.12	12.90	18.30	Borracha Sintética 	12
15	1f509953-57fc-4af2-8a5a-3e240fdfb47d	ROLAMENTO DE RODA	https://api.devmka.online/products/1f509953-57fc-4af2-8a5a-3e240fdfb47d	RW517-3172G	NGK	376.89	1	https://picsum.photos/seed/RW517-3172G/200/300	107	13.18	30.00	67.00	Borracha Sintética 	12
16	9bc4cbbe-2255-4e32-ab83-598bf61b0019	VELA DE IGNIÇÃO	https://api.devmka.online/products/9bc4cbbe-2255-4e32-ab83-598bf61b0019	SY969-0220T	NGK	449.16	1	https://picsum.photos/seed/SY969-0220T/200/300	101	14.98	44.50	29.20	Aço Carbono 	12
17	9eb6a971-819a-43f5-9f88-cb0e53f7de57	PASTILHA DE FREIO	https://api.devmka.online/products/9eb6a971-819a-43f5-9f88-cb0e53f7de57	YB182-1273Q	SKF	476.65	1	https://picsum.photos/seed/YB182-1273Q/200/300	99	3.12	31.50	74.80	Aço Carbono 	12
18	d7af833b-e3b0-41ec-99fc-f2ac9b1cd749	TERMINAL DE DIREÇÃO	https://api.devmka.online/products/d7af833b-e3b0-41ec-99fc-f2ac9b1cd749	HR829-5995S	BREMBO	826.40	1	https://picsum.photos/seed/HR829-5995S/200/300	66	1.06	33.70	79.70	Aço Carbono 	12
20	e748d9f5-dfb1-40fb-9bcd-b533ccf191ac	MOTOR DE PARTIDA	https://api.devmka.online/products/e748d9f5-dfb1-40fb-9bcd-b533ccf191ac	UV884-2693A	MONROE	369.73	1	https://picsum.photos/seed/UV884-2693A/200/300	48	6.45	32.10	98.60	Cerâmica 	12
23	fb1d2633-f52d-4893-a266-14a706fe25fe	RADIADOR	https://api.devmka.online/products/fb1d2633-f52d-4893-a266-14a706fe25fe	VD331-2613J	SKF	1236.17	1	https://picsum.photos/seed/VD331-2613J/200/300	32	14.27	8.30	28.20	Borracha Sintética 	12
24	a9b3fa6f-68ca-4bae-a949-6fcd6646be5b	PIVÔ DE SUSPENSÃO	https://api.devmka.online/products/a9b3fa6f-68ca-4bae-a949-6fcd6646be5b	LZ951-9003T	NGK	714.60	1	https://picsum.photos/seed/LZ951-9003T/200/300	155	9.14	31.90	18.10	Cerâmica 	12
25	8c3383cb-6c39-47d4-89b1-d80d145f9d55	BOMBA DE COMBUSTÍVEL	https://api.devmka.online/products/8c3383cb-6c39-47d4-89b1-d80d145f9d55	BC134-5982S	ACDELCO	1221.04	1	https://picsum.photos/seed/BC134-5982S/200/300	41	6.24	28.40	58.30	Cerâmica 	12
29	6a263920-b98e-4789-a0ce-ad17dd3c2793	DISCO DE FREIO	https://api.devmka.online/products/6a263920-b98e-4789-a0ce-ad17dd3c2793	QO046-3830E	MONROE	821.80	1	https://picsum.photos/seed/QO046-3830E/200/300	95	6.68	49.30	25.30	Alumínio 	12
33	99ac7afb-ea6b-470c-a485-960fb16eb382	KIT DE EMBREAGEM	https://api.devmka.online/products/99ac7afb-ea6b-470c-a485-960fb16eb382	WI737-3453E	MARELLI	685.69	1	https://picsum.photos/seed/WI737-3453E/200/300	102	3.45	26.90	72.00	Aço Carbono 	12
36	a51a9867-4a4c-4698-bbfb-b58f3d4e1761	CORREIA DENTADA	https://api.devmka.online/products/a51a9867-4a4c-4698-bbfb-b58f3d4e1761	YS135-0927H	BOSCH	1266.39	1	https://picsum.photos/seed/YS135-0927H/200/300	44	5.75	8.30	97.90	Borracha Sintética 	12
\.


--
-- Name: categories_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categories_category_id_seq', 12, true);


--
-- Name: products_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.products_product_id_seq', 11048, true);


--
-- Name: categories categories_category_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_category_name_key UNIQUE (category_name);


--
-- Name: categories categories_filter_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_filter_id_key UNIQUE (filter_id);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (category_id);


--
-- Name: products products_part_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_part_number_key UNIQUE (part_number);


--
-- Name: products products_photo_url_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_photo_url_key UNIQUE (photo_url);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (product_id);


--
-- Name: products products_product_id_url_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_product_id_url_key UNIQUE (product_id_url);


--
-- Name: products products_product_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_product_name_key UNIQUE (product_name);


--
-- Name: products products_product_url_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_product_url_key UNIQUE (product_url);


--
-- Name: products products_filter_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_filter_id_fkey FOREIGN KEY (filter_id) REFERENCES public.categories(filter_id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

