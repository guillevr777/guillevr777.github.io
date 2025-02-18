
--1. Número de libros que tratan de cada tema

SELECT type AS Tema, COUNT(title_id) AS NumeroLibros FROM titles GROUP BY type;

--2. Número de autores diferentes en cada ciudad y estado

SELECT city, state, COUNT(DISTINCT au_id) AS NumeroAutores FROM authors GROUP BY city, state;

--3. Nombre, apellidos, nivel y antigüedad en la empresa de los empleados con un nivel entre 100 y 150.

SELECT fname, lname, job_lvl, DATEDIFF(YEAR, hire_date, GETDATE()) AS Antiguedad FROM employee WHERE job_lvl BETWEEN 100 AND 150;

--4. Número de editoriales en cada país. Incluye el país.

SELECT country, COUNT(pub_id) AS NumeroEditoriales FROM publishers GROUP BY country;

--5. Número de unidades vendidas de cada libro en cada año (title_id, unidades y año).

SELECT title_id, SUM(qty) AS UnidadesVendidas, YEAR(ord_date) AS Anio FROM sales GROUP BY title_id, YEAR(ord_date) ORDER BY title_id, Anio;

--6. Número de autores que han escrito cada libro (title_id y número de autores).

SELECT title_id, COUNT(au_id) AS NumeroAutores FROM titleauthor GROUP BY title_id;

--7. ID, Título, tipo y precio de los libros cuyo adelanto inicial (advance) tenga un valor superior a $7.000, ordenado por tipo y título

SELECT title_id, title, type, price FROM titles WHERE advance > 7000 ORDER BY type, title;