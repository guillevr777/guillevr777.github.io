--Se usar� la BD Nortwind
--1. OBTENER CANTIDAD DE PRODUCTOS VENDIDOS:

CREATE OR ALTER FUNCTION dbo.ProductosVendidos()
RETURNS INT
AS
BEGIN
    DECLARE @Cantidad INT = 0

    SELECT @Cantidad = SUM(Quantity) FROM [Order Details]

    RETURN @Cantidad
END


SELECT dbo.ProductosVendidos() AS Vendido

--2. C�LCULO DE FIBONACCI. A partir de un n�mero obtener la sucesi�n de Fibonacci hasta ese n�mero (en la sucesi�n de Fibonacci, el siguiente n�mero es la suma de los dos anteriores): En la sucesi�n de fibonacci los dos primeros n�meros son 1 y luego la suma de los dos anteriores. 1, 1, 2, 3, 5, 8, 13, 21....

CREATE OR ALTER FUNCTION dbo.Fibonacci(@Numero INT)
RETURNS Varchar(MAX)
	BEGIN
	DECLARE @CopiaNumero INT = 1
	DECLARE @OtroNumero INT = 1
	DECLARE @Resultado Varchar(MAX) = '1'
		WHILE @OtroNumero <= @Numero
		BEGIN
		 SET @Resultado = @Resultado + ', ' + CAST(@OtroNumero AS VARCHAR)
        
        DECLARE @Temp INT = @OtroNumero
        SET @OtroNumero = @CopiaNumero + @OtroNumero
        SET @CopiaNumero = @Temp
		END
		RETURN @Resultado
	END

SELECT dbo.Fibonacci(30) AS Sucesion

--3. OBTENER DESCUENTO M�XIMO POR CATEGOR�A:

SELECT * FROM [Order Details]
SELECT * FROM Products
SELECT * FROM Categories

CREATE OR ALTER FUNCTION dbo.DescuentoMaximo(@Categoria VARCHAR(100))
RETURNS DECIMAL(5, 2)
AS
BEGIN
    DECLARE @Descuento DECIMAL(5, 2)

    SELECT @Descuento = MAX(O.Discount)
    FROM [Order Details] O
    INNER JOIN Products P ON O.ProductID = P.ProductID
    INNER JOIN Categories C ON P.CategoryID = C.CategoryID
    WHERE C.CategoryName = @Categoria

    RETURN @Descuento
END

SELECT dbo.DescuentoMaximo('Beverages') AS Sucesion

--4.Obtener los D�AS LABORABLES ENTRE DOS FECHAS:

CREATE OR ALTER FUNCTION dbo.EntreFechas()
RETURNS Varchar(MAX)
AS
BEGIN
    DECLARE @Descuento DECIMAL(5, 2)

    SELECT @Descuento = MAX(O.Discount)
    FROM [Order Details] O
    INNER JOIN Products P ON O.ProductID = P.ProductID
    INNER JOIN Categories C ON P.CategoryID = C.CategoryID
    WHERE C.CategoryName = @Categoria

    RETURN @Descuento
END

SELECT dbo.DescuentoMaximo('Beverages') AS Sucesion

--5. OBTENER TOTAL DE PEDIDOS POR CLIENTE:

--6 Funci�n que calcule el promedio de una serie de valores. Los par�metros de la funci�n se pasar�n de forma �1,2,3,4�.�:

--7. OBTENER LOS DETALLES DE PEDIDOS DE  TODOS LOS CLIENTES. Obtener el identificador de la orden, el nombre del producto, la cantidad pedida y el nombre de la compa��ia.:

--8. OBTENER VENTAS MENSUALES POR CATEGOR�A. Mostrar por cada a�o y mes, el nombre de la categor�a y la cantidad de ventas realizadas.:

--9. OBTENER RESUMEN SEMANAL DE VENTAS. Queremos mostrar por cada semana, las ventas realizadas. Ejemplo: 1    500
        --2   200:

--10. OBTENER LOS 10 PRODUCTOS M�S VENDIDOS:



