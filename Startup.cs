using System;
using System.ComponentModel;
using System.Linq;
using System.Threading.Tasks;
using AngularSPAWebAPI.Data;
using AngularSPAWebAPI.Models;
using AngularSPAWebAPI.Services;
using CBAS.Extensions;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Http.Features;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Design;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Options;
using Nest;
using OpenIddict.Abstractions;
using OpenIddict.Core;
using OpenIddict.EntityFrameworkCore;
using OpenIddict.Server;
using Serilog;
using Serilog.Exceptions;
using static Microsoft.IO.RecyclableMemoryStreamManager;
using OpenIddict.Validation.AspNetCore;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;

namespace AngularSPAWebAPI
{
    public class Startup
    {
        private readonly IHostingEnvironment currentEnvironment;

        public Startup(IConfiguration configuration, IHostingEnvironment env)
        {

            Configuration = configuration;

            currentEnvironment = env;
            Log.Logger = new LoggerConfiguration().ReadFrom.Configuration(Configuration).CreateLogger();
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            services.AddMvc(options => options.EnableEndpointRouting = false);

            services.AddSession();

            services.AddDbContext<ApplicationDbContext>(options =>
            {
                options.UseSqlServer(Environment.GetEnvironmentVariable("DEF_CONN"));
                options.UseOpenIddict();
            }
                );

            services.AddIdentity<ApplicationUser, IdentityRole>(config =>
            {
                config.SignIn.RequireConfirmedEmail = true;
            }
        )
    .AddEntityFrameworkStores<ApplicationDbContext>()
    .AddDefaultTokenProviders();

            services.Configure<IdentityOptions>(options =>
            {
                // Password settings.
                options.Password.RequireDigit = true;
                options.Password.RequiredLength = 8;
                options.Password.RequireNonAlphanumeric = false;
                options.Password.RequireUppercase = true;
                options.Password.RequireLowercase = false;
                // Lockout settings.
                options.Lockout.AllowedForNewUsers = true;
                options.Lockout.MaxFailedAccessAttempts = 10;
                options.Lockout.DefaultLockoutTimeSpan = TimeSpan.FromHours(1);
            });

            services.AddAuthorization(options =>
            {
            });

            services.AddAuthentication(options =>
            {
                options.DefaultAuthenticateScheme = IdentityConstants.ApplicationScheme;
                options.DefaultChallengeScheme = IdentityConstants.ApplicationScheme;
            });

            services.ConfigureApplicationCookie(options =>
            {
                options.Cookie.Name = "MouseBytesAuth";
                options.Cookie.SameSite = SameSiteMode.None;
                options.Cookie.SecurePolicy = CookieSecurePolicy.Always;
                options.ExpireTimeSpan = TimeSpan.FromDays(30);
                options.SlidingExpiration = true;
            });

            // Adds application services.
            services.AddTransient<IEmailSender, EmailSender>();
            //services.Add(ServiceDescriptor.Transient<IElasticClient, EmailSender>());
            services.AddElasticSearch(Configuration);

            //Adds serilog to 
            services.AddSerilog();

            // Uncomment this line for publuishing
            //services.AddIdentityServer(options =>
            //         options.PublicOrigin = "https://mousebytes.ca")

    services.AddOpenIddict()

    // Core services (database stores, etc.)
    .AddCore(options =>
    {
        // Configure OpenIddict to use the EF Core stores/models
        options.UseEntityFrameworkCore()
               .UseDbContext<ApplicationDbContext>(); // Replace with your actual DbContext
    })
    // Server features
    .AddServer(options =>
    {
        options.SetIssuer(new Uri("http://localhost:5000/"));
        // Enable the endpoints you need
        options.SetAuthorizationEndpointUris("/connect/authorize")
               .SetTokenEndpointUris("/connect/token")
               .SetUserInfoEndpointUris("/connect/userinfo")
               .SetConfigurationEndpointUris("/.well-known/openid-configuration")
               .SetIntrospectionEndpointUris("/connect/introspect");
        // Register the signing and encryption credentials
        // For dev/test, you can use .AddDevelopmentSigningCertificate()
        // or .AddEphemeralEncryptionKey(), but for production you should use a real certificate.
        options.AllowAuthorizationCodeFlow()
                   .RequireProofKeyForCodeExchange();
        options.AcceptAnonymousClients();


        options.DisableAccessTokenEncryption();

        options.RegisterScopes("openid", "profile", "email", "roles", "api");

        options.AddDevelopmentEncryptionCertificate()
               .AddDevelopmentSigningCertificate();

        // Register ASP.NET Core host and HTTP features
        options.UseAspNetCore()
                   .EnableTokenEndpointPassthrough()
                   .EnableUserInfoEndpointPassthrough()
                   .DisableTransportSecurityRequirement()
                   .EnableAuthorizationEndpointPassthrough();

        // If you want a custom consent page, you can override default or use built-in.
        // ...
    })
    // Validation features
    .AddValidation(options =>
    {
        // Import the configuration from the server
        options.UseLocalServer();
        options.UseAspNetCore();
    });

            services.Configure<OpenIddictServerOptions>(options =>
            {
                options.Issuer = new Uri("http://localhost:5000/");
            });

            services.AddControllersWithViews();

            services.AddCors(options =>
            {
                options.AddPolicy("AllowAngularClient", policy =>
                {
                    policy.WithOrigins("http://localhost:4200") // Allow requests from Angular app
                          .AllowAnyHeader()
                          .AllowAnyMethod()
                          .AllowCredentials();
                });
            });

        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IHostingEnvironment env)
        {


            app.UseSerilogRequestLogging(); // To enable Serilog request logging
            app.UseCors("AllowAngularClient");
            if (env.IsDevelopment())
            {
                //app.UseCors("LocalCorsPolicy");
                app.UseDeveloperExceptionPage();
                // Starts "npm start" command using Shell extension.
                app.Shell("ng serve");
            }
            else
            {
                //app.UseCors("ProductionCorsPolicy");
                app.UseExceptionHandler("/Home/Error");
                app.UseHsts();
            }


            app.UseSession();
            app.UseHttpsRedirection();
            app.UseRouting();
            app.UseAuthentication();
            app.UseAuthorization();
            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllers();

            });


