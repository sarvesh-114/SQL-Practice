
use GrexaAI;
drop table if exists Employees
CREATE TABLE Employees (
EmpID int NOT NULL,
EmpName Varchar(50),
Gender varchar(30),
Salary int,
City varchar(20) );

INSERT INTO Employees
VALUES (1, 'Arjun', 'M', 75000, 'Pune'),
(2, 'Ekadanta', 'M', 125000, 'Bangalore'),
(3, 'Lalita', 'F', 150000 , 'Mathura'),
(4, 'Madhav', 'M', 250000 , 'Delhi'),
(5, 'Visakha', 'F', 120000 , 'Mathura')

CREATE TABLE EmployeeDetail (
EmpID int NOT NULL,
Project Varchar(50),
EmpPosition varchar(20),
DOJ date );

INSERT INTO EmployeeDetail
VALUES 
(1, 'P1', 'Executive', CONVERT(DATE, '26-01-2019', 105)),
(2, 'P2', 'Executive', CONVERT(DATE, '04-05-2020', 105)),
(3, 'P1', 'Lead',      CONVERT(DATE, '21-10-2021', 105)),
(4, 'P3', 'Manager',   CONVERT(DATE, '29-11-2019', 105)),
(5, 'P2', 'Manager',   CONVERT(DATE, '01-08-2020', 105));

select * from EmployeeDetail;
select * from Employees;

--Find the list of employees whose salary ranges between 2L to 3L.
select EmpID, EmpName, Gender, Salary
from Employees
where Salary between 200000 and 300000;

-- Write a query to retrieve the list of employees from the same city.
select e1.EmpID, e1.EmpName, e1.City
from Employees e1 join employees e2
on e1.EmpID <> e2.EmpID and e1.City = e2.City;

-- Query to find the null values in the Employee table.
select * from Employees
where EmpID is null

-- Query to find the cumulative sum of employee’s salary.
select sum(Salary) over(order by EmpID) as cummSalary from Employees;

-- Query to find the cumulative sum of employee’s salary.
select 
count (case when Gender = 'M' then 1 end ) *100.00 / count(*) as MaleRatio,
count (case when Gender = 'F' then 1 end ) *100.00 / count(*) as FemaleRatio
from Employees;

-- Write a query to fetch 50% records from the Employee table.
select * from employee where EmpID <=(
	select empID/2 from Employees
)

-- Query to fetch the employee’s salary but replace the LAST 2 digits with ‘XX’ i.e 12345 will be 123XX
select EmpID, Salary,
left(cast(Salary as varchar), len(cast(Salary as varchar))-2) + 'xx' as MaskSalary
from Employees

-- Write a query to fetch even and odd rows from Employee table.
select * from Employees
where EmpID %2 = 1

select * from Employees
where EmpID %2 = 0

/* Write a query to find all the Employee names whose name:
• Begin with ‘A’
• Contains ‘A’ alphabet at second place
• Contains ‘Y’ alphabet at second last place
• Ends with ‘L’ and contains 4 alphabets
• Begins with ‘V’ and ends with ‘A’ */

select * from Employees
where EmpName like 'A%';

select * from Employees
where EmpName like '_A%';

select * from Employees
where EmpName like '%Y_';

select * from Employees
where EmpName like '___L';

select * from Employees
where EmpName like 'V%A';

/*Write a query to find the list of Employee names which is:
• starting with vowels (a, e, i, o, or u), without duplicates
• ending with vowels (a, e, i, o, or u), without duplicates
• starting & ending with vowels (a, e, i, o, or u), without duplicates*/

select * from Employees
where lower(EmpName) like 'a%' 
or lower(EmpName) like 'e%' 
or lower(EmpName) like 'i%' 
or lower(EmpName) like 'o%' 
or lower(EmpName) like 'u%';

select * from Employees
where lower(EmpName) like '%a' 
or lower(EmpName) like '%e' 
or lower(EmpName) like '%i' 
or lower(EmpName) like '%o' 
or lower(EmpName) like '%u';

select * from Employees
where (lower(EmpName) like '%a' 
or lower(EmpName) like '%e' 
or lower(EmpName) like '%i' 
or lower(EmpName) like '%o' 
or lower(EmpName) like '%u') and 
(lower(EmpName) like 'a%' 
or lower(EmpName) like 'e%' 
or lower(EmpName) like 'i%' 
or lower(EmpName) like 'o%' 
or lower(EmpName) like 'u%');

-- Write a query to find and remove duplicate records from a table.
select EmpID, EmpName, Gender, Salary, City, count(*) as DupCount
from Employees
group by EmpID, EmpName, Gender, Salary, City
having count(*) > 1

-- Query to retrieve the list of employees working in same project.
WITH CTE AS

(SELECT e.EmpID, e.EmpName, ed.Project
FROM Employees AS e
INNER JOIN EmployeeDetail AS ed
ON e.EmpID = ed.EmpID)

SELECT c1.EmpName, c2.EmpName, c1.project
FROM CTE c1, CTE c2
WHERE c1.Project = c2.Project AND c1.EmpID != c2.EmpID AND c1.EmpID < c2.EmpID;

-- Show the employee with the highest salary for each project
select ed.Project, max(e.Salary) as MaxSalary
from Employees as e join EmployeeDetail as ed
on e.EmpID = ed.EmpID
group by ed.Project
order by MaxSalary;

-- Query to find the total count of employees joined each year
select YEAR(DOJ) as Year, count(*) as Count
from EmployeeDetail
group by Year(DOJ);


select * from EmployeeDetail;
select * from Employees;