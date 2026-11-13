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

    [HttpPost]
    public async Task<IActionResult> CreateTicket(CreateTicketDto request)
    {
        // TEMPORARY: Until the login exists, every ticket will be created by the same user 4 (Maria Customer).
        const int temporaryCreatedByUserId = 4;

        var parameters = new DynamicParameters();
        parameters.Add("@Title", request.Title);
        parameters.Add("@Description", request.Description);
        parameters.Add("@CreatedByUserId", temporaryCreatedByUserId);
        parameters.Add("@CategoryId", request.CategoryId);
        parameters.Add("@PriorityId", request.PriorityId);

        try
        {
            await using var connection = new SqlConnection(_connectionString);
            var newTicketId = await connection.QuerySingleAsync<int>(
               "dbo.usp_CreateTicket",
               parameters,
               commandType: CommandType.StoredProcedure);

            return Created($"/api/tickets/{newTicketId}", new { ticketId = newTicketId });
        }
        catch (SqlException ex) when (ex.Number == 547)
        {
            return BadRequest(new { message = "The category or priority does not exist." });
        }
    }
}