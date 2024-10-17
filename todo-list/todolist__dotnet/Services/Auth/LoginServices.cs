using System.Net.Mail;
using todolist__dotnet.Models.Request;
using todolist__dotnet.Models.Response;

namespace todolist__dotnet.Services.Auth;

public class LoginServices {
    public LoginServices() {}
    public LoginResponseModel LoginService(LoginRequestModel model) {
        return new LoginResponseModel{
            Token = "test token"
        };
    }

    public string GetJwtToken(){
        return "this is the return";
    }

    public LoginResponseModel RegisterService(LoginRequestModel model) {
        return new LoginResponseModel{
            Token = "test token"
        };
    }
    public void GetOtpRegister() {}
    public void ConfirmOtpRegister() {}

    public LoginResponseModel SetPasswordService(LoginRequestModel model) {
        return new LoginResponseModel{
            Token = "test token"
        };
    }

    public void EmailSender(string sendTo, string linkTokenEmail) {
        // SmtpClient client = new SmtpClient("Smp")
    }
}


// using System.Net.Mail;
// using System.Net;
// using System.Text;

// namespace Sending_Emails_in_Asp.Net_Core
// {
//     public class EmailSender : IEmailSender
//     {
//         public void SendEmail(string toEmail, string subject)
//         {
//             // Set up SMTP client
//             SmtpClient client = new SmtpClient("smtp.ethereal.email", 587);
//             client.EnableSsl = true;
//             client.UseDefaultCredentials = false;
//             client.Credentials = new NetworkCredential("abby.wehner53@ethereal.email", "djgwPz8DPss78aakBv");

//             // Create email message
//             MailMessage mailMessage = new MailMessage();
//             mailMessage.From = new MailAddress("abby.wehner53@ethereal.email");
//             mailMessage.To.Add(toEmail);
//             mailMessage.Subject = subject;
//             mailMessage.IsBodyHtml = true;
//             StringBuilder mailBody = new StringBuilder();
//             mailBody.AppendFormat("<h1>User Registered</h1>");
//             mailBody.AppendFormat("<br />");
//             mailBody.AppendFormat("<p>Thank you For Registering account</p>");
//             mailMessage.Body = mailBody.ToString();

//             // Send email
//             client.Send(mailMessage);
//         }
//     }
// }