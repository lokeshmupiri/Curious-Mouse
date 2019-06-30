public class apexParam {

    public Id curId{set;get;}
    
     public List<Account> AllLeads{
        get{ return [SELECT Id, Name FROM Account]; }
    }
    
    public void deleteAcc(){
        DELETE new Account(Id=curId);
    }
}