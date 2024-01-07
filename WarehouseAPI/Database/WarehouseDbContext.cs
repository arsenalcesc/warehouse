using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;

namespace WarehouseAPI.Database
{
    public class WarehouseDbContext : DbContext
    {
        public DbSet<User> Users { get; set; }
        public DbSet<Category> Categories { get; set; }
        public DbSet<Product> Products { get; set; }
        public DbSet<Inventory> Inventories { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            optionsBuilder.UseSqlServer("Server=localhost\\SQLEXPRESS;Database=WarehouseDB;Trusted_Connection=True;");
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            // Explicitly configure ProductId as the primary key for Inventory
            modelBuilder.Entity<Inventory>()
                .HasKey(i => i.ProductId);

            // If you haven't configured the one-to-one relationship yet, do it as follows
            modelBuilder.Entity<Inventory>()
                .HasOne(i => i.Product)
                .WithOne(p => p.Inventory)
                .HasForeignKey<Inventory>(i => i.ProductId);

            // Other configurations...
        }

    }

    public class User
    {
        public int UserId { get; set; }
        public string Username { get; set; }
        public string Email { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Password { get; set; } // Ideally, this should be a hash, not plain text.
        public bool IsAdmin { get; set; }
        public DateTime AddedOn { get; set; }
        public int AddedByUserId { get; set; }
        public DateTime? UpdatedOn { get; set; }
        public int? UpdatedByUserId { get; set; }
    }


    public class Category
    {
        public int CategoryId { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public DateTime AddedOn { get; set; }
        public int AddedByUserId { get; set; }
        public DateTime? UpdatedOn { get; set; }
        public int? UpdatedByUserId { get; set; }
        public ICollection<Product> Products { get; set; }

        // Navigation properties for foreign keys, if needed
        // public User AddedByUser { get; set; }
        // public User UpdatedByUser { get; set; }
    }

    public class Product
    {
        public int ProductId { get; set; }
        public string Name { get; set; }
        public decimal Price { get; set; }
        public string Description { get; set; }
        public int CategoryId { get; set; }
        public string ImageUrl { get; set; }
        public decimal CBM { get; set; }
        public int QuantityPerBox { get; set; }
        public DateTime AddedOn { get; set; }
        public int AddedByUserId { get; set; }
        public DateTime? UpdatedOn { get; set; }
        public int? UpdatedByUserId { get; set; }

        // Navigation properties
        public Category Category { get; set; }
        public User AddedByUser { get; set; }
        public User UpdatedByUser { get; set; }
        public Inventory Inventory { get; set; } // Navigation property to Inventory
    }


    public class Inventory
    {
        public int ProductId { get; set; }
        public int QuantityInStock { get; set; }
        public DateTime LastUpdated { get; set; }

        // Navigation property for the Product
        public Product Product { get; set; }
    }

}
