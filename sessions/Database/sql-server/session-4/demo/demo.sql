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

-- m for minutes and M for months
SELECT FORMAT(GETDATE(), 'dddd dd MMMM yyyy')
SELECT FORMAT(GETDATE(), 'ddd dd MMMM yyyy')
SELECT FORMAT(GETDATE(), 'd')
SELECT FORMAT(GETDATE(), 'D')
SELECT FORMAT(GETDATE(), 'f')
SELECT FORMAT(GETDATE(), 'F')
SELECT FORMAT(GETDATE(), 'g')
SELECT FORMAT(GETDATE(), 'G')
SELECT FORMAT(GETDATE(), 'm')
SELECT FORMAT(GETDATE(), 't')
SELECT FORMAT(GETDATE(), 'T')
SELECT FORMAT(GETDATE(), 'Y')
SELECT FORMAT(GETDATE(), 'dd')
SELECT FORMAT(GETDATE(), 'ddd')
SELECT FORMAT(GETDATE(), 'ddd', 'ar')
-- Day name in Arabic
SELECT FORMAT(GETDATE(), 'ddd', 'fr')
-- Day name in French
SELECT FORMAT(GETDATE(), 'MMMM', 'ar')
-- Month name in Arabic
SELECT FORMAT(GETDATE(), 'HH')
-- 24 hours
SELECT FORMAT(GETDATE(), 'hh')
-- 12 hours
SELECT FORMAT(GETDATE(), 'mm')
SELECT FORMAT(GETDATE(), 'ss')
SELECT FORMAT(GETDATE(), 'hh:mm')
SELECT FORMAT(GETDATE(), 'hh:mm:ss')
SELECT FORMAT(GETDATE(), 'hh:mm tt')

-- ASCII, concat and concat_ws, format and cast in MS SQL server docs
-- left and right sub-string
-- left trim and right trim and trim
-- replace
-- reverse

SELECT FORMAT(123456789, '###,###,###')
-- 123,456,789

SELECT FORMAT(CAST('2022-12-31' AS DATE), N'dd/MMM/yyyy')
SELECT FORMAT(CAST('22:30' AS TIME), N'hh\:mm')

SELECT FORMAT(SYSDATETIME(), 'hh:mm tt')
-- 
SELECT FORMAT(SYSDATETIME(), 'HH:mm:ss tt')
--

SELECT UPPER(St_Fname) 'First Name'
FROM Student;

SELECT LEN('hello');


SELECT SUBSTRING('Hello', 2, 3)
-- ell
SELECT SUBSTRING('Hello', 2, 100)
-- ello
SELECT SUBSTRING('Hello', 2, LEN('Hello'))
-- ello

SELECT ASCII('a')
SELECT ASCII('A')
SELECT ASCII('Ahmed')

SELECT CHAR(65)
-- A


SELECT LEFT('Hello', 2)
-- He
SELECT RIGHT('Hello', 2)
-- lo


SELECT TRIM('  Hello  ')
-- Hello
SELECT TRIM('  Hello  ')
-- Hello

SELECT CONCAT('Hello', ' ', 'World')
-- Hello World
SELECT CONCAT('Hello', '-', 'World')
-- Hello-World

SELECT CONCAT_WS(' ', 'Hello', 'SQL', 'and', 'World')
-- Hello SQL and World
SELECT CONCAT_WS('-', 'Hello', 'SQL', 'and', 'World')
-- Hello-SQL-and-World

SELECT CONCAT_WS(' ', St_Fname, St_Lname) AS 'Full Name'
-- Student Full Name
FROM Student


SELECT COUNT(*)
FROM Student;

SELECT *
FROM Student;

SELECT COUNT(St_Address)
FROM Student;


SELECT SUM(Grade)
FROM Stud_Course;


SELECT Grade
FROM Stud_Course;


SELECT SUM(St_Age) 'Total Age'
FROM Student;

-- SELECT SUM(St_Fname) 
-- FROM Student;

SELECT AVG(Grade)
FROM Stud_Course;

