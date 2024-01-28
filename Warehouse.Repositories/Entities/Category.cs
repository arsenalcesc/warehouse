namespace Warehouse.DataLayer.Entities
{
    public class Category
    {
        public int CategoryId { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public DateTime AddedOnUtc { get; set; }
        public int AddedByUserId { get; set; }
        public DateTime? UpdatedOnUtc { get; set; }
        public int? UpdatedByUserId { get; set; }
        public ICollection<Product> Products { get; set; }

        // Navigation properties
        public User AddedByUser { get; set; }
        public User UpdatedByUser { get; set; }
    }
}
