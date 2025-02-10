
--1. T�tulo, precio y notas de los libros (titles) que tratan de cocina, ordenados de mayor a menor precio.
SELECT title,price,notes FROM titles WHERE (type like 'mod_cook' or type like '%cook%')
		ORDER BY PRICE DESC;

--2. ID, descripci�n y nivel m�ximo y m�nimo de los puestos de trabajo (jobs) que pueden tener un nivel 110.
SELECT job_id,job_desc FROM jobs WHERE (max_lvl >= 110 AND min_lvl < 110);

--3. T�tulo, ID y tema de los libros que contengan la palabra "and� en las notas
SELECT title,title_id,type FROM titles where (notes like 'and');

--4. Nombre y ciudad de las editoriales (publishers) de los Estados Unidos que no est�n en California ni en Texas
SELECT pub_name,city FROM publishers WHERE country = 'USA' AND state not in ('CA','TX');

--5. T�tulo, precio, ID de los libros que traten sobre psicolog�a o negocios y cuesten entre diez y 20 d�lares.
SELECT title,price,title_id FROM titles where (type like 'business' or type like 'psychology' AND price between 20 AND 30);

--6. Nombre completo (nombre y apellido) y direcci�n completa de todos los autores que no viven en California ni en Oreg�n.
SELECT pub_name,city,state,country FROM publishers where state not like 'CA' AND state not like 'OR';

--7. Nombre completo y direcci�n completa de todos los autores cuyo apellido empieza por D, G o S.
SELECT au_lname,au_fname,address,city,state,zip FROM authors where au_lname not like '[DGS%]';

--8. ID, nivel y nombre completo de todos los empleados con un nivel inferior a 100, ordenado alfab�ticamente
SELECT emp_id,job_lvl,fname,lname FROM employee where job_lvl < 100;

---------------------------------------------------------

SELECT * FROM authors
--1. Inserta un nuevo autor.
INSERT INTO authors VALUES ('174-45-2315','Guillemo','Villanueva',627198-2772,'13 Pirineos','Sevilla','ES','74823',1);

SELECT * FROM titles
--2. Inserta dos libros, escritos por el autor que has insertado antes y publicados por la editorial "Ramona publishers�.
INSERT INTO titles VALUES ('GU1042','Ivan es un ','psychology',0777,0.99,15000,45,10000,'its about the atopic of the ',CURRENT_TIMESTAMP);
INSERT INTO titles VALUES ('GU1082','Roman es un poco malo','psychology',0778,12,145,45,1000,'it happennds whle playing league of legends',CURRENT_TIMESTAMP);

SELECT * FROM jobs
--3. Modifica la tabla jobs para que el nivel m�nimo sea 90.
ALTER TABLE jobs ADD CONSTRAINT chk_min_lvl CHECK (min_lvl >= 90);

SELECT * FROM publishers
--4. Crea una nueva editorial (publihers) con ID 9908, nombre Mostachon Books y sede en Utrera.
INSERT INTO publishers VALUES (9908,'Mostachon Books','Utrera','EU','ESP');

SELECT * FROM publishers
--5. Cambia el nombre de la editorial con sede en Alemania para que se llame "Machen W�cher" y traslasde su sede a Stuttgart
UPDATE publishers SET pub_name = 'Machen Wucher', country = 'Stuttgart' WHERE country = 'Germany';