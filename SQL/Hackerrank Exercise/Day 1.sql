Day 1/100:
--Steps to solutions
--- Select Name
--- Select the first letter of Occupation
--- Concatenate the name and first letter of Occupation
--- Aggregate
--- Find how to insert text with results of queries
--
--Relevant resources:
--
--https://stackoverflow.com/questions/792294/how-to-get-first-character-of-a-string-in-sql
--
--https://www.javatpoint.com/sql-concat-function#:~:text=The%20CONCAT%20function%20in%20SQL,to%20make%20a%20single%20string.

/*
Enter your query here.
*/

SELECT CONCAT(Name, "(" , LEFT(Occupation, 1), ")") as "output"
FROM OCCUPATIONS
ORDER BY Name;

SELECT CONCAT("There are a total of"," ", COUNT(*)," ", lower(Occupation),"s.") as "new"
FROM OCCUPATIONS
GROUP BY Occupation
ORDER BY COUNT(*), Occupation;