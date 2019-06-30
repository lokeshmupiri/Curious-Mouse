trigger locationMandatory on Vehicles__c (Before Insert,before Update) {
 
    for(vehicles__c v : Trigger.new)
    {
        if(v.location__c==null)
        v.location__c.addError('You Must Select Location');
    }

}