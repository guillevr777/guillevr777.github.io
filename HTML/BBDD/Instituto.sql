USE Instituto

1.

SELECT * FROM Alumno
SELECT * FROM Matriculado
SELECT * FROM Asignatura
CREATE VIEW Repetidores AS SELECT A.nombre,A.dni 
FROM Alumno AS A INNER JOIN Matriculado AS M ON A.dni = M.dni 
INNER JOIN Asignatura AS ASI ON M.cod = ASI.cod 
WHERE M.repe > 0;

2.

CREATE VIEW AsignaturasRepetidores AS 
SELECT A.cod AS CodigoAsignatura,A.nombre AS NombreAsignatura 
FROM Asignatura AS A INNER JOIN Matriculado AS M ON A.cod = M.cod 
INNER JOIN Alumno AS AL ON M.dni = AL.dni
WHERE AL.dni IN (SELECT dni FROM Alumno)
ORDER BY A.cod DESC;

3.