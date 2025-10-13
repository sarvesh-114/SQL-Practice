use GrexaAI;

create table comments_and_translations
(
	id				int,
	comment			varchar(100),
	translation		varchar(100)
);

insert into comments_and_translations values
(1, 'very good', null),
(2, 'good', null),
(3, 'bad', null),
(4, 'ordinary', null),
(5, 'cdcdcdcd', 'very bad'),
(6, 'excellent', null),
(7, 'ababab', 'not satisfied'),
(8, 'satisfied', null),
(9, 'aabbaabb', 'extraordinary'),
(10, 'ccddccbb', 'medium');

CREATE TABLE source
    (
        id      int,
        name    varchar(1)
    );

CREATE TABLE target
    (
        id      int,
        name    varchar(1)
    );

INSERT INTO source VALUES (1, 'A');
INSERT INTO source VALUES (2, 'B');
INSERT INTO source VALUES (3, 'C');
INSERT INTO source VALUES (4, 'D');

INSERT INTO target VALUES (1, 'A');
INSERT INTO target VALUES (2, 'B');
INSERT INTO target VALUES (4, 'X');
INSERT INTO target VALUES (5, 'F');


/* There are 10 IPL team. write an sql query such that each team play with every other team just once. */

create table teams
    (
        team_code       varchar(10),
        team_name       varchar(40)
    );

insert into teams values ('RCB', 'Royal Challengers Bangalore');
insert into teams values ('MI', 'Mumbai Indians');
insert into teams values ('CSK', 'Chennai Super Kings');
insert into teams values ('DC', 'Delhi Capitals');
insert into teams values ('RR', 'Rajasthan Royals');
insert into teams values ('SRH', 'Sunrisers Hyderbad');
insert into teams values ('PBKS', 'Punjab Kings');
insert into teams values ('KKR', 'Kolkata Knight Riders');
insert into teams values ('GT', 'Gujarat Titans');
insert into teams values ('LSG', 'Lucknow Super Giants');

select * from comments_and_translations;

/* Write an SQL query to display the correct message (meaningful message) from the input
comments_and_translation table. */

select case when translation is null then comment else translation 
end as Meaning_Full_Comments from comments_and_translations;

select coalesce(translation, comment) from comments_and_translations;

--Derived desired output
select s.id, 'Mismatch' as comment from source as s
join target as t on t.id = s.id 
where s.name <> t.name
union all
select s.id, 'New in Source' as commnet from source as s
left join target as t 
on t.id = s.id
where t.id is null
union all
select t.id, 'New in Target' as commnet from source as s
right join target as t 
on t.id = s.id
where s.id is null;


/* There are 10 IPL team. write an sql query such that each team play with every other team just once. */
with matches as 
	(select row_number() over(order by team_name) as id, team_code, team_name
	from  teams t)
select team.team_name, opponent.team_name
from matches as team join matches as opponent
on team.id<opponent.id;


