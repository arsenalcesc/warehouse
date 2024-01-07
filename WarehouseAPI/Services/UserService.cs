
using WarehouseAPI.Database;

namespace WarehouseAPI.Services
{
    public class UserService
    {
        private readonly WarehouseDbContext _context;

        public UserService(WarehouseDbContext context)
        {
            _context = context;
        }

        public User Login(string username, string password)
        {
            // Ideally, compare password hashes, not plain text.
            return _context.Users.FirstOrDefault(u => u.Username == username && u.Password == password);
        }
    }
}
