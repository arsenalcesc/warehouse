using Microsoft.EntityFrameworkCore;
using Warehouse.BusinessLayer.Services;
using Warehouse.DataLayer;
using Warehouse.DataLayer.Repositories;

namespace WarehouseAPI
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var builder = WebApplication.CreateBuilder(args);

            // Add services to the container.
            builder.Services.AddCors(options =>
            {
                options.AddPolicy("AllowAll", builder =>
                    builder.AllowAnyOrigin()
                           .AllowAnyMethod()
                           .AllowAnyHeader());
            });

            builder.Services.AddControllers();
            // Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
            builder.Services.AddEndpointsApiExplorer();
            builder.Services.AddSwaggerGen();


            builder.Services.AddDbContext<WarehouseDbContext>(options =>
                options.UseSqlServer(builder.Configuration.GetConnectionString("WarehouseDbConnection")));

            builder.Services.AddScoped<CategoryService>();
            builder.Services.AddScoped<ProductService>();
            builder.Services.AddScoped<SaleService>();
            builder.Services.AddScoped<UserService>();


            builder.Services.AddScoped<CategoryRepository>();
            builder.Services.AddScoped<ProductRepository>();
            builder.Services.AddScoped<SaleRepository>();
            builder.Services.AddScoped<UserRepository>();


            var app = builder.Build();

            // Configure the HTTP request pipeline.
            if (app.Environment.IsDevelopment())
            {
                app.UseSwagger();
                app.UseSwaggerUI();
            }

            app.UseHttpsRedirection();
            app.UseStaticFiles(); // Enable static file serving
            app.UseAuthorization();

            app.MapControllers();

            app.UseCors("AllowAll");
            app.Run();
        }
    }
}