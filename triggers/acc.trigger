trigger acc on Opportunity(before insert,before update) {
    Map<String,Opportunity__c> mapp = Opportunity__c.getAll();
    system.debug(mapp);
for(opportunity o:Trigger.new){
    
    o.description = mapp.get('test').Default_Price_Type__c;

}
}