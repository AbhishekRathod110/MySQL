-- DATABASE
-- TABLES

-- DDL (DATA DEFINITION LANGUAGE) --> CREATE,ALTER,DROP,TRUNCATE
-- DML (DATA MANUPLATION LANGUAGE) --> INSERT,UPDATE,DELETE
-- DCL (DATA CONTROL LANGUAGE) --> GRANT,REVOKE
-- TCL (TRANSACTION CONTROL LANGUAGE) --> COMMIT,ROLLBACK,SAVEPOINT
-- DQL (DATA QUERY LANGUAGE) --> SELECT

-- CONTSRAINTS
-- 	UNIQUE
-- 	NOT NULL
-- 	PRIMARY KEY
-- 	FOREIGN KEY
-- 	CHECK
-- 	DEFAULT

-- AUTO INCREMENT

-- ALTER TABLE

-- JOIN
-- 	INNER
-- 	OUTER
-- 		LEFT
-- 		RIGHT
-- 		FULL
-- SUB QUERY
-- VIEW
-- INDEX
-- FUNCTIONS
-- 	NUMBERIC
-- 	STRINGS
-- 	DATE
-- 	SPECIAL

-- PLSQL
-- 	IF ELSE
-- 	LOOP
-- 	PROCEDURE	
-- 	FUNCTION
-- 	CURSOR
-- 	TRIGGER

-- **********  ORDER OF EXECUTION OF STATEMENTS IN MYSQL -
-- FROM clause
-- WHERE clause
-- GROUP BY clause
-- HAVING clause
-- SELECT clause
-- ORDER BY clause

-- DAY 1 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

create database custdb;
-- drop database custdb;

use custdb;

show databases;

create table employee(
empid int,
empname varchar(50),
age int,
gender char(1),
city varchar(50)
);

-- DATA TYPE
-- CHAR --> for fixed char length  
-- VARCHAR --> for var char length
-- INT --> for storing numbers
-- DATE --> for storing date
-- DECIMAL --> for storing float values
-- BOOLEAN --> true,false,none	

insert into employee values(1001,'RAMAN',26,'M','PUNE');
insert into employee values(1002,'ROHAN',25,'M','PUNE');

SELECT * FROM EMPLOYEE;

insert into employee(EMPID,EMPNAME,age,GENDER,CITY) values(1003,'AWNI',25,'M','PUNE');
insert into employee values(1004,'Suraj',27,'M','CHENNAI');
insert into employee values(1005,'Akash',24,'M','MUMBAI');
delete from employee where empid = 1003;
insert into employee(EMPID,EMPNAME,age,GENDER,CITY) values(1003,'AWNI',25,'M','PUNE');
insert into employee values(1006,'Hinata',23,'F','PUNE');
insert into employee values(1007,'Sakura',24,'F','DELHI');

SELECT * 
FROM employee 
WHERE AGE LIKE "%4%";




-- UPDATE --> HOW TO UPDATE DATA
SET SQL_SAFE_UPDATES=0;
update EMPLOYEE SET CITY='GURUGRAM' WHERE EMPID=1002;
update EMPLOYEE SET AGE=25 WHERE EMPID=1001;
update EMPLOYEE SET CITY='GURUGRAM' WHERE GENDER='M';
update EMPLOYEE SET CITY='PUNE' , AGE=26 WHERE EMPID=1001;
update EMPLOYEE SET CITY='DELHI' WHERE empid =1002;
update EMPLOYEE SET empid =1008 WHERE empid =1002;
update EMPLOYEE SET empid =1002 WHERE empid =1008;

-- DAY 2 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

use custdb;
SET SQL_SAFE_UPDATES=0;
SELECT * FROM EMPLOYEE;

SELECT * FROM employee WHERE gender='M';
SELECT * FROM employee WHERE gender!='M';
select * from employee where city = "pune";
select * from employee where city = "pune" or city = "gurugram";
select * from employee where gender = "M" and age>25;

select empname,age from employee;
insert into employee(EMPID,EMPNAME,GENDER,CITY) values(1010,'zinga','M','PUNE');
update EMPLOYEE SET CITY='GURUGRAM' WHERE empid =1010;
SELECT * FROM EMPLOYEE;

-- -----------coalesce()------------------------------------------------------------

select empname,coalesce(age,0) as age from employee;
select empname,coalesce(age,0) as age, if(age>25,'senior','junior') as seniority  from employee;


