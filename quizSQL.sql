-- CREATE DATABASE
CREATE DATABASE QuizDB;
GO

USE QuizDB;
GO

CREATE TABLE Users (
    UserID INT PRIMARY KEY IDENTITY(1,1),
    UserName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    UserPassword NVARCHAR(255) NOT NULL,
    UserRole NVARCHAR(20) CHECK (UserRole IN ('Teacher','Student','Admin')) NOT NULL
);

CREATE TABLE Subjects (
    SubjectID INT PRIMARY KEY IDENTITY(1,1),
    SubjectName NVARCHAR(100) NOT NULL
);

CREATE TABLE Questions (
    QuestionID INT PRIMARY KEY IDENTITY(1,1),
    SubjectID INT,
    QuestionText NVARCHAR(MAX) NOT NULL,
    ImageURL NVARCHAR(255),
    DifficultyLevel INT,
    CreatedBy INT,
    FOREIGN KEY (SubjectID) REFERENCES Subjects(SubjectID),
    FOREIGN KEY (CreatedBy) REFERENCES Users(UserID)
);
CREATE TABLE Options (
    OptionID INT PRIMARY KEY IDENTITY(1,1),
    QuestionID INT,
    OptionText NVARCHAR(255) NOT NULL,
    IsCorrect BIT NOT NULL,
    FOREIGN KEY (QuestionID) REFERENCES Questions(QuestionID)
);
CREATE TABLE Quizzes (
    QuizID INT PRIMARY KEY IDENTITY(1,1),
    Title NVARCHAR(150) NOT NULL,
    SubjectID INT,
    CreatedBy INT,
    StartTime DATETIME,
    Duration INT, -- in minutes
    RandomizeQuestions BIT DEFAULT 0,
    ShuffleOptions BIT DEFAULT 0,
    MaxAttempts INT DEFAULT 1,
    Remarks NVARCHAR(255),
    FOREIGN KEY (SubjectID) REFERENCES Subjects(SubjectID),
    FOREIGN KEY (CreatedBy) REFERENCES Users(UserID)
);
CREATE TABLE Attempts (
    AttemptID INT PRIMARY KEY IDENTITY(1,1),
    QuizID INT,
    StudentID INT,
    StartTime DATETIME,
    EndTime DATETIME,
    Score FLOAT,
    FOREIGN KEY (QuizID) REFERENCES Quizzes(QuizID),
    FOREIGN KEY (StudentID) REFERENCES Users(UserID)
);  
CREATE TABLE Answers (
    AnswerID INT PRIMARY KEY IDENTITY(1,1),
    AttemptID INT,
    QuestionID INT,
    SelectedOptionID INT,
    MarksAwarded FLOAT,
    FOREIGN KEY (AttemptID) REFERENCES Attempts(AttemptID),
    FOREIGN KEY (QuestionID) REFERENCES Questions(QuestionID),
    FOREIGN KEY (SelectedOptionID) REFERENCES Options(OptionID)
);
CREATE TABLE Results (
    ResultID INT PRIMARY KEY IDENTITY(1,1),
    AttemptID INT,
    TotalMarks FLOAT,
    ObtainedMarks FLOAT,
    Percentage FLOAT,
    FOREIGN KEY (AttemptID) REFERENCES Attempts(AttemptID)
);

