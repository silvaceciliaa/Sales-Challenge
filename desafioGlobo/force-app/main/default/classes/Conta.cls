@RestResource(urlMapping='/api/conta/*') 
global with sharing class Conta {

    @HttpPost
    global static String doPost(String name, String countryId, String email) {
        Account account = new Account();
        account.Name = name;
        account.Country__c = countryId;
        account.Email__c = email;
        upsert account;
        return account.Id;
    }
}