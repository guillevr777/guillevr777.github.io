--Utilizando la base de datos Empresa, realizar las siguientes consultas:
--1. Añadir una nueva oficina para la ciudad de Madrid, con el número de oficina 30, con un objetivo de 10.000 euros y región ‘Centro’. Suponer que conocemos el orden de los campos en la tabla.

SELECT * FROM Empleados
SELECT * FROM Pedidos
SELECT * FROM Clientes
SELECT * FROM Productos
SELECT * FROM Oficinas
INSERT INTO Oficinas
		VALUES (30,'Madrid','Centro',NULL,10000,NULL);

--2. Igual que el ejercicio anterior suponiendo que no sabemos cual es el orden de los campos en la tabla Oficina.

INSERT INTO Oficinas(oficina, ciudad,objetivo,region)
		VALUES (30,'Madrid',10000,'Centro');

--3. Insertar tus datos como nuevo empleado. Utilizar como numemp los tres últimos dígitos del dni, la oficina 23, el puesto “Programador”, sin jefe, con una cuota de 1000 y las ventas a 0. En el contrato la fecha de hoy.

INSERT INTO Empleados(numemp,oficina,puesto,jefe,cuota,ventas,contrato)
	VALUES (783,23,'Programador',NULL,1000,0,'2025-03-08');

--4. Insertar un nuevo cliente con tu nombre y utilizar como numclie 999. Dejar el resto de campos a su valor por defecto.

INSERT INTO Clientes (nombre,numclie)
	VALUES ('Guillermo',999);

--5. Insertar los empleados que no tienen jefes como clientes. Como número de clientes utilizaremos el mismo número de empleado, ellos mismo serán sus propios responsable y el límite de crédito será 0.

INSERT INTO Clientes (numclie, nombre, resp, limitecredito)
SELECT numemp, nombre, numemp, 0 
FROM Empleados
WHERE jefe IS NULL;

--7. Subir un 5% el precio de todos los productos del fabricante ‘ACI’.

UPDATE Productos
SET precio = precio * 1.05
WHERE idfab = 'aci';

--8. Incrementar en uno la edad de los empleados.

UPDATE Empleados SET edad = edad + 1

--9. Cambiar los empleados de la oficina 21 a la oficina 30.

UPDATE Empleados SET oficina = 30 WHERE oficina = 21

--10. De los empleados que trabajan en Cádiz, disminuir su cuota en un 10%.

UPDATE Empleados 
SET cuota = cuota - (cuota * 0.10) 
WHERE oficina IN (SELECT oficina FROM Oficinas WHERE ciudad = 'Cádiz');

--12. Modificar el nombre de los empleados para eliminar el segundo nombre o apellido (apellidos) de su nombre.

UPDATE Empleados SET nombre = LEFT(nombre, CHARINDEX(' ', nombre + ' ') - 1);

--13. Bajar 100 euros el precio de los productos de los que no se han realizado ningún pedido. Hay que tener cuidado que no queden precios negativos.

SELECT * FROM Pedidos
SELECT * FROM Productos
UPDATE Productos SET precio = precio - 100 WHERE idproducto NOT IN (SELECT Producto FROM Pedidos) AND precio >= 100;

--14. Cambiar la cuota de todos los empleados a 1000 euros.

UPDATE Empleados SET Cuota = 1000;

--15. Eliminar los pedidos cuyo responsable es el empleado 105.

DELETE Pedidos FROM Pedidos WHERE resp = 105

--16. Eliminar los tres clientes con menor límite de crédito.



--17. En un ejercicio anterior hemos insertado un nuevo empleado con nuestros datos. Eliminar dicho registro.

DELETE FROM Clientes WHERE nombre = 'Guillermo';

--18. Eliminar las oficinas que no tengan empleados.

SELECT * FROM Oficinas
SELECT * FROM Empleados
DELETE FROM Oficinas WHERE dir IS NULL

DELETE FROM Oficinas WHERE NOT EXISTS (SELECT 1 FROM Empleados WHERE Empleados.oficina = Oficinas.oficina);

--9. Elimiar cualquier rastro del cliente 2103 (datos y pedidos).

SELECT * FROM Pedidos
DELETE FROM Clientes WHERE numclie = 2103
DELETE FROM Pedidos WHERE clie = 2103

--20. Eliminar los empleado que han realizado al menos un pedido del fabricante ‘ACI’.

DELETE FROM Empleados WHERE numemp IN (SELECT resp FROM Pedidos WHERE fab = 'aci');