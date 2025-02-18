using AngularSPAWebAPI.Data;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using OpenIddict.Abstractions;
using System.Threading.Tasks;
using System;
using static OpenIddict.Abstractions.OpenIddictConstants;

public static class SeedData
{
    public static async Task InitializeAsync(IServiceProvider serviceProvider)
    {
        using var scope = serviceProvider.CreateScope();
        var context = scope.ServiceProvider.GetRequiredService<ApplicationDbContext>();

        // Apply pending migrations (if any)
        await context.Database.MigrateAsync();

        // Get the OpenIddict application manager.
        var applicationManager = scope.ServiceProvider.GetRequiredService<IOpenIddictApplicationManager>();

        var existingClient = await applicationManager.FindByClientIdAsync("AngularCBAS");

        if (existingClient != null)
        {
            // ✅ Update the existing client
            var descriptor = new OpenIddictApplicationDescriptor
            {
                ClientId = "AngularCBAS",
                DisplayName = "MouseBytes",

                // ✅ Ensure redirect URIs match Angular
                RedirectUris = { new Uri("http://localhost:4200/index.html") },
                PostLogoutRedirectUris = { new Uri("http://localhost:4200/") },

                Permissions =
            {
                OpenIddictConstants.Permissions.Endpoints.Authorization,
                OpenIddictConstants.Permissions.Endpoints.Token,
                OpenIddictConstants.Permissions.GrantTypes.AuthorizationCode,
                OpenIddictConstants.Permissions.ResponseTypes.Code,
                OpenIddictConstants.Permissions.GrantTypes.RefreshToken,

                // ✅ Explicitly allow the requested scopes
                OpenIddictConstants.Permissions.Prefixes.Scope + "openid",
                OpenIddictConstants.Permissions.Prefixes.Scope + "profile",
                OpenIddictConstants.Permissions.Prefixes.Scope + "email",
                OpenIddictConstants.Permissions.Prefixes.Scope + "roles",

                // ✅ Allow custom API scope
                OpenIddictConstants.Permissions.Prefixes.Scope + "api"
            },

                Requirements =
            {
                OpenIddictConstants.Requirements.Features.ProofKeyForCodeExchange
            }
            };

            // ✅ Apply the updates
            await applicationManager.UpdateAsync(existingClient, descriptor);

            //// Seed a client application if it doesn't exist.
            //if (await applicationManager.FindByClientIdAsync("AngularCBAS") == null)
            //{
            //    var descriptor = new OpenIddictApplicationDescriptor
            //    {
            //        ClientId = "AngularCBAS",
            //        DisplayName = "MouseBytes",
            //        RedirectUris = { new Uri("http://localhost:4200/index.html") },
            //        PostLogoutRedirectUris = { new Uri("http://localhost:4200/") },
            //        Permissions =
            //        {
            //            Permissions.Endpoints.Authorization,
            //            Permissions.Endpoints.Token,
            //            Permissions.GrantTypes.AuthorizationCode,
            //            Permissions.ResponseTypes.Code,
            //            Permissions.Scopes.Email,
            //            Permissions.Scopes.Profile,
            //            Permissions.Scopes.Roles,
            //            // If using refresh tokens
            //            Permissions.GrantTypes.RefreshToken,
            //        },
            //        Requirements =
            //        {
            //            // Enforce Proof Key for Code Exchange (PKCE) for public clients.
            //            Requirements.Features.ProofKeyForCodeExchange
            //        }
            //    };

            //    await applicationManager.CreateAsync(descriptor);
        }

        // Similarly, you can seed scopes if needed.
        // Example:
        var scopeManager = scope.ServiceProvider.GetRequiredService<IOpenIddictScopeManager>();
        if (await scopeManager.FindByNameAsync("api") == null)
        {
            var scopeDescriptor = new OpenIddictScopeDescriptor
            {
                Name = "api",
                DisplayName = "API Access"
            };

            await scopeManager.CreateAsync(scopeDescriptor);
        }
    }
}
