USE HelpdeskDb;
GO

CREATE TABLE dbo.Categories (
CategoryId TINYINT NOT NULL IDENTITY (1,1),
CategoryName NVARCHAR(50) NOT NULL,
CONSTRAINT PK_Categories PRIMARY KEY (CategoryID),
CONSTRAINT UQ_Categories_CategoryName UNIQUE (CategoryName)
);
GO

CREATE TABLE dbo.Priorities (
PriorityId TINYINT NOT NULL IDENTITY (1,1),
PriorityName NVARCHAR(50) NOT NULL,
SortOrder TINYINT NOT NULL,
CONSTRAINT PK_Priorities PRIMARY KEY (PriorityId),
CONSTRAINT UQ_Priorities_PriorityName UNIQUE (PriorityName)
);
GO

CREATE TABLE dbo.Statuses (
StatusId TINYINT NOT NULL IDENTITY (1,1),
StatusName NVARCHAR(50)  NOT NULL,
IsClosedState BIT NOT NUlL
	CONSTRAINT DF_Statuses_IsClosedState DEFAULT (0),
CONSTRAINT PK_Statuses PRIMARY KEY (StatusId),
CONSTRAINT UQ_Statuses_StatusName UNIQUE (StatusName)
);
GO
