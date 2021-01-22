using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using WebApplication2.Models;
using WebApplication2.Dal;

namespace WebApplication2.ViewModel
{
    public class hallSeatsViewModel
    {
        public HallSeats hall { get; set; }
        public List<HallSeats> halls { get; set; }
    }
}