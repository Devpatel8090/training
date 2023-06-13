using Microsoft.Extensions.Configuration;
using RegistrationDemo.Entity;
using RegistrationDemo.Repository.Interface;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RegistrationDemo.Repository.Repository
{
    public class CountryRepository : ICountryRepositoy
    {
        private readonly string _connectionString;
        public CountryRepository(string connectionString)
        {
            _connectionString = connectionString;
        }
        public IEnumerable<Country> GetAllCountries()
        {
           
            using (var connection = new SqlConnection(_connectionString))
            {
                connection.Open();

                try
                {
                    SqlCommand command = new SqlCommand("[dbo].[sp_Country_GetAllCountries]", connection);
                    command.CommandType = CommandType.StoredProcedure;
                    SqlDataReader reader = command.ExecuteReader();

                    List<Country> CountryList = new List<Country>();
                    Country country = null;

                    while (reader.Read())
                    {
                        country = new Country();
                        country.CountryId = int.Parse(reader["CountryId"].ToString());
                        country.CountryName = reader["CountryName"].ToString();
                        CountryList.Add(country);
                    }

                    return CountryList;

                }
                catch (Exception ex)
                {
                    Console.WriteLine("Error => ", ex.Message);
                    return null;
                }
                finally
                {
                    if (connection != null && connection.State == ConnectionState.Open)
                    {
                        connection.Close();
                    }
                }
            }
        }
    }
}
