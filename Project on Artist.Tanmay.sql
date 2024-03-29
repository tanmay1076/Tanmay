create database paintings;

use paintings;  -- full_name ,name , museum_id,

show tables;
select * from artist;
select * from museum;
select * from work;
select * from subject;
select * from product_size;
select * from museum_hours;
select * from image_link;
selecT * from canvas_size;
-- Joining Tables:
-- 1. Retrieve the full name of artists along with the names of the museums where their works are displayed.
select * from artist 
inner join 
work
on artist.artist_id=work.artist_id
inner join 
museum 
on work.museum_id=museum.museum_id
;


-- 2. Group By and Count:
-- How many works does each artist have in the database? Display the artist's full name along with the count of their works, ordered by the count in descending order.
select full_name ,count(work_id) as total_count from artist
left join 
work
on artist.artist_id=work.artist_id
group by artist.full_name
order by total_count desc;

-- 3. Order By and Limit:
-- List the top 5 museums with the highest number of works displayed in the database, along with their respective counts.

select * from work;
select * from museum;
select count(work_id) as total_count from museum
left join 
work 
on museum.museum_id=work.museum_id
order by total_count
limit 5;


-- 4. Join, Order By, and Limit:
-- Display the names and styles of the works along with the corresponding museum names, ordered by the museum name in ascending order. Limit the results to 10.
select museum_name,name,style,work_id from work
left join 
museum 
on work.museum_id=museum.museum_id
order by museum_name asc
limit 10;

alter table museum 
change `name` museum_name varchar(50);


-- 5.Join, Group By, and Sum:
-- Show the total sale price for each artist's works. Display the artist's full name along with the total sale price, ordered by the total sale price in descending order.
select full_name,count(sale_price) as TOTALSALEPRICE from artist
left join 
work
on artist.artist_id=work.artist_id
left join 
product_size
on
work.work_id=product_size.work_id
group by full_name
order by TOTALSALEPRICE desc;




-- 6. Join, Group By, and Having:
-- List artists who have more than 3 works in the database, along with the count of their works.
select a.full_name,a.artist_id,count(work_id) as Top_3_Works from artist as a
join
work as w
on a.artist_id=w.artist_id
group by a.full_name,a.artist_id
having count(w.work_id)>3
order by Top_3_works asc;

-- How to find weather you have duplicates in your coloum or not
select * from work
where name 
in
(select name 
from work
group by name
having count(*)>1);

select distinct(name) from work;

-- 7. Join, Where, and Order By:
-- Retrieve the names of works and their corresponding artists' full names for works
-- that have a sale price smaller than their regular price. 
select a.full_name,
w.name,
w.work_id from artist as a
inner join work as w
on a.artist_id=w.artist_id
join 
product_size as p
on w.work_id=p.work_id
where (p.sale_price<p.regular_price)
group by a.full_name,w.name,w.work_id;


-- 8. Join, Group By, and Average:
-- Calculate the average height and width of the artworks in the database. Display the average height and width.
select w.name, avg(width) as AVERAGE_WIDTH, avg(height) as AVERAGE_HEIGHT
from canvas_size  as c 
inner join 
product_size as p 
on c.size_id=p.size_id
join 
work as w
on w.work_id=p.work_id
group by w.name; 
 --  or 
 select avg(width) as AVERAGE_WIDTH, avg(height) as AVERAGE_HEIGHT
from canvas_size;


-- Join, Group By, and Max:
-- 9 Find the maximum sale price among all the works in each museum. 
-- Display the museum name along with the maximum sale price.

select museum_name, max(sale_price) as MAXIMIUM_SALE_PRICE
FROM museum 
left join 
work
on museum.museum_id=work.museum_id
join 
product_size 
on work.work_id=product_size.work_id
group by museum_name;

-- Join, Group By, and Concatenate:
-- 10. Concatenate the first name and last name of artists along with their nationality, separated by a comma. Display the concatenated string along with the count of works by each artist, ordered by the count in descending order.
select concat_ws(' , ',first_name,last_name,nationality) as personalinfo, 
count(work_id)  as COUNT_TOTAL from artist
inner join 
work 
on artist.artist_id=work.artist_id
group by personalinfo
order by COUNT_TOTAL desc;




