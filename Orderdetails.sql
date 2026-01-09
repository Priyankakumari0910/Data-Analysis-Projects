create database OrderDetails;

CREATE TABLE Salespeople (
    snum INT PRIMARY KEY,
    sname VARCHAR(50),
    city VARCHAR(50),
    comm DECIMAL(4,2)
);

INSERT INTO Salespeople (snum, sname, city, comm) VALUES
(1001, 'Peel', 'London', 0.12),
(1002, 'Serres', 'San Jose', 0.13),
(1003, 'Axelrod', 'New York', 0.10),
(1004, 'Motika', 'London', 0.11),
(1007, 'Rafkin', 'Barcelona', 0.15);

CREATE TABLE Cust (
    cnum INT PRIMARY KEY,
    cname VARCHAR(50),
    city VARCHAR(50),
    rating INT,
    snum INT,
    FOREIGN KEY (snum) REFERENCES Salespeople(snum)
);

INSERT INTO Cust (cnum, cname, city, rating, snum) VALUES
(2001, 'Hoffman', 'London', 100, 1001),
(2002, 'Giovanne', 'Rome', 200, 1003),
(2003, 'Liu', 'San Jose', 300, 1002),
(2004, 'Grass', 'Berlin', 100, 1002),
(2006, 'Clemens', 'London', 300, 1007),
(2007, 'Pereira', 'Rome', 100, 1004),
(2008, 'James', 'London', 200, 1007);

CREATE TABLE Orders (
    onum INT PRIMARY KEY,
    amt DECIMAL(10,2),
    odate DATE,
    cnum INT,
    snum INT,
    FOREIGN KEY (cnum) REFERENCES Cust(cnum),
    FOREIGN KEY (snum) REFERENCES Salespeople(snum)
);

INSERT INTO Orders (onum, amt, odate, cnum, snum) VALUES
(3001, 18.69, '1994-10-03', 2008, 1007),
(3002, 1900.10, '1994-10-03', 2007, 1004),
(3003, 767.19, '1994-10-03', 2001, 1001),
(3005, 5160.45, '1994-10-03', 2003, 1002),
(3006, 1098.16, '1994-10-04', 2008, 1007),
(3007, 75.75, '1994-10-05', 2004, 1002),
(3008, 4723.00, '1994-10-05', 2006, 1001),
(3009, 1713.23, '1994-10-04', 2002, 1003),
(3010, 1309.95, '1994-10-06', 2004, 1002),
(3011, 9891.88, '1994-10-06', 2006, 1001);


-- Q.4

SELECT 
    s.sname AS Salesperson,
    c.cname AS Customer,
    s.city AS City
FROM 
    Salespeople s
JOIN 
    Cust c
ON 
    s.city = c.city;
    
    
-- Q.5    

SELECT 
    c.cname AS Customer, s.sname AS Salesperson
FROM
    cust c
        JOIN
    salespeople s ON c.snum = s.snum;
    
 
-- Q.6 
 
SELECT o.onum, c.cname, s.sname, c.city AS customer_city, s.city AS salesperson_city
FROM orders o
JOIN Cust c ON o.cnum = c.cnum
JOIN salespeople s ON o.snum = s.snum
WHERE c.city <> s.city;


-- Q.7

SELECT o.onum, c.cname
FROM orders o
JOIN cust c
ON o.cnum = c.cnum;


-- Q.8

SELECT c1.cname AS Customer1, c2.cname AS Customer2, c1.rating
FROM cust c1
JOIN cust c2
ON c1.rating = c2.rating
AND c1.cnum < c2.cnum;


-- Q.9

SELECT c1.cname AS Customer1, c2.cname AS Customer2, c1.snum
FROM cust c1
JOIN cust c2
ON c1.snum = c2.snum
AND c1.cnum < c2.cnum;


-- Q.10

SELECT s1.sname AS Salesperson1, s2.sname AS Salesperson2, s1.city
FROM salespeople s1
JOIN salespeople s2
ON s1.city = s2.city
AND s1.snum < s2.snum;


-- Q.11

SELECT o.onum, o.snum
FROM orders o
WHERE o.snum = (
    SELECT snum FROM cust WHERE cnum = 2008
);


-- Q.12

SELECT *
FROM orders
WHERE amt > (
    SELECT AVG(amt)
    FROM orders
    WHERE odate = '1990-10-04'
);


-- Q.13

SELECT o.onum, o.amt, s.sname, s.city
FROM orders o
JOIN salespeople s ON o.snum = s.snum
WHERE s.city = 'London';


-- Q.14

SELECT c.*
FROM cust c
WHERE c.cnum = (
    SELECT snum + 1000 FROM salespeople WHERE sname = 'Serres'
);


-- Q.15

SELECT COUNT(*) AS Count_Above_Avg
FROM cust
WHERE rating > (
    SELECT AVG(rating)
    FROM cust
    WHERE city = 'San Jose'
);


-- Q.16

SELECT s.sname, COUNT(c.cnum) AS Total_Customers
FROM salespeople s
JOIN cust c ON s.snum = c.snum
GROUP BY s.sname
HAVING COUNT(c.cnum) > 1;




