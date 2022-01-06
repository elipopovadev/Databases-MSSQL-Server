--1. Records’ Count
USE Gringotts
SELECT COUNT(*) AS [Count]
FROM WizzardDeposits;

--2. Longest Magic Wand
SELECT MAX(MagicWandSize) AS LongestMagicWand
FROM WizzardDeposits;

--3. Longest Magic Wand Per Deposit Groups
SELECT DepositGroup, MAX(MagicWandSize) AS LongestMagicWand
FROM WizzardDeposits
GROUP BY DepositGroup;

--4. * Smallest Deposit Group Per Magic Wand Size
SELECT  DepositGroup FROM
 (SELECT TOP(2) DepositGroup, AVG(MagicWandSize) AS AVG_MagicWandSize
  FROM WizzardDeposits
  GROUP BY DepositGroup
  ORDER BY AVG_MagicWandSize) AS T;

--5. Deposits Sum
SELECT DepositGroup, SUM(DepositAmount) AS TotalSum
FROM WizzardDeposits
GROUP BY DepositGroup;

--6. Deposits Sum for Ollivander Family
SELECT DepositGroup, SUM(DepositAmount) AS TotalSum
FROM WizzardDeposits
WHERE MagicWandCreator = 'Ollivander family'
GROUP BY DepositGroup;

--7. Deposits Filter
SELECT DepositGroup, SUM(DepositAmount) AS TotalSum
FROM WizzardDeposits
WHERE MagicWandCreator = 'Ollivander family' 
GROUP BY DepositGroup
HAVING  SUM(DepositAmount) < 150000
ORDER BY TotalSum DESC;

--8.  Deposit Charge
SELECT DepositGroup, MagicWandCreator, MIN(DepositCharge) AS MinDepositCharge
FROM WizzardDeposits
GROUP BY DepositGroup, MagicWandCreator
ORDER BY MagicWandCreator, DepositGroup;

--9. Age Groups
WITH CTE AS
(
SELECT
(CASE 
WHEN Age BETWEEN 0 AND 10 THEN  '[0-10]'
WHEN Age BETWEEN 11 AND 20 THEN '[11-20]'
WHEN Age BETWEEN 21 AND 30 THEN '[21-30]'
WHEN Age BETWEEN 31 AND 40  THEN '[31-40]'
WHEN Age BETWEEN 41 AND 50  THEN '[41-50]'
WHEN Age BETWEEN 51 AND 60  THEN '[51-60]'
ELSE '[61+]'
END) AS AgeGroup, Id
FROM WizzardDeposits
)
SELECT AgeGroup, COUNT(Id) AS WizardCount
FROM CTE
GROUP BY AgeGroup;

--10. First Letter
SELECT SUBSTRING(FirstName, 1, 1) AS FirstLetter
FROM WizzardDeposits
WHERE DepositGroup = 'Troll Chest'
GROUP BY SUBSTRING(FirstName, 1, 1);

--11. Average Interest 
SELECT DepositGroup, IsDepositExpired, AVG(DepositInterest) AS AverageInterest
FROM WizzardDeposits
WHERE DepositStartDate > '1985/01/01'
GROUP BY DepositGroup, IsDepositExpired
ORDER BY DepositGroup DESC, IsDepositExpired;

--12. * Rich Wizard, Poor Wizard
DECLARE @sumDif DECIMAL(7,2);

SET @sumDif = (
    SELECT
        SUM(curr.DepositAmount - next.DepositAmount) 
        FROM WizzardDeposits curr
        JOIN WizzardDeposits next
        ON curr.Id = next.Id + 1);

SELECT ABS(@sumDif)

--13. Departments Total Salaries
USE SoftUni
SELECT DepartmentID, Sum(Salary) AS TotalSalary
FROM Employees
GROUP BY DepartmentID;

--14. Employees Minimum Salaries
SELECT DepartmentID, MIN(Salary) AS MinimumSalary
FROM Employees
WHERE DepartmentID IN(2, 5, 7) AND HireDate > '2000/01/01'
GROUP BY DepartmentID;

--15. Employees Average Salaries
SELECT *
INTO newTableEmployees
FROM Employees
WHERE Salary > 30000;

DELETE FROM newTableEmployees
WHERE ManagerID = 42;

UPDATE newTableEmployees
SET SALARY = SALARY + 5000
WHERE DepartmentID = 1;

SELECT DepartmentID, AVG(SALARY)
FROM newTableEmployees
GROUP BY DepartmentID;

--16. Employees Maximum Salaries
SELECT DepartmentID, MAX(SALARY) AS MaxSalary
FROM Employees
GROUP BY DepartmentID
HAVING NOT MAX(SALARY) BETWEEN 30000 AND 70000;

--17. Employees Count Salaries
SELECT COUNT(SALARY) AS Count
FROM Employees
WHERE ManagerID IS NULL;

--18. *3rd Highest Salary
WITH CTE AS
(
SELECT  DepartmentID, SALARY,
DENSE_RANK() OVER (PARTITION BY DepartmentID ORDER BY SALARY DESC ) RANK_SALARY
FROM Employees
)

SELECT DISTINCT (DepartmentID), SALARY AS ThirdHighestSalary
FROM CTE
WHERE RANK_SALARY = 3;

--19. **Salary Challenge
SELECT TOP (10) FirstName, LastName, DepartmentID FROM Employees AS e1
WHERE Salary > (SELECT AVG(Salary)
               FROM Employees AS e2
			   WHERE e1.DepartmentID = e2.DepartmentID
               GROUP BY DepartmentID)
			   ORDER BY DepartmentID;













