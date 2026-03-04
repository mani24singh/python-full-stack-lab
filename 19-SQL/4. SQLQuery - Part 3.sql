

-- 24. CASE Statement & Order By Clause:

-- Create the Products table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Category VARCHAR(20),
    Price DECIMAL(10, 2),
    StockQuantity INT,
    Supplier VARCHAR(50),
    Rating DECIMAL(3, 1)
);

-- Insert data into the Products table
INSERT INTO Products (ProductID, ProductName, Category, Price, StockQuantity, Supplier, Rating) VALUES
(1, 'Wireless Mouse', 'Electronics', 25.99, 150, 'Tech Supplies', 4.5),
(2, 'Office Chair', 'Furniture', 120.00, 85, 'Comfort Co', 4.7),
(3, 'Water Bottle', 'Accessories', 15.00, 250, 'AquaGear', 4.3),
(4, 'Laptop Backpack', 'Accessories', 45.99, 200, 'GearUp', 4.6),
(5, 'Gaming Laptop', 'Electronics', 999.99, 45, 'Tech Supplies', 4.8),
(6, 'Desk Lamp', 'Furniture', 35.00, 120, 'LightHouse', 4.2),
(7, 'Bluetooth Speaker', 'Electronics', 59.99, 95, 'SoundWave', 4.4),
(8, 'Standing Desk', 'Furniture', 250.00, 50, 'Comfort Co', 4.9),
(9, 'Fitness Tracker', 'Electronics', 129.99, 180, 'FitTech', 4.7),
(10, 'Coffee Mug', 'Accessories', 9.99, 300, 'MugMasters', 4.1);


select * from Products

--Example1 : Add a column to categorize each product into categories high, medium & low
select 
*,
case
	when Price > 500 then 'High' 
	when Price<=500 and Price>=200 then 'Medium'
	else 'Low'
end as [High/Medium/Low]
from products
-----------------------------------------------Test
select 
*,
case
	when Price > 500 then 'High' 
	when Price<=500 and Price>=200 then 'Medium'
end as [High/Medium/Low]
from products

--Example2 : Provide priority to each category & sort the data according to that priority
select * from Products
order by 
case 
	when Category in ('Electronics') then 1
	when Category in ('Furniture') then 2
	else 3
end

-----------------------test

select * from Products
order by 
case 
	when Category in ('Electronics') then 1
	when Category in ('Furniture') then 2
	when Category = 'Accessories' then 3
end


-----------------------------------------------------------------------------------------------

-- 25. NESTED CASE Statement: 

select * from Products
-- We need to group the data based on columns category & price into different categories i.e affordable & premium
select 
*,
case 
	when Category = 'Electronics' then
		case when Price>=300 then 'Premium Electronics'
		else 'Affordable Electronics'
		end 
	when Category = 'Furniture' then
		case when Price>=250 then 'Premium Furniture'
		else 'Affordable Furniture'
		end 
else 
		case when Price>=25 then 'Premium Accessories'
		else 'Affordable Accessories'
		end
end as [Groups]
from products


--------------Test
select 
*,
case 
	when Category = 'Electronics' then
		case when Price>=300 then 'Premium Electronics'
		else 'Affordable Electronics'
		end 
	when Category = 'Furniture' then
		case when Price>=250 then 'Premium Furniture'
		else 'Affordable Furniture'
		end 
    when Category in ('Accessories') then
		case when Price>=25 then 'Premium Accessories'
		else 'Affordable Accessories'
		end
end as [Groups]
from products

-----------------------------------------------------------------------------------------------

-- 25. SQL DATA TYPES: 

-- SQL Data Types:
/*
1. String Data: char, varchar, nchar, nvarchar. Eg. M or F,  
				char(1), varchar(256), nchar(1) - it supports unicode, nvarchar(256) - it supports unicode
2. Number Type:  int, bigint, tinyint, decimal(p,s), smallint
				- Age of the students, tinyint
				- Age of trees/buildings, smallint
				- decimal(p,s) , p represents total digits, s refers to number of digits you may have after decimal
					Eg. 999.99, decimal(5,2)

3. Date data type
4. time data type
5. datetime data type 

Reference https://learn.microsoft.com/en-us/sql/t-sql/data-types/data-types-transact-sql?view=sql-server-ver16 */

-----------------------------------------------------------------------------------------------

