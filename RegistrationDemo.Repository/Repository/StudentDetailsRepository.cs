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
    public class StudentDetailsRepository : IStudentDetailsRepository
    {
        private readonly string _connectionString;
        public StudentDetailsRepository(string connectionString)
        {
            _connectionString = connectionString;
        }


        public int RegisterUser(RegisterViewModel register)
        {
           
            using (var connection = new SqlConnection(_connectionString))
            {
                connection.Open();
                try
                {
                    SqlCommand command = new SqlCommand("sp_StudentDetails_AddStudent", connection);
                    command.CommandType = CommandType.StoredProcedure;
                    /*command.Parameters.AddWithValue("Surname", register.Surname);*/
                    command.Parameters.AddWithValue("FirstName", register.FirstName);
                    command.Parameters.AddWithValue("MiddleName", register.MiddleName);
                    command.Parameters.AddWithValue("DateOfBirth", register.DateOfBirth);
                    command.Parameters.AddWithValue("Gender", register.Gender);
                    command.Parameters.AddWithValue("CountryId", register.CountryId);
                    command.Parameters.AddWithValue("StateId", register.StateId);
                    command.Parameters.AddWithValue("CityId", register.CityId);
                    command.Parameters.AddWithValue("PinCode", register.PinCode);
                    command.Parameters.AddWithValue("EmailId", register.Email);
                    command.Parameters.AddWithValue("Password", register.Password);
                    command.Parameters.AddWithValue("ContactNo", register.PhoneNumber);
                    SqlParameter surname = new SqlParameter { 
                        ParameterName = "Surname",
                        Value = register.Surname,
                        Direction = ParameterDirection.Input,
                    };
                    command.Parameters.Add(surname);
                        
                    var data = command.ExecuteNonQuery();
                    return data;
                }
                catch (Exception e)
                {
                    Console.WriteLine("Error => ", e.Message);
                    return 0;
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
