-- ***********************
-- Name: Yuvraj Singh
-- ID: 155580210
-- Purpose: Lab 3 DBS311
-- ***********************

-- Question 1 �  Write a query to display the tomorrow�s date

-- Q1 SOLUTION --
Select  TO_CHAR(SYSDATE + 1, 'MONTHDD"th" "of year" YYYY') as "tomorrow"
From DUAL;

-- Question 2 � For each employee in departments 20, 50 and 60 display last name, first name, salary, 
-- and salary increased by 4% and expressed as a whole number.  
-- Label the column �Good Salary�.  
-- Also add a column that subtracts the old salary from the new salary and multiplies by 12. 
-- Label the column "Annual Pay Increase".

-- Q2 SOLUTION --
Select last_name, first_name,
                 to_char(salary, '$99,999') as salary,
                 to_char((salary *1.04), '$99,999') as "Good Salary",
                 to_char(((salary *1.04 - salary)*12), '$99,999')as "Annual Pay Increase"
From Employees
Where department_id in ('20', '50', '60');


-- Question 3 �
-- Write a query that displays the employee�s Full Name and Job Title in the following format:
-- DAVIES, CURTIS is ST_CLERK 
-- Only employees whose last name ends with S and first name starts with C or K.  
-- Give this column an appropriate label like Person and Job.  
-- Sort the result by the employees� last names.

-- Q3 SOLUTION --
Select upper(last_name) || ', ' || upper(first_name) || ' is ' ||  job_id as "Employee Jobs"
From Employees
Where last_name like lower('%s') and (first_name like upper('c%') or first_name like upper('k%'))
Order by last_name;


-- Question 4 �
-- For each employee hired before 1997, display the employee�s last name, hire date 
-- and calculate the number of YEARS between TODAY and the date the employee was hired.
-- Label the column Years worked. 
-- Order your results by the number of years employed.  
-- Round the number of years employed up to the closest whole number.

-- Q4 SOLUTION --
Select last_name, hire_date, round (months_between(sysdate, hire_date)/12)  "Years worked"
From Employees
Where hire_date < '97-01-01'
Order by "Years worked";


-- Question 5 �
-- Create a query that displays the city names, country codes and state province names, 
-- but only for those cities that starts with S and has at least 8 characters in their name. 
-- If city does not have a province name assigned, then put Unknown Province.  
-- Be cautious of case sensitivity!

-- Q5 SOLUTION --
Select city "City", country_id "Country", 
            NVL(state_province, to_char( 'Unknown Province')) as "Provice"
From Locations
Where city LIKE ('S_%_%_%_%_%_%_%');


-- Question 6 �
-- Display each employee�s last name, hire date, and salary review date, 
-- which is the first Thursday after a year of service, but only for those hired after 2017.  
-- Label the column REVIEW DAY. 
-- Format the dates to appear in the format like:
-- THURSDAY, August the Thirty-First of year 2018
-- Sort by review date

Select last_name "Last Name", hire_date "Hire Date",
             to_char((next_day(add_months(hire_date, 12),'Thursday')),  
            'DAY , Month " the "DDSPTH " of year " yyyy') as "REVIEW DAY"
FROM Employees
where hire_date > '17-01-01'
Order by "REVIEW DAY";

