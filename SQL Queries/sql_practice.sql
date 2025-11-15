drop table if exists parent_child_status;
create table parent_child_status
(
	parent_id	int,
	child_id	int,
	status		varchar(20)
);
insert into parent_child_status values (1, 3, 'Active');
insert into parent_child_status values (1, 4, 'InActive');
insert into parent_child_status values (1, 5, 'Active');
insert into parent_child_status values (1, 6, 'InActive');
insert into parent_child_status values (2, 7, 'Active');
insert into parent_child_status values (2, 8, 'InActive');
insert into parent_child_status values (3, 9, 'Inactive');
insert into parent_child_status values (4, 10, 'Inactive');
insert into parent_child_status values (4, 11, 'Active');
insert into parent_child_status values (5, 12, 'InActive');
insert into parent_child_status values (5, 13, 'InActive');


select * from parent_child_status;

/*Problem Statement: 
The status column in input table depicts the status of child. 
If the parent has atleast one child in ""Active"" status then we need to report parent as ""Active"" status (Ex: parent_id 1,2, 4). 
If none of the child is ""Active"" for a Parent then we need to report the parent as ""InActive"" (Ex: parent_id 3,5). */									
											
											
											



-- Answer 1
with active as
(
	select parent_id, status
	from parent_child_status
	where status = 'Active'
	group by parent_id, status
),
inactive as 
(
	select parent_id, status
	from parent_child_status
	where parent_id not in (select parent_id from active)
	group by parent_id, status)

select * from active
union all
select * from inactive
order by parent_id

-- Answer 2
with cte as  (
select *,
row_number() over(partition by parent_id order by status) as rn
from parent_child_status
order by parent_id, status)
select parent_id, status from cte
where rn = 1;

-- Answer 3
select parent_id, status from (
select *,
row_number() over(partition by parent_id order by status) as rn
from parent_child_status
order by parent_id, status) as e
where e.rn = 1;

--Answer 4
select a.parent_id
, case when b.status is null 
then 'InActive' 
else b.status end as status
from (select distinct parent_id from parent_child_status) a
left join ( select distinct parent_id, status 
from parent_child_status
where status = 'Active') b 
on b.parent_id = a.parent_id
order by a.parent_id;







