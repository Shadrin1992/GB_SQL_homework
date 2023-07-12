DROP TABLE IF EXISTS cars;
CREATE TABLE IF NOT EXISTS cars 
(
	id INT PRIMARY KEY AUTO_INCREMENT, 
	name VARCHAR(40) NOT NULL,
	cost INT NOT NULL
);

INSERT INTO cars(name, cost) VALUES
("Audi", 52642),
("Mercedes", 57127),
("Skoda", 9000),
("Volvo", 29000),
("Bentley", 350000),
("Citroen", 21000),
("Hummer", 41400),
("Volkswagen", 21600);

SELECT * FROM cars;

-- 1. Создайте представление, в которое попадут автомобили стоимостью до 25000 долларов.


CREATE VIEW cheap_cars AS 
SELECT name FROM cars
WHERE cost < 25000;

SELECT * FROM cheap_cars;    


-- 2. Изменить в существующем представлении порог для стоимости: 
-- пусть цена будет до 30 000 долларов (используя оператор ALTER VIEW).

ALTER VIEW cheap_cars
AS SELECT name
FROM cars
WHERE cost < 30000;

SELECT * FROM cheap_cars; 

-- 3.  Создайте представление, в котором будут только автомобили марки “Шкода” и “Ауди”.

CREATE VIEW skoda_and_audi
AS SELECT *
FROM cars
WHERE name IN ("Audi", "Skoda");

SELECT * FROM skoda_and_audi;

-- 4. Вывести название и цену для всех анализов, которые продавались 5 февраля 2020 и всю следующую неделю.

DROP TABLE IF EXISTS Analysis;
CREATE TABLE Analysis
(
	an_id INT PRIMARY KEY, 
	an_name VARCHAR(20) NOT NULL,
	an_cost INT NOT NULL,
    an_price INT NOT NULL,
    an_group VARCHAR(40) NOT NULL
);

INSERT INTO Analysis (an_id, an_name, an_cost, an_price, an_group)
VALUES
(1, "an_101", 300, 800, "A"),
(2, "an_102", 250, 600, "A"),
(3, "an_103", 400, 800, "A"),
(4, "an_104", 200, 500, "B"),
(5, "an_105", 230, 650, "B"),
(6, "an_106", 330, 700, "C"),
(7, "an_107", 280, 680, "C"),
(8, "an_108", 310, 580, "C");

SELECT * FROM Analysis;

DROP TABLE IF EXISTS Grups;

CREATE TABLE Grups
(
	gr_id INT PRIMARY KEY, 
	gr_name VARCHAR(20) NOT NULL,
	gr_temp INT NOT NULL
);

INSERT INTO Grups (gr_id, gr_name, gr_temp)
VALUES
(1, "A", 15),
(2, "B", 10),
(3, "C", 5);

SELECT * FROM Grups;

DROP TABLE IF EXISTS Orders;

CREATE TABLE Orders
(
	ord_id INT PRIMARY KEY, 
	ord_datetime DATE NOT NULL,
	ord_an INT NOT NULL
);

INSERT INTO Orders (ord_id, ord_datetime, ord_an)
VALUES
(1, "2020-01-25 00:00:00", 101),
(2, "2020-01-29 00:00:00", 104),
(3, "2020-02-01 00:00:00", 101),
(4, "2020-02-05 00:00:00", 103),
(5, "2020-02-08 00:00:00", 102),
(6, "2020-02-09 00:00:00", 106),
(7, "2020-02-11 00:00:00", 103),
(8, "2020-02-12 00:00:00", 101),
(9, "2020-02-13 00:00:00", 108),
(10, "2020-02-14 00:00:00", 104),
(11, "2020-02-15 00:00:00", 105);

SELECT * FROM Orders;

SELECT an_name, an_price, ord_datetime
FROM Analysis
JOIN Orders
ON Analysis.an_id = Orders.ord_id
AND Orders.ord_datetime >= '2020-02-05'
AND Orders.ord_datetime <= '2020-02-12';
SELECT * FROM Orders;


-- 5. Добавьте новый столбец под названием "Время до следующей станции". 

DROP TABLE IF EXISTS train;
CREATE TABLE train (
  train_id integer NOT NULL,
  station varchar(20) NOT NULL,
  station_time time NOT NULL
);

INSERT train 
    (train_id, station, station_time)
  VALUES 
    (110, 'San Francisco', '10:00:00'),
    (110, 'Redwood City', '10:54:00'),
    (110, 'Palo Alto', '11:02:00'),
    (110, 'San Jose', '12:35:00'),
    (120, 'San Francisco', '11:00:00'),
    (120, 'Palo Alto', '12:49:00'),
    (120, 'San Jose', '13:30:00');
    
SELECT * FROM train;

SELECT *,
	SUBTIME(LEAD(station_time) OVER(PARTITION BY train_id ORDER BY station_time), station_time) 
	AS time_to_next_station 
FROM train