--Consultas multitablas
--53. Mostrar la información de los empleados junto a la información de las oficinas en las que trabajan.

SELECT * FROM OFICINAS O INNER JOIN EMPLEADOS E ON O.oficina = E.oficina

--54. Igual que el ejercicio anterior, pero mostrando solo los empleados que trabajan en las oficinas del sur.

SELECT * FROM OFICINAS O INNER JOIN EMPLEADOS E ON O.oficina = E.oficina WHERE region IN ('sur')

--55. Igual que el ejercicio anterior, ordenando los empleados por edad.

SELECT * FROM OFICINAS O INNER JOIN EMPLEADOS E ON O.oficina = E.oficina WHERE region IN ('sur') ORDER BY EDAD

--56. Escribir una consulta que muestre la información de todos los empleados junto a los datos de su oficina.

SELECT * FROM OFICINAS O INNER JOIN EMPLEADOS E ON O.oficina = E.oficina 

--57. Escribir una consulta que muestre la información de todos los empleados (trabajen o no en una oficina) junto a la información de su oficina.

SELECT * FROM OFICINAS O RIGHT JOIN EMPLEADOS E ON O.oficina = E.oficina 

--58. Listar las oficinas del este indicando para cada una de ellas su número, ciudad, números y nombres de sus empleados. Hacer una versión en la que aparecen sólo las que tienen empleados, y hacer otra en las que además aparezcan las oficinas del este que no tienen empleados.

SELECT * FROM Oficinas,Empleados
SELECT O.oficina,O.ciudad,E.numemp,E.nombre FROM OFICINAS O INNER JOIN EMPLEADOS E ON O.oficina = E.oficina 
WHERE region IN ('este')

SELECT * FROM Oficinas,Empleados
SELECT O.oficina,O.ciudad,E.numemp,E.nombre FROM OFICINAS O LEFT JOIN EMPLEADOS E ON O.oficina = E.oficina 
WHERE region IN ('este')

--59. Listar los pedidos mostrando su número de pedido e importe, junto a la información del cliente (nombre y límite de crédito) que realiza el pedido.

SELECT * FROM Pedidos
SELECT * FROM Clientes
SELECT P.numpedido,P.importe,C.nombre,C.limitecredito 
FROM Pedidos AS P INNER JOIN Clientes AS C ON P.clie = C.numclie

--60. Igual que el ejercicio anterior mostrando además la información del empleado que fue responsable de este pedido.

SELECT * FROM Empleados
SELECT P.numpedido,P.importe,C.nombre,C.limitecredito,E.numemp
FROM Pedidos AS P INNER JOIN Clientes AS C ON P.clie = C.numclie INNER JOIN Empleados AS E ON C.resp = E.numemp

--61. Mostrar para cada producto la información de sus pedidos

SELECT * FROM Productos
SELECT * FROM Pedidos
SELECT P.descripcion,PE.* FROM Productos AS P INNER JOIN Pedidos AS PE ON P.idfab = PE.fab

--62. Listar los datos de cada uno de los empleados, la ciudad y región en donde trabaja.

select * from Empleados
SELECT * FROM OFICINAS
SELECT E.*,O.ciudad,O.region FROM Empleados AS E INNER JOIN OFICINAS AS O ON E.oficina = O.oficina

--63. Listar todas las oficinas con objetivo superior a 60.000 euros indicando para cada una de ellas el nombre de su director.

SELECT * FROM OFICINAS
SELECT * FROM Empleados
SELECT E.nombre,O.* FROM EMPLEADOS AS E INNER JOIN OFICINAS AS O ON E.numemp = O.dir WHERE O.objetivo > 60000

--64. Listar los pedidos superiores a 2.500 euros, incluyendo el nombre del empleado responsable del pedido y el nombre del cliente que lo solicitó. Ordenar la consulta por el nombre del cliente.

SELECT * FROM Pedidos
SELECT * FROM EMPLEADOS
SELECT * FROM Clientes
SELECT P.numpedido,P.importe,E.nombre,C.nombre FROM Pedidos AS P INNER JOIN Empleados AS E ON P.resp = E.numemp INNER JOIN Clientes AS C ON E.numemp = C.resp WHERE P.importe > 2500

--65. Listar ordenados por el nombre los empleados que han realizado algún pedido.

SELECT E.nombre,P.numpedido FROM Empleados AS E INNER JOIN Pedidos AS P ON E.numemp = P.RESP

--66. Hallar los empleados que realizaron su primer pedido el mismo día que fueron contratados.

SELECT * FROM Empleados
SELECT * FROM Pedidos ORDER BY RESP
SELECT * FROM Pedidos ORDER BY numpedido
SELECT GETDATE() CONTRATO FROM Empleados
UPDATE PEDIDOS SET fechapedido = '14-01-2000' WHERE numpedido = 110035
UPDATE PEDIDOS SET fechapedido = '13-01-2000' WHERE numpedido = 113034

SELECT E.nombre,E.contrato,P.numpedido,P.fechapedido 
FROM Empleados AS E INNER JOIN Pedidos AS P 
ON E.numemp = P.resp 
GROUP BY E.nombre,E.contrato,P.numpedido,P.fechapedido
HAVING E.contrato = MIN(P.fechapedido)

--67. Listar los empleados con una cuota superior a la de su jefe; para cada empleado sacar sus datos y el número, nombre y cuota de su jefe.

SELECT * FROM Empleados
SELECT E.nombre,E.cuota,J.nombre FROM Empleados AS E INNER JOIN Empleados AS J ON E.jefe = J.jefe

--68. Listar los números de los empleados que son responsables de un pedido superior a 1.000 euros o que tengan una cuota inferior a 5.000 euros.

SELECT * FROM Pedidos
SELECT E.numemp,P.importe,E.cuota FROM Empleados AS E INNER JOIN PEDIDOS AS P ON E.numemp = P.resp WHERE P.importe > 1000 AND E.cuota < 5000

--69. Mostrar las oficinas que no tienen director o que se encuentran en la región sur.

SELECT * FROM OFICINAS
SELECT * FROM Empleados
SELECT O.Oficina,O.region,E.nombre FROM OFICINAS AS O INNER JOIN Empleados AS E ON O.dir = E.numemp WHERE O.dir = NULL OR O.region = 'sur'

--70. Listar las oficinas que no tienen director o en las que trabaja alguien.

SELECT * FROM OFICINAS
SELECT * FROM Empleados
SELECT O.Oficina,O.region,E.nombre 
FROM OFICINAS AS O INNER JOIN Empleados AS E ON O.dir = E.numemp 
WHERE O.dir = NULL OR E.oficina = O.oficina

--