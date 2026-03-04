

-------------------------------------------------------------------------------------------

-- Questions Set-1:

create database [SQL Basics Questions]

use [SQL Basics Questions]

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10, 2)
);

INSERT INTO Employees (EmployeeID, FirstName, LastName, Department, Salary) VALUES
(1, 'John', 'Doe', 'HR', 55000.00),
(2, 'Jane', 'Smith', 'IT', 75000.00),
(3, 'Emily', 'Jones', 'Finance', 65000.00),
(4, 'Michael', 'Brown', 'IT', 80000.00),
(5, 'Sarah', 'Davis', 'HR', 60000.00),
(6, 'David', 'Wilson', 'Finance', 70000.00),
(7, 'Laura', 'Garcia', 'IT', 72000.00),
(8, 'Robert', 'Miller', 'HR', 58000.00),
(9, 'Sophia', 'Martinez', 'Finance', 67000.00),
(10, 'James', 'Anderson', 'IT', 81000.00);


--1) How do you select all columns from the Employees table?
select * from Employees

--2) How do you select only the FirstName and Last Name columns from the Employees table?
select FirstName,LastName from Employees

--3) How do you find all employees who work in the 'IT' department?
select * from Employees where Department = 'IT'
--or
select * from Employees where Department like 'IT'

--4) How do you select employees with a salary greater than 70,000?
select * from Employees where Salary>70000

--5) How do you sort the results by Last Name in ascending order?
select * from Employees order by LastName asc
--or
select * from Employees order by LastName

--6) How do you select distinct departments from the Employees table?
select distinct Department from Employees

--7) How do you count the number of employees in each department?
select Department,count(*) [Number of Employees] from Employees group by Department
--
select department,count(employeeid) [Number of Employees] from Employees group by Department

--8) How do you find the maximum salary in the Employees table?
select max(salary) [Maximum salary] from Employees

--9) How do you find the average salary of employees in the 'Finance' department?
select avg(Salary) [Finance Average] from Employees where Department like 'Finance'

--10) How do you select employees whose last name starts with 'M'?
select * from Employees where LastName like 'm%'

-------------------------------------------------------------------------------------------

-- Questions Set-2:

create database [SQL Basics Questions]

use [SQL Basics Questions]

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10, 2)
);

INSERT INTO Employees (EmployeeID, FirstName, LastName, Department, Salary) VALUES
(1, 'John', 'Doe', 'HR', 55000.00),
(2, 'Jane', 'Smith', 'IT', 75000.00),
(3, 'Emily', 'Jones', 'Finance', 65000.00),
(4, 'Michael', 'Brown', 'IT', 80000.00),
(5, 'Sarah', 'Davis', 'HR', 60000.00),
(6, 'David', 'Wilson', 'Finance', 70000.00),
(7, 'Laura', 'Garcia', 'IT', 72000.00),
(8, 'Robert', 'Miller', 'HR', 58000.00),
(9, 'Sophia', 'Martinez', 'Finance', 67000.00),
(10, 'James', 'Anderson', 'IT', 81000.00);

select * from Employees

--1. How do you select employees who work in the 'IT' department and have a salary greater than 75,000?
select * from employees where Department in ('IT') and Salary>=75000

--2. How do you find employees who work in the 'HR' department or have a salary less than 60,000?
select * from Employees where Department in ('HR') or Salary<60000

--3. How do you select employees who do not work in the 'Finance' department?
select * from Employees where Department not in ('Finance')
--or
select * from Employees where not Department = 'Finance'

--4. How do you find employees whose salary is between 60,000 and 70,000 and who work in the 'Finance' department?
select * from Employees where Salary between 60000 and 70000 and Department in ('Finance')

--5. How do you find employees who work in the 'IT' department and do not have a salary greater than 80,000?
select * from Employees where Department = 'Finance' and Salary<=80000
--or
select * from Employees where Department in ('Finance') and not Salary>80000

--6. How do you find employees who work in the 'HR' or 'Finance' departments and have a salary greater than 65,000?
select * from Employees where (Department in ('HR') OR Department in ('Finance')) and Salary>=65000

select * from Employees

--7. How do you select employees whose last name starts with 'D' and do not work in the 'HR' department?
select * from Employees where LastName like 'd%' and Department not in ('HR')

--8. How do you find employees who do not work in the 'IT' department and have a salary greater than 70,000?
select * from Employees where not Department = 'IT' and Salary>70000

--9. How do you select employees who work in the 'IT' department and either have a salary greater 
--than 75,000 or have the first name 'Laura'?
select * from Employees where (Salary>75000 or FirstName = 'Laura') and Department in ('IT')

--10. How do you find employees who do not work in the 'HR' or 'IT' departments?
select * from Employees where Department not in ('HR','IT')

-------------------------------------------------------------------------------------------

-- Questions Set-3 (Joins):

create database [SQL Questions]

use [SQL Questions]

-- Create the Customers table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    Country VARCHAR(50)
);

-- Insert data into Customers table
INSERT INTO Customers (CustomerID, CustomerName, Country)
VALUES 
(1, 'Alice', 'USA'),
(2, 'Bob', 'UK'),
(3, 'Charlie', 'Canada'),
(4, 'David', 'USA'),
(5, 'Eve', 'Australia');

