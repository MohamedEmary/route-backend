-- DROP DATABASE IF EXISTS assignmentDB;

CREATE DATABASE assignmentDB;

USE assignmentDB;

CREATE TABLE Instructors (
    Id INT PRIMARY KEY,
    Name VARCHAR(50),
    Address VARCHAR(100),
    Bouns FLOAT,
    Salary FLOAT,
    Hour_Rate FLOAT,
    Dep_Id INT
);

CREATE TABLE Departments (
    Id INT PRIMARY KEY,
    Name VARCHAR(50),
    Hiring_Date DATE,
    Ins_Id INT,
    FOREIGN KEY (Ins_Id) REFERENCES Instructors (Id)
);

ALTER TABLE Instructors
ADD FOREIGN KEY (Dep_Id) REFERENCES Departments (Id);

CREATE TABLE Topics ( Id INT PRIMARY KEY, Name VARCHAR(50) );

CREATE TABLE Students (
    Id INT PRIMARY KEY,
    FName VARCHAR(50),
    LName VARCHAR(50),
    Age INT,
    Address VARCHAR(100),
    Dep_Id INT,
    FOREIGN KEY (Dep_Id) REFERENCES Departments (Id)
);

CREATE TABLE Courses (
    Id INT PRIMARY KEY,
    Name VARCHAR(50),
    Duration INT,
    Description VARCHAR(100),
    top_Id INT,
    FOREIGN KEY (top_Id) REFERENCES Topics (Id)
);

CREATE TABLE Stud_Course (
    Stud_Id INT,
    Course_Id INT,
    Grade VARCHAR(10),
    PRIMARY KEY (Stud_Id, Course_Id),
    FOREIGN KEY (Stud_Id) REFERENCES Students (Id),
    FOREIGN KEY (Course_Id) REFERENCES Courses (Id)
);

CREATE TABLE Course_Instructor (
    Course_Id INT,
    Inst_Id INT,
    Evaluation VARCHAR(50),
    PRIMARY KEY (Course_Id, Inst_Id),
    FOREIGN KEY (Course_Id) REFERENCES Courses (Id),
    FOREIGN KEY (Inst_Id) REFERENCES Instructors (Id)
);

-- Instructors (initial insert without Dep_Id)
INSERT INTO
    Instructors (
        Id,
        Name,
        Address,
        Bouns,
        Salary,
        Hour_Rate
    )
VALUES (
        1,
        'John Smith',
        '123 Main St',
        1000.00,
        60000.00,
        50.00
    ),
    (
        2,
        'Jane Doe',
        '456 Oak Ave',
        1200.00,
        65000.00,
        55.00
    );

-- Departments
INSERT INTO
    Departments (Id, Name, Hiring_Date, Ins_Id)
VALUES (
        1,
        'Computer Science',
        '2023-01-15',
        1
    ),
    (
        2,
        'Mathematics',
        '2023-02-20',
        2
    );

-- Update Instructors with Dep_Id
UPDATE Instructors SET Dep_Id = 1 WHERE Id = 1;

UPDATE Instructors SET Dep_Id = 2 WHERE Id = 2;

-- Topics
INSERT INTO
    Topics (Id, Name)
VALUES (1, 'Programming'),
    (2, 'Database Systems');

-- Students
INSERT INTO
    Students (
        Id,
        FName,
        LName,
        Age,
        Address,
        Dep_Id
    )
VALUES (
        1,
        'Mohamed',
        'Emary',
        20,
        '12 Benha Qalyubia',
        1
    ),
    (
        2,
        'Ahmed',
        'Elsayed',
        22,
        '11 Maadi Cairo',
        2
    );

-- Courses
INSERT INTO
    Courses (
        Id,
        Name,
        Duration,
        Description,
        top_Id
    )
VALUES (
        1,
        'Java Programming',
        40,
        'Introduction to Java',
        1
    ),
    (
        2,
        'MySQL Database',
        30,
        'Database fundamentals',
        2
    );

-- Stud_Course
INSERT INTO
    Stud_Course (Stud_Id, Course_Id, Grade)
VALUES (1, 1, 'A'),
    (2, 2, 'B+');

-- Course_Instructor
INSERT INTO
    Course_Instructor (
        Course_Id,
        Inst_Id,
        Evaluation
    )
VALUES (1, 1, 'Excellent'),
    (2, 2, 'Very Good');