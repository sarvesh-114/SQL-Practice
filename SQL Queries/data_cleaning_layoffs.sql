use project;
select * from layoffs;

create table layoff_satging
like layoffs;

insert layoff_satging
select *  
from layoffs;

select * from layoff_satging;


-- Deleting duplicates
with cte as (select *,
row_number() over(partition by company, location, industry, total_laid_off,
 percentage_laid_off, `date`, stage, 
 country, funds_raised_millions) as row_num
from layoff_satging)

delete from cte
where row_num >1;


CREATE TABLE `layoff_satging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;




select * from layoff_satging2;
insert into layoff_satging2
select *,
row_number() over(partition by company, location, industry,
 total_laid_off, percentage_laid_off, `date`,
 stage, country, funds_raised_millions) as row_num
from layoff_satging;

delete from layoff_satging2
where row_num>1;

select * from layoff_satging2
where row_num>1;

select trim(company)
from layoff_satging2;

update layoff_satging2
set company = trim(company);

select distinct industry
from layoff_satging2;

update layoff_satging2
set industry = 'Crypto'
where industry like 'Crypto%';

select distinct country
from layoff_satging2
order by country;

update layoff_satging2
set country = 'United States'
where country like 'United States%';

select date,
str_to_date(`date`, '%m/%d/%y')
from layoff_satging2;

update layoff_satging2
set `date` = str_to_date(`date`, '%m/%d/%y');

update layoff_satging2
set industry = 'Travel'
where company = 'Airbnb'
and industry = '';

alter table layoff_satging2
drop column row_num;

select *
from layoff_satging2
where percentage_laid_off = 1
order by total_laid_off desc;

select company, sum(total_laid_off) as laid_off
from layoff_satging2
group by 1
order by 2 desc;

select industry, sum(total_laid_off) as laid_off
from layoff_satging2
group by 1
order by 2 desc;

select country, sum(total_laid_off) as laid_off
from layoff_satging2
group by 1
order by 2 desc;






select count(*) from layoff_satging2;
