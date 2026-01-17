CREATE TABLE museums (
    museum_id INTEGER PRIMARY KEY,
    name        VARCHAR(255) NOT NULL,
    address     VARCHAR(255),
    city        VARCHAR(100),
    state       VARCHAR(100),
    postal      VARCHAR(20),
    country     VARCHAR(100),
    phone       VARCHAR(30),
    url         TEXT
);

select * from museums;
drop table if exists image_link;
CREATE TABLE image_link (
    work_id               INTEGER ,
    url                   TEXT ,
    thumbnail_small_url   TEXT,
    thumbnail_large_url   TEXT
);
select * from image_link;


drop table if exists canvas_size;
CREATE TABLE canvas_size (
    size_id INTEGER ,
    width   INTEGER ,
    height  INTEGER,
    label   VARCHAR(50) 
);
select * from canvas_size;


drop table if exists artist;
CREATE TABLE artist (
    artist_id     INTEGER PRIMARY KEY,
    full_name     VARCHAR(255) NOT NULL,
    first_name    VARCHAR(100),
    middle_names  VARCHAR(100),
    last_name     VARCHAR(100),
    nationality   VARCHAR(100),
    style         VARCHAR(100),
    birth         SMALLINT,
    death         SMALLINT
);
select * from artist;


drop table if exists museum_hours;
CREATE TABLE museum_hours (
    museum_id INTEGER NOT NULL,
    day        VARCHAR(10) NOT NULL,
    open_time  VARCHAR(10) NOT NULL,
    close_time VARCHAR(10) NOT NULL
);
select * from museum_hours;


drop table if exists product_size;
CREATE TABLE product_size (
    work_id        INTEGER,
    size_id        varchar(20),
    sale_price     INTEGER,
    regular_price  INTEGER
);
select * from product_size;


drop table if exists subjects;
CREATE TABLE subjects (
    work_id INTEGER NOT NULL,
    subject VARCHAR(100) NOT NULL
);
select * from subjects;


drop table if exists works;
CREATE TABLE works (
    work_id    INTEGER,
    name       VARCHAR(1000) ,
    artist_id  INTEGER ,
    style  text,
    museum_id  INTEGER
);
select * from works;


-- Fetch all the paintings which are not displayed on any museums?
select * from work
where museum_id is null;

-- How many paintings have an asking price of more than their regular price? 
select count(*) from product_size
where sale_price > regular_price;

-- Identify the paintings whose asking price is less than 50% of its regular price
select * from product_size
where sale_price < (regular_price/2);

select * 
from product_size
where sale_price < (regular_price*0.5);

-- Which canva size costs the most?
select * from product_size;
select * from canvas_size;


-- Which canva size costs the most?
select cs.label, ps.sale_Price from
(
	select *, 
	rank() over(order by sale_price desc) as rn
	from product_size
) as ps
join canvas_size as cs on cs.size_id::text= ps.size_id
where ps.rn = 1


-- Delete duplicate records from work
delete from work
where work_id in (
select work_id
from (
select work_id,
row_number() over (partition by work_id order by  work_id) as rn from work
) t
where rn > 1
);

-- Identify the museums with invalid city information in the given dataset
select * from museums 

delete from museums 
where city ~ '^[0-9]';

-- Identify the museums which are open on both Sunday and Monday. Display museum name, city
select * from museums;
select * from museum_hours;

select m.name, m.city, m.country, mh.day
from museums as m
join
museum_hours as mh on m.museum_id = mh.museum_id
where mh.day = 'Sunday'
and exists (select 1 from museum_hours mh2 
where mh2.museum_id=mh.museum_id 
and mh2.day='Monday');

CREATE TABLE emp (
id INT,
name VARCHAR(100),
salary INT
);
INSERT INTO emp (id, name, salary) VALUES
(1, 'Amit', 90000),
(2, 'Rahul', 75000),
(3, 'Sneha', 90000),
(4, 'Vijay', 65000),
(5, 'Priya', 65000),
(6, 'Karan', 80000),
(7, 'Simran', 70000),
(8, 'Rohan', 70000),
(9, 'Meera', 60000);

-- Write a query to find the employees who have the third highest salary. Return - id, name, salary
select * from emp
order by salary desc
offset 2
limit 1

