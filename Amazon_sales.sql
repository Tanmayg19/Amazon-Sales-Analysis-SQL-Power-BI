CREATE TABLE sales (
Invoice_ID VARCHAR(12) PRIMARY KEY,
Branch VARCHAR(5),
City VARCHAR(15),
Customer_type VARCHAR(20),
Gender VARCHAR(10),
Product_line VARCHAR(25),
Unit_price FLOAT,
Quantity INT,
Tax FLOAT,
Total FLOAT,
Date DATE,
Time TIME,
Payment VARCHAR(25),
cogs FLOAT,
gross_margin_percentage FLOAT,
gross_income FLOAT,
Rating FLOAT);

select * from sales limit 10

####### Amazon Sales Data Analysis ######
-- Overview of Dataset --
-- The data consists of sales record of three cities/branch in Myanmar 
-- which are Naypyitaw, Yangon, Mandalay which took place in first quarter of year 2019 --
-- the data consists of 1000 rows and 17 columns --


-- Objective of Project --
-- The major aim of this project is to gain insight into the sales data of Amazon --
-- and to understand the different factors that affect sales of the different branches --
#-------------------------------------------------------------------------------------------------------#
SELECT Count(DISTINCT invoice_id) FROM sales
--- checking the null values---
SELECT COUNT(*) FROM sales WHERE NULL
-----------------------------------------------------------
-- Feature Engineering --
-- adding new columns dayname, monthname, timeofday by extracting values from date and time column --
-- this will help to analyse sales based on month, day of week, time of day --- 

ALTER TABLE sales
ADD day_name VARCHAR(10)

UPDATE sales 
SET day_name = TO_CHAR(date, 'FMDay')

ALTER TABLE sales
ADD month_name VARCHAR(10)

UPDATE sales
SET month_name = TO_CHAR(date, 'FMMonth')

ALTER TABLE sales
ADD COLUMN time_of_day VARCHAR(15) 

UPDATE sales
SET time_of_day = 
CASE
	WHEN time >= '00:00:00' AND time < '12:00:00' THEN 'Morning'
	WHEN time >= '12:00:00' AND time < '17:00:00' THEN 'Afternoon'
	ELSE 'Evening' END;

select * from sales limit 10

-- Answering Questions --

---# 1. What is the count of distinct cities in the dataset?
SELECT 
	COUNT(DISTINCT city) AS No_of_cities
FROM sales

---# 2. For each branch, what is the corresponding city?
SELECT 
	DISTINCT city, 
	branch 
FROM sales

-----# 3. What is the count of distinct product lines in the dataset?
SELECT 
	COUNT(DISTINCT product_line) AS No_of_productlines
FROM sales

---# 4. Which payment method occurs most frequently?
SELECT 
	payment, 
	COUNT(*) as count_of_paymentmethod
FROM sales
GROUP BY payment
ORDER BY 2 DESC

---# 5. Which product line has the highest sales?
SELECT 
	product_line,
	ROUND(CAST(SUM(total) as NUMERIC), 2) as total_sale
FROM sales
GROUP BY product_line
ORDER BY 2 DESC

--- # 6. How much revenue is generated each month?
SELECT 
	month_name,
	ROUND(CAST(SUM(total) as NUMERIC), 2) as monthly_revenue
FROM sales
GROUP BY month_name
ORDER BY 2 DESC

---# 7. In which month did the cost of goods sold reach its peak?
SELECT 
	month_name,
	ROUND(CAST(SUM(cogs) as NUMERIC), 2) as cost_of_goods_sold
FROM sales
GROUP BY month_name
ORDER BY 2 DESC

---# 8. Which product line generated the highest revenue?
SELECT 
	product_line,
	ROUND(CAST(SUM(total) as NUMERIC), 2) as total_revenue
FROM sales
GROUP BY product_line
ORDER BY 2 DESC

----# 9. In which city was the highest revenue recorded?
SELECT 
	city,
	ROUND(CAST(SUM(total) as NUMERIC), 2) as total_revenue
FROM sales
GROUP BY city
ORDER BY 2 DESC

---# 10. Which product line incurred the highest Value Added Tax?
SELECT 
	product_line,
	MAX(tax) as Max_tax
FROM sales
GROUP BY product_line
ORDER BY 2 DESC

---# 11. For each product line, add a column indicating "Good" if its sales are above average, otherwise "Bad."
WITH product_sales as (
	SELECT 
		product_line,
		ROUND(CAST(SUM(total) AS NUMERIC),2) as total_sales 
	FROM sales
	GROUP BY product_line
)
SELECT 
	product_line, 
	total_sales,
	CASE 
		WHEN total_sales > (SELECT AVG(total_sales) FROM product_sales) THEN 'Good'
		ELSE 'Bad' END AS performance
FROM product_sales
ORDER BY total_sales

---#12. Identify the branch that exceeded the average number of products sold.
WITH quantity_of_products AS (
	SELECT 
		branch,
		SUM(quantity) AS product_sold 
	FROM sales
	GROUP BY branch
)
SELECT branch, product_sold
FROM quantity_of_products
WHERE product_sold > (SELECT AVG(product_sold) FROM quantity_of_products);

