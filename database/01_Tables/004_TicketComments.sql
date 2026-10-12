USE HelpdeskDb;
GO

CREATE TABLE dbo.TicketComments (
CommentId INT NOT NULL IDENTITY(1,1),
TicketId INT NOT NULL,
AuthorUserId INT NOT NULL,
Body NVARCHAR(MAX) NOT NULL,
IsInternal BIT NOT NULL
	CONSTRAINT DF_TicketComments_IsInternal DEFAULT (0),
CreatedAtUtc DATETIME2(0) NOT NULL
	CONSTRAINT DF_TicketComments_CreatedAtUtc DEFAULT (SYSUTCDATETIME()),
CONSTRAINT PK_TicketComments PRIMARY KEY (CommentId),
CONSTRAINT FK_TicketComments_Tickets FOREIGN KEY (TicketId) REFERENCES dbo.Tickets(TicketId),
CONSTRAINT FK_TicketComments_Users FOREIGN KEY (AuthorUserId) REFERENCES dbo.Users(UserId)
);
GO