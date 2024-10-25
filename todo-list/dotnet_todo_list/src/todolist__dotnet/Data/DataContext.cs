using Microsoft.AspNetCore.Identity.EntityFrameworkCore;

namespace todolist__dotnet.Data;

public class DataContext : IdentityDbContext {
    // static async Task Main(string[] args)
    //     {
    //         var connString = "Host=localhost;Username=your_username;Password=your_password;Database=your_database";

    //         using var conn = new NpgsqlConnection(connString);
    //         await conn.OpenAsync();

    //         // Command untuk memanggil stored procedure
    //         using var cmd = new NpgsqlCommand("CALL insert_account(@p_name, @p_email)", conn);
    //         cmd.Parameters.AddWithValue("p_name", "John Doe");
    //         cmd.Parameters.AddWithValue("p_email", "johndoe@example.com");

    //         await cmd.ExecuteNonQueryAsync();

    //         Console.WriteLine("Stored procedure executed successfully!");
    //     }
}