CREATE DATABASE hr_project;
USE hr_project;

# Q1 Average Attrition rate for all Departments

CREATE TABLE hr1 (
    EmployeeNumber INT,
    Department VARCHAR(50),
    Attrition VARCHAR(10)
);
SELECT * FROM hr1 LIMIT 10;
SELECT COUNT(*) FROM hr1;
SELECT 
    Department,
    ROUND(
        (SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*)) * 100,
        2
    ) AS Attrition_Rate_Percentage
FROM hr1
GROUP BY Department;

# Q2

CREATE TABLE hr2 (
    EmployeeID INT,
    HourlyRate INT
);
DESCRIBE hr1;
ALTER TABLE hr1
ADD COLUMN HourlyRate INT;
ALTER TABLE hr1
ADD COLUMN Gender VARCHAR(10);
ALTER TABLE hr1 ADD COLUMN jobrole VARCHAR(50);
ALTER TABLE hr1 
MODIFY COLUMN jobrole VARCHAR(50);


select * from hr1 limit 10;
SELECT JobRole, COUNT(*) 
FROM hr1
GROUP BY JobRole;
SELECT DISTINCT JobRole 
FROM hr1;
ALTER TABLE hr1 
DROP COLUMN jobrole;
ALTER TABLE hr1
ADD COLUMN JobRole VARCHAR(50);
SELECT DISTINCT JobRole FROM hr1;
SELECT 
ROUND(AVG(HourlyRate), 2) AS Avg_Hourly_Rate_Male_Research_Scientist
FROM hr1
WHERE Gender = 'Male'
AND JobRole = 'Research Scientist';

# Q3 Attrition rate Vs Monthly income stats
 
 CREATE TABLE hr2 (
    EmployeeID INT,
    MonthlyIncome INT
);
SELECT * FROM hr2 LIMIT 10;
SELECT EmployeeID, COUNT(*)
FROM hr2
GROUP BY EmployeeID
HAVING COUNT(*) > 1;
SELECT 
    hr1.EmployeeNumber,
    hr1.Attrition,
    hr2.MonthlyIncome
FROM hr1
JOIN hr2
ON hr1.EmployeeNumber = hr2.EmployeeID
LIMIT 10;

SELECT 
    hr1.Attrition,
    COUNT(hr1.EmployeeNumber) AS Employee_Count,
    ROUND(AVG(hr2.MonthlyIncome), 2) AS Avg_Monthly_Income,
    ROUND(
        (COUNT(hr1.EmployeeNumber) * 100.0 /
        (SELECT COUNT(*) FROM hr1)),
    2) AS Attrition_Percentage
FROM hr1
JOIN hr2
ON hr1.EmployeeNumber = hr2.EmployeeID
GROUP BY hr1.Attrition;

# Q4 Average working years for each Department

ALTER TABLE hr2
ADD COLUMN TotalWorkingYears INT;
SELECT EmployeeID, MonthlyIncome, TotalWorkingYears 
FROM hr2 
LIMIT 10;
SELECT 
    hr1.EmployeeNumber,
    hr1.Department,
    hr2.TotalWorkingYears
FROM hr1
JOIN hr2
ON hr1.EmployeeNumber = hr2.EmployeeID
LIMIT 10;
SELECT 
    hr1.Department,
    ROUND(AVG(hr2.TotalWorkingYears), 2) AS Avg_Working_Years
FROM hr1
JOIN hr2
ON hr1.EmployeeNumber = hr2.EmployeeID
GROUP BY hr1.Department;

# Q5 Job Role Vs Work life balance
 
 ALTER TABLE hr2
ADD COLUMN WorkLifeBalance INT;
SELECT EmployeeID, WorkLifeBalance 
FROM hr2 
LIMIT 10;
SELECT 
    hr1.JobRole,
    hr2.WorkLifeBalance
FROM hr1
JOIN hr2
ON hr1.EmployeeNumber = hr2.EmployeeID
LIMIT 10;
SELECT 
    hr1.JobRole,
    ROUND(AVG(hr2.WorkLifeBalance), 2) AS Avg_WorkLifeBalance
FROM hr1
JOIN hr2
ON hr1.EmployeeNumber = hr2.EmployeeID
GROUP BY hr1.JobRole
ORDER BY Avg_WorkLifeBalance DESC;

# Q6 Attrition rate Vs Year since last promotion relation

ALTER TABLE hr2
ADD COLUMN YearsSinceLastPromotion INT;
SELECT EmployeeID, YearsSinceLastPromotion 
FROM hr2 
LIMIT 10;
SELECT 
    hr1.Attrition,
    hr2.YearsSinceLastPromotion
FROM hr1
JOIN hr2
ON hr1.EmployeeNumber = hr2.EmployeeID
LIMIT 10;


SELECT 
    hr1.Attrition,
    ROUND(AVG(hr2.YearsSinceLastPromotion), 2) AS Avg_Years_Since_Last_Promotion
FROM hr1
JOIN hr2
ON hr1.EmployeeNumber = hr2.EmployeeID
GROUP BY hr1.Attrition;
SELECT 
    hr2.YearsSinceLastPromotion,
    hr1.Attrition,
    COUNT(*) AS Employee_Count
FROM hr1
JOIN hr2
ON hr1.EmployeeNumber = hr2.EmployeeID
GROUP BY hr2.YearsSinceLastPromotion, hr1.Attrition
ORDER BY hr2.YearsSinceLastPromotion;

 








