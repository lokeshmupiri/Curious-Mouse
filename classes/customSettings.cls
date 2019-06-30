public class customSettings{
    
    
    public customSettings(){
    map<String,Opportunity__c> oppCustSettList =Opportunity__c.getAll();
    system.debug(oppCustSettList );
}
}