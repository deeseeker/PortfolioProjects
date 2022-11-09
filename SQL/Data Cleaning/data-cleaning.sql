--DATA CLEANING AND TRANSFORMATION (customer_table)


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
--CHECK Cleaned customer_order table
SELECT *
FROM customer_orders



--CHECK Cleaned runner_order table
SELECT *
FROM pizza_runner.runner_orders
--inspect columns with missing value
SELECT DISTINCT pickup_time
FROM pizza_runner.runner_orders

SELECT DISTINCT distance
FROM pizza_runner.runner_orders

SELECT DISTINCT duration
FROM pizza_runner.runner_orders

SELECT DISTINCT cancellation
FROM pizza_runner.runner_orders

SELECT cancellation
FROM pizza_runner.runner_orders
WHERE cancellation = ''
--DATA TRANSFORMATION of runner table
SELECT order_id,runner_id,
	CASE
        WHEN pickup_time like 'null' THEN null
		ELSE pickup_time END AS pickup_time_alt,
	CASE
		WHEN distance in ('null', '') THEN null
		WHEN distance like '%km' THEN TRIM('km' from distance)
		ELSE distance END AS distance_alt,
    CASE
		WHEN duration in ('null', NULL) THEN null
		WHEN duration like '%mins' THEN TRIM('mins' from duration)
		WHEN duration like '%minutes' THEN TRIM('minutes' from duration)
		WHEN duration like '%minute' THEN TRIM('minute' from duration)
		ELSE duration END AS duration_alt,
	CASE
        WHEN cancellation in (null, '','null') THEN null
		ELSE cancellation END AS cancellation_alt
INTO TEMP TABLE runner_order
FROM pizza_runner.runner_orders


--covert to datatype
ALTER TABLE runner_order
ALTER COLUMN pickup_time_alt TYPE TIMESTAMP USING pickup_time_alt::TIMESTAMP,
ALTER COLUMN distance_alt TYPE double precision USING distance_alt::double precision,
ALTER COLUMN duration_alt TYPE INT USING duration_alt:: integer;

---view data
SELECT *
FROM runner_order
