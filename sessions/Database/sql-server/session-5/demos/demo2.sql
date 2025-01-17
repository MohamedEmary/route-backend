-- Videos from    to    
USE ITI;


/* 

# Sub Query

Has inner query which is the sub query and outer query which is the query that contains the sub query 

The sub query is executed first and then the outer query is executed

SubQuery Is Very Slow and generally Not Recommended except for some cases when we have a part of the query (usually contains an aggregate function) that needs to be run in a separate thread and return output that will be used in the outer query

using subqueries can negatively impact performance as you are executing two queries instead of one, but sometimes we have no other choice but to use them because we have a part of the query that needs to be run in a separate thread and return output that will be used in the outer query

Inner query output is used as input for the outer query

query execution phases:
https://learn.microsoft.com/en-us/sql/relational-databases/query-processing-architecture-guide?view=sql-server-ver16#process-a-select-statement

https://www.geeksforgeeks.org/sql-query-processing/

==================================================
ADD WHEN TO USE EACH OF THE EXPLAINED SQL CLAUSES
INTO THE MARKDOWN FILE IN A HIGHLIGHTED BOX
SEARCH WITH `when` and `if` WORDS IN THE FILE
TO FIND THOSE SECTIONS
==================================================


Example of a case in which we need to use sub query
here we want to get the students that their age is greater than the average age of all students 

Error because AVG is an aggregate function
and we can't use it in the where clause
where works on table record by record
while aggregate functions work on the whole table
SQL Server Error Messages - Msg 147, Level 15, State 1, Line 8
An aggregate may not appear in the WHERE clause unless it is in a subquery contained in a HAVING clause or a select list, and the column being aggregated is an outer reference.
In the error message, it says that we can use the aggregate function in a subquery contained in a HAVING clause
 */
SELECT
  St_Id,
  St_Fname,
  St_Age
FROM
  Student
WHERE
  St_Age > AVG(St_Age);


-- To fix it we need to use a sub query inside the where clause
SELECT
  St_Id,
  St_Fname,
  St_Age
FROM
  Student
WHERE
  St_Age > (
    SELECT
      AVG(St_Age)
    FROM
      Student
  );


/* 
another example
suppose we want to get each student id and the total number of students 
for example 1/20, 2/20, 3/20, 4/20, 5/20 and so on
 */
-- Error anything selected next to an aggregate function that is not an aggregate function should be in the group by clause
SELECT
  St_Id,
  COUNT(*)
FROM
  Student;


SELECT
  St_Id,
  (
    SELECT
      COUNT(*)
    FROM
      Student
  ) -- total number of students
FROM
  Student;


/* 
As said before, subqueries are slow and not recommended
sometimes you can do something with subqueries but there is a better way to do it
an 

For Example getting the departments that have students
As we knew before that the relation between student and department is one to many as each student belongs to one department and each department has many students

So we can get the departments that have students by using subquery but using join is better and faster
 */
SELECT
  Dept_Name
FROM
  Student S,
  Department D
WHERE
  S.Dept_Id = D.Dept_Id;


/* 
You may see duplicate department names, this is because multiple students belong to the same department and we can also select `S.St_Fname` to see the students names

to get only unique values we can use the `DISTINCT` keyword

Here we are selecting from only one column but we still needed to use join because we need to get departments that have students

Join is used when we want to select data from multiple tables that have a relation between them or when we want to get data from one table based on data from another table which is the case in this example
 */
SELECT DISTINCT
  Dept_Name
FROM
  Student S,
  Department D
WHERE
  S.Dept_Id = D.Dept_Id;


-- Using subquery to get the same result (not recommended)
/* 
Since the sub query returns an array of values, we can't use the `=` operator to compare it with the `Dept_Id` column. We need to use the `IN` operator to check if the `Dept_Id` is in the array of values returned by the sub query

You can use sql server profiler to see the difference in performance between the two queries

sql server has an optimizer that optimizes the query and if you give it the query that uses subquery it will optimize it to use join instead
 */
SELECT
  Dept_Name
FROM
  Department
WHERE
  Dept_Id IN (
    SELECT DISTINCT
      Dept_Id
    FROM
      Student
    WHERE
      Dept_Id IS NOT NULL
  );


