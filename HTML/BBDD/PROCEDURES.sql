
--1) Sacar todos los empleados que se dieron de alta entre una determinada fecha inicial y fecha final y que pertenecen a un determinado departamento.

CREATE PROCEDURE ObtenerEmpleado @FechaInicial DATE, @FechaFinal DATE, @Departamento INT AS
BEGIN
    SELECT * FROM Emp WHERE Fecha_Alt BETWEEN @FechaInicial AND @FechaFinal AND Dept_No = @Departamento;
END

SELECT * FROM Emp;

EXEC ObtenerEmpleado'1980-01-01', '2025-01-01', 20;

--2) Crear procedimiento que inserte un empleado. 

CREATE PROCEDURE Empleado @Apellido VARCHAR(5) AS
BEGIN
	SELECT * FROM Emp WHERE Apellido = @Apellido
END

SELECT * FROM Emp

EXEC Empleado 'SERRA';

--3) Crear un procedimiento que recupere el nombre, número de departamento y número de personas a partir del número de departamento.

CREATE PROCEDURE DatosEmpleado @NumDepartamento INT AS 
BEGIN
SELECT D.Dnombre,D.Dept_No,COUNT(E.Apellido) AS NºPersonas FROM Dept D INNER JOIN Emp E ON D.Dept_No = E.Dept_No WHERE D.Dept_No = @NumDepartamento GROUP BY  D.Dnombre,D.Dept_No;
END

EXEC DatosEmpleado '10';

SELECT * FROM Dept

--4) Crear un procedimiento igual que el anterior, pero que recupere también las personas que trabajan en dicho departamento, pasándole como parámetro el nombre.

CREATE OR ALTER PROCEDURE DatosEmpleado3 @DNombre VARCHAR(12) AS 
BEGIN
SELECT D.Dnombre,D.Dept_No,COUNT(E.Apellido) AS NºPersonas,E.Apellido 
FROM Emp E LEFT JOIN Dept D ON D.Dept_No = E.Dept_No 
WHERE D.DNombre = @DNombre 
GROUP BY  D.Dnombre,D.Dept_No,E.Apellido;
END

EXEC DatosEmpleado3 'CONTABILIDAD';

SELECT * FROM Dept

--5) Crear procedimiento para devolver salario, oficio y comisión, pasándole el apellido.

CREATE PROCEDURE SalarioOficioComision @Apellido VARCHAR(15) AS
BEGIN
SELECT Salario,Oficio,Comision,Apellido FROM Emp WHERE Apellido = @Apellido;
END

EXEC SalarioOficioComision 'SERRA';

--6) Igual que el anterior, pero si no le pasamos ningún valor, mostrará los datos de todos los empleados.

CREATE PROCEDURE SalarioOficioComision2 @Apellido VARCHAR(15) AS
BEGIN
IF @Apellido IS NULL
	SELECT Salario,Oficio,Comision,Apellido FROM Emp;
ELSE 
	SELECT Salario,Oficio,Comision,Apellido FROM Emp WHERE Apellido = @Apellido;
END

EXEC SalarioOficioComision2 'SERRA';

--7) Crear un procedimiento para mostrar el salario, oficio, apellido y nombre del departamento de todos los empleados que contengan en su apellido el valor que le pasemos como parámetro.

CREATE OR ALTER PROCEDURE DATOS7 @Apellido VARCHAR(15) AS
BEGIN
SELECT E.Salario,E.Oficio,E.Apellido,D.DNombre FROM Emp E INNER JOIN Dept D ON E.Dept_No = D.Dept_No WHERE E.Apellido LIKE CONCAT('%',@Apellido,'%');
END

EXEC DATOS7 'S';

--8) Crear un procedimiento que recupere el número departamento, el nombre y número de empleados, dándole como valor el nombre del departamento, si el nombre introducido no es válido, mostraremos un mensaje informativo comunicándolo.

