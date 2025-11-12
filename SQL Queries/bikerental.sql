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

/* Problem 3: Emily would like to know how many bikes the shop owns by category. Can 
you get this for her? 
Display the category name and the number of bikes the shop owns in 
each category (call this column 
number_of_bikes ). Show only the categories 
where the number of bikes is greater than  */
select category, count(model) as total_bikes
from bike
group by category;


/* Problem 4:  Emily needs a list of customer names with the total number of 
memberships purchased by each.
 For each customer, display the customer's name and the count of 
memberships purchased (call this column 
membership_count ). Sort the 
results by 
membership_count , starting with the customer who has purchased 
the highest number of memberships.
 Keep in mind that some customers may not have purchased any 
memberships yet. In such a situation, display 
0 for the 
membership_count . */

select c.name, 
case when count(m.customer_id) = 0 then 0 else count(m.customer_id) end as membership_count
from customer as c left join membership as m
on c.id = m.customer_id
group by c.name
order by membership_count

/*Problem 5:  Emily is working on a special offer for the winter months. Can you help her 
prepare a list of new rental prices?
 For each bike, display its ID, category, old price per hour (call this column 
old_price_per_hour ), discounted price per hour (call it 
new_price_per_hour ), old 
price per day (call it 
old_price_per_day ), and discounted price per day (call it 
new_price_per_day ).
 Electric bikes should have a 10% discount for hourly rentals and a 20% 
discount for daily rentals. Mountain bikes should have a 20% discount for 
hourly rentals and a 50% discount for daily rentals. All other bikes should 
have a 50% discount for all types of rentals.
 Round the new prices to 2 decimal digits.  */

select
id,
distinct category,
price_per_hour as old_price_per_hour,
case when category = 'electric' then price_per_hour + (price_per_hour * 0.10 )
	 when category = 'mountain_bike' then price_per_hour + (price_per_hour * 0.20 )
	 else price_per_hour + (price_per_hour * 0.50 ) end as new_price_per_hour,
price_per_day as old_price_per_day,
case when category = 'electric' then price_per_day + (price_per_day * 0.20)
	 when category = 'mountain_bike' then price_per_day + (price_per_day * 0.50)
	 else  price_per_day + (price_per_day * 0.50) end as new_price_per_day
from bike;

/* Emily is looking for counts of the rented bikes and of the available bikes in 
each category.
 Display the number of available bikes (call this column 
available_bikes_count ) and the number of rented bikes (call this column 
rented_bikes_count ) by bike category. */








