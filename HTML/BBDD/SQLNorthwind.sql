
--1. Nombre del país y número de clientes de cada país, ordenados alfabéticamente por el nombre del país.

SELECT Country, COUNT(CustomerID) AS Numero_Clientes FROM Customers GROUP BY Country ORDER BY Country ASC;

--2. ID de producto y número de unidades vendidas de cada producto (El número de unidades las obtenemos del campo Quantity de Order Detail.

SELECT ProductID, SUM(Quantity) AS Total_Unidades_Vendidas FROM [ORDER DETAILS] GROUP BY ProductID ORDER BY ProductID DESC;

--3. ID del cliente y número de pedidos que nos ha hecho.

SELECT CustomerID, COUNT(OrderID) AS NumPedidos FROM Orders GROUP BY CustomerID;

--4. ID del cliente, año y número de pedidos que nos ha hecho cada año.

SELECT CustomerID, YEAR(OrderDate) AS Anio, COUNT(OrderID) AS NumPedidos FROM Orders GROUP BY CustomerID, YEAR(OrderDate) ORDER BY CustomerID, Anio;

--5. ID del producto, precio unitario y total facturado de ese producto, ordenado por cantidad facturada de mayor a menor. Si hay varios precios unitarios para el mismo producto tomaremos el mayor.

SELECT od.ProductID, MAX(od.UnitPrice) AS PrecioUnitario, SUM(od.Quantity * od.UnitPrice) AS TotalFacturad FROM [Order Details] od GROUP BY od.ProductID ORDER BY TotalFacturado DESC;

--6. ID del proveedor e importe total del stock acumulado de productos correspondientes a ese proveedor.

SELECT SupplierID, SUM(UnitsInStock * UnitPrice) AS ImporteTotalStock FROM Products GROUP BY SupplierID;

--7. Número de pedidos registrados mes a mes de cada año.

SELECT YEAR(OrderDate) AS Anio, MONTH(OrderDate) AS Mes, COUNT(OrderID) AS NumPedidos FROM Orders GROUP BY YEAR(OrderDate), MONTH(OrderDate) ORDER BY Anio, Mes;

--8. Año y tiempo medio transcurrido entre la fecha de cada pedido (OrderDate) y la fecha en la que lo hemos enviado (ShipDate), en días para cada año.

SELECT YEAR(OrderDate) AS Anio, AVG(DATEDIFF(DAY, OrderDate, ShippedDate)) AS TiempoMedioDias FROM Orders WHERE ShippedDate IS NOT NULL GROUP BY YEAR(OrderDate) ORDER BY Anio;

--9. ID del distribuidor y número de pedidos enviados a través de ese distribuidor.

SELECT ShipperID, COUNT(OrderID) AS NumPedidos FROM Orders GROUP BY ShipperID;

--10. ID de cada proveedor y número de productos distintos que nos suministra.

SELECT SupplierID, COUNT(DISTINCT ProductID) AS NumProductos FROM Products GROUP BY SupplierID;