using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RegistrationDemo.Entity.Model
{
    public class IncomeViewModel
    {
        public Category Category { get; set; }
        public IEnumerable<Category> Categories { get; set; }   
    }
}
