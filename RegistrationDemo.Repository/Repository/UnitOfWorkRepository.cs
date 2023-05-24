using Microsoft.Extensions.Configuration;
using RegistrationDemo.Repository.Interface;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RegistrationDemo.Repository.Repository
{
    public class UnitOfWorkRepository: IUnitOfWorkRepository
    {
        private readonly IConfiguration _configuration;
        public UnitOfWorkRepository(IConfiguration configuration)
        {  
            _configuration = configuration;
            StudentDetails =  new StudentDetailsRepository(configuration); 
            Country = new CountryRepository(configuration);
            State = new StateRepository(configuration);
            City = new CityRepository(configuration);
        }
        public ICountryRepositoy Country { get; private set; }
        public IStudentDetailsRepository StudentDetails { get; private set; }

        public IStateRepository State { get; private set; }

        public ICityRepository City { get; private set; }



    }
}
