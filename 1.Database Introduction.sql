--Problem 1. Create Database
CREATE DATABASE Minions
USE Minions

--Problem 2. Create Tables
CREATE TABLE Minions (
Id INT PRIMARY KEY,
[Name] NVARCHAR(100) NOT NULL,
Age int
)

CREATE TABLE Towns (
Id INT PRIMARY KEY,
[Name] NVARCHAR(100) NOT NULL
)

--Problem 3. Alter Minions Table
ALTER TABLE Minions
ADD TownId INT NOT NULL

ALTER TABLE Minions
ADD CONSTRAINT FK_TownId
FOREIGN KEY (TownID) REFERENCES Towns(Id)

--Problem 4. Insert Records in Both Tables
INSERT INTO Towns (Id, [Name]) VALUES 
(1,'Sofia'),
(2,'Plovdiv'),
(3,'Varna')

INSERT INTO Minions (Id, [Name], Age, TownId) Values
(1, 'Kevin', 22, 1),
(2, 'Bob', 15, 3),
(3, 'Steward', NULL, 2)

--Problem 5. Truncate Table Minions
TRUNCATE TABLE Minions

--Problem 6. Drop All Tables
DROP TABLE Minions
DROP TABLE Towns

--Problem 7. Create Table People
CREATE TABLE PEOPLE (
Id INT IDENTITY(1,1) PRIMARY KEY,
Name NVARCHAR(200) NOT NULL,
Picture VARBINARY(MAX) CHECK(DATALENGTH(Picture) > 1024 *2),
Height DECIMAL(5,2),
[Weight] DECIMAL (5,2),
Gender CHAR(1) CHECK(Gender = 'm' Or Gender = 'f') NOT NULL,
Birthdate Date NOT NULL,
Biography NVARCHAR(MAX)
)

INSERT INTO People ([Name], Picture, Height, [Weight], Gender, Birthdate, Biography) VALUES
('Ivan Ivanov', NULL, 1.90, 60.50, 'm', '08.14.1995', 'DEVELOPER'),
('Ivan Ivanov2', NULL, 1.90, 60.50, 'm', '08.14.1995', 'DEVELOPER'),
('Ivan Ivanov3', NULL, 1.90, 60.50, 'm', '08.14.1995', 'DEVELOPER'),
('Ivan Ivanov4', NULL, 1.90, 60.50, 'm', '08.14.1995', 'DEVELOPER'),
('Ivan Ivanov5', NULL, 1.90, 60.50, 'm', '08.14.1995', 'DEVELOPER')

--Problem 8. Create Table Users
CREATE TABLE Users(
Id INT IDENTITY(1,1) PRIMARY KEY,
Username VARCHAR(30) UNIQUE NOT NULL,
[Password] VARCHAR(26) NOT NULL,
ProfilePicture VARBINARY CHECK (DATALENGTH(ProfilePicture) <= 1024 * 900),
LastLoginTime DATETIME2,
IsDeleted Bit
)

INSERT INTO Users( Username, [Password], ProfilePicture, LastLoginTime, IsDeleted) VALUES
('Petur Ivanov', '1234F56FE78765', NULL, NULL, 1),
('Petur Ivanov2', '12345FE678765', NULL, NULL, 0),
('Petur Ivanov3', '12345FE678765', NULL, NULL, 1),
('Petur Ivanov4', '123456FE78765', NULL, NULL, 0),
('Petur Ivanov5', '123456FE78765', NULL, NULL, 1)

--Problem 9. Change Primary Key
ALTER TABLE Users
DROP CONSTRAINT [PK__Users__3214EC07BB3952FC]

ALTER TABLE USERS
ADD CONSTRAINT [PK_USERANDID_5452EERFEF] PRIMARY KEY (Id, Username)

--Problem 10. Add Check Constraint
ALTER TABLE USERS
ADD CONSTRAINT [Passwordlength] CHECK (LEN(Password) >= 5)

