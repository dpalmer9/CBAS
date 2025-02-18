import { Injectable } from '@angular/core';
import { HttpHeaders, HttpParams, HttpClient } from '@angular/common/http';
import { Router, ActivatedRoute } from '@angular/router';
import { Observable ,  BehaviorSubject } from 'rxjs';
import { interval } from 'rxjs';
import { timer } from 'rxjs';

import { OAuthService } from 'angular-oauth2-oidc';
import { oAuthDevelopmentConfig } from '../oauth.config'
import { firstValueFrom } from 'rxjs';
import { User } from '../models/user';

/**
 * PKCE Authentication service.
 */
@Injectable({
    providedIn: 'root',
}) export class AuthenticationService {

  // As in OAuthConfig.
  public storage: Storage = localStorage;

  /**
     * Stores the URL so we can redirect after signing in.
     */
  public redirectUrl: string = "";

  public signinStatus$: Observable<boolean>;

  public user$: Observable<User>;

  /**
     * Behavior subjects of the user's status & data.
     */
  private _user: User = { email: '', familyName: '', givenName: '', roles: [], selectedPiSiteIds: [], termsConfirmed: false, userName: '' }
    ;
    // private signinStatus = new BehaviorSubject<boolean>(false);
    // private user = new BehaviorSubject<User>(this._user);



  /**
     * Scheduling of the refresh token.
     */
  private refreshSubscription: any;

  /**
     * Offset for the scheduling to avoid the inconsistency of data on the client.
     */
  private offsetSeconds = 30;

  private signinStatus = new BehaviorSubject<boolean>(false);

    private user = new BehaviorSubject<User>(this._user);

    private authEndpoint = 'http://localhost:5000/connect/authorize';
    private tokenEndpoint = 'http://localhost:5000/connect/token';
    private clientId = 'AngularCBAS';
    private codeVerifier: string = '';

  constructor(
    private router: Router,
      private oAuthService: OAuthService,
      private http: HttpClient,
      private route: ActivatedRoute
  ) {
      //this.route.queryParams.subscribe(params => {
      //    this.redirectUrl = params['returnUrl'] || '/';
      //});
      this.init();
      this.signinStatus$ = this.signinStatus.asObservable();


      this.user$ = this.user.asObservable();
    // this._user = { Email: '', familyName: '', givenName: '', roles: [], selectedPiSiteIds: [], termsConfirmed: false, userName: '' }
  }

    public init(): void {
        this.oAuthService.configure(oAuthDevelopmentConfig);
        this.oAuthService.loadDiscoveryDocument().then(() => {
            this.oAuthService.tryLoginCodeFlow().then(() => {
                console.log("✅ User authenticated with valid access token.");
                this.signinStatus.next(true);
                this.user.next(this.getUser());
            });
        });

        this.oAuthService.events.subscribe(e => {
            console.log('OAuth Event:', e);
            if (e.type === 'token_received') {
                console.log("Access Token:", this.oAuthService.getAccessToken());
            }
        });

        this.oAuthService.events.subscribe(e => {
            console.log('Oauth Event:', e);
            if (e.type === 'token_received') {
                console.log("Access Token:", this.oAuthService.getAccessToken());
            }
        });
    // Tells all the subscribers about the new status & data.
    }

    async signin(username: string, password: string): Promise<any> {
        this.http.post('http://localhost:5000/connect/login', {
            username: username,
            password: password
        }, { withCredentials: true }).subscribe({
            next: () => {
                // After successful login, redirect the browser to the authorization endpoint.
                // This will trigger the OpenIddict authorization flow (including PKCE).
                this.oAuthService.initCodeFlow();
                this.router.navigate(['/home']);
            }
        });
    }

  public signout(): void {
    this.oAuthService.logOut();


    // Tells all the subscribers about the new status & data.
    this.signinStatus.next(false);
    this.user.next(this._user);
    }

    public processLoginCallback(): void {
        try {
            // This method processes the authorization response (the auth code) and exchanges it for tokens.
            this.oAuthService.tryLoginCodeFlow();

            if (this.oAuthService.hasValidAccessToken()) {
                // Update your BehaviorSubjects with the logged-in status and user info.
                this.signinStatus.next(true);
                // Assume getUser() extracts the user info from the access token or by other means.
                this.user.next(this.getUser());
                // Navigate to your home or desired page.
                this.router.navigate(['/home']);
            } else {
                // If tokens are not available, consider the login unsuccessful.
                this.signinStatus.next(false);
            }
        } catch (err) {
            console.error('Error processing login callback:', err);
            this.signinStatus.next(false);
        }
    }

  public getAuthorizationHeader(): HttpHeaders {
    // Creates header for the auth requests.
    let headers: HttpHeaders = new HttpHeaders().set('Content-Type', 'application/json');
    headers = headers.append('Accept', 'application/json');

    const token: string = this.oAuthService.getAccessToken();
    if (token) {
      headers = headers.set('Authorization', `Bearer ${token}`);
    }
    return headers;
  }

  public isSignedIn(): Observable<boolean> {
    return this.signinStatus.asObservable();
  }

  public userChanged(): Observable<User> {
    return this.user.asObservable();
  }

  public isInRole(role: string): boolean {
    const user: User = this.getUser();
    const roles: string[] = user && typeof user.roles !== 'undefined' ? user.roles : [];
    return roles.indexOf(role) !== -1;
  }

  public getUser(): User {
    const user: User = { email: '', familyName: '', givenName: '', roles: [], selectedPiSiteIds: [], termsConfirmed: false, userName: '' };
    if (this.oAuthService.hasValidAccessToken()) {
      const userInfo: any = this.oAuthService.getIdentityClaims();

      user.givenName = userInfo.given_name;
      user.familyName = userInfo.family_name;
      user.userName = userInfo.name;
      user.roles = userInfo.role;
    }
    return user;
  }

  /**
     * Strategy for refresh token through a scheduler.
     * Will schedule a refresh at the appropriate time.
     */
    public scheduleRefresh(): void {
        // Calculate delay based on token expiry (this is a simple example).
        const refreshDelay = this.calcDelay(this.getAuthTime());
        const source: Observable<number> = interval(refreshDelay);

        this.refreshSubscription = source.subscribe(() => {
            this.oAuthService.refreshToken()
                .then(() => {
                    // Token refreshed successfully.
                })
                .catch((error: any) => {
                    this.handleRefreshTokenError();
                });
        });
    }

  /**
     * Case when the user comes back to the app after closing it.
     */
  public startupTokenRefresh(): void {
    if (this.oAuthService.hasValidAccessToken()) {
      const source: Observable<number> = timer(this.calcDelay(new Date().valueOf()));

      // Once the delay time from above is reached, gets a new access token and schedules additional refreshes.
      source.subscribe(() => {
        this.oAuthService.refreshToken()
          .then(() => {
            this.scheduleRefresh();
          })
          .catch((error: any) => {
            this.handleRefreshTokenError();
          });
      });
    }
    }

  /**
     * Unsubscribes from the scheduling of the refresh token.
     */
  private unscheduleRefresh(): void {
    if (this.refreshSubscription) {
      this.refreshSubscription.unsubscribe();
    }
  }

  /**
     * Handles errors on refresh token, like expiration.
     */
  private handleRefreshTokenError(): void {
    this.redirectUrl = this.router.url;

    // Tells all the subscribers about the new status & data.
    this.signinStatus.next(false);
    this.user.next(this._user);

    // Unschedules the refresh token.
    this.unscheduleRefresh();

    // The user is forced to sign in again.
    this.router.navigate(['/account/signin']);
  }

  private calcDelay(time: number): number {
    const expiresAt: number = this.oAuthService.getAccessTokenExpiration();
    const delay: number = expiresAt - time - this.offsetSeconds * 1000;
    return delay > 0 ? delay : 0;
  }

  private getAuthTime(): number {
    const storageitem: any = this.storage.getItem('access_token_stored_at');
    if (storageitem != null) {
      return parseInt(storageitem, 10);
    } else {
      return 0;
    }
    }

    private isOnSignInPage(): boolean {
        return window.location.pathname.toLowerCase().includes('signin');
    }

    private async exchangeCodeForToken(authorizationCode: string) {
        const body = new HttpParams()
            .set('grant_type', 'authorization_code')
            .set('code', authorizationCode)
            .set('client_id', this.clientId)
            .set('code_verifier', this.codeVerifier); // Send the original code verifier

        try {
            const response: any = await firstValueFrom(this.http.post(this.tokenEndpoint, body));
            console.log('Token received:', response);
        } catch (error) {
            console.error('Token exchange failed:', error);
        }
    }

    logout() {
        console.log('User logged out');
    }

    private generateCodeVerifier(): string {
        const array = new Uint8Array(32);
        window.crypto.getRandomValues(array);
        return this.base64UrlEncode(array);
    }

    private async generateCodeChallenge(codeVerifier: string): Promise<string> {
        const encoder = new TextEncoder();
        const data = encoder.encode(codeVerifier);
        const digest = await window.crypto.subtle.digest('SHA-256', data);
        return this.base64UrlEncode(new Uint8Array(digest));
    }

    private base64UrlEncode(array: Uint8Array): string {
        return btoa(String.fromCharCode(...array))
            .replace(/\+/g, '-')
            .replace(/\//g, '_')
            .replace(/=+$/, '');
    }
}
