import { Injectable } from '@angular/core';

import { Router } from '@angular/router';

import { OAuthService } from 'angular-oauth2-oidc';

import { AuthenticationService } from '../services/authentication.service';

import { IdentityService } from '../services/identity.service';

import { ManageUserService } from '../services/manageuser.service';

/**
 * Provides signin method to signin & signup components.
 */
@Injectable()
export class Signin {

  model: any = {};

  errorMessages: any[] = [];

  isEmailApproved: boolean;
  isTermsConfirmed: boolean;

  constructor(
    protected router: Router,
    protected oAuthService: OAuthService,
    protected authenticationService: AuthenticationService,
    protected manageuserService: ManageUserService) {

    this.isEmailApproved = false;
    this.isTermsConfirmed = false;
  }

  clearMessages(): void {
    this.errorMessages = [];
    }

}
