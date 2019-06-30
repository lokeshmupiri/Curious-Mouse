trigger contactNumberMandatory on Vehicles__c (before Insert,before Update) {
    for(vehicles__c v : Trigger.new){
        if(v.contact_number__c == null)
        v.contact_number__c.addError('always required a contact number');
    }

}