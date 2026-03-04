
--------------------------------------- ADVANCED SQL --------------------------------------------------------

-- 45. Common Table Expression - 1:
/*
A Common Table Expression (CTE) in SQL is a temporary result set that you can reference within a 
SELECT, INSERT, UPDATE, or DELETE statement. CTEs are defined using the WITH keyword, 
and they can make complex queries easier to write, understand, and maintain by breaking them into simpler parts.
*/

select * from Employees

select * into #temp1 from Employees

select * from #temp1

---Example 1 : CTE

With CTE AS (
select * from #temp1
)

select * from cte

--Example 2 :

with Test_CTE as (
select employeeid,firstname from #temp1 where EmployeeID in (2,4)
)

select * from test_cte 

--Example 3

with [Comm Table Expression] as (
select * from #temp1 where EmployeeID in (1,2,3)
)

select * into #temp2 from [Comm Table Expression]

select * from #temp2

--Example 4 :

with CTE_1 as (
select * from #temp1 where EmployeeID in (2,4,6)
)

update #temp1 set employeeid = 101 where employeeid in (select distinct employeeid from cte_1)

--
select * from #temp1


--Example 5 :

with cte_2 as (
select * from #temp1 where EmployeeID = 1
)

delete from #temp1 where EmployeeID in (select distinct employeeid from cte_2)

select * from #temp1

--Example 6 :

with cte_3 as (
select * from #temp1 where EmployeeID in (101)
)

insert into #temp1 select * from cte_3

-----------------------------------------------------------------------------------------------

-- 46. Common Table Expression - 2:

select * from Employees

select * into #1 from dbo.Employees

---Example 1
With CTE1 as (
select * from #1 where EmployeeID in (1,2)
),CTE2 as (
select * from #1 where EmployeeID in (3,4)
)

select * from cte1
union all
select * from cte2

--Example 2
with cte3 as (
select employeeid,firstname from #1 where EmployeeID = 1
),cte4 as (
select employeeid,firstname from #1 where EmployeeID in (3)
)

select * into #2 from (
select * from cte3
union all
select * from cte4
) x


--Example 3 
with cte3 as (
select employeeid,firstname from #1 where EmployeeID = 1
),cte4 as (
select employeeid,firstname from #1 where EmployeeID in (3)
)

insert into #2 select * from (
select * from cte3
union all
select * from cte4
) x

select * from #2

--Example 4
with cte3 as (
select employeeid,firstname,Salary from #1 where EmployeeID = 2
),cte4 as (
select employeeid,firstname,Salary from #1 where EmployeeID in (4)
)

delete from #1 where EmployeeID in (select distinct employeeid from cte3
union all
select distinct EmployeeID from cte4
)

select * from #1

--Example 5 :
with cte3 as (
select employeeid,firstname,Salary from #1 where EmployeeID = 9
),cte4 as (
select employeeid,firstname,Salary from #1 where EmployeeID in (10)
)

update #1 set employeeid = 100 where EmployeeID not in (select distinct employeeid from cte3
union all
select distinct EmployeeID from cte4
)

-----------------------------------------------------------------------------------------------

-- 47. Recursive Common Table Expression:

--Recursive CTE
--Factorial of a given number (5)

with [R CTE] as (
--Anchor Query
select 1 as n

union all

--Recursive Query
select n+1 from [R CTE] where n<=4

)

select exp(sum(log(n))) [Factorial] from [R CTE]
-----------

-----------
--3*2*1
--5*4*3*2*1

----------------
with [R CTE] as (
--Anchor Query
select 1 as n

union all

--Recursive Query
select n+1 from [R CTE] where n<=4

)

select * from [r cte]

-----------------------------------------------------------------------------------------------

-- 48. Stored Procedure in MS SQL Server:

create database testDB
use testdb

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Email NVARCHAR(100) UNIQUE,
    DepartmentID INT,
    HireDate DATE,
    Salary DECIMAL(10, 2)
);

INSERT INTO Employees (EmployeeID, FirstName, LastName, Email, DepartmentID, HireDate, Salary)
VALUES 
(1, 'John', 'Smith', 'john.smith@example.com', 101, '2021-06-15', 75000.00),
(2, 'Jane', 'Doe', 'jane.doe@example.com', 102, '2020-03-10', 85000.00),
(3, 'Michael', 'Johnson', 'michael.johnson@example.com', 101, '2019-11-22', 95000.00),
(4, 'Emily', 'Davis', 'emily.davis@example.com', 103, '2022-01-05', 68000.00),
(5, 'William', 'Brown', 'william.brown@example.com', 102, '2018-07-19', 80000.00);

select * from Employees

Create procedure sp_test
as
begin
	select * from Employees
end

sp_test

exec sp_test

execute sp_test
----

--Example 2

Create proc sp_test_1
as
begin
	select firstname,lastname from Employees
end

sp_test_1

-------------------

Alter proc sp_test_1
as
begin
	select employeeid,firstname,lastname from Employees
end


-----------------------------------------------------------------------------------------------

-- 49. Views in MS SQL Server:

select * from Employees

select * into emp_bkp from Employees

select * from emp_bkp

--A View is a virtual table,it is a stored SQL Query
--It helps in reducing the complexity of the code
--It helps in implementing security

create view View_1 as (
select * from emp_bkp
)

select * from View_1
--**
update View_1
set EmployeeID = 100


--**

Create view View_2 as (
select EmployeeID,FirstName,LastName,Email,DepartmentID,HireDate from emp_bkp
)

select * from View_2

----------

drop view View_2

-----------------------------------------------------------------------------------------------

-- 50. Indexes in MS SQL Server:

--Index

select * from dbo.Employees

create index IX_1 on dbo.employees(salary desc)

create index IX_2 on dbo.employees(firstname,lastname)

drop index dbo.employees.IX_1


-----------------------------------------------------------------------------------------------

-- 51. Clustered Index:

drop database Test_Index
create database Test_Index

use test_index

drop table if exists students
create table Students ( id int, name nvarchar(50), age int, gender varchar(20))

insert into Students values
(1,'Raj',23,'M'),
(4,'Nitin',25,'M'),
(3,'Priya',21,'F'),
(2,'Nikita',20,'F'),
(5,'Monica',20,'F')

select * from Students

create clustered index ix_1 on students (id)

create clustered index ix_2 on students (id desc)

drop index ix_1 on students

create clustered index ix_3 on students (gender desc, age asc)

drop index ix_2 on students

create nonclustered index ix_1 on students (gender desc, age asc)
drop index ix_1 on students

drop index ix_3 on students

-----------------------------------------------------------------------------------------------

-- 52. Non Clustered Index:

select * from Students

create nonclustered index ix_2 on students (id)

create nonclustered index ix_1 on students (gender desc, age asc)

drop index ix_2 on students

--More than one non clustered index can exist while that is not the case with clustered index

--Clustered Index determines the physical order in which data is stored in a table while that is
--not the case with non clustered index

--Clustered index is faster than non clustered index because non clustered index needs to refer back to
--table if selected column is not present in it

--Non clustered index requires separate disc space for storage

-----------------------------------------------------------------------------------------------