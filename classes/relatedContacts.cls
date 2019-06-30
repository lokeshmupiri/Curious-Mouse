public class relatedContacts {

    public contact con;
    public relatedContacts(ApexPages.StandardController controller) {
        this.con = (contact)controller.getRecord();
    }
    public list<contact> relCon;
    
    public list<contact> getrelCon(){
        return relCon;
    }
     public PageReference relCon(){
         relCon = [SELECT Id, FirstName, LastName FROm Contact WHERE AccountID =: con.AccountID];
         return null;
     }
}