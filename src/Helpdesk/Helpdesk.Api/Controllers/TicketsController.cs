using Dapper;
using Helpdesk.Api.DTOs;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using System.Data;

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
        await using var connection = new SqlConnection(_connectionString);
        var tickets = await connection.QueryAsync<TicketListItemDto>(
            "dbo.usp_GetTickets",
            commandType: CommandType.StoredProcedure);
        return Ok(tickets);
    }
}