using Microsoft.AspNetCore.Mvc;
using todolist__dotnet.Models.Request;
using todolist__dotnet.Services.Auth;

namespace todolist__dotnet.Controllers.Auth;

[Route("api/auth")]
[ApiController]
public class LoginController : ControllerBase {

    private readonly  LoginServices _services;
    public LoginController(LoginServices services) {
        _services = services;
    }

    [HttpPost("login")]
    public IActionResult Login(LoginRequestModel md){
        var res = _services.LoginService(md);
        return Ok(res);
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