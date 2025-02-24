
--Nombre de la mascota, raza, especie y fecha de nacimiento de aquellos que hayan sufrido leucemia, moquillo o toxoplasmosis

SELECT * FROM BI_Mascotas
SELECT * FROM BI_Mascotas_Enfermedades
SELECT * FROM BI_Enfermedades
SELECT M.Alias AS Nombre,M.Raza,M.Especie,M.FechaNacimiento,E.Nombre FROM BI_Mascotas AS M INNER JOIN BI_Mascotas_Enfermedades AS ME ON M.Codigo = ME.Mascota INNER JOIN BI_Enfermedades AS E ON ME.IDEnfermedad = E.ID WHERE E.Nombre IN ('leucemia','moquillo','toxoplasmosis') GROUP BY M.Alias,M.Raza,M.Especie,M.FechaNacimiento,E.Nombre

--Nombre, raza y especie de las mascotas que hayan ido a alguna visita en primavera (del 20 de marzo al 20 de Junio)

SELECT * FROM BI_Mascotas
SELECT * FROM BI_Visitas 
SELECT M.Alias AS Nombre,M.Raza,M.Especie,MONTH(V.Fecha) AS Mes,DAY(V.Fecha) AS Dia FROM BI_Mascotas AS M INNER JOIN BI_Visitas AS V ON M.Codigo = V.Mascota WHERE (MONTH(Fecha) = 3 AND DAY(Fecha) >= 20) OR (MONTH(Fecha) BETWEEN 4 AND 5) OR (MONTH(Fecha) = 6 AND DAY(Fecha) <= 20) GROUP BY M.Alias,M.Raza,M.Especie,V.Fecha

--Nombre y tel�fono de los propietarios de mascotas que hayan sufrido rabia, sarna, artritis o filariosis y hayan tardado m�s de 10 d�as en curarse. Los que no tienen fecha de curaci�n, considera la fecha actual para calcular la duraci�n del tratamiento.
--Nombre y especie de las mascotas que hayan ido alguna vez a consulta mientras estaban enfermas. Incluye el nombre de la enfermedad que sufr�an y la fecha de la visita.
--Nombre, direcci�n y tel�fono de los clientes que tengan mascotas de al menos dos especies diferentes
--Nombre, tel�fono y n�mero de mascotas de cada especie que tiene cada cliente. Mostrar tambi�n la especie de la mascota
--Nombre, especie y nombre del propietario de aquellas mascotas que hayan sufrido una enfermedad de tipo infeccioso (IN) o gen�tico (GE) m�s de una vez.
