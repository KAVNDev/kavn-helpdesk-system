using Dapper;
using Helpdesk.Api.DTOs;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;

namespace Helpdesk.Api.Controllers;

[ApiController]
[Route("api/[controller]")]
public class TicketsController : ControllerBase
{
    private readonly string _connectionString;

    public TicketsController(IConfiguration configuration)
    {
        _connectionString = configuration.GetConnectionString("HelpdeskDb")
            ?? throw new InvalidOperationException("Connection string 'HelpdeskDb' is missing.");
    }

    [HttpGet]
    public async Task<ActionResult<IEnumerable<TicketListItemDto>>> GetTickets()
    {
        const string sql = @"
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
            INNER JOIN dbo.Statuses AS s ON t.StatusId = s.StatusId
            INNER JOIN dbo.Priorities AS p ON t.PriorityId = p.PriorityId
            INNER JOIN dbo.Categories AS c ON t.CategoryId = c.CategoryId
            INNER JOIN dbo.Users AS cu ON cu.UserId = t.CreatedByUserId
            LEFT JOIN dbo.Users AS au ON au.UserId = t.AssignedToUserId
            ORDER BY t.TicketId;";

        await using var connection = new SqlConnection(_connectionString);
        var tickets = await connection.QueryAsync<TicketListItemDto>(sql);
        return Ok(tickets);
    }
}