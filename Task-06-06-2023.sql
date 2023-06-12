
USE TUTORIALS;

INSERT INTO tblEmployee (EmpId,FirstName,MiddleName,LastName,DateOfBirth)
	VALUES ('EMP001','anan','jayeshBhai','Gandhi','02-02-2010')
INSERT INTO tblEmployee (EmpId,FirstName,MiddleName,LastName,DateOfBirth)
	VALUES ('EMP002','Jaydev','Hiren','Bhatt','02-02-2010');
INSERT INTO tblEmployee (EmpId,FirstName,MiddleName,LastName,DateOfBirth)
	VALUES ('EMP003','Dev','Vipulkumar','Patel','02-02-2010');
INSERT INTO tblEmployee (EmpId,FirstName,MiddleName,LastName,DateOfBirth)
	VALUES ('EMP004','Jay','Sanajay','Patel','02-02-2010');
INSERT INTO tblEmployee (EmpId,FirstName,MiddleName,LastName,DateOfBirth)
	VALUES ('EMP005','Varshil','ParasBhai','Shah','02-02-2010');
INSERT INTO tblEmployee (EmpId,FirstName,MiddleName,LastName,DateOfBirth)
	VALUES ('EMP006','Bhavik','Jagdish','Parmar','02-02-2010');
INSERT INTO tblEmployee (EmpId,FirstName,MiddleName,LastName,DateOfBirth)
	VALUES ('EMP007','Het','ManojBhai','Patel','02-02-2010');
INSERT INTO tblEmployee (EmpId,FirstName,MiddleName,LastName,DateOfBirth)
	VALUES ('EMP008','Yugant','Prakash','Patel','02-02-2010');
INSERT INTO tblEmployee (EmpId,FirstName,MiddleName,LastName,DateOfBirth)
	VALUES ('EMP009','Prinkesh','Pradip','Patel','02-02-2010');
INSERT INTO tblEmployee (EmpId,FirstName,MiddleName,LastName,DateOfBirth)
	VALUES ('EMP010','Jigar','AshikBhai','Patel','02-02-2010');






ALTER TABLE tblEmployee
ADD DepartmentId BIGINT;

ALTER TABLE tblEmployee
ADD Salary BIGINT;

ALTER TABLE tblEmployeeSalary
	ADD FOREIGN KEY (EmployeeId) REFERENCES tblEmployee(EmpId)


INSERT INTO tblEmployeeSalary(EmployeeId,Salary,Month,Year)
	VALUES ('EMP010','200000','6','2023');
INSERT INTO tblEmployeeSalary(EmployeeId,Salary,Month,Year)
	VALUES ('EMP009','150000','6','2023');
INSERT INTO tblEmployeeSalary(EmployeeId,Salary,Month,Year)
	VALUES ('EMP008','220000','6','2023');
INSERT INTO tblEmployeeSalary(EmployeeId,Salary,Month,Year)
	VALUES ('EMP007','240000','6','2023');
INSERT INTO tblEmployeeSalary(EmployeeId,Salary,Month,Year)
	VALUES ('EMP006','300000','6','2023');
INSERT INTO tblEmployeeSalary(EmployeeId,Salary,Month,Year)
	VALUES ('EMP005','400000','6','2023');
INSERT INTO tblEmployeeSalary(EmployeeId,Salary,Month,Year)
	VALUES ('EMP004','600000','6','2023');
INSERT INTO tblEmployeeSalary(EmployeeId,Salary,Month,Year)
	VALUES ('EMP003','800000','7','2023');
INSERT INTO tblEmployeeSalary(EmployeeId,Salary,Month,Year)
	VALUES ('EMP002','200000','6','2023');
INSERT INTO tblEmployeeSalary(EmployeeId,Salary,Month,Year)
	VALUES ('EMP001','300000','6','2023');

SELECT * 
FROM tblEmployee;

SELECT *
FROM tblEmployeeSalary



--------------------------------------------------		Create Store procedure to Get Data by pagination. (10 Page size)		------------------------------------------------------



