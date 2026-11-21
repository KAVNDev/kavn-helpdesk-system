using System.ComponentModel.DataAnnotations;

namespace Helpdesk.Api.DTOs;

public class LoginDto
{
    [Required]
    [StringLength(256)]
    public string Email { get; set; } = string.Empty;

    [Required]
    [StringLength(128)]
    public string Password { get; set; } = string.Empty;
}