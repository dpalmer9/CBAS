import { Component, OnInit, Inject } from '@angular/core';
import { MatDialog, MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { FormControl, Validators, FormBuilder } from '@angular/forms';
import { CogbytesService } from '../services/cogbytes.service';
import { INVALIDEMAILADDRESS, PIALRADYEXISTS, PISUCCESSFULLYADDED, FIELDISREQUIRED } from '../shared/messages';



@Component({

    selector: 'app-cogbytesPIDialoge',
    templateUrl: './cogbytesPIDialoge.component.html',
    styleUrls: ['./cogbytesPIDialoge.component.scss'],
    providers: [CogbytesService]

})
export class CogbytesPIDialogeComponent implements OnInit {

           
    //private _request = new Request();

    // FormControl Parameters

    emailPI: FormControl;
    piName: FormControl;
    institution: FormControl;

    constructor(public thisDialogRef: MatDialogRef<CogbytesPIDialogeComponent>,
         
        private cogbytesService: CogbytesService,
        private fb: FormBuilder,
        @Inject(MAT_DIALOG_DATA) public data: any) {
        this.emailPI = fb.control('', [Validators.required, Validators.pattern("^[a-z0-9._%+-]+@[a-z0-9.-]+\\.[a-z]{2,4}$")])
        this.piName = fb.control('', [Validators.required])
        this.institution = fb.control('', [Validators.required])
    }

    ngOnInit() {
      
    }

    onCloseCancel(): void {


        this.thisDialogRef.close('Cancel');

    }

    onCloseSubmit(): void {      

        // Submiting the request to server
        this.cogbytesService.addPI(this.piName.value, this.institution.value, this.emailPI.value).subscribe((result : any) => {
            if (result == 0) {
                alert(PIALRADYEXISTS);
            }
            else {
                alert(PISUCCESSFULLYADDED);
            }
            this.thisDialogRef.close()
        }); 
       
    }


    getErrorMessagePIName() {
        return this.piName.hasError('required') ? FIELDISREQUIRED :
            '';
    }

    getErrorMessageIns() {
        return this.institution.hasError('required') ? FIELDISREQUIRED :
            '';
    }

    getErrorMessagePIEmail() {

        return this.emailPI.hasError('required') ? FIELDISREQUIRED :
            '';

    }

    getErrorMessagePIEmailValid() {

        return this.emailPI.hasError('pattern') ? INVALIDEMAILADDRESS :
            '';
    }



   
    setDisabledVal()
    {

        if (
            this.emailPI.hasError('required') ||
            this.emailPI.hasError('pattern') ||
            this.piName.hasError('required') ||
            this.institution.hasError('required')
            
        )
        {
            return true;
        }

        return false;
    }

        
}
