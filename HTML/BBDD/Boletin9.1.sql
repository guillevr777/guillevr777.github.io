
--Nombre de los proveedores y n�mero de productos que nos vende cada uno

SELECT * FROM Suppliers
SELECT * FROM Products
SELECT S.CompanyName,S.SupplierID,COUNT(P.ProductName) AS N�Productos FROM Suppliers AS S INNER JOIN Products AS P ON S.SupplierID = P.SupplierID GROUP BY S.CompanyName,S.SupplierID

--Nombre completo y telefono de los vendedores que trabajen en New York, Seattle, Vermont, Columbia, Los Angeles, Redmond o Atlanta.

SELECT * FROM Employees
SELECT * FROM EmployeeTerritories
SELECT * FROM Territories
SELECT E.EmployeeID AS ID,(E.FirstName + ' ' + E.LastName) AS NombreCompleto,E.HomePhone AS N�Telefono,ET.TerritoryID,T.TerritoryDescription FROM Employees AS E INNER JOIN EmployeeTerritories AS ET ON E.EmployeeID = ET.EmployeeID INNER JOIN Territories AS T ON ET.TerritoryID = T.TerritoryID WHERE T.TerritoryDescription IN ('New York', 'Seattle', 'Vermont', 'Columbia', 'Los Angeles', 'Redmond', 'Atlanta') GROUP BY E.EmployeeID,E.FirstName,E.LastName,E.HomePhone,ET.TerritoryID,T.TerritoryDescription

--N�mero de productos de cada categor�a y nombre de la categor�a.

SELECT * FROM Products
SELECT * FROM Categories
SELECT COUNT(P.CategoryID) AS NumberOfCategories,C.CategoryName FROM Products AS P INNER JOIN Categories AS C ON P.CategoryID = C.CategoryID GROUP BY P.CategoryID,C.CategoryName

--Nombre de la compa��a de todos los clientes que hayan comprado queso de cabrales o tofu.

SELECT * FROM Customers
SELECT * FROM Orders
SELECT * FROM [Order Details]
SELECT * FROM Products
SELECT C.CompanyName,C.CustomerID,O.OrderID,OD.ProductID,P.ProductName FROM Customers AS C INNER JOIN Orders AS O ON C.CustomerID = O.CustomerID INNER JOIN [Order Details] AS OD ON O.OrderID = OD.OrderID INNER JOIN Products AS P ON OD.ProductID = P.ProductID WHERE P.ProductName IN ('queso de cabrales','tofu') GROUP BY C.CompanyName,C.CustomerID,O.OrderID,OD.ProductID,P.ProductName

--Empleados (ID, nombre, apellidos y tel�fono) que han vendido algo a Bon app' o Meter Franken (nombre de la compa��a).

SELECT * FROM Employees
SELECT * FROM Orders
SELECT * FROM Customers
SELECT E.EmployeeID,E.FirstName + ' ' + E.LastName AS NombreCompleto,E.HomePhone,C.CompanyName FROM Employees AS E INNER JOIN Orders AS O ON E.EmployeeID = O.EmployeeID INNER JOIN Customers AS C ON O.CustomerID = C.CustomerID WHERE C.CompanyName IN ('Bon app''','Meter Franken') GROUP BY E.EmployeeID,E.FirstName,E.LastName,E.HomePhone,C.CompanyName

--Esto esta mal hecho pero con lo que me costo no lo quiero borrar asi que ahi se queda, arrriba se encontrara el que funciona bien.
SELECT * FROM Employees
SELECT * FROM Orders
SELECT * FROM [Order Details]
SELECT * FROM Products
SELECT * FROM Suppliers
SELECT * FROM Customers
SELECT E.EmployeeID,E.FirstName + ' ' + E.LastName AS NombreCompleto,E.HomePhone,S.CompanyName FROM Employees AS E INNER JOIN Orders AS O ON E.EmployeeID = O.EmployeeID INNER JOIN [Order Details] AS OD ON O.OrderID = OD.OrderID INNER JOIN Products AS P ON OD.ProductID = OD.ProductID INNER JOIN Suppliers AS S ON P.SupplierID = S.SupplierID WHERE S.CompanyName IN ('Bon app','Meter Franken') GROUP BY E.EmployeeID,E.FirstName,E.LastName,E.HomePhone,S.CompanyName
SELECT E.EmployeeID,E.FirstName + ' ' + E.LastName AS NombreCompleto,E.HomePhone,O.OrderID,OD.ProductID,P.SupplierID,S.CompanyName FROM Employees AS E INNER JOIN Orders AS O ON E.EmployeeID = O.EmployeeID INNER JOIN [Order Details] AS OD ON O.OrderID = OD.OrderID INNER JOIN Products AS P ON OD.ProductID = OD.ProductID INNER JOIN Suppliers AS S ON P.SupplierID = S.SupplierID WHERE S.CompanyName IN ('Bon app','Meter Franken') GROUP BY E.EmployeeID,E.FirstName,E.LastName,E.HomePhone,O.OrderID,OD.ProductID,P.SupplierID,S.CompanyName

