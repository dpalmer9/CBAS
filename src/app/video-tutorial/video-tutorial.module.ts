import { NgModule } from '@angular/core';
import { VideoTutorialRoutingModule } from './video-tutorial-routing.module';
import { SharedModule } from '../shared/shared.module';
import { VideoTutorialComponent } from './video-tutorial.component';
import { TaskAnalysisService } from '../services/taskanalysis.service';
import { PagerService } from '../services/pager.service';


@NgModule({
    imports: [
        VideoTutorialRoutingModule,
        SharedModule,
        

    ],
    declarations: [
        VideoTutorialComponent,
        
    ],
    providers: [
        TaskAnalysisService,
        PagerService,
        
    ],
    bootstrap: [VideoTutorialComponent],

    exports: [VideoTutorialComponent],
})
export class VideoTutorialModule { } 

