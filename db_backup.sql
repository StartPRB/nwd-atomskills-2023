PGDMP     +    -                {            AS2023    12.14    15.2 m    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    22075    AS2023    DATABASE     |   CREATE DATABASE "AS2023" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Russian_Russia.1251';
    DROP DATABASE "AS2023";
                postgres    false                        2615    2200    public    SCHEMA     2   -- *not* creating schema, since initdb creates it
 2   -- *not* dropping schema, since initdb creates it
                postgres    false            �            1259    22078    MachineStatuses    TABLE     �   CREATE TABLE public."MachineStatuses" (
    id integer NOT NULL,
    code text,
    "beginDateTime" timestamp with time zone,
    "endDateTime" timestamp with time zone,
    "stateId" integer
);
 %   DROP TABLE public."MachineStatuses";
       public         heap    postgres    false    6            �           0    0    TABLE "MachineStatuses"    COMMENT     J   COMMENT ON TABLE public."MachineStatuses" IS 'Статус станка';
          public          postgres    false    202            �           0    0    COLUMN "MachineStatuses".id    COMMENT     O   COMMENT ON COLUMN public."MachineStatuses".id IS 'Идентификатор';
          public          postgres    false    202            �            1259    22084    Machines    TABLE       CREATE TABLE public."Machines" (
    "Id" integer NOT NULL,
    port integer,
    name text,
    "MachineTypeId" integer,
    "MachineStatusid" integer,
    "IsNotification" boolean DEFAULT false NOT NULL,
    "IsNotificationForDislay" boolean DEFAULT false NOT NULL
);
    DROP TABLE public."Machines";
       public         heap    postgres    false    6            �           0    0    TABLE "Machines"    COMMENT     6   COMMENT ON TABLE public."Machines" IS 'Станки';
          public          postgres    false    203            �           0    0    COLUMN "Machines"."Id"    COMMENT     J   COMMENT ON COLUMN public."Machines"."Id" IS 'Идентификатор';
          public          postgres    false    203            �           0    0    COLUMN "Machines".port    COMMENT     8   COMMENT ON COLUMN public."Machines".port IS 'Порт';
          public          postgres    false    203            �           0    0    COLUMN "Machines".name    COMMENT     H   COMMENT ON COLUMN public."Machines".name IS 'Наименование';
          public          postgres    false    203            �            1259    22092    States    TABLE     n   CREATE TABLE public."States" (
    code text DEFAULT ''::text,
    caption text,
    "Id" integer NOT NULL
);
    DROP TABLE public."States";
       public         heap    postgres    false    6            �           0    0    TABLE "States"    COMMENT     A   COMMENT ON TABLE public."States" IS 'Статус станка';
          public          postgres    false    204            �            1259    22099 	   WorkPlans    TABLE     �  CREATE TABLE public."WorkPlans" (
    "Id" integer NOT NULL,
    "ProductId" integer,
    "Queue" integer,
    "StartDt" timestamp with time zone,
    "EndDt" timestamp with time zone,
    "MachineTypeName" text,
    "MachinePort" integer,
    "MachineTime" integer,
    "GuidGroup" text DEFAULT ''::text NOT NULL,
    "Qty" integer DEFAULT 0,
    "OrderNumber" integer DEFAULT 0 NOT NULL
);
    DROP TABLE public."WorkPlans";
       public         heap    postgres    false    6            �           0    0    TABLE "WorkPlans"    COMMENT     @   COMMENT ON TABLE public."WorkPlans" IS 'План работы';
          public          postgres    false    205            �           0    0    COLUMN "WorkPlans"."Id"    COMMENT     K   COMMENT ON COLUMN public."WorkPlans"."Id" IS 'Идентификатор';
          public          postgres    false    205            �           0    0    COLUMN "WorkPlans"."ProductId"    COMMENT     r   COMMENT ON COLUMN public."WorkPlans"."ProductId" IS 'Запись идентификатора продукта';
          public          postgres    false    205            �           0    0    COLUMN "WorkPlans"."Queue"    COMMENT     J   COMMENT ON COLUMN public."WorkPlans"."Queue" IS 'Очередность';
          public          postgres    false    205            �           0    0    COLUMN "WorkPlans"."StartDt"    COMMENT     r   COMMENT ON COLUMN public."WorkPlans"."StartDt" IS 'Время начало обработки на станке';
          public          postgres    false    205            �           0    0    COLUMN "WorkPlans"."EndDt"    COMMENT     v   COMMENT ON COLUMN public."WorkPlans"."EndDt" IS 'Время окончания обработки на станке';
          public          postgres    false    205            �           0    0 $   COLUMN "WorkPlans"."MachineTypeName"    COMMENT     l   COMMENT ON COLUMN public."WorkPlans"."MachineTypeName" IS 'Наименоваеме типа станка';
          public          postgres    false    205            �           0    0     COLUMN "WorkPlans"."MachinePort"    COMMENT     O   COMMENT ON COLUMN public."WorkPlans"."MachinePort" IS 'Порт станка';
          public          postgres    false    205            �           0    0     COLUMN "WorkPlans"."MachineTime"    COMMENT     Y   COMMENT ON COLUMN public."WorkPlans"."MachineTime" IS 'Время выполнения';
          public          postgres    false    205            �           0    0    COLUMN "WorkPlans"."GuidGroup"    COMMENT     R   COMMENT ON COLUMN public."WorkPlans"."GuidGroup" IS 'Идентификатор';
          public          postgres    false    205            �           0    0    COLUMN "WorkPlans"."Qty"    COMMENT     �   COMMENT ON COLUMN public."WorkPlans"."Qty" IS 'Количество деталей за один шаг распределения';
          public          postgres    false    205            �           0    0     COLUMN "WorkPlans"."OrderNumber"    COMMENT     ^   COMMENT ON COLUMN public."WorkPlans"."OrderNumber" IS 'Номеря заказ наряда';
          public          postgres    false    205            �            1259    22108    MachineQueueLathe    VIEW     >  CREATE VIEW public."MachineQueueLathe" AS
 SELECT a."Id",
    a.port,
    a.enddt
   FROM ( SELECT m."Id",
            m.port,
                CASE
                    WHEN (COALESCE(w.enddt, now()) < now()) THEN now()
                    ELSE COALESCE(w.enddt, now())
                END AS enddt
           FROM (( SELECT a_1."Id",
                    a_1.port,
                    a_1.name,
                    a_1."MachineTypeId",
                    a_1."MachineStatusid"
                   FROM ((public."Machines" a_1
                     LEFT JOIN public."MachineStatuses" b ON ((a_1."MachineStatusid" = b.id)))
                     LEFT JOIN public."States" c ON ((c."Id" = b."stateId")))
                  WHERE ((c.code <> 'BROKEN'::text) AND (c.code <> 'REPAIRING'::text) AND (a_1."MachineTypeId" = 1))) m
             LEFT JOIN ( SELECT "WorkPlans"."MachinePort",
                    max("WorkPlans"."EndDt") AS enddt
                   FROM public."WorkPlans"
                  GROUP BY "WorkPlans"."MachinePort") w ON ((m.port = w."MachinePort")))) a
  ORDER BY a.enddt;
 &   DROP VIEW public."MachineQueueLathe";
       public          postgres    false    204    203    203    203    203    205    205    203    202    202    204    6            �            1259    22113    MachineQueueMilling    VIEW     @  CREATE VIEW public."MachineQueueMilling" AS
 SELECT a."Id",
    a.port,
    a.enddt
   FROM ( SELECT m."Id",
            m.port,
                CASE
                    WHEN (COALESCE(w.enddt, now()) < now()) THEN now()
                    ELSE COALESCE(w.enddt, now())
                END AS enddt
           FROM (( SELECT a_1."Id",
                    a_1.port,
                    a_1.name,
                    a_1."MachineTypeId",
                    a_1."MachineStatusid"
                   FROM ((public."Machines" a_1
                     LEFT JOIN public."MachineStatuses" b ON ((a_1."MachineStatusid" = b.id)))
                     LEFT JOIN public."States" c ON ((c."Id" = b."stateId")))
                  WHERE ((c.code <> 'BROKEN'::text) AND (c.code <> 'REPAIRING'::text) AND (a_1."MachineTypeId" = 2))) m
             LEFT JOIN ( SELECT "WorkPlans"."MachinePort",
                    max("WorkPlans"."EndDt") AS enddt
                   FROM public."WorkPlans"
                  GROUP BY "WorkPlans"."MachinePort") w ON ((m.port = w."MachinePort")))) a
  ORDER BY a.enddt;
 (   DROP VIEW public."MachineQueueMilling";
       public          postgres    false    203    205    205    204    204    203    203    203    203    202    202    6            �            1259    22118    MachineStatuses_id_seq    SEQUENCE     �   ALTER TABLE public."MachineStatuses" ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."MachineStatuses_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    6    202            �            1259    22120    MachineTypes    TABLE     y   CREATE TABLE public."MachineTypes" (
    "Id" integer NOT NULL,
    "Name" text NOT NULL,
    "Display" text NOT NULL
);
 "   DROP TABLE public."MachineTypes";
       public         heap    postgres    false    6            �           0    0    TABLE "MachineTypes"    COMMENT     U   COMMENT ON TABLE public."MachineTypes" IS 'Пользователи системы';
          public          postgres    false    209            �           0    0    COLUMN "MachineTypes"."Id"    COMMENT     N   COMMENT ON COLUMN public."MachineTypes"."Id" IS 'Идентификатор';
          public          postgres    false    209            �           0    0    COLUMN "MachineTypes"."Name"    COMMENT     N   COMMENT ON COLUMN public."MachineTypes"."Name" IS 'Наименование';
          public          postgres    false    209            �           0    0    COLUMN "MachineTypes"."Display"    COMMENT     N   COMMENT ON COLUMN public."MachineTypes"."Display" IS 'Экраное имя';
          public          postgres    false    209            �            1259    22126    MachineTypes_Id_seq    SEQUENCE     �   ALTER TABLE public."MachineTypes" ALTER COLUMN "Id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."MachineTypes_Id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    6    209            �            1259    22128    MachineWorkSummary    VIEW     �  CREATE VIEW public."MachineWorkSummary" AS
 SELECT a."ProductId",
    a."MachinePort",
    a."MachineTime",
    a."OrderNumber",
    a.type,
    a.min,
    a.max,
    a.sum,
    b.name
   FROM ( SELECT wp."ProductId",
            wp."MachinePort",
            wp."MachineTime",
            ((wp."ProductId" || '/'::text) || wp."OrderNumber") AS "OrderNumber",
                CASE
                    WHEN (wp."MachineTypeName" = 'milling'::text) THEN 'Фрезеровочный'::text
                    ELSE 'Токарный'::text
                END AS type,
            min(wp."StartDt") AS min,
            max(wp."EndDt") AS max,
            sum(wp."Qty") AS sum
           FROM public."WorkPlans" wp
          GROUP BY wp."ProductId", wp."MachinePort", wp."MachineTime", ((wp."ProductId" || '/'::text) || wp."OrderNumber"), wp."MachineTypeName") a,
    public."Machines" b
  WHERE (a."MachinePort" = b.port)
  ORDER BY a."ProductId";
 '   DROP VIEW public."MachineWorkSummary";
       public          postgres    false    205    203    203    205    205    205    205    205    205    205    6            �            1259    22133    MachinesToWait    VIEW     �  CREATE VIEW public."MachinesToWait" AS
 SELECT y.port
   FROM ( SELECT a.port,
            b.working
           FROM (( SELECT a_1.port
                   FROM ((public."Machines" a_1
                     LEFT JOIN public."MachineStatuses" b_1 ON ((a_1."MachineStatusid" = b_1.id)))
                     LEFT JOIN public."States" c ON ((c."Id" = b_1."stateId")))
                  WHERE (c.code = 'WORKING'::text)) a
             LEFT JOIN ( SELECT b_1."MachinePort" AS port,
                    1 AS working
                   FROM public."WorkPlans" b_1
                  WHERE ((now() >= b_1."StartDt") AND (now() <= b_1."EndDt"))) b ON ((a.port = b.port)))) y
  WHERE (y.working IS NULL);
 #   DROP VIEW public."MachinesToWait";
       public          postgres    false    203    202    205    205    205    204    204    203    202    6            �            1259    22138    MachinesToWork    VIEW     �  CREATE VIEW public."MachinesToWork" AS
 SELECT y.port
   FROM ( SELECT a.port,
            b.working
           FROM (( SELECT a_1.port
                   FROM ((public."Machines" a_1
                     LEFT JOIN public."MachineStatuses" b_1 ON ((a_1."MachineStatusid" = b_1.id)))
                     LEFT JOIN public."States" c ON ((c."Id" = b_1."stateId")))
                  WHERE ((c.code = 'WAITING'::text) OR (c.code = 'unknown'::text))) a
             LEFT JOIN ( SELECT b_1."MachinePort" AS port,
                    1 AS working
                   FROM public."WorkPlans" b_1
                  WHERE ((now() >= b_1."StartDt") AND (now() <= b_1."EndDt"))) b ON ((a.port = b.port)))) y
  WHERE (y.working IS NOT NULL);
 #   DROP VIEW public."MachinesToWork";
       public          postgres    false    202    203    203    204    204    205    205    205    202    6            �            1259    22143    Machines_Id_seq    SEQUENCE     �   ALTER TABLE public."Machines" ALTER COLUMN "Id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."Machines_Id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    6    203            �            1259    22145    ProductCount    VIEW     �   CREATE VIEW public."ProductCount" AS
 SELECT "WorkPlans"."ProductId",
    sum("WorkPlans"."Qty") AS prodcount
   FROM public."WorkPlans"
  WHERE ("WorkPlans"."MachineTypeName" = 'milling'::text)
  GROUP BY "WorkPlans"."ProductId";
 !   DROP VIEW public."ProductCount";
       public          postgres    false    205    205    205    6            �            1259    22149    ProductExecuted    VIEW       CREATE VIEW public."ProductExecuted" AS
 SELECT "WorkPlans"."ProductId",
    sum("WorkPlans"."Qty") AS sum
   FROM public."WorkPlans"
  WHERE (("WorkPlans"."EndDt" < now()) AND ("WorkPlans"."MachineTypeName" = 'milling'::text))
  GROUP BY "WorkPlans"."ProductId";
 $   DROP VIEW public."ProductExecuted";
       public          postgres    false    205    205    205    205    6            �            1259    22153    RequestReceiveds    TABLE     �   CREATE TABLE public."RequestReceiveds" (
    "Id" integer NOT NULL,
    "Number" text,
    "DtCreate" timestamp with time zone NOT NULL,
    "IsNotification" boolean NOT NULL
);
 &   DROP TABLE public."RequestReceiveds";
       public         heap    postgres    false    6            �            1259    22159    RequestReceiveds_Id_seq    SEQUENCE     �   ALTER TABLE public."RequestReceiveds" ALTER COLUMN "Id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."RequestReceiveds_Id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    217    6            �            1259    22161    Roles    TABLE     �   CREATE TABLE public."Roles" (
    "Id" integer NOT NULL,
    "Name" character varying(150) NOT NULL,
    "Display" character varying(150) NOT NULL
);
    DROP TABLE public."Roles";
       public         heap    postgres    false    6            �           0    0    TABLE "Roles"    COMMENT     Z   COMMENT ON TABLE public."Roles" IS 'Роль пользователя в системе';
          public          postgres    false    219            �           0    0    COLUMN "Roles"."Id"    COMMENT     P   COMMENT ON COLUMN public."Roles"."Id" IS 'Идентификатор роли';
          public          postgres    false    219            �           0    0    COLUMN "Roles"."Name"    COMMENT     P   COMMENT ON COLUMN public."Roles"."Name" IS 'Наименование роли';
          public          postgres    false    219            �           0    0    COLUMN "Roles"."Display"    COMMENT     [   COMMENT ON COLUMN public."Roles"."Display" IS 'Экранное наименование';
          public          postgres    false    219            �            1259    22164    Roles_Id_seq    SEQUENCE     �   ALTER TABLE public."Roles" ALTER COLUMN "Id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."Roles_Id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    6    219            �            1259    22166    Settings    TABLE     �   CREATE TABLE public."Settings" (
    "Id" integer NOT NULL,
    "Name" text NOT NULL,
    "Value" text NOT NULL,
    "Display" text
);
    DROP TABLE public."Settings";
       public         heap    postgres    false    6            �           0    0    TABLE "Settings"    COMMENT     <   COMMENT ON TABLE public."Settings" IS 'Настройки';
          public          postgres    false    221            �           0    0    COLUMN "Settings"."Id"    COMMENT     J   COMMENT ON COLUMN public."Settings"."Id" IS 'Идентификатор';
          public          postgres    false    221            �           0    0    COLUMN "Settings"."Name"    COMMENT     J   COMMENT ON COLUMN public."Settings"."Name" IS 'Наименование';
          public          postgres    false    221            �           0    0    COLUMN "Settings"."Value"    COMMENT     C   COMMENT ON COLUMN public."Settings"."Value" IS 'Значение';
          public          postgres    false    221            �           0    0    COLUMN "Settings"."Display"    COMMENT     ^   COMMENT ON COLUMN public."Settings"."Display" IS 'Экранное наименование';
          public          postgres    false    221            �            1259    22172    Settings_Id_seq    SEQUENCE     �   ALTER TABLE public."Settings" ALTER COLUMN "Id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."Settings_Id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    221    6            �            1259    22174    States_Id_seq    SEQUENCE     �   ALTER TABLE public."States" ALTER COLUMN "Id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."States_Id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    204    6            �            1259    22176    Users    TABLE     �  CREATE TABLE public."Users" (
    "Id" integer NOT NULL,
    "Login" character varying(250) NOT NULL,
    "Password" character varying(250),
    "Name" character varying(250) NOT NULL,
    "Surname" character varying(250),
    "Patronymic" character varying(250),
    "DtRegistration" timestamp with time zone NOT NULL,
    "RoleId" integer NOT NULL,
    "Email" text DEFAULT '-infinity'::timestamp with time zone NOT NULL
);
    DROP TABLE public."Users";
       public         heap    postgres    false    6            �           0    0    TABLE "Users"    COMMENT     N   COMMENT ON TABLE public."Users" IS 'Пользователи системы';
          public          postgres    false    224            �           0    0    COLUMN "Users"."Id"    COMMENT     G   COMMENT ON COLUMN public."Users"."Id" IS 'Идентификатор';
          public          postgres    false    224            �           0    0    COLUMN "Users"."Login"    COMMENT     ^   COMMENT ON COLUMN public."Users"."Login" IS 'Логин для входа в систему';
          public          postgres    false    224            �           0    0    COLUMN "Users"."Password"    COMMENT     c   COMMENT ON COLUMN public."Users"."Password" IS 'Пароль для входа в систему';
          public          postgres    false    224            �           0    0    COLUMN "Users"."Name"    COMMENT     5   COMMENT ON COLUMN public."Users"."Name" IS 'Имя';
          public          postgres    false    224            �           0    0    COLUMN "Users"."Surname"    COMMENT     @   COMMENT ON COLUMN public."Users"."Surname" IS 'Фамилия';
          public          postgres    false    224            �           0    0    COLUMN "Users"."Patronymic"    COMMENT     E   COMMENT ON COLUMN public."Users"."Patronymic" IS 'Отчество';
          public          postgres    false    224            �           0    0    COLUMN "Users"."DtRegistration"    COMMENT     X   COMMENT ON COLUMN public."Users"."DtRegistration" IS 'Дата регистрации';
          public          postgres    false    224            �           0    0    COLUMN "Users"."Email"    COMMENT     \   COMMENT ON COLUMN public."Users"."Email" IS 'Адрес электронной почты';
          public          postgres    false    224            �            1259    22183    Users_Id_seq    SEQUENCE     �   ALTER TABLE public."Users" ALTER COLUMN "Id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."Users_Id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    224    6            �            1259    22185    WorkPlans_Id_seq    SEQUENCE     �   ALTER TABLE public."WorkPlans" ALTER COLUMN "Id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."WorkPlans_Id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    6    205            �            1259    22187    __EFMigrationsHistory    TABLE     �   CREATE TABLE public."__EFMigrationsHistory" (
    "MigrationId" character varying(150) NOT NULL,
    "ProductVersion" character varying(32) NOT NULL
);
 +   DROP TABLE public."__EFMigrationsHistory";
       public         heap    postgres    false    6                      0    22078    MachineStatuses 
   TABLE DATA           `   COPY public."MachineStatuses" (id, code, "beginDateTime", "endDateTime", "stateId") FROM stdin;
    public          postgres    false    202   ��       �          0    22120    MachineTypes 
   TABLE DATA           A   COPY public."MachineTypes" ("Id", "Name", "Display") FROM stdin;
    public          postgres    false    209   @�       �          0    22084    Machines 
   TABLE DATA           �   COPY public."Machines" ("Id", port, name, "MachineTypeId", "MachineStatusid", "IsNotification", "IsNotificationForDislay") FROM stdin;
    public          postgres    false    203   ��       �          0    22153    RequestReceiveds 
   TABLE DATA           Z   COPY public."RequestReceiveds" ("Id", "Number", "DtCreate", "IsNotification") FROM stdin;
    public          postgres    false    217   �       �          0    22161    Roles 
   TABLE DATA           :   COPY public."Roles" ("Id", "Name", "Display") FROM stdin;
    public          postgres    false    219   (�       �          0    22166    Settings 
   TABLE DATA           F   COPY public."Settings" ("Id", "Name", "Value", "Display") FROM stdin;
    public          postgres    false    221   ��       �          0    22092    States 
   TABLE DATA           7   COPY public."States" (code, caption, "Id") FROM stdin;
    public          postgres    false    204   =�       �          0    22176    Users 
   TABLE DATA           �   COPY public."Users" ("Id", "Login", "Password", "Name", "Surname", "Patronymic", "DtRegistration", "RoleId", "Email") FROM stdin;
    public          postgres    false    224   ��       �          0    22099 	   WorkPlans 
   TABLE DATA           �   COPY public."WorkPlans" ("Id", "ProductId", "Queue", "StartDt", "EndDt", "MachineTypeName", "MachinePort", "MachineTime", "GuidGroup", "Qty", "OrderNumber") FROM stdin;
    public          postgres    false    205   �       �          0    22187    __EFMigrationsHistory 
   TABLE DATA           R   COPY public."__EFMigrationsHistory" ("MigrationId", "ProductVersion") FROM stdin;
    public          postgres    false    227   8�       �           0    0    MachineStatuses_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public."MachineStatuses_id_seq"', 11084, true);
          public          postgres    false    208            �           0    0    MachineTypes_Id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public."MachineTypes_Id_seq"', 2, true);
          public          postgres    false    210            �           0    0    Machines_Id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public."Machines_Id_seq"', 27, true);
          public          postgres    false    214            �           0    0    RequestReceiveds_Id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public."RequestReceiveds_Id_seq"', 1, false);
          public          postgres    false    218            �           0    0    Roles_Id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public."Roles_Id_seq"', 4, true);
          public          postgres    false    220            �           0    0    Settings_Id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public."Settings_Id_seq"', 2, true);
          public          postgres    false    222            �           0    0    States_Id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public."States_Id_seq"', 19, true);
          public          postgres    false    223            �           0    0    Users_Id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public."Users_Id_seq"', 7, true);
          public          postgres    false    225            �           0    0    WorkPlans_Id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public."WorkPlans_Id_seq"', 198730, true);
          public          postgres    false    226            �
           2606    22191 "   MachineStatuses PK_MachineStatuses 
   CONSTRAINT     d   ALTER TABLE ONLY public."MachineStatuses"
    ADD CONSTRAINT "PK_MachineStatuses" PRIMARY KEY (id);
 P   ALTER TABLE ONLY public."MachineStatuses" DROP CONSTRAINT "PK_MachineStatuses";
       public            postgres    false    202            �
           2606    22193    MachineTypes PK_MachineTypes 
   CONSTRAINT     `   ALTER TABLE ONLY public."MachineTypes"
    ADD CONSTRAINT "PK_MachineTypes" PRIMARY KEY ("Id");
 J   ALTER TABLE ONLY public."MachineTypes" DROP CONSTRAINT "PK_MachineTypes";
       public            postgres    false    209            �
           2606    22195    Machines PK_Machines 
   CONSTRAINT     X   ALTER TABLE ONLY public."Machines"
    ADD CONSTRAINT "PK_Machines" PRIMARY KEY ("Id");
 B   ALTER TABLE ONLY public."Machines" DROP CONSTRAINT "PK_Machines";
       public            postgres    false    203            �
           2606    22197 $   RequestReceiveds PK_RequestReceiveds 
   CONSTRAINT     h   ALTER TABLE ONLY public."RequestReceiveds"
    ADD CONSTRAINT "PK_RequestReceiveds" PRIMARY KEY ("Id");
 R   ALTER TABLE ONLY public."RequestReceiveds" DROP CONSTRAINT "PK_RequestReceiveds";
       public            postgres    false    217            �
           2606    22199    Roles PK_Roles 
   CONSTRAINT     R   ALTER TABLE ONLY public."Roles"
    ADD CONSTRAINT "PK_Roles" PRIMARY KEY ("Id");
 <   ALTER TABLE ONLY public."Roles" DROP CONSTRAINT "PK_Roles";
       public            postgres    false    219            �
           2606    22201    Settings PK_Settings 
   CONSTRAINT     X   ALTER TABLE ONLY public."Settings"
    ADD CONSTRAINT "PK_Settings" PRIMARY KEY ("Id");
 B   ALTER TABLE ONLY public."Settings" DROP CONSTRAINT "PK_Settings";
       public            postgres    false    221            �
           2606    22203    States PK_States 
   CONSTRAINT     T   ALTER TABLE ONLY public."States"
    ADD CONSTRAINT "PK_States" PRIMARY KEY ("Id");
 >   ALTER TABLE ONLY public."States" DROP CONSTRAINT "PK_States";
       public            postgres    false    204            �
           2606    22205    Users PK_Users 
   CONSTRAINT     R   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "PK_Users" PRIMARY KEY ("Id");
 <   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "PK_Users";
       public            postgres    false    224            �
           2606    22207    WorkPlans PK_WorkPlans 
   CONSTRAINT     Z   ALTER TABLE ONLY public."WorkPlans"
    ADD CONSTRAINT "PK_WorkPlans" PRIMARY KEY ("Id");
 D   ALTER TABLE ONLY public."WorkPlans" DROP CONSTRAINT "PK_WorkPlans";
       public            postgres    false    205            �
           2606    22209 .   __EFMigrationsHistory PK___EFMigrationsHistory 
   CONSTRAINT     {   ALTER TABLE ONLY public."__EFMigrationsHistory"
    ADD CONSTRAINT "PK___EFMigrationsHistory" PRIMARY KEY ("MigrationId");
 \   ALTER TABLE ONLY public."__EFMigrationsHistory" DROP CONSTRAINT "PK___EFMigrationsHistory";
       public            postgres    false    227            �
           1259    22210    IX_MachineStatuses_stateId    INDEX     _   CREATE INDEX "IX_MachineStatuses_stateId" ON public."MachineStatuses" USING btree ("stateId");
 0   DROP INDEX public."IX_MachineStatuses_stateId";
       public            postgres    false    202            �
           1259    22211    IX_Machines_MachineStatusid    INDEX     a   CREATE INDEX "IX_Machines_MachineStatusid" ON public."Machines" USING btree ("MachineStatusid");
 1   DROP INDEX public."IX_Machines_MachineStatusid";
       public            postgres    false    203            �
           1259    22212    IX_Machines_MachineTypeId    INDEX     ]   CREATE INDEX "IX_Machines_MachineTypeId" ON public."Machines" USING btree ("MachineTypeId");
 /   DROP INDEX public."IX_Machines_MachineTypeId";
       public            postgres    false    203            �
           1259    22213    IX_Users_RoleId    INDEX     I   CREATE INDEX "IX_Users_RoleId" ON public."Users" USING btree ("RoleId");
 %   DROP INDEX public."IX_Users_RoleId";
       public            postgres    false    224            �
           2606    22214 1   MachineStatuses FK_MachineStatuses_States_stateId    FK CONSTRAINT     �   ALTER TABLE ONLY public."MachineStatuses"
    ADD CONSTRAINT "FK_MachineStatuses_States_stateId" FOREIGN KEY ("stateId") REFERENCES public."States"("Id");
 _   ALTER TABLE ONLY public."MachineStatuses" DROP CONSTRAINT "FK_MachineStatuses_States_stateId";
       public          postgres    false    202    2790    204            �
           2606    22219 4   Machines FK_Machines_MachineStatuses_MachineStatusid    FK CONSTRAINT     �   ALTER TABLE ONLY public."Machines"
    ADD CONSTRAINT "FK_Machines_MachineStatuses_MachineStatusid" FOREIGN KEY ("MachineStatusid") REFERENCES public."MachineStatuses"(id);
 b   ALTER TABLE ONLY public."Machines" DROP CONSTRAINT "FK_Machines_MachineStatuses_MachineStatusid";
       public          postgres    false    202    203    2784            �
           2606    22224 /   Machines FK_Machines_MachineTypes_MachineTypeId    FK CONSTRAINT     �   ALTER TABLE ONLY public."Machines"
    ADD CONSTRAINT "FK_Machines_MachineTypes_MachineTypeId" FOREIGN KEY ("MachineTypeId") REFERENCES public."MachineTypes"("Id");
 ]   ALTER TABLE ONLY public."Machines" DROP CONSTRAINT "FK_Machines_MachineTypes_MachineTypeId";
       public          postgres    false    203    2794    209            �
           2606    22229    Users FK_Users_Roles_RoleId    FK CONSTRAINT     �   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "FK_Users_Roles_RoleId" FOREIGN KEY ("RoleId") REFERENCES public."Roles"("Id") ON DELETE CASCADE;
 I   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "FK_Users_Roles_RoleId";
       public          postgres    false    224    219    2798               �   x�mб�0D�Z�"}`᎔(JCd����LXv���'I4K���$]�+�2�zVP�Oh�^�}��[p���QJk�2s.�u����tŏۗ�༬�F�����녋DL=���3��1������T����Ӛ��5���GI|��h]l�)�oǐ������,ГR�      �   =   x�3��I,�H弰�¾�.l��pa���;��8s3sr2��9/,
n����V�d� �$      �   n   x�-�;�@�����
؇��z+���'Q���p
Zty�#�hsȖ��N��� ��`�+��@@��?�&7r����0 ��sj!
"���y������Q�/m4*�      �      x������ � �      �   x   x�3�LL����0�{.츰����.6\�p��¾�\F��ũE��E�/l���bHՅ]
���2�_����4Y��9s�K@�� 5�D�^lP�����*����� }�L"      �   }   x�3�L,Ȍ/-���())�����ON���/.�0���^lT������
�_�d�r�.�_�za� �]
6�[/v��{.6+8xr��.�/*�4401�0�¾���4.F��� X&b�      �   �   x�5�=
�@��S�B
��AB �EH���[��BZ�� �k�$����1`5<���ɂh%k�^x��\��)�t����_����NF�����s.d�`=��������M��S���l{�XP��x��"�H��-��.DW)I�	}�`       �     x�eϿJ�P���)�K���4��Bo���!���r5��I�*���&��E-Ė�W8��<����s��w>Ft��&�$�/U�*�ĕR�.�WX���	<���k����nh�=ᔋ6m���� ��e~H�<���]~/ף�[N��u9�
r��jp�R���P��q54���Eo��7���x^x�~1�O��>��'"O���������� U�z��7��·
�>c��6V~Am�����oX�����E9��8s�y�[���γ�a�ZO���-*��u�ŀ�      �      x������ � �      �   �   x�eѻ�0�:�8��]d�4�?�����t'��6�>ozāC��$�D�C�
�^Ǽ@7�T-��$| ��:<&������rJ�ƝA؄�>�'�O���^"���S���rlJ���4H�;'�(��(�Tꏡ��c��9�f�     