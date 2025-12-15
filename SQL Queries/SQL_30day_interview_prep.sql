--- VIDEO_Q1 ---

/* Problem Statement:
- For pairs of brands in the same year (e.g. apple/samsung/2020 and samsung/apple/2020) 
    - if custom1 = custom3 and custom2 = custom4 : then keep only one pair

- For pairs of brands in the same year 
    - if custom1 != custom3 OR custom2 != custom4 : then keep both pairs

- For brands that do not have pairs in the same year : keep those rows as well
*/


DROP TABLE IF EXISTS brands;
CREATE TABLE brands 
(
    brand1      VARCHAR(20),
    brand2      VARCHAR(20),
    year        INT,
    custom1     INT,
    custom2     INT,
    custom3     INT,
    custom4     INT
);
INSERT INTO brands VALUES ('apple', 'samsung', 2020, 1, 2, 1, 2);
INSERT INTO brands VALUES ('samsung', 'apple', 2020, 1, 2, 1, 2);
INSERT INTO brands VALUES ('apple', 'samsung', 2021, 1, 2, 5, 3);
INSERT INTO brands VALUES ('samsung', 'apple', 2021, 5, 3, 1, 2);
INSERT INTO brands VALUES ('google', NULL, 2020, 5, 9, NULL, NULL);
INSERT INTO brands VALUES ('oneplus', 'nothing', 2020, 5, 9, 6, 3);

SELECT * FROM brands;

--solution

with cte as (
select *,
case when brand1 < brand2 then concat(brand1, brand2, year) 
else concat(brand2, brand1, year) end as unique_id
from brands),
cte_en as (
select *,
row_number() over(partition by unique_id order by unique_id) as rank
from cte
)

select brand1, brand2, year, custom1, custom2, custom3, custom4 from cte_en
where rank = 1 
or (custom1 <> custom3 and custom2 <> custom4)


--PROBLEM STATEMENT: Write a sql query to return the footer values from input table, 
-- meaning all the last non null values from each field as shown in expected output.


DROP TABLE IF EXISTS footer;
CREATE TABLE footer 
(
	id 			INT PRIMARY KEY,
	car 		VARCHAR(20), 
	length 		INT, 
	width 		INT, 
	height 		INT
);

INSERT INTO FOOTER VALUES (1, 'Hyundai Tucson', 15, 6, NULL);
INSERT INTO FOOTER VALUES (2, NULL, NULL, NULL, 20);
INSERT INTO FOOTER VALUES (3, NULL, 12, 8, 15);
INSERT INTO FOOTER VALUES (4, 'Toyota Rav4', NULL, 15, NULL);
INSERT INTO FOOTER VALUES (5, 'Kia Sportage', NULL, NULL, 18); 


-- Solution 1
select * from (select car from footer where car is not null order by id desc limit 1) as car
cross join (select length from footer where length is not null order by id desc limit 1) as lenght
cross join (select width from footer where width is not null order by id desc limit 1) as width
cross join (select height from footer where height is not null order by id desc limit 1) as height

