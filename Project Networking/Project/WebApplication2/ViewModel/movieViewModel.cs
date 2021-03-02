using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using WebApplication2.Models;
using WebApplication2.Dal;

namespace WebApplication2.ViewModel
{
    public class movieViewModel
    {
        public Movie movie { get; set; }

        public List<Movie> movies { get; set; }
    }
}