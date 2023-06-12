USE Student


CREATE PROCEDURE [dbo].sp_INVCategory_GetAllCategories 

AS

BEGIN 

	SELECT C.CategoryName,C.Description
	FROM INVCategory C

END


EXEC [dbo].sp_INVCategory_GetAllCategories 

CREATE PROCEDURE [dbo].sp_INVCategory_AddCategories
@CategoryName AS NVARCHAR(20),
@Description AS NVARCHAR(100)
AS

BEGIN 
	INSERT INTO INVCategory(CategoryName,Description)
		VALUES (@CategoryName,@Description)

END

EXEC [dbo].sp_INVCategory_AddCategories DEV,DEVPATEL