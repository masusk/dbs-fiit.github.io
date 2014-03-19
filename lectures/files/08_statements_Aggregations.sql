-- hrackarsky priklad. Chcem si vyselectovat nejaky upraveny stlpec a zaroven podla neho filtrovat
SELECT *, vsp * 2 as double_vsp FROM students
WHERE vsp * 2 > 5

-- ukazka subselect vo FROM 
-- v tomto hrackarskom priklade som nechcel duplikovat vsp * 2 - vypocet nad stlpcami - do where casti
SELECT *
FROM (select id, name, vsp * 2 as double_vsp
from students) s2
where double_vsp > 5;

-- hrackarsky priklad: subselect medzi atributmi (toto ukazuje, ze ak je to jedna hodnota, tak mozem)
SELECT r.name, r.capacity, "1" as moj_stlpec FROM restaurants r;

-- vsetky jedalne a najvyssie vsp ku kazdej z nich (ukazka subselectu medzi atributmi)
SELECT r.name,
(SELECT DISTINCT vsp
	FROM students s
	JOIN lunches l ON s.id = l.student_id
	WHERE l.restaurant_id = r.id
	AND vsp >= ALL (SELECT vsp FROM students s
				JOIN lunches l ON s.id = l.student_id
				WHERE l.restaurant_id = r.id)
) as vsp
FROM restaurants r;

-- ak by som chcel nie vsp, ale meno (teda nieco, co mi vrati viac riadkov) tak mi to zlyha
SELECT r.name,
(SELECT DISTINCT s.name
	FROM students s
	JOIN lunches l ON s.id = l.student_id
	WHERE l.restaurant_id = r.id
) as vsp
FROM restaurants r;


-- vratme sa k vsp...a spravme ho cez GROUP BY
SELECT r.name, max(vsp) 
FROM restaurants r
JOIN lunches l ON l.restaurant_id = r.id
JOIN students s ON l.student_id = s.id
GROUP BY r.name

-- agregacie
-- SELECT A1,...,An
-- FROM T1,T2,T3,...
-- [JOIN...]
-- WHERE cond 
-- GROUP BY attrs
-- HAVING cond2

-- priemer vsetkych studentov
SELECT avg(vsp) as priemer FROM students;

-- priemer vsetkych studentov, ktori jedia v hornej
SELECT avg(vsp) 
FROM students s
JOIN lunches l ON l.student_id = s.id
JOIN restaurants r ON r.id = l.restaurant_id
WHERE r.name LIKE 'horna';

-- skutocne to tak je? Pozor na duplicity, ktore nam JOIN nevyfiltruje
-- este raz to iste, tentokrat spravne
SELECT avg(vsp)
FROM students s
where s.id IN 
(SELECT l.student_id 
	FROM lunches l
	JOIN restaurants r ON r.id = l.restaurant_id 
	WHERE r.name LIKE 'horna');

-- pocet jedalni, ktorych kapacita je viac ako 90
SELECT count(*)
FROM restaurants s
WHERE capacity > 90;

-- pocet obedov, ktore boli vydane v hornej jedalni
SELECT count(*)
FROM lunches l
JOIN restaurants r ON r.id = l.restaurant_id 
WHERE r.name LIKE 'horna';

-- pocet ludi, ktori jedli v hornej jedalni
-- vsimnite si ten distinct
SELECT count(distinct l.student_id)
FROM lunches l
JOIN restaurants r ON r.id = l.restaurant_id 
WHERE r.name LIKE 'horna';

-- rozdiel vsp hornej a ostatnych jedalni
-- vytvorime si tabulku horna s jedinou hodnotou - avg(vsp)
-- vytvorime si tabulku nehorna s jedinou hodnotou - avg(vsp)
-- selectneme si rozdiel tych dvoch riadkov
SELECT horna.vsp - nehorna.druhy_vsp
FROM
	(SELECT avg(vsp) as vsp FROM students s
		WHERE s.id IN 
			(SELECT l.student_id FROM lunches l WHERE l.restaurant_id = 1)) as horna
	,
	(SELECT avg(vsp) as druhy_vsp FROM students s
		WHERE s.id NOT IN 
			(SELECT l.student_id FROM lunches l WHERE l.restaurant_id = 1)) as nehorna;

