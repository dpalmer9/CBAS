import { Component, OnInit, Input, OnChanges, ElementRef, HostListener } from '@angular/core';
import { BreakpointObserver, Breakpoints } from '@angular/cdk/layout'
import { Router, NavigationEnd } from '@angular/router';
import { Title } from '@angular/platform-browser';
import { Observable, of } from 'rxjs';
import { OAuthService } from 'angular-oauth2-oidc';
import { oAuthDevelopmentConfig } from './oauth.config'
import { AuthenticationService } from './services/authentication.service';
import { User } from './models/user';


declare let $: any;
declare const gtag: Function;


@Component({
  selector: 'app-root',
  templateUrl: './app.component.html'
  })
export class AppComponent implements OnInit {


    isMobile = false;
    isTablet = false;
    isDesktop = false;
  navItemsAll: any[] = [
    { name: 'Data Lab', route: 'data-extraction' },
    { name: 'Data Visualization', route: 'data-visualization' },
    { name: 'Search', route: 'search-experiment' },
    ];

    navItemsUser: any[] = [
        { name: 'Experiment', route: 'experiment' },
        { name: 'Upload', route: 'upload' },
        { name: 'Animal', route: 'animal-info' },
        { name: 'Upload Log', route: 'dashboard'},
    ];

    navItemsAdmin: any[] = [
        { name: 'User Management', route: 'manage-user' },
    ];

  navItemsTutorials: any[] = [

    { name: 'Guidelines', route: 'guideline' },
    { name: 'Video Tutorials', route: 'video-tutorial' },

  ];

  navItemsResources: any[] = [

    { name: 'Contact US', route: 'contact-us' },
    { name: 'Forms', route: 'forms' },
    { name: 'Terms of Service', route: 'terms' },
  ];

  navItemsIntegration: any[] = [
    { name: 'Imaging', route: 'imaging' },
    { name: 'Genomics', route: 'genomics' }
  ];

  navItemsPubscreen: any[] = [
    { name: 'Searching Publications', route: 'pubScreen-search' }
  ];

  public signedIn!: Observable<boolean>;

  name: string;
  isAdmin: boolean;
  isUser: boolean;
  isFullDataAccess: boolean;
  key: any;
  showFooter: boolean;

  constructor(
    public title: Title,
    private oAuthService: OAuthService,
    private authenticationService: AuthenticationService,
    private router: Router,
      private el: ElementRef,
      private breakpointObserver: BreakpointObserver
  ) {
    this.name = '';
    this.isAdmin = false;
    this.isUser = false;
    this.isFullDataAccess = false;
    this.showFooter = false;

  }

    ngOnInit() {

        this.breakpointObserver.observe([Breakpoints.Handset]).subscribe((result: any) => {
            this.isMobile = result.matches;
            this.isTablet = false;
            this.isDesktop = false;
        });

        this.breakpointObserver.observe([Breakpoints.Tablet]).subscribe((result: any) => {
            this.isTablet = result.matches;
            this.isMobile = false;
            this.isDesktop = false;
        });

        this.breakpointObserver.observe([Breakpoints.Web]).subscribe((result: any) => {
            this.isDesktop = result.matches;
            this.isMobile = false;
            this.isTablet = false;
        });
        this.title.setTitle('MouseBytes');
        const urlParams = new URLSearchParams(window.location.search);
        if (urlParams.has('code') || urlParams.has('error')) {
            //this.authenticationService.processLoginCallback();

            // Optionally, clear the URL parameters to clean up the browser's address bar.
            // For example, you can navigate to the home route.
            //this.router.navigate(['/home']);
        }

    this.signedIn = this.authenticationService.isSignedIn();

    this.authenticationService.userChanged().subscribe(
      (user: User) => {
        this.name = user.givenName;
        this.isAdmin = this.authenticationService.isInRole('administrator');
        this.isUser = this.authenticationService.isInRole('user');
        this.isFullDataAccess = this.authenticationService.isInRole('fulldataaccess');
          });


    }

