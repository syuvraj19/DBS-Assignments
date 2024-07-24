-- ***********************
-- Name: Yuvraj Singh
-- ID: 155580210
-- Purpose: Lab 5 DBS311
-- ***********************

-- Question 1 �
-- 1.	Display the department name, city, street address and postal code for departments 
-- sorted by city and department name.

-- Q1 SOLUTION --
Select department_name AS department, city, street_address AS address, 
             postal_code AS "Postal Code" 
From Departments JOIN Locations using (location_id)
Order by city, department_name;


-- Question 2 �
-- Display full name of employees as a single field using format of �Last, First�, 
-- their hire date, salary, department name and city, 
-- but only for departments with names starting with an A or I
-- sorted by department name and employee name.

-- Q2 SOLUTION --
Select last_name || ', ' || first_name AS employee,
        	hire_date AS hired, salary AS salary,
        	department_name AS department, city
From employees JOIN departments using (department_id)
JOIN locations using (location_id) 
Where department_name LIKE 'A%' OR department_name LIKE 'I%' 
Order by department_name, 1;


-- Question 3 �
-- Display the full name of the manager of each department in states/provinces of Ontario,
-- New Jersey and Washington along with the department name, city, postal code and province name.   
-- Sort the output by city and then by department name.

-- Q3 SOLUTION --
Select e.first_name ||' '|| e.last_name "Manager" ,d.department_name "Dept", l.city "City", 
            l.postal_code "PC",l.state_province "State/Prov." 
From departments d
JOIN locations l ON d.location_id = l.location_id
JOIN employees e ON d.manager_id = e.employee_id
Where l.state_province IN ('Ontario','New Jersey','Washington')
Order by l.city, d.department_name;


-- Question 4 �
-- Display employee�s last name and employee number 
-- along with their manager�s last name and manager number for employees in department 20,50, and 60. 
-- Label the columns Employee, Emp#, Manager, and Mgr# respectively.

-- Q4 SOLUTION --
Select e.last_name "Employee", e.employee_id "Emp#", m.last_name "Manager", m.employee_id "Mgr#"
From employees e JOIN employees m ON e.manager_id  = m.employee_id
Where e.department_id IN (20,50,60);


-- Question 5 �
-- Display the department name, city, street address, postal code and country name for all Departments. 
-- Use the JOIN and USING form of syntax. 
-- Sort the output by department name descending.

-- Q5 SOLUTION --
Select department_name, city, street_address, postal_code, country_name
From departments 
JOIN locations using (location_id)
JOIN countries using (country_id)
Order by department_name DESC;


-- Question 6 �
-- Display full name of the employees, their hire date and salary together with their department name, 
-- but only for departments which names start with A or I.
-- Full name should be formatted:  First / Last. 
-- Use the JOIN and ON form of syntax.
-- Sort the output by department name and then by last name.

-- Q6 SOLUTION --
Select first_name || ' / ' || last_name employee, hire_date, 
             to_char(salary,'$999,999.99'), department_name "Dept."
From employees e
JOIN departments d ON e.department_id = d.department_id
where department_name like('A%') or department_name like('I%')
order by department_name, last_name;


-- Question 7 �
-- Display full name of the manager of each department in provinces Ontario, New Jersey and Washington 
-- plus department name, city, postal code and province name. 
-- Full name should be formatted: Last, First.  
-- Use the JOIN and ON form of syntax.
-- Sort the output by city and then by department name. 

-- Q7 SOLUTION --
Select e.last_name || ',' || e.first_name "Manager" , d.department_name "Dept",
             l.city "City", l.postal_code "PC", l.state_province "State/Prov." 
From departments d
Join locations l On d.location_id = l.location_id
Left join employees e on d.manager_id = e.employee_id
where l.state_province in ('Ontario','New Jersey','Washington')
Order by l.city, d.department_name;


-- Question 8 �
-- Display the department name and Highest, Lowest and Average pay per each department.
-- Name these results High, Low and Avg-- 
-- Use JOIN and ON form of the syntax.
-- Sort the output so that department with highest average salary are shown first.

-- Q8 SOLUTION --
Select d.department_name dept, to_char(max(salary),'$99,999.99') "High" ,to_char(min(salary),'$99,999.99') "Low",
        to_char(round(avg(e.salary),2),'$99,999.99')"Avg"
From  employees e
Join departments d on e.department_id = d.department_id
Group by d.department_name
Order by "Avg" DESC;


-- Question 9 �
-- Display the employee last name and employee number along with their manager�s last name and manager number. 
-- Label the columns Employee, 
-- Emp#, Manager, and Mgr#, respectively. 
-- Include also employees who do NOT have a manager and also employees who do NOT supervise anyone
-- (or you could say managers without employees to supervise).

-- Q9 SOLUTION --
Select  e.employee_id "Emp#" , e.last_name "Employee", 
             m.employee_id "Mgr#",m.last_name"Manager"
From employees e 
FULL outer join employees m ON e.manager_id = m.employee_id
Order by "Emp#";      
