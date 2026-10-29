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
    public async Task<IActionResult> GetTickets()
    {
        await using var connection = new SqlConnection(_connectionString);
        await connection.OpenAsync();
        return Ok($"Connected to database: {connection.Database}");
    }
}