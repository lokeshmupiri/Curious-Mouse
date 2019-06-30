public class ContactAndLeadSearch {

    public static list<list<sObject>> searchContactsAndLeads(string leadd)
    {
        string a=leadd;
        list<list<sobject>> searchList=[FIND 'smith' IN ALL FIELDS

	                   RETURNING lead(lastName),Contact(FirstName,LastName)];
       
        lead[] lea=(lead[])searchlist[0];
         contact[] con=(contact[])searchlist[1];
        for(contact c:con)
        {
            System.debug('found one contact'+c);
        }
        for(lead l:lea)
        {
            System.debug('found one contact'+l);
        }
        return searchlist;
    }
    
}