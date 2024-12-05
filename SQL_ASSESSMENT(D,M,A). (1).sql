
-- Here we are talking about the Bank related information of a person. 
-- For which you need to  create three tables named as Bank, Account holder and Loan 
-- table.  
-- And solve the problem stated below. 
-- Create a Bank table, attributes are : branch id, branch name, branch city 
-- Create a Loan table, attributes are : loan no, branch id, account holder’s id, loan 
-- amount and loan type  
-- Create a table named as Account holder for the same scenario containing the 
-- attributes are account holder’s id, account no, account holder’s name, 
-- city,contact, date of account created, account status (active or terminated), 
-- account type  and balance. 

-- bank table

CREATE TABLE BANK_1(
BRANCH_ID INT PRIMARY KEY,
BRANCH_NAME VARCHAR(20) NOT NULL,
BRANCH_CITY VARCHAR(20) NOT NULL
);

TRUNCATE TABLE BANK_1;

DROP TABLE BANK_1;

-- INSERT VALUE IN BANK TABLE

INSERT INTO BANK_1 VALUES(1,'CENTRAL BANK','MUMBAI');
INSERT INTO BANK_1 VALUES(2,'STATE BANK','DELHI');
INSERT INTO BANK_1 VALUES(3,'AXIS BANK','BENGALURU');

SELECT * FROM BANK_1;

DESCRIBE BANK_1;

-- ACCOUNT HOLDER TABLE

CREATE  TABLE ACCOUNT_HOLDER(
ACCOUNT_HOLDER_ID varchar(20) PRIMARY KEY,
ACCOUNT_NO INT NOT NULL,
NAME VARCHAR(20) NOT NULL,
CITY VARCHAR(40) NOT NULL,
CONTACT BIGINT, -- TO STORE 10 NUMBERS AS A INTERGER, LONG MAY BE USED
DATE_OF_ACCOUNOT DATE NOT NULL,
ACCOUNT_STATUS VARCHAR(30) NOT NULL,
ACCOUNT_TYPE VARCHAR(30) NOT NULL,
BALANCE long NOT NULL
);

TRUNCATE TABLE ACCOUNT_HOLDER;

DROP TABLE ACCOUNT_HOLDER;
-- INSERT VALUE IN ACCOUNT HOLDER TABLE

INSERT INTO ACCOUNT_HOLDER VALUES('AH001',101,'PRIYA','MUMBAI',9876543210,'2020-01-15', 'ACTIVE','SAVINGS',50000);
INSERT INTO ACCOUNT_HOLDER VALUES('AH002',102,'ROHAN','DELHI',9876543211,'2020-01-20', 'TERMINATED','CURRENT',0);
INSERT INTO ACCOUNT_HOLDER VALUES('AH003',103,'ANANYA','BENGALURU',9876543212,'2020-01-25', 'ACTIVE','SAVINGS',75000);
INSERT INTO ACCOUNT_HOLDER VALUES('AH004',104,'RAHUL','MUMBAI',9876543213,'2020-01-30', 'ACTIVE','CURRENT',125000);

SELECT * FROM ACCOUNT_HOLDER;

-- LOAN TABLE

CREATE TABLE LOAN(
LOAN_NO INT primary KEY,
BRANCH_ID INT NOT NULL,
ACCOUNT_HOLDER_ID VARCHAR(30) NOT NULL,
LOAN_AMOUNT INT NOT NULL,
LOAN_TYPE VARCHAR(30) NOT NULL

);

TRUNCATE TABLE LOAN;

DROP TABLE LOAN;

-- INSERT VALUE IN LOAN TABLE

INSERT INTO LOAN VALUES(1001,1,'AH001',500000,'HOME LOAN');
INSERT INTO LOAN VALUES(1002,2,'AH002',300000,'PERSONAL LOAN');
INSERT INTO LOAN VALUES(1003,3,'AH003',750000,'CAR LOAN');

SELECT * FROM LOAN;

COMMIT;  

-- Consider an example where there’s an account holder table where we are 
-- doing an intra bank transfer i.e. a person holding account A is trying to 
-- transfer $100 to account B.  - - 
-- for this you have to make a transaction in sql which can 
-- transfer fund from account A to B  
-- Make sure after the transaction the account information 
-- have to be updated for both the credit account and the 
-- debited account

-- TRANSACTION TABLE
-- What is a Transaction in SQL?
-- A transaction in SQL is a sequence of one or more operations (like INSERT, UPDATE, DELETE) that are executed as a single unit of work. It ensures that either all the operations within the transaction are successfully executed or none are applied (rollback). This ensures data integrity.

-- Syntax of a Transaction
-- sql
-- Copy code
-- START TRANSACTION;
--     -- SQL operations
--     COMMIT; -- Save changes
--     -- OR
--     ROLLBACK; -- Undo changes in case of errors

-- HERE WE ARE UPDATING VALUE OF ACCOUNT HOLDER A AND ACCOUNT HOLDER B BY ADDING OR WITHDRAWING AMOUNT,
-- SO WILL USE UPDATE

-- UPDATE SYNTAX:

-- UPDATE table_name
-- SET column_name = new_value
-- WHERE condition;


START TRANSACTION; -- Transaction starts here

-- Command 1: Update Priya's balance
UPDATE Account_Holder
SET Balance = Balance - 100 -- Command syntax for update
WHERE Account_Holder_ID = 'AH001';

-- Command 2: Update Rohan's balance
UPDATE Account_Holder
SET Balance = Balance + 100 -- Command syntax for update
WHERE Account_Holder_ID = 'AH002';

COMMIT; -- Save the changes

SELECT * FROM ACCOUNT_HOLDER;

-- Also fetch the details of the account holder who are related from the same CITY
SELECT ACCOUNT_NO,NAME,CITY FROM ACCOUNT_HOLDER WHERE CITY = 'MUMBAI';

-- Write a query to fetch account number and account holder name, whose 
-- accounts were created after 15th of any month 
SELECT ACCOUNT_NO,NAME FROM ACCOUNT_HOLDER WHERE DAY(DATE_OF_ACCOUNOT) >15;
-- DAY() --> THIS WILL HELP TO SPECIFY THE DATE OF ANY MONTH

-- ● Write a query to display the city name and count the branches in that city. 
-- Give the count of branches an alias name of Count_Branch. 
SELECT BRANCH_CITY, COUNT(*) AS COUNT_BRAMCH FROM BANK_1 GROUP BY BRANCH_CITY;

-- ● Write a query to display the account holder’s id, account holder’s name, 
-- branch id, and loan amount for people who have taken loans. (NOTE : use 
-- sql  join concept to solve the query)
SELECT ACCOUNT_HOLDER.ACCOUNT_HOLDER_ID, ACCOUNT_HOLDER.NAME, LOAN.BRANCH_ID, LOAN.LOAN_AMOUNT
FROM ACCOUNT_HOLDER
RIGHT JOIN LOAN 
ON ACCOUNT_HOLDER.ACCOUNT_HOLDER_ID = LOAN.ACCOUNT_HOLDER_ID;

   

