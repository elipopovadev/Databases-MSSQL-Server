--2.Find All Information About Departments
USE SoftUni
SELECT *
 FROM Departments;

--3.Find all Department Names
SELECT [Name]
 FROM Departments;

--4.Find Salary of Each Employee
SELECT FirstName, LastName, Salary
 FROM Employees;

--5.Find Full Name of Each Employee
 SELECT FirstName, MiddleName, LastName
  FROM Employees;

--6.Find Email Address of Each Employee
SELECT (FirstName + '.' + LastName + '@softuni.bg') AS [Full Email Address] 
 FROM Employees;

--7.Find All Different Employee’s Salaries
SELECT DISTINCT Salary
 FROM Employees;

--8.Find all Information About Employees
SELECT *
 FROM Employees
  WHERE JobTitle LIKE 'Sales Representative';

--9.Find Names of All Employees by Salary in Range
SELECT FirstName, LastName, JobTitle
 FROM Employees
  WHERE Salary >= 20000 AND Salary <= 30000;

--10.Find Names of All Employees 
SELECT ([FirstName] + ' ' + [MiddleName] + ' ' + [LastName]) AS [Full Name]
 FROM Employees
  WHERE Salary IN (25000, 1400, 12500, 23600);

--11.Find All Employees Without Manager
SELECT FirstName, LastName
 From Employees
  WHERE ManagerID IS NULL;

--12.Find All Employees with Salary More Than 50000
SELECT FirstName, LastName, Salary
 FROM Employees
  WHERE Salary > 50000
   Order By Salary DESC;

--13.Find 5 Best Paid Employees
SELECT TOP(5) FirstName, LastName
 FROM Employees
  ORDER BY SALARY DESC;

--14.Find All Employees Except Marketing
SELECT FirstName, LastName
 FROM Employees
  WHERE DepartmentID != 4;

--15.Sort Employees Table
SELECT *
 FROM Employees
  Order BY Salary DESC, FirstName, lastName DESC, MiddleName;
   GO

--16.Create View Employees with Salaries
CREATE VIEW v_EmployeesSalary AS
SELECT FirstName, LastName, Salary
 FROM Employees;
  GO

--17.Create View Employees with Job Titles
CREATE VIEW v_EmployeesJobTitles AS
SELECT (FirstName + ' ' + ISNULL(MiddleName, '') + ' ' + LastName) AS [Full Name], JobTitle
 FROM EMPLOYEES
  GO

--18.Distinct Job Titles
SELECT DISTINCT JobTitle 
 FROM Employees

--19.Find First 10 Started Projects
SELECT TOP(10) ProjectID, [Name], Description, StartDate, EndDate
  FROM Projects
     ORDER BY StartDate, [Name];

--20.Last 7 Hired Employees
SELECT TOP(7) FirstName, LastName, HireDate
 FROM Employees
   ORDER BY HireDate DESC;

--21.Increase Salaries
-- I created backup with GUI	
UPDATE Employees
SET Salary = Salary + Salary * 12/100
WHERE DepartmentID IN (1, 2 , 4, 11);

Use SoftUni
SELECT Salary
FROM Employees;

USE master
GO

-- I get this backup like SoftUniRestored2 and unchecked in Options: Take tail-log backup before restore; starts with right click on Databases
Use SoftUniRestored2
SELECT Salary
FROM Employees;


--22.All Mountain Peaks
USE Geography;
Select PeakName
 From Peaks
  ORDER BY PeakName;

--23.Biggest Countries by Population
SELECT TOP(30) CountryName, Population
 From Countries
  WHERE ContinentCode LIKE 'EU'
   ORDER BY [Population] DESC, CountryName;

--24.*Countries and Currency (Euro / Not Euro)
SELECT CountryName, CountryCode, Currency =
 Case CurrencyCode
    When 'EUR' THEN 'EURO'
    ELSE 'NOT EURO'
    END
FROM Countries
 ORDER BY CountryName;

--25. All Diablo Characters
USE Diablo
SELECT [Name]
 FROM Characters
  ORDER BY [NAME] ASC;