using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using AngularSPAWebAPI.Models;
using OpenIddict.EntityFrameworkCore.Models;
using Microsoft.AspNetCore.Identity;

namespace AngularSPAWebAPI.Data
{
    public class ApplicationDbContext : IdentityDbContext<ApplicationUser, IdentityRole, string>
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options)
            : base(options)
        {
        }

        public DbSet<OpenIddictEntityFrameworkCoreApplication> OpenIddictApplications { get; set; }
        public DbSet<OpenIddictEntityFrameworkCoreAuthorization> OpenIddictAuthorizations { get; set; }
        public DbSet<OpenIddictEntityFrameworkCoreScope> OpenIddictScopes { get; set; }
        public DbSet<OpenIddictEntityFrameworkCoreToken> OpenIddictTokens { get; set; }

        protected override void OnModelCreating(ModelBuilder builder)
        {
            base.OnModelCreating(builder);

            //builder.Entity<IdentityRole>(entity =>
            //{
            //    entity.HasKey(r => r.Id);
            //    entity.Property(r => r.Id)
            //    .HasColumnType("nvarchar(450)")
            //  .ValueGeneratedNever(); ;
            //});

            //builder.UseOpenIddict();
            // Customize the ASP.NET Identity model and override the defaults if needed.
            // For example, you can rename the ASP.NET Identity table names and more.
            // Add your customizations after calling base.OnModelCreating(builder);
        }
    }
}
