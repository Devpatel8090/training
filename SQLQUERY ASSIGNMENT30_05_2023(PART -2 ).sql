--	-- 1 --	write select query to find name of employee whose salary is highest.

	SELECT E.FirstName+ N' ' + E.LastName AS FULLNAME
	FROM Employee E
	WHERE E.Salary = (
	SELECT MAX(ES.Salary)
	FROM Employee ES)

--	-- 2 --	write select query to find name of employee whose salary is second highest.


	WITH Salaries AS (SELECT ROW_NUMBER() OVER (
	ORDER BY E.SALARY DESC
   ) ROW_NUM,*
   FROM Employee E)
   SELECT * 
   FROM Salaries
   WHERE ROW_NUM = 2; 
   

--	-- 3 --	write select query to find name of employee whose salary is third highest.
	
	WITH Salaries AS (SELECT ROW_NUMBER() OVER (
	ORDER BY E.SALARY DESC
   ) ROW_NUM,*
   FROM Employee E)
   SELECT * 
   FROM Salaries
   WHERE ROW_NUM = 3; 

--	-- 4 --	write select query to find name of employee whose salary is lowest.
	
	WITH Salaries AS (SELECT ROW_NUMBER() OVER (
	ORDER BY E.SALARY 
   ) ROW_NUM,*
   FROM Employee E)
   SELECT * 
   FROM Salaries
   WHERE ROW_NUM = 1; 

--	-- 5--	write select query to find name of employee whose is from "USA" country

	SELECT *
	FROM Employee E
	WHERE E.CityID IN (
	SELECT C.CityId
	FROM City C
	INNER JOIN State S
	ON C.StateId = S.StateId
	INNER JOIN  Country CO
	ON S.CountryId = CO.CountryId
	WHERE CO.CountryName = N'USA'
	)

--		-- 6 --		write select query to find number of employee of all department.
	 --It should return two columns: 
	 --1. EmployeeCount 
	 --2. Department Name

	 WITH TotalEmployee AS  ( SELECT COUNT(E.DepartmentID) AS NoOfEmpIndepartment,E.DepartmentID
	 FROM Employee E
	 INNER JOIN Department D
	 ON E.DepartmentID = D.DepartmentID
	 GROUP BY E.DepartmentID) 

	 SELECT TE.NoOfEmpIndepartment, D.DepartmentName
	 FROM Department D 
	 INNER JOIN TotalEmployee TE
	 ON TE.DepartmentID = D.DepartmentID;
	

	--   Write View for this

	CREATE VIEW dbo.TotalNoOfEmpInDepartment

	AS

	WITH TotalEmployee AS  ( SELECT COUNT(E.DepartmentID) AS NoOfEmpIndepartment,E.DepartmentID
	 FROM Employee E
	 INNER JOIN Department D
	 ON E.DepartmentID = D.DepartmentID
	 GROUP BY E.DepartmentID) 

	SELECT TE.NoOfEmpIndepartment, D.DepartmentName
	 FROM Department D 
	 INNER JOIN TotalEmployee TE
	 ON TE.DepartmentID = D.DepartmentID;


	SELECT *
	FROM dbo.TotalNoOfEmpInDepartment

--	-- 7 --	write select query to find name of department who has highest paid salary employee


	WITH TotalSalaries AS (
	SELECT SUM(E.Salary) AS SALARIES,E.DepartmentID
	FROM Employee E
	GROUP BY E.DepartmentID ) 

	SELECT TOP 1 TS.SALARIES,TS.DepartmentID,D.DepartmentName
	FROM TotalSalaries TS
	INNER JOIN Department D
	ON TS.DepartmentID = D.DepartmentID
	ORDER BY TS.SALARIES DESC;

--		-- 8 --	write select query to find name of state whose zip code is "510240"

	SELECT FirstName
	FROM Employee E
	WHERE E.PinCode = N'380015'

