using Microsoft.AspNetCore.Mvc;
using Warehouse.BusinessLayer.Services;

namespace WarehouseAPI.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class UsersController : ControllerBase
    {
        private readonly UserService _userService;

        public UsersController(UserService userService)
        {
            _userService = userService;
        }

        [HttpPost]
        public async Task<IActionResult> Post([FromBody] LoginModel login)
        {
            var user = await _userService.GetByUsernameAndPassword(login.Username, login.Password);

            if (user == null)
                return Unauthorized();

            return Ok(user);
        }

        public class LoginModel
        {
            public string Username { get; set; }
            public string Password { get; set; }
        }
    }
}
