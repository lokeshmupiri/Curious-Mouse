public class ContactSearch {

    public static list<contact> searchForContacts(string LastName,string PostalCode){
		LastName = LastName;
        string MailingPostalCode = PostalCode;
        List<Contact> con = [SELECT ID, Name 
                FROM Contact WHERE LastName = :LastName 
        AND MailingPostalCode= :MailingPostalCode];
   return con ;
    }
}