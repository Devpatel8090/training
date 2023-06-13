using RegistrationDemo.Entity.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RegistrationDemo.Repository.Interface
{
    public interface ICategoryRepository
    {
        public IEnumerable<Category> GetCategories();
        public int AddOrUpdateCategories(IncomeViewModel model);

        public string EditCategory(long categoryId);


    }
}
