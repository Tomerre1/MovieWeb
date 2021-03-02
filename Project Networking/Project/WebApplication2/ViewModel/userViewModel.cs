using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using WebApplication2.Models;
using WebApplication2.Dal;

namespace WebApplication2.ViewModel
{
    public class userViewModel
    {
        public User user { get; set; }
        public List<User> users { get; set; }
    }
}