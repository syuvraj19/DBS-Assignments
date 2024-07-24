-- ***********************
-- Name: Yuvraj Singh
-- ID: 155580210
-- Purpose: Lab 8 DBS311
-- ***********************

-- Question 1 �
-- 	Display the names of the employees whose salary is the same 
-- as the lowest salaried employee in any department.

-- Q1 SOLUTION --
SELECT first_name ||' '|| last_name as name
FROM employees 
WHERE salary = ANY(
    SELECT MIN(salary) 
    FROM employees);
    
    
-- Question 2 �
-- Display the names of the employee(s) whose salary is the lowest 
-- in each department.

-- Q2 SOLUTION --
SELECT first_name ||' '|| last_name as name
FROM employees
WHERE (salary, department_id) IN ( 
    SELECT MIN(salary), department_id 
    FROM employees
    GROUP BY department_id);
    

-- Question 3 �
-- 	Give each of the employees in question 2 a $120 bonus.

-- Q3 SOLUTION --
UPDATE employees
SET salary = salary + 120
WHERE employee_id = any (
    SELECT employee_id
    FROM employees
    WHERE (salary, department_id) = any (
            SELECT MIN(salary), department_id
            FROM employees
            GROUP BY department_id
            HAVING department_id is not null));


-- Question 4 �
-- Create a view named vwAllEmps that consists of all employees 
-- includes employee_id, last_name, salary, department_id, department_name, 
-- city and country (if applicable)

-- Q4 SOLUTION --
CREATE VIEW vwAllEmps AS
SELECT employee_id, last_name, salary, department_id, 
                department_name, city, country_name
FROM employees 
    JOIN departments USING (department_id)
    JOIN locations USING (location_id)
    JOIN countries USING (country_id);


-- Question 5 �
-- Use the vwAllEmps view to:

--a.	Display the employee_id, last_name, salary and city for all employees
--a. SOLUTION --
SELECT employee_id, last_name, salary, city
FROM vwAllEmps;

--b.Display the total salary of all employees by city
--b. SOLUTION --
SELECT sum(salary) AS "Total Salary", city
FROM vwAllEmps
Group by city;

--c.Increase the salary of the lowest paid employee(s) in each department by 120
--c. SOLUTION --
UPDATE vwAllEmps
SET salary = salary+ 120
WHERE (salary,department_id) = any (
    SELECT MIN(salary), department_id
    FROM vwAllEmps
    GROUP BY department_id );



--d.What happens if you try to insert an employee by providing values for all columns in this view?
--d. SOLUTION --
INSERT INTO vwAllEmps
VALUES(209, 'Green', 10000, 90, 'Executive', 'Tronto', 'Canada');
--d. Answer --
--Insertion was not allowed to the view since the view was created from more than one table.


--e.Delete the employee named Vargas. Did it work? Show proof.
--e. SOLUTION --
DELETE FROM vwallemps
WHERE last_name = 'Vargas';
--e. Answer
--Deletion was allowed.
--Output: 1 row deleted. 

--e. proof
SELECT last_name
FROM vwallemps
WHERE last_name = 'VARGAS';  --no output


-- Question 6 �
--Create a view named vwAllDepts that consists of all departments and 
--includes department_id, department_name, city and country (if applicable)

--6 SOLUTION --
CREATE VIEW vwAllDepts AS
SELECT department_id, department_name, city, country_name
FROM departments JOIN locations USING (location_id)
    JOIN countries USING (country_id);

-- Question 7 �
--	Use the vwAllDepts view to:
-- a.	For all departments display the department_id, name and city
-- a. SOLUTION --
SELECT  department_id, department_name,city
FROM vwAllDepts;

-- b.	For each city that has departments located in it display the number of departments by city
SELECT city, COUNT(department_id) departments_count
FROM vwAllDepts
GROUP BY  CITY;

-- Question 8 �
--	Create a view called vwAllDeptSumm that consists of all departments 
-- and includes for each department: department_id, department_name, 
-- number of employees, number of salaried employees, total salary of all employees. 
-- Number of Salaried must be different from number of employees. 
-- The difference is some get commission.

-- 8 SOLUTION --
CREATE VIEW vwAllDeptSumm AS
SELECT department_id, department_name, COUNT(employee_id) employees, 
    COUNT(employee_id)- COUNT(commission_pct) "Salaried Employees", SUM(salary) "Total Salary"
FROM employees JOIN departments USING(department_id)
GROUP BY department_id, department_name;

-- Question 9 �
--	Use the vwAllDeptSumm view to display department name and number of employees for departments 
-- that have more than the average number of employees 

-- 9 SOLUTION --
SELECT department_name, employees
FROM vwAllDeptSumm
WHERE employees > (SELECT AVG(employees) FROM vwAllDeptSumm);

-- Question 10 �
--	A) Use the GRANT statement to allow another student (Neptune account) to retrieve data for your employees table 
-- and to allow them to retrieve, insert and update data in your departments table. Show proof
-- A. SOLUTION --
GRANT SELECT ON employees TO dbs301_192d17;
GRANT SELECT, INSERT, UPDATE ON departments TO dbs301_192d17;

--proof
--the output: Grant succeeded.
SELECT * FROM USER_TAB_PRIVS;

-- B) Use the REVOKE statement to remove permission for that student to insert and update data in your departments table
-- B. SOLUTION --
REVOKE INSERT, UPDATE ON departments FROM dbs301_192d17;