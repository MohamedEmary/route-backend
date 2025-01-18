-- Videos from    to    
USE ITI;


-- TODO: search if there is a reverse function in SQL or not
-- TODO: see telegram record + ../draft/image.png, ../draft/note.excalidraw
/* 
The use of NTile, its parameter (n tiles), how it works, and how does it handles a number of rows  that is not divisible by the number of tiles. 

Example of using NTILE would be pagination, for example when you open amazon and you see the products divided into pages, each page contains a number of products.

For example if we have instructors and we want to divide them into 3 tiles based on their salary. 

in the query below since we have 15 rows, we will have 5 rows in each tile.
 */
SELECT
  Ins_Id,
  Ins_Name,
  Dept_Id,
  NTILE(3) OVER (
    ORDER BY
      Salary
  )
FROM
  Instructor;


/*
But if we divide by 4, we will have 4 rows in the first two tiles and 3 rows in the last tile.

The tile with least number of rows will always be the last tile.
 */
SELECT
  Ins_Id,
  Ins_Name,
  Dept_Id,
  NTILE(4) OVER (
    ORDER BY
      Salary
  ) SalaryTile
FROM
  Instructor;


-- To select the highest paid instructors (between 3 tiles):
SELECT
  *
FROM
  (
    SELECT
      Ins_Id,
      Ins_Name,
      Dept_Id,
      NTILE(3) OVER (
        ORDER BY
          salary DESC
      ) salaryTile
    FROM
      Instructor
  ) AS HighestPaidInstructors
WHERE
  salaryTile = 1;


/* 
if we have one million products and we want to get the top 1000 products in price, we can use NTILE to divide the products into 1000 tiles based on their price and then select the first tile.

if we want to get the last 1000 products in price, we can use NTILE to divide the products into 1000 tiles based on their price and then select the last tile.

if we want to get the products in the middle, we can use NTILE to divide the products into 1000 tiles based on their price and then select the middle tiles.

For each of the cases above we can use either a sub query and WHERE condition with the tile number or we can use TOP and select (TOP 1000 if we want the first 1000 products, OR sort the products in descending order and select TOP 1000 if we want the last 1000 products, or if we want to get for example from 3000 to 4000 products (tile number 4)  we can use TOP 4000 and then reverse the order and select TOP 1000).

One of the good resources that you can use to study SQL is JavaTPoint, and SQLServerTutorial, and of course the official documentation of SQL Server.

 */
--  ========================================
/* 
OFFSET, FETCH

OFFSET is used to skip a number of rows from the beginning of the result set.
FETCH is used after OFFSET to take a number of rows from the result set.

Later, we will talk about OFFSET and FETCH in more details.
 */
SELECT DISTINCT
  Top_Id
FROM
  Course
ORDER BY
  Top_Id
OFFSET
  1 ROWS
FETCH NEXT
  2 ROWS ONLY;


/* 
SQL Query Execution Order

- FROM
- JOIN
- ON
- WHERE
- GROUP BY
- HAVING
- SELECT
- ORDER BY
- TOP

If we have a sub query it will get executed before the outer query with the same order above, and its output will be used in the outer query that is also executed with the same order above.

IMPORTANT!!! you should also use the order above when reading queries or when being asked to read a query in an interview. Don't read the query in the order it is written, read it in the execution order above.

Knowing query execution order helps us if we want to trace a query and know why it is not working as expected, or if we want to optimize a query.

-- Some important advices in video: `Part 10 Execution Order.mp4` from 7:30


 */
-- ===================================
-- Videos from    to    
USE ITI;


/* 
Query Execution Order

While executing a query, the `WHERE` clause is executed before the `SELECT` clause, so if we try to use the alias `FullName` in the `WHERE` clause, we will get an error because the `FullName` alias is not defined yet. That is why the statement below will not work and you will get `Invalid column name 'FullName'` error: 

SELECT
St_Id,
CONCAT_WS(' ', St_Fname, St_Lname) AS FullName,
St_Age
FROM
Student
WHERE
FullName = 'Ahmed Hassan';
 */
-- ========================
/* 
The same statement works if you use that column name with `ORDER BY` clause, because the `ORDER BY` clause is executed after the `SELECT` clause.

`ORDER BY` gets executed after the `SELECT`, because we need to select the data first, then we can order them.

Meanwhile, the `WHERE` clause is executed before the `SELECT` clause, because we need to filter the rows first, then we can select the columns.

 */
SELECT
  St_Id,
  CONCAT_WS(' ', St_Fname, St_Lname) AS FullName,
  St_Age
FROM
  Student
ORDER BY
  FullName;


