public with sharing class AccountHierarchyController {

    private String selectedAccountId;  
    private static final String ACCOUNT_FIELDS = 'Id, Name, Owner.Name, Industry, AnnualRevenue, Type, Rating, NumberOfEmployees';  
    public String jsonString {  
      get{  
           List<TreeNodes> nodes = new List<TreeNodes>();  
           String queryString = 'SELECT ' + ACCOUNT_FIELDS + ' FROM Account';  
           if(this.selectedAccountId != null){  
                queryString += ' WHERE ParentId = :selectedAccountId';  
           } else {  
                queryString += ' WHERE ParentId = null';  
           }  
           queryString += ' ORDER BY Name ASC';  
           List<Account> accounts = Database.query(queryString);  
           nodes = this.buildNodes(accounts);  
           if(!nodes.isEmpty()){  
                return JSON.serialize(nodes);  
           } else {  
                return JSON.serialize('');  
           }  
      }  
      private set;   
    }  
    
     public void retrieveNodes(){  
        this.selectedAccountId = Apexpages.currentPage().getParameters().get('nodeId');  
        String nodes = this.jsonString;  
    }  
    
    private List<TreeNodes> buildNodes(List<Account> accounts){  
        List<TreeNodes> nodes = new List<TreeNodes>();  
            if(accounts != null && !(accounts.isEmpty())){  
           for(Account acct : accounts){  
                nodes.add(new TreeNodes(acct));  
           }  
        }  
        return nodes;  
    }  
    
    
    public class TreeNodes{  
      public String name { get; set; }  
      public String industry { get; set; }  
      public String owner { get; set; }  
      public String rating { get; set; }  
      public Decimal revenue { get; set; }  
      public String acctType { get; set; }  
      public Integer numberOfEmployees { get; set; }  
      public Id recordId { get; set; }  
      public TreeNodes(Account acct){  
           this.name = acct.Name;  
           this.industry = acct.Industry;  
           this.owner = acct.Owner.Name;  
           this.rating = acct.Rating;  
           this.revenue = acct.AnnualRevenue;  
           this.acctType = acct.Type;  
           this.numberOfEmployees = acct.NumberOfEmployees;  
           this.recordId = acct.Id;  
      }  
     }  
}