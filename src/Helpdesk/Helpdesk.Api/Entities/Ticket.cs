namespace Helpdesk.Api.Entities;

public class Ticket
{
    public int TicketId { get; set; }
    public string Title { get; set; } = string.Empty;
    public string Description { get; set; } = string.Empty;
    public int CreatedByUserId { get; set; }
    public int? AssignedToUserId { get; set; }
    public byte CategoryId { get; set; }
    public byte PriorityId { get; set; }
    public byte StatusId { get; set; }
    public DateTime CreatedAtUtc { get; set; }
    public DateTime UpdatedAtUtc { get; set; }
    public DateTime? ResolvedAtUtc { get; set; }
    public DateTime? ClosedAtUtc { get; set; }
}