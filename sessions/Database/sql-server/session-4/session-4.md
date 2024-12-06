---
title: \begin{title}\centering\vspace*{1cm}\rule{\textwidth}{0.05cm}\linebreak\vspace{0.5cm}{\Huge\bfseries Database Session 4 \par}\vspace{0.1cm}\hrule\end{title}
date: November 29, 2024
---

# DQL (Data Query Language)

DQL is used to display data from the database. The most common DQL command is `SELECT`.

DQL doesn't affect the actual data in the DB.

\begin{box4}{\textbf{Important Note:}}{blue}
When reading a SQL query read it with the order in which it gets executed (This is important in interviews).

You should also know how to divide the query into parts because this will help you understand complex queries later.
\end{box4}

Data in DB is stored in ascending ordered with the primary key.

In the examples here we will use adventureworks database. You can [download it here](https://learn.microsoft.com/en-us/sql/samples/adventureworks-install-configure?view=sql-server-ver16&tabs=ssms#download-backup-files)

# Example `SELECT` Statements

To specify I want to use `adventureworks` database I will use the following command:

```{.sql .numberLines}
-- This depends on how you named it when you restored the database
USE adventureworks;
```

Select all columns from `Product` table in `SalesLT` schema.

```{.sql .numberLines}
SELECT *
FROM SalesLT.Product;
```

Select `ProductID`, `Name` and `ProductNumber` columns from `Product` table in `SalesLT` schema.

```{.sql .numberLines}
SELECT ProductID, Name, ProductNumber
FROM SalesLT.Product;
```

Select `ProductID`, `Name` and `ProductCategoryID` columns from `Product` table in `SalesLT` schema where `ProductCategoryID` is greater than or equal to 40.

```{.sql .numberLines}
SELECT ProductID, Name, ProductCategoryID
FROM SalesLT.Product
WHERE ProductCategoryID >= 40;
```

Select `ProductID`, `Name` and `ProductCategoryID` columns from `Product` table in `SalesLT` schema where `ProductCategoryID` is greater than or equal to 40 and less than or equal to 50.

```{.sql .numberLines}
SELECT ProductID, Name, ProductCategoryID
FROM SalesLT.Product
WHERE ProductCategoryID >= 40 AND ProductCategoryID <= 50;

-- OR use the BETWEEN operator
SELECT ProductID, Name, ProductCategoryID
FROM SalesLT.Product
WHERE ProductCategoryID BETWEEN 40 AND 50;
```

Select `ProductID`, `Name` and `ProductCategoryID` columns from `Product` table in `SalesLT` schema where `ProductCategoryID` is **_NOT_** greater than or equal to 40 and less than or equal to 50.

```{.sql .numberLines}
SELECT ProductID, Name, ProductCategoryID
FROM SalesLT.Product
WHERE ProductCategoryID NOT BETWEEN 40 AND 50;
```

Select `ProductID`, `Name` and `Color` columns from `Product` table in `SalesLT` schema where `Color` is either `Black` or `Red`.

\begin{box4}{Note:}{black}
SQL can only use single quotes \texttt{'} with strings.
\tcblower
SQL is case-insensitive so \texttt{Black} and \texttt{black} are the same.
\end{box4}

```{.sql .numberLines}
SELECT ProductID, Name, Color
FROM SalesLT.Product
WHERE Color = 'Black' OR Color = 'Red' OR Color = 'Silver';
```

As an alternative to the above query you can use the `IN` operator.

```{.sql .numberLines}
SELECT ProductID, Name, Color
FROM SalesLT.Product
WHERE Color IN ('Black', 'Red', 'Silver');

-- NOT IN
SELECT ProductID, Name, Color
FROM SalesLT.Product
WHERE Color NOT IN ('Black', 'Red', 'Silver');
```

If we want to get rows where `SellEndDate` is `NULL` we can use the `IS NULL` operator. We can't use `=` operator with `NULL`.

```{.sql .numberLines}
SELECT ProductID, Name, SellEndDate
FROM SalesLT.Product
WHERE SellEndDate IS NULL;
```

The `LIKE` operator is used to search for a specified pattern in a column.

With `LIKE` you can use the following wildcards:

1. `%` - Zero or more characters.
2. `_` - A single character.

You can also use `[]` to specify a range/set of characters:

1. `[a-z]` - Any lowercase letter.
2. `[A-Z]` - Any uppercase letter.
3. `[0-9]` - Any digit.
4. `[a-zA-Z]` - Any letter.
5. `[^a-z]` - Any character that is not a lowercase letter.
6. `[^0-9]` - Any character that is not a digit.
7. `[^a-zA-Z]` - Any character that is not a letter.
8. `[abc]` - Any character that is `a`, `b` or `c`.
9. `[%]` - The `%` inside `[]` is treated as a normal percentage character, while outside it is a wildcard.
10. `[_]` - The `_` inside `[]` is treated as a normal underscore, while outside it is a wildcard.

Examples:

```{.sql .numberLines}
-- Products that have 'e' or 'E' as a second character in the name
SELECT ProductID, Name
FROM SalesLT.Product
WHERE Name LIKE '_E%';

-- Ends with 'Wheel'
SELECT ProductID, Name
FROM SalesLT.Product
WHERE Name LIKE '%Wheel';

-- Starts with 'Road'
SELECT ProductID, Name
FROM SalesLT.Product
WHERE Name LIKE 'Road%';

-- Contains 'Road' anywhere in the name
SELECT ProductID, Name
FROM SalesLT.Product
WHERE Name LIKE '%Road%';
```

More examples:

- `'a%h'`: Starts with `a` and ends with `h`.
- `'%a_'`: `a` is the second last character.
- `'[ahm]%'`: Starts with `a`, `h` or `m`.
- `'[^ahm]%'`: Doesn't start with `a`, `h` or `m`.
- `'[a-h]%'`: Starts with any character from `a` to `h`.
- `'^[a-h]%'`: Doesn't start with any character from `a` to `h`.
- `'[356]%'`: Starts with `3`, `5` or `6`.
- `'%[%]'`: Ends with `%`.
- `'%[_]%'`: Contains `_`.
- `'[_]%[_]'`: Starts and ends with `_`.

To Select just unique values you can use the `DISTINCT` keyword.

```{.sql .numberLines}
SELECT DISTINCT Color
FROM SalesLT.Product;
```

To order the result:

```{.sql .numberLines}
SELECT ProductID, Name, Color
FROM SalesLT.Product
ORDER BY Color;

-- DESC for descending order
SELECT ProductID, Name, Color
FROM SalesLT.Product
ORDER BY Color DESC;

-- Multiple columns
-- If two rows have the same value for the first column,
-- the order of the primary key is used to determine the order.
-- But here we are using the second column `Name` to determine the order
-- if the values in the first column (Color) are the same.
SELECT ProductID, Name, Color
FROM SalesLT.Product
ORDER BY Color, Name;

-- Different order for each column
SELECT ProductID, Name, Color
FROM SalesLT.Product
ORDER BY Color DESC, Name;

-- Use the number of the column instead of the name
SELECT ProductID, Name, Color
FROM SalesLT.Product
ORDER BY 3, 2; -- 3rd column then 2nd column in the selection
```

# Joins

We need to use Joins when we need to select data from multiple tables.

## Cross Join (Cartesian Product)

It's named cartesian product because it similar to the cartesian product in mathematics. Cartesian product of two sets is the set of all possible combinations of the elements of the two sets, which what happens in the cross join.

Suppose we have those two tables:

Table: Departments Table

| ID  | Name  |
| --- | ----- |
| 10  | Sales |
| 20  | IS    |
| 30  | HR    |
| 40  | Admin |

Table: Employees Table

| ID  | Name  | DeptID |
| --- | ----- | ------ |
| 1   | Ahmed | 10     |
| 2   | Aya   | 10     |
| 3   | Ali   | 20     |
| 4   | Osama | `NULL` |

`ID` is the primary key in both tables.

`DeptID` is a foreign key that references the `ID` column in the `Departments` table.

The cross join of those two tables, gives us this combination:

Table: Cross Join Result

| E.Name | D.Name |
| ------ | ------ |
| Ahmed  | Sales  |
| Aya    | Sales  |
| Ali    | Sales  |
| Osama  | Sales  |
| Ahmed  | IS     |
| Aya    | IS     |
| Ali    | IS     |
| Osama  | IS     |
| Ahmed  | HR     |
| Aya    | HR     |
| Ali    | HR     |
| Osama  | HR     |
| Ahmed  | Admin  |
| Aya    | Admin  |
| Ali    | Admin  |
| Osama  | Admin  |

Cross join has two different ways to write in SQL server:

::: {.columns .ragged columngap=1.5em column-rule="0.0pt solid black"}

1. ANSI Syntax:

```{.sql .numberLines}
SELECT E.Name, D.Name
FROM Employee E, Department D;
```

\columnbreak

2. Microsoft T-SQL Syntax:

```{.sql .numberLines}
SELECT E.Name, D.Name
FROM Employee E CROSS JOIN Department D;
```

:::

## Inner Join (Equi Join)

It's used to get the intersection of two tables.

The syntax of inner join is similar to cross join but with a `WHERE` condition. In the condition we have `PK = FK` (Primary Key = Foreign Key).

The result of the inner join of the two tables above is:

Table: Inner Join Result

| E.Name | D.Name |
| ------ | ------ |
| Ahmed  | Sales  |
| Aya    | Sales  |
| Ali    | IS     |

Inner join has two different ways to write in SQL server:

::: {.columns .ragged columngap=1.5em}

1. ANSI Syntax:

```{.sql .numberLines}
SELECT E.Name, D.Name
FROM Employee E, Department D
WHERE E.DeptID = D.ID;
```

\columnbreak

2. Microsoft T-SQL Syntax:

```{.sql .numberLines}
SELECT E.Name, D.Name
FROM Employee E CROSS JOIN Department D
ON E.DeptID = D.ID;
```

:::

Notice that in T-SQL syntax we used `ON` instead of `WHERE`.

## Outer Join

We have three types of outer joins:

1. Left Outer Join
2. Right Outer Join
3. Full Outer Join

### Left Outer Join

A Left Outer Join returns all rows from the left table (Employee), and the matched rows from the right table (Department). If there is no match, the result is NULL on the side of the right table.

The result of the left outer join of the two tables above is:

Table: Left Outer Join Result

| E.Name | D.Name |
| ------ | ------ |
| Ahmed  | Sales  |
| Aya    | Sales  |
| Ali    | IS     |
| Osama  | `NULL` |

Syntax:

```{.sql .numberLines}
SELECT E.Name, D.Name
FROM Employee E LEFT OUTER JOIN Department D
ON E.DeptID = D.ID;
```

### Right Outer Join

Right Outer Join is the opposite of the left outer join. It returns all rows from the right table (Department), and the matched rows from the left table (Employee). If there is no match, the result is NULL on the side of the left table.

The result of the right outer join of the two tables above is:

| E.Name | D.Name |
| ------ | ------ |
| Ahmed  | Sales  |
| Aya    | Sales  |
| Ali    | IS     |
| `NULL` | HR     |
| `NULL` | Admin  |

Syntax:

```{.sql .numberLines}
SELECT E.Name, D.Name
FROM Employee E RIGHT OUTER JOIN Department D
ON E.DeptID = D.ID;
```

### Full Outer Join

A Full Outer Join returns all rows when there is a match in either left (Employee) or right (Department) table. This means it returns all rows from both tables, with NULLs in places where there is no match.

The result of the full outer join of the two tables above is:

| E.Name | D.Name |
| ------ | ------ |
| Ahmed  | Sales  |
| Aya    | Sales  |
| Ali    | IS     |
| Osama  | `NULL` |
| `NULL` | HR     |
| `NULL` | Admin  |

Syntax:

```{.sql .numberLines}
SELECT E.Name, D.Name
FROM Employee E FULL OUTER JOIN Department D
ON E.DeptID = D.ID;
```

## Joins Diagram

This diagram shows the different types of joins:

![Joins Diagram](./images/Joins%20Diagram.png){width=400px}

## Examples From `AdventureWorks` Database

In Adventure Works database we have `Product`, and `ProductCategory` tables. `ProductCategoryID` in the `Product` table is a foreign key that references the `ProductCategoryID` in the `ProductCategory` table.

```{.sql .numberLines}
-- Cross Join
SELECT P.Name, PC.Name
FROM SalesLT.Product P, SalesLT.ProductCategory PC;

-- OR
SELECT P.Name, PC.Name
FROM SalesLT.Product P CROSS JOIN SalesLT.ProductCategory PC;

-- ===========================

-- Inner Join
SELECT P.Name, PC.Name
FROM SalesLT.Product P, SalesLT.ProductCategory PC
WHERE P.ProductCategoryID = PC.ProductCategoryID;

-- OR
SELECT P.Name, PC.Name
FROM SalesLT.Product P INNER JOIN SalesLT.ProductCategory PC
ON P.ProductCategoryID = PC.ProductCategoryID;

-- ===========================

-- Left Outer Join
SELECT P.Name, PC.Name
FROM SalesLT.Product P LEFT OUTER JOIN SalesLT.ProductCategory PC
ON P.ProductCategoryID = PC.ProductCategoryID;

-- ===========================

-- Right Outer Join
SELECT P.Name, PC.Name
FROM SalesLT.Product P RIGHT OUTER JOIN SalesLT.ProductCategory PC
ON P.ProductCategoryID = PC.ProductCategoryID;

-- ===========================

-- Full Outer Join
SELECT P.Name, PC.Name
FROM SalesLT.Product P FULL OUTER JOIN SalesLT.ProductCategory PC
ON P.ProductCategoryID = PC.ProductCategoryID;
```

## Self Join

Self join is a join of a table with itself. It can be cross join, inner join, left outer join, right outer join or full outer join.

Suppose we have that Employees table:

![Employees Table](./images/image.png){width=200px}

And we want to get the names of the employees who are managers.

To do that we suppose that we have two copies of Employees table with different aliases, one for the employees and the other for the managers.

::: {.columns .ragged columngap=1em}

```{.sql .numberLines}
SELECT Emps.Name, Managers.Name
FROM Employees Emps, Employees Managers
WHERE Emps.ManagerID = Managers.ID;
```

\columnbreak

This is how the two tables look like:

![Self Join](./images/Self%20Join.PNG)

:::

Suppose you have [this ITI DB](https://www.mediafire.com/file/weuyxpxt2p3i8ns/ITI.bak/file) which has this `Students` table:

![`Student` Table](images/students.png){width=400px}

There is a self relation here between the `St_Id` and `St_Super` columns, as the `St_Super` column references the `St_Id` column.

To apply self join here:

```{.sql .numberLines}
-- Cross Join
SELECT Stds.St_Fname 'Student Name', Supers.St_Fname 'Supervisor Name'
FROM Student Stds, Student Supers

-- Inner Join
SELECT Stds.St_Fname 'Student Name', Supers.St_Fname 'Supervisor Name'
FROM Student Stds INNER JOIN Student Supers
ON Stds.St_Id = Supers.St_super
```

## Multi Table Join

This is the schema of the ITI database:

![ITI DB Schema](./images/schema.png){width=400px}

As you can see we have a 3 tables: `Student`, `Course`, and `Stud_Course`. The `Stud_Course` represents the relation between the `Student` and `Course` tables. Each course the student takes has a grade which is a column in the `Stud_Course` table.

To get the names of the students and the names of the courses they are taking with their grades:

```{.sql .numberLines}
SELECT S.St_Fname 'Student Name', C.Crs_Name 'Course Name', SC.Grade
FROM Student S, Course C, Stud_Course SC
WHERE S.St_Id = SC.St_Id AND C.Crs_Id = SC.Crs_Id;

-- Using Inner Join Keyword
SELECT S.St_Fname 'Student Name', C.Crs_Name 'Course Name', SC.Grade
FROM Student S INNER JOIN Stud_Course SC
ON S.St_Id = SC.St_Id
INNER JOIN Course C
ON C.Crs_Id = SC.Crs_Id;

-- You can also apply a condition on the grade
SELECT S.St_Fname 'Student Name', C.Crs_Name 'Course Name', SC.Grade
FROM Student S, Course C, Stud_Course SC
WHERE S.St_Id = SC.St_Id AND C.Crs_Id = SC.Crs_Id AND SC.Grade >= 90;

-- OR
SELECT S.St_Fname 'Student Name', C.Crs_Name 'Course Name', SC.Grade
FROM Student S INNER JOIN Stud_Course SC
ON S.St_Id = SC.St_Id
INNER JOIN Course C
ON C.Crs_Id = SC.Crs_Id
WHERE SC.Grade >= 90;
-- Instead of using `WHERE` you can use `AND` in the `ON` clause
```

## Join With DML

You can use joins with DML (Data Manipulation Language) statements like `INSERT`, `UPDATE`, and `DELETE`.

\begin{box2}{Self Study}{black}
In this session we will only discuss \texttt{UPDATE} and \texttt{DELETE} statements with joins, and you should study \texttt{INSERT} statement with joins on your own.
\end{box2}

Update grades of students who live in `Cairo`:

```{.sql .numberLines}
UPDATE SC
SET Grade *= 1.1
FROM Student S, Stud_Course SC
WHERE S.St_Id = SC.St_Id AND S.St_Address = 'Cairo';

-- OR
UPDATE SC
SET Grade *= 1.1
FROM Stud_Course SC INNER JOIN Student S
ON S.St_Id = SC.St_Id
WHERE S.St_Address = 'Cairo';
```

This increases the grades of the students who live in Cairo by 10%.

Delete the grade of students who live in `Cairo`:

```{.sql .numberLines}
DELETE SC
FROM Student S, Stud_Course SC
WHERE S.St_Id = SC.St_Id AND S.St_Address = 'Cairo';

-- OR
DELETE SC
FROM Stud_Course SC INNER JOIN Student S
ON S.St_Id = SC.St_Id
WHERE S.St_Address = 'Cairo';
```
