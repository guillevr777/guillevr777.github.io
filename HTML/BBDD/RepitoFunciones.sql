
--FUNCIONES

--Usar la BD TransactSQL
 
--1. Pasar a Mayúsculas un nombre y apellido pasado por parámetro */

	CREATE OR ALTER FUNCTION dbo.Mayus (@Nombre VARCHAR(MAX), @Apellido VARCHAR(MAX))
	RETURNS VARCHAR(MAX)
	BEGIN
		DECLARE @NombreRevez VARCHAR(MAX)
		SET @NombreRevez = UPPER(@Nombre + ' ' + @Apellido)
		RETURN @NombreRevez
	END

	SELECT dbo.Mayus ('guillermo','villanueva');

--2. Pasar el número del día (lunes 1, domingo 7) y devolver el texto Lunes, Martes...

	CREATE OR ALTER FUNCTION dbo.Dia (@Numero INT)
	RETURNS VARCHAR(MAX)
	BEGIN
		DECLARE @Resultado VARCHAR(MAX)
		SET @Resultado =
			CASE @Numero
				WHEN 1 THEN 'Lunes'
				WHEN 2 THEN 'Martes'
				WHEN 3 THEN 'Miercoles'
				WHEN 4 THEN 'Jueves'
				WHEN 5 THEN 'Viernes'
			END
		RETURN @Resultado
	END

	SELECT dbo.Dia (2)

--3. Crear una funcion a la que pasar dos números y realizar la 
--suma

--4. Diseñe un programa que calcule la suma de las cifras de un 
--número sin importar cuántas cifras tenga el número.
 
	CREATE OR ALTER FUNCTION dbo.Sumar (@Numero INT)
	RETURNS INT
	BEGIN
		DECLARE @Copia INT = @Numero
		DECLARE @Operacion INT
		DECLARE @Resultado INT = 0
		WHILE @Copia > 0
		BEGIN
			SET @Operacion = @Copia % 10;
			SET @Resultado += @Operacion;
			SET @Copia = @Copia / 10;
		END
		RETURN @Resultado
	END

	SELECT dbo.Sumar (123);
	
--5.Diseñe un programa que reciba un número natural y retorne la 
--suma de sus dígitos impares.
 
--6-.Dado un número natural de cuatro cifras diseñe una función que permita obtener el revés del número. Así, si se lee el número 2385 el programa deberá imprimir 5832.
 
--7. Crear una función que invierta una palabra pasada por  parámetro

