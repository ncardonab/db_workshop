-- Should be executed at the beginning --

Alter session set "_ORACLE_SCRIPT"=true

-- Tablespace creation --

CREATE TABLESPACE CONSTRUCTION_DB datafile 'C:\oracle\data\CONSTRUCTION_DB_SYS.dbf'
SIZE 1000M
EXTENT MANAGEMENT LOCAL
SEGMENT SPACE MANAGEMENT AUTO;

-- User creation --

CREATE USER DBA_NicolasCardona
Identified by cc123
Default tablespace CONSTRUCTION_DB
quota unlimited on CONSTRUCTION_DB

-- Granting permissions to recently created user --

GRANT DBA, CONNECT, RESOURCE, CREATE SESSION TO DBA_NicolasCardona

-- Creating parent tables --

CREATE TABLE MATERIAL ( 
    Material_id     INT NOT NULL,
    Material        VARCHAR(255) NULL,
    Unidad_med      VARCHAR(255) NULL,
    Costo           INT NULL,
    Existencia      INT NULL,
    CONSTRAINT PK_Material_id   PRIMARY KEY (Material_id),
    CONSTRAINT CK_Unidad_Med    CHECK (Unidad_med IN ('BULTO', 'UNIDAD', 'METRO')),
    CONSTRAINT CK_Costo         CHECK (Costo BETWEEN 0 AND 50000),
    CONSTRAINT CK_Existencia    CHECK (Existencia BETWEEN 0 AND 10000)
);

CREATE TABLE PROVEEDOR (
    Proveedor_id        INT NOT NULL,
    Nit_prov            VARCHAR(255) NULL,
    Nombre              VARCHAR(255) NULL,
    Tel                 NUMBER(7) NULL,
    Cel                 NUMBER(10) NULL,
    URL                 VARCHAR(255) NULL,
    Email               VARCHAR(255) NULL,
    CONSTRAINT PK_Proveedor_id    PRIMARY KEY (Proveedor_id)
);

CREATE TABLE MAESTRO (
    Maestro_id          INT NOT NULL,
    Doc_ident           NUMBER(11) NULL,
    Nom1                VARCHAR(255) NULL,
    Nom2                VARCHAR(255) NULL,
    Ape1                VARCHAR(255) NULL,
    Ape2                VARCHAR(255) NULL,
    Cel                 NUMBER(10) NULL,
    CONSTRAINT PK_Maestro_id    PRIMARY KEY (Maestro_id)
);

CREATE TABLE INGENIERO (
    Ingeniero_id        INT NOT NULL,
    Doc_ident           NUMBER(11) NULL,
    Nom1                VARCHAR(255) NULL,
    Nom2                VARCHAR(255) NULL,
    Ape1                VARCHAR(255) NULL,
    Ape2                VARCHAR(255) NULL,
    Cel                 NUMBER(10) NULL,
    Email               VARCHAR(255) NULL,
    CONSTRAINT PK_Ingeniero_id  PRIMARY KEY (Ingeniero_id)
);

CREATE TABLE TIPO_OBRA (
    Tipo_obra_id        INT NOT NULL,
    Tipo_obra           VARCHAR(255) NOT NULL,
    CONSTRAINT PK_Tipo_obra_id    PRIMARY KEY (Tipo_obra_id)
);

CREATE TABLE CLIENTE (
    Cliente_id          INT NOT NULL,
    Doc_identidad       NUMBER(11) NULL,
    Tipo_doc            VARCHAR(255) NULL,
    Nom1                VARCHAR(255) NULL,
    Nom2                VARCHAR(255) NULL,
    Ape1                VARCHAR(255) NULL,
    Ape2                VARCHAR(255) NULL,
    CONSTRAINT PK_Cliente_id        PRIMARY KEY (Cliente_id),
    CONSTRAINT CK_Tipo_doc          CHECK (Tipo_doc IN('CEDULA_CIUDADANIA', 'CEDULA_EXTRANJERIA', 'TARJETA_IDENTIDAD', 'NIT', 'RUT'))
);

