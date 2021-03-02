using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using WebApplication2.Models;
using WebApplication2.Dal;

namespace WebApplication2.ViewModel
{
    public class cartViewModel
    {
        public Cart cart { get; set; }

        public List<Cart> user_carts { get; set; }

    }
}