using Microsoft.Extensions.Configuration;
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
    public class StateRepository : IStateRepository
    {
        private readonly IConfiguration _configuration;
        public StateRepository(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        public IEnumerable<State> GetStateByCountry(long countryId)
        {
            var connections = _configuration.GetSection("ConnectionStrings").GetSection("DBconnect").Value;
            using (var connection = new SqlConnection(connections))
            {
                connection.Open();

                try
                {
                    SqlCommand command = new SqlCommand("[dbo].[sp_State_GetAllStateByCountryId]", connection);
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("countryId",countryId);
                    SqlDataReader reader = command.ExecuteReader();

                    List<State> StateList = new List<State>();
                    State state = null;

                    while (reader.Read())
                    {
                        state = new State();
                        state.StateId = int.Parse(reader["StateId"].ToString());
                        state.StateName = reader["StateName"].ToString();
                        StateList.Add(state);
                    }

                    return StateList;

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
