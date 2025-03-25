USE Instituto

--1. Crear la vista Repetidores con los alumnos (nombre y dni) que repiten en alguna asignatura.

SELECT * FROM Alumno
SELECT * FROM Matriculado
SELECT * FROM Asignatura
CREATE VIEW Repetidores AS SELECT A.nombre,A.dni 
FROM Alumno AS A INNER JOIN Matriculado AS M ON A.dni = M.dni 
INNER JOIN Asignatura AS ASI ON M.cod = ASI.cod 
WHERE M.repe > 0;

--2. Crear la vista AsignaturasRepetidores que muestre las asignaturas (cod como codigoAsig y nombre como asignatura) donde están matriculado algún alumno repetidor. Ordenar por código de asignatura.
CREATE VIEW AsignaturasRepetidores AS 
SELECT A.cod AS CodigoAsignatura,A.nombre AS NombreAsignatura 
FROM Asignatura AS A INNER JOIN Matriculado AS M ON A.cod = M.cod 
INNER JOIN Alumno AS AL ON M.dni = AL.dni
WHERE AL.dni IN (SELECT dni FROM Alumno)
ORDER BY A.cod DESC;

--3. Crear la vista ProfeRepetidores que muestre el dni de los profes que imparten clase a algún alumno repetidor

SELECT * FROM Profesor
SELECT * FROM Matriculado
CREATE VIEW ProfeRepetidores AS
SELECT P.dni,A.dni FROM Profesor AS P INNER JOIN Alumno AS A ON P.dni = A.tutor INNER JOIN Matriculado AS M ON A.dni = M.dni WHERE M.repe = 1;

--4. Crear la vista ProfeSinAsignatura (nombre y dni) que muestre a los profesores que no imparten ninguna asignatura
--REVISAR
CREATE VIEW ProfeSinAsignatura AS
SELECT P.dni,P.nombre FROM Profesor AS P INNER JOIN Imparte AS I ON P.dni = I.dni INNER JOIN Asignatura AS A ON I.cod = A.cod WHERE I.dni IS NULL;

--5. Crear la vista ProfeSinAlumnos que muestre a los profesores que imparten una asignatura donde no hay ningún alumno matriculado.

SELECT * FROM Matriculado
SELECT * FROM Asignatura
CREATE VIEW ProfeSinAlumnos AS
SELECT P.dni,A.nombre FROM Profesor AS P INNER JOIN Alumno AS A ON P.dni = A.tutor INNER JOIN Matriculado AS M ON A.dni = M.dni INNER JOIN Asignatura AS ASIG ON M.cod = ASIG.cod WHERE M.cod = ASIG.cod;

--6. Crear la vista ProfeSinClase que muestra los profesores que no dan clase. Ya sea por no impartir ninguna asignatura o por impartir una asignatura donde no hay ningún alumno matriculado.
--REVISAR
CREATE VIEW ProfeSinClase AS 
SELECT P.dni FROM Profesor AS P INNER JOIN Imparte AS I ON P.dni = I.dni INNER JOIN Asignatura AS A ON I.cod = A.cod WHERE A.cod IS NULL;

--7. Modificar la vista Repetidores para que muestre la edad del alumno.

SELECT * FROM Alumno
CREATE VIEW Repetidores AS
SELECT * FROM Repetidores UNION SELECT COUNT(YEAR,fecNac,0) AS EDAD FROM Alumno