
--1) Sacar todos los empleados que se dieron de alta entre una determinada fecha inicial y fecha final y que pertenecen a un determinado departamento.

CREATE PROCEDURE ObtenerEmpleado @FechaInicial DATE, @FechaFinal DATE, @Departamento INT AS
BEGIN
    SELECT * FROM Emp WHERE Fecha_Alt BETWEEN @FechaInicial AND @FechaFinal AND Dept_No = @Departamento;
END

SELECT * FROM Emp;

EXEC ObtenerEmpleado'1980-01-01', '2025-01-01', 20;

-- Crear procedimiento que inserte un empleado. 

CREATE PROCEDURE Empleado @Apellido VARCHAR(5) AS
BEGIN
	SELECT * FROM Emp WHERE Apellido = @Apellido
END

SELECT * FROM Emp

EXEC Empleado 'SERRA';