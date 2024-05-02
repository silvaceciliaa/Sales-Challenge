@isTest
public class ContaEmailHandlerTest {
    
    @isTest
    static void testSendEmailNotification(){
        
        List<Account> accounts = new List<Account>();
        
        Account account1 = new Account();
        account1.Name = 'Conta 1';
        account1.Country__c = 'a03aj0000025SfFAAU';
        account1.Email__c = 'teste@teste.com';
        accounts.add(account1);
        insert accounts;
        
        Test.startTest();
        ContaEmailHandler.sendEmailNotification(accounts);
        Test.stopTest();
        
        List<EmailMessage> sentEmails = [SELECT Id, Subject FROM EmailMessage];
        
        EmailMessage sentEmail = sentEmails[0];
        System.assertEquals('Welcome Conta 1', sentEmail.Subject);
        
    }
}