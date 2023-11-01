create database pizza;
use pizza;
show tables;
select * from pizza_sales;

-- 1. Total Revenue --
select SUM(total_price) as Total_Revenue from pizza_sales;

-- 2. Average order value -- //used DISTINCT because there are some duplicate values// --
select SUM(total_price) / COUNT(DISTINCT order_id) as Avg_Order_Value from pizza_sales;

-- 3. Total pizzas sold -- 
select SUM(quantity) as Total_Pizza_Sold from pizza_sales;

-- 4. Total orders placed --
select COUNT(DISTINCT order_id) as Total_Orders from pizza_sales;

-- 5. Average pizzas per order -- 
select CAST(CAST(SUM(quantity) as DECIMAL(10,2)) / 
CAST(COUNT(DISTINCT order_id) as DECIMAL(10,2)) as DECIMAL(10,2)) as AVG_Pizzas_Per_Order from pizza_sales;

-- /////////////CHARTS REQUIREMENT////////////// --
-- B. Hourly Trend for Total Pizzas Sold --
SELECT EXTRACT(HOUR FROM order_time) as order_hours, SUM(quantity) as total_pizzas_sold
from pizza_sales
group by EXTRACT(HOUR FROM order_time)
order by EXTRACT(HOUR FROM order_time);

-- C. Weekly Trend for Orders -- 
SELECT WEEKofyear(STR_TO_DATE(order_date, '%d-%m-%Y'))AS WeekNumber, YEAR(STR_TO_DATE(order_date, '%d-%m-%Y')) AS Year, COUNT(DISTINCT order_id) AS Total_orders
FROM pizza_sales
GROUP BY WEEKofyear(STR_TO_DATE(order_date, '%d-%m-%Y')), YEAR(STR_TO_DATE(order_date, '%d-%m-%Y'))
ORDER BY Year,WeekNumber;

-- D. % of Sales by Pizza Category --
SELECT pizza_category, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_category;

-- E. % of Sales by Pizza Size --
SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_size
ORDER BY pizza_size;

-- F. Total Pizzas Sold by Pizza Category --///////////////
SELECT pizza_category, SUM(quantity) as Total_Quantity_Sold
FROM pizza_sales
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC;


-- G. Top 5 Pizzas by Revenue --
SELECT pizza_name, SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC
LIMIT 5;

-- H. Bottom 5 Pizzas by Total Orders --
SELECT pizza_name, SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue ASC
LIMIT 5;

-- I. Top 5 Pizzas by Quantity --
SELECT pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold DESC
LIMIT 5;

-- J. Bottom 5 Pizzas by Quantity --
SELECT pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold ASC
LIMIT 5;

-- K. Top 5 Pizzas by Total Orders --
SELECT pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders DESC
LIMIT 5;

-- L. Borrom 5 Pizzas by Total Orders --
SELECT pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders ASC
LIMIT 5;







