
-- Creating database
Create database employee_details
use employee_details

----------------------------------------------------------------------------------------

-- 1. SELECT Statements: returns requested records from the table

-- Table
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10, 2),
    HireDate DATE
);

INSERT INTO Employees (EmployeeID, FirstName, LastName, Department, Salary, HireDate)
VALUES
(1, 'John', 'Doe', 'HR', 50000.00, '2020-01-15'),
(2, 'Jane', 'Smith', 'Finance', 60000.00, '2019-03-23'),
(3, 'Alice', 'Johnson', 'IT', 75000.00, '2021-07-10'),
(4, 'Bob', 'Brown', 'Marketing', 55000.00, '2018-09-30'),
(5, 'Charlie', 'Davis', 'IT', 70000.00, '2022-02-20');


-- Queries
Select * from Employees;
Select firstname from Employees;
Select firstname, Salary from Employees;
Select firstname, lastName from Employees;

select EmployeeID, concat(firstname, ' ', lastname) from Employees;

select EmployeeID, concat(firstname, ' ', lastname) [Full Name] from Employees;
select EmployeeID, concat(firstname, ' ', lastname) as [Full Name] from Employees; -- 'as' as alias

----------------------------------------------------------------------------------------------

-- 2. DISTINCT Statements: returns distinct records from the table

-- Table
CREATE TABLE EmployeeRecords (
    EmployeeID INT PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Department NVARCHAR(50),
    Salary DECIMAL(10, 2)
);


INSERT INTO EmployeeRecords (EmployeeID, FirstName, LastName, Department, Salary)
VALUES
(1, 'John', 'Miller', 'HR', 60000),
(2, 'Jane', 'Smith', 'Finance', 75000),
(3, 'John', 'Miller', 'HR', 60000),
(4, 'Emily', 'Davis', 'IT', 85000),
(5, 'Michael', 'Brown', 'Finance', 75000),
(6, 'Jane', 'Smith', 'Finance', 75000);

-- Queries
 Select * from EmployeeRecords;
 Select Distinct FirstName from EmployeeRecords;
 Select Distinct firstname, lastname from EmployeeRecords;
 Select Distinct Salary from EmployeeRecords;
 Select Distinct * From EmployeeRecords;

 ----------------------------------------------------------------------------------------------

 -- 3. Temporary Tables: create replica of a table 

 select * into #temp1 from [dbo].[Employees];
 select * from #temp1;    --  # is called as pound sign 

 select * into ##temp2 from [dbo].[EmployeeRecords];
 select * from ##temp2; 

 /* Very Important Note:
 1. Temp table created with single # sign is not recognized in other window apart from where it is created (throws and error).
 2. Temp table created with double ## sign is recognized in other windows as well.
 
 3. Also, table  with ## sign table is active in new instance until the main instance of that server where table was
 created is active whereas table with # sign is not active in new instance either. */


-----------------------------------------------------------------------------------------------

-- 4. WHERE Clause: filter the records to view only required rows/data

select * from [dbo].[Employees];
select * from [dbo].[Employees] where employeeid = 2;

select EmployeeID, firstname from [dbo].[Employees] where employeeid = 2;

select * from [dbo].[Employees] where salary >= 75000.00;
select FirstName,LastName,Department,Salary from dbo.EmployeeRecords where Salary<75000.00

select distinct FirstName,LastName,Department,Salary from dbo.EmployeeRecords where Salary<75000.00;

-----------------------------------------------------------------------------------------------

-- 5. ORDER BY CLAUSE: Sort the table either in ascending or descending order of column
select * from [dbo].[Employees];

select * from [dbo].[Employees] order by salary;
select * from [dbo].[Employees] order by salary desc;

select * from [dbo].[Employees] order by firstname asc, salary desc;
select * from [dbo].[Employees] order by Department asc, salary desc;

-----------------------------------------------------------------------------------------------

-- 6. AND & OR OPERATOR: filter data based on multiple conditions (and = fulfill both, or = either or both met)
select * from [dbo].[EmployeeRecords];

