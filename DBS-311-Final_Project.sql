-- ************************************************************************************
-- Name: Yuvraj Singh
-- ID: 155580210
-- Purpose: Assignment 1 - DBS311
-- ************************************************************************************

-- Question 1 � 
-- Display the employee number, full employee name, job and hire date of all employees hired in May or November of any year, 
-- with the most recently hired employees displayed first

-- Q1 SOLUTION --
SELECT employee_id, RPAD(last_name || ', ' || first_name,25) "Full Name", 
                 job_id, to_char(Last_day(hire_date), 'fm"["Month" "ddth" of "YYYY"]"')
FROM employees
WHERE to_char(hire_date, 'MM') in (05, 11)
               AND to_char(hire_date, 'YYYY') NOT IN (2014, 2015)
ORDER BY hire_date DESC ;


-- Question 2 � 
-- List the employee number, full name, job and the modified salary for all employees whose monthly earning (without this increase) 
-- is outside the range $5,000 � $10,000 and who are employed as Vice Presidents or Managers

-- Q2 SOLUTION --
SELECT 'Emp# '||employee_id||' named '|| last_name||' '||first_name||' who is ' ||
    job_id || ' will have a new salary of'|| 
    to_char((CASE WHEN job_id like('%VP') THEN salary*1.25 WHEN job_id like('%MAN') 
    THEN salary*1.18 end),'$99999')"Employees with increased Pay"
FROM employees
WHERE salary NOT BETWEEN 5000 AND 10000
AND (job_id LIKE '%MAN' OR job_id LIKE '%VP' OR job_id LIKE '%MGR')
ORDER BY salary DESC;



-- Question 3 � 
-- Display the employee last name, salary, job title and manager# of all employees not earning a commission 
-- OR if they work in the SALES department, 
-- but only  if their total monthly salary with $1000 included bonus and  commission (if  earned) is  greater  than  $15,000.  

-- Q3 SOLUTION --
SELECT e.last_name,e.salary, e.job_id, NVL(to_char(e.manager_id),'NONE') "Manager#",
                 to_char((e.salary*(1+NVL(e.commission_pct,0))+1000)*12,'$999,999.99') "Total Income"
FROM employees e
JOIN departments d  USING (department_id)
WHERE (commission_pct is null or department_name = 'Sales')
                AND e.salary*(1+NVL(e.commission_pct,0))+1000 > 15000
ORDER BY 5 DESC;


-- Question 4 � 
--Display Department_id, Job_id and the Lowest salary for this combination under the alias Lowest Dept/Job Pay, 
-- but only if that Lowest Pay falls in the range $6000 - $18000. 
-- Exclude people who work as some kind of Representative job from this query and departments IT and SALES as well.

-- Q4 SOLUTION --
SELECT department_id ,job_id, MIN(salary)"Lowest Dept/Job Pay"
FROM employees
GROUP BY department_id, job_id
HAVING MIN(salary) BETWEEN 6000 AND 18000 AND
        job_id not like('%REP') AND
        job_id not like ('IT%') AND
        job_id not like('SA%')
ORDER BY department_id, job_id;


-- Question 5 � 
-- Display last_name, salary and job for all employees 
-- who earn more than all lowest paid employees per department outside the US locations

-- Q5 SOLUTION --
SELECT last_name, salary, job_id
FROM employees 
WHERE salary > ALL (SELECT MIN(salary) 
FROM employees 
JOIN departments using (department_id)
JOIN locations using (location_id)
WHERE country_id <> 'US'
GROUP BY department_id) AND
        job_id not like('%VP') AND
        job_id not like('%PRES')
ORDER BY job_id;


-- Question 6 � 
-- Who are the employees (show last_name, salary and job) who work either in IT or MARKETING department 
-- and earn more than the worst paid person in the ACCOUNTING department

-- Q6 SOLUTION --
SELECT last_name, salary, job_id
FROM employees
WHERE (job_id like ('IT%') OR
               job_id like('MK%') ) AND
               salary > (SELECT MIN(salary)
FROM employees
WHERE job_id LIKE ('AC%'))
ORDER BY last_name;


-- Question 7 � 
-- Display alphabetically the full name, job, salary (formatted as a currency amount incl. thousand separator, 
-- but no decimals) and department number for each employee who earns less than the best paid unionized employee 
-- (i.e. not the president nor any manager nor any VP), and who work in either SALES or MARKETING department.  

-- Q7 SOLUTION --
SELECT RPAD(first_name||' '||last_name,25)  "Employee", job_id, 
                 LPAD(to_char(salary,'$99,999'),15,'=')"Salary", department_id
FROM employees
WHERE salary < (SELECT MAX(salary)
FROM employees
WHERE (job_id not like('%VP')
AND job_id not like('%MAN')
AND job_id not like('%MGR')
AND job_id not like('%PRES%'))
AND department_id IN (SELECT department_id FROM departments 
WHERE UPPER(department_name) IN ('SALES','MARKETING')))
ORDER BY 1;


-- Question 8 � 
-- �Tricky One� Display department name, city and number of different jobs in each department. 
-- If city is null, you should print Not Assigned Yet.

-- Q8 SOLUTION --
SELECT department_name, SUBSTR(NVL(city,'Not Assigned Yet'),0,25) "City", 
                 COUNT(e.job_id) "# of Jobs"
FROM departments d
RIGHT JOIN employees e
ON e.department_id = d.department_id
FULL JOIN locations l
ON l.location_id = d.location_id
GROUP BY department_name, SUBSTR(NVL(city,'Not Assigned Yet'),0,25)
HAVING department_name IS NOT NULL;



