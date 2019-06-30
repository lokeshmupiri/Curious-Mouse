public class treenodes {
    public Account acct { get; set; }
    
    public treenodes() {
        String acctId = ApexPages.currentPage().getParameters().get('acctId');
        if(acctId != null){
             acct = [SELECT Id, Name FROM Account WHERE Id =: acctId];
        }
    }
    
    @RemoteAction
     public static List<AccountWrapper> getChildAccounts(Id acctId){
         system.debug('-----acctId'+acctId);
          List<AccountWrapper> aw = new List<AccountWrapper>();
          Map<Id, Id> acctMap = new Map<Id, Id>();
          Map<Id, Account> childAccounts = new Map<Id,Account>([SELECT Id, Name FROM Account WHERE ParentId =: acctId]);
          Map<Id, Account> potentialParents = new Map<Id,Account>([SELECT Id, ParentId FROM Account WHERE ParentId IN : childAccounts.keySet()]);
          system.debug('-----childAccounts '+childAccounts.size() );
          system.debug('-----potentialParents '+potentialParents.size() );
          for(Account acct : potentialParents.values()){
             if(childAccounts.get(acct.ParentId) != null){
                 acctMap.put(acct.ParentId, acct.ParentId);
              }
          }
    
          for(Account acct : childAccounts.values()){
             if(acctMap.get(acct.Id) != null){ 
                AccountWrapper acc = new AccountWrapper(acct, true);
                aw.add(new AccountWrapper(acct, true));
             } else {
                aw.add(new AccountWrapper(acct, false));
             }
          }
          return aw;
     }
     
    public class AccountWrapper{
        public Account acctRecord { get; set; }
        public Boolean isParent { get; set; }
        
        public AccountWrapper(Account acct, Boolean parent){
            this.acctRecord = acct;
            this.isParent = parent;
        }
    }
}