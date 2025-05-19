--Sobre la BD Hospital, crea los siguientes procedimientos almacenados para obtener la información necesaria.

--1) Sacar todos los empleados que se dieron de alta entre una determinada fecha inicial y fecha final y que pertenecen a un determinado departamento.

	CREATE OR ALTER PROCEDURE SacarEmpleados (@FechaI DATE, @FechaF DATE, @Dept INT)
	AS
	BEGIN
		SELECT * FROM Emp WHERE Fecha_Alt BETWEEN @FechaI AND @FechaF AND Dept_No = @Dept
	END

	EXEC SacarEmpleados '1981-11-17','1983-11-19',20;

	SELECT * FROM Emp

--2) Crear procedimiento que inserte un empleado. 

	CREATE OR ALTER PROCEDURE InsertarEmp (@Emp_No INT, @Apellido VARCHAR(MAX), @Oficio VARCHAR(MAX), @Dir INT, @Fecha_Alt DATE, @Salario DECIMAL(10,2), @Comision DECIMAL(10,2), @Dept_No INT)
	AS
	BEGIN
		INSERT INTO Emp VALUES (@Emp_No,@Apellido,@Oficio,@Dir,@Fecha_Alt,@Salario,@Comision,@Dept_No);
	END

	EXEC InsertarEmp 7777,'VILLANUEVA','DIRECTOR',7777,'2025-04-26',2600.00,1000.00,20;

--3) Crear un procedimiento que recupere el nombre, número de departamento y número de personas a partir del número de departamento.

	CREATE OR ALTER PROCEDURE Recuperar (@Dept INT)
	AS
	BEGIN
		SELECT D.DNombre AS Nombre, D.Dept_No AS Departamento, COUNT(E.Dept_No) AS Empleados FROM Emp E INNER JOIN Dept D ON E.Dept_No = D.Dept_No WHERE E.Dept_No = @Dept
		GROUP BY D.DNombre,D.Dept_No,E.Dept_No;
	END

	EXEC Recuperar 20;

--4) Crear un procedimiento igual que el anterior, pero que recupere también las personas que trabajan en dicho departamento, pasándole como parámetro el nombre.

	CREATE OR ALTER PROCEDURE RecuperarPersonas (@DeptNombre VARCHAR(MAX))
	AS
	BEGIN
		SELECT D.DNombre AS Nombre, D.Dept_No AS Departamento, E.Emp_No AS NumEmpleado, E.Apellido AS Empleados FROM Emp E INNER JOIN Dept D ON E.Dept_No = D.Dept_No WHERE D.DNombre = @DeptNombre
	END

	EXEC RecuperarPersonas 'INVESTIGACIÓN';

	SELECT * FROM Dept

--5) Crear procedimiento para devolver salario, oficio y comisión, pasándole el apellido.

	CREATE OR ALTER PROCEDURE DevolverSalario (@DeptApellido VARCHAR(MAX))
	AS
	BEGIN
		SELECT E.Salario, E.Oficio, E.Comision FROM Emp E WHERE E.Apellido = @DeptApellido
	END

	EXEC DevolverSalario 'VILLANUEVA';

	SELECT * FROM Dept

--6) Igual que el anterior, pero si no le pasamos ningún valor, mostrará los datos de todos los empleados.

	CREATE OR ALTER PROCEDURE DevolverSalarioNull (@DeptApellido VARCHAR(MAX))
	AS
	BEGIN
	IF EXISTS (SELECT E.Salario, E.Oficio, E.Comision FROM Emp E WHERE E.Apellido = @DeptApellido)
		SELECT E.Salario, E.Oficio, E.Comision FROM Emp E WHERE E.Apellido = @DeptApellido
	ELSE 
		SELECT E.Salario, E.Oficio, E.Comision FROM Emp E
	END

	EXEC DevolverSalarioNull 'A';

	SELECT * FROM Dept

