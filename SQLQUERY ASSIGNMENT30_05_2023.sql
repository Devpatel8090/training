USE TUTORIALS;

--List All User

  SELECT * FROM Employee;
--List All Country

	SELECT * FROM Country;

--List All State

	SELECT * FROM State;

--List All State Of 5 different countries
	
	 SELECT S.StateName,S.CountryId,S.StateId
	 FROM State S
	 WHERE S.CountryId IN (SELECT DISTINCT(CountryId)
	 FROM Country)

	 

--List All Department

	SELECT * FROM Department;

--List All Cities

	SELECT * FROM City;
--List User Who have no address specified

		SELECT * 
		FROM Employee AS E
		WHERE E.[Address] = '';

--List User with of 5 different departments

	SELECT DISTINCT D.DepartmentName,E.EmployeeId,E.Address
	FROM Employee E
	INNER JOIN Department D 
	ON E.DepartmentID = D.DepartmentID
	
	
--List All Male Users

	SELECT * 
	FROM Employee 
	WHERE Employee.Gender = 'M';

--List All Female Users

	SELECT * 
	FROM Employee 
	WHERE Employee.Gender = 'F';

--List Users Whoes Last name is null

	SELECT * 
	FROM Employee E
	WHERE E.LastName = '';

--List Users Whoes Last name is not null
	SELECT * 
	FROM Employee E
	WHERE E.LastName != ''  OR  E.LastName <> '';

--List All Users with state,country,department,address Of 5 different department
	
	SELECT DISTINCT E.DepartmentID,E.Gender
	FROM Employee E
	WHERE E.DepartmentID IN (SELECT DISTINCT TOP 5 DepartmentID
	FROM Department)

--List All Users with state,country,department,address Of 5 different States
	
	SELECT DISTINCT S.StateId,S.CountryId
	FROM Employee E
	INNER JOIN City C ON E.CityID = C.CityId
	INNER JOIN State S ON C.StateId = S.StateId
	INNER JOIN Country CO ON S.CountryId = CO.CountryId
	WHERE S.StateId  IN (SELECT  TOP 5 StateId
							FROM State) 

							


--List All Users with state,country,department,address Of 5 different City


--List Users with all fields who is born aftre year 2000

	SELECT *
	FROM Employee E
	WHERE YEAR(E.DateOfBirth) > 2000;

--List Users with all fields who is born before year 2000

	SELECT *
	FROM Employee E
	WHERE YEAR(E.DateOfBirth) < 2000;
--List users whose birthday is 01-Jan-1990

	DECLARE @DATE AS DATE = '1990-JAN-01';
	SELECT *
	FROM Employee E
	WHERE E.DateOfBirth = @DATE;

--List users whose birthday is between 01-Jan-1990 and 01-Jan-1995

	DECLARE @StartDate AS DATE = '1990-JAN-01';
	DECLARE @EndDate AS DATE = '1995-01-01';

	SELECT *
	FROM Employee E
	WHERE E.DateOfBirth BETWEEN '1990-JAN-01' AND '1995-01-01';

--List All Users Order by Date of Birth

	SELECT * 
	FROM Employee E
	ORDER BY E.DateOfBirth ASC;

--List All Active and inactive users.
	
	SELECT *
	FROM Employee E
	WHERE E.IsActive = 1 OR E.IsActive = 0;

--List all users whose First Name Start with  A
	
	SELECT * 
	FROM Employee E
	WHERE E.FirstName LIKE 'A%';

--List All Users whose email address contains domain @server1.com

	SELECT * 
	FROM Employee E 
	WHERE E.Address like '%server1.com%'

--List all users to whome department is not assigned


--List all female users from state gujarat
	
	SELECT * 
	FROM ((Employee E
	INNER JOIN City C 
	ON E.CityID = C.CityId)
	INNER JOIN  State S 
	ON S.StateId = C.StateId)
	WHERE S.StateName = 'Gujarat' AND E.Gender = 'F';
	

--List all male users from City Mumbai
	
	SELECT * 
	FROM ((Employee E
	INNER JOIN City C 
	ON E.CityID = C.CityId)
	INNER JOIN  State S 
	ON S.StateId = C.StateId)
	WHERE C.CityName = 'Mumbai' AND E.Gender = 'M';
	