/* 
another example but with `DELETE` to delete the grades of students who live in Mansoura

We can use either join or sub query to do this
 */
-- Sub query
DELETE FROM Stud_Course
WHERE
  St_Id IN (
    SELECT
      St_Id
    FROM
      Student
    WHERE
      St_Address = 'Mansoura'
  );


-- This is how the select statement would look:
-- The two records for `Saly`
SELECT
  *
FROM
  Stud_Course SC,
  Student S
WHERE
  SC.St_Id = S.St_Id
  AND S.St_Address = 'Mansoura';


/* 
The delete statement using join
After the delete keyword we should add the table alias to specify from which table we want to delete the records. if we add SC it will delete Saly's records (class grades) from the `Stud_Course` table, and if we add S it will delete Saly's records from the `Student` table (deletes Saly from students table)
 */
DELETE SC
FROM
  Stud_Course SC,
  Student S
WHERE
  SC.St_Id = S.St_Id
  AND S.St_Address = 'Mansoura';


-- ======================================
/* 
Top is a sql keyword (not a function) that is used to select the top rows from the table and it accepts an expression that specifies the number of rows to select
for example to select the first 2 students from the student table
The star here in the select statment represents all columns in the table, and we can also specify the columns we want to select
when using top you want to get the top records based on something so you write the logic that gets you those records then use top to get the top records
 */
SELECT
  TOP (2) *
FROM
  Student;


-- Select top 5 students fname and age
SELECT
  TOP (5) St_Fname,
  St_Age
FROM
  Student;


/* 
Something that proofs that TOP is a keyword and not a function is that we are able to select columns next to it without any problem
if you try to select columns next to an aggregate function it will give you an error
 */
SELECT
  COUNT(*),
  St_Fname
FROM
  Student;


-- To select all students except the last five
SELECT
  TOP (
    (
      SELECT
        COUNT(*)
      FROM
        Student
    ) - 5
  ) *
FROM
  Student;


-- To get the last 5 students from students table
SELECT
  TOP (5) *
FROM
  Student
ORDER BY
  St_Id DESC;


/* 
The examples above are just simple examples. now lets see a real example of using the TOP keyword

if we want to get the name of the 3 instructors with maximum salary

We knew in the last sessions that we can use the MAX aggregate function to get the maximum salary but it will return only the number
 */
--  Using MAX aggregate function to get the maximum salary value only
SELECT
  MAX(Salary) MaxSalary
FROM
  Instructor;


-- To get the name and salary of the instructor with the maximum salary
SELECT
  TOP (3) Ins_Name,
  Salary
FROM
  Instructor
ORDER BY
  Salary DESC;


/* 
To get the second top max salary without using TOP we can use a sub query
!= is similar to <> in SQL 
 */
SELECT
  MAX(Salary)
FROM
  Instructor
WHERE
  Salary != (
    SELECT
      MAX(Salary)
    FROM
      Instructor
  );


/* 
If we can use TOP we can select the top two salaries then inverse them and select the top one

You must give the resulting table you get from the sub query an alias name or you will get an error (You can use `AS` or ignore it and write the alias name directly)
 */
SELECT
  TOP (1) *
FROM
  (
    SELECT
      TOP (2) Ins_Name,
      Salary
    FROM
      Instructor
    ORDER BY
      Salary DESC
  ) AS TopTwoSal
ORDER BY
  Salary;


-- One more way to do so
SELECT
  TOP (1) Ins_Name,
  Salary
FROM
  Instructor
WHERE
  Salary != (
    SELECT
      MAX(Salary)
    FROM
      Instructor
  )
ORDER BY
  Salary DESC;


-- You can see salary values:
SELECT
  Salary
FROM
  Instructor
ORDER BY
  Salary DESC;


/* 
top with ties
must be used with order by

ties are the records that have the same value that you are ordering by
 */
SELECT
  TOP (5) St_Age
FROM
  Student
ORDER BY
  St_Age DESC;


SELECT
  TOP (5)
WITH
  TIES St_Age
FROM
  Student
ORDER BY
  St_Age DESC;


