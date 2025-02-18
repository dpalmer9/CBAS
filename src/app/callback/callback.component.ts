import { Component, OnInit } from '@angular/core';
import { OAuthService } from 'angular-oauth2-oidc';
import { Router } from '@angular/router';

@Component({
    selector: 'app-callback',
    template: `<p>Processing login...</p>` // Simple loading message
})
export class CallbackComponent implements OnInit {

    constructor(private oauthService: OAuthService, private router: Router) { }

    ngOnInit(): void {
        // Process the login response from the OAuth2 server.
        this.oauthService.tryLogin().then(() => {
            // Check if the login process resulted in a valid access token.
            if (this.oauthService.hasValidAccessToken()) {
                // Navigate to the default or home route after a successful login.
                this.router.navigate(['/']);
            } else {
                // Optionally, you might redirect to an error page or re-initiate login.
                console.error('OAuth login failed. No valid access token found.');
                this.router.navigate(['/login']);
            }
        });
    }
}
