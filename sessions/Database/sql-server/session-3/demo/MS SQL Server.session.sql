-- SELECT @@SERVERNAME
-- SELECT @@VERSION
-- DECLARE @student VARCHAR(10) = 'Mohamed';
-- SET @student = 'Ahmed';
-- SELECT @student
-- DECLARE @10chars VARCHAR(10) = '0123456789';
-- SELECT @10chars;-- 0123456789
-- SET @10chars = '0123456789ABC';
-- SELECT @10chars;-- 0123456789
-- DROP TABLE students;
-- CREATE TABLE students
-- (
--     id INT PRIMARY KEY IDENTITY(0, 10),
--     FName VARCHAR(20) NOT NULL,
--     [Second Name] VARCHAR(20)
-- );
-- INSERT INTO students
--     (FName, [Second Name])
-- VALUES('Mohamed', 'Ali');
-- INSERT INTO students
--     (FName, [Second Name])
-- VALUES('Ahmed', 'Khalid');
-- INSERT INTO students
--     (FName,[Second Name])
-- VALUES('Khalid', 'Ali');
-- SELECT *
-- FROM students;
-- CREATE TABLE people.employees (
--     id INT PRIMARY KEY,
--     FName VARCHAR(20) NOT NULL,
--     LName VARCHAR(20) NOT NULL
-- );
-- ===================================

-- SELECT @@SERVERNAME;


-- USE MASTER;

-- ALTER DATABASE [test]
-- SET single_user WITH ROLLBACK IMMEDIATE;

-- DROP DATABASE [test];

-- CREATE DATABASE [test];

USE test;

CREATE TABLE Employees
(
    Id INT PRIMARY KEY IDENTITY(1, 1),
    FName VARCHAR(40) NOT NULL,
    LName VARCHAR(40) NOT NULL,
    -- F or M
    Gender CHAR(1),
    -- 999999.99 (not more than 1 million)
    Salary DECIMAL(8, 2),
    Address VARCHAR(100) DEFAULT 'Cairo',
    BirthDate DATE,
    -- references Departments
    DepNum INT,
    SuperId INT REFERENCES Employees (Id),
);

CREATE TABLE Departments
(
    DepNum INT PRIMARY KEY,
    DepName VARCHAR(40) NOT NULL,
    [Manager Id] INT REFERENCES Employees (Id),
    [Hiring Date] DATE
);

CREATE TABLE Department_Locations
(
    DepNum INT REFERENCES Departments (DepNum),
    Location VARCHAR(100),
    PRIMARY KEY (DepNum, Location)
);

CREATE TABLE Projects
(
    PNum INT PRIMARY KEY IDENTITY(100, 100),
    PName VARCHAR(100) NOT NULL,
    Location VARCHAR(100),
    City VARCHAR(100),
    DepNum INT REFERENCES Departments (DepNum)
);

CREATE TABLE Dependents
(
    [Name] VARCHAR(50),
    EmpId INT REFERENCES Employees (Id),
    PRIMARY KEY (EmpId, [Name]),
    BirthDate DATE,
    Gender CHAR(1),
);

-- ALTER TABLE Departments
-- DROP CONSTRAINT UQ_ManagerId;

-- ALTER TABLE Departments
-- ALTER COLUMN [Manager Id] INT NOT NULL;

-- ALTER TABLE Departments
-- ADD CONSTRAINT UQ_ManagerId UNIQUE([Manager Id]);

-- ALTER TABLE Departments
-- ADD UNIQUE([Manager Id]);

-- ALTER TABLE Departments
-- ADD FOREIGN KEY([Manager Id]) REFERENCES Employees(Id)

-- ALTER TABLE Departments
-- Drop CONSTRAINT UQ__Departme__BE9BE5394AC6E294

-- ============================================

-- Drop the relation
-- ALTER TABLE Departments
-- DROP CONSTRAINT FK__Departmen__Manag__3B75D760

-- Add constraints
-- ALTER TABLE Departments
-- ALTER COLUMN [Manager Id] int NOT NULL;

-- ALTER TABLE Departments
-- ADD CONSTRAINT UQ_ManagerId UNIQUE([Manager Id]);

-- Add Relation Again
-- ALTER TABLE Departments
-- ADD FOREIGN KEY ([Manager Id]) REFERENCES Employees(Id);

-- ALTER TABLE Employees
-- ADD FOREIGN KEY(DepNum) REFERENCES Departments(DepNum);


-- INSERT INTO Employees
-- VALUES('Mohamed', 'Ali', 'M', 10000, 'Cairo', '1990-01-01', NULL, NULL);

-- TRUNCATE TABLE Employees;

-- INSERT INTO Employees
-- VALUES
--     ('Mohamed', 'Ali', 'M', 10000, 'Cairo', '1990-01-01', NULL, NULL),
--     ('Ahmed', 'Khalid', 'M', 15000, 'Giza', '1995-01-01', NULL, NULL),
--     ('Khalid', 'Ali', 'M', 12000, 'Alex', '1993-01-01', NULL, NULL),
--     ('Ali', 'Mohamed', 'M', 12000, 'Alex', '1993-01-01', NULL, NULL),
--     ('Mahmoud', 'Ahmed', 'M', 9000, 'Benha', '1998-01-01', NULL, NULL),
--     ('Fatma', 'Ali', 'F', 8000, 'Cairo', '1999-01-01', NULL, NULL),
--     ('Nada', 'Khalid', 'F', 7000, 'Giza', '2000-01-01', NULL, NULL),
--     ('Hassan', 'Mohamed', 'M', 6000, 'Alex', '2001-01-01', NULL, NULL),
--     ('Mona', 'Ahmed', 'F', 5000, 'Benha', '2002-01-01', NULL, NULL),
--     ('Sara', 'Ali', 'F', 4000, 'Cairo', '2003-01-01', NULL, NULL),
--     ('Omar', 'Khalid', 'M', 3000, 'Giza', '2004-01-01', NULL, NULL),
--     ('Amr', 'Mohamed', 'M', 2000, 'Alex', '2005-01-01', NULL, NULL),
--     ('Noha', 'Ahmed', 'F', 1000, 'Benha', '2006-01-01', NULL, NULL);


-- Select rows from a Table or View 'Employees' in schema 'dbo'
SELECT *
FROM dbo.Employees