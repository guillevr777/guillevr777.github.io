DROP DATABASE IF EXISTS Agenda;
CREATE DATABASE Agenda;
USE Agenda;

DROP DATABASE Agenda;

CREATE TABLE  Contactos (
  nombre varchar(25),
  dni varchar(9),
  PRIMARY KEY (dni)
)

CREATE TABLE  Telefonos (
  id INT Identity,
  numero varchar(9),
  dni varchar(9),
   PRIMARY KEY(id),
   FOREIGN KEY(dni) REFERENCES Contactos(dni) 
   ON DELETE SET NULL
   ON UPDATE SET NULL
)

INSERT INTO Contactos values('Ana', '111');
INSERT INTO Contactos values('Pepe', '222');
INSERT INTO Contactos values('Juan', '333');

INSERT INTO Telefonos (numero, dni) values ('1111', '111');
INSERT INTO Telefonos (numero, dni) values ('2222', '111');
INSERT INTO Telefonos (numero, dni) values ('3333', '111');
INSERT INTO Telefonos (numero, dni) values ('4444', '222');
INSERT INTO Telefonos (numero, dni) values ('5555', '222');
INSERT INTO Telefonos (numero, dni) values ('5555', '333');

-----------------------------------------------------------------

CREATE DATABASE Escuela

USE Escuela

CREATE TABLE Alumnos (
	Nombre Varchar(20),
	Nota char (2),
	Dni Char(9) CONSTRAINT PK_ALUMNOS PRIMARY KEY
)
CREATE TABLE Asignaturas (
	Codigo char(20) CONSTRAINT PK_ASIGNATURAS PRIMARY KEY,
	Nombre Varchar(20),
	Numero char(10),
	Nota char (2) CONSTRAINT FK_ALUMNOS_NOTA FOREIGN KEY
)
CREATE TABLE Profesores (
	Dni Char(9) CONSTRAINT PK_PROFESORES PRIMARY KEY,
	Nombre Varchar(20)
)