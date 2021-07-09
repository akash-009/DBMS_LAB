create database order_processing;
use order_processing;

	 -- CUSTOMER (CUST #: int, cname: String, city: String)
create table  customer(
cust int primary key,
cname varchar(20),
city varchar(20));

insert into customer values 
(1,'anand','punjab'),
(2,'bhaskar','chennai'),
(3,'chetan','banglore'),
(4,'vivek','manglore'),
(5,'rohit','gujrat');

	-- ORDER (order #: int, odate: date, cust #: int, ord-Amt: int)
create table _order (
_order int primary key,
odate timestamp,
cust int ,
ordAmt int ,
foreign key (cust) references customer (cust));
alter table _order
modify odate date;


insert into _order values 
(23,'2021/02/02',1,2000);
insert into _order values
(24,'2020/04/23',2,3500),
(25,'2021/01/24',3,1000),
(26,'2021/03/04',4,2000),
(27,'2021/04/12',5,3400);

select * from _order;
	-- ITEM (item #: int, unit-price: int)
create table item
( item int primary key,
  unitprice int);
insert into item values
(90,200),(89,340),(91,100),(45,500),(30,900),(21,1000),(34,650);

	-- ORDER-ITEM (order #: int, item #: int, qty: int)
create table _orderitem
( _order int,
  item int,
  qty int,
  foreign key (_order) references _order (_order),
  foreign key (item)  references item(item));
  
  insert into _orderitem values
  (23,34,4),
  (24,21,5),
  (25,30,2),
  (25,90,1),
  (26,45,3),
  (27,89,1),
  (27,90,2);
  
  
  -- WAREHOUSE (warehouse #: int, city: String)
  create table warehouse( 
  warehouse int primary key,
  city varchar(20));
  insert into warehouse values
  (31,'banglore'),
  (32,'chennai'),
  (33,'delhi'),
  (34,'manglore'),
  (35,'gujrat'),
  (36,'punjab');
  
  -- SHIPMENT (order #: int, warehouse #: int, ship-date: date)
  create table shipment(
  _order int,
  warehouse int,
  shipdate date,
  foreign key (_order) references _order (_order),
  foreign key (warehouse) references warehouse(warehouse));
  
  
  insert into shipment values
  (23,36,'2020/02/21'),
  (24,35,'2021/04/05'),
  (25,34,'2020/05/29'),
  (26,31,'2021/09/04'),
  (27,32,'2020/08/24');
  
  
  -- iii. Produce a listing: CUSTNAME, #oforders, AVG_ORDER_AMT, where the middle column is the total 
  -- numbers of orders by the customer and the last column is the average order amount for that customer.

  select c.cname,count(*) as count ,avg(o.ordAmt) as AVG_ORDER_AMT 
  from customer c, _order o
  where c.cust =o.cust
  group by c.cname;
  
  
  -- iv. List the order# for orders that were shipped from all warehouses that the company has in a specific city.
 select s._order ,s.shipdate
 from shipment s, warehouse w where s.warehouse=w.warehouse and city='banglore';
 
 -- v. Demonstrate how you delete item# 10 from the ITEM table and make that field null in the ORDER_ITEM table
delete item 
from item 
where item=90;