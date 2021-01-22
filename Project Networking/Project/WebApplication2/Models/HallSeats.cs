using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;
using WebApplication2.Models;
using System.Windows;
using System.ComponentModel.DataAnnotations.Schema;

namespace WebApplication2.Models
{
    public class HallSeats
    {
        [Key]
        public string HallId { get; set; }

        public string numRows { get; set; }
    }
}