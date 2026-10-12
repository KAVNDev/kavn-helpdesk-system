Use HelpdeskDb;
GO

CREATE TABLE dbo.Roles
(
	RoleID TINYINT NOT NULL IDENTITY (1,1),
	RoleName NVARCHAR(50) NOT NULL,
	CONSTRAINT PK_Roles PRIMARY KEY (RoleID),
	CONSTRAINT UQ_Roles_RoleNamne UNIQUE (RoleName)
);
GO

CREATE TABLE dbo.Users
(
    UserId        INT            NOT NULL IDENTITY(1,1),
    RoleId        TINYINT        NOT NULL,
    Email         NVARCHAR(256)  NOT NULL,
    PasswordHash  VARCHAR(255)   NOT NULL,
    FullName      NVARCHAR(150)  NOT NULL,
    IsActive      BIT            NOT NULL
        CONSTRAINT DF_Users_IsActive DEFAULT (1),
    CreatedAtUtc  DATETIME2(0)   NOT NULL
        CONSTRAINT DF_Users_CreatedAtUtc DEFAULT (SYSUTCDATETIME()),
    CONSTRAINT PK_Users PRIMARY KEY (UserId),
    CONSTRAINT UQ_Users_Email UNIQUE (Email),
    CONSTRAINT FK_Users_Roles FOREIGN KEY (RoleId) REFERENCES dbo.Roles (RoleId)
);
GO