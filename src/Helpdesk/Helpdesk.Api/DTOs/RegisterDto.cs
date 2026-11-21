using System.ComponentModel.DataAnnotations;

namespace Helpdesk.Api.DTOs;

public class RegisterDto
{
    [Required]
    [EmailAddress]
    [StringLength(256)]
    public string Email { get; set; } = string.Empty;

    [Required]
    [StringLength(150, MinimumLength = 2)]
    public string FullNmae { get; set; } = string.Empty;

    [Required]
    [StringLength(72, MinimumLength = 12)]
    public string Password { get; set; } = string.Empty;

}