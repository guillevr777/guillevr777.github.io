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

--6 Funci�n que calcule el promedio de una serie de valores. Los par�metros de la funci�n se pasar�n de forma �1,2,3,4�.�:

CREATE OR ALTER FUNCTION dbo.CalcularPromedioDesdeCadena(
    @Valores NVARCHAR(MAX)
)
RETURNS FLOAT
AS
BEGIN
    DECLARE @Promedio FLOAT;

    SELECT @Promedio = AVG(TRY_CAST(value AS FLOAT))
    FROM STRING_SPLIT(@Valores, ',')

    RETURN ISNULL(@Promedio, 0);
END

SELECT dbo.CalcularPromedioDesdeCadena('1,2,3,4,5') AS Promedio;

--7. OBTENER LOS DETALLES DE PEDIDOS DE  TODOS LOS CLIENTES. Obtener el identificador de la orden, el nombre del producto, la cantidad pedida y el nombre de la compa��ia.:

CREATE OR ALTER FUNCTION dbo.DetallesPedidos()
RETURNS TABLE
AS
RETURN
(
    SELECT 
        od.OrderID AS PedidoID,
        p.ProductName AS Producto,
        od.Quantity AS Cantidad,
        c.CompanyName AS Compa��a
    FROM [Order Details] od
    INNER JOIN Products p ON od.ProductID = p.ProductID
    INNER JOIN Orders o ON od.OrderID = o.OrderID
    INNER JOIN Customers c ON o.CustomerID = c.CustomerID
);

SELECT * FROM dbo.DetallesPedidos();

--8. OBTENER VENTAS MENSUALES POR CATEGOR�A. Mostrar por cada a�o y mes, el nombre de la categor�a y la cantidad de ventas realizadas.:

CREATE OR ALTER FUNCTION dbo.VentasMensualesPorCategoria()
RETURNS TABLE
AS
RETURN
(
    SELECT 
        YEAR(O.OrderDate) AS A�o,
        MONTH(O.OrderDate) AS Mes,
        C.CategoryName AS Categor�a,
        SUM(OD.Quantity * OD.UnitPrice * (1 - OD.Discount)) AS TotalVentas
    FROM 
        Orders O
    INNER JOIN [Order Details] OD ON O.OrderID = OD.OrderID
    INNER JOIN Products P ON OD.ProductID = P.ProductID
    INNER JOIN Categories C ON P.CategoryID = C.CategoryID
    GROUP BY 
        YEAR(O.OrderDate), MONTH(O.OrderDate), C.CategoryName
);

SELECT * FROM dbo.VentasMensualesPorCategoria();

--9. OBTENER RESUMEN SEMANAL DE VENTAS. Queremos mostrar por cada semana, las ventas realizadas. Ejemplo: 1    500
        --2   200:

CREATE OR ALTER FUNCTION dbo.ResumenVentasSemanales()
RETURNS TABLE
AS
RETURN
(
    SELECT 
        DATEPART(WEEK, O.OrderDate) AS Semana,
        SUM(OD.Quantity * OD.UnitPrice * (1 - OD.Discount)) AS TotalVentas
    FROM Orders O
    INNER JOIN [Order Details] OD ON O.OrderID = OD.OrderID
    GROUP BY DATEPART(WEEK, O.OrderDate)
);

SELECT * FROM dbo.ResumenVentasSemanales();

--10. OBTENER LOS 10 PRODUCTOS M�S VENDIDOS:

CREATE OR ALTER FUNCTION dbo.Top10ProductosMasVendidos()
RETURNS @Tabla TABLE (
    ProductID INT,
    ProductName NVARCHAR(100),
    TotalVendido INT
)
AS
BEGIN
    INSERT INTO @Tabla
    SELECT TOP 10 
        P.ProductID, 
        P.ProductName, 
        SUM(OD.Quantity) AS TotalVendido
    FROM Products P
    INNER JOIN [Order Details] OD ON OD.ProductID = P.ProductID
    GROUP BY P.ProductID, P.ProductName
    ORDER BY TotalVendido DESC

    RETURN
END


SELECT * FROM dbo.Top10ProductosMasVendidos();