/* 
Random selection
for example selecting new different student with each run
NewID() is a built-in function in SQL Server that generates new GUID (pronounced goo-wid)
GUID is a global unique identifier
each time its run it returns a different 32 character string
ex 70ff8575-bc13-4f87-9079-94e225308958
its divided into 5 groups separated by hyphens
You can use this method to do random selection
It can also be used as a primary key value in a table
default value static for example if there is no address use 'No Address'
and there is a dynamic default value value that changes each time the query is run
 */
SELECT
  NEWID();


SELECT
  TOP (1) *
FROM
  Student
ORDER BY
  NEWID();


/* 

Ranking functions:

1. `ROW_NUMBER()`: This function assigns a unique sequential integer to rows within a partition of a result set, starting at 1 for the first row in each partition.
2. `RANK()`: This function assigns a rank to each row within a partition of a result set. The rank of a row is one plus the number of ranks that come before it. If two rows have the same rank, the next rank(s) will be skipped.
3. `DENSE_RANK()`: This function assigns a rank to each row within a partition of a result set, similar to `RANK()`. However, `DENSE_RANK()` does not skip ranks if there are ties. The next rank will be the immediate next integer.

These functions take no arguments and work on the table record by record

the difference between the three functions is in how they handle rows with the same value

choosing which function to use depends on the business requirements

../images/image-1.png


 */
SELECT
  Ins_Id,
  Ins_Name,
  Salary,
  ROW_NUMBER() OVER (
    ORDER BY
      Salary DESC
  ) AS RN,
  DENSE_RANK() OVER (
    ORDER BY
      Salary DESC
  ) AS DR,
  RANK() OVER (
    ORDER BY
      Salary DESC
  ) AS R
FROM
  Instructor;


/* 
-- To get the top 10 students
SELECT
Id,
Name,
Grade,
ROW_NUMBER() OVER (
ORDER BY
Grade DESC
) AS RN
FROM
Students
WHERE
RN <= 10;
 */
-- If ranking functions find two similar values they will order them based on the order of the rows in the table (the primary key) and we can use another column to order them so if we have two similar values we can order them based on another column
SELECT
  ROW_NUMBER() OVER (
    ORDER BY
      Points DESC,
      NumberOfGoals DESC
  ) AS RN,
  DENSE_RANK() OVER (
    ORDER BY
      Points DESC,
      NumberOfGoals DESC
  ) AS DR,
  RANK() OVER (
    ORDER BY
      Points DESC,
      NumberOfGoals DESC
  ) AS R
FROM
  Instructor;


-- To get the 2 oldest students in students table
-- One note on the query below as you can see we didn't use () with the `TOP` 
-- that is because top is a keyword not a function
SELECT
  TOP 2 St_Age,
  St_Fname,
  St_Id
FROM
  Student
ORDER BY
  St_Age DESC;


/* 
We can also use `RANK`

Here instead of using top we are using ROW_NUMBER in a subquery to get the students with the highest age 
then we are selecting the students with rank 1 and 2 from the subquery

IMPORTANT: We have to give the table outputted by the subquery an alias name, We can't apply the `ROW_NUMBER` function directly in the where clause without using a subquery
 */
SELECT
  *
FROM
  (
    SELECT
      St_Age,
      St_Fname,
      St_Id,
      ROW_NUMBER() OVER (
        ORDER BY
          St_Age DESC
      ) AS RN
    FROM
      Student
  ) AS Ages
WHERE
  Ages.RN IN (1, 2);


-- Another way to write the query above is to use `WITH ... AS`
WITH
  Ages AS (
    SELECT
      St_Age,
      St_Fname,
      St_Id,
      ROW_NUMBER() OVER (
        ORDER BY
          St_Age DESC
      ) AS RN
    FROM
      Student
  )
SELECT
  *
FROM
  Ages
WHERE
  Ages.RN IN (1, 2);


/* 
out of the 3 ways we wrote the query above (using subquery, using `WITH ... AS`, and using `TOP`) the best way is to use `TOP` as there is no subquery which makes it more performant

Query Execution Steps: https://learn.microsoft.com/en-us/sql/relational-databases/query-processing-architecture-guide?view=sql-server-ver16#process-a-select-statement

it's not recommended to use subqueries because when the query has a subquery it will have those steps two times
one for the subquery and one for the outer query
 */
-- ============================
--  To get the 5th youngest student in the students table
-- Using Top
SELECT
  TOP 1 *
