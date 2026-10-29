USE HelpdeskDb;
GO

CREATE OR ALTER PROCEDURE dbo.usp_GetTickets
AS
BEGIN
	SET NOCOUNT ON;

	SELECT
		t.TicketId,
		t.Title,
		s.StatusName AS Status,
		p.PriorityName AS Priority,
		c.CategoryName AS Category,
		cu.FullName AS CreatedBy,
		au.FullName AS AssignedTo,
		t.CreatedAtUtc
	FROM dbo.Tickets AS t
	INNER JOIN dbo.Statuses AS s ON s.StatusId = t.StatusId
	INNER JOIN dbo.Priorities AS p ON p.PriorityId = t.PriorityId
	INNER JOIN dbo.Categories AS c ON c.CategoryId = t.CategoryId
	INNER JOIN dbo.Users AS cu ON cu.UserId = t.CreatedByUserId
	LEFT JOIN dbo.Users AS au ON au.UserId = t.AssignedToUserId
	ORDER BY t.TicketId;
END;
GO