--Problem 11. Set Default Value of a Field
ALTER TABLE USERS
ADD CONSTRAINT [df_LastLoginTime] DEFAULT GETDATE() FOR LastLoginTime

--Problem 12. Set Unique Field
ALTER TABLE USERS
DROP CONSTRAINT [PK_USERANDID_5452EERFEF]

ALTER TABLE USERS
ADD CONSTRAINT [PK_ID] PRIMARY KEY(ID)

ALTER TABLE USERS
ADD CONSTRAINT [UQ_USERNAME] UNIQUE(Username)

ALTER TABLE USERS
ADD CONSTRAINT [USERNAME_LENGTHCHECK] CHECK (LEN(Username) >=3)

--Problem 13. Movies Database
CREATE DATABASE Movies
USE Movies

CREATE TABLE Directors (
Id INT PRIMARY KEY IDENTITY,
DirectorName NVARCHAR(100),
Notes NVARCHAR(MAX)
)

CREATE TABLE Genres(
Id INT PRIMARY KEY IDENTITY,
GenreName NVARCHAR(100) UNIQUE,
Notes NVARCHAR(MAX)
)

CREATE TABLE Categories(
Id INT PRIMARY KEY IDENTITY,
CategoryName NVARCHAR(100) UNIQUE,
Notes NVARCHAR(MAX)
)

CREATE TABLE Movies(
Id INT PRIMARY KEY IDENTITY,
Title NVARCHAR(100) NOT NULL,
DirectorId INT FOREIGN KEY REFERENCES Directors(Id),
CopyrightYear INT NOT NULL,
[Length] TIME NOT NULL,
GenreId INT FOREIGN KEY REFERENCES Genres(Id),
CategoryId INT FOREIGN KEY REFERENCES Categories(Id),
Rating DECIMAL(2,1),
Notes NVARCHAR(MAX)
)

INSERT INTO Directors (DirectorName, Notes) VALUES
('Ivan Ivanov', 'Golden boot Winner'),
('Stan Petrov', 'Multiple international awards'),
('James Cameron', 'FC Liverpool legend'),
('Sam Mayor', 'MK3 World Champion'),
('Dany De La Hoya', 'Very talented')

INSERT INTO Genres (GenreName,Notes) VALUES
('Comedy', 'Very funny...'),
('Action', 'Weapons mepons'),
('Horror', 'Not for children'),
('SciFi', 'Space and aliens'),
('Drama', 'OMG')

INSERT INTO Categories(CategoryName,Notes) VALUES
('1', NULL),
('2', NULL),
('3', NULL),
('4', NULL),
('5', NULL)

INSERT INTO Movies(Title,DirectorId,CopyrightYear,Length,GenreId,CategoryId,Rating,Notes) VALUES
('Captain America', 1, 1988, '1:22:00', 1, 5, 9.5, 'Superhero'),
('Mean Machine', 1, 1998, '1:40:00', 2, 4, 8.0, 'Prison'),
('Little Cow', 2, 2007, '1:35:55', 3, 3, 2.3, 'Agro'),
('Smoked Almonds', 5, 2013, '2:22:25', 4, 2, 7.8, 'Whiskey in the Jar'),
('I''m very mad!', 4, 2018, '1:30:02', 5, 1, 9.9, 'Rating 10 not supported') 


--Problem 14. Car Rental Database
CREATE DATABASE CarRental
USE CarRental

CREATE TABLE Categories(
Id INT Primary Key IDENTITY,
CategoryName NVARCHAR(50) NOT NULL,
DailyRate INT NOT NULL,
WeeklyRate INT NOT NULL,
MonthlyRate INT NOT NULL,
WeekendRate INT NOT NULL
)

CREATE TABLE Cars (
Id INT PRIMARY KEY IDENTITY,
PlateNumber NVARCHAR(30) NOT NULL,
Manifacturer NVARCHAR(30) NOT NULL,
Model NVARCHAR(30) NOT NULL,
CarYear INT NOT NULL,
CategoryId INT FOREIGN KEY REFERENCES Categories(Id),
Doors INT,
Picture VARBINARY(MAX),
Condition NVARCHAR(500),
Available BIT NOT NULL
)

