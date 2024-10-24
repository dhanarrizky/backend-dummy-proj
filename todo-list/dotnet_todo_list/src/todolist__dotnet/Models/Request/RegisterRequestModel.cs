namespace todolist__dotnet.Models.Request;

public class RegisterRequestModel {
    [Required(ErrorMessage = "Username is Required!")]
    public string Username { get; set; } = null!;

    [Required(ErrorMessage = "Password is Required!")]
    [StringLength(50, MinimumLength = 8, ErrorMessage = "The Password must have a minimum of 8 characters")]
    public string Password { get; set; } = null!;
    
    [Required(ErrorMessage = "Email is Required!")]
    [EmailAddress(ErrorMessage = "Invalid Email Address")]
    public string Email { get; set; } = null!;
    
    [Required(ErrorMessage = "PhoneNumber is Required!")]
    [StringLength(13, MinimumLength = 10, ErrorMessage = "Phone Number must be between 10 and 13 characters")]
    public string PhoneNumber { get; set; } = null!;
}