import { Injectable } from '@angular/core';
import { AuthConfig, OAuthService } from 'angular-oauth2-oidc';

import { environment } from '../environments/environment';

export const oAuthDevelopmentConfig: AuthConfig = {

  clientId: 'AngularCBAS',
    scope: 'openid profile email roles api offline_access',
  issuer: 'http://localhost:5000/',
  requireHttps: false,
  redirectUri: window.location.origin + '/home',
  responseType: 'code',
    strictDiscoveryDocumentValidation: false,
    showDebugInformation: true,
    disableAtHashCheck: true

};

export const oAuthProductionConfig: AuthConfig = {

    clientId: 'AngularCBAS',
    scope: 'openid profile email api',
    issuer: 'http://localhost:5000/',
    requireHttps: true,
    waitForTokenInMsec: 1000,
    redirectUri: window.location.origin + '/auth-callback',
    responseType: 'code',

};

/**
 * angular-oauth2-oidc configuration.
 */
//@Injectable({
//  providedIn: 'root',
//  })
//export class OAuthConfig {
//  constructor(private oAuthService: OAuthService) { }

//  load(): Promise<void> {
//    const config = environment.production
//      ? oAuthProductionConfig
//      : oAuthDevelopmentConfig;

//    // Configure OAuthService
//    this.oAuthService.configure(config);

//    // Set storage (e.g., localStorage)
//    this.oAuthService.setStorage(localStorage);

//    // Load discovery document and try login
//    return this.oAuthService
//      .loadDiscoveryDocumentAndTryLogin()
//      .then(() => {
//        // Additional logic after successful configuration, if needed
//        console.log('OAuth configuration loaded successfully');
//      })
//      .catch((error) => {
//        console.error('Error loading OAuth configuration', error);
//        throw error;
//      });
//  }
//}
