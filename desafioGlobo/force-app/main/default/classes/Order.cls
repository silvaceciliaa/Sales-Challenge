@RestResource(urlMapping='/api/order/*') 
global with sharing class Order {

    @HttpPost
    global static String doPost(String clientId, Double totalPrice) {
        OrderNewVersion__c order = new OrderNewVersion__c();
        order.Client__c = clientId;
        order.Order_Date__c = date.Today();
        order.Order_Total__c = totalPrice;
        insert order;
        return order.Id;
    }
}