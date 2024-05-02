public class LatestRecords {
    @AuraEnabled
    public static List<Lead> getLeads() {
        List<Lead> leads = [SELECT Id, Name, Company, Email, Phone, Status, CreatedDate FROM Lead ORDER BY CreatedDate DESC LIMIT 12];
        return leads;
    }
}