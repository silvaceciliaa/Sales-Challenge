trigger SendEmail on Account (after insert, after update) {
    
    for(Account account : Trigger.new){
        if(account.Send_Email__c == true){
            if(Trigger.isAfter || Trigger.isBefore){
                ContaEmailHandler.sendEmailNotification(trigger.new);
            }
        }
    }
}