create database book_dealer;
use book_dealer;
-- AUTHOR(author-id: int, name: String, city: String, country: String)
create table author(
author_id int  primary key,
name varchar (20),
city varchar (20),
country varchar(20));


  -- PUBLISHER(publisher-id: int, name: String, city: String, country: String)
  create table publisher (
  publisher_id int primary key,
  name varchar(20),
  city varchar(20),
  country varchar(20));

	-- CATEGORY(category-id: int, description: String)
    create table category (
    category_id int primary key,
    description varchar(50));
    
-- CATALOG (book-id: int, title: String, author-id: int, publisher-id: int, category-id: int, year: int, price: int)
create table catalog (
book_id int primary key ,
title varchar(30),
author_id int,
publisher_id int, 
category_id int,
year int,
price int,
foreign key (author_id) references author (author_id) ,
foreign key (publisher_id) references publisher(publisher_id),
foreign key (category_id) references category (category_id));

-- ORDER-DETAILS(order-no: int, book-id: int, quantity: int)
create table order_details(
order_no int primary key ,
book_id int,
quantity int,
foreign key (book_id) references catalog(book_id));


 insert into author  values 

 (101, 'ABC' ,'DELHI' ,'INDIA'),
 (102 ,'TONY', 'HAYHOOD' ,'USA'),
 (103 ,'GHI' ,'PATNA' ,'INDIA'),
 (104, 'JKL', 'BELM' ,'SRILANKA'),
 (105 ,'MND' ,'BANGALORE' ,'INDIA');
 

INSERT INTO publisher values
(1001,'pbp' ,'blore' ,'INDIA'),
(1002, 'palk' ,'slaugh' ,'england'),
(1003, 'press' ,'tata' ,'INDIA'),
(1004 ,'rathe' ,'angakara' ,'SRILANKA'),
(1005 ,'pbp', 'blore' ,'INDIA');


INSERT INTO category values
(10001, 'cs'),
(10002, 'med'),
(10003, 'bio'),
(10004, 'meteor'),
(10005, 'mech'); 


INSERT INTO catalog values 
(1000001, 'dbms', 101, 1001, 10001, 1998 ,235),
(1000002 ,'or' ,101 ,1002 ,10003 ,1997 ,255),
(1000003 ,'cn', 102, 1003, 10002 ,2001 ,352),
(1000004 ,'se' ,102 ,1003 ,10001 ,2002 ,523),
(1000005 ,'ada' ,103, 1004, 10004, 2003 ,124);


INSERT INTO order_details values
(1 ,1000001, 12),
(2 ,1000002 ,15),
(3 ,1000003 ,23),
(4 ,1000003 ,14),
(5, 1000005 ,7);



		
 -- used for getting relation structure and data 
select * from author a,publisher p,catalog c,order_details o,category ca
where a.author_id=c.author_id and p.publisher_id=c.publisher_id and ca.category_id=c.category_id and c.book_id=o.book_id;



-- iii. Give the details of the authors who have 2 or more books in the catalog and the price of the books in the 
-- catalog and the year of publication is after 2000.

select a.*
from author a,catalog c
where a.author_id=c.author_id and c.year>2000
group by c.author_id 
having count(*)>1;

-- iv. Find the author of the book which has maximum sales.
set @temp := (select max(quantity) from order_details);   -- @tenp is variable
select a.name 
from author a, catalog c, order_details o
where a.author_id=c.author_id and  c.book_id =o.book_id and o.quantity=@temp;  


-- v. Demonstrate how you increase the price of books published by a specific publisher by 10%.
UPDATE CATALOG c , author a
SET PRICE=PRICE*0.1+PRICE
WHERE c.author_id=a.author_id and a.name ='TONY';