  mouseEnter(div: string) {
    if (div === 'homelink') {
      $('#homeImage').css('visibility', 'visible');
    } else if (div === 'contactus') {
      $('#contactImage').css('visibility', 'visible');
    } else if (div === 'aboutus') {
      $('#aboutImage').css('visibility', 'visible');
    }
  }

  mouseLeave(div: string) {
    if (div === 'homelink') {
      $('#homeImage').css('visibility', 'hidden');
    } else if (div === 'contactus') {
      $('#contactImage').css('visibility', 'hidden');
    } else if (div === 'aboutus') {
      $('#aboutImage').css('visibility', 'hidden');
    }
    }

    public signin(): void {
        // Initiate the Authorization Code Flow with PKCE.
        this.oAuthService.initLoginFlow();
    }

  signout(): void {
    this.authenticationService.signout();

    this.router.navigate(['/home']);
  }

  scrollTo(className: string): void {
    const elementList = document.querySelectorAll('.' + className);
    const element = elementList[0] as HTMLElement;
    element.scrollIntoView({ block: 'start', inline: 'nearest' }); // , behavior: 'smooth'
  }

  navigateHomeAndScrollTo(element: any) {
    this.router.navigate(['/home']).then(() => {
      this.scrollTo(element);
    });
  }

  // @HostListener('document:keydown', ['$event'])
  // handleKeyboardEvent(event: KeyboardEvent) {
  //    let x = event.keyCode;
  //    if (x === 40) {
  //        console.log(2);
  //        this.scrollTo('about');
  //    }
  // }

  showHideFooter(routerUrl: string) {
    if (routerUrl.toUpperCase() === '' ||
            routerUrl.toUpperCase() === '/home'.toUpperCase() ||
            routerUrl.toUpperCase() === '/data-extraction'.toUpperCase() ||
            routerUrl.toUpperCase() === '/data-visualization'.toUpperCase() ||
            routerUrl.toUpperCase() === '/mb-dashboard'.toUpperCase() ||
            routerUrl.toUpperCase() === '/pubScreen-dashboard'.toUpperCase() ||
            routerUrl.toUpperCase().indexOf('/data-link'.toUpperCase()) !== -1 ||
            routerUrl.toUpperCase() === '/guideline'.toUpperCase() ||
            routerUrl.toUpperCase() === '/imaging'.toUpperCase() ||
            routerUrl.toUpperCase() === '/genomics'.toUpperCase() ||
            routerUrl.toUpperCase() === '/video-tutorial'.toUpperCase() ||
            routerUrl.toUpperCase() === '/contact-us'.toUpperCase() ||
            routerUrl.toUpperCase() === '/forms'.toUpperCase() ||
            routerUrl.toUpperCase() === '/terms'.toUpperCase() ||
            routerUrl.toUpperCase() === '/account/signin'.toUpperCase() ||
            routerUrl.toUpperCase() === '/account/signup'.toUpperCase() ||
            routerUrl.toUpperCase() === '/search-experiment'.toUpperCase() ||
            routerUrl.toUpperCase() === '/pubScreen'.toUpperCase() ||
            routerUrl.toUpperCase() === '/pubScreen-queue'.toUpperCase() ||
            routerUrl.toUpperCase() === '/pubScreen-edit'.toUpperCase() ||
            routerUrl.toUpperCase() === '/comp-edit'.toUpperCase() ||
            // routerUrl.toUpperCase() === '/comp'.toUpperCase() ||
            routerUrl.toUpperCase() === '/comp-search'.toUpperCase()

    ) {
      this.showFooter = true;
    } else {
      this.showFooter = false;
    }

  }

  onActivate(event: any) {

    this.showHideFooter(this.router.url);
    }

    @HostListener('window:beforeunload', ['$event'])
    appUnload(): void {
        localStorage.setItem('autoLoginAttempted', 'false')
        console.log('Flag Switched')
    }

    private isOnSignInPage(): boolean {
        return window.location.pathname.toLowerCase().includes('signin');
    }

}
