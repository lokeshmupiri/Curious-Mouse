public with sharing class accUpdate {
    public Contact con{get;set;}
    public accUpdate(ApexPages.StandardController controller) {
        con = (Contact)Controller.getRecord();
    }
    
    public pageReference geteditAccount(){
        if(con.Accountid == null ){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR ,'Enter Account Name'));
            return null;
        }
        else{
        PageReference page = new pagereference('https://ap2.salesforce.com/'+con.accountid+'/e?retURL=%2F'+con.accountid);
        return page;
        }
        
    }

}