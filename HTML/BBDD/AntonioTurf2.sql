--1.Crea una función inline llamada FnCarrerasCaballo que reciba un rango de fechas (inicio y fin) y nos 
--devuelva el número de carreras disputadas por cada caballo entre esas dos fechas. Las columnas serán 
--ID (del caballo), nombre, sexo, fecha de nacimiento y número de carreras disputadas.

		SELECT * FROM LTCarreras

		CREATE OR ALTER FUNCTION FnCarrerasCaballo (@Inicio DATE,@Fin DATE)
		RETURNS TABLE
		AS
		RETURN (
		SELECT C.ID,C.Nombre,C.Sexo,C.FechaNacimiento,COUNT(CC.IDCarrera) AS NºCarreras FROM LTCaballos C 
		INNER JOIN LTCaballosCarreras CC ON C.ID = CC.IDCaballo 
		INNER JOIN LTCarreras CA ON CC.IDCarrera = CA.ID
		WHERE CA.Fecha BETWEEN @Inicio AND @Fin
		GROUP BY C.ID,C.Nombre,C.Sexo,C.FechaNacimiento
		);

		SELECT * FROM dbo.FnCarrerasCaballo ('2018-03-02','2018-03-12')

--2.Crea una función escalar llamada FnTotalApostadoCC que reciba como parámetros el ID de un caballo y 
--el ID de una carrera y nos devuelva el dinero que se ha apostado a ese caballo en esa carrera.

	SELECT * FROM LTApuestas

	CREATE OR ALTER FUNCTION FnTotalApostadoCC (@IDCaballo INT,@IDCarrera INT)
	RETURNS MONEY
	AS
	BEGIN
	DECLARE @Resultado MONEY
	SET @Resultado = (SELECT SUM(Importe) FROM LTApuestas WHERE IDCaballo = @IDCaballo AND IDCarrera = @IDCarrera)
	RETURN @Resultado
	END

	SELECT dbo.FnTotalApostadoCC (11,21) AS TotalApostado

--3. .Crea una función escalar llamada FnPremioConseguido que reciba como parámetros el ID de una apuesta 
--y nos devuelva el dinero que ha ganado dicha apuesta. Para obtener el dinero conseguido se tendrá que mirar
--en qué posición ha quedado el caballo en la apuesta pasada por parámetro sabiendo que si ha quedado el primero 
--el premio será el importe apostado por el campo premio1; si ha quedado en segunda posición el premio será el 
--importe apostado por el campo premio 2, y si ha quedado en otra posición el premio será 0. Si no encontramos 
--la apuesta pasada por parámetro devolverá un NULL.  

	CREATE OR ALTER FUNCTION FnPremioConseguido (@Apuesta INT)
	RETURNS MONEY
	AS
	BEGIN
	DECLARE @Resultado MONEY
	DECLARE @Posicion INT
	SET @Posicion = (SELECT TOP 1 ISNULL(Posicion,0) FROM LTCaballosCarreras CC INNER JOIN LTCarreras C ON CC.IDCarrera = C.ID INNER JOIN LTApuestas A ON C.ID = A.IDCarrera WHERE A.ID = @Apuesta)
	IF @Posicion IS NOT NULL	
	BEGIN
		SET @Resultado = (SELECT TOP 1
			CASE @Posicion
			WHEN 1 THEN (A.Importe*CC.Premio1) 
			WHEN 2 THEN (A.Importe*CC.Premio2) 
			ELSE 0
			END
		FROM LTCaballosCarreras CC 
		INNER JOIN LTCarreras C ON CC.IDCarrera = C.ID 
		INNER JOIN LTApuestas A ON C.ID = A.IDCarrera
		WHERE A.ID = @Apuesta);
	END
	ELSE 
		SET @Resultado = NULL
	RETURN @Resultado
	END

	SELECT dbo.FnPremioConseguido (6) AS Apuesta

--4.El procedimiento para calcular los premios en las apuestas de una carrera (los valores que deben figurar en
--la columna Premio1 y Premio2) es el siguiente:
--a.Se calcula el total de dinero apostado en esa carrera
--b.El valor de la columna Premio1 para cada caballo se calcula dividiendo el total de dinero apostado para esa carrera 
--entre lo apostado a ese caballo y carrera y se multiplica el resultado por 0.6
--c.El valor de la columna Premio2 para cada caballo se calcula dividiendo el total de dinero apostado àra esa carrera 
--entre lo apostado a ese caballo y carrera y se multiplica el resultado por 0.2
--d.Si a algún caballo no ha apostado nadie tanto el Premio1 como el Premio2 se ponen a 100.
--Crea una función que devuelva una tabla con tres columnas: ID del caballo, Premio1 y Premio2.
--El parámetro de entrada será el ID de la carrera.

	CREATE OR ALTER PROCEDURE CalculoPremios (@IDCarrera INT)
	AS
	BEGIN
	DECLARE @Dinero MONEY
	SET @Dinero = (SELECT SUM(Importe) FROM LTApuestas WHERE IDCarrera = @IDCarrera)
		SELECT 
		IDCaballo AS Caballo,
		ISNULL((@Dinero / dbo.FnTotalApostadoCC (@IDCarrera,IDCaballo) * 0.6),100) AS Premio1,
		ISNULL((@Dinero / dbo.FnTotalApostadoCC (@IDCarrera,IDCaballo) * 0.2),100) AS Premio2
		FROM LTApuestas WHERE IDCarrera = @IDCarrera
	END

	EXEC CalculoPremios 1

--Debes usar la función del Ejercicio 2. Si lo estimas oportuno puedes crear otras funciones para realizar parte de los cálculos.
--5.Crea una función FnPalmares que reciba un ID de caballo y un rango de fechas y nos devuelva el palmarés de ese caballo en ese intervalo de tiempo.
--El palmarés es el número de victorias, segundos puestos, etc. Se devolverá una tabla con dos columnas:
--Posición y NumVeces, que indicarán, respectivamente, cada una de las posiciones y las veces que el caballo ha obtenido ese resultado. 



--6.Crea una función FnCarrerasHipodromo que nos devuelva las carreras celebradas en un hipódromo en un rango de fechas.
--La función recibirá como parámetros el nombre del hipódromo y la fecha de inicio y fin del intervalo 
--y nos devolverá una tabla con las siguientes columnas: Fecha de la carrera, número de orden, numero de 
--apuestas realizadas, número de caballos inscritos, número de caballos que la finalizaron y nombre del ganador.



--7.Crea una función FnObtenerSaldo a la que pasemos el ID de un jugador y una fecha y nos devuelva su saldo en esa fecha.
--Si se omite la fecha, se devolverá el saldo actual

