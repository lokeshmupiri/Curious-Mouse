trigger ClosedOpportunityTrigger on Opportunity (before insert, before update) {

    list<task> listToUpdate = new list<task>();
    for(Opportunity opp : Trigger.New){
        if(opp.StageName=='Closed Won')
        listToUpdate.add(new Task(Subject='Follow Up Test Task',WhatId=opp.id));
    }
    if(listToUpdate.size()>0)
        insert listToUpdate;
}