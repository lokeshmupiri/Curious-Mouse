trigger AccountAddressTrigger on Account (after insert, after update) {
    list<account> accl = new List<Account>();
   for(account acc: [select id,name,description from account where id IN: trigger.new]){
   //for(account acc:  trigger.new){
       if(acc.description == null){
       acc.description = 'test';
       accl.add(acc);
       }
       }
       if(accl.size()>0)
   update accl;
}