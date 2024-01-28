namespace Warehouse.DataLayer.Entities
{
    public class User
    {
        public int UserId { get; set; }
        public string Username { get; set; }
        public string Email { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Password { get; set; } // Very bad practice, only a placeholder for now
        public bool IsAdmin { get; set; }
        public DateTime AddedOnUtc { get; set; }
        public int AddedByUserId { get; set; }
        public DateTime? UpdatedOnUtc { get; set; }
        public int? UpdatedByUserId { get; set; }
    }
}
