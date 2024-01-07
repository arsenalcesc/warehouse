using Microsoft.AspNetCore.Mvc;
using System;
using WarehouseAPI.Services;

namespace WarehouseAPI.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class UserController : ControllerBase
    {
        //add a constructor to inject the user service
        private readonly UserService _userService;

        public UserController(UserService userService)
        {
            _userService = userService;
        }

        [HttpPost]
        public IActionResult Post([FromBody] LoginModel login)
        {
            var user = _userService.Login(login.Username, login.Password);

            if (user == null)
                return Unauthorized();

            var response = new
            {
                Username = user.Username,
                FirstName = user.FirstName,
                LastName = user.LastName
            };

            return Ok(response);
        }

        public class LoginModel
        {
            public string Username { get; set; }
            public string Password { get; set; }
        }
    }
}
