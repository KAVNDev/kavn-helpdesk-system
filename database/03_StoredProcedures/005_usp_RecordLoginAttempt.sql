USE HelpdeskDb;
GO

CREATE OR ALTER PROCEDURE dbo.usp_RecordLoginAttempt
	@UserId INT,
	@Success BIT

AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	IF @Success = 1
	BEGIN
		 UPDATE dbo.Users
		 SET FailedLoginCount = 0,
			 LockoutEndUtc = NULL
		 WHERE UserId = @UserId
			AND (FailedLoginCount <> 0 OR LockoutEndUtc IS NOT NULL);

		RETURN;
	END;

	UPDATE u
	SET u.FailedLoginCount = x.NewCount,
		u.LockoutEndUtc =
			CASE
				WHEN x.NewCount >= 20 THEN DATEADD(MINUTE, 30, SYSUTCDATETIME())
				WHEN x.NewCount >= 15 THEN DATEADD(MINUTE, 10, SYSUTCDATETIME())
				WHEN x.NewCount >= 10 THEN DATEADD(MINUTE, 5,  SYSUTCDATETIME())
				WHEN x.NewCount >= 5  THEN DATEADD(SECOND, 30, SYSUTCDATETIME())
				ELSE u.LockoutEndUtc
			END
	OUTPUT inserted.FailedLoginCount, inserted.LockoutEndUtc
	FROM dbo.Users AS u
	CROSS APPLY
	(
		 SELECT CAST(CASE WHEN u.FailedLoginCount >= 1000
						  THEN 1000
						  ELSE u.FailedLoginCount + 1 END AS SMALLINT) AS NewCount
	) AS x
	WHERE u.UserId = @UserId;
END;
GO