-- Create the Orders table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    ProductID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Insert data into Orders table
INSERT INTO Orders (OrderID, CustomerID, OrderDate, ProductID)
VALUES 
(101, 1, '2024-08-01', 1001),
(102, 1, '2024-08-03', 1002),
(103, 2, '2024-08-04', 1001),
(104, 3, '2024-08-05', 1003),
(105, 5, '2024-08-06', 1004);

-- Create the Products table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Price DECIMAL(10, 2)
);

-- Insert data into Products table
INSERT INTO Products (ProductID, ProductName, Price)
VALUES 
(1001, 'Laptop', 1000),
(1002, 'Smartphone', 700),
(1003, 'Tablet', 500),
(1004, 'Headphones', 200),
(1005, 'Smartwatch', 300);

select * from Customers

select * from Orders

select * from Products

--1) Write an SQL query to find the names of customers who have placed an order.
select distinct CustomerName from customers c inner join Orders o on o.CustomerID = c.CustomerID

--2) Find the list of customers who have not placed any orders.
select distinct CustomerName from Customers c left join Orders o on O.CustomerID = C.CustomerID where o.OrderID is null

--3) List all orders along with the product name and price.
select distinct ProductName,Price from Orders o join Products p on o.ProductID = p.ProductID  

--4) Find the names of customers and their orders, including customers who haven't placed any orders.
select distinct CustomerName,OrderID from Customers c left join Orders o on o.CustomerID = c.CustomerID

--5) Retrieve a list of products that have never been ordered.
select distinct p.ProductID,ProductName from Products p left join Orders o on p.ProductID = o.ProductID where o.OrderDate is null

--6) Find the total number of orders placed by each customer.
select customername,count(orderid) [Number of Orders] from Customers c inner join Orders o on c.CustomerID = o.CustomerID
group by customername
--OR 
select customername,count(orderid) [Number of Orders] from Customers c LEFT join Orders o on c.CustomerID = o.CustomerID
group by customername

--7) Display the customers, the products they've ordered, and the order date. Include customers who haven't placed any orders.
select distinct CustomerName,p.ProductID,ProductName,OrderDate
from Customers c left join Orders o on c.CustomerID = o.CustomerID left join Products p on o.ProductID = p.ProductID

-------------------------------------------------------------------------------------------

-- Questions Set-4 (Joins):

select * from Customers

select * from Orders

select * from Products

--1) Identify pairs of customers who live in the same country.
select x.CustomerName, y.CustomerName 
from Customers x join Customers y on x.Country = y.Country and x.CustomerID <> y.CustomerID and x.CustomerID> y.CustomerID

--2) Find the customer who has spent the most on their orders.
select customername from
(select CustomerName, sum(price) [amount spent],Dense_Rank() over(order by sum(price) desc) [DR]
from Customers c inner join
Orders o in c.CustomerID = o.CustomerID inner join Products p on o.ProductID = p.ProductID
group by CustomerName) m where DR=1

--3) Find customers who have ordered more than one type of products.
select CustomerName, count(ProductID) from Customers c join Orders o on c.CustomerID = o.CustomerID
group by CustomerName
having count(productid)>1

--4) List all products and their corresponding orders, using a RIGHT JOIN including products that have never been ordered.
select OrderID, p.ProductID, ProductName from Orders o right join Product p on o.ProductID = p.ProductID

--5) Retrieve all orders placed by customers from the USA.
select OrderID from Customers c inner join Orders o on c.CustomerID = o.CustomerID where Country in ('USA')

--6) Find the names of customers who have ordered a product priced above $500.
select distinct 
CustomerName from Customers c inner join Orders o  on o.CustomerID = c.CustomerID inner join Products p on
p.ProductID = o.ProductID where Price > 500 

--7) Find customers who have ordered the same product more than once.
select distinct CustomerName from
(select CustomerName, ProductID, Count(OrderID) [Count] from Customers c inner join orders o on c.CustomerID = o.CustomerID
group by CustomerName, ProductID
having Count(OrderID)>1) m 

-------------------------------------------------------------------------------------------

-- Nth Highest Salary:

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    EmployeeName NVARCHAR(100),
    Salary DECIMAL(10, 2)
);

INSERT INTO Employees (EmployeeID, EmployeeName, Salary)
VALUES
(1, 'Alice Smith', 70000.00),
(2, 'Bob Johnson', 85000.00),
(3, 'Carol White', 95000.00),
(4, 'David Brown', 60000.00),
(5, 'Eve Davis', 75000.00),
(6, 'Frank Miller', 90000.00),
(7, 'Grace Lee', 80000.00),
(8, 'Hannah Clark', 62000.00),
(9, 'Ivy Harris', 74000.00),
(10, 'Jack Lewis', 98000.00);

select * from Employees

--2nd Highest Salary
select max(salary) [2nd Highest Salary] from employees where salary<
(select max(salary) from Employees)

--3rd highest salary
select max(salary) [3rd Highest Salary] from employees where salary< (
select max(salary) from employees where salary<
(select max(salary) from Employees))

