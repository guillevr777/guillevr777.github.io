--Transacciones
--1. A modo de ejemplo, iniciar una transacción donde se insertan dos empleados. Antes de finalizar
--la transacción comprobar que, desde dentro de la transacción los empleados están ya insertados
--y desde fuera de la transacción (otra local instance) los empleados todavía no existen en la base
--de datos.

	CREATE OR ALTER 

--2. Escribir una transacción que elimine cualquier rastro del cliente Jaime Jamás. Recordar que hay
--que eliminar sus datos y sus pedidos.
--3. Escribir un procedimiento almacenado con el mismo comportamiento que el ejercicio anterior.
--El nombre del cliente se le pasará mediante un parámetro. Debe eliminar todo rastro del cliente.
--En el caso que el cliente no tenga pedidos, se cancelará el borrado de sus datos.
--4. Mediante un procedimiento almacenado escribir el siguiente algoritmo:
--a) Al procedimiento se le pasa el nombre (exacto) de un empleado.
--b) Elimina al empleado.
--c) Elimina todos sus pedidos.
--d) Comprueba si el empleado es director de alguna oficina.
--e) En el caso de ser director de una oficina, no será posible eliminar al empleado. Deshacer los
--cambios realizados.

--Triggers

--5. Para la base de datos Empresa crear un disparador que cada vez que se inserta un empleado sus-
--tituya su nombre por “Pepe”.

	SELECT * FROM Empleados
	CREATE TRIGGER NuevoEmpleado
	ON Empleados
	AFTER INSERT 
	AS
	BEGIN
	SET NOCOUNT ON
	IF INSERT (Empleados)
		BEGIN
			UPDATE Empleados
			SET Nombre = 'Pepe'
		END
	END

--6. Escribir un disparador, que cada vez que se modifique un empleado, añada “Don” al principio de
--su nombre.
--7. Realizar una versión mejorada del ejercicio anterior donde se compruebe que se desea modificar
--el campo nombre.
--8. En Empresa, diseñar un disparador que compruebe cada vez que insertamos un empleado que su
--edad esté comprendida entre 16 –edad mínima para trabajar– y 67 –edad de jubilación–.
--9. Escribir un disparador para la BD Empresa que supervise los traslados de los empleados. Éstos
--pueden moverse a otra oficina, pero el traslado ha de cumplir que sea a una oficina dentro de la
--misma región a la que están asignados. Es decir, si un empleado trabaja en una oficina del ‘Este’
--podrá trasladarse a cualquier otra oficina, pero siempre dentro de la región ‘Este’.
--10. Crear un trigger para gestionar una copia de seguridad de todos los clientes: actuales y eliminados.
--Para cada uno especificaremos el nombre, el límite de crédito y la fecha de alta. Para almacenar

--estos datos dispondremos de la tabla «backupClientes». Crear también un procedimiento alma-
--cenado que cree la nueva tabla y haga una copia de los clientes actuales.

--11. Diseñar un disparador que permita modificar cualquier dato de un cliente excepto el número del
--empleado que es responsable de él (repclie).
--Franma 1

--12. Comprobar en cada inserción de empleado que el número de oficina asignado existe. En caso
--contrario asignaremos al empleado a la primera oficina que esté disponible.
--13. Realizar un disparador que controle la inserción de un nuevo empleado. En el caso que carezca de
--jefe, su cuota, ignorando la asignada, debe ser la media de las cuotas del resto de empleados.
--14. Añadir a la base de datos la tabla «productosFabricante» con los campos idfab y cantidad. En dicha

--tabla llevaremos un control del número de productos de los que disponemos para cada fabrican-
--te; indistintamente de la cantidad de cada producto. Crear los trigger necesarios para mantener

--actualizada esta información.
--Cursores
--15. Mediante un cursor incrementa la cuota del primer empleado en 10 euro, la cuota del segundo
--empleado en 20 euros y así sucesivamente. La cuota se incrementará según el orden en el que se
--encuentren los empleados en la base de datos.
--16. Mediante un procedimiento almacenado, añadir el campo orden con un valor consecutivo que

--ordene a los empleados, según la antiguedad del contrato. Si dos empleados tienen la misma an-
--tiguedad se ordenarán alfabeticamente. Tras añadir el nuevo campo y asignarle valor, se elimina

--de la tabla el campo contrato.
--17. Utilizando dos cursores (este ejercicio se podría hacer simplemente con un JOIN) mostrar para
--cada empleado el importe de pedidos del que es responsable.
--18. La empresa ha decidido que no pueden existir oficinas sin objetivos marcados. Mediante un cursor
--asignar a cada oficina sin objetivo (null) el objetivo que tiene asignado la oficina anterior en la
--tabla. En el caso que la primera oficina de la tabla no tenga objetivo asignarle por defecto 10.000
--euros.