public class CAGESearchClass2_Tia {
     public String searchstring { get; set; }
     
     
    @RemoteAction
    public static Account caseSearch(string searchString)
    {   
        //List<Account> accList = [SELECT Id,Name FROM Account WHERE Name LIKE '%'+searchString+'%'];
        return null;
    }
}