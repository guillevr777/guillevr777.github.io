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
SELECT O.Oficina,O.region 
FROM OFICINAS AS O INNER JOIN Empleados AS E ON O.dir = E.numemp 
WHERE O.dir = NULL OR E.oficina = O.oficina

--71. ¿Cuál es la cuota media y las ventas medias de todos los empleados?

SELECT * FROM Empleados
SELECT SUM(cuota)/COUNT(cuota) as CuotaMedia,SUM(ventas)/COUNT(cuota) as VentaMedia FROM Empleados 

--72. Edad media de los empleados.

SELECT SUM(EDAD)/COUNT(EDAD) FROM Empleados

--73. Edad del empleado más joven y del mayor.

SELECT MAX(EDAD) AS MAYOR,MIN(EDAD) AS MENOR FROM Empleados

--74. Hallar el importe medio de pedidos, el importe total de pedidos y el precio medio de venta (el precio de venta es el precio unitario en cada pedido).

SELECT * FROM Empleados
SELECT * FROM Pedidos
SELECT SUM(importe)/COUNT(importe) AS impMedio,SUM(importe) AS impTotal FROM Pedidos

--75. Hallar el precio medio de los productos del fabricante ‘ACI’.

SELECT * FROM Productos
SELECT SUM(precio*existencias) AS PrecioMedio FROM Productos WHERE idfab = 'ACI';

--76. ¿Cuál es el importe total de los pedidos realizados por el empleado Vicente Vino?

SELECT SUM(P.importe) AS ImporteTotal FROM Empleados AS E INNER JOIN Pedidos AS P ON E.numemp = P.resp WHERE nombre = 'Vicente Vino';

--77. Hallar en qué fecha se realizó el primer pedido.

SELECT * FROM Pedidos
SELECT MIN(fechapedido) FROM Pedidos where fechapedido != null

--78. Hallar cuántos pedidos hay de más de 5.000 euros.ç

SELECT COUNT(numpedido) AS NºPedidos FROM Pedidos WHERE importe > 5000

--79. Listar cuántos empleados están asignados a cada oficina, indicar el número de oficina.

SELECT * FROM Empleados
SELECT * FROM Oficinas
SELECT COUNT(numemp),oficina FROM Empleados GROUP BY oficina

--80. Mostrar el número de oficinas que existen en cada región.

SELECT COUNT(oficina),region FROM Oficinas GROUP BY region

--81. Saber cuántas oficinas tienen algún empleado con ventas superiores a su cuota, no queremos saber cuales sino cuántas hay.

SELECT * FROM Empleados
SELECT * FROM Oficinas
SELECT COUNT(O.oficina) AS NºOficinas FROM Oficinas AS O INNER JOIN Empleados AS E ON O.dir = E.numemp WHERE E.ventas > E.cuota

--82. Para cada empleado, obtener su número, nombre, e importe vendido a cada cliente indicando el número de cliente.

SELECT * FROM Clientes
SELECT * FROM Pedidos
SELECT E.numemp,E.nombre,P.importe,C.numclie FROM EMPLEADOS AS E INNER JOIN Pedidos AS P ON E.numemp = P.resp INNER JOIN Clientes AS C ON P.clie = C.numclie

--83. Para cada empleado cuyos pedidos suman más de 3.000 euros, hallar su importe medio de pedidos. En el resultado indicar el número de empleado y su importe medio de pedidos.

SELECT E.nombre,SUM(importe)/COUNT(importe) AS ImporteMedio FROM Empleados AS E INNER JOIN Pedidos AS P ON E.numemp = P.resp GROUP BY E.nombre HAVING (SUM(P.importe) > 3000)

--84. Listar de cada producto, su descripción, precio y cantidad total pedida, incluyendo sólo los productos cuya cantidad total pedida sea superior al 75% del stock; y ordenado por cantidad total pedida.

SELECT * FROM Productos
SELECT * FROM Pedidos
SELECT P.descripcion,P.precio,SUM(PE.cant) AS CantidadPedida FROM Productos AS P INNER JOIN Pedidos AS PE ON P.idproducto = PE.producto GROUP BY PE.cant,P.descripcion,P.existencias,P.precio HAVING SUM(PE.cant) > (P.existencias*0.75)

--85. Escribir una consulta SQL que indique el número de empleados que trabaja en cada oficina.

SELECT COUNT(E.numemp),O.oficina FROM Empleados AS E INNER JOIN Oficinas AS O ON E.oficina = O.oficina GROUP BY O.oficina

--86. Igual que el ejercicio anterior pero mostrando las oficinas donde trabajan 3 o más empleados. Subconsultas

SELECT COUNT(E.numemp),O.oficina FROM Empleados AS E INNER JOIN Oficinas AS O ON E.oficina = O.oficina GROUP BY O.oficina HAVING COUNT(E.numemp) >= 3

--87. Listar los nombres de los clientes que tienen asignado como responsable a Alvaro Aluminio (su- poniendo que no pueden haber empleados con el mismo nombre).

SELECT C.nombre,E.nombre FROM Clientes AS C INNER JOIN Empleados AS E ON C.resp = E.numemp WHERE E.nombre = 'Alvaro Aluminio'

