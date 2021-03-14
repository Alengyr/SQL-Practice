
-- Employee table renamed to Technicians using EXEC sp_rename
-- Sales managers and related are changed to Technicians.
-- Act as a self audit. You find out how many ITEMS you are going to change first.
SELECT COUNT(*) FROM technicians WHERE Title = 'Sales Region Manager';  

-- There is 5. Change to Head Technician (DONE)
UPDATE technicians
SET title = 'Head Technician' WHERE title = 'Sales Region Manager';

--Two ways to double check. Either manually do a query again or see how many rows were affected. (DONE)
SELECT title FROM technicians;

--Sales group manager to Tech Manager (DONE)
UPDATE technicians SET title = 'Tech Manager' WHERE title = 'Sales Group Manager';

-- Intentionally remove LoadDate and UpdateDate entries for Customers between ID of 200-1200 (DONE)
--UPDATE Customer
--SET 
--UpdateDate = NULL,
--LoadDate = NULL
--WHERE CustomerKey BETWEEN 200 AND 1200;

--Confirm that 200-1200 is NULL entries (DONE)
SELECT customerkey, CONCAT(firstname,' ',middlename,' ',lastname) AS fullname,
loaddate,updatedate FROM customer WHERE customerkey BETWEEN 200 AND 1200;

--Create a fullname column. First create an empty column as a receiving container. (DONE)
--ALTER TABLE Customer
--ADD FullName varchar(50);

-- Now do an update query to stuff contents into the FullName column. (DONE)
UPDATE Customer
SET FullName = CONCAT(firstname,' ',middlename,' ',lastname);

--Append from Excel new load and update dates to the ones in NULL (DONE)
UPDATE customer
SET 
customer.loaddate = toappend.loaddate,
customer.updatedate = toappend.updatedate
FROM customer JOIN toappend ON customer.customerkey = toappend.customerkey;

--Append successful. Check:
SELECT loaddate,updatedate FROM customer;

--Add a geolocation data for customer table (DONE)
--ALTER TABLE customer
--ADD "Location" varchar(50);

--This query will work to append the data from csv to existing table. But need to amend the datatype because it was imported as nvarchar. (DONE)
--UPDATE customer
--SET customer.loaddate = tqtq.loaddate
--FROM customer JOIN tqtq
--ON customer.customerkey = tqtq.keystuff;
-- Reason for append error found : The date formatting. Its not regional related. The format needs to follow the SSMS's format. (Use GETDATE() function)


--Append corrected excel file containing auto-incremented index from Excel. (DONE)

--Dropped the test append tables for loaddate and updatedate.

--Modify the EmployeeKey field to have brand new ID. The ID starts from 30-xx (Should a loop be used for this?)

