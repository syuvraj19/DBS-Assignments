-- ***********************
-- Name: Yuvraj Singh
-- ID: 155580210
-- Purpose: Lab 10 DBS311
-- ***********************

--Q1--
--1.	Create table L10Cities from table LOCATIONS, but only for location numbers less than 2000 
-- (do NOT create this table from scratch, i.e. create and insert in one statement).

--A1--
Create Table L10Cities As(
    Select * From Locations
    Where location_id < 2000);

Desc L10Cities;
Select * from L10Cities;

--Q2--
--Create table L10Towns from table LOCATIONS, but only for location numbers less than 1500 
--(do NOT create this table from scratch). 
--This table will have same structure as table L10Cities. 
--You will have exactly 5 rows here.

--A2--
Create Table L10Towns As
    Select * From Locations
    Where location_id < 1500;
    
Select * from L10Towns;

--Q3--
--Now you will empty your RECYCLE BIN with one powerful command. 
--Then remove your table L10Towns, so that will remain in the recycle bin. 
--Check that it is really there and what time was removed.  Hint: Show RecycleBin,   Purge,  Flashback

--A3--
SHOW RecycleBin;
PURGE RecycleBin;  --empty recyclebin
SHOW RecycleBin;
DROP TABLE L10Towns;
SHOW RecycleBin;

--DROP TIME:           
--2019-07-30:22:40:10 


--Q4--
--Restore your table L10Towns from recycle bin and describe it. Check what is in your recycle bin now.

--A4--
FLASHBACK TABLE L10Towns TO BEFORE DROP;
Desc L10Towns;
SHOW RecycleBin;
--Nothing is in the RecycleBin.
--SP2-0564: Object "" is INVALID, it may not be described.


--Q5--
--Now remove table L10Towns so that does NOT remain in the recycle bin. 
--Check that is really NOT there and then try to restore it. Explain what happened?

--A5--
Drop table L10Towns;
SHOW Recyclebin;
Purge RECYCLEBIN;
SHOW Recyclebin;
Flashback Table L10Towns To Before Drop;

--Error report -
--ORA-38305: object not in RECYCLE BIN
--38305. 00000 -  "object not in RECYCLE BIN"
--*Cause:    Trying to Flashback Drop an object which is not in RecycleBin.
--*Action:   Only the objects in RecycleBin can be Flashback Dropped.


--Q6--
--Create simple view called CAN_CITY_VU, based on table L10Cities so that will contain only columns Street_Address, 
--Postal_Code, City and State_Province for locations only in CANADA. Then display all data from this view.

--A6--
Create View CAN_CITY_VU As
    Select Street_Address, Postal_Code, City, State_Province
    From L10Cities
    Where Upper(Country_id) in ('CA');
    
Select * From CAN_CITY_VU;

--Q7--
--Modify your simple view so that will have following aliases instead of original column names: Str_Adr, P_Code, 
--City and Prov and also will include cities from ITALY as well. Then display all data from this view. 

--A7--
Create or Replace View CAN_CITY_VU As
    Select Street_Address "Str_Adr",  Postal_Code "P_Code",  City  , State_Province "Prov"
    From L10Cities
    Where Country_id in ('CA', 'IT');


--Q8--
--Create complex view called vwCity_DName_VU, based on tables LOCATIONS and DEPARTMENTS, 
--so that will contain only columns Department_Name, City and State_Province for locations in ITALY or CANADA. 
--Include situations even when city does NOT have department established yet. Then display all data from this view.

--A8--
Create View  vwCity_DName_VU As
    Select Department_Name, City, State_Province
    From Departments
    Right Join locations Using(location_id)
    Where country_id in ('IT', 'CA');

Select * From vwCity_DName_VU;

--Q9--
--Modify your complex view so that will have following aliases instead of original column names: 
--DName, City and Prov and also will include all cities outside United States 
--Include situations even when city does NOT have department established yet. 
--Then display all data from this view.

--A9--
Create or Replace View vwCity_DName_VU As
    Select Department_Name "DName", City "City", State_Province "Prov"
    From Departments
    Right Join locations Using(location_id)
    Where country_id Not in ('US');
    
Select * From vwCity_DName_VU;

--Q & A 10--
--Create a transaction, ensuring a new transaction is started, and include all the SQL statements 
--required to merge the Marketing and Sales departments into a single department �Marketing and Sales�. 
--Create a new department such that the history of employees departments remains intact.
--The Sales staff will change locations to the existing Marketing department�s location. 
-- All staff from both previous departments will change to the new department
--Add appropriate save points where the transaction could potentially be rolled back to (i.e. good checkpoints).
--Execute these statements, double check everything worked as intended, and then once it works through a single execution, 
--commit it.  If errors occur or the data is incorrect, you can rollback 
--and rerun after the errors have been corrected in the SQL code.

SAVEPOINT a
Insert Into Departments Values(400, 'Marketing and Sales', null, 1800)
SAVEPOINT b
Update Departments
Set Location_id = 1800
Where Department_id = 80
SAVEPOINT c
Update Employees
Set Department_id = 400
Where Department_id in (20, 80)
SAVEPOINT d;
COMMIT;


--Q11--
--Check in the Data Dictionary what Views (their names and definitions) are created so far in your account. 
--Then drop your vwCity_DName_VU and check Data Dictionary again. What is different?

--A11--
Select view_name
From user_views;

Drop View vwCity_DName_VU;

Select view_name
From user_views;
-- We cannot see the 'vwCity_DName_VU' on the list anymore. 