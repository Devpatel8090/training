using RegistrationDemo.Entity.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RegistrationDemo.Repository.Interface
{
    public interface IStateRepository
    {
        public IEnumerable<State> GetStateByCountry(long countryId);
    }
}
