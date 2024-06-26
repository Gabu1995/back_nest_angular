PGDMP                       |            Producto    16.2    16.2 #    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    16442    Producto    DATABASE        CREATE DATABASE "Producto" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Spanish_Ecuador.1252';
    DROP DATABASE "Producto";
                postgres    false            �            1255    49614 .   actualizar_cliente(integer, character varying)    FUNCTION     �   CREATE FUNCTION public.actualizar_cliente(id_cedula integer, nuevo_nombre_cliente character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE cliente SET nombre_cliente = nuevo_nombre_cliente WHERE id_cedula = id_cedula;
END;
$$;
 d   DROP FUNCTION public.actualizar_cliente(id_cedula integer, nuevo_nombre_cliente character varying);
       public          postgres    false            �            1255    49615 /   actualizar_cliente1(integer, character varying)    FUNCTION     �   CREATE FUNCTION public.actualizar_cliente1(p_id_cedula integer, nuevo_nombre_cliente character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE cliente SET nombre_cliente = nuevo_nombre_cliente WHERE id_cedula = p_id_cedula;
END;
$$;
 g   DROP FUNCTION public.actualizar_cliente1(p_id_cedula integer, nuevo_nombre_cliente character varying);
       public          postgres    false            �            1255    49616    eliminar_cliente(integer)    FUNCTION     �   CREATE FUNCTION public.eliminar_cliente(p_id_cedula integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    DELETE FROM cliente WHERE id_cedula = p_id_cedula;
END;
$$;
 <   DROP FUNCTION public.eliminar_cliente(p_id_cedula integer);
       public          postgres    false            �            1255    49607 ,   insertar_cliente(integer, character varying)    FUNCTION     �   CREATE FUNCTION public.insertar_cliente(id_cedula integer, nombre_cliente character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
INSERT INTO cliente (id_cedula, nombre_cliente) VALUES (id_cedula, nombre_cliente);
END;
$$;
 \   DROP FUNCTION public.insertar_cliente(id_cedula integer, nombre_cliente character varying);
       public          postgres    false            �            1255    49606 (   insertarsecc(integer, character varying)    FUNCTION     �   CREATE FUNCTION public.insertarsecc(id_cedula integer, nombre_cliente character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
INSERT INTO secciones VALUES (NEW.id_c, NEW.nom);
END;
$$;
 X   DROP FUNCTION public.insertarsecc(id_cedula integer, nombre_cliente character varying);
       public          postgres    false            �            1255    49613 #   navegar(integer, character varying)    FUNCTION     �  CREATE FUNCTION public.navegar(id_cedula integer, nombre_cliente character varying) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
DECLARE 
    bandera boolean := false;
BEGIN
    IF id_cedula IS NOT NULL THEN
        INSERT INTO cliente (id_cedula, nombre_cliente) VALUES (id_cedula, nombre_cliente);
        bandera := true;
    ELSE
        INSERT INTO cliente (id_cedula, nombre_cliente) VALUES (id_cedula, nombre_cliente);
        bandera := true;
    END IF;
    
    RETURN bandera;
END;
$$;
 S   DROP FUNCTION public.navegar(id_cedula integer, nombre_cliente character varying);
       public          postgres    false            �            1259    16443    cliente    TABLE     k   CREATE TABLE public.cliente (
    id_cedula integer NOT NULL,
    nombre_cliente character varying(100)
);
    DROP TABLE public.cliente;
       public         heap    postgres    false            �            1259    16463    detalle_factura    TABLE     �   CREATE TABLE public.detalle_factura (
    id_detalle integer NOT NULL,
    id_factura integer NOT NULL,
    id_producto integer NOT NULL,
    cantidad integer
);
 #   DROP TABLE public.detalle_factura;
       public         heap    postgres    false            �            1259    16453    factura    TABLE     p   CREATE TABLE public.factura (
    id_factura integer NOT NULL,
    id_cedula integer,
    fecha_emision date
);
    DROP TABLE public.factura;
       public         heap    postgres    false            �            1259    41117 	   peliculas    TABLE     �   CREATE TABLE public.peliculas (
    id integer NOT NULL,
    categoria character varying(50),
    duracion numeric,
    sinopsis character varying(50)
);
    DROP TABLE public.peliculas;
       public         heap    postgres    false            �            1259    16448    producto    TABLE     �   CREATE TABLE public.producto (
    id_producto integer NOT NULL,
    nombre_producto character varying(100),
    precio numeric(10,2),
    descripcion character varying
);
    DROP TABLE public.producto;
       public         heap    postgres    false            �            1259    16478    vista_facturas    VIEW     s  CREATE VIEW public.vista_facturas AS
 SELECT c.nombre_cliente,
    f.id_factura,
    f.fecha_emision,
    df.cantidad,
    p.nombre_producto
   FROM (((public.cliente c
     JOIN public.factura f ON ((c.id_cedula = f.id_cedula)))
     JOIN public.detalle_factura df ON ((f.id_factura = df.id_factura)))
     JOIN public.producto p ON ((df.id_producto = p.id_producto)));
 !   DROP VIEW public.vista_facturas;
       public          postgres    false    218    215    215    216    216    217    217    217    218    218            �            1259    25023    vista_productos_mas_vendidos    VIEW       CREATE VIEW public.vista_productos_mas_vendidos AS
 SELECT p.nombre_producto,
    sum(df.cantidad) AS cantidad_vendida
   FROM (public.detalle_factura df
     JOIN public.producto p ON ((df.id_producto = p.id_producto)))
  GROUP BY p.nombre_producto
  ORDER BY (sum(df.cantidad)) DESC;
 /   DROP VIEW public.vista_productos_mas_vendidos;
       public          postgres    false    216    216    218    218            �          0    16443    cliente 
   TABLE DATA           <   COPY public.cliente (id_cedula, nombre_cliente) FROM stdin;
    public          postgres    false    215   /       �          0    16463    detalle_factura 
   TABLE DATA           X   COPY public.detalle_factura (id_detalle, id_factura, id_producto, cantidad) FROM stdin;
    public          postgres    false    218   �/       �          0    16453    factura 
   TABLE DATA           G   COPY public.factura (id_factura, id_cedula, fecha_emision) FROM stdin;
    public          postgres    false    217   �/       �          0    41117 	   peliculas 
   TABLE DATA           F   COPY public.peliculas (id, categoria, duracion, sinopsis) FROM stdin;
    public          postgres    false    221   "0       �          0    16448    producto 
   TABLE DATA           U   COPY public.producto (id_producto, nombre_producto, precio, descripcion) FROM stdin;
    public          postgres    false    216   ?0       8           2606    16447    cliente cliente_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_pkey PRIMARY KEY (id_cedula);
 >   ALTER TABLE ONLY public.cliente DROP CONSTRAINT cliente_pkey;
       public            postgres    false    215            C           2606    16467 $   detalle_factura detalle_factura_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public.detalle_factura
    ADD CONSTRAINT detalle_factura_pkey PRIMARY KEY (id_detalle);
 N   ALTER TABLE ONLY public.detalle_factura DROP CONSTRAINT detalle_factura_pkey;
       public            postgres    false    218            A           2606    16457    factura factura_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.factura
    ADD CONSTRAINT factura_pkey PRIMARY KEY (id_factura);
 >   ALTER TABLE ONLY public.factura DROP CONSTRAINT factura_pkey;
       public            postgres    false    217            E           2606    41123    peliculas peliculas_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.peliculas
    ADD CONSTRAINT peliculas_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.peliculas DROP CONSTRAINT peliculas_pkey;
       public            postgres    false    221            ?           2606    16452    producto producto_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.producto
    ADD CONSTRAINT producto_pkey PRIMARY KEY (id_producto);
 @   ALTER TABLE ONLY public.producto DROP CONSTRAINT producto_pkey;
       public            postgres    false    216            9           1259    16491    idx_cedula_cliente    INDEX     R   CREATE UNIQUE INDEX idx_cedula_cliente ON public.cliente USING btree (id_cedula);
 &   DROP INDEX public.idx_cedula_cliente;
       public            postgres    false    215            :           1259    16493    idx_cliente_cedula    INDEX     R   CREATE UNIQUE INDEX idx_cliente_cedula ON public.cliente USING btree (id_cedula);
 &   DROP INDEX public.idx_cliente_cedula;
       public            postgres    false    215            ;           1259    16484    idx_nombre_descripcion    INDEX     c   CREATE INDEX idx_nombre_descripcion ON public.producto USING btree (nombre_producto, descripcion);
 *   DROP INDEX public.idx_nombre_descripcion;
       public            postgres    false    216    216            <           1259    16485    idx_nombre_descripcion_producto    INDEX     l   CREATE INDEX idx_nombre_descripcion_producto ON public.producto USING btree (nombre_producto, descripcion);
 3   DROP INDEX public.idx_nombre_descripcion_producto;
       public            postgres    false    216    216            =           1259    16492    idx_producto_nombre_descripcion    INDEX     _   CREATE INDEX idx_producto_nombre_descripcion ON public.producto USING btree (nombre_producto);
 3   DROP INDEX public.idx_producto_nombre_descripcion;
       public            postgres    false    216            G           2606    16468 /   detalle_factura detalle_factura_id_factura_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.detalle_factura
    ADD CONSTRAINT detalle_factura_id_factura_fkey FOREIGN KEY (id_factura) REFERENCES public.factura(id_factura);
 Y   ALTER TABLE ONLY public.detalle_factura DROP CONSTRAINT detalle_factura_id_factura_fkey;
       public          postgres    false    4673    217    218            H           2606    16473 0   detalle_factura detalle_factura_id_producto_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.detalle_factura
    ADD CONSTRAINT detalle_factura_id_producto_fkey FOREIGN KEY (id_producto) REFERENCES public.producto(id_producto);
 Z   ALTER TABLE ONLY public.detalle_factura DROP CONSTRAINT detalle_factura_id_producto_fkey;
       public          postgres    false    216    218    4671            F           2606    16486    factura factura_id_cedula_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.factura
    ADD CONSTRAINT factura_id_cedula_fkey FOREIGN KEY (id_cedula) REFERENCES public.cliente(id_cedula);
 H   ALTER TABLE ONLY public.factura DROP CONSTRAINT factura_id_cedula_fkey;
       public          postgres    false    217    4664    215            �   }   x�%�=
�@��z�Sxqf��)%؄���V�,L���Sx1mޗ��l
�V-�	�����s�=<�>oEI]���1��K����!��`q�/���e�S���߉��E㬫-���:d\� ���%      �   '   x�3�4Bc.#N0�2�AC.N0�2�A#�=... {R[      �   5   x�EǱ  �9�Ԧ�7�H��X�^!jZ4<5=m&��I�M�	��      �      x������ � �      �   �   x�-�A�0ׯ�i�B�$�1nM���M
��z'��Ŭ���<�3���*t'ap��a��\`��'�P�����R�g�C�}�\|C���^����R��hi����Qʖ�-Z;�Q2M޴�.ę&ص����V+     