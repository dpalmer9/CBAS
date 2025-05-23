import { Component } from '@angular/core';
import { ScrollService } from '../shared/scroll.service';
import { AnimalService } from '../services/animal.service';

@Component({
    selector: 'app-home',
    templateUrl: './home.component.html',
    styleUrls: ['./home.component.scss'],
    providers: [AnimalService]
})
export class HomeComponent {
    showItem: boolean;

    images: any;

    mouseCounter: number;

    carouselOptions: any = {
        items: 1, dots: false, nav: true, loop: true,
        navText: ["<i class='fa fa-chevron-circle-left' style='color:  #795D9C'></i>", "<i class='fa fa-chevron-circle-right' style='color:   #795D9C'></i>"]
    }

    constructor(
        private animalService: AnimalService,
        private scrollService: ScrollService,
    ) {
        this.showItem = false;
        this.mouseCounter = 0;

    }

    ngAfterViewInit() {
        this.scrollService.scrollToTop();
    }

    ngOnInit() {


        this.images = [
            //{ src: '../assets/images/cognitive2.png', btnVisible: true, btnText: 'Cognitive Behavioral Data Lab', btnLink: '/data-extraction', alt:" Graphic illustration of a human head with a gear, a lightning bolt, and a circle above the head and lines connecting them"},
            //{ src: '../assets/images/image-data-integraion.png', btnVisible: true, btnText: 'Image Data Lab (Coming Soon!)', btnLink: '/' },
            //{ src: '../assets/images/genetic-data-integration.png', btnVisible: true, btnText: 'Genomics Data Lab (Coming Soon!)', btnLink: '/' }

        ]

        //this.mouseCounter = 1200;
        this.animalService.getCountOfAnimals().subscribe(data => {
            this.mouseCounter = data;
            
        });
        //this.mouseCounter = this.animalService.getCountOfAnimals();

    }

    ngAfterViewChecked() {
        setTimeout(() => {
            this.showItem = true;
        });
    }


}