CREATE OR ALTER PROCEDURE ESTA @Nombre VARCHAR(12) AS
BEGIN
IF @Nombre IN (SELECT DNombre FROM Dept)
	SELECT D.Dept_No,D.DNombre,COUNT(E.APELLIDO) FROM Dept D INNER JOIN Emp E ON D.Dept_No = E.Dept_No WHERE D.DNombre = @Nombre GROUP BY D.Dept_No,D.DNombre,E.APELLIDO;
ELSE
	PRINT('NO SE ENCONTRO EL DEPARTAMENTO');
END

EXEC ESTA 'SERRA';

--11) Crear procedimiento que borre un empleado que coincida con los parámetros indicados (los parámetros serán todos los campos de la tabla empleado).

CREATE OR ALTER PROCEDURE Borrar @Num INT, @Apellido VARCHAR(12), @Oficio VARCHAR(12), @Dir INT, @Fecha DATE, @Salario MONEY, @Comision DECIMAL, @NumDepartamento INT AS
BEGIN
DELETE FROM Emp WHERE Emp_No = @Num AND Apellido = @Apellido AND Oficio = @Oficio AND Dir = @Dir AND Fecha_Alt = @Fecha AND Salario = @Salario AND Comision = @Comision AND Dept_No = @NumDepartamento;
END

EXEC Borrar SELECT TOP 1 FROM Emp;

SELECT * FROM Emp

-- 12) Modificación del ejercicio anterior, si no se introducen datos correctamente, informar de ello con un mensaje y no realizar la baja:
-- Si el empleado introducido no existe en la base de datos, deberemos informarlo con un mensaje indicando ‘Empleado no existente en la BD, verifique los datos del señor ‘apellidoIntroducido’.
-- Si el empleado existe, pero los datos para eliminarlo son incorrectos, informaremos mostrando los datos reales del empleado junto con los datos introducidos por el usuario, para que se vea el fallo.

CREATE OR ALTER PROCEDURE BorrarYa @Num INT, @Apellido VARCHAR(12), @Oficio VARCHAR(12), @Dir INT, @Fecha DATE, @Salario MONEY, @Comision DECIMAL, @NumDepartamento INT AS
BEGIN
IF EXISTS (SELECT * FROM Emp WHERE Emp_No = @Num AND Apellido = @Apellido AND Oficio = @Oficio AND Dir = @Dir AND Fecha_Alt = @Fecha AND Salario = @Salario AND Comision = @Comision AND Dept_No = @NumDepartamento)
	BEGIN
	DELETE FROM Emp WHERE Emp_No = @Num
	PRINT ('Se elimino con exito de la BBDD.')
	END
ELSE IF EXISTS (SELECT * FROM Emp WHERE Emp_No = @Num)
	BEGIN
	DECLARE @NS VARCHAR(100)
	SET @NS = (SELECT * FROM Emp WHERE Emp_No = @Num)
	PRINT('El usuario no coincide , ' + @NS);
	END
ELSE 
	BEGIN
	PRINT('No se encontro la consulta en la BBDD.')
	END
END

ROLLBACK
BEGIN
EXEC BorrarYa 7119,'SERRA','DIRECTOR',7782,'1983-11-19 00:00:00',225000.00,39000.00,20;
END

EXEC BorrarYa 7119,'SERRA','MACETA',7782,'1983-11-19 00:00:00',225000.00,39000.00,20;

--13) Crear un procedimiento para insertar un empleado de la plantilla del Hospital.
--Para poder insertar el empleado realizaremos restricciones:
--No podrá estar repetido el número de empleado.
--Para insertar, lo haremos por el nombre del hospital y por el nombre de sala, si no existe
--la sala o el hospital, no insertaremos y lo informaremos.
--Para insertar la función de la plantilla deberá estar entre los que hay en la base de datos, al igual que el Turno.
--El salario no superará las 500.000 euros.

SELECT * FROM Plantilla
CREATE PROCEDURE InsertarHospital @Empleado_No INT, @Sala_Cod INT, @Hospital_Cod INT, @Apellido VARCHAR, @Funcion VARCHAR, @T VARCHAR, @Salario MONEY, @Code INT AS
