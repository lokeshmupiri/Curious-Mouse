trigger preventDuplicateVehiclesName on Vehicles__c (before Insert,before Update) {
   
   if(trigger.isinsert)
    for(vehicles__c v : Trigger.new)
    {
        integer counter = [select count() from vehicles__c where name=: v.name];
        if(counter>0)
        v.addError('Vehicle name is already existed');
                 
    }
    
    if(trigger.isUpdate)
    for(vehicles__c s : Trigger.new)
    {
        integer counte = [select count()from vehicles__c where name=: s.name and id!=:s.id];
        if(counte>0)
        s.addError('Vehicle name is already existed');
                 
    }
}