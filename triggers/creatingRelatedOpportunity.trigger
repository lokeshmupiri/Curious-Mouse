trigger creatingRelatedOpportunity on Account (after insert,after Update) {

    list<opportunity> oppList = new list<Opportunity>();
    
    Map<Id,Account> accWithOpps = new Map<Id,Account>
        ([select Id,(select Id From opportunities) from Account where id In : Trigger.new]);
    for(Account a:Trigger.new){
        System.debug('accwith opps'+accWithOpps.get(a.Id).opportunities.size());
        if(accWithOpps.get(a.Id).opportunities.size()==0){
            oppList.add(new opportunity
                        (name=a.name+'opportuity', StageName='prospecting',
                         CloseDate=System.today().addMonths(1),AccountId = a.Id));
        }
            
    }
    if(oppList.size()>0)
        insert oppList;
}