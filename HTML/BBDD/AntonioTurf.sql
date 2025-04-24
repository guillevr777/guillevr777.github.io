--1.Crea una función inline llamada FnCarrerasCaballo que reciba un rango de fechas (inicio y fin)
--y nos devuelva el número de carreras disputadas por cada caballo entre esas dos fechas.
--Las columnas serán ID (del caballo), nombre, sexo, fecha de nacimiento y número de carreras disputadas.

CREATE OR ALTER FUNCTION dbo.CarrerasCaballo (@FechaInicio DATE, @FechaFin DATE)
RETURNS TABLE AS
	RETURN (SELECT C.ID,C.Nombre,C.FechaNacimiento,C.Sexo,CAR.Fecha FROM LTCaballos C INNER JOIN LTCaballosCarreras CA ON C.ID = CA.IDCaballo 
	INNER JOIN LTCarreras CAR ON CA.IDCarrera = CAR.ID WHERE CAR.Fecha BETWEEN @FechaInicio AND @FechaFin
	GROUP BY C.ID,C.Nombre,C.FechaNacimiento,C.Sexo,CAR.Fecha);

SELECT * FROM dbo.FnCarrerasCaballo('2018-03-03', '2018-03-10');

--2.Crea una función escalar llamada FnTotalApostadoCC que reciba como parámetros el ID de un caballo
--y el ID de una carrera y nos devuelva el dinero que se ha apostado a ese caballo en esa carrera.

CREATE OR ALTER FUNCTION dbo.FnTotalApostadoCC (@Caballo INT, @Carrera INT)
RETURNS MONEY
AS
BEGIN
	DECLARE @Dinero MONEY

	SET @Dinero = (SELECT A.Importe FROM LTApuestas A INNER JOIN LTCaballos C ON A.ID = C.ID 
	INNER JOIN LTCaballosCarreras CA ON C.ID = CA.IDCaballo INNER JOIN LTCarreras CAR ON CA.IDCarrera = CAR.ID 
	WHERE C.ID = @Caballo AND CAR.ID = @Carrera);

	RETURN @Dinero
END

SELECT dbo.FnTotalApostadoCC(1,1);

--3. .Crea una función escalar llamada FnPremioConseguido que reciba como parámetros el ID de una apuesta 
--y nos devuelva el dinero que ha ganado dicha apuesta. Para obtener el dinero conseguido se tendrá que mirar 
--en qué posición ha quedado el caballo en la apuesta pasada por parámetro sabiendo que si ha quedado 
--el primero el premio será el importe apostado por el campo premio1; 
--si ha quedado en segunda posición el premio será el importe apostado por el campo premio 2, y si ha quedado 
--en otra posición el premio será 0. Si no encontramos la apuesta pasada por parámetro devolverá un NULL.  

----------------------
CREATE OR ALTER FUNCTION dbo.FnPremioConseguido (@Apuesta INT)
RETURNS MONEY
AS
BEGIN
	DECLARE @Dinero MONEY
	DECLARE @Posicion INT

	SET @Posicion = (SELECT CA.Posicion FROM LTApuestas A INNER JOIN LTCaballos C ON A.ID = C.ID 
	INNER JOIN LTCaballosCarreras CA ON C.ID = CA.IDCaballo WHERE A.ID = @Apuesta);

	IF @Posicion = 1
		SET @Dinero = (SELECT (A.Importe*CA.Premio1) AS Premio FROM LTApuestas A INNER JOIN LTCaballos C ON A.ID = C.ID 
	INNER JOIN LTCaballosCarreras CA ON C.ID = CA.IDCaballo WHERE A.ID = @Apuesta);
	ELSE IF @Posicion = 2
		SET @Dinero = (SELECT (A.Importe*CA.Premio2) AS Premio FROM LTApuestas A INNER JOIN LTCaballos C ON A.ID = C.ID 
	INNER JOIN LTCaballosCarreras CA ON C.ID = CA.IDCaballo WHERE A.ID = @Apuesta);
	ELSE 
		SET @Dinero = 0;

	RETURN @Dinero
END
------------------------------

SELECT dbo.FnPremioConseguido(1);

SELECT * FROM LTCaballosCarreras

CREATE OR ALTER FUNCTION dbo.FnPremioConseguido (@Apuesta INT)
RETURNS MONEY
AS
BEGIN
	DECLARE @Dinero MONEY = 0
	DECLARE @Importe MONEY
	DECLARE @Posicion INT
	DECLARE @Premio1 FLOAT
	DECLARE @Premio2 FLOAT

	SELECT @Importe = A.Importe, @Posicion = CA.Posicion, @Premio1 = CA.Premio1, @Premio2 = CA.Premio2
	FROM LTApuestas A INNER JOIN LTCaballosCarreras CA ON A.IDCaballo = CA.IDCaballo
	WHERE A.ID = @Apuesta;

	IF @Posicion = 1
		SET @Dinero = @Importe * @Premio1
	ELSE IF @Posicion = 2
		SET @Dinero = @Importe * @Premio2

	RETURN @Dinero
END


--4.El procedimiento para calcular los premios en las apuestas de una carrera (los valores que deben figurar en la columna Premio1 y Premio2) es el siguiente:
--a.Se calcula el total de dinero apostado en esa carrera
--b.El valor de la columna Premio1 para cada caballo se calcula dividiendo el total de dinero apostado 
--para esa carrera entre lo apostado a ese caballo y carrera y se multiplica el resultado por 0.6
--c.El valor de la columna Premio2 para cada caballo se calcula dividiendo el total de dinero apostado
--àra esa carrera entre lo apostado a ese caballo y carrera y se multiplica el resultado por 0.2
--d.Si a algún caballo no ha apostado nadie tanto el Premio1 como el Premio2 se ponen a 100.
--Crea una función que devuelva una tabla con tres columnas: ID del caballo, Premio1 y Premio2.
--El parámetro de entrada será el ID de la carrera.

--Debes usar la función del Ejercicio 2. Si lo estimas oportuno puedes crear otras funciones para realizar parte de los cálculos.

--5.Crea una función FnPalmares que reciba un ID de caballo y un rango de fechas y nos devuelva el palmarés de ese caballo en ese intervalo de tiempo.
--El palmarés es el número de victorias, segundos puestos, etc. Se devolverá una tabla con dos columnas: 
--Posición y NumVeces, que indicarán, respectivamente, cada una de las posiciones y las veces que el caballo ha obtenido ese resultado. 

--6.Crea una función FnCarrerasHipodromo que nos devuelva las carreras celebradas en un hipódromo en un rango de fechas.
--La función recibirá como parámetros el nombre del hipódromo y la fecha de inicio y fin del intervalo y nos devolverá 
--una tabla con las siguientes columnas: Fecha de la carrera, número de orden, numero de apuestas realizadas, 
--número de caballos inscritos, número de caballos que la finalizaron y nombre del ganador.

--7.Crea una función FnObtenerSaldo a la que pasemos el ID de un jugador y una fecha y nos devuelva su saldo en esa fecha. 
--Si se omite la fecha, se devolverá el saldo actual
