USE HelpdeskDb;
GO

INSERT INTO dbo.SlaPolicies (PriorityId, ResponseHours , ResolutionHours)
SELECT b.PriorityId , b.ResponseHours, b.ResolutionHours
FROM (
	VALUES
	(1, 24, 72),
	(2, 8, 24),
	(3, 4, 8),
	(4, 1, 4)
	) AS b (PriorityId , ResponseHours, ResolutionHours)
WHERE NOT EXISTS
(
	SELECT 1
	FROM dbo.SlaPolicies as a
	WHERE a.PriorityId = b.PriorityId
);
GO
