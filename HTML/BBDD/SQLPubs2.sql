
--1. N�mero de libros que tratan de cada tema

SELECT type AS Tema, COUNT(title_id) AS NumeroLibros FROM titles GROUP BY type;

--2. N�mero de autores diferentes en cada ciudad y estado

SELECT city, state, COUNT(DISTINCT au_id) AS NumeroAutores FROM authors GROUP BY city, state;

--3. Nombre, apellidos, nivel y antig�edad en la empresa de los empleados con un nivel entre 100 y 150.

SELECT fname, lname, job_lvl, DATEDIFF(YEAR, hire_date, GETDATE()) AS Antiguedad FROM employee WHERE job_lvl BETWEEN 100 AND 150;

--4. N�mero de editoriales en cada pa�s. Incluye el pa�s.

SELECT country, COUNT(pub_id) AS NumeroEditoriales FROM publishers GROUP BY country;

--5. N�mero de unidades vendidas de cada libro en cada a�o (title_id, unidades y a�o).

SELECT title_id, SUM(qty) AS UnidadesVendidas, YEAR(ord_date) AS Anio FROM sales GROUP BY title_id, YEAR(ord_date) ORDER BY title_id, Anio;

--6. N�mero de autores que han escrito cada libro (title_id y n�mero de autores).

SELECT title_id, COUNT(au_id) AS NumeroAutores FROM titleauthor GROUP BY title_id;

--7. ID, T�tulo, tipo y precio de los libros cuyo adelanto inicial (advance) tenga un valor superior a $7.000, ordenado por tipo y t�tulo

SELECT title_id, title, type, price FROM titles WHERE advance > 7000 ORDER BY type, title;