using Microsoft.AspNetCore.Mvc;
using System;

namespace WarehouseAPI.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class UserController : ControllerBase
    {
        [HttpPost]
        public IActionResult Post([FromBody] LoginModel login)
        {
            if (login.Username == "admin" && login.Password == "pass")
            {
                // Return a simple guid as a token
                var token = Guid.NewGuid().ToString();

                // Create a response object with required details
                var response = new
                {
                    Token = token,
                    Username = login.Username,
                    FirstName = "AdminFirstName", // Replace with actual first name
                    LastName = "AdminLastName" // Replace with actual last name
                };

                return Ok(response);
            }
            else
            {
                return Unauthorized();
            }
        }

        public class LoginModel
        {
            public string Username { get; set; }
            public string Password { get; set; }
        }
    }
}
