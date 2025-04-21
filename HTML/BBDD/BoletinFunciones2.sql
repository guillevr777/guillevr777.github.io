--Se usará la BD Nortwind
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

--2. CÁLCULO DE FIBONACCI. A partir de un número obtener la sucesión de Fibonacci hasta ese número (en la sucesión de Fibonacci, el siguiente número es la suma de los dos anteriores): En la sucesión de fibonacci los dos primeros números son 1 y luego la suma de los dos anteriores. 1, 1, 2, 3, 5, 8, 13, 21....

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

--3. OBTENER DESCUENTO MÁXIMO POR CATEGORÍA:

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

--4.Obtener los DÍAS LABORABLES ENTRE DOS FECHAS:

CREATE OR ALTER FUNCTION dbo.EntreFechas(@FechaInicio DATE, @FechaFin DATE)
RETURNS INT
AS
BEGIN
    DECLARE @DiasLaborables INT = 0

    WHILE @FechaInicio <= @FechaFin
	BEGIN
	IF DATENAME(WEEKDAY, @FechaInicio) NOT IN ('Saturday','Sunday')
		BEGIN
            SET @DiasLaborables += 1;
        END
        SET @FechaInicio = DATEADD(DAY, 1, @FechaInicio);
    END

    RETURN @DiasLaborables
END

SELECT dbo.EntreFechas('2025-04-01', '2025-04-10') AS DiasLaborables;

--5. OBTENER TOTAL DE PEDIDOS POR CLIENTE:

CREATE OR ALTER FUNCTION dbo.TotalPedidos(@CustomerName VARCHAR(MAX))
RETURNS INT
AS
BEGIN
	DECLARE @Cantidad INT = 0
	SET @Cantidad = (SELECT COUNT(O.OrderID) FROM Customers C INNER JOIN Orders O ON C.CustomerID = O.CustomerID WHERE C.ContactName = @CustomerName);

	RETURN @Cantidad
END

SELECT dbo.TotalPedidos('Maria Anders') AS TotalPedidosCliente;

--6 Función que calcule el promedio de una serie de valores. Los parámetros de la función se pasarán de forma ‘1,2,3,4….’:



--7. OBTENER LOS DETALLES DE PEDIDOS DE  TODOS LOS CLIENTES. Obtener el identificador de la orden, el nombre del producto, la cantidad pedida y el nombre de la compañçia.:

CREATE OR ALTER FUNCTION dbo.DetallesPedidos()
RETURNS TABLE
AS
RETURN
(
    SELECT 
        O.OrderID AS PedidoID,
        P.ProductName AS Producto,
        O.Quantity AS Cantidad,
        S.CompanyName AS Compañía
    FROM [Order Details] O
    INNER JOIN Products P ON O.ProductID = P.ProductID
    INNER JOIN Suppliers S ON P.SupplierID = S.SupplierID
)

SELECT dbo.DetallesPedidos()

--8. OBTENER VENTAS MENSUALES POR CATEGORÍA. Mostrar por cada año y mes, el nombre de la categoría y la cantidad de ventas realizadas.:

CREATE OR ALTER FUNCTION dbo.Ventas(@Categoria VARCHAR(MAX))
RETURNS VARCHAR(MAX)
BEGIN
	DECLARE @Resultado VARCHAR(MAX)

	SELECT @Resultado = SELECT  FROM Orders O INNER JOIN [Order Details] OD ON O.OrderID = OD.OrderID INNER JOIN Products P ON OD.ProductID = P.ProductID INNER JOIN Categories C ON P.CategoryID = C.CategoryID WHERE C.CategoryName = @Categoria
	
	RETURN @Resultado
END

SELECT * FROM Categories

EXEC dbo.Ventas('Confections')

--9. OBTENER RESUMEN SEMANAL DE VENTAS. Queremos mostrar por cada semana, las ventas realizadas. Ejemplo: 1    500
        --2   200:

--10. OBTENER LOS 10 PRODUCTOS MÁS VENDIDOS:



