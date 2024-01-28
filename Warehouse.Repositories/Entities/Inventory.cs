namespace Warehouse.DataLayer.Entities
{
    public class Inventory
    {
        public int ProductId { get; set; }
        public int QuantityInStock { get; set; }
        public DateTime LastUpdated { get; set; }

        // Navigation properties
        public Product Product { get; set; }
    }
}