-- ==============================================
/* 
Union Family Operators

Union Family Operators are: `UNION`, `UNION ALL`, `INTERSECT`, `EXCEPT`

Sometimes we have two select statements each one returns a result and we want to get one result out of those two select statements, based on what we want to achieve we can use one of the operators above.

Union family operators can reduce requests to the database, because we can get the data we want in one request (one select statement) instead of two requests (two select statements).

For example suppose you have two databases each one in a different location, and you want to get the data from both databases, you can use the `UNION` operator to get the data from both databases in one request.


UNION ignores the duplicates (only returns one copy of the duplicate rows), while UNION ALL does not ignore the duplicates.

add the example in ./images/image-2.png into the pdf and explain it (Osama was removed).

UNION Checks duplication for only selected columns and not all columns. 
For example if we select only `St_LName` in both queries, UNION will check for duplication in `St_LName` only and not in all column values in that row.

If we select `St_LName` and `St_FName` in both queries, UNION will check for duplication in both `St_LName` and `St_FName` and if it sees a row that's for example has the same `St_LName` but different `St_FName` it will not remove it.

you should decide whether to use UNION or UNION ALL based on the requirements of the task you are working on.

======================

INTERSECT returns the common rows between the two select statements. The result of INTERSECT is what is what UNION has removed (the duplicates).

For example if we have two select statements, the first one returns 10 rows and the second one returns 5 rows, and there is 3 similar rows between the two select statements, INTERSECT will return those 3 rows.

======================

EXCEPT returns the rows that are in the first select statement and not in the second select statement.

======================

You will know the importance of this when using LINQ in C#

LINQ is a language integrated query that is used in C# to query databases. LINQ has functions that are converted to SQL queries and executed on the database.

The advantage of LINQ is that it can be used with any database, and it will handle the differences between the databases SQL syntax. You just write LINQ code and it will be converted to the correct SQL syntax for the database you are using.

An example of using INTERSECT would be when you have two arrays of employees and you want to get the common employees between the two arrays based on their SSN, Name which are a subset of the properties the employee object has. You can use INTERSECT to get the common employees between the two arrays based on this subset of properties.

Csharp 11 update came with [`IntersectBy`](https://learn.microsoft.com/en-us/dotnet/api/system.linq.enumerable.intersectby?view=net-7.0) function that helps us to intersect two collections based on a key selector, but we still need to know how to use the [`Intersect`](https://learn.microsoft.com/en-us/dotnet/api/system.linq.enumerable.intersect?view=net-7.0) function as you may see it in existing code.


Why to learn SQL if you will write queries using LINQ anyway?

1. The LINQ queries are converted to SQL queries and executed on the database, so you need to know SQL to write efficient LINQ queries.
2. To write reports, you need to know SQL because the data in the reports is fetched using SQL queries.

The first 30 min of most interviews are about SQL, so you need to know SQL to pass the interview.


We may see an misuse of UNION in some cases, for example if we have a table of students and we want to get students who live in either Cairo or Giza, we can use the `IN` operator, but some people may use UNION to get the students who live in Cairo and then get the students who live in Giza and then use UNION to combine the two results, which is not efficient.

Instead of:
Select * from Student Where St_Address = 'Cairo'
union
Select * from Student Where St_Address = 'Alex'

We can use:
Select * from Student Where St_Address in ('Cairo', 'Alex')

We can use union family operators when we have two tables with no relation between them and we want to get the data from both tables in one result set (for example two different tables in different databases or different schemas).


for example if we have two different student tables student1 and student2 with no relation and we want to get the students from both tables, we can use UNION to get the students from both tables in one result set.

Select first_name from Student1
union
Select first_name from Student2

to get duplicates we can use UNION ALL

Select first_name from Student1
union all
Select first_name from Student2

duplicates are considered duplicates if they are the same in all columns selected in the query. If any of those columns is different, UNION will not remove the row.

IMPORTANT!
For the union family operators, the number of columns selected in the two select statements should be the same, and the data type of the columns should be the same.

if you don't follow the two rules above you will get this error:
- All queries combined using a UNION, INTERSECT or EXCEPT operator must have an equal number of expressions in their target lists. 


 */
SELECT
  Ins_Name,
  Ins_Degree
FROM
  Instructor
UNION ALL
SELECT
  St_Fname
FROM
  Student;


