select distinct user_id
from survey

select *
from survey
where q1 != '0' AND q1 != '1' AND q1 != '2' AND q1 != '3' AND q1 != '4' AND q1 != '5' AND q1 != '6'

select * 
from survey 
where q4 = '4'

select * 
from survey 
where q3 = '0'

--This row returns the count of rows for each person that answered each question. 
select count(*) 
from survey 
where q4 = '0'
union 
select count(*) 
from survey 
where q4 = '1'
union
select count(*) 
from survey 
where q4 = '2'
union
select count(*) 
from survey 
where q4 = '3'
union
select count(*) 
from survey 
where q4 = '4'
union
select count(*) 
from survey 
where q4 = '5'

select * 
from survey 
where q4 = '2'

select count(*) 
from survey
where q2 = '1'

--Male/Female: the bad way to do it 
select count(*) 
from survey 
where q5 = '0'
union
select count(*)
from survey 
where q5 = '1'
union 
select count(*)
from survey 
where q5 is null

--Male/Female: the good way to do it 
select count(*), 
	   case when q5 = '0' then 'Male'
       when q5 = '1' then 'Female'
       else 'No response' end as gender
from survey
group by gender

--Computer skill level 
select count(*), 
	   case when q8 = '1' then '1'
       when q8 = '2' then '2'
       when q8 = '3' then '3'
       when q8 = '4' then '4'
       when q8 = '5' then '5'
       when q8 = '6' then '6'
       when q8 = '7' then '7'
       when q8 = '8' then '8'
       when q8 = '9' then '9'
       when q8 = '10' then '10'
       else 'no response' end as competency_level
from survey
group by competency_level
order by competency_level

--To check the work above
select *
from survey 
where q8 = '8'
       
--Where do they access the internet from. This is wrong
select count(*), 
	   case when q9 = '0' then 'Home'
       when q9 = '1' then 'Work'
       when q9 = '2' then 'School'
       when q9 = '3' then 'Mobile'
       else 'no response' end as device_type
from survey
group by device_type

--Everything that includes a 0
select count(q9), 
	   case when q9 like '%0%' then 'Home'
union
select count(q9), 
	   case when q9 like '%1%'


from survey 
group by access_point

select q9
from survey 
where q9 like '%0%'

select count(q9)
from survey 
where q9 like 


from survey 
where q9 like '%0%'

select count(*) 
from survey 

--Returns information on bookmark_status event code, trims values, and converts text into ints
select user_id, cast(replace(data1, 'total bookmarks', '') as int), 
				cast(replace(data2, 'folders', '') as int), 
                cast(replace(data3, 'folder depth', '') as int)
from events
where event_code = 8

--Let's just look at users with fewer than 500 bookmarks 
select user_id, cast(replace(data1, 'total bookmarks', '') as int)            
from events 
where event_code = 8 and cast(replace(data1, 'total bookmarks', '') as int) < 500

--Now let's look at bookmark creation. Returns number of new bookmark folders added
select count(user_id), data1 
from events
where event_code = 9 and data1 != 'New Bookmark Added'
--Other category is 'New Bookmark Added'
group by data1

select distinct user_id
from events
where event_code = 10 or event_code = 11 or event_code = 9
--and data1 = 'Bookmark Moved'

--Next join the above user_ids to the survey and find out more about these users in particular 

 
--Joining... 
select a.user_id
from events a join survey b 
on a.user_id = b.user_id

select * 
from events
limit 100
 






