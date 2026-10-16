USE HelpdeskDb;
GO

INSERT INTO dbo.Users (RoleId, Email, PasswordHash, FullName)
SELECT v.RoleId, v.Email, v.PasswordHash, v.FullName
FROM (VALUES
    (1, N'admin@helpdesk.test',  'not-a-real-hash', N'Alex Admin'),
    (4, N'ana.lead@helpdesk.test', 'not-a-real-hash', N'Ana Lead'),
    (2, N'juan.agent@helpdesk.test', 'not-a-real-hash', N'Juan Agent'),
    (3, N'maria.customer@helpdesk.test', 'not-a-real-hash', N'Maria Customer')
) AS v (RoleId, Email, PasswordHash, FullName)
WHERE NOT EXISTS
(
    SELECT 1
    FROM dbo.Users AS u
    WHERE u.Email = v.Email
);
GO