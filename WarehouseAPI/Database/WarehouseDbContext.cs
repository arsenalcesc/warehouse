using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;

namespace WarehouseAPI.Database
{
    /*
    public class WarehouseDbContext
    {
        public class WarehouseDbContext : DbContext
        {
            public DbSet<User> Users { get; set; }

            protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
            {
                optionsBuilder.UseSqlServer("Server=localhost\\SQLEXPRESS;Database=WarehouseDB;Trusted_Connection=True;");
            }
        }

        public class User
        {
            public int Id { get; set; }
            public string Username { get; set; }
            public string Email { get; set; }
            public string FirstName { get; set; }
            public string LastName { get; set; }
            public string Password { get; set; } // Ideally, this should be a hash, not plain text.
            public bool IsAdmin { get; set; }
            public DateTime AddedOn { get; set; }
            public int AddedBy { get; set; }
            public DateTime? UpdatedOn { get; set; }
            public int? UpdatedBy { get; set; }
        }
    }
    */
}
