-- create new table to insert shit in

select * into Customer from DimCustomer where CustomerKey <= 10;

select * from Customer;

-- export rows 11 to x depending on how many you want to test with.
-- alternatively, create new Customers in a csv file.

-- insert from file into new table
BULK INSERT Customer FROM 'C:\.....\*.csv' WITH (FORMAT='CSV');

-- might need to enable / grant permission to use xp_cmdshell 
exec sp_configure 'show advanced options', 1;
reconfigure;
exec sp_configure 'xp_cmdshell', 1;
reconfigure;

-- get list of files in dir
declare @cmd varchar(1000);
set @cmd = 'dir /B C:\..........\*.csv'
EXEC Master.dbo.xp_cmdShell @cmd
;

-- drop temporary table
drop table #files;

-- use a temporary table to store file list
create table #files(FileName varchar(1000));
insert into #files EXEC Master.dbo.xp_cmdShell 'dir /B "C:......\*.csv"'
;

SELECT * FROM #files;

-- get filename from temporary table #files
-- loop through the number of files in the temporary table
-- then insert from each file into table
declare @filename varchar(10);
declare @sql varchar(1000);
while (select count(*) from #files) > 1
begin
	select top 1 @filename = Filename from #files;

	print @filename;

	set @sql = 'BULK INSERT Customer FROM ''C:\......\' +@filename+''' WITH(FIELDTERMINATOR = '','');'

	print @sql;

	exec(@sql);

	delete from #files where Filename = @filename;
end
;

select * from Customer;