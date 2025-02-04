Create Database Colegas
go
Use Colegas
GO
-- People
Create Table People (
	ID SmallInt Not NULL Constraint PKPeople Primary Key,
	Nombre VarChar(20) Not NULL,
	Apellidos VarChar(20) Not NULL,
	FechaNac Date NULL
)
GO
-- Carros
Create Table Carros (
	ID SmallInt Not NULL Constraint PKCarros Primary Key,
	Marca VarChar(15) Not NULL,
	Modelo VarChar(20) Not NULL,
	Anho SmallInt NULL Constraint CKAnno Check (Anho Between 1900 AND YEAR(Current_Timestamp)),
	Color VarChar(15),
	IDPropietario SmallInt NULL Constraint FKCarroPeople Foreign Key References People (ID) On Update No action On Delete No action
)
-- Libros
Create Table Libros(
	ID Int Not NULL Constraint PKLibros Primary Key,
	Titulo VarChar(60) Not NULL,
	Autors VarChar(50) NULL
)
GO
--Lecturas
Create Table Lecturas(
	IDLibro Int Not NULL,
	IDLector SmallInt Not NULL,
	Constraint PKLecturas Primary Key (IDLibro, IDLector),
	Constraint FKLecturasLibros Foreign Key (IDLibro) References Libros (ID) On Update No action On Delete No action,
	Constraint FKLecturasLectores Foreign Key (IDLector) References People (ID) On Update No action On Delete No action,
	AnhoLectura SmallInt NULL
)





------------------RELLLENAMOS LA BASE DE DATOS---------------

INSERT INTO PEOPLE (Id,Nombre,Apellidos,FechaNac)
	values
		(1,'eduardo','mingo','14/07/1990'),
		(2,'margarita','padera','11/11/1992'),
		(4,'eloisa','lamandra','02/03/2000'),
		(5,'jordi','videndo','28/05/1989'),
		(6,'alfonso','sito','10/10/1978');

INSERT INTO CARROS values
		(1,'seat','ibiza','2014','blanco',NULL),
		(2,'ford','focus','2016','rojo',1),
		(3,'toyota','prius','2017','blanco',4),
		(5,'renault','megane','2004','azul',2),
		(8,'mitsubishi','colt','2011','rojo',6);

INSERT INTO LIBROS (ID,Titulo,Autors)
	values
		(2,'EL CORAZON DE LAS TINIEBLAS','JOSEPH CONRAD'),
		(4,'CIEN AÑOS DE SOLEDAD','Gabriel García Márquez'),
		(8,'Harry Potter y la cámara de los secretos','J. K. Rowling'),
		(16,'Evangelio del Flying Spaguetti Monster','Bobby Henderson');



-------------------------------



		INSERT INTO LECTURAS (IDLibro, IDLector)
		VALUES 
			(4,1),
			(2,2),
			(4,4),
			(8,4),
			(16,5),
			(16,6);

		INSERT INTO CARROS (ID,IDPropietario)
			VALUES 
				(5,6);
		
		SELECT * FROM PEOPLE WHERE (DATEDIFF(DAY, FechaNac, GETDATE()) >= 10950);

		SELECT * FROM CARROS WHERE (COLOR NOT LIKE 'GREEN' AND COLOR NOT LIKE 'WHITE');

		INSERT INTO LIBROS VALUES (32,'VIDAS SANTAS','ALBATE BRINGAS');

		INSERT INTO LECTURAS VALUES (2,4);
		
		INSERT INTO CARROS (ID,IDPropietario) VALUES (1,5);
		
		SELECT * FROM LIBROS WHERE (ID % 2 = 0);