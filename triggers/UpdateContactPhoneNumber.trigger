trigger UpdateContactPhoneNumber on Account (after update) 
{
    Set<ID> idSet = new Set<ID>();
    List<Contact> lstContact = new List<Contact>();
           
    for(Account acc : Trigger.New)
    {
        idSet.add(acc.id);
    }
    
    lstContact = [select id, phone,Account.phone from contact where accountid in : idset];
    
    for(Contact con : lstContact)
    {
        con.phone = con.Account.Phone;
    }
    
    update lstContact;
       
}