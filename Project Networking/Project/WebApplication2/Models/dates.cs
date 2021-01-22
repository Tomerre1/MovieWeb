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
    public class dates
    {

        public string movieName { get; set; }

        [Key]
        [Column(Order = 0)]

        public string movie_date { get; set; }

        [Key]
        [Column(Order = 1)]
        public string movie_time { get; set; }

        [Key]
        [Column(Order = 2)]
        public string hall { get; set; }
    }
}