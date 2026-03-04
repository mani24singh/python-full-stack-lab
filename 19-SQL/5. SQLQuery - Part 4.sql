

--------------------------- SQL FUNCTIONS -------------------------------------------

-- 38. ROW_NUMBER, RANK, DENSE_RANK WINDOW FUNCTION - 1:

CREATE TABLE Students (
    student_name VARCHAR(100),
    subject VARCHAR(100),
    marks INT
);

INSERT INTO Students (student_name, subject, marks)
VALUES 
-- Marks for Alice
('Alice', 'Math', 85),
('Alice', 'Science', 88),
('Alice', 'English', 92),

-- Marks for Bob
('Bob', 'Math', 90),
('Bob', 'Science', 78),
('Bob', 'English', 85),

-- Marks for Charlie
('Charlie', 'Math', 85),
('Charlie', 'Science', 82),
('Charlie', 'English', 80),

-- Marks for David
('David', 'Math', 92),
('David', 'Science', 91),
('David', 'English', 89),

-- Marks for Eve
('Eve', 'Math', 90),
('Eve', 'Science', 85),
('Eve', 'English', 87),

-- Marks for Frank
('Frank', 'Math', 75),
('Frank', 'Science', 72),
('Frank', 'English', 78),

-- Marks for Grace
('Grace', 'Math', 85),
('Grace', 'Science', 89),
('Grace', 'English', 90);


select * from Students
--Row_Number -> In case of a tie row numbers are assigned randomly
select *,ROW_NUMBER() over(order by marks desc) as [Row Number]
from Students

--Rank -> if there's a tie next rank/ranks will be skipped
select *,rank() over(order by marks desc) as [Rank Function]
from Students

--Dense_Rank -> if there's a tie ranks will not be skipped
select *,DENSE_RANK() over(order by marks desc) [Dense Rank]
from Students

-----------------------------


--Row_Number -> In case of a tie row numbers are assigned randomly
select *,ROW_NUMBER() over(order by marks) as [Row Number]
from Students

--Rank -> if there's a tie next rank/ranks will be skipped
select *,rank() over(order by marks) as [Rank Function]
from Students

--Dense_Rank -> if there's a tie ranks will not be skipped
select *,DENSE_RANK() over(order by marks) [Dense Rank]
from Students

-----------------------------------------

--Row_Number -> In case of a tie row numbers are assigned randomly
select *,ROW_NUMBER() over(order by marks asc) as [Row Number]
from Students

--Rank -> if there's a tie next rank/ranks will be skipped
select *,rank() over(order by marks asc) as [Rank Function]
from Students

--Dense_Rank -> if there's a tie ranks will not be skipped
select *,DENSE_RANK() over(order by marks asc) [Dense Rank]
from Students

-----------------------------------------------------------------------------------------------

-- 39. ROW_NUMBER, RANK, DENSE_RANK WINDOW FUNCTION - 2:

select * from student

select *, ROW_NUMBER() over(partition by subject order by marks desc) [Row Number Desc]
from students

select *, row_number() over(partition by subject order by marks) [Row Number Asc]
from students

select *, row_number() over(partition by student_name order by marks desc) [Row Number Desc]
from students

select *, rank() over(partition by student_name order by marks desc) [Rank Desc]
from students

select *, rank() over(partition by subject order by marks desc) [Rank Desc]
from students

select *, dense_rank() over(partition by subject order by marks desc) [Dense Rank Desc]
from students

select *, dense_rank() over(partition by student_name order by marks desc) [Dense Rank Desc]
from students

select *, dense_rank() over(partition by student_name order by marks asc) [Dense Rank Asc]
from students

-----------------------------------------------------------------------------------------------

-- 40. LEAD FUNCTION:

create database [Profit DB]
use [profit db]

-- Create a table to store monthly profit data for different products
CREATE  TABLE ProfitData (
    MonthNumber INT,
    MonthName VARCHAR(3),
    Product VARCHAR(50),
    Profit INT
);

-- Insert data into the ProfitData table
INSERT INTO ProfitData (MonthNumber, MonthName, Product, Profit) VALUES
(1, 'Jan', 'Product A', 1000),
(2, 'Feb', 'Product A', 1500),
(3, 'Mar', 'Product A', 1200),
(4, 'Apr', 'Product A', 1700),
(5, 'May', 'Product A', 1300),
(6, 'Jun', 'Product A', 1600),
(1, 'Jan', 'Product B', 2000),
(2, 'Feb', 'Product B', 2500),
(3, 'Mar', 'Product B', 2200),
(4, 'Apr', 'Product B', 2700),
(5, 'May', 'Product B', 2300),
(6, 'Jun', 'Product B', 2600);

select * from ProfitData