select * from company;
SELECT company, age, salary, place FROM company WHERE age < 30 AND Place != 'Chennai';
insert into company values("tcs",35,2000,"GURUGRAM","INDIA",0);
UPDATE COMPANY SET PLACE="" WHERE PLACE="GURUGRAM";


-- DAY 3 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

-- Delete data

Set sql_safe_updates=0;
select * from company where Place="";
delete from company where Place="";

-- CONSTRAINTS >>>>
-- UNIQUE
-- NOT NULL
-- CHECK
-- DEFAULT
-- PRIMARY KEY
-- FOREIGN KEY

CREATE TABLE unique_table(
custid INT UNIQUE,
custname VARCHAR(50),
age INT,
city VARCHAR(20)
);

INSERT INTO unique_table VALUES(1000,'Raja',35,'Chennai');
SELECT * FROM unique_table;
INSERT INTO unique_table VALUES(1000,'Bala',40,'Hyderabad');  -- ERROR because 1000 is duplciate
INSERT INTO unique_table VALUES(1001,'Bala',40,'Hyderabad');
INSERT INTO unique_table(custname, age, city) VALUES('Priya',30,'Pune');
INSERT INTO unique_table(custname, age, city) VALUES('Sakshi',33,'Kolkatta');

-- -------------------------------------------------------------------------

CREATE TABLE notnull_table(
custid INT NOT NULL,
custname VARCHAR(50),
age INT,
city VARCHAR(20)
);

INSERT INTO notnull_table VALUES(1000,'Raja',35,'Chennai');
SELECT * FROM notnull_table;
INSERT INTO notnull_table VALUES(1000,'Bala',40,'Hyderabad');
INSERT INTO notnull_table(custname, age, city) VALUES('Priya',30,'Pune');  -- ERROR SINCE custid column is NULL

-- -------------------------------------------------------------------------
CREATE TABLE unique_notnull_table(
custid INT UNIQUE NOT NULL,
custname VARCHAR(50),
age INT,
city VARCHAR(20)
);

INSERT INTO unique_notnull_table VALUES(1000,'Raja',35,'Chennai');
SELECT * FROM unique_notnull_table;
INSERT INTO unique_notnull_table VALUES(1000,'Bala',40,'Hyderabad');  -- ERROR since 1000 is duplicate value
INSERT INTO unique_notnull_table(custname, age, city) VALUES('Priya',30,'Pune');  -- ERROR SINCE custid column is NULL


-- -------------------------------------------------------------------------

CREATE TABLE check_table(
custid INT ,
custname VARCHAR(50),
age INT CHECK(age > 1 AND age <= 100),
city VARCHAR(20)
);

INSERT INTO check_table VALUES(1000,'Prakash',35, 'Hyderabad');
SELECT * FROM check_table;
INSERT INTO check_table VALUES(1001,'Abirami',-1, 'Ahmadabad'); -- ERROR since age is < 1
INSERT INTO check_table VALUES(1001,'Karthik',120, 'Ahmadabad');  -- ERROR since age is > 100
INSERT INTO check_table VALUES(1001,'Karthik',50, 'Ahmadabad');

SELECT * FROM check_table;
-- -------------------------------------------------------------------------

CREATE TABLE check_table_2(
custid INT ,
custname VARCHAR(50),
age INT ,
city VARCHAR(20) CHECK(city IN ('Chennai','Bangalore','Hyderabad','Pune'))
);

INSERT INTO check_table_2 VALUES(1000,'Prakash',35, 'Hyderabad');
SELECT * FROM check_table_2;
INSERT INTO check_table_2 VALUES(1001,'Abirami',-1, 'Pune'); 
SELECT * FROM check_table_2;

INSERT INTO check_table_2 VALUES(1001,'Karthik',120, 'Ahmadabad');  -- ERROR since city is not in ('Chennai','Bangalore','Hyderabad','Pune')
INSERT INTO check_table_2 VALUES(1001,'Karthik',50, 'Bangalore'); 
SELECT * FROM check_table_2;


-- DAY 4 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

CREATE TABLE default_table(
custid INT UNIQUE NOT NULL,
custname VARCHAR(100) NOT NULL,
age INT CHECK(age BETWEEN 1 AND 100),
city VARCHAR(100) DEFAULT 'Hyderabad'
);

