--Transacciones
--1. A modo de ejemplo, iniciar una transacci�n donde se insertan dos empleados. Antes de finalizar
--la transacci�n comprobar que, desde dentro de la transacci�n los empleados est�n ya insertados
--y desde fuera de la transacci�n (otra local instance) los empleados todav�a no existen en la base
--de datos.

	CREATE OR ALTER 

--2. Escribir una transacci�n que elimine cualquier rastro del cliente Jaime Jam�s. Recordar que hay
--que eliminar sus datos y sus pedidos.
--3. Escribir un procedimiento almacenado con el mismo comportamiento que el ejercicio anterior.
--El nombre del cliente se le pasar� mediante un par�metro. Debe eliminar todo rastro del cliente.
--En el caso que el cliente no tenga pedidos, se cancelar� el borrado de sus datos.
--4. Mediante un procedimiento almacenado escribir el siguiente algoritmo:
--a) Al procedimiento se le pasa el nombre (exacto) de un empleado.
--b) Elimina al empleado.
--c) Elimina todos sus pedidos.
--d) Comprueba si el empleado es director de alguna oficina.
--e) En el caso de ser director de una oficina, no ser� posible eliminar al empleado. Deshacer los
--cambios realizados.

--Triggers

--5. Para la base de datos Empresa crear un disparador que cada vez que se inserta un empleado sus-
--tituya su nombre por �Pepe�.

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

--6. Escribir un disparador, que cada vez que se modifique un empleado, a�ada �Don� al principio de
--su nombre.
--7. Realizar una versi�n mejorada del ejercicio anterior donde se compruebe que se desea modificar
--el campo nombre.
--8. En Empresa, dise�ar un disparador que compruebe cada vez que insertamos un empleado que su
--edad est� comprendida entre 16 �edad m�nima para trabajar� y 67 �edad de jubilaci�n�.
--9. Escribir un disparador para la BD Empresa que supervise los traslados de los empleados. �stos
--pueden moverse a otra oficina, pero el traslado ha de cumplir que sea a una oficina dentro de la
--misma regi�n a la que est�n asignados. Es decir, si un empleado trabaja en una oficina del �Este�
--podr� trasladarse a cualquier otra oficina, pero siempre dentro de la regi�n �Este�.
--10. Crear un trigger para gestionar una copia de seguridad de todos los clientes: actuales y eliminados.
--Para cada uno especificaremos el nombre, el l�mite de cr�dito y la fecha de alta. Para almacenar

--estos datos dispondremos de la tabla �backupClientes�. Crear tambi�n un procedimiento alma-
--cenado que cree la nueva tabla y haga una copia de los clientes actuales.

--11. Dise�ar un disparador que permita modificar cualquier dato de un cliente excepto el n�mero del
--empleado que es responsable de �l (repclie).
--Franma 1

--12. Comprobar en cada inserci�n de empleado que el n�mero de oficina asignado existe. En caso
--contrario asignaremos al empleado a la primera oficina que est� disponible.
--13. Realizar un disparador que controle la inserci�n de un nuevo empleado. En el caso que carezca de
--jefe, su cuota, ignorando la asignada, debe ser la media de las cuotas del resto de empleados.
--14. A�adir a la base de datos la tabla �productosFabricante� con los campos idfab y cantidad. En dicha

--tabla llevaremos un control del n�mero de productos de los que disponemos para cada fabrican-
--te; indistintamente de la cantidad de cada producto. Crear los trigger necesarios para mantener

--actualizada esta informaci�n.
--Cursores
--15. Mediante un cursor incrementa la cuota del primer empleado en 10 euro, la cuota del segundo
--empleado en 20 euros y as� sucesivamente. La cuota se incrementar� seg�n el orden en el que se
--encuentren los empleados en la base de datos.
--16. Mediante un procedimiento almacenado, a�adir el campo orden con un valor consecutivo que

--ordene a los empleados, seg�n la antiguedad del contrato. Si dos empleados tienen la misma an-
--tiguedad se ordenar�n alfabeticamente. Tras a�adir el nuevo campo y asignarle valor, se elimina

--de la tabla el campo contrato.
--17. Utilizando dos cursores (este ejercicio se podr�a hacer simplemente con un JOIN) mostrar para
--cada empleado el importe de pedidos del que es responsable.
--18. La empresa ha decidido que no pueden existir oficinas sin objetivos marcados. Mediante un cursor
--asignar a cada oficina sin objetivo (null) el objetivo que tiene asignado la oficina anterior en la
--tabla. En el caso que la primera oficina de la tabla no tenga objetivo asignarle por defecto 10.000
--euros.