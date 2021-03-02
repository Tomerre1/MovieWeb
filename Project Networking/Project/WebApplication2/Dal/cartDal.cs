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
    public class cartDal : DbContext
    {
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            Database.SetInitializer<cartDal>(null);
            base.OnModelCreating(modelBuilder);
            modelBuilder.Entity<Cart>().ToTable("Cart");
        }
        public DbSet<Cart> CartDB { get; set; }
    }
}