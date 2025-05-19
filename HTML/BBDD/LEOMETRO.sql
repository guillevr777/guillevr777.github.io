--1.	Crea una función inline que nos devuelva el número de estaciones que ha recorrido cada tren en un determinado periodo de tiempo. 
--El principio y el fin de ese periodo se pasarán como parámetros. Nota: Tratar los campos como Date

	SELECT * FROM LM_Viajes

	CREATE OR ALTER FUNCTION EstacionesRecorridas (@FechaI DATE,@FechaF DATE)
	RETURNS TABLE
	RETURN (
	SELECT Tren,COUNT(estacion) AS NºEstaciones FROM LM_Recorridos WHERE Momento BETWEEN @FechaI AND @FechaF GROUP BY Tren
	);

	SELECT * FROM dbo.EstacionesRecorridas('2017-02-26 02:20:00.000','2017-02-27 14:01:00.000')

--2.	Crea una función inline que nos devuelva el número de veces que cada usuario ha entrado en el metro en un periodo de tiempo.
--El principio y el fin de ese periodo se pasarán como parámetros. Nota: tomar los campos como date

	CREATE OR ALTER FUNCTION VecesMetro (@FechaI DATE,@FechaF DATE)
	RETURNS TABLE
	RETURN (
	SELECT P.ID,P.Nombre,COUNT(V.MomentoEntrada) AS NºEstaciones FROM LM_Pasajeros P INNER JOIN LM_Tarjetas T ON P.ID = T.IDPasajero INNER JOIN LM_Viajes V ON T.ID = V.IDTarjeta WHERE MomentoEntrada BETWEEN @FechaI AND @FechaF GROUP BY P.ID,P.Nombre
	);

	SELECT * FROM dbo.VecesMetro ('2017-02-24 16:50:00','2017-02-25 08:48:00')

--4.	Crea una función inline que nos diga el número de personas que han pasado por una estacion en un periodo de tiempo. 
--Se considera que alguien ha pasado por una estación si ha entrado o salido del metro por ella.
--El principio y el fin de ese periodo se pasarán como parámetros

	CREATE OR ALTER FUNCTION NºPersonas (@FechaI DATE,@FechaF DATE)
	RETURNS TABLE
	RETURN (
	SELECT E.ID AS Estacion,COUNT(P.ID) AS NºPersonas FROM LM_Pasajeros P INNER JOIN LM_Tarjetas T ON P.ID = T.IDPasajero INNER JOIN LM_Viajes V ON T.ID = V.IDTarjeta INNER JOIN LM_Estaciones E ON V.ID = E.ID WHERE V.MomentoEntrada BETWEEN @FechaI AND @FechaF OR V.MomentoSalida BETWEEN @FechaI AND @FechaF GROUP BY E.ID
	);

	SELECT * FROM dbo.NºPersonas ('2017-02-24 16:50:00','2017-04-25 08:48:00')

--5.	Crea una función inline que nos devuelva los kilómetros que ha recorrido cada línea. 



--7.	Crea una función inline que nos devuelva el tiempo total que cada usuario ha pasado en el metro en un periodo de tiempo. 
--El principio y el fin de ese periodo se pasarán como parámetros. Se devolverá ID, nombre y apellidos del pasajero. 
--El tiempo se expresará en horas y minutos.
