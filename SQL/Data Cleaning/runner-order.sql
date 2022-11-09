-- DATA CLEANING AND TRANSFORMATION OF RUNNER ORDER table

--DATA SOURCE: https://www.db-fiddle.com/f/7VcQKQwsS3CTkGRFG7vu98/65
-- written article on project: https://dee-seeker.medium.com/sql-data-wrangling-task-2-case-study-2-pizza-runner-92b0db3e06db

--ASSESS
SELECT *
FROM pizza_runner.runner_orders

--Programmatic Assessments


--check unique values and missing values
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

--QUALITY ISSUES

-- COMPLETENESS issues
-- pickup_time,distance,duration,and cancellation have missing value
-- Consistency issue
-- different representations of missing values(null special data type, ‘null’, ‘ ’ and unit of duration(minutes, mins, and minute)


-- VALIDITY issues
-- invalid datatype in pickup_time, duration, and distance
-- invalid representation of data in duration and distance columns(units and value together)
-- incorrect pickup time datatype


--DATA TRANSFORMATION of runner table
--CASE statement and Temp TABLE

-- CODE

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



--Resolve invalid datatype

ALTER TABLE runner_order
ALTER COLUMN pickup_time_alt TYPE TIMESTAMP USING pickup_time_alt::TIMESTAMP,
ALTER COLUMN distance_alt TYPE double precision USING distance_alt::double precision,
ALTER COLUMN duration_alt TYPE INT USING duration_alt:: integer;


--TEST
--CHECK Cleaned runner-order table
SELECT *
FROM runner_order
