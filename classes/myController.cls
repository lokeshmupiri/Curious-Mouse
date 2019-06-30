public with sharing class myController {

    public final id accountId;
    transient public final string accountName{get;set;}
    //public account acc{get;set;}

    public myController(){
        account acct = [select name from account where id =: ApexPages.currentpage().getParameters().get('id')];
        accountId = acct.id;
        accountName = acct.name;
        
    }
    
    public PageReference save() {
        account accs = [select Name from account where id =: accountID];
        accs.name = Accountname;
        update accs;
        pageReference page = new PageReference('http://ap2.salesforce.com/'+accountId);
        return page;
    }

}