--		-- 9 --	write select query to find name of employee who is younger most (smallest age employee)

	--DECLARE @DATE AS DATE = GETDATE();
	DECLARE @TodayDate AS DATE = GETDATE();

	WITH EMPWithAge AS (SELECT (DATEDIFF(MONTH,E.DateOfBirth,@TodayDate)/12) AS Age,*
	FROM Employee E)


	SELECT * 
	FROM EMPWithAge EWA 
	WHERE EWA.Age = (SELECT MIN(EA.Age) AS Age
	FROM EMPWithAge  EA)
	
	
--		-- 10 --	write select query to find name of country for which we don't have any employee.
	
	SELECT *
	FROM Country CO
	WHERE CO.CountryId NOT IN(
	SELECT CO.CountryId
	FROM Employee E 
	INNER JOIN City C ON E.CityID = C.CityId
	INNER JOIN State S ON S.StateId = C.StateId
	INNER JOIN Country CO ON CO.CountryId = S.CountryId)


--		-- 11 --	if DA is 20% of salary then find DA for all employee. It should return three columns: 1. EmployeeName 2. Salary 3. DA

	SELECT E.FirstName + N' ' + E.LastName AS EmployeeName,E.Salary,((E.Salary * 20) / 100) AS DA
	FROM Employee E 


		--		BY USING FUNCTION

		CREATE FUNCTION dbo.fn_GetSalaryOfPerson ()
		RETURNS TABLE
		AS
		RETURN 
			( SELECT E.FirstName + N' ' + E.LastName AS EmployeeName,E.Salary,((E.Salary * 20) / 100) AS DA
			  FROM Employee E 
			);

		SELECT * FROM dbo.fn_GetSalaryOfPerson ()
	
	

--		-- 12 --	List All users with Age (Only Year) Like 25,26,20

	DECLARE @DATE AS DATE = GETDATE();

	SELECT (DATEDIFF(MONTH,E.DateOfBirth,@DATE)/12) AS Age,*
	FROM Employee E

		

--		-- 13 --	List Users who is born in particular month
--.month will pass as parameter of stored procedure.

	ALTER PROCEDURE u_EmployeeGetByBirthDayMonth 

	 @month bigint = 1

	AS 
	BEGIN
	   --DECLARE @IbirthdayMonth AS NVARCHAR(10)
	 
		SELECT *
		FROM Employee E
		WHERE DATEPART(MONTH,E.DateOfBirth ) = @month

	END

	EXEC u_EmployeeGetByBirthDayMonth 2
	


--		-- 14 --	List users who born on date 21th  of any month and any year

	SELECT * 
	FROM Employee E
	WHERE DATEPART(DAY,E.DateOfBirth) = N'21'

--		-- 15 --	List All Departments who has only 4 Users
	
	WITH EMPBYDEP AS (SELECT COUNT(E.DepartmentID) AS NoOfEmp,E.DepartmentID
	FROM Employee E
	INNER JOIN Department D
	ON E.DepartmentID = D.DepartmentID
	GROUP BY E.DepartmentID)

	SELECT D.DepartmentName,E.FirstName,E.LastName
	FROM EMPBYDEP ED
	INNER JOIN Employee E
	ON ED.DepartmentID = E.DepartmentID
	INNER JOIN Department D 
	ON  E.DepartmentID = D.DepartmentID
	WHERE ED.NoOfEmp = 1

--  -- 16 -- List All States from India & Number of users in it. 
--It should return two columns: (If there are no users in any state, State name should also come in result) 
--1. State 
--2. UserCount

	WITH TotalEmpByState AS (SELECT COUNT(S.StateId) AS NoOfEmployeeInState,S.StateId
	FROM Employee E 
	INNER JOIN Department D ON E.DepartmentID = D.DepartmentID
	INNER JOIN City C ON C.CityId = E.CityID
	INNER JOIN State S ON S.StateId = C.StateId
	INNER JOIN Country CO ON CO.CountryId = S.CountryId
	WHERE CO.CountryName = 'INDIA'
	GROUP BY S.StateId)

	SELECT TEBS.StateId,S.StateName,TEBS.NoOfEmployeeInState
	FROM TotalEmpByState TEBS
	INNER JOIN State S ON TEBS.StateId = S.StateId


	--	USING SP --
	CREATE PROCEDURE u_AllStateUser 
	AS
	BEGIN
		WITH TotalEmpByState AS (SELECT COUNT(S.StateId) AS NoOfEmployeeInState,S.StateId
		FROM Employee E 
		INNER JOIN Department D ON E.DepartmentID = D.DepartmentID
		INNER JOIN City C ON C.CityId = E.CityID
		INNER JOIN State S ON S.StateId = C.StateId
		INNER JOIN Country CO ON CO.CountryId = S.CountryId
		WHERE CO.CountryName = 'INDIA'
		GROUP BY S.StateId)

		SELECT TEBS.StateId,S.StateName,TEBS.NoOfEmployeeInState
		FROM TotalEmpByState TEBS
		INNER JOIN State S ON TEBS.StateId = S.StateId
	END

	EXEC u_AllStateUser