-- 26. SQL CREATE TABLE: 

create database Student
use Student

create table student_details (
Student_Name nvarchar(256),
Gender char(1),
Age tinyint,
event_date date,
distance decimal(5,2))

-- drop table student_details

select * from student_details

insert into student_details(Student_Name,Gender,Age,event_date,distance)
values ('Raj Mehera','M',25,'2024-08-03',123.11)

insert into student_details
values ('Nitin Singh','M',32,'2023-12-06',119.09)

-----------------------------------------------------------------------------------------------

-- 27. INSERTING RECORDS into All Columns of the table:

select * from student_details

insert into student_details
values ('Mayank','M',18,'2024-02-02',115.35),
('Mahesh','M',34,'2023-11-08',324.66)

select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME like 'student_details'

insert into student_details (Student_Name,Gender)
values ('Priya','F')

select * from student_details

-----------------------------------------------------------------------------------------------

-- 28. INSERTING RECORDS into Certain Columns in a table:

insert into student_details(Age,event_date)
values (34,'2023-10-04'),(43,'2019-01-01'),(19,'2022-08-08')

select * from student_details

--Datatype of column age is tinyint (0 to 255)

select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME like 'student_details'

insert into student_details (Age)
values (256)
-----------------------------------------------------------------------------------------------

-- 29. Copying Data From One Table to Another:


--Copying Data From existing table to the New table

--Case 1 : The New table simply doesn't exist
--Case 2: The New table structure/New Table exists

--CASE 1 :
select * from dbo.Sales 

--All columns were copied from existing table
--This statement will result in the creation of New_Table_1 which will be having structure & records both
--same as that of dbo.sales table
select * into New_Table_1 from dbo.Sales

-------------------Certain Columns to be copied
drop table New_Table_1

select productid,quantity into new_table_1 from dbo.Sales

select * from new_table_1

--CASE 2 : New table structure/table already exists

select top 0 * into new_table_2 from dbo.Sales  --****************************

select * from new_table_2

insert into new_table_2 select * from dbo.Sales 

------Copying Certain Columns

select * into new_table_3 from dbo.Sales where 1=0  ---****************************

select * from new_table_3

insert into new_table_3 (ProductID,SaleDate) select productid,saledate from dbo.Sales

-----------------------------------------------------------------------------------------------

-- 30. SUB QUERIES:

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(100)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Insert data into Customers table
INSERT INTO Customers (customer_id, customer_name, email)
VALUES 
(1, 'Alice Smith', 'alice@example.com'),
(2, 'Bob Johnson', 'bob@example.com'),
(3, 'Charlie Brown', 'charlie@example.com');

-- Insert data into Orders table
INSERT INTO Orders (order_id, customer_id, order_date, amount)
VALUES 
(101, 1, '2024-07-15', 250.00),
(102, 1, '2024-08-05', 300.00),
(103, 2, '2024-08-10', 150.00),
(104, 3, '2024-06-25', 100.00);

select * from Customers
select * from Orders

select * from Customers
where customer_id in (
select distinct customer_id from Orders where order_date between '2024-08-01' and '2024-08-31'
)

select * from Customers
where customer_id in (
select distinct customer_id from Orders where order_date not between '2024-08-01' and '2024-08-31'
)

select * from Employees

--Fetch the data from employees table where salary > average salary

select * from Employees where Salary > (
select avg(salary) from Employees
)

select avg(salary) from Employees

-----------------------------------------------------------------------------------------------

-- 31. NOT NULL CONSTRAINT: 

create database constraints
use constraints

--Constraints 
--Conditions that can be applied on columns of a table & these conditions are to be followed while
--inserting records into the table

--Not Null constraint

--Case 1 : We will have to create a new table
create table test_not_null ( 
EID int not null,
age tinyint,
firstname varchar(256)
)

select * from test_not_null

select * from INFORMATION_SCHEMA.columns 
where TABLE_NAME like 'test_not_null'

insert into test_not_null values (1,23,'Mayank')
insert into test_not_null values (null,23,'Mayank')
insert into test_not_null values(2,null,'Raj')

--Case 2 : the table already exists
--We want to make firstname column nullable

alter table test_not_null
alter column firstname varchar(256) not null

insert into test_not_null values (21,34,null)

alter table test_not_null
alter column age tinyint not null

select * from test_not_null

-----------------------------------------------------------------------------------------------

