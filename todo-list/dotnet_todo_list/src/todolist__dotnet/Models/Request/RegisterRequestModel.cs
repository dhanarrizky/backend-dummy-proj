namespace todolist__dotnet.Models.Request;

public class RegisterRequestModel {
    public string Username { get; set; } = null!;
    public string Password { get; set; } = null!;
    public string Email { get; set; } = null!;
}