
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

CREATE OR ALTER PROCEDURE SalarioOficioComision2 @Apellido VARCHAR(15) = null AS
BEGIN
IF @Apellido IS NULL
	SELECT Salario,Oficio,Comision,Apellido FROM Emp WHERE Apellido = @Apellido;
ELSE 
	SELECT Salario,Oficio,Comision,Apellido FROM Emp WHERE Apellido = @Apellido;
END

EXEC SalarioOficioComision2 '';

--7) Crear un procedimiento para mostrar el salario, oficio, apellido y nombre del departamento de todos los empleados que contengan en su apellido el valor que le pasemos como parámetro.

CREATE OR ALTER PROCEDURE DATOS7 @Apellido VARCHAR(15) AS
BEGIN
SELECT E.Salario,E.Oficio,E.Apellido,D.DNombre FROM Emp E INNER JOIN Dept D ON E.Dept_No = D.Dept_No WHERE E.Apellido LIKE('%'+ @Apellido + '%');
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
 IF EXISTS (SELECT 1 FROM Emp  WHERE Emp_No = @Num AND Apellido = @Apellido  AND Oficio = @Oficio  AND Dir = @Dir 
        AND Fecha_Alt = @Fecha AND Salario = @Salario  AND Comision = @Comision  AND Dept_No = @NumDepartamento)
    BEGIN
        DELETE FROM Emp WHERE Emp_No = @Num AND Apellido = @Apellido AND Oficio = @Oficio AND Dir = @Dir 
        AND Fecha_Alt = @Fecha AND Salario = @Salario AND Comision = @Comision AND Dept_No = @NumDepartamento;
        PRINT 'Empleado eliminado correctamente.'
    END
    ELSE
    BEGIN
        PRINT 'No se encontro ningun empleado con esos datos.'
    END
END

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

CREATE PROCEDURE InsertarEmpleadoPlantilla @Empleado_No INT, @NombreHospital NVARCHAR(255), @NombreSala NVARCHAR(255), @Apellido NVARCHAR(255), @Funcion NVARCHAR(255), @Turno NVARCHAR(50), @Salario DECIMAL(10,2) AS
BEGIN
    DECLARE @Hospital_Cod INT, @Sala_Cod INT;
    SELECT @Hospital_Cod = h.Hospital_Cod, @Sala_Cod = s.Sala_Cod
    FROM Hospital h
    JOIN Sala s ON h.Hospital_Cod = s.Hospital_Cod AND s.Nombre = @NombreSala
    WHERE h.Nombre = @NombreHospital;
    IF @Hospital_Cod IS NULL OR @Sala_Cod IS NULL
    BEGIN
        PRINT 'Error: Hospital o sala no existen.';
        RETURN;
    END
    IF NOT EXISTS (SELECT 1 FROM Plantilla WHERE Empleado_No = @Empleado_No) AND
       EXISTS (SELECT 1 FROM Plantilla WHERE Funcion = @Funcion) AND
       EXISTS (SELECT 1 FROM Plantilla WHERE T = @Turno) AND
       @Salario <= 500000
    BEGIN
        INSERT INTO Plantilla (Empleado_No, Sala_Cod, Hospital_Cod, Apellido, Funcion, T, Salario)
        VALUES (@Empleado_No, @Sala_Cod, @Hospital_Cod, @Apellido, @Funcion, @Turno, @Salario);
        PRINT 'Empleado insertado correctamente.';
    END
    ELSE
        PRINT 'Error: Empleado duplicado, función/turno inválidos o salario excede el límite.';
END

EXEC InsertarEmpleadoPlantilla 9000, 'San Carlos', 'Cardiología', 'Fernández P.', 'Enfermero', 'T', 180000;

SELECT * FROM Plantilla
SELECT * FROM Hospital
SELECT * FROM Sala

--9) Crear un procedimiento para devolver dos informes sobre los empleados de la plantilla de un determinado hospital, sala, turno (campo T de Plantilla) o función. El informe mostrará primero, número de empleados, media del salario, suma del salario y la función, turno, sala u hospital, y segundo, un informe personalizado de cada uno, que muestre código de empleado, apellido y salario. Recibiremos un solo parámetro, que será el nombre del hospital, el nombre de la sala, el turno de la plantilla o la función de la plantilla.

CREATE PROCEDURE GenerarInformeEmpleados @Filtro NVARCHAR(255) AS
BEGIN
    SELECT COUNT(*) AS Numero_Empleados, AVG(Salario) AS Media_Salario, SUM(Salario) AS Suma_Salario, Funcion, T AS Turno, s.Nombre AS Sala, h.Nombre AS Hospital
    FROM Plantilla p JOIN Sala s ON p.Sala_Cod = s.Sala_Cod JOIN Hospital h ON p.Hospital_Cod = h.Hospital_Cod
    WHERE h.Nombre = @Filtro OR s.Nombre = @Filtro OR p.T = @Filtro OR p.Funcion = @Filtro
    GROUP BY Funcion, T, s.Nombre, h.Nombre;
    PRINT 'Informe Resumen generado.';
    SELECT Empleado_No, Apellido, Salario
    FROM Plantilla p JOIN Sala s ON p.Sala_Cod = s.Sala_Cod JOIN Hospital h ON p.Hospital_Cod = h.Hospital_Cod
    WHERE h.Nombre = @Filtro OR s.Nombre = @Filtro OR p.T = @Filtro OR p.Funcion = @Filtro;
    PRINT 'Informe Detallado generado.';
END

EXEC GenerarInformeEmpleados 'San Carlos';
EXEC GenerarInformeEmpleados 'Cardiología';

--10) Crear un procedimiento en el que pasaremos como parámetro el Apellido de un empleado. 
--El procedimiento devolverá los subordinados del empleado escrito, si el empleado no existe en la base de datos,
--informaremos de ello, si el empleado no tiene subordinados, lo informa remos con un mensaje y mostraremos su jefe.
--Mostrar el número de empleado, Apellido, Oficio y Departamento de los subordinados.


CREATE PROCEDURE ObtenerSubordinados @Apellido NVARCHAR(255) AS
BEGIN
    DECLARE @Empleado_No INT, @Jefe_No INT;
    SELECT @Empleado_No = Empleado_No
    FROM Plantilla
    WHERE Apellido = @Apellido;
    IF @Empleado_No IS NULL
    BEGIN
        PRINT 'Error: El empleado no existe en la base de datos.';
    END
    IF EXISTS (SELECT 1 FROM Plantilla WHERE Empleado_No = @Empleado_No)
    BEGIN
        PRINT 'Subordinados del empleado:';
        
    END
    ELSE
    BEGIN
        PRINT 'El empleado no tiene subordinados.';
        IF @Jefe_No IS NOT NULL
        BEGIN
            SELECT Empleado_No, Apellido, Funcion, Sala_Cod
            FROM Plantilla
            WHERE Empleado_No = @Jefe_No;
        END
        ELSE
            PRINT 'Este empleado no tiene jefe.';
    END
END

--NO SE COMO SACAR AL JEFE LA VERDAD...