--To add a new column that shows next month's profit for each product
select *,lead(Profit) over(partition by product order by monthnumber) [Next Month's Profit]
from ProfitData

--We don't want product column inthe output but we want each month's total profit to be show by monthnumber & monthname,Also a 
--new column should be added to show next month's total profit
select monthnumber,monthname,sum(profit) [Total Profit],
lead(sum(profit)) over(order by monthnumber asc) [Next Month's Total Profit]
from ProfitData
group by MonthNumber,MonthName
order by MonthNumber

-----------------------------------------------------------------------------------------------

-- 41. LAG FUNCTION:

select * from ProfitData

--To add a new column that shows previous month's profit for each product
select *,
lag(Profit) over(partition by product order by monthnumber) [Lag Function]
from ProfitData

--We don't want product column inthe output but we want each month's total profit to be show by monthnumber & monthname,Also a 
--new column should be added to show previous month's total profit
select MonthNumber,MonthName,sum(profit) [Total Profit for Month],
lag(sum(profit)) over(order by monthnumber) [Previous Month's Total Profit]
from ProfitData
group by MonthNumber,MonthName
order by MonthNumber

-----------------------------------------------------------------------------------------------

-- 42. ISNULL & COALESCE FUNCTION:

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    PhoneNumber VARCHAR(20),
    Address VARCHAR(255)
);

INSERT INTO Customers (CustomerID, FirstName, LastName, Email, PhoneNumber, Address)
VALUES
(1, 'Alice', 'Johnson', 'alice.johnson@example.com', '555-1234', '123 Elm St'),
(2, 'Bob', 'Smith', NULL, '555-5678', NULL),
(3, 'Charlie', 'Williams', 'charlie.williams@example.com', NULL, '456 Oak St'),
(4, 'Diana', 'Brown', NULL, NULL, '789 Pine St'),
(5, 'Eve', 'Davis', 'eve.davis@example.com', '555-8765', NULL);


select * from Customers

--Isnull
select isnull(null,'1 st value null')
select isnull('abx',null)
select isnull(null,null)

select coalesce('A','B','C')
select coalesce(null,'B','C')
select coalesce(null,null,'C')

--
select * from Customers

select Customerid,email,phonenumber from Customers

select Customerid,isnull(email,'Email NA'),isnull(phonenumber,'Ph No NA') from Customers

select Customerid,coalesce(email,phonenumber,'Contact NA') [Coalesce Function] from Customers

-----------------------------------------------------------------------------------------------

-- 43. FIRST_VALUE() FUNCTION:

CREATE TABLE EmployeeSalaries (
    EmployeeID INT,
    EmployeeName VARCHAR(50),
    Salary INT,
    Department VARCHAR(50)
);

INSERT INTO EmployeeSalaries (EmployeeID, EmployeeName, Salary, Department)
VALUES
(1, 'Alice', 50000, 'HR'),
(2, 'Bob', 60000, 'HR'),
(3, 'Charlie', 55000, 'HR'),
(4, 'David', 75000, 'Finance'),
(5, 'Eve', 80000, 'Finance'),
(6, 'Frank', 72000, 'Finance'),
(7, 'Grace', 90000, 'IT'),
(8, 'Heidi', 95000, 'IT'),
(9, 'Ivan', 87000, 'IT');

select * from EmployeeSalaries

select *
,FIRST_VALUE(Salary) over(order by salary asc) [Minimum Salary]
from EmployeeSalaries

select *
,FIRST_VALUE(EmployeeName) over(order by salary asc) [Emp with Minimum Salary]
,FIRST_VALUE(Salary) over(order by salary asc) [Minimum Salary]
from EmployeeSalaries

select * 
,FIRST_VALUE(EmployeeID) over(partition by department order by salary) [First Value]
from EmployeeSalaries

select * 
,FIRST_VALUE(EmployeeID) over(partition by department order by salary desc) [First Value EID]
,FIRST_VALUE(EmployeeName) over(partition by department order by salary desc) [First Value EName]
from EmployeeSalaries

-----------------------------------------------------------------------------------------------

-- 44. LAST_VALUE() FUNCTION:

CREATE TABLE EmployeeSalaries (
    EmployeeID INT,
    EmployeeName VARCHAR(50),
    Salary INT,
    Department VARCHAR(50)
);

INSERT INTO EmployeeSalaries (EmployeeID, EmployeeName, Salary, Department)
VALUES
(1, 'Alice', 50000, 'HR'),
(2, 'Bob', 60000, 'HR'),
(3, 'Charlie', 55000, 'HR'),
(4, 'David', 75000, 'Finance'),
(5, 'Eve', 80000, 'Finance'),
(6, 'Frank', 72000, 'Finance'),
(7, 'Grace', 90000, 'IT'),
(8, 'Heidi', 95000, 'IT'),
(9, 'Ivan', 87000, 'IT');

select * from EmployeeSalaries

--Incorrect Query
select * 
,LAST_VALUE(EmployeeName) over(order by salary desc) [Emp with Lowest Salary]
from EmployeeSalaries

--correct Query
select * 
,LAST_VALUE(EmployeeName) over(order by salary desc rows between unbounded preceding and unbounded following) [Emp with Lowest Salary]
from EmployeeSalaries

--correct Query
select * 
,LAST_VALUE(EmployeeName) over(order by salary desc rows between unbounded preceding and unbounded following) [Emp with Lowest Salary]
,LAST_VALUE(Salary) over(order by salary desc rows between unbounded preceding and unbounded following) [Lowest Salary]
from EmployeeSalaries

--correct Query
select * 
,LAST_VALUE(EmployeeName) over(partition by department
order by salary desc rows between unbounded preceding and unbounded following) [Emp with Lowest Salary]

,LAST_VALUE(Salary) over(partition by department order by salary desc rows between unbounded preceding and unbounded following) [Lowest Salary]
from EmployeeSalaries

--correct Query [Last Value Window Fun]
select * 
,LAST_VALUE(EmployeeName) over(partition by department
order by salary rows between unbounded preceding and unbounded following) [Emp with Highest Salary]

,LAST_VALUE(Salary) over(partition by department order by salary asc rows between unbounded preceding and unbounded following) [Highest Salary]
from EmployeeSalaries

--correct Query [First Value Window Fun]
select * 
,first_VALUE(EmployeeName) over(partition by department
order by salary desc) [Emp with Highest Salary]

,first_VALUE(Salary) over(partition by department order by salary desc) [Highest Salary]
from EmployeeSalaries

-----------------------------------------------------------------------------------------------