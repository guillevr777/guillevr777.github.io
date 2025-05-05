--1. A modo de ejemplo, iniciar una transacci�n donde se insertan dos empleados. Antes de finalizar
--la transacci�n comprobar que, desde dentro de la transacci�n los empleados est�n ya insertados
--y desde fuera de la transacci�n (otra local instance) los empleados todav�a no existen en la base
--de datos.



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