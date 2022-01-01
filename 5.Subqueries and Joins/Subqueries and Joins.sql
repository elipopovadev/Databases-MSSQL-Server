--1.Employee Address
USE SOFTUNI
SELECT TOP (5) Employees.EmployeeId, Employees.JobTitle, Addresses.AddressID AS AddressId, Addresses.AddressText
FROM Employees
JOIN Addresses ON Employees.AddressID = Addresses.AddressID
ORDER BY Addresses.AddressID;

--2.Addresses with Towns
SELECT TOP (50) Employees.FirstName, Employees.LastName, Towns.Name AS Town, Addresses.AddressText
FROM Employees
JOIN Addresses ON Addresses.AddressID = Employees.AddressID
JOIN Towns ON Towns.TownID = Addresses.TownID
ORDER BY Employees.FirstName, Employees.LastName;

--3.Sales Employee
SELECT Employees.EmployeeID, Employees.FirstName, Employees.LastName, Departments.Name AS DepartmentName
FROM Employees
JOIN Departments ON Employees.DepartmentID = Departments.DepartmentID
WHERE Departments.Name = 'Sales'
ORDER BY Employees.EmployeeID;

--4.Employee Departments
SELECT TOP (5) Employees.EmployeeID, Employees.FirstName, Employees.Salary, Departments.Name AS DepartmentName
FROM Employees
JOIN Departments ON Employees.DepartmentID = Departments.DepartmentID
WHERE Employees.Salary > 15000
ORDER BY Employees.DepartmentID

--5.Employees Without Project
SELECT TOP(3) Employees.EmployeeID, Employees.FirstName 
FROM Employees
LEFT JOIN EmployeesProjects ON EmployeesProjects.EmployeeID = Employees.EmployeeID
WHERE EmployeesProjects.EmployeeID IS NULL
ORDER BY Employees.EmployeeID;

--6.Employees Hired After
SELECT Employees.FirstName, Employees.LastName, Employees.HireDate, Departments.Name AS DeptName
FROM Employees
JOIN Departments ON Departments.DepartmentID = Employees.DepartmentID
WHERE Employees.HireDate > '1999.1.1' AND Departments.Name IN ('Sales', 'Finance')
ORDER BY Employees.HireDate;

--7.Employees with Project
SELECT TOP(5) Employees.EmployeeID, Employees.FirstName, Projects.Name AS ProjectName 
FROM Employees
JOIN EmployeesProjects ON EmployeesProjects.EmployeeID = Employees.EmployeeID
JOIN Projects ON Projects.ProjectID = EmployeesProjects.ProjectID
WHERE Projects.StartDate > CONVERT(VARCHAR, '08/13/2002', 103) AND Projects.EndDate IS NULL
ORDER BY Employees.EmployeeID;

--8.Employee 24
SELECT	Employees.EmployeeID, Employees.FirstName, 
     CASE
		WHEN Projects.StartDate >= '2005-01-01' THEN NULL
		ELSE Projects.Name
	 END AS ProjectName
     FROM Employees
JOIN EmployeesProjects ON EmployeesProjects.EmployeeID = Employees.EmployeeID
JOIN Projects ON Projects.ProjectID = EmployeesProjects.ProjectID
WHERE Employees.EmployeeID = 24;

--9.Employee Manager
SELECT employee.EmployeeID, employee.FirstName, employee.ManagerID, manager.FirstName AS ManagerName
FROM Employees AS employee
JOIN Employees AS manager ON employee.ManagerID = manager.EmployeeID
WHERE employee.ManagerID IN(3,7)
ORDER BY employee.EmployeeID;

--10.Employee Summary
SELECT TOP(50) employee.EmployeeID, CONCAT(employee.FirstName, ' ', employee.LastName) AS EmployeeName, 
CONCAT (manager.FirstName, ' ', manager.LastName) AS ManagerName, Departments.Name AS DepartmentName
FROM Employees AS employee
JOIN Employees AS manager ON employee.ManagerID = manager.EmployeeID
JOIN Departments ON employee.DepartmentID = Departments.DepartmentID
ORDER BY employee.EmployeeID;

--11.Min Average Salary
SELECT TOP(1) AVG(Salary)
FROM Employees
GROUP BY Employees.DepartmentID
ORDER BY AVG(Salary);

--12.Highest Peaks in Bulgaria
USE Geography
SELECT MountainsCountries.CountryCode, Mountains.MountainRange, Peaks.PeakName, Peaks.Elevation
FROM Peaks
JOIN Mountains ON Mountains.ID = Peaks.MountainId
JOIN MountainsCountries ON MountainsCountries.MountainId = Peaks.MountainId
WHERE MountainsCountries.CountryCode = 'BG' AND Peaks.Elevation > 2835
ORDER BY Peaks.Elevation DESC;

