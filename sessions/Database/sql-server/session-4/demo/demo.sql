-- RESTORE DATABASE [AdventureWorksLT2022] 
-- FROM DISK = N'/var/opt/mssql/data/AdventureWorksLT2022.bak' 
-- WITH FILE = 1, NOUNLOAD, REPLACE, NORECOVERY, STATS = 5


-- RESTORE DATABASE MyDatabase FROM DISK='/var/opt/mssql/data/AdventureWorksLT2022.bak'

USE AdventureWorks;

SELECT *
FROM SalesLT.Product


-- Select rows from a Table or View 'Product' in schema 'SalesLT'
SELECT ProductID, Name, ProductNumber
FROM SalesLT.Product;

SELECT ProductID, Name, ProductNumber, [ProductCategoryID]
FROM SalesLT.Product
WHERE [ProductCategoryID] >= 40;

SELECT ProductID, Name, ProductNumber
FROM SalesLT.Product
WHERE [ProductID] >= 700;

SELECT ProductID, Name, ProductNumber
FROM SalesLT.Product
WHERE [ProductID] BETWEEN 700 AND 750;

SELECT ProductID, Name, Color
FROM SalesLT.Product
WHERE Color = 'Black' OR Color = 'Red' OR Color = 'Silver';


SELECT ProductID, Name, Color
FROM SalesLT.Product
WHERE Color IN ('Black', 'Red', 'Silver');

SELECT *
FROM SalesLT.Product
WHERE [ProductCategoryID] = 35 OR [ProductCategoryID] = 18 OR [ProductCategoryID] = 27
ORDER BY [ProductCategoryID]

SELECT ProductID, Name, ProductCategoryID
FROM SalesLT.Product
WHERE ProductCategoryID IN(35,18,27)
ORDER BY ProductCategoryID


SELECT ProductID, Name, ProductCategoryID
FROM SalesLT.Product
WHERE ProductCategoryID NOT IN(35,18,27)
ORDER BY ProductCategoryID


SELECT ProductID, Name, SellEndDate
FROM SalesLT.Product
WHERE SellEndDate IS NULL
-- you can't use = with NULL

SELECT ProductID, Name, SellEndDate
FROM SalesLT.Product
WHERE SellEndDate IS NOT NULL


-- _ means one letter
-- % means any number of letters
-- LIKE is case-insensitive
-- Select products that have a name with 'e' or 'E' as a second letter since like is 
-- case-insensitive
SELECT ProductID, Name
FROM SalesLT.Product
WHERE Name LIKE '_E%'


SELECT DISTINCT [Size]
FROM SalesLT.Product
ORDER BY [Size]


-- SELECT ProductCategoryID
-- FROM SalesLT.Product
-- ORDER BY ProductCategoryID

-- SELECT ProductCategoryID
-- FROM SalesLT.ProductCategory
-- ORDER BY ProductCategoryID

-- SELECT P.Name, PC.Name
-- FROM SalesLT.Product P, SalesLT.ProductCategory PC
-- ORDER BY P.Name


-- SELECT P.Name, PC.Name
-- FROM SalesLT.Product P, SalesLT.ProductCategory PC
-- WHERE P.ProductCategoryID = PC.ProductCategoryID;

SELECT P.Name, PC.Name
FROM SalesLT.Product P LEFT OUTER JOIN SalesLT.ProductCategory PC
  ON P.ProductCategoryID = PC.ProductCategoryID;


SELECT P.Name, PC.Name
FROM SalesLT.Product P INNER JOIN SalesLT.ProductCategory PC ON P.ProductCategoryID = PC.ProductCategoryID;


SELECT P.Name, PC.Name
FROM SalesLT.Product P CROSS JOIN SalesLT.ProductCategory PC;


SELECT P.Name, PC.Name
FROM SalesLT.Product P FULL OUTER JOIN SalesLT.ProductCategory PC
  ON P.ProductCategoryID = PC.ProductCategoryID;


SELECT P.Name, PC.Name
FROM SalesLT.Product P RIGHT OUTER JOIN SalesLT.ProductCategory PC
  ON P.ProductCategoryID = PC.ProductCategoryID;


USE ITI;

SELECT *
FROM Student

SELECT Stds.St_Fname 'Student Name', Supers.St_Fname 'Supervisor Name'
FROM Student Stds INNER JOIN Student Supers
  ON Stds.St_Id = Supers.St_super


SELECT Stds.St_Fname 'Student Name', Supers.St_Fname 'Supervisor Name'
FROM Student Stds, Student Supers


SELECT S.St_Fname 'Student Name', C.Crs_Name 'Course Name', SC.Grade
FROM Student S, Course C, Stud_Course SC
WHERE S.St_Id = SC.St_Id AND C.Crs_Id = SC.Crs_Id;


SELECT S.St_Fname 'Student Name', C.Crs_Name 'Course Name', SC.Grade, S.St_Address
FROM Student S INNER JOIN Stud_Course SC
  ON S.St_Id = SC.St_Id INNER JOIN Course C ON C.Crs_Id = SC.Crs_Id
ORDER BY S.St_Address;

UPDATE SC
SET Grade *= 1.1
FROM Student S, Stud_Course SC
WHERE S.St_Id = SC.St_Id AND S.St_Address = 'Cairo';


-- remove 0.1 from the grade
UPDATE SC
SET Grade -= 0.1 * Grade
FROM Student S, Stud_Course SC
WHERE S.St_Id = SC.St_Id AND S.St_Address = 'Cairo';