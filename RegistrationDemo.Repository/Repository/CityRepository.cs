﻿using Microsoft.Extensions.Configuration;
using RegistrationDemo.Entity.Model;
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
    public class CityRepository : ICityRepository
    {
       
        private readonly string _connectionString;
        
        public CityRepository(string connectionString)
        {
             _connectionString = connectionString;
        }

        public IEnumerable<City> GetCitiesByState(long stateId)
        {
           
            using (var connection = new SqlConnection(_connectionString))
            {
                connection.Open();

                try
                {
                    SqlCommand command = new SqlCommand("[dbo].sp_City_GetAllCityByStateId", connection);
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("stateId", stateId);
                    SqlDataReader reader = command.ExecuteReader();

                    List<City> CityList = new List<City>();
                    City city = null;

                    while (reader.Read())
                    {
                        city = new City();
                        city.CityId = int.Parse(reader["CityId"].ToString());
                        city.CityName = reader["CityName"].ToString();
                        /*city.CityName = Convert.ToString(reader["CityName"]);*/
                        CityList.Add(city);
                    }

                    return CityList;

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