-- =================================================================
/* 
Database Hierarchy:
---------SQL Server service (DB Engine) 
-----------SQL Server has multiple databases
-------------Database consists of schemas
---------------The schema consist of database objects (Tables, views, functions, stored procedures, etc)
-----------------The tables consist of columns and rows

Schemas are used to divide the database into logical groups, for example we can have a schema for the HR department, a schema for the IT department, a schema for the finance department, etc.

The default schema in SQL Server is `dbo` which stands for database owner.

Based on the Hierarchy above the actual select statement should be like this:
SELECT * FROM ServerName.DatabaseName.SchemaName.TableName;

But since the server name and the database name are already set in the connection string, we can use the following select statement:

SELECT * FROM SchemaName.TableName; 

--To get the server name we can run:
SELECT @@SERVERNAME;

If the table you are selecting from is in the default schema `dbo`, you can also ignore the schema name in the select statement:

SELECT * FROM TableName;


Schema Solved 3 Problems:
1. You Can't Create Database Objects With The Same Name [Table, View, Index, Trigger, Stored Procedure, Rule]
2. There Is No Logical Meaning (Logical Name) (Grouping related objects together for example all tables related to HR in one schema, all tables related to IT in another schema, etc)
3. Permissions (Schemas help up manage Permissions and Security)


You can create a new schema using:

CREATE SCHEMA SchemaName;

Sometimes you can't put it in the same batch with other queries (search why), so you should put it in a separate batch.

Use `GO` to separate between batches.
... -- Some existing queries
Go; -- End of the batch above
CREATE SCHEMA SchemaName;
Go; -- End of the current batch

When using `sqlcmd` you have to use `GO` to execute the batch.


To create a table in a schema you can use:

CREATE TABLE SchemaName.TableName (
Column1 DataType,
Column2 DataType,
...
);

If you remove the schema name from the query, the table will be created in the default schema `dbo`.


If you want to remove that schema you will have to remove all the objects in that schema first, then you can remove the schema.

To remove a schema you can use:
DROP SCHEMA SchemaName;

To transfer a table from one schema to another schema you can use:
ALTER SCHEMA NewSchemaName TRANSFER OldSchemaName.TableName;

The schema you are transferring data to can't have a table with the same name.

After transferring the table from its old to new schema and trying to query the table from the new schema, you may get an error that the table does not exist, you can solve this by refreshing your connection to the database.

 */
SELECT
  @@SERVERNAME;


SELECT
  *
FROM
  EndeavourOS.ITI.dbo.Student;


-- ========================================================================
/* 
DDL includes (CREATE, ALTER, DROP, SELECT INTO, TRUNCATE)

So far we have talked about CREATE, ALTER, DROP. Now lets talk about SELECT INTO and TRUNCATE.

SELECT INTO is used to create a new table based on the result of a select statement. Each table consists of structure which is (Columns, Keys, Constraints, Indexes, Triggers, etc) and data which is the rows.

`SELECT INTO` copies data and only (columns, constraints) from a source table to a new table.

SELECT
 * INTO table_name
FROM
[db_name].[dbo].[table_name]


you can also copy only some columns from the source table to the new table, and you can add a WHERE condition to filter the rows you want to copy.

Here we select the data of `[db_name].[dbo].[table_name]` and copy it to the new table `table_name` in the current database.


To take a copy of the table structure only (columns, constraints) without copying the data, you can use a WHERE condition that is always false, so no rows will be copied to the new table.

SELECT
 *
INTO
table_name
FROM
[db_name].[dbo].[table_name]
WHERE
1 = 0;





To insert data from a table to an existing table we can use INSERT INTO.

So far we have learned two types of INSERT:
1. Simple INSERT
2. Row Constructor INSERT

Now we will learn the third type which is INSERT based on SELECT

To insert data from a table to an existing table we can use INSERT INTO with SELECT. But we have to satisfy the following conditions:
1. The number of columns in the source table should be equal to the number of columns in the destination table.
2. The data type of the columns in the source table should be compatible with the data type of the columns in the destination table.
3. The columns in the source table should be in the same order as the columns in the destination table.

INSERT INTO table_name (column1, column2, ...)
SELECT column1, column2, ...
FROM source_table_name
WHERE condition;


The query above will insert only the columns `column1`, `column2`, ... from the source table to the destination table.

If you want to insert all columns from the source table to the destination table, you can remove the column names from the query.

INSERT INTO table_name
SELECT *
FROM source_table_name
WHERE condition;




TRUNCATE is used to remove all rows from a table. TRUNCATE is faster than DELETE because it does not log the deleted rows, however, you can't restore the deleted rows after using TRUNCATE like you can do with DELETE.

TRUNCATE drops the table and recreates it. It's considered a DDL statement because it drops and recreates the table.

DELETE is a DML statement because it only deletes the rows and does not drop the table.

If you have a table with a foreign key constraint, you can't use TRUNCATE to delete the rows from the table, you have to use DELETE instead.


You can recover the removed data from DELETE because DELETE logs the deleted rows into the transaction log (as we know database has two main files, the `.mdf` file which contains the data and the `.ldf` file which contains the transaction log) so you can recover the deleted rows from the transaction log.
 */