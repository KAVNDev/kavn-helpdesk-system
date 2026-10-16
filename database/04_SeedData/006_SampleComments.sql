USE HelpdeskDb;
GO

INSERT INTO dbo.TicketComments (TicketId, AuthorUserId, Body, IsInternal)
SELECT v.TicketId, v.AuthorUserId, v.Body, v.IsInternal
FROM (VALUES
    (1, 3, N'Hi Maria, have you tried resetting your password?',        0),
    (1, 4, N'Yes, but the reset email never arrives.',                  0),
    (1, 3, N'Her mailbox may be on the old server. Asking the Lead.',   1),
    (1, 2, N'Approved. Re-enable her account and resend the email.',    1)
) AS v (TicketId, AuthorUserId, Body, IsInternal)
WHERE NOT EXISTS
(
    SELECT 1
    FROM dbo.TicketComments AS c
    WHERE c.TicketId = v.TicketId
      AND c.AuthorUserId = v.AuthorUserId
      AND c.Body = v.Body
);
GO