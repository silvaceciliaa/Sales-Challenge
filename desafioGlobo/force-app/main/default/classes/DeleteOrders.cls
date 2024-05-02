global class DeleteOrders implements Schedulable, Database.Batchable<sObject> {

    global Database.QueryLocator start(Database.BatchableContext BC){
        String query = 'SELECT Id FROM OrderNewVersion__c WHERE LastModifiedDate < :lastThreeMonths';
        Date lastThreeMonths = Date.today().addMonths(-3);
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<sObject> records){
        List<OrderNewVersion__c> orders = (List<OrderNewVersion__c>) records;
        Database.delete(orders);
    }
    
    global void finish(Database.BatchableContext BC){
        // Implement any post-processing logic here
    }
    
    global void execute(SchedulableContext SC){
        DeleteOrders batch = new DeleteOrders();
        Database.executeBatch(batch, 200);
    }
}