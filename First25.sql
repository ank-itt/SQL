-- tables 
SELECT * FROM Practice1.EMPY;
SELECT * FROM Practice1.DEPT;

-- 1. 
select * from empy;
-- 2. 
select distinct job from empy;
-- 3. 
select ename from empy order by sal;
-- 4. 

select * from empy order by deptno,job desc;
-- 5.
select distinct job from empy order by job desc;

-- 6. 
select * from empy where job='Manager';
-- 7. year() retrives the year 
select ename from empy where year(hiredate)<1981;

-- 8.

select empno,ename,sal, round((sal/365),2)
 as daily_sal from empy order by sal;
 
 -- 9 
-- experience of emps 
 select  concat( datediff(current_date(),hiredate) div 365," years ",datediff(current_date(),hiredate) % 365 div 30,' months')
 as 'Exp'  from empy;
 
 SELECT CONCAT(
    TIMESTAMPDIFF(YEAR, hiredate, now()),
    ' years ',
    MOD(TIMESTAMPDIFF(MONTH, hiredate, CURRENT_DATE()), 12),
    ' months'
) AS 'Exp'
FROM empy;

 -- 10.
 select e.*
 from empy m inner join empy e
 on e.mgr=m.empno
 where e.mgr=7369;
 
 -- 11.
 select a.*
 from empy a inner join empy b 
 on a.empno=b.empno
 where a.sal<b.comm;
 
 -- 12. 
 select ename,job,hiredate
 from empy
 where hiredate>'1981-06-30'
 order by length(job);
 
 -- 13.
 select ename,round((sal/365),2) as Daily_sal,CONCAT(
    TIMESTAMPDIFF(YEAR, hiredate, now()),
    ' years ',
    MOD(TIMESTAMPDIFF(MONTH, hiredate, CURRENT_DATE()), 12),
    ' months'
) AS 'Exp'
from empy where sal/365>100;

-- 14.
select ename from empy where job in('CLERK','ANALYST') order by job desc;
-- 15. 
select ename,hiredate from empy 
where hiredate in('1981-05-01','1981-12-03','1981-12-17','1980-01-19')
order by hiredate desc;
-- 16.
select ename,deptno from empy
where deptno in(10,20);
-- 17.
select ename,hiredate from empy
where year(hiredate)=1981;
-- 18.
select ename, hiredate from empy
where hiredate like '1980-08%';

-- 19.
select ename, sal*12 as Annual_Sal from empy
where sal*12 between 22000 and 45000;

-- 20.
select ename from empy
where length(ename)=5;
-- 21.
select ename from empy 
where ename like 'S%' and length(ename)=5;

-- 22.
select ename from empy
where ename like '__r_';
-- 23.
select ename from empy
where length(ename)=5 and ename like 'S%H';

-- 24.
select ename,month(hiredate) as month
from empy
where month(hiredate)=1;
-- 25.
select ename,monthname(hiredate) from empy
where monthname(hiredate) like '_a%';

