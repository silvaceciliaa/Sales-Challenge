public class ContaEmailHandler {
    
    public static void sendEmailNotification(List<Account> lstAccount){

        List<Messaging.Email> lstEmail = new List<Messaging.Email>();

        for(Account account : lstAccount){
            if(account.Email__c != null){
                Messaging.SingleEmailMessage emailMsg = new Messaging.SingleEmailMessage();
                String [] toAddress = new String[]{account.Email__c};
                emailMsg.setToAddresses(toAddress);
                String emailSub = 'Welcome ' + account.Name ;
                emailMsg.setSubject(emailSub);
                String content = 'Hi ' + account.Name + ',<br/><br/>' +
                                  'Welcome to salesforce!' ;
                emailMsg.SetHtmlBody(content);    
                
                lstEmail.add(emailMsg);
            }
        }
        Messaging.sendEmail(lstEmail);
    }
    
}