INSERT INTO default_table VALUES(1000,'Piyush',35,'Pune');
SELECT * FROM default_table;
INSERT INTO default_table VALUES(1001,'Madan',30,'Chennai');
SELECT * FROM default_table;
INSERT INTO default_table(custid,custname,age) VALUES(1002,'Abhi',30);
SELECT * FROM default_table;

-- PRIMARY KEY --------------------------------------------------------------------------- 

CREATE TABLE pkey_table(
custid INT PRIMARY KEY,     -- SINGLE PRIMARY KEY
custname VARCHAR(100) NOT NULL,
age INT CHECK(age BETWEEN 1 AND 100),
city VARCHAR(100) DEFAULT 'Hyderabad'
);


INSERT INTO pkey_table(custid,custname,age) VALUES(1003,'Piyush',35);
SELECT * FROM pkey_table;
INSERT INTO pkey_table VALUES(1000,'Madan',30,'Chennai');  -- ERROR suw to duplicate : 1000
INSERT INTO pkey_table VALUES(1001,'Madan',30,'Chennai'); 
SELECT * FROM pkey_table;
INSERT INTO pkey_table(custname,age) VALUES('Abhi',30);  -- ERROR since the null value cannot be inserted into primary keu column
INSERT INTO pkey_table(custid,custname,age) VALUES(1002,'Abhi',30); 
SELECT * FROM pkey_table;

CREATE TABLE comp_pkey_table(
custid INT,     
custname VARCHAR(100) ,
age INT CHECK(age BETWEEN 1 AND 100),
city VARCHAR(100) DEFAULT 'Hyderabad',
CONSTRAINT my_pk PRIMARY KEY (custid, custname)  -- COMPOSITE PKEY
);


INSERT INTO comp_pkey_table VALUES(1000,'Piyush',35,'Pune');
SELECT * FROM comp_pkey_table;
INSERT INTO comp_pkey_table VALUES(1000,'Madan',30,'Chennai'); 
INSERT INTO comp_pkey_table VALUES(1000,'Madan',30,'Chennai');  -- ERROR - Duplicate 1000-Madan
INSERT INTO comp_pkey_table VALUES(1001,'Madan',30,'Chennai');
INSERT INTO comp_pkey_table(custid,custname,age) VALUES(1010,'Raman',40);
INSERT INTO comp_pkey_table(custid,custname,age) VALUES(1010,'Suraj',40);
INSERT INTO comp_pkey_table(custid,custname,age) VALUES(1020,'Raman',40);
SELECT * FROM comp_pkey_table;

-- FOREIGN KEY

CREATE TABLE customer(
custid INT PRIMARY KEY,
custname VARCHAR(100) NOT NULL,
age INT CHECK (age BETWEEN 1 AND 100),
city VARCHAR(100) DEFAULT 'Hyderabad'
);

INSERT INTO customer VALUES(1000,'Rajesh',30,'Chennai'),(1001,'Sankavi',25,'Bangalore');
INSERT INTO customer VALUES(1002,'Kavin',3,'Hyderabad');
SELECT * FROM customer;

CREATE TABLE orders(
order_id INT PRIMARY KEY,
custid INT,
prodcuct_name VARCHAR(100),
amount INT,
FOREIGN KEY (custid) REFERENCES customer(custid)
);

INSERT INTO orders VALUES(1,1000,'TV',70000);
SELECT * FROM orders;
INSERT INTO orders VALUES(2,1001,'Mobile',50000);
SELECT * FROM orders;
INSERT INTO orders VALUES(3,1003,'Desktop',50000); -- ERROR since 1003 is not present in customer table
INSERT INTO orders VALUES(3,1002,'Desktop',50000);
INSERT INTO orders VALUES(3,1006,'Desktop',50000);
SELECT * FROM orders;


DELETE FROM customer WHERE custid=1002;  -- ERROR due to child table has an entry for 1002
DELETE FROM orders WHERE custid=1002;
DELETE FROM customer WHERE custid=1002;
-- ------------------------------
DROP TABLE orders;

INSERT INTO customer VALUES(1002,'Kavin',3,'Hyderabad');

SELECT * FROM customer;

