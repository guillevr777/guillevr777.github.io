--1. A modo de ejemplo, iniciar una transacción donde se insertan dos empleados. Antes de finalizar
--la transacción comprobar que, desde dentro de la transacción los empleados están ya insertados
--y desde fuera de la transacción (otra local instance) los empleados todavía no existen en la base
--de datos.



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