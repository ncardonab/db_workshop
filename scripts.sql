-- Should be executed at the beginning --

Alter session set "_ORACLE_SCRIPT"=true

-- Tablespace creation --

CREATE TABLESPACE BDVENTAS datafile 'C:\oracle\data\BDSYSVENTAS.dbf'
SIZE 1000M 
EXTENT MANAGEMENT LOCAL
SEGMENT SPACE MANAGEMENT AUTO;

-- User creation --

CREATE user DBA_NicolasCardona
Identified by cc123
Default tablespace BDVENTAS
quota unlimited on BDVENTAS

-- Grant permissions to recently created user --

GRANT DBA, CONNECT, RESOURCE, CREATE SESSION TO DBA_NicolasCardona

SHOW USER

-- First create parent tables to avoid getting errors --

CREATE TABLE CLIENTE(
    Cliente_Id      INTEGER NOT NULL,
    Doc_Identidad   VARCHAR2(15) UNIQUE,
    Nom1            VARCHAR2(20) NOT NULL,
    Nom2            VARCHAR2(20) NULL,
    Ape1            VARCHAR2(20) NOT NULL,
    Ape2            VARCHAR2(20) NULL,
    Fecha_Ing       DATE NOT NULL,
    Cel             VARCHAR2(10) NOT NULL,
    Tipo_Cliente    VARCHAR2(20) NOT NULL,
    Email           VARCHAR(30) NULL,
    CONSTRAINT PKCLIENTE PRIMARY KEY (Cliente_Id),
    CONSTRAINT CK_TIPO_CLIENTE CHECK (Tipo_Cliente in('NORMAL','PREFERENCIAL'))
);

CREATE TABLE VENDEDOR(
    Vendedor_Id INTEGER NOT NULL ,
    Cod_Vendedor varchar2(10) NOT NULL UNIQUE,
    Nom1 varchar(20) NOT NULL,
    Nom2 varchar(20) NULL,
    Ape1 varchar(20) NOT NULL,
    Ape2 varchar(20) NULL,
    Email varchar2(30) NOT NULL,
    Cel  varchar(10) NOT NULL,
    CONSTRAINT PKVENDEDOR PRIMARY KEY(Vendedor_Id)
);
