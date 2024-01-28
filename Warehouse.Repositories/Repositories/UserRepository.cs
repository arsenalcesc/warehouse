using Microsoft.EntityFrameworkCore;
using Warehouse.DataLayer.DTOs;

namespace Warehouse.DataLayer.Repositories
{
    public class UserRepository
    {

        private readonly WarehouseDbContext _context;

        public UserRepository(WarehouseDbContext context)
        {
            _context = context;
        }

        public async Task<UserDto> GetByUsernameAndPassword(string username, string password)
        {
            var user = await _context.Users.FirstOrDefaultAsync(u => u.Username == username && u.Password == password);

            if (user == null)
                return null;

            return new UserDto
            {
                Username = user.Username,
                FirstName = user.FirstName,
                LastName = user.LastName
            };
        }
    }
}
