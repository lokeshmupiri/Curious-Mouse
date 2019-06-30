trigger sameNameContacts on Account (before Update) {
    for(Account acc : [SELECT Id,name,Description,(SELECT Id,Lastname FROM Contacts) FROM Account WHERE ID IN : Trigger.newMap.keyset()]){
        system.debug('acccc'+acc);
        Integer i=0;
        for(Contact con : acc.contacts){
            if(acc.Name.contains(con.LastName)){
                i+=1;
            }
        }
         system.debug('acccc'+String.valueOf(i));
        acc.description = String.valueOf(i);    
     }   
}