USE HelpdeskDb;
GO

CREATE OR ALTER PROCEDURE dbo.usp_GetUserByEmail
    @Email NVARCHAR(256)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        u.UserId,
        u.Email,
        u.FullName,
        u.PasswordHash,
        r.RoleName,
        u.IsActive,
        u.FailedLoginCount,
        u.LockoutEndUtc,
        CAST(CASE WHEN u.LockoutEndUtc IS NOT NULL
                   AND u.LockoutEndUtc > SYSUTCDATETIME()
                  THEN 1 ELSE 0 END AS BIT) AS IsLockedOut
    FROM dbo.Users AS u
    INNER JOIN dbo.Roles AS r ON r.RoleId = u.RoleId
    WHERE u.Email = @Email;
END;
GO