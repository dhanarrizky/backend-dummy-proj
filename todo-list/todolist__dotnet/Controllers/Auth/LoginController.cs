using Microsoft.AspNetCore.Mvc;

namespace todolist__dotnet.Controllers.Auth;

[Route("api/auth")]
[ApiController]
public class LoginController : ControllerBase {
    [HttpPost("login")]
    public IActionResult Login(){
        return Ok(new { message = "test" });
    }

    [HttpPost("register")]
    public IActionResult Register(){
        return Ok();
    }

    [HttpPost("OtpCode")]
    public IActionResult OtpCode(){
        return Ok();
    }

    [HttpPost("ConfirmPass")]
    public IActionResult ConfirmPass(){
        return Ok();
    }
}