CREATE TABLE COMPRA (
    Nro_factura         INT NOT NULL,
    Fecha               DATE NULL,
    Total_pagar         INT NOT NULL,
    Proveedor_id        INT NOT NULL,
    CONSTRAINT PK_Nro_factura    PRIMARY KEY (Nro_factura),
    CONSTRAINT FK_Proveedor_id   FOREIGN KEY (Proveedor_id)   REFERENCES PROVEEDOR (Proveedor_id)
);

CREATE TABLE COMPRA_MATERIAL (
    Compra_material_id  INT NOT NULL,
    Nro_factura         INT NOT NULL,
    Material_id         INT NOT NULL,
    Cantidad            INT NULL,
    Costo_unid          INT NULL,
    Total               INT NULL,
    CONSTRAINT PK_Compra_material_id    PRIMARY KEY (Compra_material_id),
    CONSTRAINT FK_Nro_factura           FOREIGN KEY (Nro_factura)   REFERENCES COMPRA (Nro_factura),
    CONSTRAINT FK_Material_id           FOREIGN KEY (Material_id)   REFERENCES MATERIAL (Material_id)
);

CREATE TABLE OBRA (
    Nro_obra            INT NOT NULL, 
    Fecha               DATE NULL,
    Forma_pago          VARCHAR(255) NULL,
    Valor_total         INT NULL,
    Plazo               INT NULL,
    Pago_inicial        INT NULL,
    Saldo               INT NULL,
    Ingeniero_id        INT NOT NULL,
    Tipo_obra_id        INT NOT NULL,
    Cliente_id          INT NOT NULL,
    CONSTRAINT PK_Nro_obra              PRIMARY KEY (Nro_obra),
    CONSTRAINT FK_Ingeniero_id          FOREIGN KEY (Ingeniero_id)   REFERENCES INGENIERO (Ingeniero_id),
    CONSTRAINT FK_Tipo_obra_id          FOREIGN KEY (Tipo_obra_id)   REFERENCES TIPO_OBRA (Tipo_obra_id),
    CONSTRAINT FK_Cliente_id            FOREIGN KEY (Cliente_id)     REFERENCES CLIENTE (Cliente_id)
);

CREATE TABLE OBRA_MAESTRO (
    Detalle_obra_maestro_id INT NOT NULL, 
    Nro_obra                INT NOT NULL,
    Maestro_id              INT NOT NULL,
    Fecha_ingreso           DATE NULL,
    CONSTRAINT PK_Detalle_obra_maestro_id   PRIMARY KEY (Detalle_obra_maestro_id),
    CONSTRAINT FK_Nro_obra                  FOREIGN KEY (Nro_obra)      REFERENCES OBRA (Nro_obra),
    CONSTRAINT FK_Maestro_id                FOREIGN KEY (Maestro_id)    REFERENCES MAESTRO (Maestro_id)
);

CREATE TABLE DETALLE_OBRA (
    Detalle_obra_id     INT NOT NULL,
    Nro_obra            INT NOT NULL, 
    Material_id         INT NOT NULL,
    Cantidad            INT NULL,
    Costo               INT NULL,
    Total               INT NULL,
    CONSTRAINT PK_Detalle_obra_id           PRIMARY KEY (Detalle_obra_id),
    CONSTRAINT FK_Nro_obra_detalle_obra     FOREIGN KEY (Nro_obra)      REFERENCES OBRA (Nro_obra),
    CONSTRAINT FK_Material_id_detalle_obra  FOREIGN KEY (Material_id)   REFERENCES MATERIAL (Material_id)
);

-- Dropping tables --

DROP TABLE OBRA_MAESTRO;

DROP TABLE DETALLE_OBRA;

DROP TABLE OBRA;

DROP TABLE COMPRA_MATERIAL;

DROP TABLE COMPRA;

DROP TABLE CLIENTE;

DROP TABLE TIPO_OBRA;

DROP TABLE INGENIERO;

DROP TABLE MAESTRO;

DROP TABLE PROVEEDOR;

DROP TABLE MATERIAL;