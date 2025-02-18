import { NgModule } from '@angular/core';
import { TermsRoutingModule } from './terms-routing.module';
import { SharedModule } from '../shared/shared.module';
import { TermsComponent } from './terms.component';

import { AuthenticationService } from '../services/authentication.service';
import { TaskAnalysisService } from '../services/taskanalysis.service';

import { PagerService } from '../services/pager.service';


@NgModule({
  imports: [
  TermsRoutingModule,
  SharedModule,
// MatSelectModule,


  ],
  declarations: [
  TermsComponent,

  ],
  providers: [
  // AuthenticationService,
  TaskAnalysisService,
// GenomicsService,
  PagerService,

  ],
  bootstrap: [TermsComponent]

  })
export class TermsModule { }

