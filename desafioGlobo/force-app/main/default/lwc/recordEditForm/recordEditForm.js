import { LightningElement, api } from 'lwc';

import EMAIL_FIELD from '@salesforce/schema/Account.Email__c';

export default class RecordEditFormExample extends LightningElement {

    // Flexipage provides recordId and objectApiName
    @api recordId;
    @api objectApiName;

    // Expose a field to make it available in the template
    email = EMAIL_FIELD;

    handleAccount(){
        //seleciona todos os elementos que correspondem a um seletor
        const inputFields = this.template.querySelectorAll('lightning-input-field');
    }
}