--13.Count Mountain Ranges
SELECT MountainsCountries.CountryCode, COUNT(Mountains.MountainRange)
FROM MountainsCountries
JOIN Mountains ON Mountains.Id = MountainsCountries.MountainId
WHERE MountainsCountries.CountryCode IN('BG', 'RU', 'US')
GROUP BY MountainsCountries.CountryCode 
ORDER BY COUNT(Mountains.MountainRange) DESC;

--14.Countries with Rivers
SELECT TOP(5) Countries.CountryName, Rivers.RiverName
FROM Countries
LEFT JOIN CountriesRivers ON CountriesRivers.CountryCode = Countries.CountryCode
LEFT JOIN Rivers ON Rivers.Id = CountriesRivers.RiverId
WHERE Countries.ContinentCode = 'AF'
ORDER BY Countries.CountryName;

--15.*Continents and Currencies
WITH CTE AS
(
  SELECT Countries.ContinentCode, Countries.CurrencyCode, COUNT(Countries.CurrencyCode) AS CurrencyUsage, 
  DENSE_RANK() OVER(PARTITION BY Countries.ContinentCode ORDER BY COUNT(Countries.CurrencyCode) DESC) AS RN
  FROM Countries
  GROUP BY Countries.CurrencyCode, Countries.ContinentCode
)
SELECT ContinentCode, CurrencyCode, CurrencyUsage
FROM CTE
WHERE RN = 1 AND CTE.CurrencyUsage != 1
ORDER BY CTE.ContinentCode;

--16.Countries Without Any Mountains
WITH CTE AS
(
SELECT Countries.CountryCode, MountainsCountries.CountryCode AS MountainsCountryCode
FROM Countries
LEFT JOIN MountainsCountries ON MountainsCountries.CountryCode = Countries.CountryCode
WHERE MountainsCountries.CountryCode IS NULL
)
SELECT COUNT(CTE.CountryCode) AS [Count]
FROM CTE

--17.Highest Peak and Longest River by Country
USE Geography
WITH CTE_PEAKS (CountryCode, CountryName, MountainRange, PeakName, Elevation, RANK_PEAKS) AS
     (
      SELECT Countries.CountryCode, Countries.CountryName, Mountains.MountainRange, Peaks.PeakName, Peaks.Elevation,
      DENSE_RANK() OVER(PARTITION BY Countries.CountryName ORDER BY Peaks.Elevation DESC) AS RANK_PEAKS
      FROM Countries
      LEFT JOIN MountainsCountries ON MountainsCountries.CountryCode = Countries.CountryCode
      LEFT JOIN Mountains ON Mountains.Id = MountainsCountries.MountainId
      LEFT JOIN Peaks ON Peaks.MountainId = Mountains.Id
     ),
	 CTE_RIVERS (CountryCode, RiverName, RiverLength, RANK_RIVERS) AS
	 (
	  SELECT Countries.CountryCode, Rivers.RiverName, Rivers.Length AS  RiverLength,
	  DENSE_RANK() OVER(PARTITION BY Countries.CountryName ORDER BY Rivers.Length DESC) AS RANK_RIVERS
	  FROM Countries
      LEFT JOIN CountriesRivers ON CountriesRivers.CountryCode = Countries.CountryCode
      LEFT JOIN Rivers ON Rivers.ID = CountriesRivers.RiverId
	 )
SELECT TOP(5) CountryName, Elevation AS HighestPeakElevation, RiverLength AS LongestRiverLength
FROM CTE_PEAKS
LEFT JOIN  CTE_RIVERS ON CTE_RIVERS.CountryCode = CTE_PEAKS.CountryCode
WHERE RANK_RIVERS = 1 AND RANK_PEAKS = 1
ORDER BY Elevation DESC, RiverLength DESC, CountryName;

--18.Highest Peak Name and Elevation by Country
WITH CTE (CountryName, PeakName, Elevation, Peaks_Rank, MountainRange) AS
 (
  SELECT Countries.CountryName, Peaks.PeakName, Peaks.Elevation,
  DENSE_RANK() OVER(PARTITION BY Countries.CountryName ORDER BY Peaks.Elevation DESC) AS Peaks_Rank, Mountains.MountainRange
  FROM Countries
  LEFT JOIN MountainsCountries ON MountainsCountries.CountryCode = Countries.CountryCode
  LEFT JOIN Mountains ON Mountains.Id = MountainsCountries.MountainId
  LEFT JOIN PEAKS ON Peaks.MountainId = Mountains.Id
 )
SELECT TOP(5) CountryName, ISNULL(PeakName, '(no highest peak)') AS [Highest Peak Name], 
ISNULL(Elevation, 0) AS [Highest Peak Elevation], ISNULL(MountainRange, '(no mountain)') AS Mountain	
FROM CTE
WHERE Peaks_Rank = 1
ORDER BY CountryName, [Highest Peak Name]



















