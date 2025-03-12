--Examen
--1.
SELECT * FROM Empleados
SELECT * FROM Departamentos
SELECT E.dni,E.nombre,E.apellidos,D.numd 
FROM Empleados AS E INNER JOIN Departamentos AS D ON E.numd = D.numd 
WHERE D.numd = 5;

--2.
SELECT * FROM Proyectos
SELECT * FROM Trabaja_en
SELECT * FROM Empleados
SELECT * FROM Departamentos
SELECT * FROM Lugares_dptos
SELECT E.nombre,E.direccion,P.nombrep AS NombreProyecto,L.lugar AS LugarDepartamento 
FROM Proyectos AS P 
JOIN Trabaja_en AS T ON P.nump = T.nump 
JOIN Empleados AS E ON T.nump = E.dni 
JOIN Departamentos AS D ON E.numd = D.numd 
JOIN Lugares_dptos AS L ON D.numd = L.numd 
WHERE P.lugarp = 'Sevilla' AND L.lugar != 'Santiago';

--3.
SELECT * FROM Departamentos
SELECT D.numd,D.nombred,AVG(E.salario) AS MediaSalario,COUNT(E.dni) AS NºEmpleados
FROM Departamentos AS D INNER JOIN Empleados AS E ON D.numd = E.numd 
GROUP BY D.numd,D.nombred 
HAVING AVG(E.salario) > 100;

--4.
SELECT * FROM Empleados
SELECT nombre,apellidos,DATEDIFF(YEAR,fechanac,CURRENT_TIMESTAMP) AS Edad,DATEDIFF(YEAR,fechanac,CURRENT_TIMESTAMP) AS AñosParaJubilacion 
FROM Empleados 
GROUP BY nombre,apellidos,fechanac;

--5.
SELECT * FROM Empleados
SELECT * FROM Departamentos
SELECT 'Gerente' + ' ' + nombre + ' ' + apellidos AS NombreCompleto,salario FROM Empleados WHERE dni IN (SELECT dnigte FROM Departamentos);
SELECT 'Empleado' + ' ' + nombre + ' ' + apellidos AS NombreCompleto,salario FROM Empleados WHERE dni NOT IN (SELECT dnigte FROM Departamentos);

--6.
SELECT * FROM Trabaja_en
SELECT * FROM Empleados
SELECT * FROM Departamentos
SELECT * FROM Proyectos
SELECT E.dni,E.nombre,T.horas,COUNT(P.nombrep) AS NºProyectos 
FROM Trabaja_en AS T FULL JOIN Empleados AS E ON T.nump = E.numd 
FULL JOIN Departamentos AS D ON E.numd = D.numd 
FULL JOIN Proyectos AS P ON D.numd = P.numd 
GROUP BY  E.dni,E.nombre,T.horas,P.nombrep;

--7.
SELECT DISTINCT E.nombre 
FROM Empleados AS E 
INNER JOIN Trabaja_en AS T ON E.numd = T.nump 
INNER JOIN Proyectos AS P ON T.nump = P.nump 
WHERE E.numd IN (SELECT numd FROM Proyectos) 
AND E.numd IN (SELECT nump FROM Trabaja_en) AND P.lugarp != 'Camas';

--8.
SELECT * FROM Empleados
SELECT dni,COUNT(dnisuper) AS NºEmpleados 
FROM Empleados 
WHERE dni IN (SELECT dnisuper FROM Empleados) 
GROUP BY dni

--9.
SELECT * FROM Departamentos
SELECT * FROM Empleados
SELECT D.numd,D.nombred,COUNT(E.dni) FROM Empleados AS E INNER JOIN Departamentos AS D ON D.numd = E.numd INNER JOIN Lugares_dptos AS L ON D.numd = L.numd HAVING 3 < COUNT(E.dni IN (SELECT dnigte FROM Departamentos)) AND L.lugar = 'Sevilla';

--10.
UPDATE Departamentos SET nombred = 'Departamento flojillo' WHERE EXISTS (SELECT TOP 1 E.nombre FROM Empleados AS E INNER JOIN Trabaja_en AS T ON E.numd = T.nump ORDER BY T.horas ASC EXCEPT;