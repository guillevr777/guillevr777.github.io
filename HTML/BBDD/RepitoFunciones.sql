
--FUNCIONES

--Usar la BD TransactSQL
 
--1. Pasar a May�sculas un nombre y apellido pasado por par�metro */

	CREATE OR ALTER FUNCTION dbo.Mayus (@Nombre VARCHAR(MAX), @Apellido VARCHAR(MAX))
	RETURNS VARCHAR(MAX)
	BEGIN
		DECLARE @NombreRevez VARCHAR(MAX)
		SET @NombreRevez = UPPER(@Nombre + ' ' + @Apellido)
		RETURN @NombreRevez
	END

	SELECT dbo.Mayus ('guillermo','villanueva');

--2. Pasar el n�mero del d�a (lunes 1, domingo 7) y devolver el texto Lunes, Martes...

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

--3. Crear una funcion a la que pasar dos n�meros y realizar la 
--suma

--4. Dise�e un programa que calcule la suma de las cifras de un 
--n�mero sin importar cu�ntas cifras tenga el n�mero.
 
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
	
--5.Dise�e un programa que reciba un n�mero natural y retorne la 
--suma de sus d�gitos impares.
 
--6-.Dado un n�mero natural de cuatro cifras dise�e una funci�n que permita obtener el rev�s del n�mero. As�, si se lee el n�mero 2385 el programa deber� imprimir 5832.
 
--7. Crear una funci�n que invierta una palabra pasada por  par�metro

