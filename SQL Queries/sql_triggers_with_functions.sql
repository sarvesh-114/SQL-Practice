CREATE TABLE employees (
    emp_id SERIAL PRIMARY KEY,   
    emp_name VARCHAR(25) NOT NULL,  
    salary NUMERIC(10, 2) NOT NULL,  
    department VARCHAR(50),        
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
);

INSERT INTO employees (emp_name, salary, department) VALUES
('Amit Sharma', 45000, 'HR'),
('Neha Gupta', 52000, 'Finance'),
('Rajesh Kumar', 60000, 'IT'),
('Pooja Mehta', 35000, 'Marketing'),
('Vikram Singh', 48000, 'Sales');


CREATE TABLE employee_records
(
	emp_id INT, 
	emp_name VARCHAR(25), 
	action VARCHAR(50), 
	action_time TIMESTAMP
);

-- There are two types of triggers in SQl one is After and Before
-- Req - record employee in another table which is called "employee_records" after emp being deleted

create or replace function employee_delete_log()
returns trigger as
$$
begin
insert into employee_records(emp_id, emp_name, action, action_time)
values(OLD.emp_id, OLD.emp_name, 'Delete', current_timestamp);
return old;
end
$$
language plpgsql;


create trigger delete_emp_logs_trigger
after delete on employees
for each row
execute function employee_delete_log()

delete from employees
where emp_id = 1



select * from employees;
select * from employee_records;



create or replace function prevent_delete()
returns trigger as 
$$
begin
if old.department = 'IT' then
raise exception 'deleting employees from IT department is not allow';
end if;
return old;
end
$$
language plpgsql;


create trigger prevent_delete_trigger
before delete on employees
for each row
execute function prevent_delete()

delete from employees
where department = 'IT';
