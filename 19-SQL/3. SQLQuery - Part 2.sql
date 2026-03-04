

use [Sales Database]

--Creating Table1 & insertinting records in Table1
create table table1 (C1 int, C2 nvarchar(max))
insert into table1 values (1,'A'),
(1,'B'),
(2,'C'),
(NULL,'D'),
(3,'E'),
(7,'DA')

--Creating Table2 & insertinting records in Table2
create table table2 (C1 int, C3 nvarchar(max))
insert into table2 values (1,'XA'),
(2,'MB'),
(2,'NX'),
(NULL,'MO'),
(4,'XY'),
(5,'TF')

-----------------------------------------------------------------------------------------------

-- 16. INNER JOIN:  

select * from table1
select * from table2

select * from table1 
inner join table2 on table1.C1 = table2.C1

select table1.C1,table1.C2,table2.C3 from table1 
inner join table2 on table1.C1 = table2.C1

select a.C1,a.C2,b.C3 from table1 a 
inner join table2 b on
a.C1 = b.C1

select a.C1,a.C2,b.C3 from table1 a 
join table2 b on
a.C1 = b.C1

-----------------------------------------------------------------------------------------------

-- 17. LEFT JOIN:  

select * from table1
select * from table2

select * from table1 left join table2
on table1.C1 = table2.C1

select * from table1 left outer join table2
on table1.C1 = table2.C1

select * from table1 a left join table2 b 
on a.C1 = b.C1

select a.C1,a.C2,b.C3 from table1 a left join table2 b 
on a.C1 = b.C1

-----------------------------------------------------------------------------------------------

-- 18. RIGHT JOIN:  

select * from table1
select * from table2

select * from table1 right join 
table2 on table1.C1 = table2.C1

select * from table1 right outer join table2
on table1.C1 = table2.C1

select a.C1,a.C2,b.C3
from table1 a right outer join table2 b
on a.C1 = b.C1

-----------------------------------------------------------------------------------------------

-- 19. LEFT & RIGHT ANTI JOIN:  

select * from table1
select * from table2

--Left Anti Join
select * from table1 left join table2 
on table1.C1 = table2.C1 
where table2.C1 is null

--Right Anti Join
select * from table1 right join table2 
on table1.C1 = table2.C1
where table1.C2 is null

-----------------------------------------------------------------------------------------------

-- 20. FULL OUTER JOIN:  

select * from table1
select * from table2

select * from table1 full outer join table2 
on table1.c1 = table2.c1

select a.c1, a.c2, b.c3 from table1 
as a full outer join table2 as b 
on a.c1 = b.c1

-----------------------------------------------------------------------------------------------

-- 21. SELF JOIN:  

select * from table1

select * from table1 a inner join table1 b
on a.C1 = b.C1

select a.C1,b.C2 from table1 a inner join table1 b
on a.C1 = b.C1

select a.C1,b.C2 from table1 a join table1 b
on a.C1 = b.C1

-----------------------------------------------------------------------------------------------

-- 22. UNION & UNION ALL:  

create table append1 (C1 int,C2 nvarchar(255),C3 int)
insert into append1 values (1,'A',7),
(2,'B',8),
(3,'C',9)

create table append2 (C1 int,C2 nvarchar(255),C3 int)
insert into append1 values (11,'AA',17),
(2,'B',8),
(33,'C1',91)


select * from append1
select * from append2

select c1,c2,c3 from append1
union all
select c1,c2,c3 from append2

select c1,c2,c3 from append1
union 
select c1,c2,c3 from append2

-- Numbers of columns present in the select list have to be same
-- Data Types of the columns have to be same
-- Order in which columns are written has to be the same

select c1,c2,c3 from append1 --C1 is int, C2 is nvarchar, C3 is int
union 
select c1,c3,C2 from append2

-- Aliase names which are specified in 1st select statement will be assigned to the columns

select c1 [Column1],c2 [Column2],c3 [Column3] from append1
union
select c1 [Col1],c2 [Col2],c3 [Col3] from append2


-----------------------------------------------------------------------------------------------

-- 23. LIKE OPERATOR: used in a WHERE clause to search for a specified pattern in a column � usually with text data (strings).
--                    It�s often used with wildcards to match part of a string.
--                      %: Represents zero, one, or multiple characters
--                      _: Represents a single character
--                      ^: Represents any single character not in brackets
--                     []: Represents any single character within brackets


-- Create Employees_us table
CREATE TABLE Employees_US (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50)
);

-- Insert sample data into Employees table
INSERT INTO Employees_us (EmployeeID, FirstName, LastName, Department) VALUES
(1, 'Alice', 'Smith', 'Finance'),
(2, 'Bob', 'Johnson', 'Engineering'),
(3, 'Charlie', 'Williams', 'Marketing'),
(4, 'Diana', 'Brown', 'Finance'),
(5, 'Edward', 'Jones', 'Engineering'),
(6, 'Fiona', 'Garcia', 'Marketing'),
(7, 'George', 'Miller', 'Finance'),
(8, 'Hannah', 'Wilson', 'Engineering');

select * from Employees_US

--1) Find Employees whose Last Name starts with 'S'.
select * from employees_us where lastname like 's%'

--2) Find Employees whose First Name ends with 'a'.
select * from employees_us where firstname like '%a'

--3) Find Employees whose Department contains 'Eng'.
select * from employees_us where department like '%eng%'

--4) Find Employees whose Last Name is exactly 5 characters long.
select * from employees_us where lastname like '_____'

--5) Find Employees whose First Name starts with 'C' or 'D'.
select * from employees_us where firstname like '[CD]%' 

--6) Find Employees whose Last Name contains 'son'.
select * from employees_us where lastname like '%son%'

--7) Find Employees whose First Name contains the letter 'i' as the second character.
select * from employees_us where firstname like '_i%'

--8) Find Employees whose Last Name starts with any letter between 'A' and 'L'.
select * from employees_us where lastname like '[a-l]%'

--9) Find Employees whose First Name does not contain 'o'.
select * from employees_us where firstname not like '%o%'

--10) Find Employees whose Last Name ends with 'a' and is exactly 5 characters long.
select * from employees_us where lastname like '____a'

select * from employees_us

--11) Find Employees whose Department starts with 'Mar' and ends with 'ing'.
select * from employees_us where department like 'mar%ing'

--12) Find Employees whose First Name has an 'a' in the third position.
select * from employees_us where firstname like '__a%'

--13) Find Employees whose Last Name starts with 'Br' or 'Bl'.
select * from employees_us where lastname like 'br%' or lastname like 'bl%'

--14) Find Employees whose First Name starts with a vowel.
select * from employees_us where firstname like '[aeiou]%'

--15) Find Employees whose First Name does not start with a consonant.
select * from employees_us where firstname not like '[^aeiou]%'

--16) Find Employees whose First Name starts with a consonant.
select * from employees_us where firstname like '[^aeiou]%'


-----------------------------------------------------------------------------------------------
