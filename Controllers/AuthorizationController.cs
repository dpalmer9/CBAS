using System.Collections.Generic;
using System.Linq;
using System;
using System.Security.Claims;
using AngularSPAWebAPI.Models;
using Microsoft.AspNetCore;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using OpenIddict.Abstractions;
using OpenIddict.Server.AspNetCore;
using OpenIddict.Validation.AspNetCore;
using Microsoft.Extensions.DependencyInjection;
using static OpenIddict.Abstractions.OpenIddictConstants;
using Microsoft.Extensions.Primitives;

[Route("connect")]
public class AuthorizationController : Controller
{
    private readonly UserManager<ApplicationUser> _userManager;
    private readonly SignInManager<ApplicationUser> _signInManager;

    public AuthorizationController(UserManager<ApplicationUser> userManager,
                                   SignInManager<ApplicationUser> signInManager)
    {
        _userManager = userManager;
        _signInManager = signInManager;
    }
    [HttpGet("authorize"), HttpPost("authorize")]
    public IActionResult Authorize()
    {
        // Retrieve the OpenIddict request.
        var request = HttpContext.GetOpenIddictServerRequest();
        if (request == null)
        {
            throw new InvalidOperationException("The OpenIddict request cannot be retrieved.");
        }

        // If the user is not authenticated, redirect to the Angular login page.
        // Make sure to include a returnUrl (so that after login, Angular can redirect back).
        if (!User.Identity?.IsAuthenticated ?? true)
        {
            // Adjust the URL to point to your Angular app's login route.
            var loginUrl = "http://localhost:4200/account/signin?returnUrl=" +
                           Uri.EscapeDataString(Request.Path + Request.QueryString);
            return Redirect(loginUrl);
        }

        // At this point the user is authenticated.
        // Create a ClaimsIdentity based on the current user.
        var identity = new ClaimsIdentity(OpenIddictServerAspNetCoreDefaults.AuthenticationScheme);

        // For example, add the subject and name claims.
        var subjectClaim = new Claim(Claims.Subject, User.FindFirstValue(ClaimTypes.NameIdentifier));

        // Set the destinations for this claim.
        subjectClaim.SetDestinations(new[] { Destinations.AccessToken, Destinations.IdentityToken });

        // Add the claim to the identity.
        identity.AddClaim(subjectClaim);


        identity.AddClaim(Claims.Name, User.Identity.Name,
            Destinations.IdentityToken);

        // Retrieve roles from User claims
        var roleClaims = User.FindAll(ClaimTypes.Role).ToList();

        // Ensure roles are properly set
        foreach (var roleClaim in roleClaims)
        {
            var claim = new Claim("role", roleClaim.Value);
            claim.SetDestinations(new[] { Destinations.AccessToken, Destinations.IdentityToken });
            identity.AddClaim(claim);
        }

        // Set the list of scopes granted (typically the scopes requested by the client).
        identity.SetScopes(request.GetScopes());

        // Create the principal.
        var principal = new ClaimsPrincipal(identity);

        var properties = new AuthenticationProperties();

        if (!string.IsNullOrEmpty(request.CodeChallenge))
        {
            // You can use a well-known key, for example "code_challenge"
            properties.Items["code_challenge"] = request.CodeChallenge;
        }

        // Optionally, adjust the destinations for each claim.
        foreach (var claim in principal.Claims)
        {
            claim.SetDestinations(GetDestinations(claim, principal));
        }

        // Issue a sign-in response (this will generate an authorization code for the client).
        return SignIn(principal, properties, OpenIddictServerAspNetCoreDefaults.AuthenticationScheme);
    }

    // POST: /connect/token
    [HttpPost("token"), IgnoreAntiforgeryToken]
    public async Task<IActionResult> Exchange()
    {
        var request = HttpContext.GetOpenIddictServerRequest();
        if (request == null)
        {
            return BadRequest(new { error = "Invalid token request" });
        }

        if (request.IsAuthorizationCodeGrantType())
        {
            var result = await HttpContext.AuthenticateAsync(OpenIddictServerAspNetCoreDefaults.AuthenticationScheme);
            if (!result.Succeeded)
            {
                return BadRequest(new { error = "Invalid authorization code" });
            }

            result.Properties.Items.TryGetValue("code_challenge", out var storedCodeChallenge);
            var receivedCodeVerifier = request.CodeVerifier;

            if (!ValidatePkce(storedCodeChallenge, receivedCodeVerifier))
            {
                return BadRequest(new { error = "Invalid PKCE code verifier." });
            }

            return SignIn(result.Principal, OpenIddictServerAspNetCoreDefaults.AuthenticationScheme);
        }

        return BadRequest(new { error = "Unsupported grant type" });
    }

