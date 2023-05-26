using Microsoft.AspNetCore.Mvc;
using RegistrationDemo.Entity;
using RegistrationDemo.Repository.Interface;
using System.Data;
using System.Data.SqlClient;


namespace RegistrationDemo.Controllers
{
    public class RegistrationController : Controller
    {
        private readonly IConfiguration _configuration;
        private readonly IUnitOfWorkRepository _unitOfWork;
        public RegistrationController(IConfiguration configuration,IUnitOfWorkRepository unitOfWork)
        {
            _configuration = configuration; 
            _unitOfWork = unitOfWork;
        }
        [HttpGet]
        public IActionResult Register()
        {
            var today = DateTime.Now;
            var minYear = today.Year - 7;
            var minMonth = today.Month;
            var minDay = today.Day;
            System.DateTime maxdate = new System.DateTime(minYear, minMonth, minDay);
           
            var registrationModel = new RegisterViewModel
            {
               Countries = _unitOfWork.Country.GetAllCountries(),
               DateOfBirth = maxdate,
               PinCode = 382220
            };
            return View(registrationModel);
        }

        [HttpPost]
        public IActionResult Register(RegisterViewModel register)
        {
            /*var connections = _configuration.GetSection("ConnectionStrings").GetSection("DBconnect").Value;

            var connection2 = _configuration.GetValue<string>("ConnectionStrings:DBconnect");*/
            if (ModelState.IsValid)
            {
                var rowsAffected = _unitOfWork.StudentDetails.RegisterUser(register);
                if(rowsAffected > 0)
                {
                    TempData["success"] = "Registered Successfully";
                    return RedirectToAction("Privacy", "Home");
                }
                else
                {
                    TempData["error"] = "Sorry! Try Again";
                    return View(register);
                }
                
            }
            else
            {
                register.Countries = _unitOfWork.Country.GetAllCountries();
                return View(register);
            }
           
           
        }

        public JsonResult GetStateDetailsByCountry(long countryId)
        {
            //var city = _cities.CityByCountry(CountryId);
            var state = _unitOfWork.State.GetStateByCountry(countryId);

            return Json(state);
        } 
        public JsonResult GetCityDetailsByState(long stateId)
        {
            //var city = _cities.CityByCountry(CountryId);
            var city = _unitOfWork.City.GetCitiesByState(stateId);

            return Json(city);
        }

    }
}
