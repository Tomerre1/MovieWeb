using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;
using WebApplication2.Models;
using System.Windows;

namespace WebApplication2.Models
{
    public class User
    {
        [Required]
        [RegularExpression("([A-Z]|[a-z])[a-z]+$", ErrorMessage = "-Invalid First Name\n")]
        public string FirstName { get; set; }


        [Required]
        [RegularExpression("([A-Z]|[a-z])[a-z]+$", ErrorMessage = "-Invalid Last Name\n")]
        public string LastName { get; set; }

        [Required]
        [RegularExpression("([a-z]|[A-Z])([a-z]|[A-Z]|[0-9])+$", ErrorMessage = "Invalid UserName format\n")]
        public string UserName { get; set; }



        [Required]
        public string UserEmail { get; set; }



        [Required]
        [StringLength(12, MinimumLength = 4, ErrorMessage = "-Invalid User Password: Min:5 Max:20 chars\n")]
        public string UserPassword { get; set; }



        [Required]
        [Key]
        [RegularExpression("^[0-9]{9}$", ErrorMessage = "-Invalid User ID is only 9 digits\n")]
        public string UserID { get; set; }


        [Required]
        [RegularExpression("^[0-9]{10}$", ErrorMessage = "-Invalid Phone Number is only 10 digits only\n")]
        public string UserPhone { get; set; }
    }
}