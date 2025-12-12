drop table if exists Employee;
CREATE TABLE Employee
(
 EmployeeID INT , 
 FirstName  varchar(50) ,
 LastName varchar(50) ,
 Phone varchar(20) ,
 Email varchar(50)
);

INSERT INTO Employee VALUES 
(1, 'Adam', 'Owens', '444345999' , 'adam@demo.com'),
(2, 'Mark', 'Wilis', '245666921' , 'mark@demo.com'),
(3, 'Natasha', 'Lee', '321888909' , 'natasha@demo.com'),
(4, 'Adam', 'Owens', '444345999' , 'adam@demo.com'),
(5, 'Riley', 'Jones', '123345959' , 'riley@demo.com'),
(6, 'Natasha', 'Lee', '321888909' , 'natasha@demo.com');

-- Task: Delete duplicates
-- Identifying the duplicates
select FirstName, LastName, count(*)
from Employee
group by FirstName, LastName
having count(*) > 1

-- Deleting duplicates using sub query
delete from Employee
where EmployeeID not in(
select max(EmployeeID)
from Employee
group by FirstName, LastName
)

-- Deleting duplicates using CTE
with duplicate as (
select EmployeeID,
row_number() OVER (partition by FirstName, LastName order by EmployeeID) as rnk
from Employee
)
delete from Employee
using duplicate
where Employee.EmployeeID = duplicate.EmployeeID
and duplicate.rnk > 1;


drop table if exists employee;
create table employee (
    employee_id integer primary key,
    first_name  varchar(50),
    last_name   varchar(50),
    phone       varchar(20),
    email       varchar(100),
    salary      integer
);

insert into employee (employee_id, first_name, last_name, phone, email, salary) values
(3, 'Natasha', 'Lee', '321888909', 'natasha@demo.com', 30000),
(2, 'Mark', 'Wilis', '245666921', 'mark@demo.com', 85000),
(1, 'Melissa', 'Rhodes', '1893456702', 'melissa@demo.com', 40000),
(5, 'Adam', 'Owens', '444345999', 'adam@demo.com', 60000),
(4, 'Riley', 'Jones', '123345959', 'riley@demo.com', 75000),
(6, 'Nick', 'Adams', '1363456702', 'nick@demo.com', 45000);


--Task: Find nth largest salary
-- Max salary
select * from employee
where salary = (select max(salary) from employee)

-- 4th largest salary
select * from employee
order by salary desc
limit 1
offset 3


-- create table
drop table if exists employee;
create table employee (
    employee_id  integer primary key,
    first_name   varchar(50) not null,
    last_name    varchar(50) not null,
    manager_id   integer
);

-- insert sample data
insert into employee (employee_id, first_name, last_name, manager_id) values
(1, 'Adam',    'Owens',   3),
(2, 'Mark',    'Hopkins', null),
(3, 'Natasha', 'Lee',     2),
(4, 'Riley',   'Cooper',  5),
(5, 'Jennifer','Hudson',  2),
(6, 'David',   'Wamer',   5);


-- Find managers of employees
select 
    emp.first_name || ' ' || emp.last_name as employee_name,
    mgr.first_name || ' ' || mgr.last_name as manager_name
from employee emp
join employee mgr 
    on emp.manager_id = mgr.employee_id;