CREATE TABLE Notifications (
    NotificationID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT,
    Message NVARCHAR(255),
    CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

INSERT INTO Users (UserName, Email, UserPassword, UserRole) VALUES
('Ali Khan', 'ali@student.com', '123', 'Student'),
('Sara Ahmed', 'sara@student.com', '123', 'Student'),
('Dr. Hassan', 'hassan@teacher.com', '123', 'Teacher'),
('Ahmed Student', 'ahmed@student.com', '123', 'Student'),
('Fatima Student', 'fatima@student.com', '123', 'Student'),
('Usman Student', 'usman@student.com', '123', 'Student');

INSERT INTO Subjects (SubjectName) VALUES
('Mathematics'),
('Computer Science'),
('Physics');

INSERT INTO Questions (SubjectID, QuestionText, DifficultyLevel, CreatedBy) VALUES
(1, 'What is 2 + 2?', 1, 1),
(1, 'What is 5 * 6?', 1, 1),
(2, 'What does CPU stand for?', 1, 1),
(2, 'Which language is used for web apps?', 2, 1),
(3, 'What is gravity?', 2, 1);

-- Question 1
INSERT INTO Options (QuestionID, OptionText, IsCorrect) VALUES
(1, '3', 0),
(1, '4', 1),
(1, '5', 0),
(1, '6', 0);

-- Question 2
INSERT INTO Options VALUES
(2, '30', 1),
(2, '25', 0),
(2, '35', 0),
(2, '40', 0);

-- Question 3
INSERT INTO Options VALUES
(3, 'Central Processing Unit', 1),
(3, 'Computer Personal Unit', 0),
(3, 'Central Power Unit', 0),
(3, 'Control Processing Unit', 0);

-- Question 4
INSERT INTO Options VALUES
(4, 'Python', 1),
(4, 'HTML', 1), -- multiple correct (optional case)
(4, 'C++', 0),
(4, 'Java', 1);

-- Question 5
INSERT INTO Options VALUES
(5, 'Force attracting objects', 1),
(5, 'Energy source', 0),
(5, 'Light', 0),
(5, 'Heat', 0);

INSERT INTO Quizzes 
(Title, SubjectID, CreatedBy, StartTime, Duration, RandomizeQuestions, ShuffleOptions, MaxAttempts, Remarks)
VALUES
('Math Quiz 1', 1, 1, GETDATE(), 30, 1, 1, 1, 'Basic math quiz'),
('CS Quiz 1', 2, 1, GETDATE(), 20, 1, 1, 1, 'Basic CS quiz'),
('Algebra Basics', 1, 2, GETDATE(), 15, 0, 0, 1, 'Basic algebra test'),
('Calculus Intro', 1, 2, GETDATE(), 20, 1, 1, 1, 'Derivatives and limits'),

('Programming Fundamentals', 2, 3, GETDATE(), 25, 0, 1, 1, 'C++ basics'),
('Data Structures', 2, 3, GETDATE(), 30, 1, 1, 1, 'Lists and stacks'),

('Newton Laws', 3, 2, GETDATE(), 15, 0, 0, 1, 'Physics basics');

-- Math Quiz
INSERT INTO QuizQuestions VALUES
(1, 1),
(1, 2);

-- CS Quiz
INSERT INTO QuizQuestions VALUES
(2, 3),
(2, 4);

INSERT INTO Attempts (QuizID, StudentID, StartTime, EndTime, Score)
VALUES
(1, (SELECT UserID FROM Users WHERE Email='ahmed@student.com'), GETDATE(), GETDATE(), 1),

(2, (SELECT UserID FROM Users WHERE Email='ahmed@student.com'), GETDATE(), GETDATE(), 1),

(3, (SELECT UserID FROM Users WHERE Email='fatima@student.com'), GETDATE(), GETDATE(), 1),

(1, (SELECT UserID FROM Users WHERE Email='usman@student.com'), GETDATE(), GETDATE(), 0);

INSERT INTO Answers (AttemptID, QuestionID, SelectedOptionID, MarksAwarded) VALUES
(1, 1, 2, 5),
(1, 2, 5, 5),
(2, 3, 9, 4),
(2, 4, 13, 4);

INSERT INTO Results (AttemptID, TotalMarks, ObtainedMarks, Percentage) VALUES
(1, 10, 10, 100),
(2, 10, 8, 80);

INSERT INTO Notifications (UserID, Message) VALUES
(2, 'New quiz available'),
(3, 'Your result is published');




SELECT * FROM Users
SELECT * FROM Subjects
SELECT * FROM Questions
SELECT * FROM Options
SELECT * FROM Quizzes
SELECT * FROM Attempts
SELECT * FROM Answers
SELECT * FROM Results
SELECT * FROM Notifications

ALTER TABLE Attempts
ALTER COLUMN Score INT;

Update Attempts 
SET Score = 100
WHERE AttemptID = 2

DELETE FROM Attempts
WHERE AttemptID = 8

SELECT U.UserName, Q.Title, R.Percentage
FROM Attempts A
JOIN Results R ON A.AttemptID = R.AttemptID
JOIN Quizzes Q ON A.QuizID = q.QuizID
JOIN Users U ON U.UserID = A.StudentID

SELECT q.*
FROM Quizzes q
LEFT JOIN Attempts a ON q.QuizID <> a.QuizID 