--List User's all detail who belongs to .NET department

	SELECT * 
	FROM Employee E 
	INNER JOIN Department D
	ON E.DepartmentID = D.DepartmentID
	WHERE D.DepartmentName = '.NET'

	
	
--List User's all detail whoes zip code is 380015

	SELECT * 
	FROM Employee E
	WHERE E.PinCode = '380015';






--INSERTING VALUE IN THE TABLE



INSERT INTO Country(CountryName) VALUES('India');
INSERT INTO Country(CountryName) VALUES('Pakistan');
INSERT INTO Country(CountryName) VALUES('NewZealand');
INSERT INTO Country(CountryName) VALUES('Australia');
INSERT INTO Country(CountryName) VALUES('Usa');
INSERT INTO Country(CountryName) VALUES('Canada');


INSERT INTO State(StateName,CountryId) VALUES('Gujarat',1);
INSERT INTO State(StateName,CountryId) VALUES('Rajastan',1);
INSERT INTO State(StateName,CountryId) VALUES('Balochistan',2);
INSERT INTO State(StateName,CountryId) VALUES('Sindh',2);
INSERT INTO State(StateName,CountryId) VALUES('North Island',3);
INSERT INTO State(StateName,CountryId) VALUES('Wellington',3);
INSERT INTO State(StateName,CountryId) VALUES('New South Wales',4);
INSERT INTO State(StateName,CountryId) VALUES('Queensland',4);
INSERT INTO State(StateName,CountryId) VALUES('California',5);
INSERT INTO State(StateName,CountryId) VALUES('illinois',5);
INSERT INTO State(StateName,CountryId) VALUES('Toronto',6);
INSERT INTO State(StateName,CountryId) VALUES('Quebec',6);


INSERT INTO City(CityName,StateId) VALUES ('Ahmedabad',1);
INSERT INTO City(CityName,StateId) VALUES ('Jaipur',2);
INSERT INTO City(CityName,StateId) VALUES ('Gwadar',3);
INSERT INTO City(CityName,StateId) VALUES ('Karachi',4);
INSERT INTO City(CityName,StateId) VALUES ('Auckland',5);
INSERT INTO City(CityName,StateId) VALUES ('Wellington',6);
INSERT INTO City(CityName,StateId) VALUES ('Sydney',7);
INSERT INTO City(CityName,StateId) VALUES ('Brisbane',8);
INSERT INTO City(CityName,StateId) VALUES ('Los Angeles',9);
INSERT INTO City(CityName,StateId) VALUES ('Chicago',10);
INSERT INTO City(CityName,StateId) VALUES ('Kitchner',11);
INSERT INTO City(CityName,StateId) VALUES ('Montreal',12);

INSERT INTO Department(DepartmentName) VALUES ('HR');
INSERT INTO Department(DepartmentName) VALUES ('QA');
INSERT INTO Department(DepartmentName) VALUES ('.NET');
INSERT INTO Department(DepartmentName) VALUES ('JAVA');
INSERT INTO Department(DepartmentName) VALUES ('PYTHON');


INSERT INTO Employee(FirstName,LastName,Gender,DateOfBirth,DepartmentID,Salary,Address,CityID,PinCode,IsActive) 
		VALUES('DEV','PATEL','M','2020-08-02',3,1000000,'AHMEDABAD',1,380015,1);
INSERT INTO Employee(FirstName,LastName,Gender,DateOfBirth,DepartmentID,Salary,Address,CityID,PinCode,IsActive) 
		VALUES('JAY','PATEL','M','2020-06-01',3,900000,'JAIPUR',2,382225,1);
INSERT INTO Employee(FirstName,LastName,Gender,DateOfBirth,DepartmentID,Salary,Address,CityID,PinCode,IsActive) 
		VALUES('JAYDEV','BHATT','M','2020-01-20',4,700000,'Sydney',7,382226,1);
INSERT INTO Employee(FirstName,LastName,Gender,DateOfBirth,DepartmentID,Salary,Address,CityID,PinCode,IsActive) 
		VALUES('NUPOOR','PATEL','F','2020-02-02',5,500000,'Chicago',10,382290,1);
INSERT INTO Employee(FirstName,LastName,Gender,DateOfBirth,DepartmentID,Salary,Address,CityID,PinCode,IsActive) 
		VALUES('NIPA','PANCHAL','F','2019-02-02',1,500001,'Montreal',12,382280,1);




 
