

--2. ID de producto y número de unidades vendidas de cada producto.  Añade el nombre del producto

SELECT * FROM [Order Details]
SELECT * FROM Products
SELECT P.ProductID, P.ProductName, O.Quantity FROM Products AS P INNER JOIN [Order Details] AS O ON P.ProductID = O.ProductID;

--3. ID del cliente y número de pedidos que nos ha hecho. Añade nombre (CompanyName) y ciudad del cliente

SELECT * FROM Customers
SELECT * FROM Orders
SELECT C.CustomerID,C.CompanyName,C.City,COUNT(O.OrderID) AS OrderCount FROM Customers AS C INNER JOIN  Orders AS O ON C.CustomerID = O.CustomerID GROUP BY C.CustomerID, C.CompanyName, C.City


--4. ID del cliente, año y número de pedidos que nos ha hecho cada año. Añade nombre (CompanyName) y ciudad del cliente, así como la fecha del primer pedido que nos hizo.

SELECT * FROM Customers
SELECT * FROM Orders
SELECT C.CustomerID,C.CompanyName,C.City,YEAR(O.OrderDate) AS Año,MIN(O.OrderDate) AS PrimerPedido,O.OrderID FROM Customers AS C INNER JOIN Orders AS O ON C.CustomerID = O.CustomerID GROUP BY C.CustomerID,C.CompanyName,C.City,O.OrderID,O.OrderDate

--5. ID del producto, precio unitario y total facturado de ese producto, ordenado por cantidad facturada de mayor a menor. Si hay varios precios unitarios para el mismo producto tomaremos el mayor. Añade el nombre del producto

SELECT * FROM Products
SELECT * FROM [Order Details]

SELECT  P.ProductID,MAX(O.UnitPrice),SUM(O.Quantity*O.UnitPrice) AS TotalFacturado,P.ProductName 
FROM Products AS P INNER JOIN [Order Details] AS O 
ON P.UnitPrice = O.UnitPrice 
AND P.ProductID = O.ProductID 
GROUP BY P.ProductID,O.UnitPrice,O.Quantity,P.ProductName 
ORDER BY TotalFacturado DESC

--6. ID del proveedor e importe total del stock acumulado de productos correspondientes a ese proveedor. Añade el nombre del proveedor

SELECT * FROM Suppliers
SELECT * FROM Products
SELECT S.SupplierID,S.CompanyName,P.UnitsInStock FROM Products AS P INNER JOIN Suppliers AS S ON P.SupplierID = S.SupplierID GROUP BY S.SupplierID,S.CompanyName,P.UnitsInStock

--9. ID del distribuidor y número de pedidos enviados a través de ese distribuidor. Añade el nombre del distribuidor

SELECT * FROM Shippers
SELECT * FROM Orders
SELECT S.ShipperID,S.CompanyName,COUNT(O.OrderID) AS NºPedido FROM Shippers AS S INNER JOIN Orders AS O ON S.ShipperID = O.ShipVia GROUP BY S.ShipperID,O.OrderID,S.CompanyName

--10. ID de cada proveedor y número de productos distintos que nos suministra. Añade el nombre del proveedor.

SELECT * FROM Suppliers
SELECT * FROM Products
SELECT S.SupplierID,S.CompanyName,COUNT(P.ProductID) AS NºProductos FROM Suppliers AS S LEFT JOIN Products AS P ON S.SupplierID = P.SupplierID GROUP BY S.SupplierID,S.CompanyName