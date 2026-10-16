USE HelpdeskDb;
GO

INSERT INTO dbo.Tickets (Title, Description, CreatedByUserId, AssignedToUserId, CategoryId, PriorityId, StatusId)
SELECT v.Title, v.Description, v.CreatedByUserId, v.AssignedToUserId, v.CategoryId, v.PriorityId, v.StatusId
FROM (VALUES
    (N'Cannot log in to my account', N'Password reset email never arrives.',       4, 3,    4, 3, 2),
    (N'Laptop screen is flickering',  N'Screen flickers every few minutes.',       4, NULL, 1, 2, 1),
    (N'Wi-Fi drops in meeting room',  N'Connection drops during video calls.',     4, 2,    3, 4, 1)
) AS v (Title, Description, CreatedByUserId, AssignedToUserId, CategoryId, PriorityId, StatusId)
WHERE NOT EXISTS
(
    SELECT 1
    FROM dbo.Tickets AS t
    WHERE t.Title = v.Title
);
GO