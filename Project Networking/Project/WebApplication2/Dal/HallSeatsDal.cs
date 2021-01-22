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
    public class HallSeatsDal:DbContext    {
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            Database.SetInitializer<HallSeatsDal>(null);
            base.OnModelCreating(modelBuilder);
            modelBuilder.Entity<HallSeats>().ToTable("HallRows");
        }
        public DbSet<HallSeats> HallSeatsDB { get; set; }
    }

}