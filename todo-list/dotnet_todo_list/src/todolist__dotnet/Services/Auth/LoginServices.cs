using System.Net.Mail;
using todolist__dotnet.Models.Request;
using todolist__dotnet.Models.Response;

namespace todolist__dotnet.Services.Auth;

public class LoginServices {
    public LoginServices() {}
    public LoginResponseModel LoginUserService(LoginRequestModel model) {
        return new LoginResponseModel{
            Token = "test token"
        };
    }

}