--		-- 17 --	Find Active & Inactive User Count from Ahmedabad City
	
	SELECT COUNT(E.IsActive) AS ActiveUserInAmd 
	FROM Employee E
	INNER JOIN City C ON E.CityID = C.CityID
	WHERE C.CityName = N'Ahmedabad' AND E.IsActive = N'1'

	SELECT COUNT(E.IsActive) AS InActiveUserInAmd 
	FROM Employee E
	INNER JOIN City C ON E.CityID = C.CityID
	WHERE C.CityName = N'Ahmedabad' AND E.IsActive = N'0'


--		-- 18 --	List All States from which there are any Male Employees.

	SELECT S.StateId, S.StateName , C.CityName,E.*
	FROM Employee E 
	INNER JOIN City C ON E.CityID = C.CityId
	INNER JOIN State S ON S.StateId = C.StateId 
	WHERE E.Gender = N'M'.



	--	-- 19 --	Make one view which shows users all detail

		CREATE VIEW dbo.GetAllEmployee
		AS
		SELECT *
		FROM Employee


		SELECT * FROM dbo.GetAllEmployee


	--	-- 20 --	Make one trigger for employee table.So when new employee created at that time new user is automatically created.

		
	CREATE TABLE [User]
	(
	UserId BIGINT PRIMARY KEY IDENTITY(1,1),
	EmployeeId BIGINT,
	FirstName  VARCHAR(50) NOT NULL,
	LastName VARCHAR(50),
	Gender   CHAR(1) NOT NULL CHECK(Gender = 'M' or Gender = 'F'),
	DateOfBirth DATETIME,
	FOREIGN KEY(EmployeeId) REFERENCES [Employee](EmployeeId)
	)

CREATE TRIGGER [UserInsert]
ON Employee
FOR INSERT
AS
   INSERT INTO [User](EmployeeId, FirstName, LastName, Gender, DateOfBirth)
   SELECT EmployeeID, Firstname, LastName, Gender, DateOfBirth
   FROM INSERTED;
GO

--Execution on Trigger
	SELECT * FROM [User]	
	INSERT INTO Employee(FirstName,LastName,Gender,DateOfBirth,DepartmentID,Salary,Address,CityID,PinCode,IsActive) VALUES('Kavan','Ardeshana','M','2020-08-02',3,10000,'AHMEDABAD',1,380015,1);
	SELECT * FROM [User]



	--Calculate the age using the function

	CREATE FUNCTION CalculateAge(@DOB DATE)
	RETURNS INT 
	AS 
	BEGIN 

	DECLARE @AGE INT
	SET @AGE = DATEDIFF(YEAR,@DOB,GETDATE()) -
				CASE 
					WHEN ( MONTH( @DOB ) > MONTH( GETDATE() )
					 OR ( MONTH( @DOB ) = MONTH( GETDATE() ) AND DAY( @DOB ) > DAY( GETDATE() ) ) )
					THEN 1
					ELSE 0
				END
				
		 RETURN @AGE
	END 

	
	--CALLING FUNCTION IN SELECT STATEMENT


	SELECT TUTORIALS.dbo.CalculateAge(E.DateOfBirth) AS AGE ,*
	FROM Employee E
		
