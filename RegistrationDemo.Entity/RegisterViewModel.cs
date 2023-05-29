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
        [Required(ErrorMessage = "Surname is Required"),
        StringLength(15, MinimumLength = 3,ErrorMessage = "Surname should be minimum 3 and maximum 10 alphabets"),
      /*  RegularExpression(@"(\S\D)+", ErrorMessage = " Space and numbers not allowed")]*/]
        public string Surname { get; set; }

        [Required(ErrorMessage = "FirstName is Required"),
        /* RegularExpression(@"(\S\D)+", ErrorMessage = " Space and numbers not allowed")]*/]
        public string FirstName { get; set; }

        public string MiddleName { get; set; }

        [Required(ErrorMessage = "DateOfBirth is Required")]
        public DateTime DateOfBirth { get; set; }

        [Required(ErrorMessage = "Gender is Required")]
        public int Gender { get; set; }

        [Required(ErrorMessage = "PinCode is Required"),
         DataType(DataType.PostalCode, ErrorMessage = " Please Enter Valid Postal Code"),
         DisplayFormat(NullDisplayText = "382220")]
        public long PinCode { get; set; }

        [Required(ErrorMessage = "Email is Required")]
        public string Email { get; set; }

        [Required(ErrorMessage = "CountryName is Required")]
        public long CountryId { get; set; }

        [Required(ErrorMessage = "StateName is Required")]
        public long StateId { get; set; }

        [Required(ErrorMessage = "CityName is Required")]
        public long CityId { get; set; }
        
        [Required(ErrorMessage = "Password is Required"), 
         DataType(DataType.Password)]
        public string Password { get; set; }

        [Required(ErrorMessage = "ConfirmPassword is Required"),
         DataType(DataType.Password),
         System.ComponentModel.DataAnnotations.Compare(nameof(Password), ErrorMessage = "Please Re-enter Password Again it is not same as password")]
        public string ConfirmPassword { get; set; }

        [Required(ErrorMessage = "PhoneNumber is Required")]
        public string PhoneNumber { get; set; }


        public IEnumerable<Country> Countries { get; set; } = Enumerable.Empty<Country>();


    }
}