CREATE TABLE orders1(
order_id INT PRIMARY KEY,
custid INT,
prodcuct_name VARCHAR(100),
amount INT,
FOREIGN KEY (custid) REFERENCES customer(custid) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO orders1 VALUES(1,1000,'TV',70000);
SELECT * FROM orders1;
INSERT INTO orders1 VALUES(2,1001,'Mobile',50000);
SELECT * FROM orders1;
INSERT INTO orders1 VALUES(3,1003,'Desktop',50000); -- ERROR since 1003 is not present in customer table
INSERT INTO orders1 VALUES(3,1002,'Desktop',50000);
SELECT * FROM orders1;

DELETE FROM customer WHERE custid=1002;
update cust_table set custid=1005 where custid=1001;
select * from cust_table;
INSERT INTO cust_table VALUES(1007,'Mahesh','DELHI','M');
INSERT INTO cust_table VALUES(1008,'Sourav','GURUGRAM','M');
INSERT INTO cust_table VALUES(1009,'Karan','CHENNAI','M');
select * from cust_table;
use custdb;


-- DAY 5 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

-- AUTO_INCREMENT

CREATE TABLE mytable(
custid INT UNIQUE auto_increment,
custname VARCHAR(100)  NOT NULL,
age INT,
city VARCHAR(100)
);

INSERT INTO mytable(custname,age,city) VALUES('Ramamoorthy',33,'Chennai');
INSERT INTO mytable(custname,age,city) VALUES('Venkatsh',31,'Hyderabad');
INSERT INTO mytable(custname,age,city) VALUES('Ranjitha',25,'Bangalore');
INSERT INTO mytable VALUES(100,'Divya',25,'Bangalore');
INSERT INTO mytable(custname,age,city) VALUES('Mani',27,'Delhi');
SELECT * FROM mytable;

-- ALTER TABLE STATEMENT

DESC customer;
SELECT * FROM customer;

ALTER TABLE customer ADD COLUMN gender CHAR(1) DEFAULT 'M';
SELECT * FROM customer;
UPDATE customer SET gender='F' WHERE custid=1001;
SELECT * FROM customer;

DESC CUSTOMER;


ALTER TABLE customer DROP COLUMN age;
DESC CUSTOMER;
SELECT * FROM customer;

ALTER TABLE customer MODIFY COLUMN city varchar(20);
DESC CUSTOMER;


ALTER TABLE customer RENAME column city TO location;
DESC CUSTOMER;
SELECT * FROM customer;

ALTER TABLE customer RENAME to cust_table;
DESC cust_table;

DESC check_table;
ALTER TABLE check_table ADD CONSTRAINT pkey PRIMARY KEY(custid);
DESC check_table;

ALTER TABLE check_table MODIFY COLUMN custname varchar(50) NOT NULL;
DESC check_table;

-- DAY 6 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

-- Inner Join
use custdb;
create table customer_tbl (custid int ,custname varchar(50),city varchar(20));

insert into customer_tbl values(1000,	"Raja" ,	"Chennai");
insert into customer_tbl values(1001,	"Bala" ,	"Bangalore");
insert into customer_tbl values(1002,	"Prabha" ,	"Huderabad");
insert into customer_tbl values(1003,	"Aveek" , 	"Pune");
insert into customer_tbl values(1004,	"Chandra" ,	"Delhi");
insert into customer_tbl values(1005,	"Janaki" ,	"Mumbai");

select * from customer_tbl;

create table TRANSACTION_TBL (transid int, custid int,	productname varchar(50),	amount int);

insert into TRANSACTION_TBL values(1,	1000,	"TV"	,50000);
insert into TRANSACTION_TBL values(2,	1001,	"FRIDGE",	30000);
insert into TRANSACTION_TBL values(3,	1001,	"WASHING MACHINE",	40000);
insert into TRANSACTION_TBL values(4,	1002,	"MOBILE",	30000);
insert into TRANSACTION_TBL values(5,	1002,	"LAPTOP",	75000);
insert into TRANSACTION_TBL values(6,   1004,	"DESKTOP",	50000);
insert into TRANSACTION_TBL values(7,	1004,	"PRINTER",	15000);
insert into TRANSACTION_TBL values(8,	1003,	"CHARGER",	5000);
insert into TRANSACTION_TBL values(9,	1003,	"MICROOVEN",	10000);
insert into TRANSACTION_TBL values(10,	1006,	"WATCH",	3000);

select * from TRANSACTION_TBL;

SELECT * FROM CUSTOMER_TBL c INNER JOIN TRANSACTION_TBL t ON c.custid=t.custid;


-- OUTER JOIN ==
-- 	   LEFT JOIN
--     RIGHT JOIN
--     FULL JOIN

SELECT * FROM CUSTOMER_TBL;

SELECT * FROM TRANSACTION_TBL;

-- LEFT JOIN / LEFT OUTER JOIN

SELECT * FROM CUSTOMER_TBL c LEFT JOIN TRANSACTION_TBL t ON c.custid=t.custid;


-- RIGHT JOIN / RIGHT OUTER JOIN

SELECT * FROM CUSTOMER_TBL c RIGHT JOIN TRANSACTION_TBL t ON c.custid=t.custid;

-- Please write a query to know the customers details who have not done any transaction?

SELECT c.custid,city,custname FROM CUSTOMER_TBL c LEFT JOIN TRANSACTION_TBL t ON c.custid=t.custid WHERE transid IS NULL;
-- or --
SELECT c.* FROM CUSTOMER_TBL c LEFT JOIN TRANSACTION_TBL t ON c.custid=t.custid WHERE transid IS NULL;

-- FULL JOIN / OUTER JOIN

SELECT * FROM CUSTOMER_TBL c LEFT JOIN TRANSACTION_TBL t ON c.custid=t.custid 
UNION SELECT * FROM CUSTOMER_TBL c RIGHT JOIN TRANSACTION_TBL t ON c.custid=t.custid;

-- CROSS JOIN / CONDITIONLESS JOIN -------------------

SELECT * FROM CUSTOMER_TBL c CROSS JOIN TRANSACTION_TBL t;

-- OR

SELECT * FROM CUSTOMER_TBL c CROSS JOIN TRANSACTION_TBL t;


-- SELF JOIN ----------------




-- SUB QUERY:
	-- A query within an another query is called sub query

SELECT * FROM CUSTOMER_TBL WHERE custid NOT IN (
SELECT DISTINCT custid FROM TRANSACTION_TBL);



SELECT * FROM CUSTOMER_TBL WHERE custid IN (
SELECT DISTINCT custid FROM TRANSACTION_TBL);

-- VIEW:
-- ( Virtual Table)-- ========

CREATE VIEW cust_trans_details AS
SELECT c.custname,t.productname FROM CUSTOMER_TBL AS c INNER JOIN TRANSACTION_TBL AS t ON c.custid=t.custid;

SELECT * FROM cust_trans_details;   -- ( VIEW is a read only table)


SELECT * FROM company;

CREATE VIEW tcs_data AS 
SELECT * FROM COMPANY WHERE company='TCS' AND Place != 'Cochin';

SELECT * FROM tcs_data WHERE salary>5000;

-- INDEX
-- ========

SELECT * FROM TRANSACTION_TBL;

CREATE INDEX trans_idx ON TRANSACTION_TBL(transid);

UPDATE TRANSACTION_TBL SET productname='LAPTOP' WHERE transid=9;

SHOW INDEXES FROM TRANSACTION_TBL;

SELECT * FROM TRANSACTION_TBL WHERE transid=6;
CREATE INDEX prod_idx ON TRANSACTION_TBL(productname);

SHOW INDEXES FROM TRANSACTION_TBL;


-- DAY 7 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

create table products (
prod_id int primary key,
prod_name varchar(50) not null,
quantity int not null
);

insert into products values(1001,'TV',100),(1002,'AC',200),(1003,'Washing m/c',150),(1004,'desktop',120),(1005,'laptop',75),(1006,'mobile',20);

select * from products;

select * from products where quantity>100;

SELECT * FROM products ORDER BY quantity DESC;

-- AGGREGATE FUNCTION

SELECT COUNT(*) FROM PRODUCTS; 

SELECT MAX(quantity) FROM PRODUCTS;

SELECT MIN(quantity) FROM PRODUCTS;

SELECT SUM(quantity) FROM PRODUCTS;

SELECT AVG(quantity) FROM PRODUCTS;

select * from products;

SELECT upper(prod_name) FROM PRODUCTS;
SELECT lower(prod_name) FROM PRODUCTS;

SELECT concat(prod_id,"_",prod_name, "_", quantity) FROM products;
SELECT concat_ws("_",prod_id,prod_name, quantity) FROM products;

use custdb;
SELECT substr(prod_name,1,2) FROM products;

SELECT * FROM products;

SELECT replace(prod_name,'desktop','computer') FROM products;


-- ------------------- DATE FUNCTIONS: -----------------------

SELECT NOW();
SELECT current_timestamp();

SELECT curdate();
SELECT current_time();
SELECT current_date();


-- %a -> days short name -> sun,mon,tue...
-- %W -> weeday in fullname -> Sunday, Monday...
-- %b -> months short name -> jan, feb, mar
-- %M -> months full name -> January, February...
-- %d -> day of the month (1..31)  %e
-- %m -> month in numeric(1..12)   %c
-- %y -> year in 2 digit (23, 24...)
-- %Y -> year in 4 digit ( 2023, 2024...)
-- %H -> hours in 24 hrs format (00..23)
-- %h -> hours in 12hrs format(1..12)
-- %p -> AM | PM
-- %i -> minute

-- hour/minute/(AM/PM) -----
SELECT DATE_FORMAT(NOW(),"%d-%m-%Y %H:%i ");
SELECT DATE_FORMAT(NOW(),"%d-%m-%Y %h:%i %p ");

-- month -----
SELECT DATE_FORMAT(NOW(),"%d-%m-%Y %h:%i %p ");
SELECT DATE_FORMAT(NOW(),"%d-%c-%Y %h:%i %p ");

-- day -----
SELECT DATE_FORMAT(NOW(),"%a - %d/%M/%Y %H:%i ");
SELECT DATE_FORMAT(NOW(),"%a - %e/%M/%Y %H:%i ");
SELECT DATE_FORMAT(NOW(),"%w - %d/%M/%Y %H:%i ");
SELECT DATE_FORMAT(NOW(),"%W - %d/%M/%Y %H:%i ");

SELECT DATE_FORMAT(NOW(),"%W %M %d %Y ");

SELECT * FROM company;

-- CASE 
-- WHEN condition THEN ops
-- WHEN cond2 THEN ops2
-- WHEN cond3 THEN ops3
-- ELSE ops4
-- END as column_name

SELECT company, age, salary, place,case
when place IN ('Chennai','Podicherry') THEN 'Tamil'
WHEN place='Mumbai' THEN 'Marthi'
WHEN place='Calcutta' THEN 'Bengali'
WHEN place='Delhi' THEN 'Hindi'
WHEN place='Cochin' THEN 'Malayalam'
WHEN place='Hyderabad' THEN 'Telangana'
ELSE 'ENGLISH' 
END as language
FROM company;

-- 0-3000 => "Less Paid"
-- 3001-6000 => "Medium Paid"
-- 6000+ => "High paid"

SELECT company, age, salary, case 
WHEN salary BETWEEN 0 and 3000 THEN "Less Paid"
WHEN salary BETWEEN 3001 AND 6000 THEN "Medium Paid"
ELSE "High Paid"
END as category,
Place
FROM company;
SELECT * FROM company;

-- DAY 8 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

use custdb;

#TCL - Transaction Control Language

#COMMIT AND ROLLBACK ,savepoint

start transaction;

set sql_safe_updates=0;
select * from customer_tbl;

delete from customer_tbl;
rollback;

start transaction;
delete from customer_tbl where custid=1004;
commit;

-- savepoint

start transaction;

select * from company;
savepoint deletenull;
delete from company where place='';

savepoint deletechennai;
delete from company where place='chennai';

savepoint deletemumbai;
delete from company where place='mumbai';

rollback to deletechennai;
commit;

start transaction;

select * from company;

savepoint deletechennai;
delete from company where place='chennai';

savepoint deletemumbai;
delete from company where place='mumbai';

rollback to deletemumbai;
commit;


-- DCL - DATA CONTROL LANGUAGE (GRANT,REVOKE)

-- SELECT
-- INSERT
-- DELETE
-- UPDATE
-- VIEW
-- ALL

GRANT SELECT ON customer_tbl to root@localhost;
GRANT SELECT,update ON customer_tbl to root@localhost;
GRANT delete ON customer_tbl to root@localhost;

revoke delete ON customer_tbl from root@localhost;


-- GROUP BY,HAVING,ORDER BY,LIMIT -----------------------------------------------------------------------------

select * from company;
select company,sum(salary) from company
group by company;

select company,min(salary) from company
group by company;

select company,place,sum(salary) from company
group by company,place
having sum(salary)>2000;

select company,place,sum(salary) from company
group by company,place
having sum(salary)>0
order by sum(salary);

select company,place,sum(salary) 
from company
WHERE company!=''
group by company,place
having sum(salary)>5000
order by company;

select company,place,sum(salary) 
from company
WHERE company!=''
group by company,place
having sum(salary)>0
order by sum(salary)desc
limit 10;









