USE HelpdeskDb;
GO

INSERT INTO dbo.Priorities (PriorityName, SortOrder)
SELECT b.PriorityName, b.SortOrder
FROM (
	VALUES 
	(N'Low',1),
	(N'Medium',2),
	(N'High',3),
	(N'Critical',4)
	) AS b (PriorityName, SortOrder)
WHERE NOT EXISTS
(
	SELECT 1
	FROM dbo.Priorities as a
	WHERE a.PriorityName = b.PriorityName
);
GO

INSERT INTO dbo.Statuses (StatusName, IsClosedState)
SELECT b.StatusName, b.IsClosedState
FROM (
	VALUES
	(N'Open', 0),
	(N'In Progress', 0),
	(N'Resolved', 1),
	(N'Closed', 1)
	) AS b (StatusName, IsClosedState)
WHERE NOT EXISTS
(
	SELECT 1
	FROM dbo.Statuses as a
	WHERE a.StatusName = b.StatusName
);
GO

INSERT INTO dbo.Categories (CategoryName)
SELECT b.CategoryName
FROM (
	VALUES
	(N'Hardware'),
	(N'Software'),
	(N'Network'),
	(N'Account Access'),
	(N'Other')
	) AS b (CategoryName)
WHERE NOT EXISTS
(
	SELECT 1 
	FROM dbo.Categories as a
	WHERE a.CategoryName = b.CategoryName
);
GO