--7) Crear un procedimiento para mostrar el salario, oficio, apellido y nombre del departamento de todos los empleados que contengan en su apellido el valor que le pasemos como parámetro.

	CREATE OR ALTER PROCEDURE MostrarDatos (@Valor VARCHAR(MAX))
	AS
	BEGIN
			SELECT D.DNombre AS Nombre, E.Apellido AS Empleados, E.Salario, E.Oficio FROM Emp E INNER JOIN Dept D ON E.Dept_No = D.Dept_No WHERE E.Apellido LIKE '%' + @Valor + '%';
	END

	EXEC MostrarDatos 'I';

	SELECT * FROM Dept

--8) Crear un procedimiento que recupere el número departamento, el nombre y número de empleados, dándole como valor el nombre del departamento, si el nombre introducido no es válido, mostraremos un mensaje informativo comunicándolo.

	CREATE OR ALTER PROCEDURE MostrarDatos (@Dept VARCHAR(MAX))
	AS
	BEGIN
		IF EXISTS (SELECT DNombre FROM Dept WHERE DNombre = @Dept)
			SELECT D.Dept_No AS NºDepart, D.DNombre AS Nombre, COUNT(E.Dept_No) AS Empleados FROM Emp E INNER JOIN Dept D ON E.Dept_No = D.Dept_No WHERE D.DNombre = @Dept GROUP BY D.Dept_No,E.Dept_No,D.DNombre;
		ELSE
			PRINT('El departamento introducido no existe.');
	END

	EXEC MostrarDatos 'CONTABILIDAD';

	SELECT * FROM Dept

--AVANZADO: DEJARLA PARA EL FINAL
--9) Crear un procedimiento para devolver dos informes sobre los empleados de la plantilla de un determinado
--hospital, sala, turno (campo T de Plantilla) o función. El informe mostrará primero, número de empleados,
--media del salario, suma del salario y la función, turno, sala u hospital, y segundo, un informe personalizado 
--de cada uno, que muestre código de empleado, apellido y salario. Recibiremos un solo parámetro, 
--que será el nombre del hospital, el nombre de la sala, el turno de la plantilla o la función de la plantilla.

	SELECT * FROM Hospital
	SELECT * FROM Sala
	SELECT * FROM Plantilla
	SELECT * FROM Hospital

	CREATE OR ALTER PROCEDURE Informes (@Dato VARCHAR(MAX))
	AS
	BEGIN
		SELECT COUNT(Empleado_No), AVG(Salario), SUM(Salario), 
		CASE
			WHEN @Dato IN (SELECT Nombre FROM Hospital) THEN 'Hospital: ' + @Dato
			WHEN @Dato IN (SELECT Nombre FROM Sala) THEN 'Sala: ' + @Dato
			WHEN @Dato IN (SELECT T FROM Plantilla) THEN 'Turno: ' + @Dato
			WHEN @Dato IN (SELECT Funcion FROM Plantilla) THEN 'Funcion: ' + @Dato
		END AS Categoria
		FROM Plantilla WHERE Sala_Cod IN (SELECT * FROM Sala WHERE Nombre = @Dato) OR 
						   	 Hospital_Cod IN (SELECT * FROM Sala WHERE Nombre = @Dato) OR 
							 Funcion = @Dato OR 
						   	 T = @Dato;
		SELECT Empleado_No, Apellido, Salario FROM Plantilla
	END

--Nº 10 avanzada DEJARLO PARA EL FINAL

--10) Crear un procedimiento en el que pasaremos como parámetro el Apellido de un empleado. 
--El procedimiento devolverá los subordinados del empleado escrito, si el empleado no existe en la base de datos,
--informaremos de ello, si el empleado no tiene subordinados, lo informa remos con un mensaje y mostraremos su jefe. 
--Mostrar el número de empleado, Apellido, Oficio y Departamento de los subordinados.

	

--11) Crear procedimiento que borre un empleado que coincida con los parámetros indicados (los parámetros serán todos los campos de la tabla empleado).

	CREATE OR ALTER PROCEDURE EliminarEmp (@Emp_No INT, @Apellido VARCHAR(MAX), @Oficio VARCHAR(MAX), @Dir INT, @Fecha_Alt DATE, @Salario DECIMAL(10,2), @Comision DECIMAL(10,2), @Dept_No INT)
	AS
	BEGIN
	IF EXISTS (SELECT * FROM Emp WHERE Emp_No = @Emp_No AND Apellido = @Apellido AND @Oficio = Oficio)
		DELETE FROM Emp WHERE Emp_No = @Emp_No
	ELSE
		PRINT('No existe');
	END

	EXEC EliminarEmp 7777,'VILLANUEVA','DIRECTOR',7777,'2025-04-26',2600.00,1000.00,20;

