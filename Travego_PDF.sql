-- 1. Creating the schema and required tables using MySQL workbench 

/* a.Create a schema named Travego and create the tables mentioned above with the mentioned column names. Also, declare the relevant 
data types for each feature/column in the dataset.(5marks) show schemas;  */

CREATE SCHEMA IF NOT EXISTS Travego;

USE Travego;

CREATE TABLE IF NOT EXISTS passenger(
passenger_id INT NOT NULL PRIMARY KEY,
passenger_name VARCHAR(20),
category VARCHAR(20),
GENDER VARCHAR(20),
boarding_city VARCHAR(20),
destination_city VARCHAR(20),
distance INT,
bus_type VARCHAR(20)
);


CREATE TABLE price(
id INT NOT NULL PRIMARY KEY,
bus_type VARCHAR(20),
distance INT,
price INT
);

/* b. Insert the data in the newly created tables.(3marks)  */

INSERT INTO passenger VALUES
(1,'Sejal','AC','F','Bengaluru','Chennai',350,'Sleeper'),
(2,'Anmol','Non-AC','M','Mumbai','Hyderabad',700,'Sitting'),
(3,'Pallavi','AC','F','Panaji','Bengaluru',600,'Sleeper'),
(4,'Khusboo','AC','F','Chennai','Mumbai',1500,'Sleeper'),
(5,'Udit','Non-AC','M','Trivandrum','Panaji',1000,'Sleeper'),
(6,'Ankur','AC','M','Nagpur','Hyderabad',500,'Sitting'),
(7,'Hemant','Non-AC','M','Panaji','Mumbai',700,'Sleeper'),
(8,'Manish','Non-AC','M','Hyderabad','Bengaluru',500,'Sitting'),
(9,'Piyush','AC','M','Pune','Nagpur',700,'Sitting');


INSERT INTO price VALUES
(1,'Sleeper',350,770),
(2,'Sleeper',500,1100),
(3,'Sleeper',600,1320),
(4,'Sleeper',700,1540),
(5,'Sleeper',1000,2200),
(6,'Sleeper',1200,2640),
(7,'Sleeper',1500,2700),
(8,'Sitting',500,620),
(9,'Sitting',600,744),
(10,'Sitting',700,868),
(11,'Sitting',1000,1240),
(12,'Sitting',1200,1488),
(13,'Sitting',1500,1860)
;

SELECT * FROM passenger;

SELECT * FROM price;

-- 2.     
/* a.  How many female passengers traveled a minimum distance of 600KMs? (1mark)   */

SELECT count(passenger_name) AS female_passenger FROM passenger
WHERE gender LIKE 'F%' AND distance < 600; 

/* b. Write a query to display the passenger details whose travel distance is greater than 500 and 
who are traveling in a sleeper bus.(2marks)  */

SELECT * FROM passenger
WHERE distance > 500 AND bus_type = 'sleeper';

/* c.	Select passenger names whose names start with character 'S' */

SELECT passenger_name FROM passenger
WHERE passenger_name LIKE 'S%';

/* d.	Calculate price charged for each passenger displaying Passenger name, Boarding City, Destination City, Bus_Type, Price in the output  */

SELECT a.passenger_name, a.boarding_city, a.destination_city, a.bus_type, b.price 
FROM passenger a JOIN price b
ON a.passenger_id = b.id;

/* e.	What are the passenger name(s) and the ticket price for those who traveled 1000 KMs Sitting in a bus?  */

SELECT a.passenger_name, a.distance, a.bus_type, b.price
FROM passenger a JOIN price b
ON a.passenger_id = b.id
WHERE a.distance = 1000 AND b.bus_type = 'sitting';   /*** Here we dont get output because there are no "bus_type=sitting" for 
                                                                   "distance=1000 KMs" ***/

/* f.	What will be the Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to Panaji?  */

SELECT a.passenger_name, a.boarding_city, a.destination_city, a.bus_type, b.price 
FROM passenger a JOIN price b
ON a.passenger_id = b.id
WHERE a.passenger_name = 'pallavi' AND a.bus_type in ('sitting', 'sleeper');  /*** for pallavi "bus_type is sleeper" in table so the
																					    output we are getting is for sleeper only ***/

/* g.	Alter the column category with the value "Non-AC" where the Bus_Type is sleeper (2marks) */ 

-- SET sql_safe_updates = 0;

UPDATE passenger
SET category = 'Non-AC'
WHERE bus_type = 'Sleeper';

SELECT * FROM passenger;

/* h.Delete an entry from the table where the passenger name is Piyush and commit this change in the database.(1mark) */

DELETE FROM passenger
WHERE passenger_name = 'Piyush';

SELECT * FROM passenger;

/* i. Truncate the table passenger and comment on the number of rows in the table (explain if required).(1mark) */

TRUNCATE TABLE passenger;

SELECT * FROM passenger;   /**** After truncating the table "passenger",
                                    all the data's inside the table gets deleted so, there are no rows present in the table. ****/ 

/* j. Delete the table passenger from the database.(1mark)  */

DROP TABLE passenger;

SHOW tables;