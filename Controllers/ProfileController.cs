using AngularSPAWebAPI.Models;
using AngularSPAWebAPI.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using AngularSPAWebAPI.Models.AccountViewModels;
using OpenIddict.Validation.AspNetCore;
using System.Linq;
using System.Security.Claims;
using System.IdentityModel.Tokens.Jwt;

namespace AngularSPAWebAPI.Controllers
{
    /// <summary>
    /// Resources Web API controller.
    /// </summary>
    [Route("api/[controller]")]
    // Authorization policy for this API.
    [Authorize(AuthenticationSchemes = OpenIddictValidationAspNetCoreDefaults.AuthenticationScheme)]
    public class ProfileController : Controller
    {
        private readonly ProfileService _profileService;
        private readonly UserManager<ApplicationUser> _manager;
        

        public ProfileController(UserManager<ApplicationUser> manager)
        {
            _profileService = new ProfileService();
            _manager = manager;
        }

        
        [HttpGet("GetUserInfo")]
        public async Task<IActionResult> GetUserInfo()
        {
            var userId = User.FindFirstValue(JwtRegisteredClaimNames.Sub);
            var user = await _manager.FindByIdAsync(userId);
            var userID = user.Id;

            return new JsonResult(_profileService.GetUserInfoByID(userID));
        }

        [HttpPost("UpdateProfile")]
        public async Task<IActionResult> UpdateProfile ([FromBody]CreateViewModel UserModel)
        {
            var userId = User.FindFirstValue(JwtRegisteredClaimNames.Sub);
            var user = await _manager.FindByIdAsync(userId);
            _profileService.UpdateProfile(UserModel, userId);
            return new JsonResult("Done!");
        }

        [HttpPost("ChangePassword")]
        public async Task<IActionResult> ChangePassword([FromBody]ChangePasswordModel model)
        {
            var userId = User.FindFirstValue(JwtRegisteredClaimNames.Sub);
            var user = await _manager.FindByIdAsync(userId);
            var userEmail = user.UserName;

            var appUser = await _manager.FindByNameAsync(userEmail);
            if (appUser == null)
            {
                return new JsonResult("Invalid Email!");
            }
            var result = await _manager.ChangePasswordAsync(appUser, model.currentPassword, model.newPassword);

            return new JsonResult(result);
        }

    }
}
