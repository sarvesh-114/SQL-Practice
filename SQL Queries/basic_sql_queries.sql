-- create computer table
drop table if exists computer;
create table computer (
    compid integer primary key,
    brand varchar(50),
    compmodel varchar(50),
    manufacturedate date
);

-- create employee table
drop table if exists employee;
create table employee (
    empid integer primary key,
    firstname varchar(50),
    lastname varchar(50),
    salary numeric(10,2),
    emailid varchar(50),
    managerid integer,
    dateofjoining date,
    dept varchar(10),
    compid integer,
    constraint fk_compid foreign key (compid) references computer(compid)
);

-- insert data into computer table
insert into computer values 
(1001, 'lenovo', 't480', to_date('12-jun-2019', 'dd-mon-yyyy')),
(1002, 'lenovo', 't490', to_date('24-aug-2020', 'dd-mon-yyyy')),
(1003, 'sony', 'sq112', to_date('01-dec-2019', 'dd-mon-yyyy')),
(1004, 'sony', 'sx1001', to_date('21-dec-2020', 'dd-mon-yyyy'));

-- insert data into employee table
insert into employee values
(1, 'nanda', 'kumar', 50000, 'nanda@gmail.com', null, to_date('15-jun-2012','dd-mon-yyyy'), 'it', 1001),
(2, 'biplab', 'parida', 30000, 'bparida@yahoo.com', 1, to_date('21-dec-2015','dd-mon-yyyy'), 'it', 1001),
(3, 'disha', 'patel', 50000, 'dishap@gmail.com', null, to_date('21-aug-2013','dd-mon-yyyy'), 'hr', null),
(4, 'siba', 'prasad', 90000, 'siba@gmail.com', 3, to_date('01-jun-2020','dd-mon-yyyy'), 'hr', 1002),
(5, 'anushka', 'sharma', 20000, 'sharmaa@gmail.com', 1, to_date('01-mar-2021','dd-mon-yyyy'), 'it', null),
(6, 'somnath', 'maharana', 65000, 'smaha@gmail.com', 3, to_date('07-may-2019','dd-mon-yyyy'), 'it', 1003);

-- create duplicate table
drop table if exists duplicate;
create table duplicate (
    empid integer primary key,
    firstname varchar(50),
    lastname varchar(50),
    salary numeric(10,2),
    emailid varchar(50),
    managerid integer,
    dateofjoining date
);

-- insert data into duplicate table
insert into duplicate values
(1, 'nanda', 'kumar', 50000, 'nanda@gmail.com', null, to_date('15-jun-2012','dd-mon-yyyy')),
(2, 'biplab', 'parida', 30000, 'bparida@yahoo.com', 1, to_date('21-dec-2015','dd-mon-yyyy')),
(3, 'siba', 'prasad', 90000, 'siba@gmail.com', 3, to_date('01-jun-2020','dd-mon-yyyy')),
(4, 'anushka', 'sharma', 20000, 'sharmaa@gmail.com', 1, to_date('01-mar-2021','dd-mon-yyyy')),
(5, 'biplab', 'parida', 30000, 'bparida@yahoo.com', 1, to_date('21-dec-2015','dd-mon-yyyy'));

-- 1. SQL Query to update DateOfJoining to 15-jul-2012 for empid =1
update employee
set dateofjoining = '2012-07-15'
where empid = 1

-- 2. SQL Query to select all student name where age is greater than 22
select * from STUDENT where AGE > 22;

-- 3. SQL Query to Find all employee with Salary between 40000 and 80000?
select * from employee
where salary between 40000 and 80000;

-- 4. SQL Query to display full name?
select firstname || ' ' || lastname as fullname
from employee

-- 5. SQL Query to find name of employee beginning with S?
select * from employee
where firstname like 's%';

-- 6. Write a query to fetch details of employees whose firstname ends with an alphabet ‘A’ and contains exactly five alphabets ?
select * from employee
where firstname like '____a';

-- 7. Write an SQL query to fetch the employee FIRST names and replace the A with ‘@’:
select replace(firstname, 'a', '@') as new_name from employee

-- 8. Write an SQL query to update the employee names by removing leading and trailing spaces :
update employee
set firstname = trim(firstname)

-- 9. Write an SQL query to fetch all the Employees details from Employee table who joined in the Year 2020:
select * from employee
where extract(year from dateofjoining) = 2020

-- 10. Write an SQL query to fetch only odd rows / Even rows from the table :
select * from employee
where mod(empid, 2) = 0

select * from employee
where mod(empid, 2) = 1

--11. Write an SQL query to create a new table with data and structure copied from another table:
create table dummy_employee as (select * from employee)
select * from dummy_employee

-- 12. Write an SQL query to fetch top 3 HIGHEST salaries :
select * from employee
order by salary desc
limit 3

-- 13. Write a query to fetch the department-wise count of employees sorted by department’s count in ascending order:
select dept, count(*) as no_of_emp
from employee
group by dept
order by no_of_emp asc

-- 14.Write a query to retrieve Department wise Maximum salary:
select dept, salary, rnk from
(select *,
rank() over(partition by dept order by salary desc) as rnk
from employee) as r
where r.rnk = 1

select * from employee;
select * from duplicate;
select * from computer;



