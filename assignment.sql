create database GrexaAI;
use GrexaAI;

create table Department(
	depId int primary key,
	depName varchar(50) not null unique,
	)

create table Employee(
	empId int primary key,
	empName varchar(50) not null,
	depId int not null,
	joiningDate date not null,
	foreign key (depId) references Department(depId)
	)


create table Salary(
	empId int primary key,
	salary int not null check (salary > 0)
	foreign key (empId) references Employee(empId)
	)

-- Question 1) Write SQL query to find the department name that has the highest salary among employees.

select d.depName from Department d
join Employee e on d.depId = e.depId
join Salary s on e.empid = s.empid
where s.salary = (select max(salary) from Salary);

-- Question 2) write a sql query to calculate total salary earn by each employee in year 2024 based on their joining data, 
-- display the result in alphabetical order of employee name(Considering all employees join in 2024 based on sample data mention in assignment file)

select E.empName, (12 - month(E.joiningDate)) * S.salary as totalSalary2024 from Employee E
join Salary S on E.empId = S.empId
order by E.empName asc;

-- Question 3) using monthly salary data, write a query to display each employees salary along with 
-- row_number(), rank(), dense_rank() based on salary in descending order

select E.empName,S.salary,
row_number() over (order by  S.salary desc) as row_num,
rank() over (order by S.salary desc) as rank_num,
dense_rank() over (order by S.salary desc) as dense_rank_num
from Employee E
join Salary S ON E.empId = S.empId;
