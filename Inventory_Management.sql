USE Student


CREATE PROCEDURE [dbo].sp_INVCategory_GetAllCategories 

AS

BEGIN 

	SELECT C.CategoryName,C.Description,C.CategoryId
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



ALTER PROCEDURE [dbo].sp_INVCategory_GetCategoryById
@categoryId AS BIGINT
AS

BEGIN 
	SELECT C.CategoryName,C.Description,C.CategoryId
	FROM INVCategory C
	WHERE C.CategoryId = @categoryId

END


EXEC [dbo].sp_INVCategory_GetCategoryById 1



ALTER PROCEDURE [dbo].sp_INVCategory_UpdateCategory
@categoryId AS BIGINT,
@categoryName AS VARCHAR(20),
@description AS VARCHAR(100)
AS

BEGIN 
	UPDATE INVCategory 
	SET CategoryName = @categoryName, Description = @description,UpdatedAt = GETDATE()
	WHERE CategoryId = @categoryId

END

EXEC [dbo].sp_INVCategory_UpdateCategory 1,JP,ABCDS 

