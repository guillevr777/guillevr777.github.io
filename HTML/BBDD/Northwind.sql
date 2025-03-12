
CREATE VIEW Northvam AS 
SELECT OD.ProductID, P.ProductName, SUM(OD.Quantity) AS VentasAnuales FROM Products AS P
	INNER JOIN [Order Details] AS OD ON P.ProductID = OD.ProductID
	INNER JOIN Orders AS O ON OD.OrderID = O.OrderID
	Where Year (O.OrderDate) = 1996 
	Group By OD.ProductID, P.ProductName
	UNION
	SELECT P.ProductID, P.ProductName, SUM(ISNULL(OD.Quantity,0)) AS VentasAnuales 
FROM Products AS P
	LEFT JOIN [Order Details] AS OD ON P.ProductID = OD.ProductID
	LEFT JOIN Orders AS O ON OD.OrderID = O.OrderID
	Where Year (O.OrderDate) = 1997 OR O.OrderDate IS NULL
	Group By P.ProductID, P.ProductName

SELECT P.ProductName, SUM(OD.Quantity) AS VentasAnuales FROM Products AS P
	INNER JOIN [Order Details] AS OD ON P.ProductID = OD.ProductID
	INNER JOIN Orders AS O ON OD.OrderID = O.OrderID
	Where Year (O.OrderDate) = 1996 OR YEAR (O.OrderDate) = 1997
	Group By OD.ProductID, P.ProductName
	UNION
	SELECT P.ProductID, P.ProductName, SUM(ISNULL(OD.Quantity,0)) AS VentasAnuales 
FROM Products AS P
	LEFT JOIN [Order Details] AS OD ON P.ProductID = OD.ProductID
	LEFT JOIN Orders AS O ON OD.OrderID = O.OrderID
	Where Year (O.OrderDate) = 1997 OR O.OrderDate IS NULL
	Group By P.ProductID, P.ProductName