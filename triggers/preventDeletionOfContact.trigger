trigger preventDeletionOfContact on Account (before delete) {

    set<id> setid = new set<id>();
    for(account c : Trigger.old)
    {
       setid.add(c.id);
    }
    list<contact> lstcontacts = [select id from contact where account.id=:setid];
    if(lstContacts.size() > 0 && lstContacts != null)
    {
        for(Contact con : lstContacts)
        {
            con.Accountid = null;        
        }
        
        upsert lstContacts;
    }
}