--88. Mostrar información de los productos cuyas existencias estén por debajo de la existencia media de los productos.

SELECT descripcion,precio FROM Productos GROUP BY existencias,descripcion,precio HAVING existencias < (SELECT AVG(existencias) FROM Productos)

--89. Listar los empleados (numemp, nombre, y no de oficina) que trabajan en oficinas “buenas” (las que tienen ventas superiores a su objetivo).

SELECT E.numemp,E.nombre,O.oficina FROM Empleados AS E INNER JOIN Oficinas AS O ON E.numemp = O.dir WHERE O.ventas > O.objetivo

--90. Listar los empleados que trabajan en una oficina de la región norte o de la región sur.

SELECT E.nombre,O.region FROM Empleados AS E INNER JOIN Oficinas AS O ON E.numemp = O.dir WHERE O.region IN ('sur', 'norte')

--91. Listar los empleados (numemp, nombre y oficina) que no trabajan en oficinas dirigidas por el empleado 108.

SELECT E.numemp,E.nombre,O.oficina FROM Empleados AS E INNER JOIN Oficinas AS O ON E.numemp = O.dir WHERE O.dir != 108

--92. Escribir una consulta que muestre los empleados cuyo nombre coincide con el de algún cliente. Hacer dos versiones: con subconsulta de tipo lista y de tipo tabla.

SELECT E.nombre AS nombreEmpleado, C.nombre AS nombreCliente FROM Empleados AS E INNER JOIN Clientes AS C ON LEFT(E.nombre, CHARINDEX(' ', E.nombre + ' ') - 1) = LEFT(C.nombre, CHARINDEX(' ', C.nombre + ' ') - 1);
SELECT nombre AS nombreEmpleado FROM Empleados WHERE nombre IN (SELECT nombre FROM Clientes);
SELECT E.nombre AS nombreEmpleado FROM Empleados AS E WHERE EXISTS (SELECT 1 FROM Clientes AS C WHERE E.nombre = C.nombre);

--93. Escribir una consulta que muestre los empleados cuyo primer nombre coincide con el primer nombre de algún cliente.

SELECT E.nombre AS nombreEmpleado, C.nombre AS nombreCliente FROM Empleados AS E INNER JOIN Clientes AS C ON LEFT(E.nombre, CHARINDEX(' ', E.nombre + ' ') - 1) = LEFT(C.nombre, CHARINDEX(' ', C.nombre + ' ') - 1);

--94. Mostrar los empleados que no son directores de ninguna oficina.

SELECT * FROM Empleados
SELECT * FROM Oficinas
SELECT nombre FROM Empleados WHERE numemp NOT IN (SELECT dir FROM Oficinas WHERE dir IS NOT NULL);

--95. Listar los productos (idfab, idproducto y descripción) para los cuales no existe ningún pedido con importe igual o superior a 2.500 euros.

SELECT * FROM Productos
SELECT * FROM Pedidos
SELECT P.idfab,P.idproducto,P.descripcion FROM Productos AS P WHERE NOT EXISTS (SELECT 1 FROM Pedidos AS PE WHERE PE.producto = P.idproducto AND PE.importe >= 2500);

--96. Listar los clientes asignados a Ana Bustamante que no han hecho un pedido superior a 300 euros.

SELECT * FROM Clientes
SELECT * FROM Empleados
SELECT C.nombre
FROM Clientes C
JOIN Empleados E ON C.resp = E.numemp
WHERE E.nombre = 'Ana Bustamante' AND C.resp NOT IN (SELECT P.clie FROM Pedidos P WHERE P.importe > 300);

--97. Listar las oficinas en donde al menos haya un empleado cuyas ventas representen más del 55% del objetivo de su oficina.

SELECT * FROM Empleados
SELECT * FROM Oficinas
SELECT O.oficina, E.nombre, O.ventas 
FROM Empleados AS E 
INNER JOIN Oficinas AS O ON E.oficina = O.oficina 
WHERE EXISTS (
    SELECT 1 
    FROM Empleados AS EE 
    WHERE EE.oficina = O.oficina 
    AND EE.ventas > (O.objetivo * 0.55)
);

--98. Listar las oficinas donde todos los empleados tienen ventas que superan al 50% del objetivo de la oficina.

SELECT O.oficina
FROM Oficinas O
WHERE NOT EXISTS (
    SELECT 1 
    FROM Empleados E
    WHERE E.oficina = O.oficina
    AND E.ventas <= (O.objetivo * 0.50)
);

--99. Listar las oficinas que tengan un objetivo mayor que la suma de las cuotas de sus empleados.

SELECT O.oficina
FROM Oficinas O
WHERE O.objetivo > (
    SELECT COALESCE(SUM(E.cuota), 0)
    FROM Empleados E
    WHERE E.oficina = O.oficina
);

---------------------------------------------

--Pruebas
SELECT * FROM Empleados
SELECT * FROM Clientes
SELECT nombre FROM Clientes WHERE resp IN (SELECT numemp FROM Empleados WHERE nombre = 'Alvaro Aluminio');

SELECT * FROM Productos
--SELECT * FROM Productos WHERE SELECT existencias FROM Productos WHERE 