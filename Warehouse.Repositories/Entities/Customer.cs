namespace Warehouse.DataLayer.Entities
{
    public class Customer
    {
        public int CustomerId { get; set; }
        public string BusinessName { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Email { get; set; }
        public string Phone { get; set; }
        public string Address { get; set; }
        public DateTime AddedOnUtc { get; set; }
        public int AddedByUserId { get; set; }
        public DateTime? UpdatedOnUtc { get; set; }
        public int? UpdatedByUserId { get; set; }

        // Navigation properties
        public User AddedByUser { get; set; }
        public User UpdatedByUser { get; set; }
    }
}
