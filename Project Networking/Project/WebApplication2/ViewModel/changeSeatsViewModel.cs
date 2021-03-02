using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using WebApplication2.Models;
using WebApplication2.Dal;

namespace WebApplication2.ViewModel
{
    public class changeSeatsViewModel
    {
        public string userName { get; set; }
        public string movieName { get; set; }
        public string date { get; set; }
        public string time { get; set; }
        public HallSeats hall { get; set; }
        public List<Order> orders { get; set; }
        public string newSeats { get; set; }

        public string subTotal { get; set; }
        public string price { get; set; }
    }
}