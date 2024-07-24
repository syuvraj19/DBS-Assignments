-- ***********************
-- Name: Yuvraj Singh
-- ID: 155580210
-- Purpose: Lab 6 DBS311
-- ***********************

-- Question 1 �
--  SET AUTOCOMMIT ON (do this each time you log on) so any updates, deletes and inserts 
--  are automatically committed before you exit from Oracle.

-- Q1 SOLUTION --
SET AUTOCOMMIT ON


-- Question 2 �
-- Create an INSERT statement to do this.  Add yourself as an employee with a NULL salary, 
-- 0.21 commission_pct, in department 90, and Manager 100.  You started TODAY.  

-- Q2 SOLUTION --
INSERT INTO EMPLOYEES
    (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID,
    COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID)
VALUES (207, 'YOUNGEUN', 'HONG', 'YHONG38@MYSENECA.CA', '28-JUN-19',
    'AD_PRES', 0.21, 100, 90);
    
    
-- Question 3 �
-- Create an Update statement to:
-- Change the salary of the employees with a last name of Matos and Whalen to be 2500.

-- Q3 SOLUTION --
UPDATE EMPLOYEES
SET SALARY = 2500
WHERE LAST_NAME IN ('Matos', 'Whalen');


-- Question 4 �
-- Display the last names of all employees who are in the same department 
-- as the employee named Abel.

-- Q4 SOLUTION --
SELECT LAST_NAME
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM EMPLOYEES
    WHERE LAST_NAME = 'Abel');


-- Question 5 �
-- Display the last name of the lowest paid employee(s)

-- Q5 SOLUTION --
SELECT LAST_NAME
FROM EMPLOYEES
WHERE SALARY = (SELECT MIN(SALARY) FROM EMPLOYEES);


-- Question 6 �
-- Display the city that the lowest paid employee(s) are located in.

-- Q6 SOLUTION --
SELECT CITY
FROM EMPLOYEES E
    JOIN DEPARTMENTS D ON (E.DEPARTMENT_ID = D.DEPARTMENT_ID)
    JOIN LOCATIONS L ON (D.LOCATION_ID = L.LOCATION_ID)
WHERE SALARY = (SELECT MIN(SALARY) FROM EMPLOYEES); 


-- Question 7�
-- Display the last name, department_id, and salary of the lowest paid employee(s) in each department.  
-- Sort by Department_ID. (HINT: careful with department 60)

-- Q7 SOLUTION --
SELECT LAST_NAME, DEPARTMENT_ID, SALARY
FROM EMPLOYEES
WHERE (DEPARTMENT_ID, SALARY) IN (SELECT DEPARTMENT_ID, MIN(SALARY) 
    FROM EMPLOYEES   GROUP BY DEPARTMENT_ID)
ORDER BY DEPARTMENT_ID;


-- Question 8 �
-- Display the last name of the lowest paid employee(s) in each city    

-- Q8 SOLUTION --
SELECT LAST_NAME
FROM EMPLOYEES 
JOIN DEPARTMENTS USING(DEPARTMENT_ID)
JOIN LOCATIONS USING(LOCATION_ID)
WHERE(CITY, SALARY) IN(SELECT CITY, MIN(SALARY)
    FROM EMPLOYEES 
    JOIN DEPARTMENTS USING(DEPARTMENT_ID)
    JOIN LOCATIONS USING(LOCATION_ID)
    GROUP BY CITY);
    

-- Question 9�
-- Display last name and salary for all employees who earn less than the lowest salary in ANY department.  
-- Sort the output by top salaries first and then by last name.

-- Q9 SOLUTION --
SELECT LAST_NAME, SALARY
FROM EMPLOYEES 
WHERE SALARY < ANY(SELECT MIN(SALARY) FROM EMPLOYEES
    GROUP BY DEPARTMENT_ID)
ORDER BY SALARY DESC, LAST_NAME;


-- Question 10 �
-- Display last name, job title and salary for all employees whose salary matches any of the salaries from the IT Department. 
-- Do NOT use Join method.  Sort the output by salary ascending first and then by last_name

-- Q10 SOLUTION --
SELECT LAST_NAME, JOB_ID, SALARY
FROM EMPLOYEES 
WHERE SALARY IN (SELECT SALARY FROM EMPLOYEES   WHERE DEPARTMENT_ID = 60)
ORDER BY SALARY, LAST_NAME;