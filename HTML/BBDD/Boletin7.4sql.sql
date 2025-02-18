
SELECT * FROM BI_Clientes
--Introduce dos nuevos clientes. Asígnales los códigos que te parezcan adecuados.
INSERT INTO BI_Clientes (Codigo,Telefono,Direccion,Nombre) VALUES (107,627189704,'Calle Pirineos, 13','Guillermo Villanueva');
INSERT INTO BI_Clientes (Codigo,Telefono,Direccion,Nombre) VALUES (108,627189703,'Urbanizacion Brenes','Ivan Zamora');

SELECT * FROM BI_Mascotas
--Introduce una mascota para cada uno de ellos. Asígnales los códigos que te parezcan adecuados.
INSERT INTO BI_Mascotas VALUES ('GV007','Galgo','Gato','2020-08-14',null,'Maki',107);
INSERT INTO BI_Mascotas VALUES ('IZ069','Podenco','Perro','2022-08-04',null,'Jorge',108);

--Escribe un SELECT para obtener los IDs de las enfermedades que ha sufrido alguna mascota. Los IDs no deben repetirse
SELECT * FROM BI_Enfermedades

--El cliente Josema Ravilla ha llevado a visita a todas sus mascotas.
--Escribe un SELECT para averiguar el código de Josema Ravilla.
SELECT * FROM BI_Clientes 
Select Codigo FROM BI_Clientes where Nombre = 'Josema Ravilla';

--Escribe otro SELECT para averiguar los códigos de las mascotas de Josema Ravilla.
SELECT * FROM BI_Mascotas
SELECT Codigo FROM BI_Mascotas WHERE CodigoPropietario = 102;

--Con los códigos obtenidos en la consulta anterior, escribe los INSERT correspondientes en la tabla BI_Visitas. La fecha y hora se tomarán del sistema.
SELECT * FROM BI_Visitas
INSERT INTO BI_VISITAS (Fecha,Temperatura,Peso,Mascota) VALUES (CURRENT_TIMESTAMP,45,54,'GM002');
INSERT INTO BI_VISITAS (Fecha,Temperatura,Peso,Mascota) VALUES (CURRENT_TIMESTAMP,30,24,'PH002');

--Todos los perros del cliente 104 han enfermado el 20 de diciembre de sarna.
SELECT * FROM BI_Mascotas_Enfermedades
SELECT Codigo FROM BI_Mascotas WHERE CodigoPropietario = 104;
INSERT INTO BI_Mascotas_Enfermedades () VALUES ('GH004','2025-06-24');
INSERT INTO BI_Mascotas_Enfermedades () VALUES ('PH004','2025-06-24');
INSERT INTO BI_Mascotas_Enfermedades () VALUES ('PH104','2025-06-24');
INSERT INTO BI_Mascotas_Enfermedades () VALUES ('PM004','2025-06-24');

--Escribe un SELECT para averiguar los códigos de todos los perros del cliente 104
--Con los códigos obtenidos en la consulta anterior, escribe los INSERT correspondientes en la tabla BI_Mascotas_Enfermedades

