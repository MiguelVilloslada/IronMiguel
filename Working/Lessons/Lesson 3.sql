use bank
# how many clients per district?

select A2 as districtname, A3 as regionname, count(distinct client_id) as noofclients
from district #left table
LEFT JOIN client #right table
ON district.A1 = client.district_id #join clause(s)
group by A2, A3;
 -- USING() if the fields are named the same
 
#creating alias for the tables
select d.A2 as districtname, d.A3 as regionname, count(distinct c.client_id) as noofclients
from district d#left table
LEFT JOIN client c #right table
ON d.A1 = c.district_id #join clause(s) ON if the field is not same
group by d.A2, d.A3;

select * from district
Left Join client
on district.A1 = client.district_id;

#how many loans and avg(amount) per account?
select a.account_id, a.date, count(l.loan_id), avg(l.amount)
from loan l #left table
Inner join account a #right table
using(account_id) #join table USING if the field is the same
group by account_id, a.date #aggreg process

#Activity 3
#Get a list of districts ordered by the number of clients (descending order). Name the columns as: District_name and Number_of_clients respectively.
Select A2 as district_name, count(distinct client_id) as number_of_clients 
From district
JOIN client 
on district.A1 = client.district_id
group by A2
order by number_of_clients DESC;

#Get a list of regions ordered by the number of clients (descending order). Name the columns as: Region_name and Number_of_clients respectively.
Select A3 as region_name, count(distinct client_id) as number_of_clients 
From district
JOIN client 
on district.A1 = client.district_id
group by A3
order by number_of_clients DESC;

#Get the number of accounts opened by district and year. Name the columns as: District_name, Year and Accounts_opened. Order the results by District_name and Year.

Select A2 as district_name, date_format(date,'%Y') as Year, count(account_id) as Accounts_opened from district
join account
on A1=district_id
group by A2, date_format(date,'%Y')
order by A2, date_format(date,'%Y');

#example where left and right matters. The order of the tables matters. 
select * from account
left join loan #account with no loans
using(account_id);

select * from account
right join loan #account with loans
using(account_id);

#what about joining more than two tables loan-account-district 
#how many loans per region

Select d.A3 region, count(l.loan_id) as noofloans, count(a.account_id) as noofaccounts 
from loan l
inner Join account a
using(account_id)
inner Join district d
on a.district_id=d.A1
group by d.A3;

Select d.A3 as region, 
count(l.loan_id) as noofloans, 
count(a.account_id) as noofaccounts, 
count(c.client_id) as noofclients
from loan l
inner join account a using(account_id)
inner join disp dp using (account_id)
inner join client c using (client_id)
inner join district d on a.district_id = d.A1
where dp.type='OWNER'
group by A3;

#Activity 4
#Extend the query below and list district_name, client_id, and account_id for those clients who are the owner of the account. 
#Order the results by district_name:


select da.A2 as district_name, c.client_id, d.account_id 
from disp d
join client c using(client_id)
join district da on c.district_id=da.A1
Where d.type='owner'
order by da.A2;

# --DDL (definition) and DML (manipulate)
#create alter drop truncate rename update

drop database booksauthors;
create database booksauthors;
use booksauthors;

drop table if exists authors;
Create table authors
(
author_id int auto_increment not null,
authorname varchar(30) default null,
country varchar(30) default null,
Primary key (author_id)
);

drop table if exists books;
Create table books
(
book_id int auto_increment not null,
author_id INT NOT NULL,
bookname varchar(50) default null,
primary key (book_id),
KEY idx_fk_author_id(author_id),
CONSTRAINT fk_author_id FOREIGN KEY (author_id)
REFERENCES authors(author_id) ON DELETE RESTRICT ON UPDATE CASCADE
);


insert into authors(authorname,country)
Values('Richard H. Thaler','USA'),('Sebastien Page','USA'), ('Eva García Sáenz','Spain'),('Guillem Balagué','Spain'),('Jordan Mackay','USA');
select * from authors;

insert into books (bookname, author_id)
Values('Misbehaving',1),('Beyond Diversification',2),('Aquitania',3),('Pep Guardiola',4),('Secrets of the Sommeliers',5);
select * from books;

Select * from books
right join authors
using(author_id);

use bank;

#Create a view
CREATE VIEW clients_loans_combo AS
Select c.client_id, c.district_id, l.loan_id, l.status, l.amount, l.duration, l.payments,l.date as loan_date
from client c
join disp dp using(client_id)
join account a using(account_id)
join loan l using(account_id)
where dp.type= 'OWNER'
;

Select * from clients_loans_combo;

#SUBQUERY=a query inside a query

#step 2 outer query
#step 1 (inner query) - check it

-- which loans are bigger than average
select * from loan where amount>
(select avg(amount) from loan);

-- one value (=>), a column of values (in), a table of values (subquery needs an alias)

select avg(amount) from loan;

#Find out the average of the number of transactions by account.
#Hint: Compute first the number of transactions by account.
select * from trans;
#option 1 create a view
create view acctrans as
select account_id, count(trans_id) as transact from trans
group by account_id;

#option2 querey and subquery
select avg(transact) from (select account_id, count(trans_id) as transact from trans
group by account_id) as s;

Select avg(select count(trans_id), account_id from trans
group by account_id); # inneer query

#get a list of accounts from Central Bohemia using a subquery.
#rewrite the previous as join query
select account_id from account where district_id in
(select A1 from district where A3 Like 'c%Bohemia');

select account_id from account
join district
on account.district_id=district.A1
where A3 = 'central Bohemia';

# CTE's common table expressions we want to join x + y but x does not exist
-- transactions table - get the total amount for each account and any acc info
-- then draw on that table to get information
-- use that table to join to another table

with cte_loan as (select * from loan)
select loan_id from cte_loan
where status = 'B'; 


#Find the most active customer for each district in Central Bohemia using at least one CTE.



