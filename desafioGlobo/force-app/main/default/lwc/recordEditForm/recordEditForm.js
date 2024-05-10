import { LightningElement, api } from 'lwc';

export default class RecordEditFormExample extends LightningElement {

    @api recordId;
    @api objectApiName;


    handleAccount(){
        const inputFields = this.template.querySelectorAll('lightning-input-field');
    }
}
