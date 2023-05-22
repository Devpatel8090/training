using Microsoft.AspNetCore.Mvc;
using RegistrationDemo.Entity;
using System.Data;
using System.Data.SqlClient;

namespace RegistrationDemo.Controllers
{
    public class RegistrationController : Controller
    {
        private readonly IConfiguration _configuration;
        public RegistrationController(IConfiguration configuration)
        {
            _configuration = configuration; 
        }
        [HttpGet]
        public IActionResult Register()
        {
            return View();
        }
        [HttpPost]
        public IActionResult Register(RegisterViewModel register)
        {
            var connections = _configuration.GetSection("ConnectionStrings").GetSection("DBconnect").Value;

            var connection2 = _configuration.GetValue<string>("ConnectionStrings:DBconnect");
            if (ModelState.IsValid)
            {
                // NEED NOT TO CLOSE CONNECTION USING BLOCK AUTOMATICALLY CLOSE IT
                using (var connection = new SqlConnection(connections))
                {
                    connection.Open();
                    SqlCommand command = new SqlCommand("AddStudent", connection);
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("Surname", register.Surname);
                    command.Parameters.AddWithValue("FirstName", register.FirstName);
                    command.Parameters.AddWithValue("LastName", register.LastName);
                    command.Parameters.AddWithValue("DateOfBirth", register.DateOfBirth);
                    command.Parameters.AddWithValue("Gender", register.Gender);
                    command.Parameters.AddWithValue("CountryId", register.CountryId);
                    command.Parameters.AddWithValue("StateId", register.StateId);
                    command.Parameters.AddWithValue("CityId", register.CityId);
                    command.Parameters.AddWithValue("PinCode", register.PinCode);
                    command.Parameters.AddWithValue("EmailId", register.Email);
                    command.Parameters.AddWithValue("Password", register.Password);
                    command.Parameters.AddWithValue("ContactNo", register.PhoneNumber);
                    command.ExecuteNonQuery();
                }
                return RedirectToAction("Privacy","Home");
            }
           
            return View();
        }
    }
}
