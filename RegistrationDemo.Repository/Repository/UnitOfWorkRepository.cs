using Microsoft.Extensions.Configuration;
using RegistrationDemo.Repository.Interface;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RegistrationDemo.Repository.Repository
{
    public class UnitOfWorkRepository: IUnitOfWorkRepository
    {
        private readonly IConfiguration _configuration;
        private readonly string _connectionString;
       
        public UnitOfWorkRepository(IConfiguration configuration)
        {  
            _configuration = configuration;
            _connectionString = _configuration.GetSection("ConnectionStrings").GetSection("DBconnect").Value;
            StudentDetails =  new StudentDetailsRepository(_connectionString); 
            Country = new CountryRepository(_connectionString);
            State = new StateRepository(_connectionString);
            City = new CityRepository(_connectionString);
            Category = new CategoryRepository(_connectionString);
        }

        /*public SqlConnection CreateConnection() => new SqlConnection(_connectionString);*/
        public ICountryRepositoy Country { get; private set; }
        public IStudentDetailsRepository StudentDetails { get; private set; }

        public IStateRepository State { get; private set; }

        public ICityRepository City { get; private set; }

        public ICategoryRepository Category { get; private set; }



    }
}
