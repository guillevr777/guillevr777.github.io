
--Queremos saber nombre, apellidos y edad de cada miembro y el número de regatas que ha disputado en barcos de cada clase.

SELECT * FROM LS_Miembros
SELECT * FROM LS_Miembros_Barcos_Regatas
SELECT * FROM LS_Barcos
SELECT * FROM LS_Clases

CREATE VIEW NumDisputasPorBarco AS
SELECT M.nombre,M.apellidos,DATEDIFF(YEAR,M.f_nacimiento,GETDATE()) AS Edad,C.nombre AS NombreBarco,COUNT(mi.f_inicio_regata) AS NºRegatas 
FROM LS_Miembros M 
INNER JOIN LS_Miembros_Barcos_Regatas MI 
ON M.licencia_federativa = MI.licencia_miembro 
INNER JOIN LS_Barcos B 
ON MI.n_vela = B.n_vela 
INNER JOIN LS_Clases C 
ON B.nombre_clase = C.nombre
GROUP BY M.nombre,M.apellidos,M.f_nacimiento,C.nombre

SELECT * FROM NumDisputasPorBarco

--Miembros que tengan más de 250 horas de cursos y que nunca hayan disputado una regata compartiendo barco con Esteban Dido.

SELECT * FROM LS_Miembros
SELECT * FROM LS_Cursos
SELECT * FROM LS_Regatas
SELECT * FROM LS_Miembros_Barcos_Regatas

CREATE VIEW HorasDeCurso AS
SELECT M.licencia_federativa,M.nombre + ' ' + M.apellidos AS NombreCompleto,SUM(C.duracion * 24) AS Horas_Totales_Curso FROM LS_Miembros M 
INNER JOIN LS_Miembros_Cursos MI ON M.licencia_federativa = MI.licencia_federativa 
INNER JOIN LS_Cursos C ON MI.codigo_curso = C.codigo_curso 
GROUP BY  M.licencia_federativa, M.nombre, M.apellidos,C.duracion;

---------------------------------------------------------

CREATE VIEW Equipo AS
SELECT DISTINCT M.licencia_federativa,M.nombre + ' ' + M.apellidos AS NombreCompleto FROM LS_Miembros M
INNER JOIN LS_Miembros_Barcos_Regatas MB ON M.licencia_federativa = MB.licencia_miembro
WHERE MB.n_vela IN (
SELECT MB2.n_vela FROM LS_Miembros M2 
INNER JOIN LS_Miembros_Barcos_Regatas MB2 ON M2.licencia_federativa = MB2.licencia_miembro) 
AND M.nombre != 'Esteban' AND M.apellidos != 'Dido';

----------------------------------------------------------

SELECT * FROM HorasDeCurso MH WHERE MH.Horas_Totales_Curso > 250 AND MH.licencia_federativa IN (SELECT licencia_federativa FROM Equipo)
ORDER BY MH.Horas_Totales_Curso DESC;

/**
*Crea una vista VTrabajoMonitores que contenga número de licencia, nombre y apellidos de cada monitor, número de cursos y número total de horas que ha impartido, 
*así como el número total de alumnos que han participado en sus cursos. A la hora de contar los asistentes, se contaran participaciones, no personas. 
*Es decir, si un mismo miembro ha asistido a tres cursos distintos, se contará como tres, no como uno. Deben incluirse los monitores a cuyos cursos no haya asistido nadie, para echarles una buena bronca.
*/

SELECT * FROM LS_Monitores
SELECT * FROM LS_Miembros
SELECT * FROM LS_Miembros_Cursos
SELECT * FROM LS_Cursos

CREATE VIEW CursosProfesores AS
SELECT M.nombre + ' ' + M.apellidos AS NombreCompleto,M.licencia_federativa,COUNT(C.codigo_curso) AS NºCursos,SUM(C.duracion*24) AS NºHorasCurso FROM LS_Miembros M 
INNER JOIN LS_Monitores MO ON M.licencia_federativa = MO.licencia_federativa 
INNER JOIN LS_Cursos C ON MO.licencia_federativa = C.licencia 
GROUP BY M.nombre,M.apellidos,M.licencia_federativa;

---------------------------------------------------------------------------

CREATE VIEW Asistencias AS 
SELECT M.licencia_federativa,M.nombre + ' ' + M.apellidos AS NombreCompleto,COUNT(MI.codigo_curso) AS NºCursos FROM LS_Miembros M FULL JOIN LS_Miembros_Cursos MI ON M.licencia_federativa = MI.licencia_federativa
GROUP BY M.licencia_federativa,M.nombre,M.apellidos

----------------------------------------------------------------------------

CREATE VIEW VTrabajoMonitores AS
SELECT * FROM CursosProfesores C WHERE C.licencia_federativa IN (SELECT licencia_federativa FROM Asistencias)


SELECT * FROM CursosProfesores
SELECT * FROM Asistencias

/**
*Número de horas de cursos acumuladas por cada miembro que no haya disputado una regata en la clase 470 en los dos últimos años (2013 y 2014). 
*Se contarán únicamente las regatas que se hayan disputado en un campo de regatas situado en longitud Oeste (W). Se sabe que la longitud es W porque el número es negativo.
*/

SELECT * FROM LS_Cursos
SELECT * FROM LS_Miembros_Cursos
SELECT * FROM LS_Miembros
SELECT * FROM LS_Miembros_Barcos_Regatas
SELECT * FROM LS_Regatas
SELECT * FROM LS_ResultadosRegatas
SELECT * FROM LS_Barcos
SELECT * FROM LS_Clases

SELECT * FROM LS_Cursos
SELECT * FROM LS_Clases
SELECT * FROM LS_ResultadosRegatas
SELECT * FROM LS_Miembros

CREATE VIEW HorasMiembros AS
SELECT M.nombre + ' ' + M.apellidos AS NombreCompleto,SUM(C.duracion*24) AS HorasAcumuladas,CL.nombre AS NombreRegata,RR.FechaRegata FROM LS_Cursos C 
INNER JOIN LS_Miembros_Cursos MC ON C.codigo_curso = MC.codigo_curso 
INNER JOIN LS_Miembros M ON MC.licencia_federativa = M.licencia_federativa 
INNER JOIN LS_Miembros_Barcos_Regatas MBR ON 