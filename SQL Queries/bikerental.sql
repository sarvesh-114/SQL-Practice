/* Problem 1: Emily is preparing a sales report. She needs to know the total revenue 
from rentals by month, the total by year, and the all-time across all the 
years. 
4
 Bike rental shop  SQL Case study
Display the total revenue from rentals for each month, the total for each 
year, and the total across all the years. Do not take memberships into 
account. There should be 3 columns: 
year , 
month , and 
revenue .
 Sort the results chronologically. Display the year total after all the month 
totals for the corresponding year. Show the all-time total as the last row.*/

-- Answer 1
select extract(year from start_timestamp) as year
, extract(month from start_timestamp) as month
, sum(total_paid) as revenue
from rental
group by extract(year from start_timestamp), extract(month from start_timestamp)
union all
select extract(year from start_timestamp) as year
, null as month, sum(total_paid) as revenue
from rental
group by extract(year from start_timestamp)
union all
select null as year, null as month, sum(total_paid) as revenue
from rental
order by year, month;

--Answer 2
select extract(year from start_timestamp) as year
, extract(month from start_timestamp) as month
, sum(total_paid) as revenue
from rental
group by grouping sets ((year, month), (year), ())
order by year, month

--Answer 3
select extract(year from start_timestamp) as year
, extract(month from start_timestamp) as month
, sum(total_paid) as revenue
from rental
group by rollup (year, month)
order by year, month

 /* Problem 2Emily would like data about memberships purchased in 2023, with 
subtotals and grand totals for all the different combinations of membership 
types and months.
 Display the total revenue from memberships purchased in 2023 for each 
combination of month and membership type. Generate subtotals and 
grand totals for all possible combinations.  There should be 3 columns: 
membership_type_name , 
month , and 
total_revenue .
 Sort the results by membership type name alphabetically and then 
chronologically by month */

--Answer 1
select name,
extract(month from start_date) as month,
sum(total_paid) as total_amt
from membership as m join membership_type as mt
on mt.id = m.membership_type_id
group by grouping sets((name, month), (name))
order by name, month







