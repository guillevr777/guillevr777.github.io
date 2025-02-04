
SELECT title,price,notes FROM titles WHERE (type like 'mod_cook' or type like 'trad_cook')
		ORDER BY PRICE DESC;

SELECT job_id,job_desc FROM jobs WHERE (max_lvl < 110);

SELECT title,title_id,type FROM titles where (notes like 'and');

SELECT pub_name,city FROM publishers WHERE country = 'USA' AND STATE = 'TX' OR 'CA';