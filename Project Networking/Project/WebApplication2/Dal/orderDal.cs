using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using WebApplication2.Models;
using System.Data.Entity;
using WebApplication2.ViewModel;
using WebApplication2.Dal;

namespace WebApplication2.Dal
{
    public class orderDal : DbContext
    {
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            Database.SetInitializer<orderDal>(null);
            base.OnModelCreating(modelBuilder);
            modelBuilder.Entity<Order>().ToTable("Orders");
        }
        public DbSet<Order> OrdersDB { get; set; }
    }
}
