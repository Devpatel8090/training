using System.Data.SqlClient;

namespace RegistrationDemo.Utility
{
    public class Utilities
    {
        private readonly IConfiguration _configuration;
        private readonly string _connectionString;
        /*public Utilities(IConfiguration configuration)
        {
            _configuration = configuration;
            _connectionString = _configuration.GetSection("ConnectionStrings").GetSection("DBconnect").Value;

        }*/
        public string Encodepass(string str)
        {
            byte[] encData_byte = new byte[str.Length];           
            encData_byte = System.Text.Encoding.UTF8.GetBytes(str);
            string encodedPassword = Convert.ToBase64String(encData_byte);
            return encodedPassword;
        }

        public SqlConnection CreateConnection() => new SqlConnection(_connectionString);
    }
}