CREATE TABLE Employees (
Id INT PRIMARY KEY IDENTITY,
FirstName NVARCHAR(100) NOT NULL,
LastName NVARCHAR(100) NOT NULL,
Title NVARCHAR(100),
Notes NVARCHAR(MAX),
)

CREATE TABLE CUSTOMERS (
Id INT PRIMARY KEY IDENTITY,
DriverLicenceNumber NVARCHAR(50) UNIQUE NOT NULL,
FullName NVARCHAR(100) NOT NULL,
Address NVARCHAR(100) NOT NULL,
City NVARCHAR(50) NOT NULL,
ZIPCode NVARCHAR(50),
Notes NVARCHAR(MAX) 
)

CREATE TABLE RentalOrders (
Id INT PRIMARY KEY IDENTITY,
EmployeeId INT FOREIGN KEY REFERENCES Employees(Id),
CustomerId INT FOREIGN KEY REFERENCES Customers(Id),
CarId INT FOREIGN KEY REFERENCES Cars(Id),
TankLevel INT NOT NULL,
KilometrageStart INT NOT NULL,
KilometrageEnd INT NOT NULL,
TotalKilometrage AS KilometrageEnd - KilometrageStart,
StartDate DATE NOT NULL,
EndDate DATE NOT NULL,
TotalDays AS DATEDIFF(DAY, EndDate, StartDate),
RateApplied INT NOT NULL,
TaxRate AS RateApplied * 0.2,
OrderStatus BIT NOT NULL,
Notes NVARCHAR(MAX)
)

INSERT INTO Categories VALUES
('Limousine', 65, 350, 1350, 120),
('SUV', 85, 500, 1800, 160),
('Economic', 40, 230, 850, 70)

INSERT INTO Cars VALUES
('B8877PP', 'Audi', 'A6', 2001, 1, 4, NULL, 'Good', 1),
('GH17GH78', 'Opel', 'Corsa', 2014, 3, 5, NULL, 'Very good', 0),
('CT17754GT', 'VW', 'Touareg', 2008, 2, 5, NULL, 'Zufrieden', 1)

INSERT INTO Employees VALUES
('Stancho', 'Mihaylov', NULL, NULL),
('Doncho', 'Petkov', NULL, NULL),
('Stamat', 'Jelev', 'DevOps', 'Employee of the year')

INSERT INTO Customers(DriverLicenceNumber, FullName, Address, City) VALUES
('AZ18555PO', 'Michael Smith', 'Medley str. 25', 'Chikago'),
('LJ785554478', 'Sergey Ivankov', 'Shtaigich 37', 'Perm'),
('LK8555478', 'Franc Joshua', 'Dorcel str. 56', 'Paris')

INSERT INTO RentalOrders(EmployeeId, CustomerId, CarId, TankLevel, KilometrageStart, KilometrageEnd, 
StartDate, EndDate, RateApplied, OrderStatus) VALUES
(1, 2, 3, 45, 18005, 19855, '2007-08-08', '2007-08-10', 250, 1),
(3, 2, 1, 50, 55524, 56984, '2009-09-06', '2009-09-28', 1500, 0),
(2, 2, 1, 18, 36005, 38547, '2017-05-08', '2017-06-09', 850, 0)


--Problem 15. Hotel Database
CREATE DATABASE Hotel
USE HOTEL

CREATE TABLE Employees (
	Id INT PRIMARY KEY IDENTITY,
	FirstName NVARCHAR(100) NOT NULL,
	LastName NVARCHAR(100) NOT NULL,
	Title NVARCHAR(30),
	Notes NVARCHAR(MAX)
)

