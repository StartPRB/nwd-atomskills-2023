PGDMP     6                    {            AS2023    12.14    15.2 c    n           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            o           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            p           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            q           1262    21603    AS2023    DATABASE     |   CREATE DATABASE "AS2023" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Russian_Russia.1251';
    DROP DATABASE "AS2023";
                postgres    false                        2615    2200    public    SCHEMA     2   -- *not* creating schema, since initdb creates it
 2   -- *not* dropping schema, since initdb creates it
                postgres    false            �            1259    21604    Machines    TABLE     �   CREATE TABLE public."Machines" (
    "Id" integer NOT NULL,
    port integer,
    name text,
    "MachineTypeId" integer,
    "MachineStatusid" integer
);
    DROP TABLE public."Machines";
       public         heap    postgres    false    6            r           0    0    TABLE "Machines"    COMMENT     6   COMMENT ON TABLE public."Machines" IS 'Станки';
          public          postgres    false    202            s           0    0    COLUMN "Machines"."Id"    COMMENT     J   COMMENT ON COLUMN public."Machines"."Id" IS 'Идентификатор';
          public          postgres    false    202            t           0    0    COLUMN "Machines".port    COMMENT     8   COMMENT ON COLUMN public."Machines".port IS 'Порт';
          public          postgres    false    202            u           0    0    COLUMN "Machines".name    COMMENT     H   COMMENT ON COLUMN public."Machines".name IS 'Наименование';
          public          postgres    false    202            �            1259    21610 	   WorkPlans    TABLE     �  CREATE TABLE public."WorkPlans" (
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
       public         heap    postgres    false    6            v           0    0    TABLE "WorkPlans"    COMMENT     @   COMMENT ON TABLE public."WorkPlans" IS 'План работы';
          public          postgres    false    203            w           0    0    COLUMN "WorkPlans"."Id"    COMMENT     K   COMMENT ON COLUMN public."WorkPlans"."Id" IS 'Идентификатор';
          public          postgres    false    203            x           0    0    COLUMN "WorkPlans"."ProductId"    COMMENT     r   COMMENT ON COLUMN public."WorkPlans"."ProductId" IS 'Запись идентификатора продукта';
          public          postgres    false    203            y           0    0    COLUMN "WorkPlans"."Queue"    COMMENT     J   COMMENT ON COLUMN public."WorkPlans"."Queue" IS 'Очередность';
          public          postgres    false    203            z           0    0    COLUMN "WorkPlans"."StartDt"    COMMENT     r   COMMENT ON COLUMN public."WorkPlans"."StartDt" IS 'Время начало обработки на станке';
          public          postgres    false    203            {           0    0    COLUMN "WorkPlans"."EndDt"    COMMENT     v   COMMENT ON COLUMN public."WorkPlans"."EndDt" IS 'Время окончания обработки на станке';
          public          postgres    false    203            |           0    0 $   COLUMN "WorkPlans"."MachineTypeName"    COMMENT     l   COMMENT ON COLUMN public."WorkPlans"."MachineTypeName" IS 'Наименоваеме типа станка';
          public          postgres    false    203            }           0    0     COLUMN "WorkPlans"."MachinePort"    COMMENT     O   COMMENT ON COLUMN public."WorkPlans"."MachinePort" IS 'Порт станка';
          public          postgres    false    203            ~           0    0     COLUMN "WorkPlans"."MachineTime"    COMMENT     Y   COMMENT ON COLUMN public."WorkPlans"."MachineTime" IS 'Время выполнения';
          public          postgres    false    203                       0    0    COLUMN "WorkPlans"."GuidGroup"    COMMENT     R   COMMENT ON COLUMN public."WorkPlans"."GuidGroup" IS 'Идентификатор';
          public          postgres    false    203            �           0    0    COLUMN "WorkPlans"."Qty"    COMMENT     �   COMMENT ON COLUMN public."WorkPlans"."Qty" IS 'Количество деталей за один шаг распределения';
          public          postgres    false    203            �           0    0     COLUMN "WorkPlans"."OrderNumber"    COMMENT     ^   COMMENT ON COLUMN public."WorkPlans"."OrderNumber" IS 'Номеря заказ наряда';
          public          postgres    false    203            �            1259    21619    MachineQueueLathe    VIEW       CREATE VIEW public."MachineQueueLathe" AS
 SELECT a."Id",
    a.port,
    a.enddt
   FROM ( SELECT m."Id",
            m.port,
                CASE
                    WHEN (COALESCE(w.enddt, now()) < now()) THEN now()
                    ELSE COALESCE(w.enddt, now())
                END AS enddt
           FROM (( SELECT d."Id",
                    d.port,
                    d.name,
                    d."MachineTypeId"
                   FROM public."Machines" d
                  WHERE (d."MachineTypeId" = 1)) m
             LEFT JOIN ( SELECT "WorkPlans"."MachinePort",
                    max("WorkPlans"."EndDt") AS enddt
                   FROM public."WorkPlans"
                  GROUP BY "WorkPlans"."MachinePort") w ON ((m.port = w."MachinePort")))) a
  ORDER BY a.enddt;
 &   DROP VIEW public."MachineQueueLathe";
       public          postgres    false    202    202    203    203    202    202    6            �            1259    21624    MachineStatuses    TABLE     �   CREATE TABLE public."MachineStatuses" (
    id integer NOT NULL,
    code text,
    "beginDateTime" timestamp with time zone,
    "endDateTime" timestamp with time zone,
    "stateId" integer
);
 %   DROP TABLE public."MachineStatuses";
       public         heap    postgres    false    6            �           0    0    TABLE "MachineStatuses"    COMMENT     J   COMMENT ON TABLE public."MachineStatuses" IS 'Статус станка';
          public          postgres    false    205            �           0    0    COLUMN "MachineStatuses".id    COMMENT     O   COMMENT ON COLUMN public."MachineStatuses".id IS 'Идентификатор';
          public          postgres    false    205            �            1259    21630    States    TABLE     n   CREATE TABLE public."States" (
    code text DEFAULT ''::text,
    caption text,
    "Id" integer NOT NULL
);
    DROP TABLE public."States";
       public         heap    postgres    false    6            �           0    0    TABLE "States"    COMMENT     A   COMMENT ON TABLE public."States" IS 'Статус станка';
          public          postgres    false    206            �            1259    21637    MachineQueueMilling    VIEW     @  CREATE VIEW public."MachineQueueMilling" AS
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
 (   DROP VIEW public."MachineQueueMilling";
       public          postgres    false    203    202    202    202    202    202    203    205    205    206    206    6            �            1259    21642    MachineStatuses_id_seq    SEQUENCE     �   ALTER TABLE public."MachineStatuses" ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."MachineStatuses_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    205    6            �            1259    21644    MachineTypes    TABLE     y   CREATE TABLE public."MachineTypes" (
    "Id" integer NOT NULL,
    "Name" text NOT NULL,
    "Display" text NOT NULL
);
 "   DROP TABLE public."MachineTypes";
       public         heap    postgres    false    6            �           0    0    TABLE "MachineTypes"    COMMENT     U   COMMENT ON TABLE public."MachineTypes" IS 'Пользователи системы';
          public          postgres    false    209            �           0    0    COLUMN "MachineTypes"."Id"    COMMENT     N   COMMENT ON COLUMN public."MachineTypes"."Id" IS 'Идентификатор';
          public          postgres    false    209            �           0    0    COLUMN "MachineTypes"."Name"    COMMENT     N   COMMENT ON COLUMN public."MachineTypes"."Name" IS 'Наименование';
          public          postgres    false    209            �           0    0    COLUMN "MachineTypes"."Display"    COMMENT     N   COMMENT ON COLUMN public."MachineTypes"."Display" IS 'Экраное имя';
          public          postgres    false    209            �            1259    21650    MachineTypes_Id_seq    SEQUENCE     �   ALTER TABLE public."MachineTypes" ALTER COLUMN "Id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."MachineTypes_Id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    209    6            �            1259    21652    Machines_Id_seq    SEQUENCE     �   ALTER TABLE public."Machines" ALTER COLUMN "Id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."Machines_Id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    202    6            �            1259    21654    Roles    TABLE     �   CREATE TABLE public."Roles" (
    "Id" integer NOT NULL,
    "Name" character varying(150) NOT NULL,
    "Display" character varying(150) NOT NULL
);
    DROP TABLE public."Roles";
       public         heap    postgres    false    6            �           0    0    TABLE "Roles"    COMMENT     Z   COMMENT ON TABLE public."Roles" IS 'Роль пользователя в системе';
          public          postgres    false    212            �           0    0    COLUMN "Roles"."Id"    COMMENT     P   COMMENT ON COLUMN public."Roles"."Id" IS 'Идентификатор роли';
          public          postgres    false    212            �           0    0    COLUMN "Roles"."Name"    COMMENT     P   COMMENT ON COLUMN public."Roles"."Name" IS 'Наименование роли';
          public          postgres    false    212            �           0    0    COLUMN "Roles"."Display"    COMMENT     [   COMMENT ON COLUMN public."Roles"."Display" IS 'Экранное наименование';
          public          postgres    false    212            �            1259    21657    Roles_Id_seq    SEQUENCE     �   ALTER TABLE public."Roles" ALTER COLUMN "Id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."Roles_Id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    6    212            �            1259    21659    Settings    TABLE     �   CREATE TABLE public."Settings" (
    "Id" integer NOT NULL,
    "Name" text NOT NULL,
    "Value" text NOT NULL,
    "Display" text
);
    DROP TABLE public."Settings";
       public         heap    postgres    false    6            �           0    0    TABLE "Settings"    COMMENT     <   COMMENT ON TABLE public."Settings" IS 'Настройки';
          public          postgres    false    214            �           0    0    COLUMN "Settings"."Id"    COMMENT     J   COMMENT ON COLUMN public."Settings"."Id" IS 'Идентификатор';
          public          postgres    false    214            �           0    0    COLUMN "Settings"."Name"    COMMENT     J   COMMENT ON COLUMN public."Settings"."Name" IS 'Наименование';
          public          postgres    false    214            �           0    0    COLUMN "Settings"."Value"    COMMENT     C   COMMENT ON COLUMN public."Settings"."Value" IS 'Значение';
          public          postgres    false    214            �           0    0    COLUMN "Settings"."Display"    COMMENT     ^   COMMENT ON COLUMN public."Settings"."Display" IS 'Экранное наименование';
          public          postgres    false    214            �            1259    21665    Settings_Id_seq    SEQUENCE     �   ALTER TABLE public."Settings" ALTER COLUMN "Id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."Settings_Id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    214    6            �            1259    21667    States_Id_seq    SEQUENCE     �   ALTER TABLE public."States" ALTER COLUMN "Id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."States_Id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    206    6            �            1259    21669    Users    TABLE     �  CREATE TABLE public."Users" (
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
          public          postgres    false    217            �           0    0    COLUMN "Users"."Id"    COMMENT     G   COMMENT ON COLUMN public."Users"."Id" IS 'Идентификатор';
          public          postgres    false    217            �           0    0    COLUMN "Users"."Login"    COMMENT     ^   COMMENT ON COLUMN public."Users"."Login" IS 'Логин для входа в систему';
          public          postgres    false    217            �           0    0    COLUMN "Users"."Password"    COMMENT     c   COMMENT ON COLUMN public."Users"."Password" IS 'Пароль для входа в систему';
          public          postgres    false    217            �           0    0    COLUMN "Users"."Name"    COMMENT     5   COMMENT ON COLUMN public."Users"."Name" IS 'Имя';
          public          postgres    false    217            �           0    0    COLUMN "Users"."Surname"    COMMENT     @   COMMENT ON COLUMN public."Users"."Surname" IS 'Фамилия';
          public          postgres    false    217            �           0    0    COLUMN "Users"."Patronymic"    COMMENT     E   COMMENT ON COLUMN public."Users"."Patronymic" IS 'Отчество';
          public          postgres    false    217            �           0    0    COLUMN "Users"."DtRegistration"    COMMENT     X   COMMENT ON COLUMN public."Users"."DtRegistration" IS 'Дата регистрации';
          public          postgres    false    217            �           0    0    COLUMN "Users"."Email"    COMMENT     \   COMMENT ON COLUMN public."Users"."Email" IS 'Адрес электронной почты';
          public          postgres    false    217            �            1259    21676    Users_Id_seq    SEQUENCE     �   ALTER TABLE public."Users" ALTER COLUMN "Id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."Users_Id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    217    6            �            1259    21678    WorkPlans_Id_seq    SEQUENCE     �   ALTER TABLE public."WorkPlans" ALTER COLUMN "Id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."WorkPlans_Id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    6    203            �            1259    21680    __EFMigrationsHistory    TABLE     �   CREATE TABLE public."__EFMigrationsHistory" (
    "MigrationId" character varying(150) NOT NULL,
    "ProductVersion" character varying(32) NOT NULL
);
 +   DROP TABLE public."__EFMigrationsHistory";
       public         heap    postgres    false    6            ]          0    21624    MachineStatuses 
   TABLE DATA           `   COPY public."MachineStatuses" (id, code, "beginDateTime", "endDateTime", "stateId") FROM stdin;
    public          postgres    false    205   �p       `          0    21644    MachineTypes 
   TABLE DATA           A   COPY public."MachineTypes" ("Id", "Name", "Display") FROM stdin;
    public          postgres    false    209   iq       [          0    21604    Machines 
   TABLE DATA           Z   COPY public."Machines" ("Id", port, name, "MachineTypeId", "MachineStatusid") FROM stdin;
    public          postgres    false    202   �q       c          0    21654    Roles 
   TABLE DATA           :   COPY public."Roles" ("Id", "Name", "Display") FROM stdin;
    public          postgres    false    212   %r       e          0    21659    Settings 
   TABLE DATA           F   COPY public."Settings" ("Id", "Name", "Value", "Display") FROM stdin;
    public          postgres    false    214   �r       ^          0    21630    States 
   TABLE DATA           7   COPY public."States" (code, caption, "Id") FROM stdin;
    public          postgres    false    206   :s       h          0    21669    Users 
   TABLE DATA           �   COPY public."Users" ("Id", "Login", "Password", "Name", "Surname", "Patronymic", "DtRegistration", "RoleId", "Email") FROM stdin;
    public          postgres    false    217   �s       \          0    21610 	   WorkPlans 
   TABLE DATA           �   COPY public."WorkPlans" ("Id", "ProductId", "Queue", "StartDt", "EndDt", "MachineTypeName", "MachinePort", "MachineTime", "GuidGroup", "Qty", "OrderNumber") FROM stdin;
    public          postgres    false    203   �t       k          0    21680    __EFMigrationsHistory 
   TABLE DATA           R   COPY public."__EFMigrationsHistory" ("MigrationId", "ProductVersion") FROM stdin;
    public          postgres    false    220   i�      �           0    0    MachineStatuses_id_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public."MachineStatuses_id_seq"', 1706, true);
          public          postgres    false    208            �           0    0    MachineTypes_Id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public."MachineTypes_Id_seq"', 2, true);
          public          postgres    false    210            �           0    0    Machines_Id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public."Machines_Id_seq"', 27, true);
          public          postgres    false    211            �           0    0    Roles_Id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public."Roles_Id_seq"', 4, true);
          public          postgres    false    213            �           0    0    Settings_Id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public."Settings_Id_seq"', 2, true);
          public          postgres    false    215            �           0    0    States_Id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public."States_Id_seq"', 18, true);
          public          postgres    false    216            �           0    0    Users_Id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public."Users_Id_seq"', 6, true);
          public          postgres    false    218            �           0    0    WorkPlans_Id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public."WorkPlans_Id_seq"', 159344, true);
          public          postgres    false    219            �
           2606    21684 "   MachineStatuses PK_MachineStatuses 
   CONSTRAINT     d   ALTER TABLE ONLY public."MachineStatuses"
    ADD CONSTRAINT "PK_MachineStatuses" PRIMARY KEY (id);
 P   ALTER TABLE ONLY public."MachineStatuses" DROP CONSTRAINT "PK_MachineStatuses";
       public            postgres    false    205            �
           2606    21686    MachineTypes PK_MachineTypes 
   CONSTRAINT     `   ALTER TABLE ONLY public."MachineTypes"
    ADD CONSTRAINT "PK_MachineTypes" PRIMARY KEY ("Id");
 J   ALTER TABLE ONLY public."MachineTypes" DROP CONSTRAINT "PK_MachineTypes";
       public            postgres    false    209            �
           2606    21688    Machines PK_Machines 
   CONSTRAINT     X   ALTER TABLE ONLY public."Machines"
    ADD CONSTRAINT "PK_Machines" PRIMARY KEY ("Id");
 B   ALTER TABLE ONLY public."Machines" DROP CONSTRAINT "PK_Machines";
       public            postgres    false    202            �
           2606    21690    Roles PK_Roles 
   CONSTRAINT     R   ALTER TABLE ONLY public."Roles"
    ADD CONSTRAINT "PK_Roles" PRIMARY KEY ("Id");
 <   ALTER TABLE ONLY public."Roles" DROP CONSTRAINT "PK_Roles";
       public            postgres    false    212            �
           2606    21692    Settings PK_Settings 
   CONSTRAINT     X   ALTER TABLE ONLY public."Settings"
    ADD CONSTRAINT "PK_Settings" PRIMARY KEY ("Id");
 B   ALTER TABLE ONLY public."Settings" DROP CONSTRAINT "PK_Settings";
       public            postgres    false    214            �
           2606    21694    States PK_States 
   CONSTRAINT     T   ALTER TABLE ONLY public."States"
    ADD CONSTRAINT "PK_States" PRIMARY KEY ("Id");
 >   ALTER TABLE ONLY public."States" DROP CONSTRAINT "PK_States";
       public            postgres    false    206            �
           2606    21696    Users PK_Users 
   CONSTRAINT     R   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "PK_Users" PRIMARY KEY ("Id");
 <   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "PK_Users";
       public            postgres    false    217            �
           2606    21698    WorkPlans PK_WorkPlans 
   CONSTRAINT     Z   ALTER TABLE ONLY public."WorkPlans"
    ADD CONSTRAINT "PK_WorkPlans" PRIMARY KEY ("Id");
 D   ALTER TABLE ONLY public."WorkPlans" DROP CONSTRAINT "PK_WorkPlans";
       public            postgres    false    203            �
           2606    21700 .   __EFMigrationsHistory PK___EFMigrationsHistory 
   CONSTRAINT     {   ALTER TABLE ONLY public."__EFMigrationsHistory"
    ADD CONSTRAINT "PK___EFMigrationsHistory" PRIMARY KEY ("MigrationId");
 \   ALTER TABLE ONLY public."__EFMigrationsHistory" DROP CONSTRAINT "PK___EFMigrationsHistory";
       public            postgres    false    220            �
           1259    21701    IX_MachineStatuses_stateId    INDEX     _   CREATE INDEX "IX_MachineStatuses_stateId" ON public."MachineStatuses" USING btree ("stateId");
 0   DROP INDEX public."IX_MachineStatuses_stateId";
       public            postgres    false    205            �
           1259    21702    IX_Machines_MachineStatusid    INDEX     a   CREATE INDEX "IX_Machines_MachineStatusid" ON public."Machines" USING btree ("MachineStatusid");
 1   DROP INDEX public."IX_Machines_MachineStatusid";
       public            postgres    false    202            �
           1259    21703    IX_Machines_MachineTypeId    INDEX     ]   CREATE INDEX "IX_Machines_MachineTypeId" ON public."Machines" USING btree ("MachineTypeId");
 /   DROP INDEX public."IX_Machines_MachineTypeId";
       public            postgres    false    202            �
           1259    21704    IX_Users_RoleId    INDEX     I   CREATE INDEX "IX_Users_RoleId" ON public."Users" USING btree ("RoleId");
 %   DROP INDEX public."IX_Users_RoleId";
       public            postgres    false    217            �
           2606    21705 1   MachineStatuses FK_MachineStatuses_States_stateId    FK CONSTRAINT     �   ALTER TABLE ONLY public."MachineStatuses"
    ADD CONSTRAINT "FK_MachineStatuses_States_stateId" FOREIGN KEY ("stateId") REFERENCES public."States"("Id");
 _   ALTER TABLE ONLY public."MachineStatuses" DROP CONSTRAINT "FK_MachineStatuses_States_stateId";
       public          postgres    false    2763    206    205            �
           2606    21710 4   Machines FK_Machines_MachineStatuses_MachineStatusid    FK CONSTRAINT     �   ALTER TABLE ONLY public."Machines"
    ADD CONSTRAINT "FK_Machines_MachineStatuses_MachineStatusid" FOREIGN KEY ("MachineStatusid") REFERENCES public."MachineStatuses"(id);
 b   ALTER TABLE ONLY public."Machines" DROP CONSTRAINT "FK_Machines_MachineStatuses_MachineStatusid";
       public          postgres    false    202    2761    205            �
           2606    21715 /   Machines FK_Machines_MachineTypes_MachineTypeId    FK CONSTRAINT     �   ALTER TABLE ONLY public."Machines"
    ADD CONSTRAINT "FK_Machines_MachineTypes_MachineTypeId" FOREIGN KEY ("MachineTypeId") REFERENCES public."MachineTypes"("Id");
 ]   ALTER TABLE ONLY public."Machines" DROP CONSTRAINT "FK_Machines_MachineTypes_MachineTypeId";
       public          postgres    false    2765    202    209            �
           2606    21720    Users FK_Users_Roles_RoleId    FK CONSTRAINT     �   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "FK_Users_Roles_RoleId" FOREIGN KEY ("RoleId") REFERENCES public."Roles"("Id") ON DELETE CASCADE;
 I   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "FK_Users_Roles_RoleId";
       public          postgres    false    212    217    2767            ]   �   x�e��!D�3T�{��cclSD*���_�"��d�1Zx���&&���?@]�����'I:_	-�EL-���Y��[�Ok�Mͻ�)-��-Sc���Њq}�<����5
����%��%��P�m�u���o��HY�N|�֑Rᆿ����o���E�6��}���v�P�      `   =   x�3��I,�H弰�¾�.l��pa���;��8s3sr2��9/,
n����V�d� �$      [   _   x�%���0���K���x�����m	}8���5���C���д�-�D�l��9!�hc��m[�	ʿ���K[@eK[�%�l����m[�l[�^ ~� �      c   x   x�3�LL����0�{.츰����.6\�p��¾�\F��ũE��E�/l���bHՅ]
���2�_����4Y��9s�K@�� 5�D�^lP�����*����� }�L"      e   }   x�3�L,Ȍ/-���())�����ON���/.�0���^lT������
�_�d�r�.�_�za� �]
6�[/v��{.6+8xr��.�/*�4401�0�¾���4.F��� X&b�      ^   �   x�w���s�0�¶;.l����^ ���Д�)���Տ����/컰$�ih�U����_��ya@��/l���b��&��}�*\l����w�f�9W�k��gئ�6(\l ��T�����+F��� � LU      h   
  x�e�=N�@�z}
zk��k)�MBA���`1N*+���!��$J��썘���f�x�<��,�\���\C��9�p���vaK�O��
�p�[|��n���3ɥ�q���q?���E?�J�r�D������_̼��bvv�Ns���La��P\�5�q�������.pE��G\�~������u���/����ҳ����Nρ�>S���N~!m�ث��.��f[Y�J�ZˈKgʆ��c�����      \      x��}��$9�ݺ��4�]d���� c���0������j��h�vu�:!�I)�$�?
��#�h���F(��J�u�W��#�t�!�/����_�[�;���]�(���̟�\�F!u�¦������e�T[��o���C1���+�_���_�[��������_�����̘�Rj+�;��BC�9�Д�IaCH"�քFkC))$S:vL�C z땆EnN��㕄�4:/�l��dI�"J)�y��= ?'�;����x�`A�S@��1��BB	�T� �&l	(bMZd��J&��I@8X8�W1��g�d)���U#KQ iOV�m`)�պe�*� ���0�p�pZ�4,b��#�E�5��^i�9�RTk��1�0J��ӱ:[���D��A�i�Ѱ��AA끗�b����EuY	�$�6�"�)�I�|��� ���J�"��<*e�X>�V;�f��7�т� �V%�R�I/���@� �i�X�4,b�K��z�)>��@ �$�J�Ҟ�@�$եƘl�;y¹D� 4��ۦX�0�He�5cN�5tj֓�
�I�Ś��H���V)W�J�%r���B�5s�T&=��^7�G>݄��@&A^%�V;s�A8i8��M��a.��Z;�ȏ��)���U����9-�5��|�-H�M��D� 4��ۦX�� �N�ɦ8���L���t@+RT����Z[�%$r ��^iX�� ��"�1���)�sށ�:Z����i�ր�r�@�A"N�mS�ax�H���pX/4��R��Q��gS�D��Z)�uԃD �4�+�$2X7��^h�9���]5��*��Rf'�A�5��:9�p�pZ�4,bx�H
��,�[Y\�����ve�"�H3KYfEK�� ���{���A�tx��i���kԁ�2��:�W@���e���K?�q �`�^iX�� �&���z�G�c��Zh�-%7 ��ӗ�5��9*� �'�{v��a.�ZZ���z����9h�����V!k� 1!�N��\G�4|�W1��Q+���z;���V��iڗ�ωT���WS�+:���8�p�pZ�g�K���L>֫@��DH�â��VZ�@N�M#�
Qv�9�pРڰ�a.��df�&>��h��b)p#y�W�$����� zs�A8i�=�"��Djj�O|���)�f#)����e	""FQ�U����{_�%r���B�5�����c�А(f�2��}v�$O�AA�������� ���J�"��^���z�H#}�.Q�^��S�o����X�� <H� �A�i�I���������z�AJ��䢀|6�"R��2��5fJ�� <H� �A�i�Ұ��A"��D"O�5npZ7�fRlD_(��$O�F�\��/�D 4��[ܰ�a.�F:	C>��U��ܭY
_e�s���u��T\����f.�#o>��U���D
,ƛ�c�n������$_�H%R�C+�&��v��%r���6���D-'w��%>䐉�;(�EWA��k�2�:��s�A8h8�7�0�%�p2��^�!��r�-��"8������l3!�R\��عD� �4֛6�a�K�1ތ��z�!d��r��L�������K��e�9�p�pZo4�ax�Hk�D"O땆��8R&�}��5��#�#��R�]� $r ���hX�� �||?��ޮqI�mj� �RM�P��}{ckH]��$r ��ޯq�0<H��I0��^�H����K*�I�P>J���Gc(՗j�A"N�{0���A"���Q|���y]C�D_F��$gE-!ǂAw>�=H� �A�i��/ax��`&�p�ʐ����}_3P$N�(�-�BSǍ ����a����y5���X�I6��Κ7�u[���,�������Q�y@8X8��${Ã<�� �c��$ȐU�c��{R
,���e6d��Sh� �'��v䲆�A�d5��{]m?煡����!��+�d͹h�-v_�?�� �A�i�Rװ�a.�V;^�0�T��"9O�<$ώʉ��A��;syAx���
�0�����昆�zH�l�M�oV��)t� ���Kp�\ GN�M"�0�%�:�H��z��a�肐Iт4�%#��+U�o��� ��%r��K�"��DZ��%O��B�jh �J�h��KtI�")TU&QH����@ �+���h�����c���J+��!elZX,�U�J�Kj>�N��\GN덆5���Џ�=��\�(ZV��@>�(Q���VS���� �0(	]�� �(�8|�Xo�!�&�,L�H�m�"�\v�K�vlx������z_K�ari��^#H�Sk9����XM�|%��P�M�]�q ��_�-b�ˣ��i�X���-��VO�,ЖD�N����V���	s�Ax���B�5s�令���z=��1���d&%>�R�r�Y�=Q�H�;s�A8h8���5s�tZM�>�륝)��V��by�frߕ�.B��w���4#��vi��a.����	�5����F�/�R�ck��UQ|�D+��y�n�����R�!�ˣ3Ώ�Ǐ��%<h�%Q��w�sQ ��3e������衛f�`�޼��y��e|����;���)���;�k�YxR�|2�����M3�p�pZ��V�`x�G��{ˏ�Zᢍ�|�C�ʳ�
"y�)����Eo�4#'���rÃ<�ɵ�i�]� �%��ur$L����05��o�t��f �����\D� �!�c��x-����&)b�a�$�����h 
�D|�\�Rz|��^�Qj�4a����5+R�|�P%�Ba.�#o>֛4�a�K��j�>֫4��O9�/4�36x魓�~ �.�����z��5si�zv��^K�Mp��:��M~|��" ��.DkTa.�#'�#�Esi��d��9�Pm,ZDJ߸��>)�S�8v_%��\ ȋ��譝\�����9��2������&�0!�+-�JCa.�#��<�ax�Gg�DN����(��X�rK|Jī���=*�< 4��+�䑵dL�i��L)`�	�d �������L�"�X�.?G����f���B�5��aR���^ݜ��@��Uy%��ʴ�L!L������^����A���z}��MѼ���2X��_+$�]tuEG���O��C3�p�pZo�bÃD�6��c�v�$�$��dl$O%����`j�u�!<H� �A�i�uѬax�HT����)����	���#>�P��_�&�LB�j��@x������z�K$q�E�^����DΎ�Lc1�,��$�ƛ��B��E3�pҀ߻h1�%2P2N+?��E]�y����������R����ԩ�C����~Q��a.�A�IY��z=v39W�䬚j�Wm+�Q��!T���D� 4�������D�W��^��(RQ2���%�r׀�En�i�T���D� 4��[��a.���&���U"s#uJJ
��Ew�k�R����� �%r���$r�\"C ;�)>��YC���,���B��TK_"��j�;g��E3�p�pZogk$��땆��L�����]h"��E)�Nvy�C��A�i�Ѱ��A"ٻ�i8�׳dC[DH�}v�^�,���<�V�d�hFN���a�\"A=�?ֻ�hC!O�S���&\���h���A�K������X�0�H�HlE~��8���Ys]�4a�[�(0Ħ]�_�����f�����0�%�V�i��=ao)�&J>
mk�H�1f�r��C��I|_��Inō㆏�Z� S�	��<���\�K�K��M�"��.�����z�gX�0�H0��.뵞� E(�	r�[7$�+�<Q�nr$��s�A8h8��z�5i�M��^S+KA����    YI>��$lN4O.��ƷE��@8h8���jÃD:�HcN�5������(��3G�-�S5��������.�����z��0<H$��_��2������U�GЗH��Y���'d����hF�_g;뭸e	�K ݀k�t_�;i����!��!�/����dj<M�ZZ�ȥ�b�ZR����n����N8Z���#��V1�9��}�+:Y8��Yp�A-YPFO	n�������FSt�!�sN땅En΂s�
lNN�oP&����kڗ>Ӳ$T�U�l��uͻ�f�� ���i����!�Y��[fw�pZ��)��9�0V"}���џ��3�q��!�9����"��(�pZ�@Im�h����a�&�ER��	�s���1����"�u�z=?$�/��T���Qx���$��\�ѶP���t�A���I������"�ec'���PV[���Q1��*Y�hSFrP�,��1���2$��+��巳�������^��Z��w���M�\�����wxP�����zeaÃ2��Þ��&�B�I���|�����(M6�}o��q��d�~��ք5se�H|��a�(�w.�D�[�J�y'R� J���f,ݨ9�������vӃ�ߟ+���[6{��O�oj�
�������b��%Sc�^�֕��&���+��h��	�����B,�/�F�M<�ޑ�v-��[;��8Bp�pZo���a���+a&,�K�,�̔����z�*������t�Z������a�E�k�H�o� O�o $�"�ȉ���"��\Cr�2�v�t�k���
�w︈�A��mL�i��AҎ���v-ڊ�ǣ�R�HH�������AN땅E��`�I�el<$�U��Z�{�o}dQ}��
����q��d�gҋ��'v��/�^PDN�L��W��b4�1�-�>{�]����6����"�U���c����|���&>�|]�x��+��Ul�_��8@p�F��U��&�pZ/�H�s�7e�`�Y)ЂY�R�Ϊ.Z�] 8X8�7e\��h�� �,�֋&���$(���H�	e��J���X�ז�2,�֛&�a�+�����4^�C��g"HޑUq1���%��y�Zj��s]�����x�k�����H�c�́M|����;��H�����.&8�Z�4�uq��$�~�ba�\y�ٗ+����z�kr��=l-�=/�y~!��F1���+��2�,��[���a��\;���,�d]l ��үR[�(�T��[�zse!8X8����5se�n�#N�oL@SL���9�m�B5t����� ��-��se!8Y��'*���X��|���9�H���/�c&�y�O�)�O:��u�q��`��"�5�hU�RRv�pZ/Q���}T�5-l3I�o{!�_�9�R��<�� ���i�ōkԑ����<����\��Iĺh�,e�F��]p�Q��C�'pS�>_Z���}�s�pZ/>�=yh���H��%_�#� ���<�� ���i���5�������z�1h�l�'��@z��o�+��4��zP�����z�k�1|��?Y׆��!%�"xډ�#�$i]�,��5��S��A½���"�u��d�^�#�-m������ܒȮ���;���bԃ:,���}��uD7�'?֋�D~�";��K�[2�1"�V$�N���<�� ���i�y�5su��Vː����G4�?�d=K��-�jQҾ4�j���������G�a���W__D;YP�G��>"e\1�B��!�+�,��9�==W���u���#�0��ѫ��d��l�jE_H+0"��A`�N��J1S|��mz��#'�Z�w����:z��8��X��K���Z�,3e� P�#��E��m�N<�������i��/-a���7��P����z�
(2'�qj�0q����e4��.F��q��`��|��u��[K���i��/D��s�Z��P�N����T��Ã:,������utr�#N�VA��$J�i(*g��j��b%%�����yP�����z�UX������ϸ�OC$���cn"�ĕ3�X�[|͇� xP�����+��s�5�Ƚ�cN�e-������lMx���{�)R�����8@p�pZokaÃ:9)��X�u\�ҷ"+�%+��xK��G��/�S&���^ɵ��Aìz�c���@ȩ���x���=�L�ß(�B��u 8YT�,bxPG�3u<���2c��'��V�%�G��*��P~�������u 8X8���rÃ:����}�pZ/�`Ҿt�'q��B<�M��G������u 8X8�7]X���M�����x!s�^���#�-֐��B��s-�@�����:�,�ۀ��ZX�0W��㖇,|��;J����5m�4
ق�"�Dq�^5c��8B�f�c��Q.a��c��d��i���0��5�>���ؒ�D
gZ��2ٹ:�,���ZX�0WǠ ƙ��z��P9�UPȮ�Y�f
�D���)��A���8Bp�pX�Q���:=��=��hA�����<5��)�&BM�֡��{��<t�~��@��]D0WF�M'�L��v�R�/���l)�w�6elNW���6?�Ì$������e���J�$X�-j�EUQ���KM�+h�ep���R���A���A��͵|��5��M$?p�>D��;�
8N��(}LJj즲��N�����@���y	��"ziǧl���I�,ũ���z�Ԙ@�\"֒���[�}0#	��vʶ��A}�D�����$��칟=�Q](��J� ]ׁa:aFN���yÃ*��pZ������<�"� �z��j�� w��0#����"�U��SVO�:��}[o4I?Y ��$�ΔL�'"yL{���|��f��`�s^߷�k�����pAs�S��w"'M�1�BI,�l�2��Of�!x��������z	Ã:��6��d�^�tk���T�5�mʋ�П��Sj��|�!8X8����5su$�:&�4^�љ�*�.�5z�6���tɣGWum���3��7��k��JMjW>�k�������"P��������[)!)�L7��<�Ì$��{����2��o�$?,���L+��(b��ΔŚL��tE�r�`��#'p�f����0̕���<���Y݊+(h�qG�� 9k���L�n@:bFN��vv	�\��oo'�,��˩��*�D ��,�R.�t!U�҄�m鳗�������z;UY���ޓ���K�h5�E�<b"}�V#�����|0R#x��!�_�[��᥍D�W^��x����@��(ʌ"߅%�C6k�[y,;?�����ӥwO�Wv��~�	��ܜm�6~��Y��r9��)�ڑ��@�P�QR�nG��b�,,��+�#�������l�R8Xˉ��F��u���*w���3fa��`�^YXĀ,���?��, ��T<���j4erN
-���&�=�m�]1�#8Y8�W1�9.��Z8�]ȭBr��ސ:cD�x�ҁ�((R���ƻ/f�� ���i����u��یݓ������PH�DK�D��EA��y��ݽ(>�� ���i�����A�g�?��,$� �RY��_'���Fۄ��Ɯ����AN땅E��Mv�i�͂��jW��^U#�s.�^@�����;<�� ���i�����AQ��������XSp�$,p��K���M���#��:ڭ|P�����zeaÃ:"~{���^�x���/�4�� �·���h�������u 8Y��;/1����0����^X��R�oA�̾� A��?-���wO@Z9W��7덅5su4j|��1^�C�&B�y
�lt@�_�P����~����?(P���nXC0WFCA�8��Xs`L�BU�2!�MD    ����Y�k�C0W�����zea�\��q׏�1�bj�V=cI���|�K��,FBw3l�\GN�V�����0̕�?���^2)%��U���|&U��5sڨ����!�+����i�eRk�ђv�Y8���є�U��V���k^H^WL�e 8X8���qÃ2:5�����f�������XyV�Iq���KhQ��C�m 8X8�W1<����`�I�W_"��m��G�P%��&uF��m��ZmR��U����
����&�!xP� ��?�KF���^=��J�a�QqX)�u-j��mZ���	���Q�axP� �1�� �2"��K����S�����9j���V�~P����=��baÃ2��:N��Fȋ� %�BK�ɑ��D%L�j}k���C�e 8X��!/1<(#1:��N�%j�2�L{ ��&rS)�8}9	��a��e 8X8���q�\)��0�X/ڈ�"d+8{%e
��7�{�"$U��W�\G�,|�7u\�0WGbɎ���z��|�ʧ ���|���O @Q$[�f:}6su!8X8���i�\��a�N�E*��;=��2����o�D�)c�h���\GN�M�0���Z���c�ƍ��Q�N���E��D�$׀�m�5�w���q��`����%su�΍��X��k��P��x���R���t$����k��8Bp�pZ�,,bxPGo�s��x�L�(��xVڝ)�w�Ƚ����N�̃:,��[����ACϫ��^�B��^-t�NfJZ�Ӣ������c��>�� ���i���5�H�h�D|���(4i9�F��vF QTG�m�w{��}P�����z[k������c��7fU�<��oŸw1�ʭ{*����S&;W��7���q�\�?��1^���GE	=rՀ�$�|��"7�"y,�����\�P�no �O��̕���o�Ψ���X�٭��59�����E�ܝ�ع.~�`�~?s^D0WE�ݸ���z���5Qz��sܵ��k*�(	
�1�:*��8Bp�pZowQk���3�NۅJ�ir�P��qy�l�P��l�_ﾁ�+��_���m:��o���s5�'g��%V,|7n���f����p���lA�E������p�����b�5s5��z�,���:0P(W�A���7	�Ee�U*��on��#����0���0��o�g`��4!�\/⣀tL�f�\�`��#����"��*zp�L�c��3z�d��5���äДh�yO��K�;��sU!8X8��s�5sU�LΖ>֋�Ф���ǰ@.��r���E�jݞ�se!x���<���:��n��5V4`��;T�8�T��N�l��[Y��?W�����z��0��13�>֋.��?�����q����$0Ԕs���t��������i�����:���>�c���[��q�b���q���H
��Q�ڽ�d�\GN덅5su���a��z�!TrPV�V�tRܮ(v	2W��%tYl������i��k����c���k��(Ve�"\h���&PD�R�:,���ZX��8s��C�fH��(]�1�"%tC�b�������P����"��2�T0ք���%����k�<٢�aw��T	C��B���2��I�Xo^r�\A�nf?�kĤ������D�ӕ[�S��9c�=��2�,������2���4~���5���D��gNK�&-|4%�w_މ ��8Bp��5����ƍ���X/U�%�y�K�	���)�n�%rd/m��!�+����i�U��a�+#��8>u�X/,�@�]D0���|��S�-E�9��\GN덅5��շ7�ON�E�KQK)
z���Y�3E(]��Q'��C?����i����u�-cN�~	����(���cHQ�:�
&�N��aFN�~iÃ:b�8���!f,���Z�	-��j�ﺹ���f��`��NX�0����8�c�Tl/%�,����H��0&f�|6����f�����z��X�0WG��{��%j*NR�b�ɜ�6��R���=$�hOӝn<�Ì,��[Դ�a����x����$�_�X����TE��
-+��:����:�,��k�ꈠ�8v�X��c�)���7)��"jrZ��2F�&�*ۇ~�����z��0���dG��K�`���o6E��ro�&,�\�t �܂��~�����z��0LՑ֛ǎ?�KFI����p_wgI�R��tr�VӚԾv��8D�b��z�)�0L��K��/��X/;"YH~��7�xZb�V+�����:,��ێX�0UG��CO�c���eb�ݴ�į {|/�Kd7���ܼ#f��d��Oۖ0L��K3��1^��� 

G@���	����)&���f�yG���
�m��;VXC0UF/-m�1��=ېZ�Wm-��õ���p0)�7���O5����$��[����Aك�Y8������kd����J1[�B���t��ܼf��`�ު;�0<(�'a�pZ/^2���Wu�7�GMZ�0i�����n�3Dp�pZo^rÃ2�M���a��2)5�"�+�v$��:Q���	K�Ο���?o������&���ߡ�֊��_�[?������|!�E�@�$,�`�\�o�����B��zkǂ��U(kpJ��ˠ����B���d�w��;�q!Y)|I�K4�v�6�w?̐��7땆EjN���f�4���d��x��e3�ȍ��H8���9��~ݻ!fL� �A�i�Ұ��<Ѐߜԇ���75$#����Ȟ�f��p�@�*ڨC7O׽;b&4|�pҀ7?��a��������!5g!C�~���-E�����Te]�n��0�p���E�"��Dz㿉�I�i��`�,�P�&�
�J����Y�1Nv�9�p�pZ�4,bx�HJ8��'��JC}�|R&����7�z�!bD�G�/̓D 4��k$��o�]'��B@�Ј4W�eKy�J�t
��Q)�T�<H� �A�i�Ұ��A"��?i��<?h�/�G��%g?��ˢr�R��%3�A"��=Ӱ��A")�h�i�Ҡh�ycxNw�6�ٹYjh��D��� <H� �A�i�Ѱ��A"�|�9i8�Wm�r���"O� P~kP���:�69�p�pZoڰ�a.�\F7�?�HN��/�*�;��[rV��l�N��ܕ:;���7땆Es�j��5|�>!�We�S��9�kRE�J��ۗv.�#j������M�^���A�Aa����B~�<�P�?P��tS�K��A�i�i���D��8��X���#��҈�-?�Ԅ$7�yt^�] k�9�p�pZo���DR������^S���})��+���m�x���w���K��A�i��Vk$қo��'��BC��"�"B0�D��(�ߩ(�֩q�kUr�A"N땆EI�DN��S4i#�t���I�r+�'g��;� ����)�0<H$�o�*'��BCh�0�ƅU��{nr'Uʕ�(5�Zw'?�A"N땆E�a�S|�W\n�ƛ&��t�m�H��|�L9�p�pZo4�a�K$��j��i��������_S���
)�71��W�_���@ �98�W
�呢rG����%i��U	�#eiO�YXQ1det
�Sh?������z;rY�0�G�h�^�c��6I��Kx�xh_��,�������q��ގc�0��|4{�pZ�^Bz�[Ҕ��%�K4�ܷ�ZQ~������q��޼���<�M2��^h��@E
'yP���QT_#����E9?������z�aÃ<:�}cN�5���4Ɏ�2��x��kJ��J��P[�A N�-�\�� ��}��z�pZ/4��R>����ʭZP���F�� ���J�"��v�-O�5��A;�P�_���k�u�#�*��?�.�9�p�pZo����买c    N�5���(�Z~���:�P�P��[D 4��[v���A")��l��z� 4�䧢+�R���'B1��zc��A"N�-�\�0�Hr;vL��z�!HI���4��3�r���ڬ+�t�>a.�#o>�k����S|�WO�LH	��l�o��,�B#\V<� A�� s�A8h8�7O��a.�h&��i�� �*��"d漎��@�e)��Vz���E�0����=�^D0�G�����^H�%��	2�Sh)�*8�(�)]�syA8X8�W1���׷aO��u���	��J����G��"b�e�[��ȣέ�&����AC�?O�>uZ�� �`'U.�5�H>�=W�{}}��cҵJ+��u�9x������z�'�0<�#�ɉ��z��0�-_�g����e���RJ�6|=�tB�y@8h8����5Sy$����MÏ�AzZx���<e~+�k2iE
�9p#G^��>�S�Bx��c�E�k���,lL�i��	�U�ܱryd�f�'NJH���-H�J��A�i�y�5S����[�X�����R)?{F)6�*�"�]�/���q*�C'p�K��k�I��׊̓}�=N�Tl�� ~��}�S�'��;��u�>8��!��}�
}�<�a�Jd�7.���^�l�4g�Ld6���PPS����˩D!4��;"�${ÃD�ٞ�_�����nR��|�쌈FZA��l�R���@~pp`�o�E�H�l�,��Q�fQnh����vgN}э���Ax������z�k��}����__�;R*_����<�p��Zx#U��i	��� ����;�Z�� �d�8��z=�M�qg�H�K���/�2�&�����Ax������z;�]�0�G%�׸E��^O�����M����W��@_�`�@���8B`~[o�NK^�h.���s�[��Z��*4[���XI�h%�l�H���k�v��G�}�1�[;�;�_a6�yl��V4k
��hEi�M�>Q��w�A�<`nE�Sxv���{^%9�j=t�����"�����1��ϕw����Q�K�롋��Ŀ[j�uA�}@i�!OE�77iZ�Nr��)���O �{j�}}X�C's6.WO~Zw�3�hqVn�׹�������"�:	R%�S"R�F�
f3�6!�E����\�C')�/MRf��1��u���QJ�M��=:�b�N*�Z�XD���K�":� �m>�j����\�C'��ȓt�d�����i!��Ut��(�G'A��Irζ�oV~��Ӣ�8ƃ.2��S�!���E;t��R��3~L��,ʬ�]��Ⱦ��+�����E;tR�^�D�YЧ�G�hMѾ�Juy�٣�� v�$�JT���/��B]�1�$M�F%��T�=:�b�N*��0�dr�>AXx�m�u!�ݣ�� �ē�:��
m9��OgJI0�<Z!�C�O��ء��V��p��Y��Ly/�h%�v*h���"�:�j4�п�z5���I�
�9!���X����E;tҷP-O$L���^`��S��"�Kr�N.�آ��Z	�5eA��@'�pA��F;Z�?�&�\�C'�KE��hZ���Ч���&Z�\�ۣ�� v�dӲT~{�X�
|>,�u|�� ��څ�n�N.�ؒwG ��^$����KIy� ��v�۔w���O��%�RT��U~l�S�S��ٔ�U�{�)�\�C'���	�_ӧ"�*�X�l��T���{�G'Al�IPY;n{2�>N"��>���R�U�T�M:�b�NjC;Q�#Q��(
fRi�X�$Jgt�!���E;t2{�Xd��W��J���!m�4�%�ҥ�~�N.�ء�@Q�k<O�FaZ���P �ē�s����G'A��I��[��yl�� �X��@n�B6�{Q·=:�b�N*��m��ٸ�I�+�8�皃D�g:{trĖ��b�w�%�{����ً$�
 ��n����'�@��In'���,���b}��YxL��6�.�{tr��l2�PhI���W�F��-���kw����"�:�R���~O����D P�"��)���\��.��?�1�(�[���$�m�T���;6���ؒw+��UV���z_��y&ޚё��d�$lʻ�@��II�Mp|g^6\��O�)�+Fv{tr��4��(��9��";k�G��^�a�N��ء����
��O�!W��(�"���.��=:�b�Nr�]J�[�$D�5^ ʀ�[��ܣ�� v�M.FW� ]�#RG��f�T�m� ���E;t����I�D}M�Ն����$�:h�j�p�N.�ء���5��7��9�ɤX:���I����\�C'�K5�"G���U"(Y�����#� ���"�-:	-ؠ� 䮰�x(I5%���֪M� l��5[�'u��R(G��S�b$Ei��J"TT�M�k ��O��SV���Y���,��&aF$o�u6�O��ء��֞��q�'�m�eN#*��L���� ���"�-��H  ��<~��ID�h�H���b��Zj����-uAI���K�%��fc)S�U��v6���ء���ϧ�<�B9��lDqJ;��F�;{trĖ~
Qt�@�$N���(OyN��~A��
��q�@���TM��r\���loN�fRQ�D�Aأ�� v�d���$��a� )�AJz��?6��,�ء�F*��r��W͖���^���H�[�Cأ�� v�$Z�4� 4�EN��{�o6��PMu��¦~�E[�'�+�X��$lΤN���Y_�ӥ8��qA���|��(���.���R��.!-�hJ�6��,�ء��2��)�#�����8��N��i���M�8� v褤.#�Š�u��s�@W�7��֥z��qA���s�5ZQ<����/J��\��i�Zw���"�-��6��=ĩ�&Q(���:aK�@6��,��r��\k>EQe-�Jڤ�PC~L% �	�M�8k v褬`rKP�yЭp)�S�Ŕe��*��]aS?�"�:=�B�I��2��$����5��:�鮒¦~�E[�qJʮR�k��+5���r����Q9�¦{�5�H'�S\�~2�r��H�;UQ)�m�)��G���L��z�$�o������1���+�W��
[�«AL	��~��\'ԯn�o�_���$��}a���0�l��+��n'����|WZ.n�(�Ѳ��_���:��h�)������IqyVQKS�6>�.�{����4,b0h�D�B;�=1Yrw9�$+i��R�j��j���iX��6А���ǒ#�}��)҂T)���_x� �4,b�!�^�S���	K�HDC�/O �6��'~��"��vHdh���o�f��u��D!n�h�;�[$r��,��T�q~<x,���OƲ��wQ�o��E;$��c�E��<�J󀞒D�I�hi�����o��E;$JlYU~ô���F�<-�APd���o��E;$�� ���Wͯ���-zQB�!E������\İC"A�E�/5�y���J�������˰E"1�H��'J�D�6	��Ȟu�Y�H{Vw/���E"1��jk.�$�C@aU#��I��Zh�&)	�d�"��vHd��a�2�ȝ���`���FGv��Cu�H�"�ɣ�\O��͑ו�~��W�+׊���-��aK��tQ-l��2�Z�T��颷Uɤ�x�$�kvH����#-C��.m�*ڄFc@�����H�"�I\���y|Y.U �������@!]���\İE"���D)r�l��MΏ�d�2`��m*��5[�Ȧ�L���P`�e�Ng�&%�q��(rÖD[+
\�:;�=q�L�x��&0	���pO���a�DҪS&��_6�/eM}K�Kh��9]���H�"�$���u09}"(!	��E����������%�ǝ��B��W����H�7�.F8~���?����7 ��cp\�j5-U��/G?���0�`�okǂ�C}C�@    �ҭB Z�)4F�F��-��*��M������E����-��W�J����W#P�NQJ� ~r;xu���4,bPh���K���5yA`!�6�%Wy�@A�a�ٱ)���(����KQ����XclL�Jڴ��`�l�5;$2[�1Y�ĕ�9h�zx[8����x�[$r������ŭ!i>��%(pIh�a�	���@n��E;$�'C).?;�RM�]���#I���9���H�"�-�+j(H�ǥ'���T1�RTP���G"�0�HT��VD.��T���+O�s��*Y� l��E;$2���[�C�#�y�cI�)�.�\�ۗj�D.b�!�҄f�Fa�EO�&	��7�-O܀>��E"1������(�6���KD�(D�+�ߗz�D.b�!��Yo�(��R�?�T�I���\�vu&��H�"�� 6�Dю�)�l��w�䮃Q���-��a�D��ɓ�
�8��w��ї P�������"��vH����ch�(�6)�k3�oњ";��[$r��lZ�X?dʯ��N�9�I��r0{$r����;���'�)���>/�I�_?��t�d�H�"�i<�o�~�!aC枯wWd����A�"��vH$�}6!`�t�͜�*!9�	�ٌ�J�-��a�D��c��B�Ĺ��\���q���Z\��-��a�D6��.�̯YRC�bIQ1F�ԝJ�-��a�DS��R�J|E�.)5�:�	�DoJ��v�D.b�!��|u�h��`�
� �(T�>.h�ݾ�[$r��D�\�n���T�S�q������N���E"1�HR���|g�%�Ǌ���R����:[$r����6�$|i\V��|,�Z��j.�^/p[$rÖ�HO���?a�yx��Tj��Jw8���E�a�E6��<b
IX��gB���WF�ZaO��a�u�Ou1��Y<��NM�z�D��fÖD�eM���8�m���E�BebaO���a�DF�3�CB���Kٹ���V���"��vHdr�����2$��H�0K�#C7u��\İC")�oI� ��<T�4*�Z�*!e�r�N���\İ�臂v<�+��$�g��A�������D���g���U#�&QW)�㎯�t���T�B�E"1��$�w:j�%�k(�I�zSP�w2l��E[�1Ŧ���p?�|vU	d�l��aO���a�D�浥N����hZ��r&�n��P�kT���\İC"5)/O�!O-y,|�"ъ-��R�.�[$rÖ���7���4R�#ɓ���31��c�/��E�a�!��T��(.��<�b��i�ˆ�t�l��E;$R�Z=�p�a��S<�Y��kҦlK� a�D.b�!���rR"`���G�?,\���%�u*[$r��l�8t�D���R(F��4Cy�/����H�"�-�6_�����o��5HXg�$`��]{�5[J�UP��*J��������F*��R`�R� ����5;$��o�;���� Nw�f� �R�X|�-��a�D�Zt��3��:�Dn��d�8��ea�D.b�!�JAk��y �v�M���G�Z���=�-��aK]$"%6���@�h�&ʧEԔ���T5]���f��̠���)xN$~�Ι�#j�]�*n�YðC"�En�K<`�O�c�*N��)�S䮺���]��aK]d��U���"ɓ�|0)�/�t�^���f��٤����*m+�0?�-�ņ-�A�"��vH$,�i�N)�m2E��E;Ec�'�U�� l��E;$R�f[s(<�+S�b�f`��<V����YİC"��6�h��x�R�ߜ��Ĝd���{�k1l��X�o������ U
t[�<v�H��-u�)g�9	#����^����5SV�v*���fÖ�H#�.9
���%��(�!�+�Pb7�t�,b�!�Z�%Jry��*\į�a�Oч�*MpOw�"�-g��F~X���VI�+�l�L��OsQwa�Y��Y���pr�8�-Ĥd���BYSs��v�H�"�Y��>D+j�/�H�4�q�xL�Vc���YİC")6i�O���K>I��r�FQ�����"���������6>/�'5:/d˒>�=���=�5�vH$6�>S�%_�E~����S+y�j�nOw�"�-E?MQfC1)��l��,�B��[�ikv���a�Ҁ�2�<?y�X%b2E(��Bo��d�=�5�vH����@�<�"�_Q�#)�u��t����Yİ�te����|qVT�ȴbj����Қ=�5��D��/���yh@s X���6%����=�5���P:#���3_�k���y��+�k��=�5��t��jAD�<;�|���ڬl�j���M�5k�$�I��1����%xSP�6t�w��qOw�"�&���u2_��;�����$��A�\�8����J����5+R� h�$�\It_>D��?�	�u�Ɍ�E�,�1\ud���N	�]`���Lw��~��ǓG��+{k����]a6�`�r<�p�� $/r���@u]��~��_�a���CІ����%���Ǘ)���e.ҫn_�_���yX6�\�\�Po�����S%6��X��w�@?Cn�����rC��z[Ǆ*]�~����a��l��H��(���������%� ����E;t��ц��l�K$V�O��o��!趦ߣ�� v�ʔ��fϼ��h5��أ5&c��0����E;t��l�%��ڔ�@������U�����~�N.�ء���d~�^Ғ�u��P�ڜţ�:���E;tR�*��YTY�u�0�W�0�,I�l� ���E;tR� !Q������(�˚'=�؍���G'A��IԠ���h�Ʋ�e��{��hIBW��a�N.�آ�����~�,�SvC��!�*���[���I'�@��I�THQ$�(�A��(��!�VM�ݧ�=:�b�N�i�6����Yo뽀"��)�r�6���=:�b�N�긾@�Y��S�D��RJ�6�.��=:�b�NR�몥%�.<���b����,mQ]���\�C'�T:z��C(����d��h�Lp}�⁰G'A���Vjý��D�iIzi%��}=���E;tR��M%�«̽.��%PƓ)�O��֥z�G'A��Ɋ�;(V��VJy��ٞʂnŅԺw���:i�4Zi��Was�w��?1�<t��Z�=:�b�Nzrۑ���@�q�Zg�PhKi��$
���"�:���*J4��C�1#���:
�[�H�����k v�d�]N8~6�ʠDT^QDSrC���8���\�C'+q3?�LI� "�U���u�j�� ���E;t2iڂ�,-��Z�M�\B���S��Ba�N.�ء�6E~��s�.I�-|u EH���k�su@���"�-�8���TM*�̊NPƟ�%��<П+���t��b�=N���J�����))��Qhrى⛒L'Qj�=��:��I�_�U-���D�0ʆ��y� ;{tr��,RSB�	�f��y�%R�L�X���O�G'Al�I(�T�d�B��5�#�D[W�+���G6���:I*�C�3Q�G�����Qii\�Y��A���E;t2F)�3��Ò��F�Td5�d-���G'A��IT1�b(ճ�$��$��+S��y�:׭���"�=�Z&h(��]i)�Xx6:Ĕ�15��A�u>�b�N�FY-Z/B�v( @V�kȳ���)�♰{�5;t��PѴ&��#��A�#�]�,y-�B���\��~ҫRBт��ṔR�̥�Z+�<��ݒ4��'�@���Tr�2�6k>��s%+�oc��:�ԅ�f�N.�ء�k4�����򎶦�Z`�AkGN�s� ���E[t����ԉ�4_�z
n_�R�rj���l��5;t26���#�̥�*Ч0��u	�VL��e���"���򯆙Nf/=mHP<�n�䲜�h+�J�^8�#�������l�,;q4�ۋ�	�w����F�    ծ��'p�:f2�+3���<�$Q�gL�h�P~����)����R]��w��F��LG��m�Ѽ|�p0�=�z��p~�����
l���^�`nV^5����Z�m�^�,���<�O5�B�\
Z�(<j��?
[Z��т�O.��	Sa�s(,��Z�<���G�F�q
�T��U"/l�i�(���z�$��#�4���Ba�gh�]3?��Ku��u���8W��#	�G�QC �!L-�m�\� q�����N�~�
�㣆 :rk�ΩC���S���-^�o�+]
B���!��DzHm��I9S��E��D�r���l��:>j��،�&?7B�oa~-�ƛ`���`�CA�㣆 :�-�����S��;%�2r���|N>Үw����QC �F}��)����e�}�������B�GtT���-L�x��)XF�!����n>�:>j�����H����ݷ�{O�q�eA�ط�:>j�����|C2���"/��"�h-�6'�����x�7t�@����1~�%[$�-��3@�,���!t|�@ǎ�{Yk�m�Q^3�c�[�W��|�4�!t|�@�!���p{�-\+�69Q�6j�A��g�㣆 :�i�,��Z�7�B7��e]�t��� ����y�k)�1��G2�Ju�q�(Ņ��S�㣆 :�E�p�lA��ם�u�j�aɺl��np5�q�оNN��}�®iU]T��r}�q5бK��!'u���y�dӲ�RG�\S��X8�����괠�ԔW�wr1%�	i�S��MW�1SB�Gtl*�>J��F%��jPJ����"�"����QC 7fͥ�ڴ�Ky
[l�j����5�KA5�qv(��z��|�ck��ƦKw����
B���!�����%��V�%�|[�t��Xp���k%!t|�@Ǒ��_):ޫ֦_KZ�N��u��k����QC�w,U���-s��^��4�Z:�uE��c�㛆 :�ՙ��Y�v�N����	�K��>�RB�Gt��׶Xvo�S�g$��b°דg/�o1t|�@�ӱΜ֪��7�ņ?���7=��*zm
B���!����#��m6���n�d��fhomy��q)�㣆�}ǹ��깯ůQTo�ǐ�aۯR�����}�7!���K�Ԗ����;l{E2U�
W.@о㓆�}��A�
<�jQ��3|�-�[
eP���;�i��w�2�j���/�T�q��c��=��t���}�7t8��0�V�;o�	f���v6��:]
B���!��zΔ���RU[I��I��%��� ��IC G��Σ�=>-Z����m�����:>j��w��A����J
�,`&:�N�'��^
b��4�q[��d���e���!z�{�o��!t|�qf�RJk��xF�.I�}��AB/[�Rsf��!b��3���^�s(�f�"���׭D�2����;�i�#�l�.a�B}pRΚT^yc�X�� :>i���3dZ�p{���T�l$�9V[��jPbn��i���(P唜�������lvHc�Ҡ]'�Pb�;�i��w�p�>��{��߽��7�ڋb����ku��w|���8�R?�H�חB3�ٴ�*u����z5f��MC � �_3�J^�8�=�b��l"�y+�㣆 :�!y��\��Ź{o��g��:�V.!t|�@�<����$,�??#�}����>OL�̣� :V����^^�[OfS̷����a_.!t|�@G\�}��@>Uk�0�&��E����tbre5D����k?)��U<�YkM��N�t�/1�2oB"�]�߾���9��'5�-�~�fc�띌ɕy�Yohk�M��>u�zP{8,[����Y�i�$d]Ħ�9w�I�-� i�*�IiL�̣� :�}���x��:�V~n9���"�3ھ�kL�̣� :���h|~�%�u"{S��W<�+�!���xIͯ&��oQ-W��i��^�@��/!t|�AGsp�٪m��̊7�Lݖ�|�T��l��㛆�=f��̱��sp�q��{��Y��:�ɕy���X�͸�T��/�'��%��GY�x.&W�QC�m��3��Լ$k�%��������+sbre5БK�o�[�����$���m�"�|�ט\�G7z���hm����,2e�s������IL�̣��<�m��}35��ֆ9Y4��Ͱml$�GL�̣� :�E ٠�6}��=ܣm��K�]�\�G����*]�{�a�uPmiJy�EY�Z�cre5DбUoS��l�yx��X ���4��r��1�2�"n���9���}��ca�wH�"XTu�[A̍�7�2ݜ�,#����!�/�U���i�l�ɕy�@�C=o]ۯ�xZ�Xns0u3n�Z���\�Gt<#�܉��e����wI����19��:>j���+l�����7�����ˢ�ZI��[A�m�7!t˓:S�y�;�{GV�1v#8�"SL�̣� :b]�E��ܫ�2�d�����h�2�!&W�QC '���s`��a�Y2�f�;xϴy9�ɕy����D�ߧ(�v�
PS��^�������}�'t<u�z����g���[�%����!����QC ������lͽ���of�b�Z��`L�̣��}�<ʱ�(���ܫ�o�ܽo9(���}�7t\��S-����Z$�Tkۛ9W-��S�ɕy�q���(]�O��u�P�S�v��Y�E��\�GNG{5��)(^��r�^���}}��(�߼�/e�TlY�e�}�1x&3+�T,ƫ�L�\�_((�:������^�P~������k����1y���ɢr��<���R�"F�QC��Qh���lk�ll�w|f��67�+[��0�ɕ��Qx� �?
�e���vV�o�����B�����u�?�2�>
���G�\:&'hk�cid<���.���ɕ��Qx�@G�6��lu�g��J�蓥 7�L�1����MGC/2Ȣ�i�A}�kci۫,*]�C���!������
���d���ǂ�#��d�.!t|�@ǅ�%{F�EoۋEv8ұ�Ӏ�W},!t|�@GB�����nӞC�/����g4���_U����QC��G�d��$��S9��u��\�����MC kS�c�N��z��My��*�ʵV�:>j���G3��\�$ӢR�b��
�f�y^
B���!���g{�lq6����6/�k�$��'����k5б���
�_��⹌d��f�Yq���k5б�<٨����lԭ��ub�u�U����QC guz��̲��-��S�mF&�u�=C���!��[jœ%�����t��i�Y�(f��r�5���蘋����{�����NM�m�A���NR5�qx��Ob���̻�j��6ӂt�>@
�㣆�}��u��I�w�B�#����Yx�c� f��MC 5�1i����ߧ{F��4�;~͜��Ss�:>j�#��r]翝S�ܫ@i�"��ｯk��B���!���Jl��~��s�[vl�Z��-��s�C�7t<S�-K��j�>����b���-����8�b�1fʭm[��ߠ؜�V{��&6�:>j�c��1��^�x�4�(��۷:>j��}?)�~�c��4�9WF�+[[5�q3�"e�}�XT[ў���|bM;^�>�]����S��~��;���;�մOt�m��r�ǜʼi��9��I�>�춽��zڜ�稤��<=������;��@��
l|n�}l�	{�u�{5бȬ{/J�[^u'>������i糇��QC����#u��|�-U�u�7�ի������:�i��w����]��gzK��8LKF(��X�>��;�i�c�s�̙֜��/l#���������z�C���!����Lla=M����c�������~E2B�Gt\;On�+�zlo/a��ܩ��5��0�!t|�@�ږ�O^k�<���B�p]pC�3�k��:>j���|�I�i/�x��צ�� ﭵ��)1��MC ��Qf�4�O�
�$�v���sg�k��:>j    ���H^�P4���O��Zj:�����'K观���o�H�� �9��<��$���|�7�V)	�㣆GG��}G��&�y�d��@��:L.���}<��������v|��ac�_	����������^9�,j+���40؟�D�g�Dg�W8����������������(��Z�P��Q6�zv��#�V��~��E�ZSe�vI������؊��򞞺�1�P�N�|����h��Â�0p��S�ٜ��9�p�~\,�g)�l�o�G�R�;����W���̿��Y�j��l|���|�K�!�3��4��=~N�&�R{�S��KB"�4� r�s�Y���j��7J�U����^� �o"9{]�̥,�|�x�..c�*�S/	!�|���f��i�i~F*z��t����4��
� �QC"�B[�ͫ�q<�UlB�i#r/�>=e���!�|��HޣS#�_��$|'\Qk*��U�^�%!��"Yxr�����^��d1�yz�q�ך�!�|��H�tr�j�U-�K��I��-[�%!��"Yf�L͋�V���LL�i����%!��"I�L��/^�,��V빥��ڧP��PB��!�En�e;�ܧ��O�v�S�н�\b\䛆DZ�-�5<yX�Fó^7/�����X�D>j�@��.�l?'ڭ%�H	g�v��O媟B��!�8`?*,u�PO`�FG��K-z!�|����ǂtF_�U?I+���.T�_�W�F�!�|����} {��ZГ64��*	ʹ쥽xJA䣆D
ۈ����{��z�gN~R�x��{.	!�|�h�.��\�e��,�=����=�edkL���!d/��@���?�ؘ��2k�"y+�Z�-!f/�MC"��.uRI�xc5T����ޕ�����;
A䣆D�F�LO�aP�0@W��	QvN�KB"5���웚�6=�)���y6<��u@=��B1����D�e��2���y�秚}Y�G˰/JS"5D �,~�����-����q'A��0~�W�
� �QC"�B���4�9����+^l/&|�?�!�� �QC"�EG��z��%ݬ����wX�K�X��D>j�@$����+ي�+h��.���ώ�md["5��<ט������^�X�)�����)!&�~�r\�m�u� ��sͺl2��M�[B�q͛��"�ًX>7M�ٚm/'l�c�G�Uv����!��I#��n�ث��qz/��y��D>j�@�϶'��Is�	��&�� (Ҁ���D>j�@��}���s�֧��_2񺬨�t������G�<�h�
�Ы�׮�o��R*P�g�$� �QC"q�͞����w�������м�hA䣆D"�(u/�^��S�:��TԻ�V�D>j�@��FQ��?F�>������]8��"Y�$BɏLlB.kh�����A~����G���aRnI�A��I筜���՝[�WX�!�|��H3�ٞ��w9�F���OD���}@	A䣆�����a��<;�I����-S3-st5c����u�W�,�g}�7	@��J�K���]�=g���0����M$��Gu��I�p��,m��b援�_H�������,�z|�@�0�`�����}����|j�J��+W�$��ax���!��f�����E�m&.^�uV�J�AɏĚ��G0��mNfe-�;Z�l�J�9�}^����Gj�wã��r�eNez2��to+����_AM��[����!�6��L��d���(	�j?������D>j�@䚵�E=��-�o�%�����<mB/��B��!�UW=��
U����q�R-��^\��j�A䛆Df�]��c��{��΅������r
���G���wm�q�.���B�'��Si��/	!�|��Ⱦ�l[��;��^+�[����d�uIA䣆D�v�v�n��{Mss�^�<�}��BW�_!��"Y�94��~,������}�r�^��,W�
!�|���Q,�G3,��o�+����9����ǹ� �QC"���a^�Ƨ����w�ũK�%!��"�,4��c�=��#ek�
J��D>j�@��iÞ��74c���R_s�b��]��!�|��"[:=-xy%l���@*i�v�V�q�oB�^��O����4��l�ާf����rp%&�~��"�6�!?F�'1�i��V[��a��"�4D RԖi�Ūx��]m���iM��W����D>j�@��X���1��nyon/(�Py�Je�uKA䣆DZ4�v����%�������a�u\x*!�|��H���g�5�jOl��Q<�G�Fp���5��B\�n{/�N<�S��Q�f] �a�f���$j��|�hO���va�W ki[�g�nk�-!&�~��Ƚ͹��ifo�	^9����d��U�5���G�䳱IBω����Prվ��7��D>j�@${5��۶�֧���+�xb����rmyP"5D �C_Y���/mO��Y=�g���0]`��G!'��>cԝp��w�-��~��Bڪ�1j���7!.r�|l��L䅧T�(ݜ�ɼ[9�<���b\䛆D
3� 	�yoj�䵜�-ڃ�b߿�D"5D r�hޭ=ͅ�w׳9��S����b�(�B��!�X����^1�2�haJY���JE����� �QC"W�
������w9�v^<I�\A䣆D���z5��&���[����5p�6_m!�|��Hs(��R���6!ɾlݽ�"Ү�(�� �QC"����0a��j�V��R����<X\.<�D>j	�3�N����&$Yl#+�d~�`=��+���@�MCȥ�&t�l�|��
{�I<�r2#�J9Wt�c.��i�	~S����i���=!���s/�MC"����%d�MH/�M�ج����yz���C��!$�.ҧ�"=����z=�mA��}��h�i�YH;�O����
abi+-�mgZM����c�E�i�@d�f`�_Yo�I�$��`Fí��<x�p"5D ҋj�:%��!������0�|����q"5�\���O��\Ƀ\�ekx%.������i�1�~�4��Hk�M�s�����ϙ�M2�_l>^���"�4��Ev�)u%a�S[�F�p��a�>]Nb�"�4�ڛ���2���D�ŷTl�Zs�J�AkLvͣ�D���A�6�~�����6̂�d�}~�]�!�8����>i�^���$2	T���\�ULvͣ�D
�Is�d�3zJ�7��:� 4�E|u}�b�k5�\�)�����Z?Z��W�k豰�b�%]�y��H$����+j^+q6'3��\�9r�=���G��yآڙ��gG�e���<�1}��zIA䣆D���7zIeM�K���,���QO�z���)&��QC"�؋�f]��{ic������Bۋ��5�d�<j�@d[y���w�2؂�)��9'�
��D>j�@d]Z�/Vl��Yqل,�m��[z^Ǩ�]�!$q{m>h����#�a&֋����4wQ:&��QC�q�@��~z�O�%��s�Ԩ��N>�:1���G!WǙl�{!�փj��DLق���Uŕb�k5D ��X/���X��BM�g�k���b�k5D lʵ�l���^�nު{$k�$�s-V1�5�"�u�u����W*͜�L[³���l����G�lyqm�Uly6��ޠtz����~9xIA䣆D�NZ�98�/����$NZmrc[�?�	1�5�Bmnc�I�Zt��US4�˱�Xך�]��_ �Sr��`êz�ȋ�Ϥ���&��Z�����AHS�~��Ohx����RB�Oϒ��B�_��s�uf�Y���Ӯ}OXm�ޮ`��h�︌ˏܚ��P��%�\��w��4�>���ꩈs�O�|�x.�3$�N��Z�_��Grͷ�ã����bʽ��=I��iU����z=��5�?�D@�8@f��s�K�?�'�m3���\�e]���^����(��C��    ��`�f��;�aj+�~�/�^[`?�k�}EDp�e�����OR�M��uU���W�֫��G�l^�r�J�S�s��aa}ڭ/�9�Ц�p�QD'm�f#0$lˋ��F�5�=�mNg��uC��G�\}- [�O�-r�#y�W��4��h�)���""8�R��Gq����0H���ɸ�$�p�QD'���xB�,�w*����D|e�q�MD'[�Y�o{t�%��7(�Ii�a�e�tY9
�䛈Nv:������~-�/��R����7`���D-���""8�A�O�>�ή=
mj�*��ig�ym�N>����F\<��<���#��J�t����re�P��䣈N�G������\B��`��-��lSuq�.�N>����
%���C�n�^�������O��SB'�D���3[�,����h��z(�*J-W�B�Aq����ɿJ��8��(=��kkit=	IϚt셵��������Û�����|J��Of�B����|��(����[ew���QZ�������S�}=�K�_q�'���
�����{��&򪁾�4�c���Ey��{���M�7�\�'���G�QC�se�u7���N�S*Oڇm_k�'������QУ��ԗG6r�L�p��b�e��L�D�o�G����Gu��]�_���ع��#�6joZ/1
��X̢�f9��B�~Mv����Z{��l�:>j����=�+{g��fns�B�]����QC �C-�C����}���1R�c�J�]~�:>j�#Ү�T��g�s��{y�;Vγm�:����QC -�a�~+	�w���
kM��/�Ү�$!t|�@�VW_�1A��u�֏{'�K��ٙ뚅���QC �hm��6a��98	ԒNYҰ����� ���踱e-�,o�\{��eqZ0���ʵ�%!t|�@G�cY��d�g�$n�-��p�б�W�S�!t|�@G�jP(M�j|&��{��ޤʾ���QC � ��Y��[T^�� ���2�KA5���:�]Je/t=���ΩXh��/�� ����xd��tq(�F��;8�4V�"u��d5�1�%ŻW���x��Dc��{Ϋ�o�:>j�c�,[�������V��S�p6�u��LB�Gt�S�w���:�S3?t%�9��v��C5�qܻ����%dOD�i�jx̹m�KA5�1ϒm��T>��h
�|Jb�����T�gc5б�"�bvU��*���&hӄ�ɂ���6�㣆�}G��fTԞ��VM��&{#�
��/1��o"����+�j(�wj��`�r�m!�p�y+��o�h��rj���	��%���cS����QC ��S�j	�'�e[��ZL�r8o �z�6�㣆 :�kǳ�1�oЖ$��B�S�\G�uo��:>j�c����׽'︷���b�s��RB�G����G�{.H)��l�Ջ������NG0'g&^�}��+8��"���'	6��H�볾��Ik*3~[���F:��K.I���s�5W�z�(n�d�_)�߱����;�_������(0��բ�B^.�NB���*�����R���A��Ufi��*�ǔ�ƚez#�C_wq�'���G�Q|�(�֗��-���lD������6���WG��I���Qx�P�`+���}��[=�&�i�}��E�*��D����!�����Q���:}�sYV�Pdx�/��B���!��ǖ�a#M����U�9�f���� ����x�{��Rn@~�%�3Oid���P5�qYm���Z�"g�Rg[e�k��B���!���7��-zi^IGT��T�b2�d\}�띤:>j��)��e�)_�Ͳ&�g�����rEsB�G����]��������d��e�iͽ+bM��������o�p�q;�� �I��%��u���_H��Y_��9����&6�$�	1/�y+'�Kؓ袬�,�:n�O�̯���^��r�w�Jq~� �?
��f�k���fއ���<�M�{�>	3�>
����BT��d�Tly��)ixE>d��>�2�>
���Gs��g�W����5����j{�q��1
������m����)y!�A�$47�V�|�	}Re�}5б��.{�,��l����R�R�@�J��F�㣆 :j/�,o���0*�O�@d 6.�~=���踶7��xx^�S9���Iri���:>j���!K�8��w�r�w����9�,���:>j�cw,�7�cZd?���{�`;H�V�׎_�㣆 :nU8���O��Ii��m�3�bs�:�:>j�#�Q`؛XF�3�ip�|%эd���m�q5�q��i�i����-���J�od�NI9����8{����d�^��ﭾ�5� ���{�:>j�c�If������$uP2�6��d:.��!t|�@G[�[���C�L3�c�H�����x5GjB�Gt���|�O��I̸�1���q�a�RB�Gt����^����.'Y WR+g��]�UB���!���\?��,/@�H|6ڢe���a^ ����QC ���^�j��X@̻�Qf�x�|�UkB�Gt�}N�w2�}xmm�����^�&
W�nU�C�7�1F���۳��򚋼��5��.�KA�w|�@G2Fl(�&<NGv:b~-�=�/!t|�@�Z���BQ����p��~��زu��:>j�#*t��N�Z����$-�>��ƽ��s5���u3�ŭ%��1�UV�	O��TW���;���QC mu� �St�V�cQ<Mf��:���!����Xy���oMds����'.44׃|���B���!b�Q��Wo�-��9̽�:�qMs4�R����!�T�[��������3	/%k)𘗂�S�7�Q�OǞJ��V��稜��3_��c�㛆 :N�r@���U�P�i��g���ϧ3�O!t|�@G��;H���B��B�ӊn��-����QC �>XJ���;`�{��c�p�KA5D���E�6�8�ͷ�E��-���4K��RC�7t\[��^���i
��=��NuC�C���%���"�m����͛�n�f6�e�My��L%f��MCs3��s��]��).�`�1r�WM�^b���!�������QS���lJ��E�:���P�r�%���"NeR_Pͱ���R���J��,ʸ�C̛̩� :r'{�ե(�@�i��kԞ�������QC �!qo���p�%�\�^,l�>C�<|�㣆 :r�4���NM��X�V���\�z'k5D��=�S�`�T�g�i�ж�։'�z���:�i����?��4�?�Uͽ�,�2@���Wl_cn��i��(��6�����^CkǴZm;��~�_
(����Hy"�b?ܻ�����{�+�.���VB�Gt�9a5��ٌj��H=���e�AԹ�
B���!�����ip���Z= 	�E22����������3�7t�B���*e�W?���֌��Q5��柷1鉶gk�3B�KX=s#�}"�+�!��{�6�4'����JMCh�؇�r�����<j���S������YX��-��1sn�8���:>j�ȕ!��Gͬ.��H�^$�*O;z�]�\�7t\�W-�N�U̱T�i�b��`�`�8�E��\�Gt�bV?:���
{{�ᩭyP�9����ɕy�@�q��OZ���5�(6/�T=�@/W���+�!b߱�l�\���ϋ�}aj�b6Yy#^�{L�̣������A���&9۳�s��R�v8bre5б��)R��E02ٯi֞l7Bm[��~'C���!b�t������llg&���e	�z'cre5D��4R9�t����
�4�Xș���Xbre5D�;R��V7��F0(�x���g(��Wg��+�!���4�}s:�D��SM�m��ԔO��o�ɕy�@G"��{������,�dc�П#��\�Gt��yj��{�z	f]j�.e�q��WE��+�!��~Ra�    �H���H����tl:N^�&SL�̣� :��'��#[l_z��6�,l�oU�k�/&W�QC {i�X(����6gNB�͞6��7m�:#�ɕy�AG�e2���R��L+@�Q������<j����ͪM����)h�X�3͓���'���/���<j���y�aN�;}��c��^��e����.!t|�@�l��ҽج��&~w@9���C�:�RB�G�*�@M�z'�9q��(#��|u��\�Gt̵n[� eX~��YwH�m�>g=�~'C���!⾣7�޳��<̾{��-yT�e�����1�2�蘧�߯m/�}��7�l���Z���}+�㣆 :��5Z���ω�l����n�ʕn!t|�qf�[��JB?.�*=IUM�`Ҷ W�n��+�!����a+�o{����d<-�:ul�2����1�2�"j� �5̳�L9�9l�Bl<��<��W}�ɕy�q��f��='�&���yԚ̼�i���{��ɕy�A�>���S�=���fղ����FѾzrL�̣� :�3�a��Sܳ��V)��!��-;_�dL�̣��3�Q�4�g�w,� �{9��Y�ĜY�i���s���5��`���&Q�i-�z�a�}E21�2�"n���m��}��'�{`��t�������1�2�"j�h�Y�9�\�u�ʳ�Y�7G�V麏�1�2�""kmx���p�[el��E Z����`pL�̣���
I�7�l�áю}�zx�u�:�\�G��X��J��RU��4D0�Z�owy��� &W�Qÿ�#������aP���]V�?�`ԅ��g�v���2d?���&��f����?���.���w��� ���aK�Y�7�J�����&d#Sd��.�Z�/��9��Q�EA�J����@� J�K_�ƿ_(�cRn�d5����R�"�MB��Am�{��*�_�N��J����Ų��Y\9`%��²�H~ܷU^���dA-��ftW���(f)r�>i���KM��Y>es.2�����&! �� �%�Bz����.�������1D��QB a�zP��珡z[#�Z(����u^N�"��(! �}�|ʘi�2Ӛ�O�:��e�6�R�G	`��h�5���J�OD���As�d�����G	`��|��������kIz�a���+��[%��yp�`tt�Acve �Yr�N�\Y�"��(! �K6�JIX�,�!^���ee�צF� 㣄 0�(��ǝZF�c�IC�\-ҟ�\
"��(! �d�ը��螼x��Y@��d��x����#��(! ��ʻC:�^���]�i����ӏ�/`|� F���\+��I��k~��'U`���=���h��\�B������ٓ��Nc4�}��#��(!�1��4�޾��|�ۻ&s�6KqM�7{{�c|� FO��B~�換���:}���Q�`|� F��7�M��Sie{+D�}��#Y��q,G��QB m1f��-���^ͩ�f�e:Sו���G	`��H�T�_$7��Im��;4��.4s%���45*��k�`2��d4�>f��X� 㣄ǘ��4��[�Ɖ��Oa�K��8�7	`�fVexg��|�9I[�e� �J�G	`�:a[0_�C�f
�w<�pmv�r���G	`�{)�t��G`��s��O�� T׶�D��QB ��O[����V���B�ё�y�s��E"��(! �3�@?&X��3͸iIϬ�B����&9������Y$�l6��i0�DS�A���/`|� �E�����4��3{�l�2j�����+9���HZYl��ɗMf_���L��.�~�{��S���7	`��X���������� �����`���ѓ�G	`\ۆ[����V��wJ��v�r��
���MB ��A�f���U��q�Mϖݹ��W.���	8wx� ���)ްg#��C�v��E{-	��0_
"��(! �e�����~.���"��O9h�ӕu �G	`�=� O���e!�w��5hϹq�{.F��QB E:�g?y{v�-R6��~�v���1`%D�1R'���>�i:���w]{n{7\
B��$���#~�r�n����Zj�>l"Vmx�(� 㣄�8�
�w9��C��=vʻ�QZ��$����&!�TZ�P�
��S�8v`���ςhZs)9�~� �}�Z��G���g3�s�r樻��1�0>J cmqHNZ3�J����f���*��_��0>J���Xs�ˢc�Jl�ܘ����F�+�@J�=�7	{�b��}I�l��%^pZ����k�.!{�o�腂Qʱi�e����
�����;x.`|���E������5i����!�en1ݾ����$�q�ҳ����L�^M�`�뤝���r5��G	�>硔�x,[�L�����`{��� �1�I�8�*k�!�E�ף�E3uW���\-�$$��QBD�˶O��(Mv�
��?��0J�ś]
B2_�$D�J��<-z���pj��n�JZ���j]%!�/���/�f)��QUh6mVOXF�V��fm����wh�䕞x����H�k���1(>B_��9��o[��`ay�2;�+�i`��۵��i�?
>�@��
��|�OY�_5�����Ǜq��/UB�Wo'a�cOA!_
Z�(<j��?
P%�mN��')����q���q��k˧9̷�£��QX;��S���_[Iҡ��p���������G�Q|�(�R�E��n[�Vﾻ�����m���;�i����!��U�j��e�7�&��f�-�+}�K���B�GtlP:N�Xv|.�5��j�̶VͲ_�����QC �3�uJ[��aSӤ�J*k`��u\�'�B���!��Gy��5Y�����[����g�ʧ^���C���!���)NZ5Q�©{����n��»s5��B�Gt�2u���o�i6-�7�+����k�����QC a.Xm��$��ֆ$�8�ܣW���Ӱ맂:>j��rN��z�4�(^���)匑�z�:>j�����9	h{�P���+f�b����*��㛆 :��u�df��{��X��{���ZX��s�:>j��8ʠ���O��|F[��0�Y��n)���QC ���C�f[�m6⢤��v5Ϣ���˱p5бڒ�y��/�L�ix'�Y��^vf�N�8����(e3�2R_��w�`�"��V���J&!t|�@����*z<{��s /�g(������ �������;��i����l�ڼ������z@$���"�g)u���t>��I�^�0.P��vܳ1f��MC y�nsϴ���)y}�R��q�{a9W<'!t|�@�Zh��	��m�q�W����S�O�b&&����Hmρ='o��uv��#��Yg>J_�� ����hv��F��4����-O$���rp5f1!t|�@ǵZ�Em��(���^P�=�)�.�~+�㣆 :�E�JB�«�4��խZs��RB�Gt�Ӵ[��~�dޅ��*ә�Z���y�B�Gt��l��9=�yO���C����RB�Gt,�Z�OMq���lJm^��^eQ�_-OMA5б�,���xA,�k���I�7���Ut����QCĩ���Z��g��_�@Q����dV��˱@̛̩� :�WT�}C��:�U�&�ӹ�w��I�㣆�8Z���/O�����j�g���`u)��o蘧r)���U�I#���=�}�k��:>j��wJ��&)�Sܽz��~��w1N�KA̾㛆 :���KJ/�Y�ibs�f`F��شZ����QC[��"�Ei��*e�E�p(����֚�s(1t|�@��ᖅ.b6U�浥��eA=�O�sE2%���"Ne̻{euO�$o|���~/]��g���C̛̩� :�M����co�d��֦t���vq��!����h�|���ⱽ �*%faۘ`��"S	�㣆�3k�]��Զ|�awC3j�b�T������ƜY�i���K�o������O$)���l�2��9Ԙ��M    C ��*i�V�tm~"b�l�,�"�띬!t|���,����0-���#��w���R��4DxG����j���X	���\��|�s5�;�i��g��^+��Q�ӓf[��Z|�{��W$C!t|�@GE�G�H���e�s⩐Zl+%{�KA5DбgƵ�-K�{&g6߆�KYj�u\
b���!��sk�aν���f�o�V���>�sB�SA5Dx�ٵ���z�Z���X-�+^;�1�2�"�c�z�Gjݫ��a���@}��N>�nWL�̣� :�9��g�N5j��n�o�i��=�v=��\�Gt\�Y�����b���j����rE�1�2��x3mi�M?5��|[k`���i�Bz+�㣆E�L6�˒W�b�a����< ��Y�j/le��W���cn���dy��ac�����z��s@�	_��9���[o�8�+��W��r�$�%�k���)���������5�7n���Gai�ZNM(�]�4���x�#�ҥ #F�QC��Q�E�.E��lj�^K�Ѽ�bӯ淦�F�£��Q�^���Sa�~�d&[�lJ�uX7�ޮ�G��w�£���>��~~.��!sm^�
w1	�K�#S�۹�!���8W蜨xs�R5��)&s�R�!t|�@G���4���H����f`����Gc����!t|�@Ǿ��+u/�T'w�~���1ǂs��p5�ь��g,���v��u5�OѱtY�?�㣆 :�'U�>�Po}j���X6G�r��8�������PD�q�q*qQI���w.|�H5�q�k�EB��I�B�0yt{�f߾�I	�㣆 :ʮ�V>I�o�lfE�I�r�#�Kݗo�:>j�c�s+�J@���:n�J!�_+8t9	�㣆 :B�[U0Rk^sx�e���l�;[P+����:>j��Mĳ��&X���{���l��i��w���2�!t|�@�Ç��9���p�/B7��[��lr5DD���~�S9�x�����X}�x�KALd��!����$�NV����$�,ԟЖ�S�ץ ����=�c�w��#�KR�~������T�:>j�c���ǜ���5�<�}{`�ͬ�
5�/�B�Gt��+��U��Ъw���d�2d�-_
B���!�;�Y�����6�8h/&��29��JA�w|�@�:��--�:rؼ��u���]��#^
B���!�����)�2�@���'Ң�H�ǥ ���"Ne�0{�
}��0�9@�	�Z���f��d cNe�4DБm�yY���+Q��TI�e��܄�RC�7t�@L�Y�kԗ5}���b���O��O!t|�q*S����:�s��fn�)>��V�ϼn� Ɯʼi�#eݍ����wiJ���d'�U�Ȅ!t|�YC�l��WDLJ�,l�Ny2�E�Y�i��b5�5���g���#S=�6�J��:>j�cfo��L�����I�h�p�>&�rE2%�����xz7��V���T[Мʆ�4��W=jSB�G�Q���f�>7}���7[�I��z1��MC 7�nFR�óT�1FIãZQ��/5����(�go[�����-�%��).y�ܻ]5���""k�T�=cs,���(��bN��J�����MC aM{#a��j�T��P���v�9��^k5�q26�����e�F&/�`�ܲ%J3����㣆 :�A���F����O��5I�ƥMW>'P5�qT�5�fڅ?9�Ǣڼͽb���d�<<���QC z�!���y[�Dʟ��e^Q�B���!b���9��s�o�)ݣښ�oאY��R̾㛆�=��lU�J�ׅ��z�Q{�I�ʸ�}����!��:�/�5�~'ڟ�������+&})h!t|�@G�j$�7��g���Fܒ&�}�>�ն:>j�8��3�Ju��R���8�����.��3�7t�i��������ch͓ٴZ(G|e�C�㣆 :Vir����i�� �lrB7:/ʕ/��B���!����,S�8�o�ʜ��a����|���bre5D��٫�I�ӽ���S'G{a�H|�ubre5D�;�ٰ��j��-�k�ִ��f�6�^�1&W�QC �Z��e?����f#SGN��`��½��+�!"WƜ����2�:�N���hq���=/�+�!�̚N�?��4�g׿k1� $��� ��/�J'�+�.W}����aWf���� ���=;����$/�dL2B��+�*&W�QC[]Վ�t��x�dV�wn�#���<(W�MC �9�/[*����!$=AA�yn���n�ɕy�a;�x#�C;`x-4���e���������+�!�vd�������5��M�F�����[A����!���70��W��R���̗M{��:g�˫�ɕy�@��̎7 ��_�u���a�y��:N�ɕy�AG��%��7�8A;���\�ٵw�aL�̣� :n�ˤ �	�=���ɺ�z�h�)�^bre5DD�L��hS�(��ݧY=��6O���u��+�!³��P1m�n�YK)�*���̕�j�Ԙ\�G�#�}���/��"�͟�����:X��KA����!��g���2훫���춹�!�Z��H�ɕy�@���cڬ��������fG��μ���Q�/�1ˏ����4{���㝤�{ԺS^���j]c���+������o哄��%�W)�L]�'c�?���?Ǡ����hvR7_��=ci�93�����,|e��D�8����z���x�P~�(�%�Q�i���,�1�X䲆Q�5�׎�ʔ�ݣ�~�(d?�K_�#�S�_l��Q�Z��R�� #F�Q��Q�5���4��{ۜ2՜��y�����ʔ�ݣ��1h������BzEA��&�c��R�!;�MC �m�53P̒W-ni�����;��j��B�GtԌ�h�;ܼ�b��i'uK������r�����QC K��oNP=��o��*�i���f�bok�㣆 :�5�J��]s�����j�K�(2��KA5�qԺQ�<ӫQ��n^b2�e,��)UC���!���j_D-�/O�<�c�T��`ei�1vB���!����A�N�f��)E�'=�u5�R����� ���"l�!�l��v���>̛[e�6��n�|�:"V���4Б[)mpNS�n;���̻[�,0�����QC Ia�'v�9��ըM>�c;����� ���"lG�:k�&w5���-N��6�+��b����!��S�Dn��l���ImR��%7s�W���!t|�@G�C�fO��͜��6�z���-'�y+�㣆 :Ήer6*��z{����X�)6Acݫ1������6�d3���{x���p�Jt�\�+���QC 6oK���{s>�c2<Ye�Fz�B���!��w?v �I^:��8lsr�UZ9��J!t|�@�Q�U|����j6O&{Xv�k�MF�kOR5�qc��9����N)4�^ͮ�6��Uq�R5�KevcżW;�
؇3��'�@��RB�Gt�����,{'�g���}T����n!t|�@�#���>Rnf����͔h�3�4f�桅��QC�g]�����:<���4
h������)�b<�7�u5��%^G���ua$����ǁ�1���� :nm��Qe���*�n���u�<ͼ�KA5�1gŅ���Y	'Ab���3��=���B�Gt,M�<�I�G �cv[���T����+�����QC �޸U������G�^ͩ;f�Q������!t|�AGu.��Hϴ��� ��1&U%*z��C�7��xe��	>�1q}l��4n6ͫ�n�1�㛆 :��cpm�������UGI��]yޕC���!��]WV��	�GP��]G�4�wp����SA5�qc��N��W�Z��9��Z�S�]#�r5Б$k�3�^Q�W� ��ð���_9���"ެW�y��{�9j���ä�����W� ǼY�i�#֕��F�w!M������ܹ|�F	�㣆 :f28�35�D�;��    �ǔ��n�:>j�#V��sM���+�N���0��z+�㣆 :�nR<�(��=ɬW��,��O�F�\v����QCD�㴏1?6A�^�}פ��L���}�"���;�i���4�<f:JͽZ�o�Lzh�s�U=�{5B���q�pV�P�����6��G7�~��<�\
b��4б���w\��'��Ih�&/bp"�t+�㣆 :�-g�ǜ���;7�7Ƥ�7�e�USr5бbi��\�S�{0��s�Ek�:vE�.!t|��*��z�3S�yxLC�n[��d��m�AL�̣�:���L�ԏ{�"���-�p�:�z�z/��\�G�5� ۉ�egv�Yp�3���^o�+�����?
�ǂ6�d��v=�u�[���,����_�G����'	6��%��\����=��c��sۿ�w>��qD�8�h+͹U�9�puӆ�L��(���Y��@�� xDk!�On���Z�T���Wߕ�׵%�Re~�0<�(���_ۄ`
f�Z {��D��_
j�0<���?\����y�7��^6+��)!��uX%���axA�a5�c�k5�{I�`����^��\�F�+[����7��Ve s�=��Q�0<��m-cS�����G�,���C���Z�iQ�%�5u����� ��G�,�����eN3[���;�&�?�	*���1�|�ȳ�@E���cò�L�dW�<��b��*�A䣈 D
�ŸW*���9zPM?�;�.�{���1��"ɥ6���VۛỲ󻿙y�r�*�1�|�k�4{��q��%mB�՛)�*L�i�9���L���G �!���7@��4�����ׯ���.��OZ�脹��(�<��J+�G���\e��+i�'��?K�?@~^������A��s��F数����ާ5�:Ŭ�}�{}e���ax�@�p�Q�u[���Ğ����t
�v��r��f~�0<j����ar����lI��߿�~��鸲��+o�wã�`����8����ũ��%A>vbJ��+q淳�MC"�s��E���3YKgЮI!�|���\��3�G����.˦�{ �����0�B��!�Ju�đ��n?l���g��G޽LjxKA䣆D�%�z��!~ȟ��t̎o��(��"i�KG����G���4.iU�m��sZ"5�"K7c���A�+;�t{��O�Psq��m����G���_"�y���>��&�H���A0g$��w	5����W�����@���i���-x�Q�',���<����?+(��W�R��ܓG��Gaι�"I*^0���%�$MD�ir�ɹc��G���g��T|�:�b��MKM����jz)��Qx� ���\���^������-Y���=��^�5_�3�{5��!�ܺ̉�o:�ɶ.�Js��	2O�.|��g~��x�@�}͜Kʦ�ˎ��4�T�]a�˹�!t|�@G�]K==���o��#f����6��v��p�!t|�@�B8z5�>���y�6��x�l��w=����xF�����>�F2�=J;kB���:>j�#���)�hK�P;�J��O𠓚�S�C���!���O��c?�l@����HOi �+]v���QC ��~�ʋ<��k�6[�^X�OT9p�I�㣆 :���XO�̇�A6��$<Nf/�|)�㣆 :�Zl�a%o%kgu=���o��E��e�I5бL�3���Ws�W2R#�Ǿ|5[	�㣆 :iF:�˕��A}��稇�)�VB�Gt�5K��z�Rf�$��6�:�b]����MC ���V;i6>��!��6��@��z�:>j����x��R�x��4��4tr6>��o>c�㣆 :�3�C��᭥M�-Ǵك�x��� ����K�Ŏ*�����1���{3�2�=!t|�@�-T�/��i}f�'3�W����V����QC ��;�5?�S���{;,�x�&˾���QC ��|5N[|�۟��(�Z��*�r���:>j��̳
�}��j��4^�Nf�К{#ѵ'K5Б�n�k&��Uy��$���ؼJ5�m�
B���!��j��Wȑm
�oI�]D�}z��Z>M��TB�Gt�E���ѐ���v�s�=m��+L�������QC ;�Z��h�^rr��I�Ӭ׾�l:�D��WA�㣆 :���R2 �O��վ�F�fo�M��s�㣆 :Ba�xT��̕õ҂	���v�Vc�㣆 :�f��!��r�ڥQISfƚ�ʥ ����XQW��ȻzI[�s)��2gμZ���b�㣆 :��n��|6�ś���ml[t�i3��e�C5D���J��(��g�(iR/����<@̛̫��7�n�z���Uoت��b��h�#e�\
bެ�4D�;V�<mO�	���� ��^���}�+�!���MC �,>�02h���83~���1G/��KA5�1����-�M�9������� �_����QC q��.���ڢ?5c֜{5-ϥ �����%�8���Pj���I�H����Q6�uJa5�9s�]�W�{��Gʝ��ǫ|)�㣆:Bɋ��{Մ�UX���?�O�1ֽc���!��f�B)�����x^�}�j�lC;����S�:>j��0۽�h����R{�����e�}VS5�q��{J�2j'�6��{G�<��ƬE��J!t|�a;3�c^g�A�)��~�K-f�sUC���4DD����Ж��C����,�O���R��!��j���m^x�P��;�H��,ܠ�\�]-��o"�X��v�i��� O� <i�P��ODן
b���!�ͺ�)��'R͟œ[���o�w{+}_w~1�2�"��Юɻ���2�d�� v)K��"�+�!�v<��H�y��1�V��FU]���˫�ɕy��Ys�p�V�V	�To����E��4Y|�m1�2�"�?y�Z��PM�T�W�l �;v &W�QCĽ���a{��lv[�t����\d>���e��ʼi�Ϫf���m1	����ށ�\e�1&W�QC ��,�0�?�}��H���P���sL�̣���-<�e���B&�g�J�1�ʢ�cre5�1��f>�̡T�j�H���ɲt��*haL�̣��h��g��D�<Hh&J�����,׮̗o�+�!����_��,s�����;){7m��r+�㣆 :����v�ϟTwI`&h��p��1�2�~���~`��3B�|;�'����<�.�FU�jo��#��ReJ�Q��O�b�������Z�ׯ"�cM�B��C M�ǚ6�yN9`����B(���ԟ*����_�Ơ�!�*~� ���z��:zH��.-^�W�#�G	��i�����L��ǫ��V;��p��H�X	o������X�p�X�(Sk��BM.WN8`%���]O����"M�ә���Ӭ����=˷C9£� 0�Y$&ظ󧗅A���+$�t�R�G	`���MzK��̶��E�bnL;g��'{�O`|� �U�u�M�����Ԟ�i��g��k1���x�L�%s׆�ن�I�{+����r��G	`4�cL��2{P�)��!Woᰱ�����L%���8O�d���[�{d/��|��rOC� 㣄 0��X4��/��4��ߢw^o��
"��(! �z���3��r���R�\K�z�R� 㣄 0.<R�QZ�=F�[��S�`��B��0>J 㩍쌲��n�V���ˆ�@���R�T#��(! ���-�%�敇���X)�M�ש��� ��"\i2$m�Y��,��qT�f�gm\��Ѕj�+�&! �c��mH�͵�'=� �M�>+� 㣄 0�{������:��(����2�"�{-F��QB )��C%���IZn��e|F����>D�G	`�C��q�l���>�~A����>�4@%���f������m����v�t9��G	`�5�����O�Z�&��CsB�yQ	"��(! ���'�L�    ���G/5kZ�0V�+�e"��(! �cz�\wa��_��̵ٽ�8��ܥ]�:�G	`���gK���o�e�,ΌCF��1�o�Ȭ�vin����g��L�^WC3T��D��QB �I�~��tzJ� '6I���Z3�ˏ�0>J �@���' �����K=y4��KA%��@C�z���%�s'o�`?P�����J�G	`�}F�nZݯu�H�����{���� 㣄 0��V��\<۷&i�dN>42��\
"��(! ��J3���$�F�I���z�� 9�Z� 㣄 0��˧M�Q�^������47]��s��!� 㣄Wz�e�){z NJ{�e���f��^k����o�8 �\x��h6�ݼZL[�˞a\�J� 㣄 0:�O�TМ��[�w��i����rEH�}��$�Qv�icn�7q�˨T폴j/%����"��(!�%g.��76 �H�uu=��`�ү�4j!`|�a1i-f������1G��l�|8s�;P��$D<��Nk���G����S����[�2��?=���MB[mg���݄�F�.���Tz�$DX��ֽm86��o~�-Õ�\ga*�z�!㛄�;F����V`S�^�i�Dp�m�tκ��C��$�q�!��ݖv���I\-��+/�l����7	w�9�FIU��vHc��e�lڭM�s��1�I�x�Flx��aJ�%�xϙ��3��E�/4sȫ����W��J]^>mC������h�6G�Kp ��J�I� ��i��s��؆� �q(����'�q)㛄 0f$Z�`���i����ր��s�mI%���T$4*��@�ύ{K�`䣍J�����(! �X �)�l�ZL�7O/f��6�>_�tH�ˣ� 0za���0�F���q�
�g�ʺ��B2_%��q��^R��lV�Y��ˬ��EG�^�1`|��He�~���j�$=��H�xH˷��B2_%D��yX�x��ؼ�͊�0�n��b�|y���2���IǶe2��w���8�=2\}(ZH�ˣ��Wi�=U�>�|l֖���&@9f��KAȫ�����^���m+���m?�HY��y����b2_�$�Qxto�뙙��g�R3se5'4�Y���C�|y���"uK۾��Ԛ3W����!:t��J1�/o"�X7e��><GW<����e;���u>�d�<J #����N�K�C�z�u[����b�Z,��0>Jɕ.CZwj
�g�J;�)j�,>���\�'	��=쯶q��_u�4��(�=�͹��7-&��MB �ۍ�->�Ko�Q��E��Gi[�z��*z�B2_%Dx�lv�VGۇI|W�R2�2��q)	�~� F�r�����d����,�{�KA%Dd�T�d�oR�ga����S뜿�h1�/o"_j\y�:�'Lϸ��³&�9��|-$��QB �vہ�\�d���=�x�<V�D��QB �-m������6ʞ?�q�:���*� 㣄�"��.�T��iy'&sf�my�%]
B�H�I��[>5�f����6��Ǐ�!ϖ[AH�����p�����|6:6�jؘ���cm˼/�B2_%DX�K���n[�h6����i�8���VH�ˣ����w��uml�Vb�hqu�Pp��p�|y���'�	b��b�f����Z2NxmȐ̗G	`�͞Ta3ཎ�f�n��M�u;���KA%��JJ6#�����=hljR9sѣ�[ΐ̗G	`�#w��-�t?�����z�!�/�"R��*S)yhPB^l��g\�����KAHJ����p��&�,�vh�}�Y*+c�G�L���F#$��QB ��!�b�جK�R�IJ�̷���o`|� F�&[���6���ww%�|���+ļ�d�<J�(T[o�'u����f��=�ʌ�̚��!���(!�T`���:B�]K&��Yr�L�[A�$DX�җB^�|bj�lIs��g��Ja���B2_%�
���=$����0 y�A��1�n��G���_�b����CW�?U��g�����L��4C�fn��Gu���K���� ����@���� �y�n7��UC���P4��	���jӢ�5x׉m�7/��׈Qx� ��ޙ���ވ�43܁S.��R�'~+��Qx�@���s��9�ëM��2��̵�L�^�-b5�QX-�G�������SP@�����M�2
o�X��q��ɟ�@��{o>��d8�/1CB�Gt���X �ݚ?���d�>T�b���8��o�u��F�Mn�c��J��M���7 �㣆 :f>� ?qB���(�DNU�<�lZm׭7���QCy�&���̶�����K��b���9��o"�z�����^�a;����h���ZJ��w$��o����[��͋���ю�z�� _�,����QC` [����{x"Z�2�<��u�!1t|�@G���0ͦ1b�L�#ui]xG�H5Б63�RҚd^� H2�0���\����~+�㣆 :n;��K��yМ����^̢�\%_o�B�Gt�U:d�Vמ����+q[�+���KA5Б������[xL�@1�jsR�RB�Gt��af��Z��S�HbGrj8�ا�\�xz�㣆 :��5B�3����7�iC�Z�x�KA5�1o�̕`��u���=Y밅�E�wu�^B���!��ch)�ط�}8�\�ݤuA���U��:>j����ԕkj�<�ͫeN��׼�x�k5�:>j�#��>y��0�9���8*�� Ϟ�y�㓆 :� s_�\��9�÷�ɱ*�^ΩW��^B���!���P�����U�������P���k5�:>j���v�8ios����^�nŜ�<���\c���!����O���́�Ո��Pk:�#V��V��d�㣆 :��Z��t����Y�0�=�,Y�	μ�d�㣆 :6;�(��F^Oyk�m��֑�xM���:>j��M�RSk��H�$E;�4�Ui+0]��x�o���_�͟��y)��N)۝�]���\�B���!��]�g#�5�)��1-5�}/i�0.1t|�a;ұ�jp���vJyq�j~�ջ恕.1�㛆 :����͖���P�j��d�<!�uVC5�q����b�$Eg��
���s%�v�㣆�7�!Mf�I���ij��s��i��U�z�1���MC ��f�A�f�D-� t��_�Ui�^��̔���4�Q$ws��P�f��|㯅�������]
B���!��{6cr��,f�eL��xu����ʽC���!��8;go�P�2OF�˞��Lg;�=<�[���QC�g���F�⹋�n�մ��4d"��b���Mï����k��!��4��7��cSH՟�m��+�W���ʿ^5=I��f��M�d�� ��k�b�p}��A(�A.Jv&y*{78!�J���ڼ��+�re�t��*������z��ͪ�j���m�l�K�˼9�n9���A ���|)��Qx� ���%J��l\r۵�O%I3��<�E���c�~�(<j(�ņ�:�'�y�����lgK�y�uEv������~�(ضkm���g�����mLy���y�~)��Qx�@�.ٳ��?���ҏW�5~�2ɽC���!��cֳ���=�^HC��Ե3�w�^�!t|�@G�f3�:ɛ�&�ފ�����̭���C���!��^W\��i����|Z��)��k�-{���:>j�#��6�}��zV;�'g�3�cF�_v)�㣆 :�\�f���<��$�fˢ��KF���ۦ���4D؎�4,�����bۓG�H�w�@���4�q��m5M�Sj�_�bތ0�n�˕��9�����bo˓jo�V��<`�t����g����C���!����������$ݩ��J�^Ԙۣ����QC W-�AE6�k��ז����uO���!t|�@G9PzO��Y����3�>�g�lx�㣆�zf��,i���؞�ff�-<�<�"�T 1���� :j    %���?�yl�$E\)�je���n!t|�@G�bV�����B͒�L�$�0�L��uJI5�q�j�����z��b���fҋB�Ǧ��$�����8���4D7>�>{��˅IE�
)v	�㣆 :�>��W��i;'=��ٜ�!g��-�!t|�@�҇-H�(�սZ0��M��ᗦ������QC f/�0���d����L�u��+~v��
B���!��q�:�-��E�W�[m��ūn�[���;�i��->��|��N)[���E��ʥ Ƴ~�@Gٻ�%������ e�DG�X���*(!t|�q�(�/���G��z疲,!3�&\6<��{�7tl�W�L��=�U�hu���hx�� �������K#�]<r �j̫���o��K5�qn�&���my� �i�z��Ytt+�㣆�W�ަ"���co�b٨�\ ��We~�1�2o�,-�N��O�;i�z��'=fӝKA5D�ʌ�\$[}���g�u6?&���W�ļʼi���a3�
�7�o��/���?�9�ƥ���kLDϛ�����N'�^��j�)����8��3�:�R��!�U:�<9{m��@�e%�.�b���-�MM��!��Վ��͟��Y�Ћl�m̹�i�c{\^-���QC �l��^���`{=yKh��Rץ ���"lG��E���>��N���iЇ��qbl�7t�ufq7v�ۮ�m
�v�k	�~�E&�㣆 :�]��e�L�V���p]����v��[���QCī�Y=�T���,FOJ0n�!����Ʉ1�2o"ެ�<�9-��ӽZL��s�;_
bެ�4�q��*�Wbo_��jZm�ұ��/�C���!³�,��yj�Z���W٤$%/�e��KA�g��!�����<l����W>���T���/>S5Dx�e�;{��9���ՎR4Ac�2��]7��Y�i�x�ٓN�������X�ј�/��b^e�4DD�P�S��O+�c��m�<Og�s�9&W�QC ���&�k�)eLN#ONů���9�{5���QC �s���_{LQ�ILG�6�!J3��LF�ɕy�@Ǳ����>����<�y�Q��1��^��+�!���V�ds�l��Q;�ɶ�""�غ��ɕy��Y��>(�}8ao-���+��6�̷���MC �n˰�SC#�!��I� �S�z+�㣆�W��v;iB�4!�i��̉�WF'�ʼi��$����F3\�9��^~�#��hڥ &��MC �׺z��7��D<���+b�q���\�G�2g g�fT����_r�~W� z�_�\L�̣� :��pk�ت�)�+�6��:��^,�"SL�̣� :2�M�0e�ܱ�i�@��y�`���t���\�Gt�-���==A���Fm=�"���ơ��/&W�QC �n8�Z*�5��$e��
nl`���<���QC /7Z�v��l���� V����ߥ ���"lGj5�i������O�Y���- &W�QCD��Ё�{2��N�n���H�u]�8&W�QC ɀԼ��L�e,m5�&3j�a��u��+�!�ͺ�W���a��͙xOIMp壛��XØ\�G���,�v����+�W+xM�a>~�61מ�ɕy�@Ǯ��[�>M3͉Q/7��ѷ�'C���!�����d�DE��qR��;o6:ϑ��b�ɕy��C�a_3���F�+��y;�2��m��/1=o"l������<����P^'�l����|E\JL�̣��{Gsj������%9�i�.���>�uVKL�̣��=�����nq�e�<p[+e�4���ճ@bre5�q�ۚ�v�y�{����W��x^}s%&W�QC�g=� g&,%:�Gߚ��Pۙ��� Ƴ~�@G>cth-��� ��9����;֎���*1KL�̣��L�f{ώd3�>Od�QMyu��Z�o/1�2�"�qk�_�c�;��S|��,$~~)��w|��g]��uN��o>��W̺S#,v^�W�����<j��wd��́�"�����&̝��$�K^
b��4D�ʜ]O��&�#�YNR�#-���	� &W�MC ��6��ܹ��n���mzڱ�
�� ����e�½�U�N�r�i��:6�y)^�TL�̣� :z��n��X��M8^���>{��dL�̣��Zl���)�X��"9�+��(_
b<�7t,�2�4��(f���XƆQ�yum�� ���"�훳K�K�n˒bG7Af�s_�]�+�!����a�*A}y��ս��9�"�[�u�L1�2�"*��<�{K@^������f��;�IL�̣�_�#�(��ψy0�U�4��2��6�Y���5������_L�����x�`����7	�3��*o���1(�:�,W��7\Ǜ����+O���4��%�}�?�����`[���G0����p&5#~��D�%��Z�6_�\ǔ'��ã�0�ֆ�ãR����$�$�=�i�`�$p�8<���q��F��FR/��z�%�k��k�6�ԫ��x�L�8<�(� e�Oc$3�wH��L:���Wsqqw?`EDpҽ��y1�j��l���isvK���b8�("��}*�^m����C�φ�՛�e��6^(���""8َt�P��_}M�$��ocS�lE��|�N>���d]4e����/��|<;�C�x]�N>���d�f�����Kr�4�ަH:�N��uI��䣈NbѾ�FZ�%А���zR��F�* -���""8Y̢��Ӛ�o�����6'e��­ ��-���""8��.[�'Q�����tj*�|�E�k�\b8�("��8�کݼ�z�#�b~V�'f�����p�QD'���w��}�~7�lft�Mz�8=���""8Y͵��L�9�7L\f�w�]\{��I�����G��e�=؎��~1ꇗ�Je8{��Wq1�1�|�Ƀ[��w�OiZ��Jm��ݩ�.����G�S1�){,�5j"��"���c8�("��S���履��ů�7J�,<�����1�|��B��D3u�n�%�=!|���|�~��䣈N
,c��f&���D�ҡ:���y? q'EDp�b������j{��_�B��A{��
��p�QD'���������3��t�a���r��$���""8ى�,s�xZ�YJi��W�jkվ|]�H'EDpr�"/ܞ6zQw��5��L�*ѼMZ��䣈{R�V^F��%�j'�����3/TK�=�$"����y�D~���P]f�c-3K����p�QD'{/�a��S�d7Cu�)(Y����
�c8�("��*�Y=���x#Ց4�?<������%!���"B����b���>�+Hxg��-�~I��D��O(S��pMC��cVL��mԽ�.	A��o""8���T�lXj_�Ƒ���=�/	1�|�K�D�A�/�$̓kZ�M�6KR��k���f�`�?��_�$����0�i�P���|��t��T��}��Q��n*�7��d���̶ =��6���-��,�$t������m���%&�«�<&�ǥyv�ͧÛ��E�M��U.	1�(`z��f���so�5EW��3��~n7	-b5�a�^�Q'-����#�[/�d�gruP3	2o$b6�/g�S�
�2;�����Վ����s�!��!�gp�cn&Cr�O:r�U�*ߕ[MB"5D �>2�钏��{�,.� �u.	!�|���!��[�����v�<���!w��ڼg"��"9h,Eےk���~Qej*^k���/C��!�Y[WX�w�I%q���hc3d�-�o	��G!Vd��Ok	�.Uۡ�p��3��9��+�MC"�2o6���l_�Τbο/Զ�m�B��!��իXc�����V�ӞS�,Y���G!���of�/?��2������PǡL��1�|��H<Mˆ�vvfW�U����t5���+0A䣆D�Y�oIg�/�2�"�H�N�΃�4���G�<*2v�T��2w�� ȩ��a�O!�?%� �QC"�    Tͻ�T��k��=1��9�Μ��2��B��ꇽ����6h'���n;O��̹���1�|���}f)yz���+�؂sn��v���ʃB��!���Z�t�"���	�j~#ؐ��[B"5� R�X����z���N�,�!c#�XR�+�s�D�i�@$,-B�S���@3b�jA����|�.��G���Af��I=�w�����q���2�(M!�|���I��ۂ,��a�F��c":e,��5-��B�"K^9���wYD��#�	���ʱ�%!�.�MC"�ZF�~��)3ꥱ�X^�r�"m�2d["5D �d14����n��i�B7d�&���j!�|���3[�5{�=OvA�ֳmARQ1^�|���G!�5ˣ(�9�^��t�Y�XN�b����:��<׼i�@��Yȇȼ;_��c����Tsp]��~�C��!����<����	̐͜=Z������G��'���T�,ߗ� چ��]�ܬ�yJA䣆�m]�����ň��b���&f/տ,Ș�7�diy�q��-Hv	�p���S�GuA䣆D�#kذۙ���X��>9�7'h��yA䣆D�����3w�|�f;�����3�-�r9���G��H�^��Ay�M��A坔����Cܫ�?��!M�G���(�I� �&��5m�{�\�O&}����� ؿ�?F�l&�$��h��'�I�P{ٛ�½����l~"~�g	�G����(��$`�OE����L��L���0�Yz^���l~�0<j(ð�Y��iԽ���ϫ�υe��L���~����ax� �P���B�r#
��+{�ԭ�3��+��wã
�N��aԴ�Y����V��!�J�/�{&Z�0<j�@$�9�Y3͏��V�%��m/��.�NB��!����-C�a�U���̴��-k�߆K�!�|��ȎɎ�D�m���Ȃ9��{��	��.	!�|��ȽA�X��M��yy˟U�,���F�$� �QC"��T�}�����<9���� ��.�IA䣆D�:��?�^�$���uoabYY�ޗ1�|��HώW��Z���ҺWa���K1SV��SSJ"5D �M#��>J�Ś�A��W3��V�KB"5D R��9?(���.�ھ4h�
JK�_�ZJ	A䣆D�#�x�4͌�0ݞt쓀��W�P/	!�|���Am�9�v:y���d�R?f�W���/	1�|��H���v�s�W�:%�����5u����j"5D �>_� ��s�ˁ��iM�,�u�a��j"5�X�g�Os��'���x�|^u�!�jUkb��7��t ��Ӂ>�:$-����H�/	!�|��Hμ'��6�P�����x޲xl�M���G!�,`L"���~#���uh�6i�Y�� �o"i�;��̎-�i�@��jG�Y���B��!���VsW<���X�Z�&�#^�yq��;A䣆���Jm��N������vn9���k^�:� �.�MC"!�E�>؎%�Hsr��!�kHE�˞�D>j�@� �@�fo�$�#yo�$����uh�D>j��\4����>��Y��D@K�k_3�1w�o"��*x���E��?](5F�����׾�D>j� �~���e��?yMf���9�p��l��(y9/�虰��U���8����Z����
�G��z��Y������Ag3j�_U4ċ�d��BM����Y�G�Q���QXP�g����߇����6��
�̗��\�k~�(<j(� ȍ4����C�y3��J�V��/4}����Qx� ��V*��	�K�zP���6G'C���WZ���Gt,�o���~��[csdG�i��Sڹ�|(����H�?���Oj�S�8���uՃ�Ǽl
�㣆 :�̲���Do�n0J���\KG���n!t|�@Ǣ��6�=K7�U�6�6k�˸]�|U)-����X3Zs'0%�2�F�5n�^��{B���!��u ��o�e���gQ�OI�,�=G�㣆 :�Qa���E�s�I�x����T6��[5б��HU��S��zHf�k�¾.�{5�qQ��CqxA�)'	H�u�݊�?�C���!�vl=ϕ���&�ӆP���ܫ���z����!��y�z���z(�+6-y=B�p���RB�Gt��R?ͬk�f���hj˛�L�� ����s`9����S��^���}�F�㣆 :N�Շ����9�4���������z3�:>j��G������|hy��i��f�Wq��1�㛆 :*�}{9��E��m��N��jߋ�^8���B�h�ʩf����y��/M)�l�_���At|�q�ȭԕ[r6a�b^~?����~�~e|��w|��YS�X�&Xs�$���f�[r�E&���4Dб5ۇ�$�n�X�W=+�98^$�*�P$��o���:����Nh�$�~�������RB�Gt�؎����K��߂U�������{5���QC ���w�~�n��-���O�|��Or�!t|�@�������^�r$A/{��n�2��L*�㣆 :�91�����ӞՎ/���})�㣆 :XS'�4�2�6��ł9e�x2h����QC ��R���=ٶa1��U
��-z���B�G�F����?[M������^�����d+xl1.��>�K@�586�3��$�����h��\�_���V��)�ò�R��M�=|N[����6P���3?�@��?��$�t���QC�`�JM�߂��AE-1g=��%#��Q�n)����܆A�H͒o���݅������ax����.�^%Fof��/�%(�<̫iP.	1�$bS ���vZ���Z{�|L���� /�6`���l�7���e����bV��4dS�L;�l���D>j�@�d��\Л��i�:l�~��d�E��D>j�@d�ٹpZ����.�ԡˮ�7�"�jA䣆D�T��;��͞􌝦m�R͒�2/	!�|��HZ�H;w�K�t�Y<?�$����� ��"Y�������i	����*���m��}�uXA"5D �<��z�9/���2d[���٩���2] ��"���6������Ej5��+���_$� �QC"yځ-}$��	y5J�I6��l�]x�D>j�@$H�cz��U���rl�0���(��-C��!�T��2ۧD�����<ݮ��N�3.	!�|���m�|�l���^�<'_���6/«�E�D>j�@��NX�h5<�ߏ��i��n��n�0��"i��4���a{�z1��w�c���¹�lA䣆Df?'=i�&eNL����������[)��"�Vƒ�����W��Oh:��ݪ�z_yP"5D ��ٟ ����B�L�C;�|��!��vIA䣆���ĳz�=5��@���B��2�u+LAw�O"�N����'�A^eLF���
�)r՜���G!�4锖�I�	I�-sk�8*�
Ю-�oB9F�X}~�xp�=�MG�Z��`ޗ��b��!�:gv�ސ8{�ղm:[��Ls�/�� �QC"	��=��
U��,3��XZYK�u+�B��!�Sfղ5��c]�%L9�jh{x_�sW�D>j�@�ic�z����0	�3f�4m��:�{"5D 2����� 9S�V8�AYV��ܷ�=��By���xđ?���$��&esv��n垉D�iy�A�5y�V/����rζ/���>n���<׼i�@�g'�}l�z�&��F?y����=!�|��HT��VN��:�۱ť�T:�����/�C��!��3����M�s�k�Sͼ�T�vr9��"i���U0���D/�9ؖ�z�~��>�%!��"��a��2�ݐ��R5J]ͦ�+A䣆��8�[�"�d���>��m06۵�^�1A?o"��y�ճY<vؾ4c&1K>�^�����G!���%s���EZ�I��)�:������V�q��4D ��~���\����~~y��:?ݺ���    �G!��`���tfv'W��dN[�;g]��v�D"�4D ��D����%{����,�*<@`a���PB��!$.��Ɏ��a/�����˼;▍S�T�ۂ���!Ɗd��ͦ��V�Z���We���v�$Y�OB�n��¤U���<�O��-3�^��qI�q��4D Ҝ8�Pʕ<#����q��Y���F 9��B�"��<����E�8m&/##ed��ޗ1w�obB��eW�u}�˼ɠ���������:��!$�f��4S�������s�w�e�U/	1�5o"���i-hn��5^'`I����f�r�8��{/� ���/���䩒h��tD�r���7�� �a�6��wf�^B��!�^���J�͐%��J6�Z=P.	!�|��������fQ�І����؂4[��a4z�� �U��������$x�!��%��3)��f�`������ |��6=�3��d2��4۾�f�Ca��k�t���
Z�'p���Co��(�|�0�=��3���"�u'��yF���L}��OW���G��ð���ב�^���N]V�Y�S��\
j�0<�h�����I�yu���o�@"�q�o��4��M�0������s��Y0b��س~Z���:�?]i�E ՗���o��_`{�:$v�L���:�0��"�վg�)���P���6KM^\H3�|\�c�(" ��XI��\/o��)�S���\+�KA"ED R�b�U����1ISۛS�`�Q3^
��&" �mIj6���6�?�w:kp]���i"b�(" ���`�^R���jVk�8ۛ��Xs���`�A䣈 D���J�d}��N;���m�;�"�~ٱ5��"9�4���#t��+8-�s��i����T��G��ig��b�n�JIh�����Ш��Ȯ1�|�H9f�5�	=n�����ߌ�qvΨ�� �QD "����j*�N�
^Fc1A�n.݋��R�b�("\����������i-���f�+�]nAV䛈 Dv!�d6/�����yh[R'�E�D>�@�(3�؈�s=x��n���ޝyy9��j1�|�Ȣ��՗���ݽ؎ɐA~7\����G��3I�iK�C2m[�4��
s�-���
�D>�@$��{�vo�W1�1�q��ؿڹ}=%S"ED r�}y[�<=��~'d�7b��W?� D��@d��Z>�Ɛw��굒a����[�V���P"E R'�U$]���ԡ�$Іvҵ�|�D>�@d�e �}����2mG���nз�^��7�D>�@�W�C���} ��//wnVJ]�{��Dp"E �-s>A��)o�K�������7��\8��""�HP�ێl`/����^�^�P��=��r�9Ȋ|�H�S������fF�-ő
��m�q]r"�DD8����4���������p�M�J�F	r��D 2���2�Q��G?���sc�]G�� �QD"�4�H)��_��n^�Z�t�ۀ� D��@��z��H<?��=�컹8Fe��N��G���(sy�B�2�lg՘)��s�����D>�@$xj��Ǽ�
Q���r�4ź	�z7�D>��@�t�}�4G��/ƶ����y�:B�!�MDċ��'�;�n�<P�F�:��B�i��Z����&" �rn�lGv��8ſ\Z�5[/k}駂D>�@��-S�A:׾�A�щ��Z��,��iX�SA"ED �t�0��f� �Y.������
.���7!V��L�ٱ�����+��� �DY�O"9[ٺ�~�ύyW�f��28�A�-Ss"E r�����X�?&��ZW��4�Ц\��5� �QD"�����T��i�p�B'�ߎ.�!�MD "��E���+�W�Hќ;���l:�mYb�("�� ��^��Y5�v;��|4�~�
��&" �,y����ppy8��%eZ{��p��R��G�Ě=��F�c�}+C"��Ơ����ZK"ED8�2A-�Mo#m^�&��_����:�
��7�5�y7�2���j��Zұ5*��f�[��k�D r��̳��ϧ�y��ݔc/�}����]�(��!�/��)h�����ض�vZ˰�ػ@G�3�a��!�Gi��'^4| Y���/�}��y��Z��GU-*~�e�m����&^xP����4�o���*(�ϟ^��6�����<l��S���;��e�#�����ɗ	�G���P�<�I��
X����6�M�<ܯܚo�G���a#��H�,��v�(��m��kv��k"�rk�}E��è5��.�b��1_G��,�[��2�+��ۇ�QD "��Z݉�_f;���Mʼj3S�ݑxc�(" �hv�t�I��Mu7��!}��2��R��G���s�����R��7A�p\����n�1�|�H�k��GB���i_>�id�އ�i��}j"E �{q�c�J�?����}|3��4@w)Sϥ ��"i_�s@Is����h�1�gk�O+��
b�(" �^{r��9���C3'�I8��3�R��G���3���To5�^?��ڏ��C�u��e�A䣈 D�N�|���976�NZ�����վ/1�|����)����r;�g��Af:{_}k�A䣈 D���6xR�7MW�T�=��q)�A䣈+�\�K�5:��掇p�������c[��&" �ͻ`�j_���R�f|o;�u-�Zl���^)��"�2)�S�>Z]��\w?�T�R"ED R�b��� ͎Mc;��>*i]׍!�MD "�k֑���Ye�l�$1G�R���c�(" ��Yk�\�x8�D�O��;�҇��6�b�(�_ ����HU��Z,f���;Ѧ�Pr��ϫq���O�G+�H�'@��5|��U��W��L��`���� ��{���v<�mV۔�5F��n��U=�~e��U���bK��
�G�?��#�����5x�iR�96~��ŝ}2̜Y�B�t�ͩ_�5�>�"��C���V�e׼l�ڦl3Q'R�*|_~e�|�0<���a��CR'��=�e� ��Bt��u��+�����M�~�0��n���'�z�ބ�����X1k�Q�2k�}E ��7��w�ja��Ss�g�S�u�%1�|���WΫQ���~���;���D� �QD "WST��<��e&�.e��K��T�|9���G�c�q����<p��N0�WAʟC�D>�@�񧫜�J�X��͞%�4��%�����1�|�H;��^#ۖ���������y�������1�|���TZ*ӻ(y��Xk���r���"�j"�D �&��M�~j�y�)�K���}�.�z�A䣈 DB�\J��o����N:(�m�g\��G�ܥ��,��Y.����х8J�<�_�K�1�|�ȵ��6��=��3 ����f���_��-� �QD "�~
��֬��t��´6L�e�u)�A䣈 D�u��,�gU����+��T����KA"E �Cc`O8<p�2- i�l6�)���
b�(" ��x���iM/�e�1I�=�6F�Z�r�[�A䣈 D2v��&;����Ӷ��	!�S�E���G����ӽ����Lr�+�)l��˜o%��"yl�Qm6�s�����pʠEO�
</1�|�H[��LV��+wIJ��B��!�*.A�|�H�a��V��^��R�fØ�'�LS�� b�(" �r+�8����;�g3��z�	b�(" ��O���T�۱�!>p�ɀ1=�\�� �QD"��<6��Ͷe|�fȘ��g�5B䛈G����5�<�ڢ�3K�]����ʗsQ����G����4���ڷ���<�擉빲@F9�O""�H�5d�wH�`�I2�a���KA��&" ���뜑V�����X��r)B�O��.�c�(" ��w/�ӝw|�vr�f��"Ö�؇��1�|aEz79�l�m5�6	J�tb�͎�{=Y�o""9A&ɲ����3�Y5�I�˴S[����!�MD     "�m�j�@f�z���?��Uٶ��j��D>�@�z�n3P<���>�D��ݧ���s_۲� �QD����gZ޳�v�r�"i�Yp�O���P�AV䛈 Dj�"�;.0�^�P�n9g"b�ˎ�1�|��\�[4-a��j^�č�(EG��["E ���9-BOk!���ήf��˹k1�|q�h����a���ƃ�ӬG�~���
��"�D �N�sH���ȧ�w�)9i_T۪����� �QD "�l9�V͛�^^ƌ��zp����A䣈 D69�Z̎�2͹�Ԛ�B�L�,�A䣈�m(Tg�cj�_?}9w���R��.��:�)�E�MD��ü�ٍN�_Q�&�So�v&�.~(Ȋ|�ȱׁ,����z��2�Gϥ����w�D>�@�F����z����'%��|�~u�U��Gq�P��ɓ�g"�nI�t�V��f<���|�HA�~<L���V�"�T)kq�� �QD�]d^+/4W�of�1Z����v�^J�����7����̍Q`o.F#%Lco�4m~.W?(��QD "�4�Y�<�Uk$���e�v�*�ނ�kE � �Y*3!v����6!MefP�
����G����t�d?��e�L�������~U�mA�5�"���q��V�OI����!��خ�2���kE s�k���&��~.�k^v�o��*�ӂ�kED<ר�DUmzk���dNLLGeC�nA�5o""��Ô�D�\���-cZ��i���mA�5�")۾fLۑ*�TyI݋O"s�V����]�(""�z�����d
�c��t5�Ĕ\7A�5�""�>}aO4v����'�HZf�"��9_q�A�5�"�Y��9��q���4����������((��QD "q.��]����f���s���e�QPvͣ�Dv��s�{����fl%���~)B䛈 D��g �$�zH���S��s=c��\
b�(""��Vۆs���5'�����^�>Ee׼�@�,�&���X�T���Wv�z]	�� �QDD�q���C�۩�ܙ�l��2f��cPvͣ����e�fg4���6�a��3����q)
�y�������yE����$':G+�V�BFA�5�"���<<E�����#5Aq;�>����D>�@��5v9����TcR5S��{}Rw�~)�A䣈��Ⱦ�\`���Y*qM�d�`rMЫz)e�<�@$�J�F��{��,��Yv��O�؟
b�(""G{MY�{�������at���=�s�c���G�ܞ�b�sjۯ�8������Cm��1��""�H=��f��ܜGso���l�r,�rٱA�5�"�&�����ӠЌ�nf-�Y�|"���RPvͣ��z��Y1�W3�����hOT��nu�v)��&" �s"5��|���8m=fs���f��v��((��QDD�x-�i�mܶ����S��h���^Q)(��QDD�HimWp<����V�m���s��uuD���G�5���E�w��ӳ�=xS� ��_
��kED�4_��|܂�Ah��<�#EF���]�(�_!2�h�?0���K�����~�}kb�qh�g��+�_2�(�</�48 �]C��9k�� ���ӟ����eu�c�/}��Ǵߑ�5w��zp^�@��@?J����#ߟ^Àp}���Ж��Z�|�g@�4�vء ���$b5h�0�<��t���A��2�~`?y#�r�o��o�G%`΂��rO3�����6s2f	���W�	}�k�}5`�0d�9��t���^��{z��6����[�I���ax���-Ƨm����r��%�Z#��
���� �MC"�±$��ճ�?�2p����[��vy�-��"i��m2�$�9U�w����~���`��}(��"Y�Y�S(����$�4@�2 �p���2D!�|��Ȳ���vf�����p��it;�7xz�=!�|��H��1�)��0]�$85��������D>j�@��nM{�qO���fF�	y;��n�K��G��^����9o�=�l_�_�G���B��C��!�R�g&������U۪�/ۢ���L��G���ֱ�;u�d|5��Gm�\dϺ.<q"5D ҫ�d4�wcs�o1@7M�u�2���%!��B�Hp�V��/���d�d.e2Hg�J8�o"y�lZͻ���?�TFMX���^_{_��D>j�@d��.H����v�dݰ���s�$	A䣆D�q
�ʩl/t�mZ��궑�j}��a%!�|��H�����dN�K@��Ԗ6Լp������ �QC"�E��-1 y��i���~Zq���/JK"5D �wD�/n^>A=�!��z%ۢ�/�EC��!�����o�y�I�IE����r"A䣆���ssf�����(�v�w��Ӧ�Uŕ4�.�MC"in-�K}O3_�\�o��Y��;�/Jk"5D R���f�T������RV�{fQ\��-!��"��O8={���Ķ3[GI�[Apȿ+�!�|���� ��0T��O_o�g���J�
K�2~���U�������(<I� ��]��S��R|��g�`����>'<�cMl]�^F:m�[�7��N�������=���M�dcݻ������m�vI�0��״=5�ߋO��9��H!��(��A�,oƺ�xt�l�T並�|��g�K��Û��a��x�<vB�����1��k�H���/�̚��G%`&,��c�c=�;��K��ۼ_
 f�DD �N�m֊6`��ni�7%=�Q�B��R��7�$h�x��T�7+�����Z���N,��D>�@$�o��Ĩ��!F^[���)�>t)�A䣈 D6s������^�����N+�&�W�.C"E r�����{�96��s��̧�y~*�A䣈D2���j����ԑ�ǳ_�4]���Q�|�ȶD�q{2'��Ǭ�Ðx���;�ݰ�!��"9�Q��HԦ�W��T2_hzsEZ��D>���"�KW��,P��)�l�<�I]���"�D �hT�+]�A3����`�Yv��V��G���/cZRn��;�Lc&����+��1��"����\�u�w�m�z�#�9s�dT&�� �QD "�93�~U�����������Ռى�r�1��"9D{W����*�lt;�R�Kie�&�� �QD "���f;��S��)y6HS
���WA_�1�|�Ȋc�]�W��^)�>�7�<�O�ܻ˜�1�|q����93��nZ쬢\���w��5�.�MD "ki0=3���i�i���s�\/:�D>��p���Zѻj�b�׭�(@4��܂�7�,u�\���k@���c��2F�4�� �QD "i������%2W�Շ��8S��jZ"ED ���3on���[�d#5U ٹ�ʷ� D���x�f���ٶD8i�b�v���8e^
��k�D f��GN�y����:3�|pN/HwE�3� �QD "�%2)��o�|��f=Fꝱo6+��� �QD "͊_�vFo�z��z�ݗp��f2�=1�|�H8��M� mK�(��Z�*����%�R��G�v;|�9w��<��K���Ōz�.�)��~���<���\�Ͷ%i�6R/\lj��}�c�(" �vN�Bi�F'o�����������j���G��/Zf�z%/�`����d���U��9��"�=�ן�9��-�))������b����G������>3wɩ����m�x_ =uԳ�0���G��M��lx��d�������?��5_~3�ϲ��H��L 6�4w���p��K��;2k���Q��%��R��0x����0�
ɈԽ������u�-ynۓ���?%@�0<j��a���̭[��'��5�rsjj}�i&j�0<jhðf��KTzyB;����W8vσH䪰�_�5�=�8`v�Ew�V���3cu���jR��ԯ̚��G�Kj����?Ui�S�W:P���>�C�� �QC    "=f{v3W������_� ��L���q��D�i�@�ث���S���9!��yi�v.�A/	!�|��H���ʹͣ�{�dߴR���r�<��"A䣆D�5f/=����hf�W�9��˹.C5��"y��u���c5ۗ=�TJ�����t���G��9k��ٜ֞��x�Ff �$� �QC"e�{ϔ����l3��-��e�HA䣆DΒ�61������;�x({��L�~IA䣆Dή��A������F�ѳ7
�����KB"5D r�!�73�8W7]l��p�ׁ��a뗄��G�$��2i��S�yw}Մ�[��P�%!��"��y/��T��~\�^g�5��xS����D>j�@���#O����a��hI��g�8xIA䣆D�y�{�ɻ������8	̎��Gmz�D"5D ��/��̦��J�� ���\��k_B"5�8ڛ��Z�Qo��;��F�6��W�o�G�MC"C1e'~7�d���eVs!&ݽ�B��!�4��^���U^i��� i�ۼJ�	� �QC"�^g�}��j�~ˆ�V)Q���ʼ%� �QC"�������f���tuHR���e����G�T�fD����i�I��(i���W����KB"5D �(WY0���t[�����Լo3��=!�|���z�zf��*�g�]4�:w����^B��!����y���y-������̳�[���a"5D R{FB��ݙ��OT]G_��k�bФ� �QC"�^-\kM�qx��M�!e�a��</<�D>j�@�N3N ��_�n#��,O��l�Ð�[���G!��:�n��'�G�3p%v,�\�NsRc��!�����u/��4g��.;M��y��^�!�|��\#�h��`yl��o��8��r������%���7!V�1?<M�[� f���I�<���c\��X�oB�~��jg�1�msM=��k>�N<-O�.�ZL�ϛ�D�3��f�7Fۗ���_�����ǎ�KB"5D Ҽ�~|��,י�V~+�ܤ��-!��B�k��n��yl&�?�����=T��˞���7�4{������C3�w�ߐ���:����B���_!�Џ����Ξ,�%��l�y�����A?��6�W�,�E;���~��$�]§.g6rh�>D�>�96�`�e�7Tx"�]y�?�R�Mjv]��(p��_�5�CB�������O�1m�У��K��u\�y8I�)��*	]O�_�5�=�4`xv���;~�ۏ���AP�(��:��Rk�{5���Цy�S��ڿ
(�����e�.�Yo0` 3�1���iG�sNʞ��Ӿg�Fã�D�Q�~�N�/���|�����8��� �QC"/��,����+��;��wfgb��|�!�|��Ȫ��$�^Zfz�oN�m��}��FI$��")�� ��l͠U��t��A꼬y	A䣆D�����⧷��4�P�Y�T�9�Y !�|���^5����*�b�r�g�;��pʾg"��"�U��Mسw�ٟ4P�x[��|��WkV�D>j�@�6Xm���l��jF�_��3�v��YA䣆D.9{�^�H<vlu7�v�S9m�#�� �QC"ǖ��ތ����ƛ�����=_����G�ݴ�(�N~X���0��3�;x�5��}4��B�-��i�ݼ�5����6)k����3�h�i�@���ln'��H�G�[�3�U+���:�5� �QC"��ӳ}�Z�~�+���b+t�%!��"i��J��Ξ���U˳�k�u�9��B�ȶ�H�&ۙ�vOݬ����5*�3cE�i�@�'�617��G+g�����~a�dI]��D>jA�V�ݘ'{Kw�FJ�Q�cu��k�$�D�i�@$șb����O^KG;���T�f��)k�KB"5D rÚ���.��r_Ir�4u�V��̆�$� �QC�i�.s�`u�{lC�y�vv�]Wh�v��%Ɗ|��H*�06O�O�_��e��0w��k��B��!�.2�!m02{^̖CX	�T!�v�:�
1w�oB�kx�]����^2�n;��Wsmټ}�%!��MC"��.�9�9�NT�ɭ���YH�he�D>j�@$��7��ڧ��ۗ}���`!���$� �QC"�ٱs��~Xu�3��]ʲ���K�%!��"��(�7�W��Z��D]��ϧ�_}/�u���G!V$�y�X�O/�4��dfd#�T���1V䛆DN3OV�����b����6j�+���t�D�i�@����4�;���JO-�̦�6�M�{@�D>jyѮPA<�Ґ)ɬ�:��u���'�y�~�bE.]�ط������l?o,�����OJk���!�m��v��|R��4;_�}��u�SC��!�E�@V/��>$˫��D�veӞ�KB̋���D�O�oP�yxo�����7����ې�!�|��H��y�jl�����H�m�5��s��5��"9F/y��&O�\�"#m�U�գV["5��hg������9v5�Lt��!ܺ?7N?%ļh�i�@��/��쩱����qGR�l�bo�x]��D>j�@dřǢ����e��|R����Q�KB"5D r ~<���ק�����̐U����o!�|���J�=C�	3i�8��|����$PL�ϛ�G{ɞ�y�R3�*MH�ݚCvTM3支�P�q��4���#�KIf���Þ�GsBm`�6��B1A?o"�G)��$h��p�i�c^N1v���[����G��Y��(I��i�#Qn�y�밊ɮy��H�;��j~L^�L؞��0][�Y�}����]�!��� $srqٙ�ނҼ���u�Y���G!/�4�sc��Da�pC'��J.EZ�(�]�!�mٷ�é�c��:S�.[sֽV��p��d�<j�@d�r���1�dtF5J愈�{\�%!��"نG�RڙlA�I�M��:'�'��b�k5D r�!��H��;4{��H���J�챯�*&��QC"3	�i��~h�K�9/��9�T
����d�<j��,��{2��L�cG/���Ͽ��~J���|�٥���.X�Yl&��2��O���b�"�4D �I�|e�P�i>�-ht�w�E��G����|j��n�j�1�����̄�"���G!w���p�4x�F=�s9{�)W7s�ɮy��A$��a@��U�p���_��������������
�Az̒�d��l6n��G��+�������U�0��l_���f;6��c�A����q�:"�Wrͷã��a���_	����Z� ��l^�hQ"���U�Wrͷã����0����{��u��cp�Z�Y�_�O2�"0`�ʣ���x�[�޺xqZ|�zU!35f�D Rp������S_m��uq�z߷�D>�@�%{�Ylp���;�gKy�Q?�t�KA"E rN[pˋ��-�u&��]0�
��G׶,1�|����O5W��W/=��^��w������)�A䣈 Dz�s�f�-��̎-���i��1w���R��G����2���|2:�Jf�c:H�N���p)�A䣈+x+��az#Js�i�we���p_
���7���exqBj��*��qJڕ�3�^�b�(" �լ���8{���j?��c�ڠ\׶�D>�@$�]���?�岽εފt�b��*�A䣈 Dڑ4D�9]� ݎ&�m��R���z�A䣈 Dr��wZ�{�(xh��ڦG+��rAb�(" �
�y�m��%uwOs���Z��l�U�1�|�HP3T՘����c{	�]ӱ*�ޜ���A䣈 D���:�T�SL�Ԛl�ִa��h���׍� �QD�i>�,j�����}��쨞<�T��RdE����"��'c���jޮfs�Κ�t�g�u)�"�D ����Ņ�{�b�>޻��z�8׹����G�D;�$זV˞��G�Gb;ƥ���D�D>�@d�gϖ9����    �?�zl�=���e��D>�@$���d3\�x~��xT(��5�� �KA"E �dy�QNڊ����-Ǯ	�Σٚ�����Gw��͜���z�<���Y��?K��s��-�.�MD "�V&/.�`z{�݌N���ܖ��pө� �QD "w��+S2�e��W�j��:SǙ�ĕKA"ED<״���WS2UOl��J���y��Qh
��k�D r��w�2y_�Fۋ(�z4HwP�-�KI�A䣈 D�9l�Ϧ[<���H�}�>����A䣈 D�!w�	��[���Ѱ�F��#� �QD "Q�$!���#3��7���u�%��\���b�(" �[N듽���8b�];^��t�����b�(" �h�[Y�R�c���guN���?fޕr�xP"E �� ;�3��#ێ)o462�����ƃc�(" ���>N��Cx{�s��7$�B��v)�A䣈DB)��s�{|oD9Vޘu����*�f
��&" �����dGv!B���/�z�v9w��G�,C:��X�\��bGv퉶��S]q\w���G��c�5�Hܼe�LP�X���ʨ�J'h�D>���Y퐮���uN���,���̗9/AA?o"9�8�L��<6� =��6'<Z�>�Z��(1�|�ȣ���c���ׯ~�=4U��;�D��&" �s{L��v��xHb���m��(k�s��D>��W�,�Q{�2V�ǆ���U9�LX��u#�����G��;Bf���uy����M|�J8{���5T�!����A����a_5��@8��S��="�I9lN������	�G+���ʏrz�������:�O���dFܰ�����K�h~�%�Fã�0��tm(��W�;a3\�yy�`��:U�e�%�|�0<j��a�vH1å�gGWZIqj����1�_��Wr�wã���D�Q��^�%)��6�h��5n��\���MC"7Թ�bM��ސ��ހ���9�\��į��o�G��l���eޗ�$;�z2SmN�~]���G��Gx��=v�fxZ���Z���cB��!�$���h��~L���n������2��"i��b���O�˜�f�婥�Zf��L�D>j�@d+e�n��}��K-y��}��ʼ$� �QC"����DՃ�mZ�WI{�9��_I�&!��"9����U�KF���$=�����/߮�D>j�@��0��V)�ؙ�ɏ�~E�sc��2�2��"����D��m�OJ�{ ��,�J�+��G��v2m✎|�\;�:O��]� �u^��D>jq��{i}�T�w���.����;�]u�2	1����Df�rj���O�d��f#0�F�d�!�|��H��'/�v]������N��gJ+����G����TN������8�=f���5��G��|*W���1�F�����2ԊExЯr"&!��"������W��HH%���h�L�����G!Vd���=���4<��E��T23w�=1V䛆D��V��S���Yp�ӎr�rHO����G!��^��u�, �:�yw���AoJ�G�MC������Qi|���'��!�vf�.�`��h�i�@d�{QaL >ږwi��]�ІNxIA䣆D.���+�l���7�2<y`�j}�{&B��!�.��23��֨}�
��X�̆��t�֘��7���d,ǰ�M�е$5�Ż	����=�+���G�Թ�,Ҵ�M�UK�Zr*l���5�kA�D>j�@��^ ��z[�z��.n��3���\�A䣆D�moHs�I�̞�f!Dm���+���7��-�ȧ#��g5$��N�v� ۢ|_��D>j�@�U:?qWE<p�ta���gt���p-H
A䣆D"���r*���L~��w�jf��s�B��!�E{�������`3b�OBb����Ƶ )�E�MC��]V;�������4�c��r[{�Iv9��h�i�@dŹ�֑���#MO���MTF�SJϗ�D>j�@�^?�w�xlI�՝v�َ�m���D>j�@$�4�u$�q̻����)�0j���[B"5D 2㘦ax�Aߗ�$��bd��_u��C��!湦�Zl7����p�6ZRSm���t���\�!�m�����?�w􂕚Ȑ�h���z#�D>j�@d+&�O	�����i0;��d����,!�|��H3V*�Ii"W�41PͳW��o�_B��!��e!��z�H�^���[��9h^���G�j��)}f4	ˌz��i/l�!C����� �QC"�������ݞ�,'�]A��|�J"5��pky�c���?\+��b��f�ɀ���	�y���c��Uχ=�;��7�4��g?�J.1�5�BmB�������:Β��E��^�KLvͣ���*�4�Y���,�^�����ڗA�5oB^��
���S�7��9����+��{AƼh�iɮ��r=�Z̞�YI�|�d�R�V���t���7!q����W�����VK�	���;���%!&.�MC�s�Z��zH����s�{���#zz�%!��MC�]$���3�u�BBs~����W{V�s��!������$ޱ�����iײ'u��� c�7�D�M\	�'=���ld���O1�5�"	[mz�)�[m�,����u6S~�U�}�]�!$t|`��rzh&���/��[��)J�����7��.y�}�X����v�٪b��U����G�,}�Rj�cϻ� �\61���W�d�<jA�vJ���_�<
ͫ��7�]���Cb�k5�8ګt�l�^�AIͲ���DtX��+�	b�k5D ��5� ��^xj�Q�I{g�E�97�c�k5�<�03�O�g��-�Y�9	m�V<k��SPv͛����c��X�u}:����k*e!mR̗����7!q�FZg$�E5��x���b>�hv#_gvLvͣ�D�Q%�zw���l����fն�&^x�ɮy���M^T�����=���dRǬ�f��$��h�i)c1��y� ��jnm��#��\g�%Ĕ�x���Ө@My��l�[�$1��=��.^B��!��ma/��i2�l_�=�hYt��_�-�]�!&.��0�T<��7��RR�C��Í2_��"�4� ���!��x�Ý\���a3q��}\b��!���kLH���.�%c���k'�%��/<�d�<jq��v<q�����ܚ<�A�}�����c�k5��E�����3o��|'���3u�Yʼ)�]��_!�
�V�[u���E�f�$a[����Ju�w����EH���d6<I� R�.�/%R��������Q�G�{� s���T$��Ӳ��4��(�M�����k����G���a���Vb�1�&�/��j�
�|�_�5�>�"����^������˽��'�9U�H�0<����^�1���ԯ:�DCaWه���+��ۇ�QD��ah��x)��;e���y�uc3ڼ��Wjͷã� D��G��\��C�����������=�/1�|�H�9/1��/_����j�i��w>*Z����G��r�Dob�~�+���Z��c;�OW���G�����ka����'u[�	F-{�ǋ���D>�@����s��P;�&Y�'j2�X�X̟
b�(" �J9�۹o�I��.4gHs�>�cħw�O1�|�ȁ|����eVs�S�P������ �QD "�(��W�7�ܔG��z���f�c�(" �(��)g�-=����ڀ���t��}$��""�ȹJ3>��UUz^�����((�� +�MD "u3��L�k�~�&;��Z)��s)�A䣈 D������Ƴ������Yt\%}Ab�(" ���͈9M��*h����w��i����A䣈D�ٕx'�mo�m�Q$I�:*�
�
H� D����"Y�t0s��{��ŉ��e���_�;�Y�o")�7;�1�V�r��k�nIzl��Z��1�|�Ȟ��+�,��c>�T�   Y�Ak�5�� �QD������_it��3B���7�I�๷e���&"��T�TK�_�$#w[�J#�*��D`B䛈 DN�p �핆�v�I�$��+� ��"�y
�h����m�`�P�k94�U�s"E r��%"��t7�y]�ӽ#�6`具�D>�@dÆ�-Ǒ�Dxo���y�yv�P׸� �QD "+���Z�TlGv�Xs��5�J����G��E
tj����T^I�����q>]
b�(" �#c�4%�*��s�P����T]��� ��""�k�A�l�m^m��|���n�R.A�5o"�;�4;��w`,mx�bL�;%p�r�.1�|��yʁ��W���Y%՜�s21�y��E'�A䣈G[k,+���*s���g�3���\
��7�쓗}�2�K���/f���Ƃ�D0�e�B"E r�nF;�$�œ��֣ٱ�칹7nW�)�D>�@$�P�[��,�`$���6�=t)�A䣈 D�F��x�V�qm�%[�3�}v�6ξ!�1�|�H/Wy�����L㌚��BS֭ ��""�"Gi2������e����^��Mbȧ_���"�DD�Eڂsf����zy���[B�ϲ۟.~0�.�MD�)Sm�{�����H�Y0����SA��&" ���[tvB54�U�p�&92�^巰� �QD "եY���D7.��2�:;�n'�ʗ�D>��w�������Ed����)�h��ٱ�O�� N�C�+��~T����������?����)at�      k   �   x�eл1�:Ơ��]d�4�?�)"� E1X ����y�#&���Iԉ
����?�¼@�T-��$���Vyt`KYQ���(�:�W��{z۞pv�z�C�t��X�v����.	�3����c|1(Vz     