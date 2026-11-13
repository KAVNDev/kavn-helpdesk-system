USE HelpdeskDb;
GO

CREATE OR ALTER PROCEDURE dbo.usp_CreateTicket
	@Title NVARCHAR(200),
	@Description NVARCHAR(MAX),
	@CreatedByUserId INT,
	@CategoryId TINYINT,
	@PriorityId TINYINT
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @OpenStatusId TINYINT = 1;
	DECLARE @NewTicketId INT;

	BEGIN TRANSACTION;

	INSERT INTO dbo.Tickets (Title, Description, CreatedByUserId, CategoryId, PriorityId, StatusId)
	VALUES (@Title, @Description, @CreatedByUserId, @CategoryId, @PriorityId, @OpenStatusId);

	SET @NewTicketId = SCOPE_IDENTITY();

	INSERT INTO dbo.TicketHistory (TicketId, ChangedByUserId, OldStatusId, NewStatusId)
	VALUES (@NewTicketId, @CreatedByUserId, NULL, @OpenStatusId);

	COMMIT TRANSACTION;

	SELECT @NewTicketId AS TicketId;
END;
GO