CREATE TABLE Customers (
	AccountNumber INT PRIMARY KEY IDENTITY,
	FirstName NVARCHAR(100) NOT NULL,
	LastName NVARCHAR(100) NOT NULL,
	PhoneNumber NVARCHAR(30),
	EmergencyName NVARCHAR(30),
	EmergencyNumber NVARCHAR(30),
	Notes NVARCHAR(MAX) 
)

CREATE TABLE RoomStatus (
	RoomStatus NVARCHAR(30) PRIMARY KEY NOT NULL,
	Notes NVARCHAR(MAX)
)

CREATE TABLE RoomTypes (
	RoomType NVARCHAR(50) PRIMARY KEY NOT NULL,
	Notes NVARCHAR(MAX)
)

CREATE TABLE BedTypes (
	BedType NVARCHAR(50) PRIMARY KEY NOT NULL,
	Notes NVARCHAR(MAX)
)

CREATE TABLE Rooms (
	RoomNumber INT PRIMARY KEY NOT NULL,
	RoomType NVARCHAR(50) FOREIGN KEY REFERENCES RoomTypes(RoomType) NOT NULL,
	BedType NVARCHAR(50) FOREIGN KEY REFERENCES BedTypes(BedType) NOT NULL,
	Rate DECIMAL(6,2) NOT NULL,
	RoomStatus BIT NOT NULL,
	Notes NVARCHAR(MAX)
)

CREATE TABLE Payments (
	Id INT PRIMARY KEY IDENTITY,
	EmployeeId INT FOREIGN KEY REFERENCES Employees(Id) NOT NULL,
	PaymentDate DATETIME NOT NULL,
	AccountNumber INT FOREIGN KEY REFERENCES Customers(AccountNumber) NOT NULL,
	FirstDateOccupied DATE NOT NULL,
	LastDateOccupied DATE NOT NULL,
	TotalDays AS DATEDIFF(DAY, FirstDateOccupied, LastDateOccupied),
	AmountCharged DECIMAL(7, 2) NOT NULL,
	TaxRate DECIMAL(6,2) NOT NULL,
	TaxAmount AS AmountCharged * TaxRate,
	PaymentTotal AS AmountCharged + AmountCharged * TaxRate,
	Notes NVARCHAR(1500)
)

CREATE TABLE Occupancies (
	Id INT PRIMARY KEY IDENTITY,
	EmployeeId INT FOREIGN KEY REFERENCES Employees(Id) NOT NULL,
	DateOccupied DATE NOT NULL,
	AccountNumber INT FOREIGN KEY REFERENCES Customers(AccountNumber) NOT NULL,
	RoomNumber INT FOREIGN KEY REFERENCES Rooms(RoomNumber) NOT NULL,
	RateApplied DECIMAL(7, 2) NOT NULL,
	PhoneCharge DECIMAL(8, 2) NOT NULL,
	Notes NVARCHAR(1000)
)

INSERT INTO Employees(FirstName, LastNAme) VALUES
('Galin', 'Zhelev'),
('Stoyan', 'Ivanov'),
('Petar', 'Ikonomov')

INSERT INTO Customers(FirstName, LastName, PhoneNumber) VALUES
('Monio', 'Ushev', '+359888666555'),
('Gancho', 'Stoykov', '+359866444222'),
('Genadi', 'Dimchov', '+35977555333')

INSERT INTO RoomStatus(RoomStatus) VALUES
('occupied'),
('non occupied'),
('repairs')

INSERT INTO RoomTypes(RoomType) VALUES
('single'),
('double'),
('appartment')

INSERT INTO BedTypes(BedType) VALUES
('single'),
('double'),
('couch')

INSERT INTO Rooms(RoomNumber, RoomType, BedType, Rate, RoomStatus) VALUES
(201, 'single', 'single', 40.0, 1),
(205, 'double', 'double', 70.0, 0),
(208, 'appartment', 'double', 110.0, 1)

