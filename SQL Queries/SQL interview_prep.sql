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


