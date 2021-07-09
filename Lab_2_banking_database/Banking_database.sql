create database banking;
use banking;

create table Branch (
BranchName varchar(30),
BranchCity varchar(20),
Assets int 
);
alter table Branch add primary key (BranchName);
desc Branch;


create table BankAccount (
Accno int ,
BranchName varchar(30),
Balance int,
foreign key (BranchName)  references Branch(BranchName)
);
alter table BankAccount add primary key(Accno);
desc BankAccount;


create table BankCustomer (
CustomerName varchar(20) primary key,
CustomerStreet varchar(30) ,
CustomerCity varchar(20)
);
desc BankCustomer;

create table Loan (
LoanNumber int primary  key,
BranchName varchar(30) ,
Amount int,
foreign key (BranchName) references Branch(BranchName)
);
desc Loan;


create table Depositor (
CustomerName varchar(20),
Accno int  ,
foreign key (CustomerName) references BankCustomer (CustomerName),
foreign key (Accno) references BankAccount(Accno)
);
desc Depositor;


insert into Branch values
('SBI_chamrajpet','Banglore',50000),
('SBI_residencyRoad','Banglore',10000),
('SBI_shivajiRoad','Bombay',20000),
('SBI_parlimentRoad','Delhi',10000),
('SBI_jantarmantar','Delhi',20000);

select * from Branch order by BranchCity ;

insert into  BankAccount values
(1,'SBI_chamrajpet',20000),
(2,'SBI_residencyRoad',5000),
(3,'SBI_shivajiRoad',6000),
(4,'SBI_parlimentRoad',9000),
(5,'SBI_jantarmantar',8000),
(6,'SBI_shivajiRoad',4000),
(8,'SBI_residencyRoad',4000),
(9,'SBI_parlimentRoad',3000),
(10,'SBI_residencyRoad',5000),
(11,'SBI_jantarmantar',2000);
select * from BankAccount;

insert into BankCustomer  values
('Avinash','Bull temple road','Banglore'),
('Dinesh','Bannergatta road','Banglore'),
('Mohan','National college road','Banglore'),
('Nikil','Akbar road','Delhi'),
('Ravi','Prithviraj road','Delhi');

insert into Depositor values
('Avinash',1),
('Dinesh',2),
('Nikil',4),
('Ravi',5),
('Avinash',8),
('Nikil',9),
('Dinesh',10),
('Nikil',11);



insert into Loan values
(1,'SBI_chamrajpet',1000),
(2,'SBI_residencyRoad',2000),
(3,'SBI_shivajiRoad',3000),
(4,'SBI_parlimentRoad',4000),
(5,'SBI_jantarmantar',5000);

 -- iii. Find all the customers who have at least two accounts at the Main branch.
 
 select CustomerName 
 from Depositor 
 where Accno in (select Accno
				from BankAccount 
				group by  BranchName )
 group by CustomerName 
 having  count(*)>1;
 
 
  -- iv. Find all the customers who have an account at all the branches located in a specific city.

                              
                              
select distinct CustomerName 
        from Depositor
        where Accno in (select Accno
						from BankAccount 
                        where BranchName in (select  BranchName 
												from Branch
                                                where BranchCity ='Banglore'))
		group by CustomerName having count(distinct Accno)>=(select count(*) from Branch
															where BranchCity ='Banglore');                              
   