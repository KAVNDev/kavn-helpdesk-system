USE HelpDeskDb;
GO

CREATE OR ALTER PROCEDURE dbo.usp_RegisterUser
	 @Email NVARCHAR(256),
	 @PasswordHash VARCHAR(255),
	 @FullName NVARCHAR(150)

AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @CustomerRoleId TINYINT =
	(
		SELECT RoleId
		FROM Dbo.Roles
		WHERE RoleName = N'Customer'
	);

	IF @CustomerRoleId IS NULL
		THROW 50001, 'The Customer role is missing from dbo.Roles', 1;

    INSERT INTO dbo.Users (RoleId, Email, PasswordHash, FullName)
    VALUES (@CustomerRoleId, @Email, @PasswordHash, @FullName);

    DECLARE @NewUserId INT = SCOPE_IDENTITY();

    SELECT @NewUserId AS UserId;
END;
GO