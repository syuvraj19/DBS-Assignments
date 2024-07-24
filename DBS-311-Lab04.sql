-- ***********************
-- Name: Yuvraj Singh
-- ID: 155580210
-- Purpose: Lab 4 DBS311
-- ***********************

-- Question 1 �
-- Display the difference between the Average pay and Lowest pay in the company.  
-- Name this result Real Amount.  
-- Format the output as currency with 2 decimal places.

-- Q1 SOLUTION --
Select to_char(round(AVG(salary)- MIN(salary),2),'$9999.99') "Real Aount"
From employees;

-- Question 2 �
-- Display the department number and Highest, Lowest and Average pay per each department. 
-- Name these results High, Low and Avg. 
-- Sort the output so that the department with highest average salary is shown first.  
-- Format the output as currency where appropriate.

-- Q2 SOLUTION --
Select  department_id"DeptID",
              to_char(MAX(salary),'$99,999.99') "High",
              to_char(MIN(salary),'$99,999.99') "Low",
              to_char(round(AVG(salary),2),'$99,999.99') "Avg"
From employees
Group by department_id
Having department_id is not null
Order by "Avg" desc;

-- Question 3 �
-- Display how many people work the same job in the same department. 
-- Name these results Dept#, Job and How Many. 
-- Include only jobs that involve more than one person.  
-- Sort the output so that jobs with the most people involved are shown first.

-- Q3 SOLUTION --
Select department_id "Dept#", job_id "Job", Count(employee_id) "How Many"
From employees
Group by department_id, job_id
Having count(employee_id) > 1
Order by 3 desc;


-- Question 4 �
-- For each job title display the job title and total amount paid each month for this type of the job. 
-- Exclude titles AD_PRES and AD_VP and also include only jobs that require more than $11,000.  
-- Sort the output so that top paid jobs are shown first.

-- Q4 SOLUTION --
Select job_id "Job", to_char(Sum(salary),'$999,999.99')"Amount Paid"
From employees
Group by job_id
Having job_id != 'AD_PRES'  AND job_id != 'AD_VP'   AND Sum(salary)>11000
Order by "Amount Paid" desc;


-- Question 5 �
-- For each manager number display how many persons he / she supervises. 
-- Exclude managers with numbers 100, 101 and 102 and also include only those managers that supervise more than 2 persons.  
-- Sort the output so that manager numbers with the most supervised persons are shown first.

-- Q5 SOLUTION --
Select manager_id "Manager", Count(employee_id) "Employees"
From employees
Where manager_id not in(100, 101, 102)
Group by manager_id
Having count (employee_id) > 2
Order by "Employees" desc;


-- Question 6 �
-- For each department show the latest and earliest hire date, BUT
-- exclude departments 10 and 20 
-- exclude those departments where the last person was hired in this decade. (it is okay to hard code dates in this question only)
-- Sort the output so that the most recent, meaning latest hire dates, are shown first.

-- Q6 SOLUTION --
Select department_id "Dept#", 
             to_char(Max(hire_date),'YY-MM-DD') "Latest",
             to_char(min(hire_date),'YY-MM-DD') "Earliest"
From employees  
Group by department_id
Having  department_id not in (10, 20) And
               to_char(max(hire_date),'YY') 
               not in (19,18,17,16,15,14,13,12,11,10)
Order by 2 desc;


