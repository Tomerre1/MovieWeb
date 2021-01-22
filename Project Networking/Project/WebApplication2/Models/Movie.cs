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
    public class Movie
    {
        public string movie_image { get; set; }
        public string movie_description { get; set; }
        [Key]
        public string movieName { get; set; }
        public int price { get; set; }
        public int prev_price { get; set; }

        public string category { get; set; }

        public int age { get; set; }

    }
}