-- Conditions
select * from [dbo].[EmployeeRecords] where LastName = 'Miller';
select * from [dbo].[EmployeeRecords] where LastName = 'Miller' and EmployeeID = 3;
select * from [dbo].[EmployeeRecords] where LastName = 'Miller' and EmployeeID = '3';

select * from [dbo].[EmployeeRecords] where Department = 'HR' or Department = 'Finance';

select * from [dbo].[EmployeeRecords] where (Department = 'HR' or Department = 'Finance') and salary=60000;

-----------------------------------------------------------------------------------------------

-- 7. NOT, BETWEEN & IN OPERATOR:
select * from dbo.EmployeeRecords;

-- NOT 
select * from dbo.EmployeeRecords where not firstname = 'john';
select * from dbo.EmployeeRecords where not firstname = 'john' and not salary = 60000;
select * from dbo.EmployeeRecords where not lastname = 'Miller' or not Department = 'HR';

-- BETWEEN
select * from dbo.EmployeeRecords where salary between 75000 and 85000;
select * from dbo.EmployeeRecords where salary>= 75000 and Salary<=85000;

select * from dbo.EmployeeRecords where salary not between 75000 and 85000;
select * from dbo.EmployeeRecords where not salary between 75000 and 85000;

-- IN
select * from dbo.EmployeeRecords where Department = 'HR' or Department = 'IT';
select * from dbo.EmployeeRecords where Department in ('HR', 'IT');
select * from dbo.EmployeeRecords where Department not in ('HR', 'IT');

-----------------------------------------------------------------------------------------------

-- 8. INSERT INTO: Add a row value into the table
select * from [dbo].[Employees];

insert into dbo.Employees (EmployeeID,FirstName,LastName,Department,Salary,HireDate)
values (6,'Raj','Ambani','IT',67000,'2023-04-20')

insert into dbo.Employees (EmployeeID,FirstName,LastName)
values (7,'Rohit','Mehra')

insert into dbo.Employees
values (8,'Mahesh','Narang','HR',73000,'2024-01-21')  -- only possible incase where all record values given

-- To check the schema of the table to get the data type of table columns
select * from INFORMATION_SCHEMA.COLUMNS where table_name = 'Employees'


-----------------------------------------------------------------------------------------------