SELECT SUM(Grade)/COUNT(*)
FROM Stud_Course;


SELECT MIN(Grade)
FROM Stud_Course;

SELECT MAX(Grade)
FROM Stud_Course;


SELECT Grade
FROM Stud_Course
ORDER BY Grade

SELECT MIN(St_Fname)
FROM Student;

SELECT MAX(St_Fname)
FROM Student;

SELECT St_Fname
FROM Student
ORDER BY St_Fname


SELECT IsNull(Student.St_Age,200)
FROM Student

SELECT IsNULL(St_Fname, 'No First Name') 'First Name'
FROM Student;


SELECT IsNULL(St_Address, 'No Address Available') 'Address'
FROM Student;


SELECT ISNULL(St_Lname, St_Fname) 'Name'
FROM Student;

SELECT ISNULL(NULL, 'No Value') 'Value'
-- No Value
SELECT ISNULL('Hello', 'No Value') 'Value'
-- Hello

SELECT ISNULL(St_Fname, ISNULL(St_Lname, 'No Name')) 'Name'
FROM Student;

SELECT COALESCE(St_Fname, St_Lname, 'No Name')
FROM Student

SELECT St_Fname + ' ' + CONVERT(VARCHAR(max),St_Age)
FROM Student

SELECT ISNULL(St_lname, 'No Name') + ' ' + CONVERT(VARCHAR(max),ISNULL(St_Age, 0))
FROM Student

SELECT CONCAT(St_lname ,St_Age)
FROM Student

SELECT St_lname + ' ' + CAST(St_Age AS VARCHAR(MAX))
FROM Student



-- Declare and set the date variable
DECLARE @Today DATE = '2024-12-18';

-- Using CAST
SELECT CAST(@Today AS VARCHAR(MAX));
-- 2024-12-18

-- Using CONVERT with different style numbers
SELECT CONVERT(VARCHAR(MAX), @Today, 101);
-- 12/18/2024
SELECT CONVERT(VARCHAR(MAX), @Today, 102);
-- 24.12.18
SELECT CONVERT(VARCHAR(MAX), @Today, 110);
-- 12-18-24
SELECT CONVERT(VARCHAR(MAX), @Today, 111);
-- 24/12/18


SELECT PARSE('2024-12-08' AS DATE)
-- 2024-12-08

SELECT PARSE('123' AS INT)
-- 123

SELECT PARSE('12/08/2024' AS DATE USING 'en-US')
-- 2024-12-08
SELECT PARSE('12/08/2024' AS DATE USING 'de-DE')
-- 2024-12-08

SELECT PARSE('&euro;345,98' AS MONEY USING 'de-DE')

-- Option 1: Using direct € symbol
SELECT PARSE('€345,98' AS MONEY USING 'de-DE');


-- Option 2: Using numeric value only
SELECT PARSE('345,98' AS MONEY USING 'de-DE');


-- Option 3: If you need to format with currency symbol after parsing
SELECT FORMAT(PARSE('345,98' AS MONEY USING 'de-DE'), 'C', 'de-DE');



SELECT PARSE('€345,98' AS MONEY USING 'de-DE'); -- 345,98
SELECT PARSE('345,98' AS MONEY USING 'de-DE'); -- 345,98
SELECT FORMAT(PARSE('345,98' AS MONEY USING 'de-DE'), 'C', 'de-DE'); -- 345,98 €


SELECT FORMAT(
    PARSE('345,98' AS MONEY USING 'de-DE'),
    'C',
    'de-DE'
    ); -- 345,98 €



SELECT PARSE('Mohamed Ahmed' AS DATE) -- Error
SELECT TRY_PARSE('Mohamed Ahmed' AS DATE) -- NULL


SELECT CAST('Mohamed Ahmed' AS DATE) -- Error
SELECT TRY_CAST('Mohamed Ahmed' AS DATE) -- NULL

SELECT CONVERT(DATE, 'Mohamed Ahmed') -- Error
SELECT TRY_CONVERT(DATE, 'Mohamed Ahmed') -- NULL