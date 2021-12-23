--Problem 1.One-To-One Relationship
CREATE DATABASE Register
 --dbo.Passports with PRIMARY KEY INCREMENT and dbo.Persons with PRIMARY KEY INCREMENT are created with GUI
 --PassportID and PassportNumber are set to Unique in both tables with GUI
ALTER TABLE Persons
ADD CONSTRAINT FK_Persons_PassportsID
FOREIGN KEY (PassportID) REFERENCES Passports(PassportID);

--Problem 2.One-To-Many Relationship
CREATE DATABASE Cars
--dbo.Models with PRIMARY KEY INCREMENT and dbo.Manufacturers with PRIMARY KEY INCREMENT are created with GUI
ALTER TABLE Models
ADD CONSTRAINT FK_Model_Manufacturer
FOREIGN KEY (ManufacturerID) REFERENCES Manufacturers(ManufacturerID);

--Problem 3.Many-To-Many Relationship
CREATE DATABASE School
--dbo.Students with PRIMARY KEY INCREMENT StudentID, dbo.Exams with PRIMARY KEY ExamID and dbo.StudentsExams with Composite PRIMARY KEY are created
ALTER TABLE StudentsExams
ADD CONSTRAINT FK_StudentID_StudentID
FOREIGN KEY (StudentID) REFERENCES Students(StudentID);

ALTER TABLE StudentsExams
ADD CONSTRAINT FK_ExamID_ExamID
FOREIGN KEY (ExamID) REFERENCES Exams(ExamID);

--Problem 4.Self-Referencing 
USE School
CREATE TABLE Teachers (
TeacherID int PRIMARY KEY  NOT NULL,
Name VARCHAR(50) UNIQUE NOT NULL,
ManagerID int 
)
-- Data is inserted in dbo.Teachers with GUI
ALTER TABLE Teachers
ADD CONSTRAINT FK_ManagerID_TeacherID
FOREIGN KEY (ManagerID) References Teachers(TeacherID);

--Problem 5.Online Store Database
CREATE DATABASE Store;

Create TABLE Orders (
OrderID int PRIMARY KEY,
CustomerID int NOT NULL
)

CREATE TABLE Customers (
CustomerID int PRIMARY KEY,
[Name] varchar(50) NOT NULL,
Birthday date NOT NULL,
CityID int NOT NULL
)

CREATE TABLE Cities (
CityID int PRIMARY KEY,
[Name] varchar(50) NOT NULL
)

CREATE TABLE OrderItems (
OrderID int NOT NULL,
ItemID int NOT NULL,
)

ALTER TABLE OrderItems
Add Constraint PK_OrderID_ItemID PRIMARY Key(OrderID, ItemID);

CREATE TABLE Items (
ItemID int PRIMARY KEY,
[Name] varchar(50) NOT NULL,
ItemTypeID int NOT NULL
)

CREATE TABLE ItemTypes (
ItemTypeID int PRIMARY KEY,
[Name] varchar(50) NOT NULL
)

ALTER TABLE Orders
ADD FOREIGN KEY (CustomerID)
REFERENCES Customers(CustomerID);

ALTER TABLE OrderItems
ADD FOREIGN KEY (OrderID)
REFERENCES Orders(OrderID);

ALTER TABLE OrderItems
ADD FOREIGN KEY(ItemID)
REFERENCES Items(ItemID);

ALTER TABLE Items
ADD FOREIGN KEY(ItemTypeID)
REFERENCES ItemTypes(ItemTypeID);

ALTER TABLE Customers
ADD FOREIGN KEY(CityID)
REFERENCES Cities(CityID);

--Problem 6.University Database
CREATE DATABASE University;
CREATE TABLE Majors (
MajorID int PRIMARY KEY,
[Name] nvarchar(50) NOT NULL
)

CREATE TABLE Payments (
PaymentID int PRIMARY KEY,
PaymentDate date NOT NULL,
PaymentAmount decimal NOT NULL,
StudentID int NOT NULL
)

CREATE TABLE Students (
StudentID int PRIMARY KEY,
StudentNumber int NOT NULL,
StudentName nvarchar(50),
MajorID int NOT NULL
)

CREATE TABLE Agenda (
StudentID int NOT NULL,
SubjectID int NOT NULL
)

ALTER TABLE Agenda
ADD Constraint PK_Agenda
PRIMARY KEY (StudentID,SubjectID);

CREATE TABLE Subjects (
SubjectID int PRIMARY KEY,
SubjectName nvarchar(50) NOT NULL
)

ALTER TABLE Payments
ADD FOREIGN KEY (StudentID)
REFERENCES Students(StudentID);

ALTER TABLE Students
ADD FOREIGN KEY (MajorID)
REFERENCES Majors(MajorID);

ALTER TABLE Agenda
ADD FOREIGN KEY (StudentID)
REFERENCES Students (StudentID);

ALTER TABLE Agenda
ADD FOREIGN KEY (SubjectID)
REFERENCES Subjects (SubjectID);

--Problem 9.*Peaks in Rila
USE Geography
SELECT Mountains.MountainRange, Peaks.PeakName, Peaks.Elevation
FROM Peaks
JOIN Mountains ON Peaks.MountainId = Mountains.Id
WHERE Mountains.MountainRange = 'Rila'
ORDER BY Peaks.Elevation DESC;

