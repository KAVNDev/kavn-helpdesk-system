USE HelpdeskDb;
GO

IF COL_LENGTH('dbo.Users','FailedLoginCount') IS NULL
BEGIN
	 ALTER TABLE dbo.Users
		ADD FailedLoginCount SMALLINT NOT NULL
			 CONSTRAINT DF_Users_FailedLoginCount DEFAULT 0;

END;
GO

IF COL_LENGTH ('dbo.Users', 'LockoutEndUtc') IS NULL
BEGIN
	ALTER TABLE dbo.Users
		ADD LockoutEndUtc DATETIME2(0) NULL;
END;
GO