-- 1. Creating the schema and required tables using sql script or using MySQL workbench UI

/* a. Create a schema named Travego.   */

CREATE SCHEMA IF NOT EXISTS Travego;

USE Travego;

/* b. Create the tables mentioned above with the mentioned column names.   */

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

/* c. Insert the data in the newly created tables using sql script or using MySQL UI.   */

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

-- 2. Perform read operation on the designed table created in the above task using SQL script. 

/* a. How many females and how many male passengers traveled a minimum distance of 600 KMs?  */

SELECT gender, count(gender) FROM passenger
WHERE distance <=600
GROUP BY gender;

/* b. Find the minimum ticket price of a Sleeper Bus. */

SELECT bus_type, min(price) AS min_price FROM price 
WHERE bus_type LIKE '%Sleeper%'
GROUP BY bus_type;

/* c. Select passenger names whose names start with character 'S' */ 

SELECT passenger_name FROM passenger
WHERE passenger_name LIKE 'S%';

/* d. Calculate price charged for each passenger displaying Passenger name, Boarding City, Destination City, Bus_Type,
        Price in the output  */
        
SELECT a.passenger_name, a.boarding_city, a.destination_city, a.bus_type, b.price 
FROM passenger a JOIN price b
ON a.passenger_id = b.id;
        
/* e. What are the passenger name(s) and the ticket price for those who traveled 1000 KMs Sitting in a bus?  */

SELECT a.passenger_name, a.distance, a.bus_type, b.price
FROM passenger a JOIN price b
ON a.passenger_id = b.id
WHERE a.distance = 1000 AND b.bus_type = 'sitting';   /*** Here we dont get output because there are no "sitting" for "distance=1000KMs" ***/

/* f. What will be the Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to Panaji?  */

SELECT a.passenger_name, a.boarding_city, a.destination_city, a.bus_type, b.price 
FROM passenger a JOIN price b
ON a.passenger_id = b.id
WHERE a.passenger_name = 'pallavi' AND a.bus_type in ('sitting', 'sleeper');     /*** for pallavi "bus_type is sleeper" in table so that
																					    the output we are getting is for sleeper only ***/

/* g. List the distances from the "Passenger" table which are unique (non-repeated distances) in descending order. */

SELECT distinct distance FROM passenger
ORDER BY distance DESC;

/* h. Display the passenger name and percentage of distance traveled by that passenger from the total distance traveled by 
      all passengers without using user variables */

SELECT passenger_name, round((distance/(SELECT sum(distance) FROM passenger))*100,2) AS percentage_of_distance FROM passenger;
