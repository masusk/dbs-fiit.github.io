-- ---------------------------------
-- Kompletne najoinovane 
-- a skusme si to rozne sposoby zoradenia vysledkov, vzostupne, zostupne, cez viac fieldov
-- ---------------------------------
SELECT s.name, s.vsp, r.name,l.was_tasty
FROM students s
JOIN lunches l ON s.id = l.student_id
JOIN restaurants r ON l.restaurant_id = r.id;
-- ---------------------------------
-- Chceme vsetkych studentov, ktory maju rovnake vsp
-- problem je, ze mame aj kombinacie sameho so sebou a duplicity
-- skusme pridat taky WHERE, ktory nam to vyriesi
-- ---------------------------------
SELECT s1.id,s1.name, s1.vsp, s2.id,s2.name,s2.vsp
FROM students s1
JOIN students s2 ON s1.vsp = s2.vsp;
-- ---------------------------------
-- UNION robi distinct (mnozinova operacia), UNION ALL nerobi
-- chceme vsetky mena (studentov aj restauracii)
-- ako sa vola stlpec vo vyslednej relacii/tabulke?
-- ---------------------------------
SELECT name AS label FROM students
UNION ALL
SELECT name FROM restaurants
ORDER BY label;
-- ---------------------------------
-- Postgres ma INTERESECT (hoci ten nepotrebujeme, kedze je ekvivalent JOINu)
-- chceme id-cka studentov, ktori obedovali v jedalni 2 a 3
-- ---------------------------------
SELECT student_id FROM lunches WHERE restaurant_id = 2
INTERSECT
SELECT student_id FROM lunches WHERE restaurant_id = 3
-- ---------------------------------
-- MySQL nema INTERESECT (a ten nepotrebujeme, kedze je ekvivalent JOINu)
-- chceme id-cka studentov, ktori obedovali v jedalni 2 a 3
-- ---------------------------------
SELECT DISTINCT l1.student_id
FROM lunches l1
JOIN lunches l2 ON l1.student_id = l2.student_id
WHERE l1.restaurant_id = 2 AND l2.restaurant_id = 3;
-- ---------------------------------
-- iny sposob, cez subselect
-- ---------------------------------
SELECT l1.student_id
FROM lunches l1
WHERE l1.restaurant_id = 2 AND student_id IN
(SELECT l2.student_id FROM lunches l2 where l2.restaurant_id = 3);
-- ---------------------------------
-- Postgres ma MINUS (EXCEPT)
-- chceme studentov, ktori obedovali v 1ke a neobedovali v 2ke
-- ---------------------------------
SELECT student_id FROM lunches WHERE restaurant_id = 1
EXCEPT
SELECT student_id FROM lunches WHERE restaurant_id = 2;
-- ---------------------------------
-- MySQL nema MINUS (EXCEPT)
-- chceme studentov, ktori obedovali v 1ke a neobedovali v 2ke
-- ---------------------------------
SELECT l1.student_id
FROM lunches l1
WHERE l1.restaurant_id = 1
AND l1.student_id NOT IN
(SELECT l1.student_id
FROM lunches l1
WHERE l1.restaurant_id = 2);
-- ---------------------------------
-- Vsetci studenti, ktori obedovali v 1ke, cez JOIN
-- ---------------------------------
SELECT s.id FROM students s
JOIN lunches l ON l.student_id = s.id
WHERE l.restaurant_id = 1;
-- ---------------------------------
-- to iste cez subselect
-- ---------------------------------
SELECT s.id FROM students s
WHERE s.id IN
(SELECT student_id FROM lunches WHERE restaurant_id = 1);
-- ---------------------------------
-- Prve riesenie (cez JOIN) je problem, kedze nam vracia riadky z lunches, 
-- cize mozeme mat duplicity v id-cku studenta
-- teraz mozeme pouzit distinct, ale skuste si namiesto id-cka studenta vypytat vsp a pochopite...
-- ---------------------------------
-- Pokus o max vsp cez JOIN (FAIL)
-- ---------------------------------
SELECT s1.id,s1.vsp 
FROM students s1
JOIN students s2 ON s1.vsp > s2.vsp;
-- ---------------------------------
-- max VSP cez subquery (skuste si  aj MIN)
-- ---------------------------------
SELECT s1.id,s1.name,s1.vsp 
FROM students s1
WHERE NOT EXISTS (SELECT * FROM students s2 WHERE s1.vsp < s2.vsp);
-- ---------------------------------
-- to iste inak, dalsimi dvoma sposobmi
-- preco je tam mensie rovne? Skuste dat prec to rovne
-- ---------------------------------
SELECT * FROM students s1
where s1.vsp >= ALL (SELECT vsp FROM students s2);
-- ---------------------------------
SELECT * FROM students s1
where NOT s1.vsp < ANY (SELECT vsp FROM students s2);
-- ---------------------------------

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
SELECT r.name, r.capacity, '1' as moj_stlpec FROM restaurants r;

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
ALTER TABLE restaurants
ADD COLUMN location VARCHAR(50) DEFAULT 'intraky'

UPDATE restaurants
SET location = 'fakulty' WHERE name IN ('studentska', 'prifuk')

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




