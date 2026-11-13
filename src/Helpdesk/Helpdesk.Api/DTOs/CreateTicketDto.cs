using System.ComponentModel.DataAnnotations;

namespace Helpdesk.Api.DTOs;

public class CreatTicketDto
{
    [Required]
    [StringLength(200, MinimumLength = 5)]
    public string Title { get; set; } = string.Empty;

    [Required]
    [StringLength(4000, MinimumLength = 10)]
    public string Description { get; set; } = string.Empty;

    [Range(1, 255)]
    public byte CategoryId { get; set; }

    [Range(1, 255)]
    public byte PriorityId { get; set; }
}
