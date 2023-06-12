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
    public class CategoryRepository : ICategoryRepository
    {

        private readonly IConfiguration _configuration;
        public CategoryRepository(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        public IEnumerable<Category> GetCategories()
        {
            var connections = _configuration.GetSection("ConnectionStrings").GetSection("DBconnect").Value;
            using (var connection = new SqlConnection(connections))
            {
                connection.Open();

                try
                {
                    SqlCommand command = new SqlCommand("[dbo].sp_INVCategory_GetAllCategories", connection);
                    command.CommandType = CommandType.StoredProcedure;

                    SqlDataReader reader = command.ExecuteReader();

                    List<Category> CategoryList = new List<Category>();
                    Category category = null;

                    while (reader.Read())
                    {
                        category = new Category();
                        category.CategoryName = reader["CategoryName"].ToString();
                        category.Description = reader["Description"].ToString();
                        /*city.CityName = Convert.ToString(reader["CityName"]);*/
                        CategoryList.Add(category);
                    }

                    return CategoryList;

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

        public int AddCategories(IncomeViewModel model)
        {

            var connections = _configuration.GetSection("ConnectionStrings").GetSection("DBconnect").Value;
            using (var connection = new SqlConnection(connections))
            {
                connection.Open();
                try
                {
                    SqlCommand command = new SqlCommand("[dbo].sp_INVCategory_AddCategories", connection);
                    command.CommandType = CommandType.StoredProcedure;

                    command.Parameters.AddWithValue("CategoryName", model.Category.CategoryName);
                    command.Parameters.AddWithValue("Description", model.Category.Description);
                    

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
