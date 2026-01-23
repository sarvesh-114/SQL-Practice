-- 1. List all videos and their creator name
select v.video_id, v.title, c.creator_name
from creators as c
join videos as v
on c.creator_id = v.creator_id

--2. count total videos per creators
select c.creator_id, c.creator_name, count(v.video_id) as total_videos
from creators as c
join videos as v
on c.creator_id = v.creator_id
group by c.creator_id, c.creator_name
order by total_videos desc

--3.get total commets for given video

select v.video_id, v.title, sum(c.comment_id) as total_comments
from videos as v
join comments as c
on v.video_id = c.video_id
group by v.video_id, v.title
order by v.video_id;

--4. list videos publish in last 18 months
select * from videos
where publish_date >= dateadd(MM, -18, getdate());

--5. Find the videos longer than 20 min
select * from videos
where duration_seconds/60 > 20;

--6. show top 10 videos by total views
select top 10 v.video_id, v.title, sum(dv.views) as total_views
from videos as v
join daily_views as dv
on v.video_id = dv.video_id
group by v.video_id, v.title
order by total_views desc;

--7. show unique categories
select distinct category
from videos;

--8.count creators per country
select country, count(country) as total_creators
from creators
group by country;
