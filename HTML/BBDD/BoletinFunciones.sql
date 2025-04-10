--FUNCIONES

--Usar la BD TransactSQL
 
--1. Pasar a May�sculas un nombre y apellido pasado por par�metro 

CREATE OR ALTER FUNCTION dbo.PasarAMayusculas(@Nombre NVARCHAR(100), @Apellido NVARCHAR(100))
RETURNS NVARCHAR(200)
AS
BEGIN
    DECLARE @Resultado NVARCHAR(200)

    SET @Resultado = UPPER(@Nombre + ' ' + @Apellido)

    RETURN @Resultado
END

SELECT dbo.PasarAMayusculas('guillermo','carrascoza') AS NombreCompleto

--2. Pasar el n�mero del d�a (lunes 1, domingo 7) y devolver el texto Lunes, Martes...

CREATE OR ALTER FUNCTION dbo.DiaANumero (@Dia INT)
RETURNS VARCHAR(10)
AS
BEGIN
	DECLARE @Resultado VARCHAR(10)
	SET @Resultado = CASE
		WHEN @DIA = 1 THEN 'LUNES'
		WHEN @DIA = 2 THEN 'MARTES'
		WHEN @DIA = 3 THEN 'MIERCOLES'
		WHEN @DIA = 4 THEN 'JUEVES'
		WHEN @DIA = 5 THEN 'VIERNES'
		WHEN @DIA = 6 THEN 'SABADO' 
		WHEN @DIA = 7 THEN 'DOMINGO'
		END
	RETURN @Resultado
END

SELECT dbo.DiaANumero(3) AS Dia

--3. Crear una funcion a la que pasar dos n�meros y realizar la 
--suma

CREATE OR ALTER FUNCTION dbo.Suma (@Num1 INT, @Num2 INT)
RETURNS INT
AS
BEGIN
	DECLARE @Resultado INT
	SET @Resultado = @Num1 + @Num2
	RETURN @Resultado
END

SELECT dbo.Suma(1,2) AS Suma

--4. Dise�e un programa que calcule la suma de las cifras de un 
--n�mero sin importar cu�ntas cifras tenga el n�mero.
 
CREATE OR ALTER FUNCTION dbo.SumaCifras (@Numero INT)
RETURNS INT
AS
BEGIN
	DECLARE @Resultado INT = 0
	DECLARE @Digito INT
	
	WHILE @Numero > 0
    BEGIN
        SET @Digito = @Numero % 10
        SET @Resultado = @Resultado + @Digito
        SET @Numero = @Numero / 10
    END

	RETURN @Resultado
END

SELECT dbo.SumaCifras(245) AS SumaCifras

--5.Dise�e un programa que reciba un n�mero natural y retorne la 
--suma de sus d�gitos impares.

CREATE OR ALTER FUNCTION dbo.RetornoSumaDigitos (@Numero INT)
RETURNS INT
AS
BEGIN
	DECLARE @Resultado INT = 0
	DECLARE @Digito INT
	
	WHILE @Numero > 0
    BEGIN
        SET @Digito = @Numero % 10
		IF @Digito % 2 != 0
		  SET @Resultado = @Resultado + @Digito

        SET @Numero = @Numero / 10
    END

	RETURN @Resultado
END

SELECT dbo.RetornoSumaDigitos(245) AS SumaCifras
 
--6.Dado un n�mero natural de cuatro cifras dise�e una funci�n que permita obtener el rev�s del n�mero. As�, si se lee el n�mero 2385 el programa deber� imprimir 5832.
 
 CREATE OR ALTER FUNCTION dbo.NaturalDelRevez (@Numero INT)
RETURNS INT
AS
BEGIN
	DECLARE @Resultado INT = 0
	DECLARE @Digito INT
	
	WHILE @Numero > 0
    BEGIN
        SET @Digito = @Numero % 10
        SET @Resultado = CAST(@Resultado AS Varchar) + CAST(@Digito AS Varchar)
        SET @Numero = @Numero / 10
    END

	RETURN @Resultado
END

SELECT dbo.NaturalDelRevez(245) AS SumaCifras

--7. Crear una funci�n que invierta una palabra pasada por  par�metro

 CREATE OR ALTER FUNCTION dbo.PalabraDelRevez (@Palabra Varchar(100))
RETURNS Varchar(100)
AS
BEGIN
	DECLARE @Resultado Varchar(100) = ''
	DECLARE @Letra Int = LEN(@Palabra)
	
	WHILE @Letra > 0
    BEGIN
        SET @Resultado = @Resultado + SUBSTRING(@Palabra,@Letra,1)
		SET @Letra = @Letra - 1
    END

	RETURN @Resultado
END

SELECT dbo.PalabraDelRevez('Mantequilla') AS SumaCifras
