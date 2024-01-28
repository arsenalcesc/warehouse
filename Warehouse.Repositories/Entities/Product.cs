namespace Warehouse.DataLayer.Entities
{
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
        public DateTime AddedOnUtc { get; set; }
        public int AddedByUserId { get; set; }
        public DateTime? UpdatedOnUtc { get; set; }
        public int? UpdatedByUserId { get; set; }

        // Navigation properties
        public Category Category { get; set; }
        public User AddedByUser { get; set; }
        public User UpdatedByUser { get; set; }
        public Inventory Inventory { get; set; }
    }
}
