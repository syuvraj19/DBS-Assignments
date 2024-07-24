-- ***********************
-- Name: Yuvraj Singh
-- ID: 155580210
-- Purpose: Lab 9 DBS311
-- ***********************

--Q1--
--Create table L09SalesRep and load it with data from table EMPLOYEES table. 
--Use only the equivalent columns from EMPLOYEE as shown below 
--and only for people in department 80.

--A1--
Create Table L09SalesRep(
    RepId	NUMBER	(6),	
    FName VARCHAR2(20),    
    LName VARCHAR2(25) ,  
    Phone# VARCHAR2(20),          
    Salary NUMBER(8,2),                            
    Commission NUMBER(2,2) 
);

INSERT INTO  L09SalesRep(
SELECT Employee_id, First_name, Last_name, Phone_number, Salary, Commission_pct
FROM Employees
WHERE department_id = 80);

--Q2--
--Create L09Cust table.

--A2--
CREATE TABLE L09Cust (
   CUST#	 NUMBER(6),
   CUSTNAME VARCHAR2(30), 
   CITY VARCHAR2(20), 
   RATING CHAR(1),
   COMMENTS VARCHAR2(200),
   SALESREP# NUMBER(7) );   


INSERT INTO L09Cust (CUST#,CUSTNAME,CITY,RATING,SALESREP#) 
    VALUES (501 ,'ABC LTD.','Montreal','C',201);
INSERT INTO L09Cust (CUST#,CUSTNAME,CITY,RATING,SALESREP#) 
    VALUES (502,'Black Giant','Ottawa','B',202 );
INSERT INTO L09Cust (CUST#,CUSTNAME,CITY,RATING,SALESREP#) 
    VALUES (503,'Mother Goose','London','B',202);
INSERT INTO L09Cust (CUST#,CUSTNAME,CITY,RATING,SALESREP#) 
    VALUES (701,'BLUE SKY LTD','Vancouver','B',102 );
INSERT INTO L09Cust (CUST#,CUSTNAME,CITY,RATING,SALESREP#) 
    VALUES (702,'MIKE and SAM Inc.','Kingston','A',107 );
INSERT INTO L09Cust (CUST#,CUSTNAME,CITY,RATING,SALESREP#) 
    VALUES (703,'RED PLANET','Mississauga','C',107 );
INSERT INTO L09Cust (CUST#,CUSTNAME,CITY,RATING,SALESREP#) 
    VALUES (717,'BLUE SKY LTD','Regina','D',102);


--Q3--
--Create table L09GoodCust by using following columns but only if their rating is A or B.

--A3--
CREATE TABLE L09GoodCust AS
SELECT  CUST# CUSTID,CUSTNAME NAME, CITY LOCATION, SALESREP# REPID
FROM L09Cust
WHERE RATING in ('A','B');

--Q4--
--Now add new column to table L09SalesRep called JobCode that will be of variable character type 
--with max length of 12. Do a DESCRIBE L09SalesRep to ensure it executed

--A4--
ALTER TABLE L09SalesRep 
ADD JobCode VARCHAR2(12);


--Q5--
--Declare column Salary in table L09SalesRep as mandatory one
--and Column Location in table L09GoodCust as optional one. 
--You can see location is already optional

--A5--
ALTER TABLE L09SalesRep  
MODIFY Salary NOT NULL;

ALTER TABLE L09GoodCust 
MODIFY Location NULL;
-- *Cause:    the column may already allow NULL values

--Q5--
--Lengthen FNAME in L09SalesRep to 37. 
--The result of a DESCRIBE should show it happening
--You can only decrease the size or length of Name in L09GoodCust 
--to the maximum length of data already stored. 
--Do it by using SQL and not by looking at each entry 
--and counting the characters. May take two SQL statements

SELECT LENGTH(fname)
FROM L09SalesRep;

ALTER TABLE L09SalesRep
MODIFY Fname VARCHAR2(37);


--Q6--
--Now get rid of the column JobCode in table L09SalesRep in a way
--that will not affect daily performance. 

--A6--
ALTER TABLE L09SalesRep
DROP COLUMN JobCode;


--Q7--
--Declare PK constraints in both new tables  RepId and CustId

--A7--
ALTER TABLE L09SalesRep
ADD CONSTRAINT L09SalesRep_RepId_PK PRIMARY KEY (RepId) ;

ALTER TABLE L09GoodCust
ADD CONSTRAINT L09GoodCust_CustId_PK PRIMARY KEY (CustId) ;


--Q8--
--Declare UK constraints in both new tables  Phone# and Name

--A8--
ALTER TABLE L09SalesRep
ADD CONSTRAINT L09SalesRep_Phone_UK UNIQUE (Phone#);

ALTER TABLE L09GoodCust
ADD CONSTRAINT L09GoodCust_Name_UK UNIQUE (NAME);


--Q9--
--Restrict amount of Salary column to be in the range [6000, 12000] 
--and Commission to be not more than 50%.

--A9--
ALTER TABLE L09SalesRep
ADD CONSTRAINT L09SalesRep_Salary_CK CHECK (SALARY BETWEEN 6000 AND 12000);

ALTER TABLE L09SalesRep
ADD CONSTRAINT L09SalesRep_Commission_CK CHECK (Commission <= 0.5);


--Q10--
--Ensure that only valid RepId numbers from table L09SalesRep 
--may be entered in the table L09GoodCust. Why this statement has failed?

--A10--
ALTER TABLE L09GoodCust
ADD CONSTRAINT L09GoodCust_RepID_FK FOREIGN KEY (RepID)
    REFERENCES L09SalesRep(RepId);
--*Cause:    an alter table validating constraint failed because the table has child records.
--We cannot add the foreign key since there is data in the child table which does not have the one in the parent table


--Q11--
--Firstly write down the values for RepId column in table L09GoodCust and then make all these values blank. 
--Now redo the question 10. Was it successful? 

--A11--
UPDATE L09GoodCust
SET RepId = NULL;

ALTER TABLE L09GoodCust
ADD CONSTRAINT L09GoodCust_RepID_FK FOREIGN KEY (RepID)
    REFERENCES L09SalesRep(RepID);

--Yes. Table L09GOODCUST altered.


--Q12--
--Disable this FK constraint now and enter old values for RepId in table L09GoodCust and save them. 
--Then try to enable your FK constraint. What happened?

--A12--
ALTER TABLE L09GoodCust
DROP CONSTRAINT L09GoodCust_RepID_FK;

UPDATE L09GoodCust
SET RepId = 202
WHERE CUSTID = 502;

ALTER TABLE L09GoodCust
ADD CONSTRAINT L09GoodCust_RepID_FK FOREIGN KEY (RepID)
    REFERENCES L09SalesRep(RepID);

--*Cause:    an alter table validating constraint failed because the table has child records.
--The same thing happened. We cannot add the foreign key since there is data in the child table which does not have the one in the parent table


--Q13--
--Get rid of this FK constraint. Then modify your CK constraint from question 9 
--to allow Salary amounts from 5000 to 15000.

--A13--
ALTER TABLE L09GoodCust
DROP CONSTRAINT L09GoodCust_RepID_FK;

ALTER TABLE L09SalesRep
DROP CONSTRAINT L09SalesRep_Salary_CK;

ALTER TABLE L09SalesRep
ADD CONSTRAINT L09SalesRep_Salary_CK CHECK (Salary BETWEEN 5000 AND 15000);


--Q14--
--Describe both new tables L09SalesRep and L09GoodCust and then show 
--all constraints for these two tables by running the following query

--A14--
DESC L09SalesRep;
 
DESC L09GoodCust;

SELECT constraint_name, constraint_type, 
       search_condition, table_name
    FROM user_constraints
    WHERE lower(table_name) IN ('l09salesrep','l09goodcust')
    ORDER BY table_name, constraint_type;

