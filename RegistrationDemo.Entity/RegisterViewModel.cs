using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RegistrationDemo.Entity
{
    public class RegisterViewModel
    {
        [Required]
        public string Surname { get; set; }
        [Required]
        public string FirstName { get; set; }

        public string LastName { get; set; }
        [Required]
        public DateTime DateOfBirth { get; set; }
        [Required]
        public int Gender { get; set; }
        [Required]
        public long PinCode { get; set; }
        [Required]
        public string Email { get; set; }
        [Required]
        public long CountryId { get; set; }
        [Required]
        public long StateId { get; set; }
        [Required]
        public long CityId { get; set; }
        [Required]
        public string Password { get; set; }
        [Required]
        public string PhoneNumber { get; set; }
    }
}
