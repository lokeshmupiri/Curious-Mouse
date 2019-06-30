trigger contactTrigger on Contact (after insert, before update,before insert) {
    Set<id> accSet = new Set<id>();
    for(Contact ct : Trigger.new)
        {
            accSet.add(ct.Accountid);
        }
    if(Trigger.isAfter && Trigger.isInsert)
    {
        
        Map<id,List<Contact>> acc_Contact_Map = new Map<id,List<Contact>>();
        List<Account> curAcc_Update_List = new List<Account>();
        
        List<Contact> conList = [Select id,Accountid from Contact where Accountid=:accSet];
        
        for(Contact c : conList) 
        {
           List<Contact> conAccList = new List<Contact>();
           if(acc_Contact_Map.containsKey(c.Accountid))
           {     
               conAccList = acc_Contact_Map.get(c.Accountid);
               conAccList.add(c);
               acc_Contact_Map.put(c.Accountid,conAccList);
           }
           else
           {
               conAccList.add(c);
               acc_Contact_Map.put(c.Accountid,conAccList);
           }
        }    
        
        Map<id,Account> accMap = new Map<id,Account>([Select id,Number_of_Contacts__c,BillingAddress from Account where id=: acc_Contact_Map.KeySet()]);
        for(id curAccId : accMap.KeySet())
        {
            List<Contact> curConList = acc_Contact_Map.get(curAccId);
            Account acc  = accMap.get(curAccId);
            acc.Number_of_Contacts__c = curConList.size();
            curAcc_Update_List.add(acc);
        }
        if(curAcc_Update_List != Null && curAcc_Update_List.size()>0)
        update curAcc_Update_List;
     }

     if(Trigger.isBefore)
     {
     if(Trigger.isInsert || Trigger.isUpdate)
     {
         Map<id,Account> con_Acc_Map = new Map<id,Account>([Select id,Billing_City__c,Billing_Street__c from Account where id=:accSet]); 
         for(Contact con : Trigger.new)
         {
             if(con.AccountId != null)
             {
                 Account accRcd = con_Acc_Map.get(con.AccountId);
                 if(con.Copy_Address_of_Account__c == True)
                 {
                    con.Billing_Street__c = accRcd.Billing_Street__c ;
                    con.Billing_City__c = accRcd.Billing_City__c;
                 }
             }
         }
     }
     }
}