ALTER PROCEDURE u_tblEmployeeGetByPagination

@pageNo bigint,
@pageSize bigint
AS
BEGIN
select *
FROM tblEmployee
ORDER BY (SELECT NULL)
OFFSET ((@pageNo-1)*@pageSize) ROWS FETCH NEXT @pageSize ROWS ONLY
END



EXECUTE u_tblEmployeeGetByPagination 3,5




-------------------------------------------			STORED PROCEDURE FOR INSERT			--------------------------------------------------------------


ALTER PROCEDURE u_tblEmployeeInsert

@EmpId nvarchar(50),
@FirstName nchar(10),
@LastName nchar(10),
@MiddleName nchar(10),
@DateOfBirth date,
@DepartmentId bigint


AS
BEGIN
	INSERT INTO tblEmployee(EmpId,FirstName,LastName,MiddleName,DateOfBirth,DepartmentId)
		VALUES (@EmpId,@FirstName,@LastName,@MiddleName,@DateOfBirth,@DepartmentId)
END


EXECUTE u_tblEmployeeInsert 'EMP014','Vedant','Chavda','Mahesh','20010723',1


----------------------------------------------		 STORED PROCEDURE FOR UPDATE		------------------------------------------------------------------------


ALTER PROCEDURE u_tblEmployeeUpdate

@EmpId nvarchar(50),
@FirstName nchar(10),
@LastName nchar(10),
@MiddleName nchar(10),
@DateOfBirth date,
@DepartmentId bigint


AS
BEGIN
	UPDATE tblEmployee
	SET FirstName = @FirstName, LastName = @LastName, MiddleName = @MiddleName, DateOfBirth = @DateOfBirth,DepartmentId = @DepartmentId 
	WHERE EmpId = @EmpId;

	SELECT *
	FROM tblEmployee
END


EXECUTE u_tblEmployeeUpdate 'EMP011','Praful','Patel','Dharmendra','20011209',1




-------------------------------------------			STORED PROCEDURE to get employee by id				--------------------------------------------------------------


ALTER PROCEDURE u_tblEmployeeGetById

@EmpId nvarchar(50)

AS
BEGIN
	SELECT TE.EmpId,TE.FirstName + N' ' + TE.MiddleName + N' ' + TE.LastName AS EmployeeName,TE.DateOfBirth,TE.DepartmentId
	FROM tblEmployee TE
	WHERE TE.EmpId = @EmpId
END


EXECUTE u_tblEmployeeGetById 'EMP011'



------------------------------------------		Create SP to Get Salary by Month (EmployeeID, EmployeeName (First + Middle + Last), Month, Year, Salary)		-------------------------------




ALTER PROCEDURE u_tblEmployeeSalaryGetByMonth

@month bigint

AS 
BEGIN
	SELECT ES.EmployeeId, E.FirstName + N' ' + E.MiddleName + N' ' + E.LastName AS EmployeeName, ES.Month,ES.Year,ES.Salary
	FROM tblEmployeeSalary ES
	INNER JOIN tblEmployee E  
	ON ES.EmployeeId = E.EmpId
	WHERE ES.Month = @month

END


EXECUTE u_tblEmployeeSalaryGetByMonth 6



-----------------------------------------			Create SP Top 10 Salary Paid Employees		---------------------------------------------

ALTER PROCEDURE u_tblEmployeeGetTopPaidEmployee

AS

BEGIN

	SELECT TOP 10 SubQuery.EmpId,SubQuery.FirstName,SubQuery.LastName,SubQuery.DateOfBirth,SubQuery.Month,SubQuery.Year,SubQuery.Salary
	FROM
	(SELECT ROW_NUMBER() OVER(PARTITION BY E.EmpId ORDER BY TS.Salary DESC) AS ROWNUM,E.*,TS.Salary,TS.Month,TS.Year,TS.EmployeeId
	FROM tblEmployee E
	INNER JOIN tblEmployeeSalary TS
	ON E.EmpId = TS.EmployeeId) AS SubQuery
	WHERE SubQuery.ROWNUM = 1
	ORDER BY SubQuery.Salary DESC
