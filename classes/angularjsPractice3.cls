public with sharing class angularjsPractice3 {
    
    public String getContact(){
    	List<Contact> conList = [SELECT Id,Name,Phone,Account.Name,CreatedDate FROM Contact];
    	String s = JSON.serializePretty(conList);
    	return s;
    }
}