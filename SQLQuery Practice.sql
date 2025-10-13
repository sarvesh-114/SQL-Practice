-- Write a SQL query to fetch all the duplicate records from a table.
use GrexaAI;

create table users
(
user_id int primary key,
user_name varchar(30) not null,
email varchar(50));

insert into users values
(1, 'Sumit', 'sumit@gmail.com'),
(2, 'Reshma', 'reshma@gmail.com'),
(3, 'Farhana', 'farhana@gmail.com'),
(4, 'Robin', 'robin@gmail.com'),
(5, 'Robin', 'robin@gmail.com');


select user_id, user_name, email from (
select *,
row_number() over(partition by user_name order by user_id) as rn
from users
) as x
where x.rn > 1


--2. Write a SQL query to fetch the second last record from employee table.
drop table employee;
create table Employees
( emp_ID int primary key
, emp_NAME varchar(50) not null
, DEPT_NAME varchar(50)
, SALARY int);

insert into Employees values(101, 'Mohan', 'Admin', 4000);
insert into Employees values(102, 'Rajkumar', 'HR', 3000);
insert into Employees values(103, 'Akbar', 'IT', 4000);
insert into Employees values(104, 'Dorvin', 'Finance', 6500);
insert into Employees values(105, 'Rohit', 'HR', 3000);
insert into Employees values(106, 'Rajesh',  'Finance', 5000);
insert into Employees values(107, 'Preet', 'HR', 7000);
insert into Employees values(108, 'Maryam', 'Admin', 4000);
insert into Employees values(109, 'Sanjay', 'IT', 6500);
insert into Employees values(110, 'Vasudha', 'IT', 7000);
insert into Employees values(111, 'Melinda', 'IT', 8000);
insert into Employees values(112, 'Komal', 'IT', 10000);
insert into Employees values(113, 'Gautham', 'Admin', 2000);
insert into Employees values(114, 'Manisha', 'HR', 3000);
insert into Employees values(115, 'Chandni', 'IT', 4500);
insert into Employees values(116, 'Satya', 'Finance', 6500);
insert into Employees values(117, 'Adarsh', 'HR', 3500);
insert into Employees values(118, 'Tejaswi', 'Finance', 5500);
insert into Employees values(119, 'Cory', 'HR', 8000);
insert into Employees values(120, 'Monica', 'Admin', 5000);
insert into Employees values(121, 'Rosalin', 'IT', 6000);
insert into Employees values(122, 'Ibrahim', 'IT', 8000);
insert into Employees values(123, 'Vikram', 'IT', 8000);
insert into Employees values(124, 'Dheeraj', 'IT', 11000);

select emp_id, emp_NAME, DEPT_NAME, SALARY from (select *,
row_number() over (order by emp_id desc) as rn
from Employees ) as x
where x.rn = 2

--3. Write a SQL query to display only the details of employees who either earn the highest salary or
-- the lowest salary in each department from the employee table.

select emp_ID, emp_NAME, DEPT_NAME, SALARY
from (
    select *,
           rank() over (partition by DEPT_NAME order by salary asc) as min_rank,
           rank() over (partition by DEPT_NAME order by salary asc) as max_rank
    from Employees
) as ranked
where min_rank = 1 OR max_rank = 1;

--4. From the doctors table, fetch the details of doctors 
--who work in the same hospital but in different specialty.

create table doctors
(
id int primary key,
name varchar(50) not null,
speciality varchar(100),
hospital varchar(50),
city varchar(50),
consultation_fee int
);

insert into doctors values
(1, 'Dr. Shashank', 'Ayurveda', 'Apollo Hospital', 'Bangalore', 2500),
(2, 'Dr. Abdul', 'Homeopathy', 'Fortis Hospital', 'Bangalore', 2000),
(3, 'Dr. Shwetha', 'Homeopathy', 'KMC Hospital', 'Manipal', 1000),
(4, 'Dr. Murphy', 'Dermatology', 'KMC Hospital', 'Manipal', 1500),
(5, 'Dr. Farhana', 'Physician', 'Gleneagles Hospital', 'Bangalore', 1700),
(6, 'Dr. Maryam', 'Physician', 'Gleneagles Hospital', 'Bangalore', 1500);

select d1.* from doctors d1
join doctors d2 on d1.id <> d2.id and d1.hospital = d2.hospital 
and d1.speciality <> d2.speciality

-- From the login_details table, fetch the users who logged in consecutively 3 or more times.
create table login_details(
login_id int primary key,
user_name varchar(50) not null,
login_date date);

