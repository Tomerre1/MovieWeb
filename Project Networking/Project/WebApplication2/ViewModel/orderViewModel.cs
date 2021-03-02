using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using WebApplication2.Models;
using WebApplication2.Dal;

namespace WebApplication2.ViewModel
{
    public class orderViewModel
    {
        public User user { get; set; }
        public Movie myMovie { get; set; }
        public string date { get; set; }
        public string time { get; set; }
        public string hall { get; set; }
        public List<Order> orders { get; set; }
       
        public HallSeats HallRows { get; set; }
    }
}