END

EXECUTE u_tblEmployeeGetTopPaidEmployee



------------------------------------------------			index	 ----------------------------------------------------------------


CREATE INDEX NDX_SearchByDateOrYear
ON tblEmployeeSalary (Month,Year)



------------------------------------------------			TRIGGER ON UPDATE ----------------------------------------------------------------



ALTER TRIGGER TU_tblEmployee
ON tblEmployee
FOR UPDATE
AS 
BEGIN
	 UPDATE tblEmployee
	 SET UpdatedAt =  GETDATE()
	 where EmpId IN (SELECT EmpId FROM inserted) 
	
END


----------------------------------------------------		TRIGGER ON INSERT	----------------------------------------------------------------

CREATE TRIGGER TI_tblEmployee
ON tblEmployee
FOR INSERT
AS 
BEGIN
	 UPDATE tblEmployee
	 SET CreatedAt =  GETDATE()
	 where EmpId IN (SELECT EmpId FROM inserted) 
	
END


--			-------------------------------------------------------------  Create a Function to find Age (scalar function)	----------------------------


	ALTER FUNCTION dbo.fn_GetAgeOfPerson (@DOB DATE)
	RETURNS INT 
	AS 
	BEGIN 
	DECLARE @IbirthMonth AS INT	=  DATEPART(month, @DOB)
	DECLARE @IcurrentMonth AS INT = DATEPART(MONTH, GETDATE())
	DECLARE @IbirthDay AS INT 
	SET @IbirthDay = DATEPART(DAY, @DOB)
	DECLARE @IcurrentDay AS INT = DATEPART(DAY, GETDATE())
	DECLARE @AGE INT

	SET @AGE = DATEDIFF(YEAR,@DOB,GETDATE()) -
				CASE 
					WHEN (( @IbirthMonth > @IcurrentMonth )
					 OR (( @IbirthMonth = @IcurrentMonth) AND (@IbirthDay > @IcurrentDay) ) )
					THEN 1
					ELSE 0
				END
				
		 RETURN @AGE
	END 

	SELECT dbo.fn_GetAgeOfPerson(TE.DateOfBirth) AS AGE ,TE.FirstName,TE.LastName,TE.DateOfBirth
	FROM tblEmployee TE
		


--		------------------------------------------		 Create a View		 &&		Find Rank (Result)			---------------------------------------------------



	ALTER VIEW dbo.TopTenEmployee

	AS

	SELECT TOP 10 SubQuery.EmpId,SubQuery.FirstName,SubQuery.LastName,SubQuery.DateOfBirth,SubQuery.Month,SubQuery.Year,SubQuery.Salary
	FROM
	(SELECT RANK() OVER(PARTITION BY E.EmpId ORDER BY TS.Salary DESC) RANK ,ROW_NUMBER() OVER(PARTITION BY E.EmpId ORDER BY TS.Salary DESC) AS RowIndex,E.*,TS.Salary,TS.Month,TS.Year
	FROM tblEmployee E
	INNER JOIN tblEmployeeSalary TS
	ON E.EmpId = TS.EmployeeId) AS SubQuery
	WHERE SubQuery.RANK = 1 AND SubQuery.RowIndex = 1
	ORDER BY SubQuery.Salary DESC



	SELECT *
	FROM dbo.TopTenEmployee 
	



	--				-----------------------------------			 FK  Cascade			------------------


		Alter table tblEmployee
		Add foreign key(DepartmentId) references tblDepartment(DepartmentId) ON DELETE CASCADE

		Alter table tblEmployeeSalary
		Add foreign key(EmployeeId) references tblEmployee(EmpId) ON DELETE CASCADE

		SELECT * FROM tblDepartment

		SELECT * FROM tblEmployee

		
		DELETE FROM tblDepartment
		WHERE tblDepartment.DepartmentId = 5
	




