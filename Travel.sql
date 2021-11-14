create database travel;

/*1. You are required to create two tables PASSENGER and PRICE with the following
attributes and properties */

CREATE TABLE IF NOT EXISTS travel.passenger (
    passenger_id INT NOT NULL AUTO_INCREMENT,
    passenger_name VARCHAR(50),
    category VARCHAR(25),
    gender VARCHAR(1),
    boarding_city VARCHAR(25),
    destination_city VARCHAR(25),
    distance INT,
    bus_type VARCHAR(7),
    PRIMARY KEY (passenger_id)
);

CREATE TABLE IF NOT EXISTS travel.price (
    bus_type VARCHAR(7),
    distance INT,
    price INT
);
 
 /*2.  Insert the following data in the tables*/
 insert into travel.passenger (passenger_name,category,gender,boarding_city,destination_city,distance,bus_type) 
 values("Sejal","AC",'F', "Bengaluru", "Chennai", 350, "Sleeper");
insert into travel.passenger (passenger_name,category,gender,boarding_city,destination_city,distance,bus_type) 
 values("Anmol", "Non-AC", 'M'," Mumbai", "Hyderabad", 700,"Sitting");
insert into travel.passenger (passenger_name,category,gender,boarding_city,destination_city,distance,bus_type) 
 values("Pallavi", "AC", 'F', "Panaji", "Bengaluru", 600, "Sleeper");
insert into travel.passenger (passenger_name,category,gender,boarding_city,destination_city,distance,bus_type) 
 values("Khusboo", "AC", 'F', "Chennai", "Mumbai", 1500, "Sleeper");
insert into travel.passenger (passenger_name,category,gender,boarding_city,destination_city,distance,bus_type) 
 values("Udit", "Non-AC", 'M', "Trivandrum", "panaji", 1000, "Sleeper");
insert into travel.passenger (passenger_name,category,gender,boarding_city,destination_city,distance,bus_type) 
 values("Ankur", "AC", 'M', "Nagpur", "Hyderabad", 500, "Sitting");
insert into travel.passenger (passenger_name,category,gender,boarding_city,destination_city,distance,bus_type) 
 values("Hemant", "Non-AC", 'M', "panaji", "Mumbai", 700, "Sleeper");
insert into travel.passenger (passenger_name,category,gender,boarding_city,destination_city,distance,bus_type) 
 values("Manish", "Non-AC", 'M', "Hyderabad", "Bengaluru", 500 ,"Sitting");
insert into travel.passenger (passenger_name,category,gender,boarding_city,destination_city,distance,bus_type) 
 values("Piyush", "AC", 'M', "Pune", "Nagpur", 700, "Sitting");
 
insert into travel.price (bus_type,distance,price) values("Sleeper", 350, 770);
insert into travel.price (bus_type,distance,price) values("Sleeper", 500, 1100);
insert into travel.price (bus_type,distance,price) values("Sleeper", 600, 1320);
insert into travel.price (bus_type,distance,price) values("Sleeper", 700, 1540);
insert into travel.price (bus_type,distance,price) values("Sleeper", 1000, 2200);
insert into travel.price (bus_type,distance,price) values("Sleeper", 1200, 2640);
insert into travel.price (bus_type,distance,price) values("Sleeper", 350, 434);
insert into travel.price (bus_type,distance,price) values("Sitting", 500, 620);
insert into travel.price (bus_type,distance,price) values("Sitting", 500, 620);
insert into travel.price (bus_type,distance,price) values("Sitting", 600, 744);
insert into travel.price (bus_type,distance,price) values("Sitting", 700, 868);
insert into travel.price (bus_type,distance,price) values("Sitting", 1000, 1240);
insert into travel.price (bus_type,distance,price) values("Sitting", 1200, 1488);
insert into travel.price (bus_type,distance,price) values("Sitting", 1500, 1860);

select * from travel.price;

/* 3. How many females and how many male passengers travelled for a minimum distance of
600 KM s?*/

SELECT 
    COUNT(gender), gender
FROM
    travel.passenger
WHERE
    distance >= 600
GROUP BY gender;

/* 4. Find the minimum ticket price for Sleeper Bus.*/

SELECT 
    MIN(price), bus_type
FROM
    travel.price
WHERE
    bus_type = 'Sleeper';

/* 5. Select passenger names whose names start with character 'S' */

SELECT 
    *
FROM
    travel.passenger
WHERE
    passenger_name LIKE 'S%';

/* 6. Calculate price charged for each passenger displaying Passenger name, Boarding City,
Destination City, Bus_Type, Price in the output*/

SELECT 
    passenger_name,
    boarding_city,
    destination_city,
    pa.bus_type,
    pr.price
FROM
    travel.passenger pa,
    travel.price pr
WHERE
    pa.bus_type = pr.bus_type
        AND pa.distance = pr.distance;

/* 7.What is the passenger name and his/her ticket price who travelled in Sitting bus for a
distance of 1000 KM s */

SELECT 
    passenger_name, price
FROM
    travel.passenger pa
        JOIN
    travel.price pr ON pa.bus_type = pr.bus_type
WHERE
    pa.bus_type = 'Sitting'
        AND pa.distance = 1000;

/* 8. What will be the Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to
Panaji?*/

SELECT 
    pr.distance, pa.passenger_name, pr.bus_type, pr.price
FROM
    travel.price pr
        JOIN
    travel.passenger pa ON pr.distance = pa.distance
WHERE
    pa.passenger_name = 'Pallavi'
        AND (pr.bus_type = 'Sleeper'
        OR pr.bus_type = 'Sitting');
    
/* 9. List the distances from the "Passenger" table which are unique (non-repeated
distances) in descending order.*/

SELECT 
	DISTINCT(distance)
FROM
    travel.passenger
ORDER BY distance DESC;

/*10.Display the passenger name and percentage of distance travelled by that passenger
from the total distance travelled by all passengers without using user variables*/

SELECT 
    passenger_name,
    distance * 100 / pa.dist AS 'percent of distance'
FROM
    travel.passenger
        CROSS JOIN
    (SELECT 
        SUM(distance) AS dist
    FROM
        travel.passenger) pa;

/* 11. Display the distance, price in three categories in table Price
a) Expensive if the cost is more than 1000
b) Average Cost if the cost is less than 1000 and greater than 500
c) Cheap otherwise*/

SELECT 
    distance,
    price,
    CASE
        WHEN price >= 1000 THEN 'Expensive'
        WHEN price < 1000 AND price > 500 THEN 'Average Cost'
        ELSE 'Cheap'
    END AS Categories
FROM
    travel.price;
    