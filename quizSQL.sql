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
CREATE TABLE QuizQuestions (
    QuizID INT,
    QuestionID INT,
    PRIMARY KEY (QuizID, QuestionID),
    FOREIGN KEY (QuizID) REFERENCES Quizzes(QuizID),
    FOREIGN KEY (QuestionID) REFERENCES Questions(QuestionID)
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


SELECT * FROM Users
SELECT * FROM Subjects
SELECT * FROM Questions
SELECT * FROM Options
SELECT * FROM Quizzes
SELECT * FROM QuizQuestions
SELECT * FROM Attempts
SELECT * FROM Answers
SELECT * FROM Results
SELECT * FROM Notifications