using Microsoft.AspNetCore.Mvc;
using RegistrationDemo.Entity.Model;
using RegistrationDemo.Repository.Interface;

namespace RegistrationDemo.Controllers
{
    public class InventoryAdminController : Controller
    {
        private readonly IUnitOfWorkRepository _unitOfWork;
        public InventoryAdminController(IUnitOfWorkRepository unitOfWork)
        {
            _unitOfWork = unitOfWork;

        }
        public IActionResult Index()
        {
            return View();
        }
        public IActionResult Income()
        {
            IncomeViewModel model = new IncomeViewModel
            {
                Categories = _unitOfWork.Category.GetCategories(),
            }; 
            
            return View(model);
        }
        public IActionResult Payee()
        {
            return View();
        }
        [HttpPost]
        public IActionResult AddCategory(IncomeViewModel model)
        {
           
                var rowsAffected = _unitOfWork.Category.AddOrUpdateCategories(model);
                if(rowsAffected != null)
                {
                    TempData["success"] = "Category Added Or Updated Successfully";
                    return RedirectToAction("Income");
                }
                else
                {
                    TempData["error"] = "Oh No! Please Try Again";
                    return RedirectToAction("Income");

                }

            
           

        }

        public string EditCategory(long categoryId)
        {
            if(categoryId == 0)
            {
                TempData["error"] = "sorry!!!";
                return null;
            }
            else
            {
                var category = _unitOfWork.Category.EditCategory(categoryId);
                return category ;
            }
        }
    }
}