---#13. Which product line is most frequently associated with each gender?
WITH new_table AS 
	(SELECT 
		gender, 
		product_line, 
		COUNT(*) as counts
	FROM sales
	GROUP BY gender,product_line),
	
max_count as (SELECT MAX(counts) FROM new_table GROUP BY gender)

SELECT * FROM new_table 
WHERE counts in (SELECT * from max_count)
ORDER BY counts DESC limit 2

----#14. Calculate the average rating for each product line.
SELECT product_line, 
ROUND(CAST(AVG(rating) as NUMERIC),2) FROM sales
GROUP BY product_line

----#15. Count the sales occurrences for each time of day on every weekday.
SELECT day_name, time_of_day, COUNT(*) AS occurences
FROM sales
GROUP BY day_name, time_of_day
ORDER BY CASE day_name 
	WHEN 'Sunday' THEN 1
	WHEN 'Monday' THEN 2 
	WHEN 'Tuesday' THEN 3 
	WHEN 'Wednesday' THEN 4 
	WHEN 'Thursday' THEN 5 
	WHEN 'Friday' THEN 6 
	ELSE 7 END,
	
CASE time_of_day 
	WHEN 'Morning' THEN 1 
	WHEN 'Afternoon' THEN 2 
	ELSE 3 END

---#16. Identify the customer type contributing the highest revenue.

SELECT customer_type, 
ROUND(CAST(SUM(total)AS NUMERIC),2) as revenue
FROM sales
GROUP BY customer_type
ORDER BY revenue LIMIT 1

---#16. USING CTE in case there are more than one customer_type with highest revenue.

With customer_revenue AS(
SELECT customer_type, 
ROUND(CAST(SUM(total)AS NUMERIC),2) as revenue
FROM sales
GROUP BY customer_type),

rank_table AS (SELECT customer_type, revenue,
RANK() OVER(ORDER BY revenue DESC) as rnk 
FROM customer_revenue)

SELECT customer_type, revenue FROM rank_table WHERE rnk = 1 

-----------
--- #17. Determine the city with the highest VAT percentage.
SELECT 
	city, 
	MAX(tax) as VAT 
FROM sales
GROUP BY city
ORDER BY VAT DESC

--- #18. Identify the customer type with the highest VAT payments.

SELECT customer_type, ROUND(CAST(SUM(tax) as NUMERIC), 2) as vat_payments
FROM sales
GROUP BY customer_type
ORDER BY vat_payments DESC

---#19. What is the count of distinct customer types in the dataset?
SELECT COUNT(DISTINCT customer_type) from sales;

---#20. What is the count of distinct payment methods in the dataset?
SELECT COUNT(DISTINCT payment) as count_of_payment_types from sales;

---#21. Which customer type occurs most frequently?
SELECT customer_type, Count(*) as occurence
FROM sales
GROUP BY customer_type
ORDER BY occurence DESC

---#22. Identify the customer type with the highest purchase frequency.
SELECT customer_type, month_name, count(invoice_id) as purchase_frequency
FROM sales
GROUP BY customer_type, month_name
ORDER BY purchase_frequency DESC

---#23. Determine the predominant gender among customers.
SELECT customer_type, gender, count(gender) FROM sales
GROUP BY customer_type, gender
ORDER BY customer_type

---#24. Examine the distribution of genders within each branch. 
SELECT branch, gender, count(*) as count_of_gender
FROM sales
GROUP BY branch, gender
ORDER BY branch, gender

---#25. Identify the time of day when customers provide the most ratings.
WITH rating_frequency AS (
SELECT time_of_day, count(rating) as count_of_rating
FROM sales
GROUP BY time_of_day)
SELECT time_of_day, count_of_rating
FROM rating_frequency
WHERE count_of_rating = (SELECT MAX(count_of_rating) FROM rating_frequency)

--- #26. Determine the time of day with the highest customer ratings for each branch.
WITH max_ratings AS(
	SELECT branch, time_of_day, MAX(rating) as highest_ratings 
	FROM sales
	GROUP BY branch, time_of_day)
SELECT branch, time_of_day, highest_ratings
FROM max_ratings
WHERE highest_ratings = (SELECT MAX(highest_ratings) FROM max_ratings)

--- #27. Identify the day of the week with the highest average ratings.
WITH avg_ratings_of_day AS (
	SELECT day_name, ROUND(CAST(AVG(rating) AS NUMERIC), 2) as average_rating
	FROM sales
	GROUP BY day_name
	ORDER BY average_rating DESC)
SELECT day_name, average_rating
FROM avg_ratings_of_day
WHERE average_rating = (SELECT MAX(average_rating) FROM avg_ratings_of_day)

---#28. Determine the day of the week with the highest average ratings for each branch.
WITH rating_table AS (
	SELECT 
		branch, 
		day_name, 
		ROUND(CAST(AVG(rating) AS NUMERIC), 2) as average_rating
	FROM sales
	GROUP BY branch, day_name),
rank_table AS(
	SELECT 
		branch, 
		day_name, 
		average_rating,
		RANK() OVER(PARTITION BY branch ORDER BY average_rating DESC) AS rnk
	FROM rating_table)
SELECT branch, day_name, average_rating 
FROM rank_table
WHERE rnk = 1