DROP TABLE IF EXISTS AUTO;

CREATE TABLE  AUTO 
(       
	REGNUM VARCHAR(10) PRIMARY KEY, 
	MARK VARCHAR(10), 
	COLOR VARCHAR(15),
	RELEASEDT DATE, 
	PHONENUM VARCHAR(15)
);

INSERT INTO AUTO (REGNUM, MARK,	COLOR, RELEASEDT, PHONENUM )
VALUES
(111114,'LADA', 'КРАСНЫЙ', DATE '2008-01-01', '9152222221'),
(111115,'VOLVO', 'КРАСНЫЙ', DATE '2013-01-01', '9173333334'),
(111116,'BMW', 'СИНИЙ', DATE '2015-01-01', '9173333334'),
(111121,'AUDI', 'СИНИЙ', DATE '2009-01-01', '9173333332'),
(111122,'AUDI', 'СИНИЙ', DATE '2011-01-01', '9213333336'),
(111113,'BMW', 'ЗЕЛЕНЫЙ', DATE '2007-01-01', '9214444444'),
(111126,'LADA', 'ЗЕЛЕНЫЙ', DATE '2005-01-01', NULL),
(111117,'BMW', 'СИНИЙ', DATE'2005-01-01', NULL),
(111119,'LADA', 'СИНИЙ', DATE '2017-01-01', 9213333331);

SELECT * FROM AUTO;

-- 1. Вывести на экран, сколько машин каждого цвета для машин марок BMW и LADA.

SELECT MARK AS automark, COUNT(*) AS count
FROM AUTO
WHERE MARK IN ('BMW', 'LADA')
GROUP BY MARK;
    
-- 2. Вывести на экран марку авто (количество) и количество авто не этой марки.

SELECT MARK AS automark, 
(SELECT COUNT(*) FROM AUTO) - COUNT(*) AS other_count
FROM AUTO
GROUP BY MARK;

-- 3. Даны 2 таблицы. Напишите запрос, который вернет строки из таблицы test_a,
-- id которых нет в таблице test_b, НЕ используя ключевого слова NOT

DROP TABLE IF EXISTS test_a, test_b;
CREATE TABLE test_a 
(
id_number INT,
data VARCHAR(1)
);

CREATE TABLE test_b 
(id_number INT);

INSERT INTO test_a (id_number, data) 
VALUES (10, 'A'),
       (20, 'A'),
       (30, 'F'),
       (40, 'D'),
       (50, 'C');

INSERT INTO test_b (id_number) 
VALUES (10),
       (30),
       (50);

SELECT * FROM test_a;
SELECT * FROM test_b;

SELECT * FROM test_a
NATURAL LEFT JOIN test_b
WHERE test_b.id_number IS NULL;