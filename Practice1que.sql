select * from dept;
-- 47
select dept.dname,empno,ename
	from dept
	inner join empy on dept.deptno=empy.deptno;


-- 48.
select * from empy
	where sal>(select sal from empy where ename='blake');
-- 49.
/*
with t as (
select ename,job from empy where ename='allen')
select ename from empy where job=t.job;
*/
select ename  from empy
	where job in (select job from empy where ename='allen')
	ename<>'allen';
 
 -- 50.
 select ename from empy 
	where hiredate<(select hiredate from empy where ename='king');
 -- 51.
 select e.ename,e.hiredate,m.ename,m.hiredate
	from empy m inner join empy e
	on e.mgr=m.empno
	where e.hiredate<m.hiredate;
 -- 52.
 select ename from empy where deptno=20 and
 job in(select job from empy where deptno=10);
 -- 53.
 select ename,sal from empy
	where sal in(
    select sal from empy where ename in('Ford','smith'))
    order by sal desc;
    
    -- 55.
    select ename from empy where sal>
		(select sum(comm) from empy where job='salesman');
        
	-- 59.
select e.*,d.*
	from empy e inner join dept d    
	on e.deptno=d.deptno
    where sal in
		(select job from empy where deptno = 10 and
			job not in(select job from empy where deptno=20));
            
-- 61.
select max(sal) from empy;
-- 62.
select * from empy
	where sal = (select max(sal) from empy);

-- 63. 
select ename,sal from empy
    where sal=(select max(sal)from empy where deptno=30 group by deptno);
 
select x.ename,x.sal from
    (select deptno,ename,sal, 
	row_number() over(partition by deptno order by sal desc) as salary
	from empy) x where x.salary=1 and deptno=30;
    
select distinct x.name from
    (select deptno,ename,sal, 
	first_value(ename) over(partition by deptno order by sal desc) as name
	from empy) x where x.deptno=30;

-- 64.

select e.ename,hiredate,loc,grade from empy e
	 inner join dept d on e.deptno=d.deptno
     where grade=3 and loc='chicago'
     order by hiredate desc;
     
-- 65.

select * from empy where hiredate<(
select e.hiredate from empy e inner join empy m 
on e.mgr=m.empno
where m.ename='king'
order by hiredate desc limit 1);


-- 66.
select * from empy e
inner join dept d on e.deptno=d.deptno
where d.loc='New York' and grade in(3,4,5) and job<>'President'
and sal>(select max(sal) from empy where d.loc='chicago')
and job in('manager','salesman') and mgr<>(select empno from empy where ename='king');

select * from empy where deptno in (select deptno from dept where dept.loc
='NEW YORK')
and empno in (select empno from empy e where
e.grade in (3,4,5) ) and job != 'PRESIDENT' and sal >(select max(sal) from empy
where deptno in
(select deptno from dept where dept.loc = 'CHICAGO') and job in
('MANAGER','SALESMAN') and
mgr not in (select empno from empy where ename = 'KING')); 

-- 12th April 
-- 70.
select * from empy;
select * from dept;

select sum(sal) from empy where job='Manager';
-- 72.
select sum(sal) from empy where grade=3;
select avg(sal) from empy where job='clerk';

select deptno,job,count(ename) from 
empy group by deptno,job
order by deptno;

select deptno,count(*)
from empy group by deptno
having count(*)>=2;

select grade,count(*) as 'Number of Employees',max(sal)
from empy group by grade
order by grade;

select deptno, grade, count(*)
from empy
where deptno in (select deptno from (select deptno,count(*)
from empy where job='clerk'
group by deptno
having count(*)>=2)x)
group by deptno,grade;

select e.deptno,d.dname,count(e.ename) from empy e
right join dept d on d.deptno=e.deptno
group by e.deptno,d.dname
order by count(e.ename) desc;

-- greater than 3000 after 20% of increment 
select ename,sal,sal+0.20*sal as 'new sal' from empy
where sal+sal*0.20>3000;
select ename from empy where 1.2*sal>3000;

-- sal of emp is greater than managers 
select e.ename,e.sal,m.ename,m.sal from empy e join empy m
on e.mgr=m.empno
where e.sal>m.sal;

select ename,sal from empy 
where sal< ( select max(sal) from empy where grade
in (select grade from empy where ename ='Ford')) and ename='Ford';

select e.ename, e.sal from empy e where e.ename='Ford' and e.sal <
( select max(e2.sal) from empy e2 where e.grade=e2.grade);

-- employees with maximum salary in their respective department 
select * from empy where sal in ( 
select max(sal) as sal from empy 
group by deptno);

select * from (
select deptno,ename,sal,dense_rank() over(partition by deptno order by sal desc) as 'rank'
from empy) x where x.rank=1;

-- employee with average of maximum and minimum salary of the employees
select * from empy 
where sal in (select avg(total_sal) from
(
select max(sal)as total_sal from empy 
union
select min(sal) from empy
)x);

select deptno,count(*) from empy 
group by deptno
having count(*) >=3;

-- manager's salary more than the average of the employee's salary 
select distinct m.ename,m.job, m.sal from empy e 
join empy m on e.mgr=m.empno
where m.sal>( select avg(e.sal) from empy e2
where e2.mgr=m.empno);

select * from empy m where m.empno in (select mgr from empy)
 and m.sal > (select avg(e.sal) from empy e where e.mgr = m.empno ) ;

select  e.ename,e.job, e.sal,m.sal from empy e 
join empy m on e.mgr=m.empno
where e.sal<m.sal and e.sal> any(
select   m.sal from empy e 
join empy m on e.mgr=m.empno);

-- average salary department wise 
select * from empy e join (
select deptno, avg(sal) from empy 
group by deptno) x on e.deptno=x.deptno;



    
    
 