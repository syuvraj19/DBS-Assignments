-- ***********************
-- Name: Yuvraj Singh
-- ID: 155580210
-- Purpose: Lab 2 DBS311
-- ***********************

-- Question 1 -- 	Display the employee_id, last name and salary of employees earning in the range of $8,000 to $10000 inclusive. 
-- Sort the output by top salaries first and then by last name

Select employee_id, last_name, salary
From EMPLOYEES
Where salary between 8000 and 10000
Order by salary desc, last_name;


-- Question 2 --  Display only if they work as Programmers or Sales Representatives. 
-- Use same sorting as before

Select employee_id, last_name, salary
From EMPLOYEES
Where (salary between 8000 and 10000) AND
             (job_id in ('IT_PROG', 'SA_REP'))
Order by salary desc, last_name;


-- Question 3 -- Find high salary and low salary employees. 
-- Displays the same job titles but for people who earn outside the range of $8,000 to $11000 exclusive. 
-- Use same sorting as before.

Select employee_id, last_name, salary
From EMPLOYEES
Where (salary not between 8000 and 11000) AND
             (job_id in ('IT_PROG', 'SA_REP'))
Order by salary desc, last_name;


-- Question 4 -- A list of long term employees for a thank you dinner. 
-- Display the last name, job_id and salary of employees hired after 2016. 
-- List the most recently hired employees first.

Select last_name, job_id, salary, hire_date
From EMPLOYEES
Where hire_date >='01-JAN-16'
Order by hire_date desc;


-- Question 5 --  Displays only employees earning more than $12,000 and hired before 2017.
-- List the output by job title alphabetically and then by highest paid employees.

Select last_name, job_id, salary, hire_date
From EMPLOYEES
Where hire_date < '01-JAN-17' AND
             salary > 12000
Order by job_id, salary desc;


-- Question 6 -- Display the job titles and full names of employees
-- whose first name contains an �c� or �C� anywhere

Select job_id "Job title", first_name ||' '|| last_name "Full name"
From EMPLOYEES
where lower(first_name) like '%c%'; 


-- Question 7 --  Create a report to display last name,  salary, and commission percent for all employees 
-- that earn a commission and a salary less than 9000.

Select  last_name, salary, commission_pct
From EMPLOYEES
where salary < 9000 AND 
            commission_pct is not null;


-- Question8  -- Put the report in order of descending salaries.

Select  last_name, salary, commission_pct
From EMPLOYEES
where salary < 9000 AND 
            commission_pct is not null
Order by salary desc;


-- Question9 -- Use a numeric value instead of a column name to do the sorting.

Select  last_name, salary, commission_pct
From EMPLOYEES
where salary < 9000 AND 
            commission_pct is not null
order by 2 desc;

