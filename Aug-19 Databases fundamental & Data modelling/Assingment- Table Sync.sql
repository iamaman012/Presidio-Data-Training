CREATE DATABASE StudentDb
USE StudentDb


-- Creating the source and target tables
CREATE TABLE student_src (
    Id INT PRIMARY KEY IDENTITY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Age INT,
	CreatedAt DATETIME
);

CREATE TABLE student_tgt (
    Id INT PRIMARY KEY IDENTITY,
	StudentId INT,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Age INT,
    IsDeleted BIT DEFAULT 0,
	CreatedAt DATETIME
);


-- Stored procedures for Insertion, Updation and Deletion

CREATE OR ALTER PROCEDURE Insert_Student
    @Id INT,
    @FirstName NVARCHAR(50),
    @LastName NVARCHAR(50),
    @Age INT,
    @CreatedAt DATETIME
AS
BEGIN
    INSERT INTO student_tgt (StudentId, FirstName, LastName, Age, IsDeleted, CreatedAt)
    VALUES (@Id, @FirstName, @LastName, @Age, 0, @CreatedAt);
END;



CREATE OR ALTER PROCEDURE Update_Student
    @Id INT,
    @FirstName NVARCHAR(50),
    @LastName NVARCHAR(50),
    @Age INT
AS
BEGIN
    INSERT INTO student_tgt (StudentId, FirstName, LastName, Age, IsDeleted, CreatedAt)
    VALUES (@Id, @FirstName, @LastName, @Age, 0, GETDATE());
END;


CREATE OR ALTER PROCEDURE Delete_Student
    @Id INT
AS
BEGIN
    UPDATE student_tgt
    SET IsDeleted = 1
    WHERE StudentId = @Id;
END;


-- Triggers
CREATE OR ALTER TRIGGER Student_Insert_Trigger
ON student_src
AFTER INSERT
AS
BEGIN
    DECLARE @Id INT, @FirstName NVARCHAR(50), @LastName NVARCHAR(50), @Age INT, @CreatedAt DATETIME;

    SELECT @Id = Id, @FirstName = FirstName, @LastName = LastName, @Age = Age, @CreatedAt = CreatedAt
    FROM inserted;

    EXEC Insert_Student @Id, @FirstName, @LastName, @Age, @CreatedAt;
END;


CREATE OR ALTER TRIGGER Student_Update_Trigger
ON student_src
AFTER UPDATE
AS
BEGIN
    DECLARE @Id INT, @FirstName NVARCHAR(50), @LastName NVARCHAR(50), @Age INT, @CreatedAt DATETIME;

    SELECT @Id = Id, @FirstName = FirstName, @LastName = LastName, @Age = Age
    FROM inserted;

    EXEC Update_Student @Id, @FirstName, @LastName, @Age;
END;


CREATE OR ALTER TRIGGER Student_Delete_Trigger
ON student_src
AFTER DELETE
AS
BEGIN
    DECLARE @Id INT;

    SELECT @Id = Id
    FROM deleted;

    EXEC Delete_Student @Id;
END;



-- Testing

SELECT * FROM student_src;
SELECT * FROM student_tgt;

-- Insert into student_src
INSERT INTO student_src (FirstName, LastName, Age, CreatedAt)
VALUES ('Luffy', 'Monkey D.', 20, GETDATE());

INSERT INTO student_src (FirstName, LastName, Age, CreatedAt)
VALUES ('Ichigo', 'Kurosaki', 18, GETDATE());

SELECT * FROM student_src;
SELECT * FROM student_tgt;

-- Update student_src
UPDATE student_src
SET LastName = 'Pirate King', Age = 22
WHERE Id = 1;

SELECT * FROM student_src;
SELECT * FROM student_tgt;

-- Delete from student_src
DELETE FROM student_src
WHERE Id = 1;

SELECT * FROM student_src;
SELECT * FROM student_tgt;