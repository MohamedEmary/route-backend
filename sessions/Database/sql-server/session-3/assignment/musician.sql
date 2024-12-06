DROP DATABASE IF EXISTS assignmentDB;

CREATE DATABASE assignmentDB;

USE assignmentDB;

CREATE TABLE IF NOT EXISTS Musician (
    Id INT PRIMARY KEY,
    Name VARCHAR(50),
    Ph_Number VARCHAR(20),
    City VARCHAR(50),
    Street VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS Instrument (
    Name VARCHAR(50),
    Musical_Key VARCHAR(10),
    PRIMARY KEY (Name, Musical_Key)
);

CREATE TABLE IF NOT EXISTS Album (
    Id INT PRIMARY KEY,
    Title VARCHAR(100),
    Date DATE,
    Mus_Id INT,
    FOREIGN KEY (Mus_Id) REFERENCES Musician (Id)
);

CREATE TABLE IF NOT EXISTS Song (
    Title VARCHAR(100),
    Author VARCHAR(50),
    PRIMARY KEY (Title, Author)
);

CREATE TABLE IF NOT EXISTS Album_song (
    Album_Id INT,
    Song_Title VARCHAR(100),
    Song_Author VARCHAR(50),
    FOREIGN KEY (Album_Id) REFERENCES Album (Id),
    FOREIGN KEY (Song_Title, Song_Author) REFERENCES Song (Title, Author),
    PRIMARY KEY (
        Album_Id,
        Song_Title,
        Song_Author
    )
);

CREATE TABLE IF NOT EXISTS Mus_song (
    Mus_Id INT,
    Song_Title VARCHAR(100),
    Song_Author VARCHAR(50),
    FOREIGN KEY (Mus_Id) REFERENCES Musician (Id),
    FOREIGN KEY (Song_Title, Song_Author) REFERENCES Song (Title, Author),
    PRIMARY KEY (
        Mus_Id,
        Song_Title,
        Song_Author
    )
);

CREATE TABLE IF NOT EXISTS Mus_Instrument (
    Mus_Id INT,
    Inst_Name VARCHAR(50),
    FOREIGN KEY (Mus_Id) REFERENCES Musician (Id),
    FOREIGN KEY (Inst_Name) REFERENCES Instrument (Name),
    PRIMARY KEY (Mus_Id, Inst_Name)
);

-- Insert Musicians
INSERT INTO
    Musician
VALUES (
        1,
        'Mohammed Ali',
        '555-0001',
        'Cairo',
        'Al Nil Street'
    ),
    (
        2,
        'Ahmed Khalid',
        '555-0002',
        'Alexandria',
        'Al Horreya Street'
    );

-- Insert Instruments
INSERT INTO Instrument VALUES ('Oud', 'C'), ('Qanun', 'G');

-- Insert Albums
INSERT INTO
    Album
VALUES (1, 'Makan 1', '2023-01-01', 1),
    (2, 'Makan 2', '2023-02-01', 2);

-- Insert Songs
INSERT INTO
    Song
VALUES (
        'Reya7 El7ayah',
        'Hamza Namira'
    ),
    ('El Atlal', 'Umm Kulthum');

-- Insert Album_song relationships
INSERT INTO
    Album_song
VALUES (
        1,
        'Reya7 El7ayah',
        'Hamza Namira'
    ),
    (2, 'El Atlal', 'Umm Kulthum');

-- Insert Mus_song relationships
INSERT INTO
    Mus_song
VALUES (
        1,
        'Reya7 El7ayah',
        'Hamza Namira'
    ),
    (2, 'El Atlal', 'Umm Kulthum');

-- Insert Mus_Instrument relationships
INSERT INTO Mus_Instrument VALUES (1, 'Oud'), (2, 'Qanun');