-- 9. NULL OPERATOR: Operator to add a Nan value in table (it is different from blank('') or zeroth value('0')
select * from [dbo].[Employees];

Insert into dbo.Employees
values (9, 'Jay', '', 'IT', 73000, '2022-04-04');   -- This inserts a blank value in lastName

Insert into dbo.Employees
VALUES (10,'Nitin','shamani','0',54000,'2021-02-22');  -- This inserts a zero value

/* Note:
1. Null values are different from blank values.
2. Zero value is different from null and blank. */

--  Find the departments who value is null
select * from dbo.Employees where Department = null  -- doesnt provide output,wrong way to query.
select * from dbo.Employees where Department is null  -- for null operator we need to write 'is'
select * from dbo.Employees where Department is not null



-----------------------------------------------------------------------------------------------

-- 9. UPDATE STATEMENT: Use to update a value in table (Update table should have where clause otherwise whole table will be updated)
select * from [dbo].[Employees];

-- Lets create a hash table for practice hence our original table is not disturbed from update
select * into #1 from dbo.Employees
select * from #1

Update #1 set Department = 'HR' Where Department is Null;

update #1 set salary=89000, hiredate='2023-01-01' where EmployeeID = 7
select * from #1 where EmployeeID = 7

-- Experimenting what will happen if we dont use where clause
select * into #2 from dbo.Employees
select * from #2

update #2 set Department = 'Finance'

-- IMPORTANT NOTE: Be Caution and use 'where' clause when dealing with update or delete command (check number of rows impacted)

-----------------------------------------------------------------------------------------------

-- 10. DELETE, DROP, TRUNCATE: (where clause is a must while using such statements)
select * from [dbo].[Employees];

select * into #3 from dbo.Employees;
select * from #3

-- DELETE: To delete an entry from the table (usually used to drop a specific entry)
delete from #3 where LastName='' or Department='0'

    -- Suppose, we dont use where clause in table #4 for delete statement, the whole table is deleted and structure remains
    select * into #4 from dbo.Employees
    select * from #4
    delete from #4  -- this drops the table #4 but keeps the structure of table

-- TRUNCATE: To drop all records from the table, without dropping the structure of the table
truncate table #3
select * from #3

-- DROP: To drop a table completely
drop table #3

/* Note:
1. Delete - delete certain records from the table
2. if we will use delete without where condition, all records from the table will be deleted, but the table structure remains intact
3. Truncate - delete all the records from the table but the structure of the table remains intact
4. Drop - all the records will be deleted plus table structure will also be removed. */
 
-----------------------------------------------------------------------------------------------

-- 11. COMMENTS & TOP N: Write readable comments in sql, TOP N give top n result

-- Hi we are learning SQL Server (single line comment)
select * from dbo.employees

/*
Hi
we 
are                 (multi-line comment)
learning
sql
server
*/
select * from dbo.employees

select top 2 * from dbo.employees     -- (TOP N)
select top 2 employeeid,salary from dbo.employees
select top 5 firstname,lastname from dbo.employees
-----------------------------------------------------------------------------------------------

-- 12. MAX, MIN and GROUPBY: 

Create database [Sales Database]
use [sales database]

-- Creating a table with more columns, including a varchar column
CREATE TABLE dbo.Sales (
    ProductID INT,
    SaleDate DATE,
    Quantity INT,
    TotalAmount DECIMAL(10, 2),
    CustomerID INT,
    StoreID INT,
    SalespersonID INT,
    PaymentMethod VARCHAR(50)  -- New varchar column for payment method
);

-- Inserting more sample data (10 records), including NULL values
INSERT INTO dbo.Sales (ProductID, SaleDate, Quantity, TotalAmount, CustomerID, StoreID, SalespersonID, PaymentMethod)
VALUES 
(1, '2023-08-01', 10, 200.00, 101, 1, 201, 'Credit Card'),
(2, '2023-08-01', 5, 150.00, 102, 1, 202, 'Cash'),
(1, '2023-08-02', 8, 160.00, 103, 2, 203, 'Credit Card'),
(2, '2023-08-02', 7, 210.00, 104, 2, 204, 'Cash'),
(1, '2023-08-03', 6, 120.00, 105, 1, 201, NULL),              -- NULL value in PaymentMethod
(3, '2023-08-04', 12, 300.00, 106, 3, 205, 'Credit Card'),
(1, '2023-08-04', 5, 100.00, 107, 3, 206, 'Debit Card'),
(2, '2023-08-05', 9, 270.00, 108, 1, 202, NULL),              -- NULL value in PaymentMethod
(3, '2023-08-05', 15, 375.00, 109, 3, 207, 'Cash'),
(1, '2023-08-06', 7, 140.00, 110, 2, 203, 'Credit Card');

select * from dbo.sales

-- 1. MAX: Function to calculate maximum of record. 
select max(TotalAmount) [Maximum Amount] from dbo.sales;
select max(saledate) [Max SalesDate] from dbo.Sales
select max(paymentmethod) [Max Pay method] from dbo.Sales

-- 2. MIN: Function to calculate minimum of record. 
select min(quantity) [Minimum Quantity] from dbo.Sales
select min(saledate) [Minimum Sales Date] from dbo.Sales
select min(paymentmethod) [Minimum Pay Method] from dbo.Sales

-- 3. Groupby: Function used to perform grouping and aggregation of a value.
----- Maximum Quantity sold for each productID
select productid, max(quantity) [Maximum Quantity] from dbo.sales group by productid;
----- Maximum Total Amount for all distinct dates in saledate column
select saledate, max(TotalAmount)[Maximum Total Amount] from dbo.sales group by saledate;
----- Show minimum totalamount for each storeid
select storeid, min(totalamount) [Minimum Total Amount] from dbo.Sales group by storeid

-----------------------------------------------------------------------------------------------

-- 13. SUM, AVG, COUNT, GROUP BY: Function to calculate sum(total), average, count of a record table.

select * from dbo.sales

----- SUM
select sum(quantity) [Total Quantity] from dbo.sales
select sum(quantity) [Total Quantity],sum(totalamount) [Sum of Amount] from dbo.Sales

-- Average
select avg(quantity) [Average Quantity] from dbo.Sales
select avg(quantity) [Avg Quantity],avg(totalamount) [Avg Amount] from dbo.Sales

-- Question: Sum of Quantity, sum of totalamount, avg of quantity, avg of total amount for each distinct product
select 
ProductID,
sum(Quantity) as [Total Quantity],
sum(TotalAmount) as [Sum of Amount],
avg(Quantity) [Average Quantity Sold],
avg(TotalAmount) [Average Amount]
from dbo.Sales
group by ProductID


-- Question: Sum of Quantity, sum of amount, avg of quantity & avg of amount for distinct combinations of ProductID & storeid
select
productid,
storeid,
sum(Quantity) [Total Quantity],
sum(totalamount) [Sum of Amount],
avg(quantity) [Avg of Quantity],
avg(totalamount) [Avg of Amount]
from dbo.sales
group by ProductID,StoreID

-- Count 
select * from dbo.sales
select count(*) [Number of Rows] from dbo.Sales
select count(paymentmethod) [No of Records] from dbo.Sales
select count(distinct productid) [Distinct Products] from dbo.Sales

select PaymentMethod,count(distinct paymentmethod) [Distinct Pay Mode] from dbo.Sales
group by PaymentMethod

select PaymentMethod,count(paymentmethod) [Pay Mode] from dbo.Sales
group by PaymentMethod

select PaymentMethod,count(*) [Pay Mode] from dbo.Sales
group by PaymentMethod
-- Note: Null values are ignored by min, max, sum, avg, count functions during aggregation.


-----------------------------------------------------------------------------------------------

-- 14. GROUPBY Clause: Used to query a table based on group aggregation

select * from dbo.Sales

select paymentmethod,sum(totalamount) as [Sum of Sales] from dbo.Sales
group by PaymentMethod

select ProductID,PaymentMethod,sum(TotalAmount) [Sum of Sales] from dbo.Sales
group by ProductID,PaymentMethod
order by ProductID

-----------------------------------------------------------------------------------------------

-- 14. HAVING Clause: Generally used with groupby clause, to filter the groupby records based on conditions

select * from dbo.Sales

--Total Sales, Avg Sales, Total Quantity, Avg Quantity for each distinct product
select 
ProductID,
sum(TotalAmount) [Sum of Sales],
sum(Quantity) [Total Quantity],
avg(TotalAmount) [Avg Amount],
avg(Quantity) [Avg Quantity]
from dbo.Sales
group by 
ProductID
having sum(TotalAmount)<700 and sum(Quantity) = 21

-----------------------------------------------------------------------------------------------

-- 15. Difference Between Having and Where Clause: Where is used to filter out data based on conditions from 
--      table itself where as having is used to filter conditions from the groups formed.

select * from dbo.Sales

select * from dbo.Sales where TotalAmount>=161

select productid, sum(totalamount) [Sum of sales] from dbo.Sales
group by ProductID
having sum(totalamount)<700


-- Combined (Where + Having)
select productid,sum(totalamount) [Sum of sales] from dbo.Sales
where TotalAmount>=161
group by productid
having sum(totalamount)>=250
order by PRODUCTid desc


select productid,sum(totalamount) [Sum of sales] from dbo.Sales
where TotalAmount>=161
group by productid
having sum(totalamount)>=250
order by sum(totalamount) asc

-----------------------------------------------------------------------------------------------