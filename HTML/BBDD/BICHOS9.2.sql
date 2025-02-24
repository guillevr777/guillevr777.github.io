
--Nombre de la mascota, raza, especie y fecha de nacimiento de aquellos que hayan sufrido leucemia, moquillo o toxoplasmosis

SELECT * FROM BI_Mascotas
SELECT * FROM BI_Mascotas_Enfermedades
SELECT * FROM BI_Enfermedades
SELECT M.Alias AS Nombre,M.Raza,M.Especie,M.FechaNacimiento,E.Nombre FROM BI_Mascotas AS M INNER JOIN BI_Mascotas_Enfermedades AS ME ON M.Codigo = ME.Mascota INNER JOIN BI_Enfermedades AS E ON ME.IDEnfermedad = E.ID WHERE E.Nombre IN ('leucemia','moquillo','toxoplasmosis') GROUP BY M.Alias,M.Raza,M.Especie,M.FechaNacimiento,E.Nombre

--Nombre, raza y especie de las mascotas que hayan ido a alguna visita en primavera (del 20 de marzo al 20 de Junio)

SELECT * FROM BI_Mascotas
SELECT * FROM BI_Visitas 
SELECT M.Alias AS Nombre,M.Raza,M.Especie,MONTH(V.Fecha) AS Mes,DAY(V.Fecha) AS Dia FROM BI_Mascotas AS M INNER JOIN BI_Visitas AS V ON M.Codigo = V.Mascota WHERE (MONTH(Fecha) = 3 AND DAY(Fecha) >= 20) OR (MONTH(Fecha) BETWEEN 4 AND 5) OR (MONTH(Fecha) = 6 AND DAY(Fecha) <= 20) GROUP BY M.Alias,M.Raza,M.Especie,V.Fecha

--Nombre y teléfono de los propietarios de mascotas que hayan sufrido rabia, sarna, artritis o filariosis y hayan tardado más de 10 días en curarse. Los que no tienen fecha de curación, considera la fecha actual para calcular la duración del tratamiento.
-- REVISAR ERROR BBDD

SELECT * FROM BI_Clientes
SELECT * FROM BI_Mascotas
SELECT * FROM BI_Mascotas_Enfermedades
SELECT * FROM BI_Enfermedades
SELECT C.Nombre,C.Telefono,E.Nombre AS Enfermedad 
FROM BI_Clientes AS C INNER JOIN BI_Mascotas AS M ON C.Codigo = M.CodigoPropietario 
INNER JOIN BI_Mascotas_Enfermedades AS ME ON M.CodigoPropietario = ME.Mascota 
INNER JOIN BI_Enfermedades AS E ON ME.IDEnfermedad = E.ID 
WHERE E.Nombre IN ('rabia''sarna''artritis''filariosis') 
AND DATEDIFF(DAY, ME.FechaInicio, COALESCE(ME.FechaCura, GETDATE())) > 10 
OR ME.FechaCura = NULL
GROUP BY C.Nombre,C.Telefono,E.Nombre

--Nombre y especie de las mascotas que hayan ido alguna vez a consulta mientras estaban enfermas. Incluye el nombre de la enfermedad que sufrían y la fecha de la visita.

SELECT * FROM BI_Mascotas
SELECT * FROM BI_Enfermedades
SELECT * FROM BI_Mascotas_Enfermedades
SELECT M.Alias AS Nombre,M.Especie,E.Nombre,ME.FechaInicio FROM BI_Mascotas AS M INNER JOIN BI_Mascotas_Enfermedades AS ME ON M.Codigo = ME.Mascota INNER JOIN BI_Enfermedades AS E ON ME.IDEnfermedad = E.ID GROUP BY M.Alias,M.Especie,E.Nombre,ME.FechaInicio

--Nombre, teléfono y número de mascotas de cada especie que tiene cada cliente. Mostrar también la especie de la mascota

SELECT * FROM BI_Mascotas
SELECT * FROM BI_Clientes
SELECT C.Nombre,C.Telefono,M.Codigo,M.Especie FROM BI_Clientes AS C INNER JOIN BI_Mascotas AS M ON C.Codigo = M.CodigoPropietario GROUP BY C.Nombre,C.Telefono,M.Codigo,M.Especie

--Nombre, especie y nombre del propietario de aquellas mascotas que hayan sufrido una enfermedad de tipo infeccioso (IN) o genético (GE) más de una vez.

SELECT * FROM BI_Clientes
SELECT * FROM BI_Mascotas
SELECT * FROM BI_Mascotas_Enfermedades
SELECT * FROM BI_Enfermedades
SELECT M.Alias AS Nombre,M.Especie,C.Nombre 
FROM BI_Clientes AS C INNER JOIN BI_Mascotas AS M ON C.Codigo = M.CodigoPropietario
INNER JOIN BI_Mascotas_Enfermedades AS ME ON M.Codigo = ME.Mascota 
INNER JOIN BI_Enfermedades AS E ON ME.IDEnfermedad = E.ID 
WHERE E.Tipo IN ('IN','GE')
GROUP BY M.Alias,M.Especie,C.Nombre
HAVING COUNT(E.Tipo) > 1