INSERT INTO Payments(EmployeeId, PaymentDate, AccountNumber, FirstDateOccupied, LastDateOccupied, AmountCharged, TaxRate) VALUES
(1, '2011-11-25', 2, '2017-11-30', '2017-12-04', 250.0, 0.2),
(3, '2014-06-03', 3, '2014-06-06', '2014-06-09', 340.0, 0.2),
(3, '2016-02-25', 2, '2016-02-27', '2016-03-04', 500.0, 0.2)

INSERT INTO Occupancies(EmployeeId, DateOccupied, AccountNumber, RoomNumber, RateApplied, PhoneCharge) VALUES
(2, '2011-02-04', 3, 205, 70.0, 12.54),
(2, '2015-04-09', 1, 201, 40.0, 11.22),
(3, '2012-06-08', 2, 208, 110.0, 10.05)


--Problem 16. Create SoftUni Database
CREATE DATABASE Softuni
use Softuni
CREATE TABLE Towns (
	Id INT PRIMARY KEY IDENTITY NOT NULL,
	Name VARCHAR(50) NOT NULL
)

CREATE TABLE Addresses (
	Id INT PRIMARY KEY IDENTITY NOT NULL,
	AddressText NVARCHAR(100) NOT NULL,
	TownId INT FOREIGN KEY REFERENCES Towns(Id) NOT NULL
)

CREATE TABLE Departments (
	Id INT PRIMARY KEY IDENTITY NOT NULL,
	Name VARCHAR(80) NOT NULL
)

CREATE TABLE Employees (
	Id INT PRIMARY KEY IDENTITY NOT NULL,
	FirstName NVARCHAR(30) NOT NULL,
	MiddleName NVARCHAR(30) NOT NULL,
	LastName NVARCHAR(30) NOT NULL,
	JobTitle NVARCHAR(80) NOT NULL,
	DepartmentId INT FOREIGN KEY REFERENCES Departments(Id) NOT NULL,
	HireDate DATE,
	Salary DECIMAL(7,2),
	AddressId INT FOREIGN KEY REFERENCES Addresses(Id)
)

--Problem 18. Basic Insert
Use Softuni
INSERT INTO Towns VALUES
('Sofia'),
('Plovdiv'),
('Varna'),
('Burgas')

INSERT INTO Departments VALUES
('Engineering'),
('Sales'),
('Marketing'),
('Software Development'),
('Quality Assurance')

INSERT INTO Employees(FirstName, MiddleName, LastName, JobTitle, DepartmentId, HireDate, Salary ) VALUES
('Ivan', 'Ivanov', 'Ivanov', '.NET Developer', 4, '2013-02-01', 3500.00),
('Petar', 'Petrov', 'Petrov', 'Senior Engineer', 1, '2004-03-02', 4000.00),
('Maria', 'Petrova', 'Ivanova', 'Intern', 5, '2016-08-28', 525.25),
('Georgi', 'Teziev', 'Ivanov', 'CEO', 2, '2007-12-09', 3000.00),
('Peter', 'Pan', 'Pan', 'Intern', 3, '2016-08-28', 599.88)

--Problem 19. Basic Select All Fields
SELECT * FROM Towns
SELECT * FROM Departments
SELECT * FROM Employees

--Problem 20. Basic Select All Fields and Order Them
SELECT * FROM Towns ORDER BY NAME 
SELECT * FROM Departments ORDER BY NAME
SELECT * FROM Employees ORDER BY Salary DESC

--Problem 21. Basic Select Some Fields
SELECT [Name] FROM Towns ORDER BY NAME 
SELECT [Name] FROM Departments ORDER BY NAME
SELECT FirstName, LastName, JobTitle, Salary FROM Employees ORDER BY Salary DESC

--Problem 22. Increase Employees Salary
Use Softuni
UPDATE Employees
SET Salary = Salary + (Salary * 10/100)
SELECT Salary FROM Employees 

--Problem 23. Decrease Tax Rate
USE HOTEL
UPDATE Payments
SET TaxRate = TaxRate - (TaxRate * 3/100)
SELECT TaxRate FROM Payments

--Problem 24. Delete All Records
TRUNCATE TABLE Occupancies 

