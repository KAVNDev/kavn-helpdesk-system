USE HelpdeskDb;
GO

CREATE TABLE dbo.Tickets (
	TicketId INT NOT NULL IDENTITY (1,1),
	Title NVARCHAR(200) NOT NULL,
	Description NVARCHAR(MAX) NOT NULL,
	CreatedByUserId INT NOT NULL,
	AssignedToUserId INT NULL,
	CategoryId TINYINT NOT NULL,
	PriorityId TINYINT NOT NULL,
	StatusId TINYINT NOT NULL
		CONSTRAINT DF_Tickets_StatusId DEFAULT (1),
	CreatedAtUtc DATETIME2(0) NOT NULL
		CONSTRAINT DF_Tickets_CreatedAtUtc DEFAULT (SYSUTCDATETIME()),
	UpdatedAtUtc DATETIME2(0) NOT NULL
		CONSTRAINT DF_Tickets_UpdatedAtUtc DEFAULT (SYSUTCDATETIME()),
	ResolvedAtUtc DATETIME2(0) NULL,
	ClosedAtUtc DATETIME2(0) NULL,
CONSTRAINT PK_Tickets PRIMARY KEY (TicketId),
CONSTRAINT FK_Tickets_CreatedBy FOREIGN KEY (CreatedByUserId) REFERENCES dbo.Users (UserId),
CONSTRAINT FK_Tickets_AssignedTo FOREIGN KEY (AssignedToUserId) REFERENCES dbo.Users (UserId),
CONSTRAINT FK_Tickets_Categories FOREIGN KEY (CategoryId) REFERENCES dbo.Categories (CategoryId),
CONSTRAINT FK_Tickets_Priorities FOREIGN KEY (PriorityId) REFERENCES dbo.Priorities (PriorityId),
CONSTRAINT FK_Tickets_Statuses FOREIGN KEY (StatusId) REFERENCES dbo.Statuses (StatusId)
);
GO