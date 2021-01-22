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
    public class movieDal:DbContext
    {
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            Database.SetInitializer<movieDal>(null);
            base.OnModelCreating(modelBuilder);
            modelBuilder.Entity<Movie>().ToTable("Movies");
        }
        public DbSet<Movie> MoviesDB { get; set; }
    }
}