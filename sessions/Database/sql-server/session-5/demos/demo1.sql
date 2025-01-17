-- Videos from    to    
USE ITI;


SELECT
  *
FROM
  iti.dbo.Instructor;


SELECT
  MIN(Salary)
FROM
  Instructor;


SELECT
  *
FROM
  Instructor
WHERE
  Salary = (
    SELECT
      MIN(Salary)
    FROM
      Instructor
  );


SELECT
  MIN(Salary) "Min Salary Per Dept"
FROM
  Instructor
GROUP BY
  Dept_Id;


SELECT
  MIN(Salary) "Min Salary Per Dept",
  Dept_Id
FROM
  Instructor
GROUP BY
  Dept_Id;


-- The null appears since there is no other instructors in the dept, but if
-- there is another instructor in the dept, the null will not appear since it's
-- not a value (null appears when there is no other value)
SELECT
  MIN(Salary) "Min Salary Per Dept",
  Dept_Id
FROM
  Instructor
WHERE
  Salary IS NOT NULL
GROUP BY
  Dept_Id;


-- GROUP BY makes the aggregate function work on each group, instead of the whole table
-- Goes over each employee in the table and shows the min salary for the
-- department that employee works for
SELECT
  Dept_Id,
  MIN(Salary) OVER (
    PARTITION BY
      Dept_Id
  )
FROM
  Instructor;


-- This is similar to the query in line 23, there may be a difference in performance
-- but to make sure that there is a difference in performance, we need to use a benchmark 
-- tool that will be discussed in the dotnet framework section of the course
-- We can also use sql server profiler
SELECT DISTINCT
  Dept_Id,
  MIN(Salary) OVER (
    PARTITION BY
      Dept_Id
  ) "Min Salary Per Dept"
FROM
  Instructor
WHERE
  Salary IS NOT NULL;


-- When using group by use it on a column that it's values are the same in multiple rows
-- Using it on a unique column like the primary key will be useless
SELECT
  St_Id,
  COUNT(*)
FROM
  Student
GROUP BY
  St_Id;



-- You also can't group by *. For this to work you need to have at least
-- two rows with the same values in all columns which shouldn't happen from the 
-- beginning since the primary key is unique
-- It's also not possible in code, you will get an error
-- SELECT St_Id, COUNT(*)
-- FROM Student
-- GROUP BY * -- Error
-- Count the number of students in each department
-- Here the count aggregate function works on each group from the group by
SELECT
  Dept_Id,
  COUNT(*) AS 'Number of Dep Students'
FROM
  Student
GROUP BY
  Dept_Id;


SELECT
  Dept_Id,
  COUNT(*) AS 'Number of Students'
FROM
  Student
WHERE
  Dept_Id IS NOT NULL
GROUP BY
  Dept_Id;


-- Here the count aggregate function works on the whole table
SELECT
  COUNT(*) AS 'Number of Students'
FROM
  Student;


-- Anything being selected next to the aggregate function and it's not an
-- aggregate function should be in the group by
SELECT
  St_Lname,
  COUNT(*)
FROM
  Student
GROUP BY
  St_Lname;


SELECT
  St_Fname,
  MAX(St_Age)
FROM
  Student
GROUP BY
  St_Fname;


-- Grouping by multiple columns have a similar idea to cross join
-- See images/image-1.png to understand this query
SELECT
  Dept_Id,
  St_Address,
  COUNT(*) AS 'Number of Students'
FROM
  Student
WHERE
  Dept_Id IS NOT NULL
  AND St_Address IS NOT NULL
  -- Grouping here is done by address first (the second column) 
  -- then by dept_id (the first column)
GROUP BY
  Dept_Id,
  St_Address;


-- Grouping here is done by dept first then by dept_id
-- GROUP BY Dept_Id, St_Address
-- SELECT and WHERE work on table record by record while 
-- COUNT aggregate function works on the whole table
-- That is why you can't use `AND COUNT(*) > 2` in 
-- the WHERE clause in the statement below if you want to 
-- get the number of students in each department that have
-- more than 2 students
-- SELECT Dept_Id, COUNT(*) AS 'Number of Students'
-- FROM Student
-- WHERE Dept_Id IS NOT NULL AND COUNT(*) > 2
-- GROUP BY Dept_Id
-- To change that you will need to use HAVING keyword
-- HAVING works on the groups created by the GROUP BY clause
-- HAVING is mostly used with aggregate functions
SELECT
  Dept_Id,
  COUNT(*) AS 'Number of Dep Students'
FROM
  Student
WHERE
  Dept_Id IS NOT NULL
GROUP BY
  Dept_Id
HAVING
  COUNT(*) > 2;


-- One of the few conditions we can see having without group by
-- is when we want to get the sum of all instructors salaries
-- if there is more than 10 instructors in the table for example
SELECT
  SUM(Salary) AS 'Total Salaries'
FROM
  Instructor
HAVING
  COUNT(*) > 14;


SELECT
  COUNT(*)
FROM
  -- 15
  Instructor;


-- So in general we use HAVING without GROUP BY if we want to apply
-- a condition on an aggregate function and we are not selecting 
-- that aggregate function in the SELECT clause
-- You can't use aggregate functions in the WHERE clause
-- Aggregate functions work on the whole table while WHERE works
-- on the table record by record
-- With HAVING we always have a condition with aggregation
-- that condition works on the groups created by the GROUP BY clause
-- or on the whole table if there is no GROUP BY clause and we are
-- using an aggregate function in the SELECT clause

SELECT
  Dept_Id,
  SUM(Salary) AS 'SumOfSalaries'
FROM
  Instructor
WHERE
  Dept_Id IS NOT NULL
GROUP BY
  Dept_Id;


-- The statement below is similar to the one above
-- Here we are using join
-- The performance here is worse than the one above since
-- we are applying operations on two tables
-- Generally this is not a good case for using join
-- Join is used when we want to get data from two tables
SELECT
  I.Dept_Id,
  SUM(I.Salary) AS 'SumOfSalaries'
FROM
  Instructor I,
  Department D
WHERE
  I.Dept_Id = D.Dept_Id
GROUP BY
  I.Dept_Id;


-- To show the dept name
-- Here each department have only one name
-- but we still need to group by dept_name
-- to make the query work
SELECT
  I.Dept_Id,
  D.Dept_Name,
  SUM(I.Salary) AS 'SumOfSalaries'
FROM
  Instructor I,
  Department D
WHERE
  I.Dept_Id = D.Dept_Id
GROUP BY
  I.Dept_Id,
  D.Dept_Name;


-- To select the students who act as supervisors and 
-- the number of students they supervise
-- Here we had to group by both Supr.St_Fname,Supr.St_Id
-- since we are selecting both of them in the SELECT clause
-- If we are selecting only one of them we can group by only
-- that column
-- 
-- NOTICE!! If you group by only the St_Fname column, and we 
-- have two supervisors with the same FName, the query will 
-- group them together and show the number of students they 
-- supervise together which is wrong
SELECT
  Supr.St_Fname 'Supervisor',
  Supr.St_Id 'Supervisor ID',
  COUNT(*) 'No of Students'
FROM
  Student Stud,
  Student Supr
WHERE
  Supr.St_Id = Stud.St_super
GROUP BY
  Supr.St_Fname,
  Supr.St_Id;