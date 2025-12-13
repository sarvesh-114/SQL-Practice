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

select * from employee;
select * from duplicate;
select * from computer;



