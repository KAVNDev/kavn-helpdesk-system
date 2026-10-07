BEGIN TRAN

USE HelpdeskDb;
GO

INSERT INTO dbo.Roles (RoleName)
SELECT v.RoleName
FROM (VALUES (N'Admin'), (N'Agent'), (N'Customer'), (N'Lead')) AS v (RoleName)
WHERE NOT EXISTS
(
    SELECT 1
    FROM dbo.Roles AS r
    WHERE r.RoleName = v.RoleName
);
GO

ROLLBACK TRAN

