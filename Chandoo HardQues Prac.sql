SELECT * FROM `awesome chocolates`.people;

-- 1. sales in the first 7 days of January 
select distinct p.salesperson from people p inner join sales s on p.spid=s.spid
where s.saledate between '2022-01-01' and '2022-01-07';

-- 2. 
select * from people p left join sales s on p.spid=s.spid
where s.saledate between '2022-01-01' and '2022-01-07';

select p.salesperson from people p where p.spid not in(
select spid from sales where saledate between '2022-01-01' and '2022-01-07');

-- 3. 
-- more than 1000 boxes per day each month 
select year(saledate) as "Year",month(saledate) as m,count(boxes) as boxes
from sales where boxes>1000
group by year(saledate),month(saledate);

-- 4. 
select year(s.saledate) as "Year",month(s.saledate) as "month",sum(s.boxes) as "No. of shipment"
from products p inner join sales s on p.pid=s.pid 
inner join geo g on g.geoid=s.geoid  where p.product="After Nines" and g.geo="New Zealand"
group by year(s.saledate),month(s.saledate);

-- 5. 


select g.geo as c,year(s.saledate) as y,month(s.saledate) as m,sum(s.boxes)  as total
from products p inner join sales s on p.pid=s.pid 
inner join geo g on g.geoid=s.geoid
where g.geo in ('India', 'Australia')
group by g.geo,year(s.saledate),month(s.saledate)
order by year(s.saledate),month(s.saledate),total desc;

-- chandoo 
select year(s.saledate) as y, month(s.saledate) as m , 
sum(case when g.geo='India' then boxes else 0 end ) as Ind,
sum( case when g.geo='Australia' then boxes else 0 end ) as Aus
from products p inner join sales s on p.pid=s.pid 
inner join geo g on g.geoid=s.geoid
group by year(s.saledate),month(s.saledate);

















