var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

app.MapGet("/", () => $"Hello from Whale container! {System.Environment.MachineName}");

app.Run("http://0.0.0.0:80");