select id, name, salary from
	(select *,
	rank() over(order by salary desc) as rnk
	from emp)
where rnk = 3


CREATE TABLE Consecutive (
number INT
);
INSERT INTO Consecutive (number) VALUES
(1),
(2),
(3),
(5),
(6),
(7),
(10),
(11),
(12),
(13),
(20);

-- Write a query to find the length of the longest consecutive sequence of numbers.
with cte as	
	(select *,
	row_number() over(order by number) as seq,
	(number - row_number() over(order by number)) as diff
	from Consecutive)

select diff, count(*)
from cte
group by diff
order by count(*) desc
limit 1;


create table course (
id int,
skill varchar(100),
description varchar(255)
);
insert into course (id, skill, description) values
(1, 'SQL Basics', 'Introduction to SQL queries'),
(2, 'Data Modeling', 'Fundamentals of data design'),
(3, 'Python', 'Learn Python for data'),
(4, 'SQL Basics', 'Introduction to SQL queries'),
(5, 'Data Modeling', 'Fundamentals of data design'),
(6, 'Power BI', 'Data visualization with Power BI'),
(7, 'Python', 'Learn Python for data');

-- You have a table ‘course’ with potential duplicate rows. Write a query to delete all
-- duplicate entries while keeping one copy.
with cte as
	(select *,
	rank() over(partition by skill order by id) as rnk
	from course)
-- select id from cte where rnk>1

delete from course
where id in(select id from cte where rnk>1)

select * from course;


create table payments (
order_id int,
customer_id int,
payment_type varchar(20),
amount decimal(10,2)
);
insert into payments (order_id, customer_id, payment_type, amount)
values
(101, 1, 'Cash', 450.00),
(102, 1, 'UPI', 300.00),
(103, 2, 'Card', 700.00),
(104, 3, 'UPI', 250.00),
(105, 3, 'Card', 500.00),
(106, 4, 'Cash', 600.00),
(107, 5, 'UPI', 120.00),
(108, 6, 'Card', 900.00);

-- Write a query to find the customer_id of customers who have never made cash
-- payment.
select distinct customer_id from payments
where customer_id not in (
select distinct customer_id from payments 
where payment_type = 'Cash')

select * from payments;


create table lift_logs (
log_id INT,
emp_id INT,
weight INT,
entry_time TIMESTAMP
);
insert into lift_logs (log_id, emp_id, weight, entry_time) values
(1, 201, 70, '2024-12-01 09:00:00'),
(2, 202, 82, '2024-12-01 09:01:00'),
(3, 203, 68, '2024-12-01 09:02:00'),
(4, 204, 75, '2024-12-01 09:03:00'),
(5, 205, 90, '2024-12-01 09:04:00'),
(6, 206, 88, '2024-12-01 09:05:00'),
(7, 207, 95, '2024-12-01 09:06:00'),
(8, 208, 92, '2024-12-01 09:07:00'),
(9, 209, 85, '2024-12-01 09:08:00'),
(10, 210, 80, '2024-12-01 09:09:00'),
(11, 211, 78, '2024-12-01 09:10:00');


select * from lift_logs;
-- Suppose a lift has a weight limit of 750 kg. Employees enter one by one. Write a
-- query to find the first entry event where the lift starts ringing due to the weight
-- limit being exceeded. Return log_id, emp_id, and entry_time.
with cte as 
	(select log_id, emp_id, entry_time, weight,
	sum(weight) over ( order by  entry_time
	rows between unbounded preceding and current row
	) as cum_weight
	from lift_logs)

select log_id, emp_id, entry_time
from cte where cum_weight > 750
limit 1



CREATE TABLE weather (
Days DATE,
Temperature INT
);
INSERT INTO weather (Days, Temperature) VALUES
('2024-01-01', 20),
('2024-01-02', 22),
('2024-01-03', 21),
('2024-01-05', 25),
('2024-01-06', 25),
('2024-01-07', 28),
('2024-01-08', 24),
('2024-01-09', 26);

-- Write a query to find the days when the temperature was higher than the previous
-- day.

with cte as (
select *,
lag(days) over(order by days) as prev_day,
lag(temperature) over(order by days) as prev_temp
from weather)

select * from cte
where temperature > prev_temp
and age(days, prev_day) = interval '1 DAY'





