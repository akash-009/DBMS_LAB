create database airline;
use airline;
 
 -- FLIGHTS (flno: integer, origin: string, destination: string, distance: integer, departs: time, arrives: time, price: integer) 
 
 create table flights
 ( flno int primary key,
   origin varchar(20),
	destination varchar(20),
   distance int,
   departs timestamp,
   arrives timestamp,
   price int );
   desc flights;
   
   
 insert into flights values(101,'Bangalore','Delhi',2500, '2005-05-13 07:15:31', '2005-05-13 17:15:31',5000);

 insert into flights values(102,'Bangalore','Lucknow',3000, '2005-05-13 07:15:31', '2005-05-13 11:15:31',6000);

 insert into flights values(103,'Lucknow','Delhi',500, '2005-05-13 12:15:31', '2005-05-13 17:15:31',3000);

 insert into flights values(107,'Bangalore','Frankfurt',8000, '2005-05-13 07:15:31', '2005-05-13 22:15:31',60000);

 insert into flights values(104,'Bangalore','Frankfurt',8500, '2005-05-13 07:15:31', '2005-05-13 23:15:31',75000);

 insert into flights values(105,'Kolkata','Delhi',3400,'2005-05-13 07:15:31', '2005-05-13 09:15:31',7000);
select *from flights;


   -- AIRCRAFT (aid: integer, aname: string, cruisingrange: integer) 
   create table aircraft (
   aid int primary key,
   aname varchar(20),
   cruisingrange int);
   
 insert into aircraft values(101,'747',3000);
 insert into aircraft values(102,'Boeing',900);
 insert into aircraft values(103,'647',800);
 insert into aircraft values(104,'Dreamliner',10000);
 insert into aircraft values(105,'Boeing',3500);
 insert into aircraft values(106,'707',1500);
 insert into aircraft values(107,'Dream', 120000);
  select *from aircraft; 
   -- EMPLOYEE (eid: integer, ename: string, salary: integer)
   create table employee (
   eid int  primary key,
   ename varchar(30),
   salary int);
  
  
 insert into employee values(701,'A',50000);

 insert into employee values(702,'B',100000);

 insert into employee values(703,'C',150000);

 insert into employee values(704,'D',90000);

 insert into employee values(705,'E',40000);

 insert into employee values(706,'F',60000);

 insert into employee values(707,'G',90000);
   
   -- CERTIFIED (eid: integer, aid: integer)
   create table certified (
   eid int,
   aid int,
   foreign key (eid) references employee(eid),
   foreign key (aid) references aircraft(aid));
   desc certified;
   
   
  insert into certified values(701,101);

 insert into certified values(701,102);

 insert into certified values(701,106);

 insert into certified values(701,105);

 insert into certified values(702,104);

 insert into certified values(703,104);

 insert into certified values(704,104);

 insert into certified values(702,107);

 insert into certified values(703,107);

 insert into certified values(704,107);

 insert into certified values(702,101);

 insert into certified values(703,105);

 insert into certified values(704,105);

 insert into certified values(705,103);

select * from certified order by eid;


  --  i. Find the names of aircraft such that all pilots certified to operate them have salaries more than Rs.80,000.
    -- 1 way
   select aname from aircraft
   where aid in (select aid from certified
   where eid in (select eid from employee
   where salary > 80000));
   
   -- 2 way
   select distinct a.aname 
   from aircraft a, employee e, certified c
   where a.aid =c.aid and c.eid = e.eid and e.salary > 80000;
   
 -- ii. For each pilot who is certified for more than three aircrafts, find the eid and the maximum cruising range of 
  -- the aircraft for which she or he is certified.
  select c.eid,max(a.cruisingrange)
  from certified c, aircraft a
  where c.aid=a.aid
  group by c.eid
  having count(*)>3;
  
 -- iii. Find the names of pilots whose salary is less than the price of the cheapest route from Bengaluru to Frankfurt.
 select e.ename 
 from employee e
 where e.salary <(select MIN(f.price)
 from flights f
 where f.origin='Bangalore' and f.destination='Frankfurt');
 -- iv. For all aircraft with cruising range over 1000 Kms, find the name of the aircraft and the average salary of all pilots certified for this aircraft.
 select a.aname,avg(e.salary)
 from aircraft a,employee e,certified c
 where   e.eid=c.eid and c.aid=a.aid and a.cruisingrange >1000
 group by a.aid;
-- v. Find the names of pilots certified for some Boeing aircraft.
select distinct e.ename 
from employee e,aircraft a,certified c
where e.eid=c.eid and c.aid=a.aid and  a.aname like'Boeing%';

-- vi. Find the aids of all aircraft that can be used on routes from Banglore to  Delhi.
select a.aid 
from aircraft a
where a.cruisingrange > (select min(f.distance) 
						from flights f
                        where f.origin='Bangalore' and f.destination='Delhi');
                                                

-- vii. A customer wants to travel from    Banglore jto Delhi with no more than two changes of flight. List the 
-- choice of departure times from Madison if the customer wants to arrive in New York by 6 p.m.


-- viii. Print the name and salary of every non-pilot whose salary is more than the average salary for pilots.
SELECT E.ename, E.salary
FROM employee E
WHERE E.eid NOT IN ( SELECT DISTINCT C.eid
FROM certified C )
AND E.salary >( SELECT AVG (E1.salary)
FROM employee E1
WHERE E1.eid IN
( SELECT DISTINCT C1.eid
FROM certified C1 ) );