--CTE
with cte as(
select *,DENSE_RANK() over(order by salary desc) [DR] from Employees
)

select salary [2nd Highest Salary] from cte where DR = 2

--3rd Highest Salary
with cte as(
select *,DENSE_RANK() over(order by salary desc) [DR] from Employees
)

select salary [3rd Highest Salary] from cte where DR = 3

--Sub Query along with Dense_Rank()

select salary as [2nd highest salary] from
(select *, DENSE_RANK() over(order by salary desc) [DR] from Employees) x
where DR = 2

select salary as [3rd highest salary] from
(select *, DENSE_RANK() over(order by salary desc) [DR] from Employees) x
where DR = 3

--Sub Query
select top 1 salary [2nd Highest Salary] from 
(select distinct top 2 salary from Employees order by Salary desc) x
order by Salary asc

--3rd Highest Salary
select top 1 salary [3rd Highest Salary] from 
(select distinct top 3 salary from Employees order by salary desc) y
order by Salary asc

-------------------------------------------------------------------------------------------

-- Reportee and Manager Question:

-- Create the table
CREATE TABLE ReportingStructure (
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(100),
    ManagerID INT
);

-- Insert data into the table
INSERT INTO ReportingStructure (EmployeeID, EmployeeName, ManagerID) VALUES
(1, 'Alice Smith', NULL),  -- Alice Smith is at the top and reports to no one
(2, 'Bob Johnson', 1),     -- Bob Johnson reports to Alice Smith
(3, 'Carol White', 1),     -- Carol White reports to Alice Smith
(4, 'David Brown', 2),     -- David Brown reports to Bob Johnson
(5, 'Eve Davis', 2),       -- Eve Davis reports to Bob Johnson
(6, 'Frank Miller', 3);    -- Frank Miller reports to Carol White

select * from ReportingStructure

select b.employeename [Reportee],A.employeename [Manager]
from
ReportingStructure A inner join reportingstructure B
on a.employeeid = b.managerid

union all

select employeename,null [Manager] from reportingstructure
where managerid is null

-------------------------------------------------------------------------------------------

-- Deleting Duplicates Q1:

-- Create the table with potential duplicates
CREATE TABLE EmployeeRecords (
    EmployeeID INT,
    EmployeeName VARCHAR(100),
    ManagerID INT
);

-- Insert data into the table, including duplicates
INSERT INTO EmployeeRecords (EmployeeID, EmployeeName, ManagerID) VALUES
(1, 'Alice Smith', NULL),
(2, 'Bob Johnson', 1),
(3, 'Carol White', 1),
(4, 'David Brown', 2),
(5, 'Eve Davis', 2),
(6, 'Frank Miller', 3),
(2, 'Bob Johnson', 1),  -- Duplicate entry
(4, 'David Brown', 2);  -- Duplicate entry

select * from EmployeeRecords
order by EmployeeID,EmployeeName,ManagerID

With CTE as (
select *, row_number() over(partition by employeeid,employeename,managerid order by employeeid) [Row Number] from EmployeeRecords
)
--select * from CTE
delete from cte where [Row Number] = 2

-----------------------
select * into emprecords_bkp from EmployeeRecords

select * from emprecords_bkp

select distinct * into #1 from emprecords_bkp

truncate table emprecords_bkp

insert into emprecords_bkp select * from #1

select * from #1

-----------------------------------------------------------------------------------------------
-- Deleting Duplicates Q2:
-- Create the table with EmployeeID and Email
CREATE TABLE EmployeeRecords_1 (
    EmployeeID INT,
    Email VARCHAR(100)
);

-- Insert data into the table, including duplicates
INSERT INTO EmployeeRecords_1 (EmployeeID, Email) VALUES
(1, 'alice@example.com'),
(2, 'bob@example.com'),
(3, 'carol@example.com'),
(4, 'david@example.com'),
(2, 'bob@example.com'),        -- Duplicate entry (same EmployeeID and Email)
(4, 'david@example.com'),      -- Duplicate entry (same EmployeeID and Email)
(5, 'shared@example.com'),     -- Valid case: Same email, different EmployeeID
(6, 'shared@example.com');     -- Valid case: Same email, different EmployeeID


select * from EmployeeRecords_1
order by Employeeid,email

------
select distinct * into #1 from EmployeeRecords_1

truncate table EmployeeRecords_1

insert into EmployeeRecords_1 select * from #1

select * from EmployeeRecords_1 order by email

--

--Record with Lower Employee ID should remain
with cte as (
select *, DENSE_RANK() over(partition by email order by employeeid) [DR] from EmployeeRecords_1

)

delete from cte where dr = 2

---
select * into employeerecords_2 from #1

select * from employeerecords_2 order by email

--Retail the record with higher Employee id
with cte as (
select *, DENSE_RANK() over(partition by email order by employeeid desc) [DR] from employeerecords_2
)
--select * from cte
delete from cte where DR = 2

-------------------------

select * from employeerecords_1 --Employeeid = 5 was retained

select * from employeerecords_2 --Employeeid = 6 was retained

------------------------------------------------------------------------------------------------