--Empleados (ID, nombre, apellidos, mes y d�a de su cumplea�os) que no han vendido nunca nada a ning�n cliente de Portugal. 

SELECT * FROM Employees
SELECT * FROM Orders
SELECT * FROM Customers
SELECT E.EmployeeID,E.FirstName + ' ' + E.LastName AS NombreCompleto,MONTH(E.BirthDate) + ' ' + DAY(E.BirthDate) AS Cumplea�os,C.Country FROM Employees AS E INNER JOIN Orders AS O ON E.EmployeeID = O.OrderID INNER JOIN Customers AS C ON O.CustomerID = C.CustomerID WHERE C.Country NOT IN ('Portugal') GROUP BY E.EmployeeID,E.FirstName,E.LastName,E.BirthDate,C.Country

--Total de ventas en US$ de productos de cada categor�a (nombre de la categor�a).

SELECT * FROM Products
SELECT * FROM Categories
SELECT * FROM [Order Details]
SELECT C.CategoryName,SUM(OD.UnitPrice * OD.Quantity) AS VentasCategoria 
FROM Categories AS C 
INNER JOIN Products AS P ON C.CategoryID = P.CategoryID 
INNER JOIN [Order Details] AS OD ON P.ProductID = OD.ProductID 
GROUP BY C.CategoryName

--Total de ventas en US$ de cada empleado cada a�o (nombre, apellidos, direcci�n).

SELECT * FROM Employees
SELECT * FROM Orders
SELECT * FROM [Order Details]
SELECT * FROM Products
SELECT (E.LastName + ' ' + E.FirstName) AS NombreCompleto,YEAR(O.OrderDate) AS A�oVentas,P.ProductName AS NombreProducto,SUM(OD.Quantity * OD.UnitPrice) AS Dolares FROM Employees AS E INNER JOIN Orders AS O ON E.EmployeeID = O.EmployeeID INNER JOIN [Order Details] AS OD ON O.OrderID = OD.OrderID INNER JOIN Products AS P ON OD.ProductID = P.ProductID GROUP BY O.OrderDate,E.FirstName,E.LastName,P.ProductName ORDER BY NombreCompleto,O.OrderDate ASC

--Ventas de cada producto en el a�o 97. Nombre del producto y unidades.

SELECT * FROM Products
SELECT * FROM [Order Details]
SELECT * FROM Orders
SELECT P.ProductName,P.UnitsInStock,YEAR(O.OrderDate) AS A�o FROM Products AS P INNER JOIN [Order Details] AS OD ON P.ProductID = OD.ProductID INNER JOIN Orders AS O ON OD.OrderID = O.OrderID WHERE YEAR(O.OrderDate) = 1997 GROUP BY P.ProductName,P.UnitsInStock,O.OrderDate

--Empleados (nombre y apellidos) que trabajan a las �rdenes de Andrew Fuller.

SELECT * FROM Employees
SELECT (E.LastName + ' ' + E.FirstName) AS NombreCompleto FROM Employees AS E INNER JOIN Employees AS EM ON E.EmployeeID = E.ReportsTo WHERE E.FirstName IN ('Andrew') AND E.LastName IN ('Fuller')

--N�mero de subordinados que tiene cada empleado, incluyendo los que no tienen ninguno. Nombre, apellidos, ID.

SELECT * FROM Employees
SELECT E.EmployeeID AS ID,COUNT(EM.EmployeeID) AS N�Subordinados,E.FirstName,E.LastName 
FROM Employees AS E INNER JOIN Employees AS EM ON E.EmployeeID = EM.ReportsTo 
GROUP BY E.EmployeeID,E.FirstName,E.LastName