            // Router on the server must match the router on the client (see app.routing.module.ts) to use PathLocationStrategy.
            var appRoutes = new[] {
                 "/home",
                 "/account/signin",
                 "/account/signup",
                 "/account/forgot",
                 "/resources",
                 "/dashboard",
                 "/taskAnalysis",
                 "/upload",
                 "/animal-info",
                 "/experiment",
                 "/data-extraction",
                 "/data-link",
                 "/search-experiment",
                 "/manage-user",
                 "/profile",
                 "/imaging",
                 "/genomics",
                 "/guideline",
                 "/data-visualization",
                 "/video-tutorial",
                 "/forms",
                 "/terms",
                 "/contact-us",
                 "/account/reset",
                 "/download-ds",
                 "/mb-dashboard",
                 "/pubScreen-dashboard",
                 "/pubScreen",
                 "/pubScreen-search",
                 "/comp",
                 "/comp-search",
                 "/pubScreen-queue",
                 "/pubScreen-edit",
                 "/comp-edit",
            };

            app.Use(async (context, next) =>
            {
                if (context.Request.Path.HasValue && appRoutes.Contains(context.Request.Path.Value))
                {
                    context.Request.Path = new PathString("/");
                }

                await next();
            });

            // Microsoft.AspNetCore.StaticFiles: API for starting the application from wwwroot.
            // Uses default files as index.html.
            app.UseDefaultFiles();
            // this should always be the last middleware
            app.UseStaticFiles();


        }
    }
}