FROM
  (
    SELECT
      TOP 5 St_Fname,
      St_Age
    FROM
      Student
    WHERE
      St_Age IS NOT NULL
    ORDER BY
      St_Age
  ) AS YoungestFive
ORDER BY
  St_Age DESC;


-- IF you have two queries and you want to know which one performs better you can use the benchmark tool in SQL Server Management Studio
-- Using Rank
SELECT
  *
FROM
  (
    SELECT
      St_Fname,
      St_Age,
      ROW_NUMBER() OVER (
        ORDER BY
          St_Age
      ) AS RN
    FROM
      Student
    WHERE
      St_Age IS NOT NULL
  ) AS YoungestFive
WHERE
  YoungestFive.RN = 5;


-- To get the youngest student in each department
SELECT
  Dept_Id,
  MIN(St_Age) 'Min Age'
FROM
  Student
WHERE
  Dept_Id IS NOT NULL
GROUP BY
  Dept_Id;


/* 
IMPORTANT: When selecting an aggregate function we are dealing with the table as groups (Resulting from GROUP BY) or one group (The table itself if we are not using GROUP BY but selecting an aggregate function)

That is why if we want to get the sum of salaries if the number of instructors is greater than 2 we should use the `HAVING` clause instead of the `WHERE` clause because here our table is only one group (group of all instructors)

that is why you can't select a column that is not in the group by clause when selecting an aggregate function
because you are not selecting from the table but you are selecting from the group so you can only select group keys and if you want to select another column you should add it to the group by clause (when using group by you are selecting group keys)


-- TAKE NOTES!!!
 */
SELECT
  SUM(Salary) 'Total Salary'
FROM
  Instructor
HAVING
  COUNT(*) > 10;


/* 
Now to get all info about the youngest student in each department we need to use PARTITION BY with the `ROW_NUMBER` function

PARTITION BY is used with aggregate functions when we want to get an aggregate value and still want to work on the table as table not as group/s so we can use an aggregate function and still select columns from the table

Using PARTITION BY on the query below is like running `MAX(Salary) OVER (PARTITION BY Dept_Id)` on a thread and running `SELECT Ins_Name, Ins_Id` on another thread

In the query below it will select the maximum salary for each department and the instructor name and id

 */
SELECT
  Ins_Id,
  Ins_Name,
  Dept_Id,
  MAX(Salary) OVER (
    PARTITION BY
      Dept_Id
    ORDER BY
      Salary DESC
  ) AS 'Max Dep Salary'
FROM
  Instructor
WHERE
  Salary IS NOT NULL;


-- If we use GROUP BY we will only get the max salary for each department but in the query above we are getting all instructors with the max salary for their department
SELECT
  Dept_Id,
  MAX(Salary) 'Max Dep Salary'
FROM
  Instructor
WHERE
  Salary IS NOT NULL
GROUP BY
  Dept_Id;


-- To get instructors with highest salary in each department
SELECT
  *
FROM
  (
    SELECT
      Dept_Id,
      Ins_Name,
      ROW_NUMBER() OVER (
        PARTITION BY
          dept_id
        ORDER BY
          Salary DESC
      ) AS SalaryRank
    FROM
      Instructor
    WHERE
      Salary IS NOT NULL
  ) AS InstructorSalaries
WHERE
  SalaryRank = 1;


-- Check the table to make sure the query is correct
SELECT
  *
FROM
  Instructor
ORDER BY
  Dept_Id;


-- Now lets return to the query in [line 575] where we want to get the youngest student in each department
SELECT
  *
FROM
  (
    SELECT
      St_Fname,
      Dept_Id,
      St_Age,
      ROW_NUMBER() OVER (
        PARTITION BY
          Dept_Id
        ORDER BY
          St_Age
      ) AS AgeRank
    FROM
      Student
    WHERE
      St_Age IS NOT NULL
      AND Dept_Id IS NOT NULL
      -- ORDER BY -- we can't use order by here
      --   Dept_Id
  ) AS AgeRankTable
WHERE
  AgeRank = 1;


-- Check the table to make sure the query is correct
SELECT
  St_Fname,
  St_Age,
  Dept_Id
FROM
  Student
WHERE
  St_Age IS NOT NULL
  AND Dept_Id IS NOT NULL
ORDER BY
  Dept_Id;


-- We can also use TOP