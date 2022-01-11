--1.	Employees with Salary Above 35000
USE Softuni
CREATE PROCEDURE usp_GetEmployeesSalaryAbove35000 
AS
SELECT FirstName AS [First Name], LastName AS [Last Name]
FROM Employees
WHERE Salary > 35000;

EXEC usp_GetEmployeesSalaryAbove35000 
GO

--2.	Employees with Salary Above Number
CREATE PROCEDURE usp_GetEmployeesSalaryAboveNumber @NUM DECIMAL(18,4)
AS
SELECT FirstName AS [First Name], LastName AS [Last Name]
FROM [dbo].[Employees]
WHERE Salary >= @NUM;

EXEC usp_GetEmployeesSalaryAboveNumber 48100
GO

--3.	Town Names Starting With
CREATE PROCEDURE usp_GetTownsStartingWith  @SYMBOL varchar(10)
AS
SELECT [Name] AS Town
FROM [dbo].[Towns]
WHERE [Name] LIKE @SYMBOL + '%';

EXEC usp_GetTownsStartingWith b
GO

--4.	Employees from Town
CREATE PROCEDURE usp_GetEmployeesFromTown  @TownName varchar(50)
AS
SELECT FirstName AS [First Name], LastName AS [Last Name]
FROM Employees
JOIN Addresses ON Addresses.AddressID = Employees.AddressID
JOIN Towns ON Towns.TownID = Addresses.TownID
WHERE TOWNS.Name = @TownName;

EXEC usp_GetEmployeesFromTown Sofia
GO

--5.	Salary Level Function
CREATE FUNCTION ufn_GetSalaryLevel (@salary DECIMAL(18,4)) 
RETURNS varchar(10) AS
BEGIN
  DECLARE @SalaryLevel VARCHAR(10)
  SET @SalaryLevel =
    CASE 
    WHEN @salary < 30000 THEN 'Low'
    WHEN @salary > 50000 THEN 'High'
    ELSE 'Average'
    END
  RETURN @SalaryLevel
END
GO

SELECT Salary, dbo.ufn_GetSalaryLevel(Salary) AS [Salary Level]
FROM Employees
GO

--6.	Employees by Salary Level
CREATE PROCEDURE usp_EmployeesBySalaryLevel (@SalaryLevel varchar(10))
AS
SELECT FirstName AS [First Name], LastName AS [Last Name]
FROM Employees
WHERE @SalaryLevel = dbo.ufn_GetSalaryLevel(Employees.Salary);

EXEC usp_EmployeesBySalaryLevel 'high'
GO

--7.	Define Function
CREATE FUNCTION ufn_IsWordComprised (@setOfLetters nvarchar(100), @word nvarchar(100))
RETURNS bit AS
BEGIN
DECLARE @WordLength INT = LEN(@word)
	DECLARE @Index INT = 1

	WHILE (@Index <= @WordLength)
	BEGIN
		IF (CHARINDEX(SUBSTRING(@word, @Index, 1), @setOfLetters) = 0)
		BEGIN
			RETURN 0
		END

		SET @Index += 1
	END

	RETURN 1
END;

SELECT dbo.ufn_IsWordComprised('oistmiahf', 'Sofia')
SELECT dbo.ufn_IsWordComprised('oistmiahf', 'halves')
SELECT dbo.ufn_IsWordComprised('bobr', 'Rob')
SELECT dbo.ufn_IsWordComprised('pppp', 'Guy')
GO

--8.	* Delete Employees and Departments
CREATE PROCEDURE usp_DeleteEmployeesFromDepartment (@departmentId INT) 
AS
ALTER TABLE [EmployeesProjects] NOCHECK CONSTRAINT ALL -- disable all constraints in the tables
ALTER TABLE [Employees] NOCHECK CONSTRAINT ALL
ALTER TABLE [Projects] NOCHECK CONSTRAINT ALL
ALTER TABLE [Departments] NOCHECK CONSTRAINT ALL
ALTER TABLE [Addresses] NOCHECK CONSTRAINT ALL
ALTER TABLE [Towns] NOCHECK CONSTRAINT ALL

DELETE FROM [dbo].[Employees]
WHERE [dbo].[Employees].DepartmentID = @departmentId;

