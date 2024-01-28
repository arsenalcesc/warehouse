using Warehouse.DataLayer.DTOs;
using Warehouse.DataLayer.Repositories;

namespace Warehouse.BusinessLayer.Services
{
    public class UserService
    {
        private readonly UserRepository _userRepository;

        public UserService(UserRepository userRepository)
        {
            _userRepository = userRepository;
        }

        public async Task<UserDto> GetByUsernameAndPassword(string username, string password)
        {
            return await _userRepository.GetByUsernameAndPassword(username, password);
        }
    }
}
