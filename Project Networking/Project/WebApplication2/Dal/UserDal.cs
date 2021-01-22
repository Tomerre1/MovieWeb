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
    public class UserDal : DbContext
    {
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            Database.SetInitializer<UserDal>(null);
            base.OnModelCreating(modelBuilder);
            modelBuilder.Entity<User>().ToTable("tblUser");
        }
        public DbSet<User> Users { get; set; }
    }
}