insert into login_details values
(101, 'Michael', cast(getdate() as date)),
(102, 'James', cast(getdate() as date)),
(103, 'Stewart', dateadd(day, 1, cast(getdate() as date))),
(104, 'Stewart', dateadd(day, 1, cast(getdate() as date))),
(105, 'Stewart', dateadd(day, 1, cast(getdate() as date))),
(106, 'Michael', dateadd(day, 2, cast(getdate() as date))),
(107, 'Michael', dateadd(day, 2, cast(getdate() as date))),
(108, 'Stewart', dateadd(day, 3, cast(getdate() as date))),
(109, 'Stewart', dateadd(day, 3, cast(getdate() as date))),
(110, 'James', dateadd(day, 4, cast(getdate() as date))),
(111, 'James', dateadd(day, 4, cast(getdate() as date))),
(112, 'James', dateadd(day, 5, cast(getdate() as date))),
(113, 'James', dateadd(day, 6, cast(getdate() as date)));




select * from login_details;

select distinct user_name from
(select user_name,
case when user_name = lead(user_name) over(order by login_id) and
user_name = lead(user_name, 2) over(order by login_id) then user_name else null end as repeated_logins
from login_details) as x
where x.repeated_logins is not null;

-- From the students table, write a SQL query to interchange the adjacent student names.
create table students
(
id int primary key,
student_name varchar(50) not null
);

insert into students values
(1, 'James'),
(2, 'Michael'),
(3, 'George'),
(4, 'Stewart'),
(5, 'Robin');
insert into students values
(6, 'Sarvesh');

select id, student_name, 
case when id % 2 = 1 then lead(student_name) over(order by id) 
else lag(student_name) over(order by id) end as swapped_name
from students;

--From the weather table, fetch all the records when London had extremely cold temperature 
--for 3 consecutive days or more.
--Note: Weather is considered to be extremely cold then its temperature is less than zero.

create table weather
(
id int,
city varchar(50),
temperature int,
day date
);

insert into weather values
(1, 'London', -1, cast('2021-01-01' as date)),
(2, 'London', -2, cast('2021-01-02' as date)),
(3, 'London', 4, cast('2021-01-03' as date)),
(4, 'London', 1, cast('2021-01-04' as date)),
(5, 'London', -2, cast('2021-01-05' as date)),
(6, 'London', -5, cast('2021-01-06' as date)),
(7, 'London', -7, cast('2021-01-07' as date)),
(8, 'London', 5, cast('2021-01-08' as date));
select * from weather;

select id, city, temperature, day
from (
    select *,
        case when temperature < 0
              and lead(temperature) over(order by day) < 0
              and lead(temperature,2) over(order by day) < 0
        then 'Y'
        when temperature < 0
              and lead(temperature) over(order by day) < 0
              and lag(temperature) over(order by day) < 0
        then 'Y'
        when temperature < 0
              and lag(temperature) over(order by day) < 0
              and lag(temperature,2) over(order by day) < 0
        then 'Y'
        end as flag
    from weather) x
where x.flag = 'Y';

create table event_category
(
  event_name varchar(50),
  category varchar(100)
);

create table physician_speciality
(
  physician_id int,
  speciality varchar(50)
);

create table patient_treatment
(
  patient_id int,
  event_name varchar(50),
  physician_id int
);

insert into event_category values ('Chemotherapy','Procedure');
insert into event_category values ('Radiation','Procedure');
insert into event_category values ('Immunosuppressants','Prescription');
insert into event_category values ('BTKI','Prescription');
insert into event_category values ('Biopsy','Test');

insert into physician_speciality values (1000,'Radiologist');
insert into physician_speciality values (2000,'Oncologist');
insert into physician_speciality values (3000,'Hermatologist');
insert into physician_speciality values (4000,'Oncologist');
insert into physician_speciality values (5000,'Pathologist');
insert into physician_speciality values (6000,'Oncologist');

insert into patient_treatment values (1,'Radiation', 1000);
insert into patient_treatment values (2,'Chemotherapy', 2000);
insert into patient_treatment values (1,'Biopsy', 1000);
insert into patient_treatment values (3,'Immunosuppressants', 2000);
insert into patient_treatment values (4,'BTKI', 3000);
insert into patient_treatment values (5,'Radiation', 4000);
insert into patient_treatment values (4,'Chemotherapy', 2000);
insert into patient_treatment values (1,'Biopsy', 5000);
insert into patient_treatment values (6,'Chemotherapy', 6000);

select * from event_category;
select * from physician_speciality;
select * from patient_treatment;


