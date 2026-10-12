USE HelpdeskDb;
GO

CREATE TABLE dbo.SlaPolicies (
SlaPolicyId TINYINT NOT NULL IDENTITY(1,1),
PriorityId TINYINT NOT NULL,
ResponseHours SMALLINT NOT NULL,
ResolutionHours SMALLINT NOT NULL,
	CONSTRAINT PK_SlaPolicies PRIMARY KEY (SlaPolicyId),
	CONSTRAINT UQ_SlaPolicies_PriorityId UNIQUE (PriorityId),
	CONSTRAINT FK_SlaPolicies_Priorities FOREIGN KEY (PriorityId) REFERENCES dbo.Priorities (PriorityId),
	CONSTRAINT CK_SlaPolicies_ResponseHours CHECK (ResponseHours>0),
	CONSTRAINT CK_SlaPolicies_ResolutionHours CHECK (ResolutionHours>=ResponseHours)
);
GO