    [HttpPost("login")]
    public async Task<IActionResult> Login([FromBody] LoginInputModel model)
    {
        if (!ModelState.IsValid)
        {
            return BadRequest(ModelState);
        }

        var user = await _userManager.FindByNameAsync(model.Username);
        if (user == null)
        {
            return Unauthorized("Invalid username or password.");
        }

        var result = await _signInManager.PasswordSignInAsync(user, model.Password, isPersistent: true, lockoutOnFailure: false);
        if (!result.Succeeded)
        {
            return Unauthorized("Invalid username or password.");
        }

        // The cookie is issued automatically. Return a success response.
        if (!string.IsNullOrEmpty(model.ReturnUrl))
        {
            return Redirect(model.ReturnUrl);
        }

        // Otherwise, simply return an OK response.
        return Ok(new { message = "Login successful." });
    }

    [HttpPost("introspect"), IgnoreAntiforgeryToken]
    public async Task<IActionResult> Introspect()
    {
        // Expect the token to be provided as a form parameter named "token"
        if (!Request.HasFormContentType ||
            !Request.Form.TryGetValue("token", out StringValues tokenValues))
        {
            return BadRequest(new { error = "Token is missing." });
        }

        var token = tokenValues.FirstOrDefault();
        if (string.IsNullOrEmpty(token))
        {
            return BadRequest(new { error = "Token is missing." });
        }

        // Temporarily inject the token into the Authorization header.
        // This allows the OpenIddict validation middleware to validate it.
        var originalAuthorizationHeader = Request.Headers["Authorization"].FirstOrDefault();
        Request.Headers["Authorization"] = "Bearer " + token;

        // Validate the token using the OpenIddict validation scheme.
        var result = await HttpContext.AuthenticateAsync(OpenIddictValidationAspNetCoreDefaults.AuthenticationScheme);

        // Restore the original Authorization header.
        if (!string.IsNullOrEmpty(originalAuthorizationHeader))
        {
            Request.Headers["Authorization"] = originalAuthorizationHeader;
        }
        else
        {
            Request.Headers.Remove("Authorization");
        }

        // If the token is invalid, return an inactive response.
        if (!result.Succeeded)
        {
            return Ok(new { active = false });
        }

        var principal = result.Principal;

        // Extract useful information from the validated token.
        var subject = principal.Claims.FirstOrDefault(c => c.Type == "sub")?.Value;
        var expiration = principal.Claims.FirstOrDefault(c => c.Type == "exp")?.Value;
        var scopes = principal.Claims.Where(c => c.Type == "scope")
                                     .Select(c => c.Value);

        // Return a JSON response with the token's metadata.
        return Ok(new
        {
            active = true,
            sub = subject,
            exp = expiration,
            scope = string.Join(" ", scopes)
        });
    }

    public class LoginInputModel
    {
        public string Username { get; set; }
        public string Password { get; set; }

        public string ReturnUrl { get; set; }
    }

    // Validates PKCE Code Verifier
    private bool ValidatePkce(string codeChallenge, string codeVerifier)
    {
        if (string.IsNullOrEmpty(codeChallenge) || string.IsNullOrEmpty(codeVerifier))
        {
            return false;
        }

        using var sha256 = System.Security.Cryptography.SHA256.Create();
        var computedHash = Convert.ToBase64String(sha256.ComputeHash(System.Text.Encoding.UTF8.GetBytes(codeVerifier)))
            .Replace('+', '-')
            .Replace('/', '_')
            .TrimEnd('=');

        return computedHash == codeChallenge;
    }

    private IEnumerable<string> GetDestinations(Claim claim, ClaimsPrincipal principal)
    {
        // In a real application, set claim destinations as appropriate.
        // Here we simply send all claims in both the access and identity tokens.
        return new[] { Destinations.AccessToken, Destinations.IdentityToken };
    }
}
