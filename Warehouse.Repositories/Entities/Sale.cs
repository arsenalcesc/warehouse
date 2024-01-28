namespace Warehouse.DataLayer.Entities
{
    public class Sale
    {
        public int SaleId { get; set; }
        public int CustomerId { get; set; }
        public DateTime SaleDate { get; set; }
        public int SaleByUserId { get; set; }
        public DateTime AddedOnUtc { get; set; }
        public int AddedByUserId { get; set; }

        // Navigation properties
        public Customer Customer { get; set; }
        public User SaleByUser { get; set; }
        public User AddedByUser { get; set; }
        public List<SaleItem> SaleItems { get; set; }
    }
}
