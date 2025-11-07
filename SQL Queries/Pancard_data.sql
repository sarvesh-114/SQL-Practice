
drop table if exists pan_number;
create table pan_number
(
	pan_number text
);

select * from pan_number;
select count(*) from pan_number;

-- Data Cleaning and Data preprocessing
-- 1. Identify and handle missing data
select pan_number 
from pan_number where pan_number is null

-- 2. Check for duplicates
Select pan_number, count(*) from pan_number 
group by pan_number
having count(*) > 1

-- 3. handelling trailing and leading spaces
select pan_number
from pan_number
where pan_number <> trim(pan_number)

--4. Correct letter cases
select pan_number
from pan_number
where pan_number <> upper(pan_number)

select distinct trim(upper(pan_number)) as pan_number
from pan_number
where pan_number is not null
and trim(upper(pan_number)) <> ''


-- function to check if adjacent characters are same
create or replace function fn_check_adjacent_char(p_str text)
returns boolean
language plpgsql
as $$
begin
for i in 1 .. (length(p_str) - 1) 
loop
if substring(p_str, i, 1) = substring(p_str, i + 1, 1) then
return true;
end if;
end loop;
return false;
end;
$$;

select fn_check_adjacent_char('AACDE')

-- function to check if characters are in sequence
create or replace function fn_check_sequence_char(p_str text)
returns boolean
language plpgsql
as $$
begin
for i in 1 .. (length(p_str) - 1) 
loop
if ascii(substring(p_str, i+1, 1)) - ascii(substring(p_str, i, 1)) <> 1
then
return false;
end if;
end loop;
return true;
end;
$$;
select fn_check_sequence_char('ABCDE')

-- Characters ruling
select * from pan_number
where pan_number ~ '^[A-Z]{5}[0-9]{4}[A-Z]$'

--Final Table
with cte_cleaned_pan as
		(select distinct upper(trim(pan_number)) as pan_number
		from pan_number 
		where pan_number is not null
		and TRIM(pan_number) <> ''),
	cte_valid_pan as
		(select *
		from cte_cleaned_pan
		where fn_check_adjacent_char(pan_number) = 'false'
		and fn_check_sequence_char(substring(pan_number,1,5)) = 'false'
		and fn_check_sequence_char(substring(pan_number,6,4)) = 'false'
		and pan_number ~ '^[A-Z]{5}[0-9]{4}[A-Z]$')

select 
cln.pan_number,
case when vln.pan_number is not null then 'Valid PAN' else 'Invalid PAN' end as Status
from cte_cleaned_pan as cln
left join cte_valid_pan as vln on vln.pan_number = cln.pan_number