--12) Modificación del ejercicio anterior, si no se introducen datos correctamente, informar de ello con un mensaje y no realizar la baja:
-- Si el empleado introducido no existe en la base de datos, deberemos informarlo con un mensaje indicando ‘Empleado no existente en la BD, verifique los datos del señor ‘apellidoIntroducido’.
-- Si el empleado existe, pero los datos para eliminarlo son incorrectos, informaremos mostrando los datos reales del empleado junto con los datos introducidos por el usuario, para que se vea el fallo.

	CREATE OR ALTER PROCEDURE EliminarEmp (@Emp_No INT, @Apellido VARCHAR(MAX), @Oficio VARCHAR(MAX), @Dir INT, @Fecha_Alt DATE, @Salario DECIMAL(10,2), @Comision DECIMAL(10,2), @Dept_No INT)
	AS
	BEGIN
	IF EXISTS (SELECT * FROM Emp WHERE Emp_No = @Emp_No OR Apellido = @Apellido OR Oficio = @Oficio OR Dir = @Dir OR Fecha_Alt = @Fecha_Alt OR Salario = @Salario OR Comision = @Comision OR Dept_No = @Dept_No)
		IF EXISTS (SELECT * FROM Emp WHERE Emp_No = @Emp_No AND Apellido = @Apellido AND Oficio = @Oficio AND Dir = @Dir AND Fecha_Alt = @Fecha_Alt AND Salario = @Salario AND Comision = @Comision AND Dept_No = @Dept_No)
			DELETE FROM Emp WHERE Emp_No = @Emp_No
		ELSE
		BEGIN
			PRINT('Los datos no coinciden :');
			SELECT * FROM Emp WHERE Emp_No = @Emp_No;
		END
	ELSE
		PRINT('No existe');
	END

	EXEC EliminarEmp 7777,'SERRA','DIRECTOR',7777,'2025-04-26',2600.00,1000.00,20;

	SELECT * FROM Emp

--13) Crear un procedimiento para insertar un empleado de la plantilla del Hospital.
--Para poder insertar el empleado realizaremos restricciones:
-- No podrá estar repetido el número de empleado.
-- Para insertar, lo haremos por el nombre del hospital y por el nombre de sala, si no existe
--la sala o el hospital, no insertaremos y lo informaremos.
-- Para insertar la función de la plantilla deberá estar entre los que hay en la base de datos, al igual que el Turno.
-- El salario no superará las 500.000 euros.

SELECT * FROM Hospital
SELECT * FROM Sala
SELECT * FROM Plantilla
SELECT * FROM Hospital

	CREATE OR ALTER PROCEDURE InsertarEmpleado (@Emp_No INT, @Sala INT, @Hospital INT, @Apellido VARCHAR(MAX), @Funcion VARCHAR(MAX), @T CHAR, @Salario MONEY)
	AS
	BEGIN
		IF @Salario < 500000
			IF EXISTS (SELECT * FROM Hospital WHERE Hospital_Cod = @Hospital) AND EXISTS (SELECT * FROM Sala WHERE Sala_Cod = @Sala)
				IF EXISTS (SELECT * FROM Plantilla WHERE Empleado_No = @Emp_No)
					PRINT('El numero del empleado se encuentra ya en la BBDD');
				ELSE
				BEGIN
				PRINT('El empleado se añadio a la BBDD');
				INSERT INTO Plantilla VALUES (@Emp_No,@Sala,@Hospital,@Apellido,@Funcion,@T,@Salario);
				END
			ELSE
				PRINT('El hospital o sala no existen');
		ELSE
			PRINT('Tas pasao con el salario crack');

	END

	EXEC InsertarEmpleado 22,3,18,'VILLANUEVA','Enfermero','T',50000;