-- to cele inak (selectneme si rovno hodnoty a odpocitame)
SELECT DISTINCT
	(SELECT avg(vsp) as vsp FROM students s
		WHERE s.id IN 
			(SELECT l.student_id FROM lunches l WHERE l.restaurant_id = 1)) -
	(SELECT avg(vsp) as druhy_vsp FROM students s
		WHERE s.id NOT IN 
			(SELECT l.student_id FROM lunches l WHERE l.restaurant_id = 1))


-- GROUP BY
SELECT student_id, count(*)
FROM lunches
GROUP BY student_id;

-- pridajte si do restaurants location (intraky a fakulty), inak Vam to nepojde :)
-- ked chceme vidiet-ladit, co nam spravi GROUP BY, tak ho simulujeme ORDER BY
SELECT * FROM restaurants ORDER BY location;

-- chceme celkovu kapacitu jednotlivych locations
SELECT location, sum(capacity) FROM restaurants GROUP BY location;

-- kto kde kolkokrat obedoval
SELECT student_id, restaurant_id, count(*)
FROM lunches
GROUP BY student_id, restaurant_id;

-- mozem si vypytat aj iny atribut ako je ten, podla ktoreho groupujem
-- aka vsak bude jeho hodnota?
-- kazde student_id ma prave jedno meno, takze tu to bude ok (MySQL) alebo nie? (Postgres)
SELECT student_id, s.name, count(*)
FROM lunches l
JOIN students s ON s.id = l.student_id
GROUP BY student_id -- ,s.name

-- ibaze by sme groupovali podla niecoho, o com postgres vie, ze je to primary key...
SELECT s.id, s.name, count(*)
FROM lunches l
JOIN students s ON s.id = l.student_id
GROUP BY s.id

-- dokaz (ak by niekto potreboval...)
SELECT student_id, s.name
FROM lunches l
JOIN students s ON s.id = l.student_id
ORDER BY student_id;

-- chceme pocet roznych restauracii kde student obedoval - to je este v poriadku
-- ale meno restauracie nam MySQL vrati nahodne, Postgres mlci
SELECT student_id, s.name, count(distinct restaurant_id) -- ,r.name
FROM lunches l
JOIN students s ON s.id = l.student_id
JOIN restaurants r ON r.id = l.restaurant_id
GROUP BY student_id, s.name;

-- chceme aj studentov, ktori nikdy neobedovali
-- riesenie cez union
SELECT s.name, count(distinct restaurant_id) as pocet
FROM lunches l
JOIN students s ON s.id = l.student_id
JOIN restaurants r ON r.id = l.restaurant_id
GROUP BY student_id
UNION
SELECT name, 0 as pocet FROM students WHERE id NOT IN (SELECT student_id FROM lunches);

-- lepsie riesenie cez RIGHT JOIN
SELECT s.name, count(distinct r.name)
FROM restaurants r
JOIN lunches l ON l.restaurant_id = r.id
RIGHT JOIN students s ON s.id = l.student_id
GROUP BY s.id;

-- asi najpochopitelnejsie je pouzit LEFT JOIN
SELECT *
FROM students s
LEFT JOIN lunches l ON l.student_id = s.id
LEFT JOIN restaurants r ON l.restaurant_id = r.id
ORDER BY s.id;

-- http://blog.codinghorror.com/a-visual-explanation-of-sql-joins/

-- chceme tie location, ktore maju viac ako dve jedalne
-- HAVING nam teda umozni filtrovat skupiny, ktore vzniknu po GROUP BY
SELECT location, sum(capacity)
FROM restaurants
GROUP BY location
HAVING count(*) > 2;

-- chceme si pripomenut priemernu kapacitu jedalni
SELECT avg(capacity) FROM restaurants;

-- chceme len tie locations, ktore maju jedalen, ktorej max kapacita je mensia ako priemerna
-- je to hrackarske, ale ukazuje, ze za HAVING sa mozeme do sytosti realizovat :)
SELECT location
FROM restaurants
GROUP BY location
HAVING max(capacity) < (SELECT avg(capacity) FROM restaurants);

-- trosku syntaxe...
-- DELETE FROM table WHERE cond

-- UPDATE table 
-- SET attr1 = val1, attr2 = val2
-- WHERE cond

-- tym, co neobedovali vytvorime zaznam o obede v hornej jedalni
INSERT INTO lunches(student_id, restaurant_id)
	SELECT s.id as student_id, r.id as restaurant_id 
	FROM students s, restaurants r
	WHERE s.id NOT IN (SELECT student_id FROM lunches)
	AND r.name LIKE 'horna';

-- zmazeme obedy studentom c. 6 a 7
DELETE FROM lunches where student_id = 6 or student_id = 7;
