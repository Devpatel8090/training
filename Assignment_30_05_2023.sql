CREATE DATABASE TUTORIALS;

USE TUTORIALS;

CREATE TABLE Employee(
EmployeeId BIGINT PRIMARY KEY IDENTITY(1,1),
FirstName  VARCHAR(50) NOT NULL,
LastName VARCHAR(50),
Gender   CHAR(1) NOT NULL CHECK(Gender = 'M' or Gender = 'F'),
DateOfBirth DATETIME ,
DepartmentID BIGINT DEFAULT '1',
Salary DECIMAL(18,2) NOT NULL,
Address VARCHAR(200),
CityID BIGINT ,
PinCode CHAR(6),
IsActive BIT
FOREIGN KEY(DepartmentID) REFERENCES Department(DepartmentID),
FOREIGN KEY(CityID) REFERENCES City(CityId)
)

CREATE TABLE Department (
DepartmentID	BIGINT	PRIMARY KEY,
DepartmentName	VARCHAR(50)		
)

CREATE TABLE Country (
   CountryId BIGINT PRIMARY KEY IDENTITY(1,1),
   CountryName VARCHAR(50) NOT NULL,
)

CREATE TABLE State (
   StateId BIGINT PRIMARY KEY IDENTITY(1,1),
   StateName VARCHAR(50) NOT NULL,
   CountryId BIGINT,    
   FOREIGN KEY(CountryId) REFERENCES Country(CountryId),   
)

CREATE TABLE City (
   CityId BIGINT PRIMARY KEY IDENTITY(1,1),
   CityName VARCHAR(50) NOT NULL,
   StateId BIGINT NOT NULL,
   FOREIGN KEY(StateId) REFERENCES State(StateId) 
)



StateID	int	YES	Foreign Key




 
 

 










)