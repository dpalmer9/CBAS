using AngularSPAWebAPI.Models;
using AngularSPAWebAPI.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using OpenIddict.Validation.AspNetCore;
using System;
using System.Collections.Generic;
using System.Security.Claims;
using System.Threading.Tasks;
using System.IdentityModel.Tokens.Jwt;

namespace AngularSPAWebAPI.Controllers
{
    /// <summary>
    /// Resources Web API controller.
    /// </summary>
    [Route("api/[controller]")]
    // Authorization policy for this API.
    [Authorize(AuthenticationSchemes = OpenIddictValidationAspNetCoreDefaults.AuthenticationScheme)]
    public class PISiteController : Controller
    {
        private readonly PISiteService _piSiteService;
        private readonly UserManager<ApplicationUser> _manager;

        public PISiteController(UserManager<ApplicationUser> manager)
        {
            _piSiteService = new PISiteService();
            _manager = manager;
        }


        [HttpGet("GetPISite")]
        [AllowAnonymous]
        public IActionResult GetPISite()
        {
            return new JsonResult(_piSiteService.GetPISiteList());
        }

        [HttpGet("GetPISitebyUserID")]
        public async Task<IActionResult> GetPISitebyUserID()
        {
            var userId = User.FindFirstValue(JwtRegisteredClaimNames.Sub);
            var user = await _manager.FindByIdAsync(userId);
            var res = await _piSiteService.GetPISitebyUserIDAsync(userId);
            return new JsonResult(res);
        }


    }
}
