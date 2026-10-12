USE HelpdeskDb;
GO

CREATE TABLE dbo.TicketHistory (
HistoryId BIGINT NOT NULL IDENTITY(1,1),
TicketId INT NOT NULL,
ChangedByUserId INT NOT NULL,
OldStatusId TINYINT NULL,
NewStatusId TINYINT NOT NULL,
OldAssignedToUserId INT NULL,
NewAssignedToUserId INT NULL,
ChangedAtUtc DATETIME2(0) NOT NULL
	CONSTRAINT DF_TicketHistory_ChangedAtUtc DEFAULT (SYSUTCDATETIME()),
	CONSTRAINT PK_TicketHistory PRIMARY KEY (HistoryId),
	CONSTRAINT FK_TicketHistory_Tickets FOREIGN KEY (TicketId) REFERENCES dbo.Tickets(TicketId),
	CONSTRAINT FK_TicketHistory_ChangedBy FOREIGN KEY (ChangedByUserId) REFERENCES dbo.Users(UserId),
	CONSTRAINT FK_TicketHistory_OldStatus FOREIGN KEY (OldStatusId) REFERENCES dbo.Statuses(StatusId),
	CONSTRAINT FK_TicketHistory_NewStatus FOREIGN KEY (NewStatusId) REFERENCES dbo.Statuses(StatusId),
	CONSTRAINT FK_TicketHistory_OldAssignedTo FOREIGN KEY (OldAssignedToUserId) REFERENCES dbo.Users(UserId),
	CONSTRAINT FK_TicketHistory_NewAssignedTo FOREIGN KEY (NewAssignedToUserId) REFERENCES dbo.Users(UserId)
);
GO