-- 32. UNIQUE CONSTRAINT:

--Unique Constraint
--It ensures that a column consists of unique values

--Case 1 : when the table already exists
alter table test_unique
add unique (lastname)

--Case 2 : We need to create the table
create table test_unique (
SID int unique,
age tinyint not null,
firstname varchar(256) not null unique,
lastname varchar(256)
)

select * from test_unique

insert into test_unique values (1,22,'Mayank','Mehera')

insert into test_unique values (1,24,'Rohit','Singh')  --*****************

insert into test_unique values (null,34,'Akhilesh','Jain')

insert into test_unique values (null,54,'Nitin','Singh') --******************

truncate table test_unique

-----------------------------------------------------------------------------------------------

-- 33. CHECK CONSTRAINT:

--Check Constraint
--It checks for certain condition that can be applied on the columns of a table, if this condition is not
--fulfilled, we will not be able to insert the records into the table

--Case 1 : Table doesn't exist
create table test_check (
EID int,
firstname varchar(256),
age tinyint check(age>=10)
)

select * from test_check

insert into test_check values (1,'Mayank','20')

insert into test_check values (2,'Raj',9)

update test_check set EID = 11 where EID = 1

--Case 2 : Table exists
alter table test_check
add check (eid>5)

insert into test_check values(3,'Nitin',34)

insert into test_check values(30,'Nitin',34)

-----------------------------------------------------------------------------------------------

-- 34. DEFAULT CONSTRAINT:

--Default Constraint
--This constraint to provide default values to columns

--Case 1 : The table does not exist
create table test_default (
EID int default 5,
firstname varchar(256) default 'Rohit',
lastname varchar(256),
age tinyint
)

select * from test_default

insert into test_default values(1,'Nitin','Jain',23)

insert into test_default(lastname,age) values('Singh',34)

insert into test_default (lastname) values ('Grover')

--Case 2 : The table already exists

alter table test_default
add default 25 for age

insert into test_default (lastname) values('Jain')

select * from test_default

-----------------------------------------------------------------------------------------------

-- 35. PRIMARY KEY CONSTRAINT:

--Primary Key Constraint

--Case 1 : When new is to be created
create table test_pk_1 (
eid int primary key,
gender char(1),
age tinyint,
firstname varchar(256)
)

insert into test_pk_1 values(1,'M',23,'Mayank')

select * from test_pk_1

insert into test_pk_1 values (1,'F',19,'Priya')

insert into test_pk_1 values (null,'M',25,'Raj')

truncate table test_pk_1

--Case 2 : Table Already exists
alter table test_pk_1
add primary key (age)

drop table test_pk_2

create table test_pk_2 (
SID int not null unique,
firstname nvarchar(256),
age tinyint not null
)

alter table test_pk_2
add primary key (sid,age)

alter table test_pk_2
add primary key (sid)

-----------------------------------------------------------------------------------------------

-- 36. FOREIGN KEY CONSTRAINT:

--Foreign Key Constraint

--Case 1 : When the new table has to be created
create table test_Primary_key (
ID int primary key,
name varchar(256)
)

insert into test_primary_key values (1,'Mayank'),(2,'Raj'),(3,'Jayant')

select * from test_Primary_key

create table test_foreign_key (
ID int foreign key references test_primary_key(id),
course varchar(256)
)

insert into test_foreign_key values (1,'A')

select * from test_foreign_key

insert into test_foreign_key values (null,'B')

INSERT INTO test_foreign_key VALUES (5,'C')

--Case 2 : Table already exists
create table test_foreign_key_2 (ID int, course varchar(256))

alter table test_foreign_key_2
add foreign key (id) references test_primary_key(id)

-----------------------------------------------------------------------------------------------

-- 37. SQL ORDER OF EXECUTION:

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

--Order Of Execution

select * from EmployeeSalaries

--Correct Query
select distinct top 1 Department,AVG(Salary) [Avg Salary] 
from EmployeeSalaries
where Salary>50000
group by Department
having AVG(Salary)>55000
order by Department 

--From & Joins
--where
--group by
--having
--select
--distinct
--order by
--top

--Incorrect Query
select distinct top 1 Department,AVG(Salary) [Avg Salary] 
from EmployeeSalaries
where Salary>50000
group by Department
having [Avg Salary]>55000
order by Department 

-----------------------------------------------------------------------------------------------