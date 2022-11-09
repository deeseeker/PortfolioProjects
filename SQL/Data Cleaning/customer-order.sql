--DATA CLEANING AND TRANSFORMATION (customer_table)

--DATA SOURCE: https://www.db-fiddle.com/f/7VcQKQwsS3CTkGRFG7vu98/65
---- written article on project:   https://dee-seeker.medium.com/sql-data-wrangling-task-1-case-study-2-pizza-runner-a527c7e276a


--ASSESS
SELECT *
FROM pizza_runner.customer_orders

--Programmatic Assessments

-- check unique values
SELECT DISTINCT exclusions
FROM pizza_runner.customer_orders

SELECT DISTINCT extras
FROM pizza_runner.customer_orders


--check missing values

SELECT DISTINCT extras
FROM pizza_runner.customer_orders
WHERE extras is NULL

SELECT DISTINCT exclusions
FROM pizza_runner.customer_orders
WHERE exclusions is NULL

SELECT DISTINCT exclusions
FROM pizza_runner.customer_orders
WHERE exclusions = ''

SELECT DISTINCT exclusions
FROM pizza_runner.customer_orders
WHERE exclusions = 'null'

SELECT DISTINCT extras
FROM pizza_runner.customer_orders
WHERE extras = 'null'

SELECT DISTINCT extras
FROM pizza_runner.customer_orders
WHERE extras = ''


-- Quality issues
-- Multiple ways of referring to missing values: ‘ ’,`null`,NULL in exclusions and extras column

--CLEANING

--Define
--convert ‘ ’, `null`, NULL in exclusions and extras column to a NULL using a CASE statement


--CODE  (cleaning)

SELECT order_id, customer_id, pizza_id,
 CASE
   WHEN exclusions IN ('null' ,'') THEN NULL
   ELSE exclusions
   END AS exclusions,
 CASE
   WHEN extras IN ('null', '') THEN NULL
   ELSE extras
   END AS extras,order_time
INTO TEMP TABLE customer_orders
FROM pizza_runner.customer_orders


--TEST
--CHECK Cleaned customer-order table
SELECT *
FROM customer_orders
