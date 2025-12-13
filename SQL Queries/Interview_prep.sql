-- Drop tables and sequence:
DROP TABLE student_batch_maps;
DROP TABLE instructor_batch_maps;
DROP TABLE attendances;
DROP TABLE sessions;
DROP TABLE test_scores;
DROP TABLE tests;
DROP TABLE users;
DROP TABLE batches;

DROP SEQUENCE instructor_batch_maps_id_seq;
DROP SEQUENCE sessions_id_seq;
DROP SEQUENCE tests_id_seq;
DROP SEQUENCE student_batch_maps_id_seq;
DROP SEQUENCE users_id_seq;
DROP SEQUENCE batch_id_seq;


-- 1.users table:  name(user name), active(boolean to check if user is active)
CREATE SEQUENCE users_id_seq;
CREATE TABLE users (
  id INTEGER PRIMARY KEY NOT NULL DEFAULT NEXTVAL ('users_id_seq'),
  name VARCHAR(50) NOT NULL,
  active BOOLEAN NOT NULL DEFAULT true,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

insert into users values (1, 'Rohit', true, CURRENT_DATE-5, CURRENT_DATE-4);
insert into users values (2, 'James', true, CURRENT_DATE-5, CURRENT_DATE-4);
insert into users values (3, 'David', true, CURRENT_DATE-5, CURRENT_DATE-4);
insert into users values (4, 'Steven', true, CURRENT_DATE-5, CURRENT_DATE-4);
insert into users values (5, 'Ali', true, CURRENT_DATE-5, CURRENT_DATE-4);
insert into users values (6, 'Rahul', true, CURRENT_DATE-5, CURRENT_DATE-4);
insert into users values (7, 'Jacob', true, CURRENT_DATE-5, CURRENT_DATE-4);
insert into users values (8, 'Maryam', true, CURRENT_DATE-5, CURRENT_DATE-4);
insert into users values (9, 'Shwetha', false, CURRENT_DATE-5, CURRENT_DATE-4);
insert into users values (10, 'Sarah', true, CURRENT_DATE-5, CURRENT_DATE-4);
insert into users values (11, 'Alex', true, CURRENT_DATE-5, CURRENT_DATE-4);
insert into users values (12, 'Charles', false, CURRENT_DATE-5, CURRENT_DATE-4);
insert into users values (13, 'Perry', true, CURRENT_DATE-5, CURRENT_DATE-4);
insert into users values (14, 'Emma', true, CURRENT_DATE-5, CURRENT_DATE-4);
insert into users values (15, 'Sophia', true, CURRENT_DATE-5, CURRENT_DATE-4);
insert into users values (16, 'Lucas', true, CURRENT_DATE-5, CURRENT_DATE-4);
insert into users values (17, 'Benjamin', true, CURRENT_DATE-5, CURRENT_DATE-4);
insert into users values (18, 'Hazel', false, CURRENT_DATE-5, CURRENT_DATE-4);




-- 2.batches  table:  name(batch name), active(boolean to check if batch is active)
CREATE SEQUENCE batch_id_seq;
CREATE TABLE batches (
  id INTEGER PRIMARY KEY NOT NULL DEFAULT NEXTVAL('batch_id_seq'),
  name VARCHAR(100) UNIQUE NOT NULL,
  active BOOLEAN NOT NULL DEFAULT true,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

insert into batches values (1, 'Statistics', true, CURRENT_DATE-10, CURRENT_DATE-6);
insert into batches values (2, 'Mathematics', true, CURRENT_DATE-10, CURRENT_DATE-6);
insert into batches values (3, 'Physics', false, CURRENT_DATE-10, CURRENT_DATE-6);




-- 3.student_batch_maps  table: this table is a mapping of the student and his batch. deactivated_at is the time when a student is made inactive in a batch.
CREATE SEQUENCE student_batch_maps_id_seq;
CREATE TABLE student_batch_maps (
  id INTEGER PRIMARY KEY NOT NULL DEFAULT   NEXTVAL('student_batch_maps_id_seq'),
  user_id INTEGER NOT NULL REFERENCES users(id),
  batch_id INTEGER NOT NULL REFERENCES batches(id),
  active BOOLEAN NOT NULL DEFAULT true,
  deactivated_at TIMESTAMP NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

insert into student_batch_maps values (1, 1, 1, true, CURRENT_TIMESTAMP, CURRENT_DATE-5, CURRENT_DATE-4);
insert into student_batch_maps values (2, 2, 1, true, CURRENT_TIMESTAMP, CURRENT_DATE-5, CURRENT_DATE-4);
insert into student_batch_maps values (3, 3, 1, true, CURRENT_TIMESTAMP, CURRENT_DATE-5, CURRENT_DATE-4);
insert into student_batch_maps values (4, 4, 1, false, CURRENT_TIMESTAMP, CURRENT_DATE-5, CURRENT_DATE-4);
insert into student_batch_maps values (5, 5, 2, true, CURRENT_TIMESTAMP, CURRENT_DATE-5, CURRENT_DATE-4);
insert into student_batch_maps values (6, 6, 2, true, CURRENT_TIMESTAMP, CURRENT_DATE-5, CURRENT_DATE-4);
insert into student_batch_maps values (7, 7, 2, true, CURRENT_TIMESTAMP, CURRENT_DATE-5, CURRENT_DATE-4);
insert into student_batch_maps values (8, 8, 2, true, CURRENT_TIMESTAMP, CURRENT_DATE-5, CURRENT_DATE-4);
insert into student_batch_maps values (9, 9, 2, false, CURRENT_TIMESTAMP, CURRENT_DATE-5, CURRENT_DATE-4);
insert into student_batch_maps values (10, 10, 3, true, CURRENT_TIMESTAMP, CURRENT_DATE-5, CURRENT_DATE-4);
insert into student_batch_maps values (11, 11, 3, true, CURRENT_TIMESTAMP, CURRENT_DATE-5, CURRENT_DATE-4);
insert into student_batch_maps values (12, 12, 3, false, CURRENT_TIMESTAMP, CURRENT_DATE-5, CURRENT_DATE-4);
insert into student_batch_maps values (13, 13, 3, true, CURRENT_TIMESTAMP, CURRENT_DATE-5, CURRENT_DATE-4);
insert into student_batch_maps values (14, 14, 3, true, CURRENT_TIMESTAMP, CURRENT_DATE-5, CURRENT_DATE-4);
insert into student_batch_maps values (15, 4, 2, true, CURRENT_TIMESTAMP, CURRENT_DATE-4, CURRENT_DATE-3);
insert into student_batch_maps values (16, 9, 3, false, CURRENT_TIMESTAMP, CURRENT_DATE-3, CURRENT_DATE-2);
insert into student_batch_maps values (17, 9, 1, true, CURRENT_TIMESTAMP, CURRENT_DATE-2, CURRENT_DATE-1);
insert into student_batch_maps values (18, 12, 1, true, CURRENT_TIMESTAMP, CURRENT_DATE-4, CURRENT_DATE-3);




-- 4.instructor_batch_maps  table: this table is a mapping of the instructor and the batch he has been assigned to take class/session.
CREATE SEQUENCE instructor_batch_maps_id_seq;
CREATE TABLE instructor_batch_maps (
  id INTEGER PRIMARY KEY NOT NULL DEFAULT NEXTVAL('instructor_batch_maps_id_seq'),
  user_id INTEGER REFERENCES users(id),
  batch_id INTEGER REFERENCES batches(id),
  active BOOLEAN NOT NULL DEFAULT true,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

insert into instructor_batch_maps values (1, 15, 1, true, CURRENT_DATE-5, CURRENT_DATE-4);
insert into instructor_batch_maps values (2, 16, 2, true, CURRENT_DATE-5, CURRENT_DATE-4);
insert into instructor_batch_maps values (3, 17, 3, true, CURRENT_DATE-5, CURRENT_DATE-4);
insert into instructor_batch_maps values (4, 18, 2, true, CURRENT_DATE-5, CURRENT_DATE-4);




-- 5.sessions table: Every day session happens where the teacher takes a session or class of students.
CREATE SEQUENCE sessions_id_seq;
CREATE TABLE sessions (
  id INTEGER PRIMARY KEY NOT NULL DEFAULT NEXTVAL('sessions_id_seq'),
  conducted_by INTEGER NOT NULL REFERENCES users(id),
  batch_id INTEGER NOT NULL REFERENCES batches(id),
  start_time TIMESTAMP NOT NULL,
  end_time TIMESTAMP NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

insert into sessions values (1, 15, 1, (CURRENT_TIMESTAMP - INTERVAL '240 MINUTE'), (CURRENT_TIMESTAMP - INTERVAL '180 MINUTE'), CURRENT_DATE, CURRENT_DATE);
insert into sessions values (2, 16, 2, (CURRENT_TIMESTAMP - INTERVAL '240 MINUTE'), (CURRENT_TIMESTAMP - INTERVAL '180 MINUTE'), CURRENT_DATE, CURRENT_DATE);
insert into sessions values (3, 17, 3, (CURRENT_TIMESTAMP - INTERVAL '240 MINUTE'), (CURRENT_TIMESTAMP - INTERVAL '180 MINUTE'), CURRENT_DATE, CURRENT_DATE);
insert into sessions values (4, 15, 1, (CURRENT_TIMESTAMP - INTERVAL '180 MINUTE'), (CURRENT_TIMESTAMP - INTERVAL '120 MINUTE'), CURRENT_DATE, CURRENT_DATE);
insert into sessions values (5, 16, 2, (CURRENT_TIMESTAMP - INTERVAL '180 MINUTE'), (CURRENT_TIMESTAMP - INTERVAL '120 MINUTE'), CURRENT_DATE, CURRENT_DATE);
insert into sessions values (6, 18, 2, (CURRENT_TIMESTAMP - INTERVAL '120 MINUTE'), (CURRENT_TIMESTAMP - INTERVAL '60 MINUTE'), CURRENT_DATE, CURRENT_DATE);




-- 6.attendances table: After session or class happens between teacher and student, attendance is given by student. students provide ratings to the teacher.
CREATE TABLE attendances (
  student_id INTEGER NOT NULL REFERENCES users(id),
  session_id INTEGER NOT NULL REFERENCES sessions(id),
  rating DOUBLE PRECISION NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (student_id, session_id)
);

insert into attendances values (1, 1, 8.5, CURRENT_DATE, CURRENT_DATE);
insert into attendances values (2, 1, 7.5, CURRENT_DATE, CURRENT_DATE);
insert into attendances values (3, 1, 6.0, CURRENT_DATE, CURRENT_DATE);
insert into attendances values (5, 2, 8.5, CURRENT_DATE, CURRENT_DATE);
insert into attendances values (6, 2, 7.5, CURRENT_DATE, CURRENT_DATE);
insert into attendances values (7, 2, 6.0, CURRENT_DATE, CURRENT_DATE);
insert into attendances values (8, 2, 6.0, CURRENT_DATE, CURRENT_DATE);
insert into attendances values (10, 3, 9.5, CURRENT_DATE, CURRENT_DATE);
insert into attendances values (11, 3, 7.0, CURRENT_DATE, CURRENT_DATE);
insert into attendances values (13, 3, 8.0, CURRENT_DATE, CURRENT_DATE);
insert into attendances values (14, 3, 6.0, CURRENT_DATE, CURRENT_DATE);
insert into attendances values (1, 4, 7.0, CURRENT_DATE, CURRENT_DATE);
insert into attendances values (2, 4, 5.5, CURRENT_DATE, CURRENT_DATE);
insert into attendances values (5, 5, 5.0, CURRENT_DATE, CURRENT_DATE);
insert into attendances values (5, 6, 6.0, CURRENT_DATE, CURRENT_DATE);
insert into attendances values (9, 2, 4.0, CURRENT_DATE, CURRENT_DATE);
insert into attendances values (12, 3, 5.0, CURRENT_DATE, CURRENT_DATE);




-- 7.tests table: Test is created by instructor. total_mark is the maximum marks for the test.
CREATE SEQUENCE tests_id_seq;
CREATE TABLE tests (
   id INTEGER PRIMARY KEY NOT NULL DEFAULT NEXTVAL('tests_id_seq'),
  batch_id INTEGER REFERENCES batches(id),
  created_by INTEGER REFERENCES users(id),
  total_mark INTEGER NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

insert into tests values (1, 1, 15, 100, CURRENT_DATE, CURRENT_DATE);
insert into tests values (2, 2, 16, 100, CURRENT_DATE, CURRENT_DATE);
insert into tests values (3, 3, 17, 100, CURRENT_DATE, CURRENT_DATE);
insert into tests values (4, 2, 18, 100, CURRENT_DATE, CURRENT_DATE);
insert into tests values (5, 1, 15, 50, CURRENT_DATE, CURRENT_DATE);
insert into tests values (6, 1, 15, 25, CURRENT_DATE, CURRENT_DATE);
insert into tests values (7, 1, 15, 25, CURRENT_DATE, CURRENT_DATE);
insert into tests values (8, 2, 16, 50, CURRENT_DATE, CURRENT_DATE);
insert into tests values (9, 3, 17, 50, CURRENT_DATE, CURRENT_DATE);



-- 8.test_scores table: Marks scored by students are added in the test_scores table.
CREATE TABLE test_scores (
  test_id INTEGER REFERENCES tests(id),
  user_id INTEGER REFERENCES users(id),
  score INTEGER NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY(test_id, user_id)
);

insert into test_scores values (1, 1, 80, CURRENT_DATE, CURRENT_DATE);
insert into test_scores values (1, 2, 60, CURRENT_DATE, CURRENT_DATE);
insert into test_scores values (1, 3, 30, CURRENT_DATE, CURRENT_DATE);
insert into test_scores values (2, 5, 80, CURRENT_DATE, CURRENT_DATE);
insert into test_scores values (2, 6, 35, CURRENT_DATE, CURRENT_DATE);
insert into test_scores values (2, 7, 38, CURRENT_DATE, CURRENT_DATE);
insert into test_scores values (2, 8, 90, CURRENT_DATE, CURRENT_DATE);
insert into test_scores values (3, 10, 65, CURRENT_DATE, CURRENT_DATE);
insert into test_scores values (3, 11, 85, CURRENT_DATE, CURRENT_DATE);
insert into test_scores values (3, 13, 95, CURRENT_DATE, CURRENT_DATE);
insert into test_scores values (3, 14, 100, CURRENT_DATE, CURRENT_DATE);
insert into test_scores values (5, 1, 40, CURRENT_DATE, CURRENT_DATE);
insert into test_scores values (5, 2, 35, CURRENT_DATE, CURRENT_DATE);
insert into test_scores values (5, 3, 45, CURRENT_DATE, CURRENT_DATE);
insert into test_scores values (6, 1, 22, CURRENT_DATE, CURRENT_DATE);
insert into test_scores values (6, 2, 12, CURRENT_DATE, CURRENT_DATE);
insert into test_scores values (7, 1, 16, CURRENT_DATE, CURRENT_DATE);
insert into test_scores values (7, 3, 10, CURRENT_DATE, CURRENT_DATE);
insert into test_scores values (8, 5, 15, CURRENT_DATE, CURRENT_DATE);
insert into test_scores values (8, 6, 20, CURRENT_DATE, CURRENT_DATE);
insert into test_scores values (9, 13, 25, CURRENT_DATE, CURRENT_DATE);
insert into test_scores values (9, 14, 35, CURRENT_DATE, CURRENT_DATE);



-- Problem Statement: Find customers with successful multiple purchases in the last 1 month. 
-- Purchase is considered successful if they are not returned within 1 week of purchase. 

DROP TABLE IF EXISTS purchases;
create table purchases 
(
    purchase_id     int,
    customer_id     int,
    purchase_date   date,
    return_date     date
);

insert into purchases (purchase_id, customer_id, purchase_date, return_date) values
(1, 101, '2025-11-24', '2025-11-27'),
(2, 102, '2025-11-23', '2025-11-23'),
(3, 101, '2025-11-24', null),
(4, 101, '2025-10-28', null),
(5, 103, '2025-11-11', null),
(6, 102, '2025-11-23', null),
(7, 102, '2025-11-03', null),
(8, 103, '2025-11-27', '2025-12-03');


-- solution:
select customer_id from purchases
where purchase_date > cast(current_date - interval '1 month' as date)
and (return_date is null or 
return_date > cast(purchase_date + interval '1 week' as date))
group by customer_id
having count(customer_id) >=1


-- Problem 2: Latest Order Summary per Customer

-- Problem Statement: Write an SQL query to fetch the customer name, their latest order date and total value of the order. If a customer made multiple orders on the latest order date then fetch total value for all the orders in that day. If a customer has not done an order yet, display the “9999-01-01” as latest order date and 0 as the total order value.


DROP TABLE IF EXISTS customers;
CREATE TABLE customers 
(
    id     INT,
    name   VARCHAR(50)
);
INSERT INTO customers VALUES
(101, 'David'),
(102, 'Robin'),
(103, 'Carol'),
(104, 'Ali');

DROP TABLE IF EXISTS orders;
CREATE TABLE orders 
(
    id              INT,
    customer_id     INT,
    total_cost      DECIMAL,
    order_date      DATE
);
INSERT INTO orders VALUES
(1, 101, 100, '2025-04-15'),
(2, 102, 40, '2025-04-20'),
(3, 101, 80, '2025-03-12'),
(4, 101, 120, '2025-03-12'),
(5, 103, 60, '2025-04-20'),
(6, 103, 50, '2025-04-20');

--solution
select customer,
coalesce(order_date, '9999-01-01') as latest_order_date,
coalesce(sum(total_cost), '0') as total_cost
from (
select o.*, c.name as customer,
rank() over(partition by customer_id order by order_date) as rnk
from orders as o right join customers as c
on c.id = o.customer_id
) as x
where x.rnk = 1
group by customer_id, customer, order_date


-- Problem 3: Past Active Customers 
-- Problem Statement: Find customers who have not placed any orders yet in 2025 
-- but had placed orders in every month of 2024 and had placed orders in at least 6 of the months in 2023. Display the customer name.
DROP TABLE IF EXISTS customers;
CREATE TABLE customers 
(
    id     INT PRIMARY KEY,
    name   VARCHAR(50)
);
INSERT INTO customers VALUES
(101, 'David Smith'),
(102, 'Nikhil Reddy'),
(103, 'Carol Tan'),
(104, 'Riya Sengupta'),
(105, 'Liam Patel'),
(106, 'Priya Nair'),
(107, 'James Canny');


DROP TABLE IF EXISTS orders;
CREATE TABLE orders 
(
    id              INT PRIMARY KEY,
    customer_id     INT,
    order_date      DATE
);
INSERT INTO orders VALUES
(1 , 101, '2024-01-05'),
(2 , 101, '2024-02-10'),
(3 , 101, '2024-03-03'),
(4 , 101, '2024-04-15'),
(5 , 101, '2024-05-20'),
(6 , 101, '2024-06-18'),
(7 , 101, '2024-07-12'),
(8 , 101, '2024-08-25'),
(9 , 101, '2024-09-30'),
(10, 101, '2024-10-22'),
(11, 101, '2024-11-02'),
(12, 101, '2024-12-17'),
(13, 102, '2024-01-10'),
(14, 102, '2024-02-15'),
(15, 102, '2024-03-10'),
(16, 102, '2024-04-05'),
(17, 102, '2024-05-07'),
(18, 102, '2024-06-12'),
(19, 102, '2024-07-14'),
(20, 102, '2024-08-16'),
(21, 103, '2024-01-01'),
(22, 103, '2024-04-01'),
(23, 103, '2024-07-01'),
(24, 103, '2024-10-01'),
(25, 104, '2024-02-20'),
(26, 104, '2024-05-20'),
(27, 104, '2024-08-20'),
(28, 105, '2024-01-01'),
(29, 105, '2024-02-01'),
(30, 105, '2024-03-01'),
(31, 105, '2024-04-01'),
(32, 105, '2024-05-01'),
(33, 105, '2024-06-01'),
(34, 105, '2024-07-01'),
(35, 105, '2024-08-01'),
(36, 105, '2024-09-01'),
(37, 105, '2024-10-01'),
(38, 105, '2024-11-01'),
(39, 105, '2024-12-01'),
(40, 102, '2024-08-10'),
(41, 102, '2024-07-05'),
(42, 102, '2024-06-06'),
(43, 102, '2024-05-26'),
(44, 106, '2024-01-02'),
(45, 106, '2024-02-13'),
(46, 106, '2024-03-05'),
(47, 106, '2024-04-16'),
(48, 106, '2024-05-26'),
(49, 106, '2024-06-17'),
(50, 106, '2024-07-19'),
(51, 106, '2024-08-20'),
(52, 106, '2024-09-12'),
(53, 106, '2024-10-22'),
(54, 106, '2024-11-03'),
(55, 106, '2024-12-14'),
(56, 105, '2025-01-28'),
(57, 105, '2025-04-21'),
(58, 103, '2025-03-22'),
(59, 101, '2023-01-15'),
(60, 101, '2023-02-11'),
(61, 101, '2023-03-13'),
(62, 101, '2023-05-10'),
(63, 101, '2023-06-12'),
(64, 101, '2023-07-11'),
(65, 101, '2023-12-12'),
(66, 107, '2024-01-22'),
(67, 107, '2024-02-28'),
(68, 107, '2024-03-31'),
(69, 107, '2024-04-30'),
(70, 107, '2024-05-30'),
(71, 107, '2024-06-30'),
(72, 107, '2024-07-31'),
(73, 107, '2024-08-31'),
(74, 107, '2024-09-30'),
(75, 107, '2024-10-31'),
(76, 107, '2024-11-30'),
(77, 107, '2024-12-28'),
(78, 107, '2024-12-31'),
(79, 107, '2023-07-31'),
(80, 107, '2023-08-31'),
(81, 107, '2023-09-30'),
(82, 107, '2023-10-31'),
(83, 107, '2023-11-30'),
(84, 107, '2023-12-31'),
(85, 105, '2023-01-21'),
(86, 105, '2023-03-09'),
(87, 105, '2023-04-20'),
(88, 105, '2023-06-10'),
(89, 105, '2023-10-10'),
(90, 105, '2023-11-21');

-- solution 1
with customers_2025 as
        (select * 
        from orders
        where extract(year from order_date) = 2025),
    customers_2024 as 
        (select customer_id
        , count(extract(month from order_date)) as unique_monthly_orders
        from orders
        where extract(year from order_date) = 2024
        group by customer_id
        having count(distinct extract(month from order_date)) >= 12),
    customers_2023 as
        (select customer_id
        , count(extract(month from order_date)) as unique_monthly_orders
        from orders
        where extract(year from order_date) = 2023
        group by customer_id
        having count(distinct extract(month from order_date)) >= 6)
select c.name as customer
from customers c
join customers_2024 c24 on c24.customer_id = c.id
join customers_2023 c23 on c23.customer_id = c.id
where c.id not in (select customer_id from customers_2025);
select * from customers;
select * from orders;

