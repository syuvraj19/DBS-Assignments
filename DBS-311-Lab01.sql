-- ***********************
-- Name: Yuvraj Singh
-- ID: 155580210
-- Purpose: Lab 1 DBS311
-- ***********************

-- Question 1 �  Which one of these tables appeared to be the widest? or longest? 
-- Q1 Solution --
SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;
SELECT * FROM JOB_HISTORY;
--Q1 Answer � The Employees table is the longest.

-- Question 2 �  If the following SELECT statement does NOT execute successfully, how would you fix it?
-- Q2 Solution � � -> ", Hire Date -> Hire_Date
-- Q2 Result �
SELECT last_name "LName", job_id "Job Title", Hire_Date "Job Start"
 FROM employees;
 
-- Question 3 �  There are THREE coding errors in this statement. Can you identify them? correct them and provide a working statement.
-- Q3 Solution � last name -> last_name, Emp Comm => "Emp Comm", remove comma after "Emp Comm"
-- Q3 Result �
SELECT employee_id,  last_name, commission_pct  "Emp Comm"
FROM employees;

-- Question 4 �  What command would show the structure of the LOCATIONS table? 
-- Q4 answer � desc LOCATIONS;

-- Question 5 � Create a query to display the output shown below. 
-- Q5 answer �
SELECT Location_id "City#", city "City", state_province || ' IN THE ' || country_id as "Province with Country Code"
FROM locations



 
 
 





