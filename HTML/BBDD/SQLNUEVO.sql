
--Introduce dos nuevos clientes. Asígnales los códigos que te parezcan adecuados.
INSERT INTO BI_Clientes (Codigo, Telefono, Direccion, NumeroCuenta, Nombre)
VALUES (107, '611223344', 'Calle Mayor, 22', 'ES1234567890123456789012', 'Laura Méndez'),
       (108, '622334455', 'Avenida Central, 55', 'ES9876543210987654321098', 'Carlos Rivera');

--Introduce una mascota para cada uno de ellos. Asígnales los códigos que te parezcan adecuados.
INSERT INTO BI_Mascotas (Codigo, Raza, Especie, FechaNacimiento, FechaFallecimiento, Alias, CodigoPropietario)
VALUES ('PM006', 'Beagle', 'Perro', '20200115', NULL, 'Max', 107),
       ('GM007', 'Persa', 'Gato', '20191205', NULL, 'Luna', 108);

--Escribe un SELECT para obtener los IDs de las enfermedades que ha sufrido alguna mascota. Los IDs no deben repetirse
SELECT DISTINCT IDEnfermedad FROM BI_Mascotas_Enfermedades;

--El cliente Josema Ravilla ha llevado a visita a todas sus mascotas.
--Escribe un SELECT para averiguar el código de Josema Ravilla.
SELECT Codigo FROM BI_Clientes WHERE Nombre = 'Josema Ravilla';

--Escribe otro SELECT para averiguar los códigos de las mascotas de Josema Ravilla.
SELECT Codigo FROM BI_Mascotas WHERE CodigoPropietario = (SELECT Codigo FROM BI_Clientes WHERE Nombre = 'Josema Ravilla');

--Con los códigos obtenidos en la consulta anterior, escribe los INSERT correspondientes en la tabla BI_Visitas. La fecha y hora se tomarán del sistema.
INSERT INTO BI_Visitas (Fecha, Mascota, Temperatura, Peso) SELECT GETDATE(), Codigo, NULL, NULL FROM BI_Mascotas WHERE CodigoPropietario = (SELECT Codigo FROM BI_Clientes WHERE Nombre = 'Josema Ravilla');

--Todos los perros del cliente 104 han enfermado el 20 de diciembre de sarna.
--Escribe un SELECT para averiguar los códigos de todos los perros del cliente 104
SELECT Codigo FROM BI_Mascotas WHERE CodigoPropietario = 104 AND Especie = 'Perro';

--Con los códigos obtenidos en la consulta anterior, escribe los INSERT correspondientes en la tabla BI_Mascotas_Enfermedades
INSERT INTO BI_Mascotas_Enfermedades (IDEnfermedad, Mascota, FechaInicio, FechaCura) SELECT 4, Codigo, '2024-12-20', NULL FROM BI_Mascotas WHERE CodigoPropietario = 104 AND Especie = 'Perro';

--Escribe una consulta para obtener el nombre, especie y raza de todas las mascotas, ordenados por edad.
SELECT * FROM BI_Mascotas
SELECT Alias,Especie,Raza FROM BI_Mascotas ORDER BY FechaNacimiento

--Escribe los códigos de todas las mascotas que han ido alguna vez al veterinario un lunes o un viernes. Para averiguar el dia de la semana de una fecha se usa la función DATEPART (WeekDay, fecha) que devuelve un entero entre 1 y 7 donde el 1 corresponde al lunes, el dos al martes y así sucesivamente.
SELECT * FROM BI_Visitas
SELECT Mascota FROM BI_Visitas WHERE DATEPART (WeekDay, Fecha) = 1 OR DATEPART (WeekDay, Fecha) = 5;