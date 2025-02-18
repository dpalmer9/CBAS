using OpenIddict.Abstractions;
using OpenIddict.Core;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

public static class OpenIddictConfig
{
    public static async Task InitializeAsync(OpenIddictApplicationManager<OpenIddictApplicationDescriptor> applicationManager)
    {
        if (await applicationManager.FindByClientIdAsync("AngularCBAS") is null)
        {
            var descriptor = new OpenIddictApplicationDescriptor
            {
                ClientId = "AngularCBAS",
                ConsentType = OpenIddictConstants.ConsentTypes.Implicit,
                DisplayName = "Angular Client",
                //Type = OpenIddictConstants.ClientTypes.Public,
                PostLogoutRedirectUris = { new Uri("http://localhost:4200") },
                RedirectUris = { new Uri("http://localhost:4200") },
                Permissions =
                {
                    OpenIddictConstants.Permissions.Endpoints.Authorization,
                    OpenIddictConstants.Permissions.Endpoints.Token,
                    OpenIddictConstants.Permissions.GrantTypes.AuthorizationCode,
                    OpenIddictConstants.Permissions.GrantTypes.RefreshToken,
                    OpenIddictConstants.Permissions.ResponseTypes.Code,
                    OpenIddictConstants.Permissions.Scopes.Email,
                    OpenIddictConstants.Permissions.Scopes.Profile,
                    OpenIddictConstants.Permissions.Scopes.Roles,
                    //OpenIddictConstants.Permissions.Scopes.OfflineAccess
                }
            };

            await applicationManager.CreateAsync(descriptor);
        }
    }
}