DELETE FROM [dbo].[Departments]
WHERE [dbo].[Departments].DepartmentID = @departmentId;

ALTER TABLE [EmployeesProjects] CHECK CONSTRAINT ALL -- re-create all constraints in the tables
ALTER TABLE [Employees] CHECK CONSTRAINT ALL
ALTER TABLE [Projects] CHECK CONSTRAINT ALL
ALTER TABLE [Departments] CHECK CONSTRAINT ALL
ALTER TABLE [Addresses] CHECK CONSTRAINT ALL
ALTER TABLE [Towns] CHECK CONSTRAINT ALL

SELECT COUNT(EmployeeID)
FROM Employees
WHERE DepartmentID = @departmentId;

EXEC usp_DeleteEmployeesFromDepartment 5
GO

--2.	Queries for Bank Database
--9.	Find Full Name
USE Bank
CREATE PROCEDURE usp_GetHoldersFullName 
AS
SELECT CONCAT(FirstName,' ', lastName) AS [Full Name]
FROM AccountHolders;

EXEC usp_GetHoldersFullName 
GO

--10.	People with Balance Higher Than
CREATE OR ALTER PROCEDURE usp_GetHoldersWithBalanceHigherThan @MONEY decimal(18,2) AS
BEGIN
WITH CTE AS 
(
SELECT AccountHolders.Id AS Id, sum(CAST(Accounts.Balance AS decimal(18,2)))  AS TotalBalance
FROM AccountHolders
LEFT JOIN Accounts ON Accounts.AccountHolderId = AccountHolders.Id
GROUP BY AccountHolders.Id
)
SELECT FirstName as [First Name], LastName as [Last Name]
FROM AccountHolders
LEFT JOIN CTE ON CTE.Id = AccountHolders.Id
WHERE CTE.TotalBalance > @MONEY
END

EXEC usp_GetHoldersWithBalanceHigherThan 20000

--11.	Future Value Function
USE BANK
CREATE FUNCTION ufn_CalculateFutureValue (@Sum decimal(16,2), @Yarly_Interest_Rate float , @Number_Years int)
RETURNS decimal(20,4) AS
BEGIN
DECLARE @Future_Sum decimal(20,4)
SET @Future_Sum = @Sum * (POWER ((1 + @Yarly_Interest_Rate), @Number_Years))
RETURN @Future_Sum
END;
	
SELECT dbo.ufn_CalculateFutureValue(1000, 0.1, 5) AS OUTPUT;
GO

--12.	Calculating Interest
CREATE OR ALTER PROCEDURE usp_CalculateFutureValueForAccount (@AccountID int, @Yarly_Interest_Rate float)
AS
BEGIN

WITH CTE ([First Name], [Last Name], [Account Id], [Current Balance]) AS 
(
 SELECT AccountHolders.FirstName, AccountHolders.LastName, Accounts.Id AS [Account Id],
 Accounts.Balance AS [Current Balance]
 FROM AccountHolders
 LEFT JOIN Accounts ON Accounts.AccountHolderId = AccountHolders.Id
 WHERE Accounts.Id = @AccountID
)

 SELECT CTE.[Account Id], CTE.[First Name], CTE.[Last Name], CTE.[Current Balance],
 dbo.ufn_CalculateFutureValue(CTE.[Current Balance],  @Yarly_Interest_Rate, 5)
 FROM CTE
 END

 EXECUTE usp_CalculateFutureValueForAccount 1, 0.1

 --3.	Queries for Diablo Database
 --13.	*Scalar Function: Cash in User Games Odd Rows
CREATE OR ALTER FUNCTION ufn_CashInUsersGames (@GameName nvarchar(100))
RETURNS TABLE
AS
RETURN
(
   WITH CTE (Name, GameId, CASH, Row#)
   AS
   (
       SELECT Games.Name, UsersGames.GameId, UsersGames.CASH,
       ROW_NUMBER() OVER(ORDER BY UsersGames.CASH DESC) AS Row#
       FROM UsersGames
       JOIN Games ON Games.ID = UsersGames.GameId
	   WHERE Games.Name = @GameName
    )   

    SELECT SUM(CTE.CASH) AS SumCash
	FROM CTE
    WHERE Row# % 2 = 1
)
GO

SELECT * FROM dbo.ufn_CashInUsersGames ('Love in a mist')

