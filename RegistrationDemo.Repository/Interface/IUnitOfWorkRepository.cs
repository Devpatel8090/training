using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RegistrationDemo.Repository.Interface
{
    public interface IUnitOfWorkRepository
    {
        public ICountryRepositoy Country { get; }
        public IStudentDetailsRepository StudentDetails { get; }
    }
}
