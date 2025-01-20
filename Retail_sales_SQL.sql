/*Sql Retail Sales Analysis*/
CREATE DATABASE sample_project;
USE sample_project;
CREATE TABLE retail_sales(
transactions_id int primary key,
sale_date date,	
sale_time time,	
customer_id int,
gender varchar(20),	
age int,
category varchar(12),	
quantiy int,
price_per_unit float,	
cogs float,
total_sale float
);
SELECT * FROM retail_sales;
SELECT COUNT(*) FROM retail_sales;
SET SQL_SAFE_UPDATES = 0;


SELECT * FROM retail_sales 
WHERE sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantiy IS NULL OR price_per_unit IS NULL OR cogs IS NULL OR total_sale IS NULL;
DELETE FROM retail_sales 
WHERE sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantiy IS NULL OR price_per_unit IS NULL OR cogs IS NULL OR total_sale IS NULL;
    
-- TOTAL SALES --   
SELECT COUNT(*) AS TOTAL_SALES FROM retail_sales;
-- Total Unique Customers --
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
-- Total unique categories --
SELECT COUNT(DISTINCT category) FROM retail_sales;
SELECT DISTINCT category FROM retail_sales;

-- Retrieve all columns for sales made on '2022-11-05' --
SELECT * FROM retail_sales
WHERE sale_date = '2022-11-05';

-- retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022 --
SELECT * FROM retail_sales
WHERE (category = 'Clothing') AND DATE_FORMAT(sale_date, '%Y-%m')= '2022-11' AND (quantiy >= 4);

-- calculate the total sales for each category --
SELECT SUM(total_sale) AS sum, 
category FROM retail_sales 
GROUP BY category;

-- find the average age of customers who purchased items from the 'Beauty' category --
SELECT AVG(age), category 
FROM retail_sales WHERE category = 'Beauty';

-- find all transactions where the total sales is greater than 1000 --
SELECT * FROM retail_sales
WHERE total_sale > 1000;

-- find the total number of transactions made by each gender in each category --
SELECT COUNT(transactions_id) AS Total_transac, gender, category FROM retail_sales
GROUP BY category, gender
ORDER BY gender; 

-- calculate the average sale for each month. Find out best selling month in each year --
SELECT AVG(total_sale) AS avg_sales_month, 
YEAR(sale_date), MONTH(sale_date),
sale_date FROM retail_sales 
GROUP BY sale_date
ORDER BY YEAR(sale_date), avg_sales_month DESC;

-- find the top 5 customers based on the highest total sales --
SELECT customer_id,
SUM(total_sale) AS Total_sales FROM retail_sales
GROUP BY customer_id ORDER BY Total_sales DESC LIMIT 5;

-- find the number of unique customers who purchased items from each category --
SELECT COUNT(DISTINCT customer_id) as Uniq_Customer, category FROM retail_sales
GROUP BY category;

-- create each shift and number of orders Example Morning <12, Afternoon Between 12 & 17, Evening >17 --
SELECT *, 
CASE     WHEN HOUR(sale_time) < 12 THEN 'Morning'
		 WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
         ELSE 'Evening' END AS Shift
FROM retail_sales;
