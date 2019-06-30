/*Author - Shilpa Sirikonda
  Date - Feb 01, 2016
  Description - This class will be used to handle the opportunitycontactrole deletes to clean-up campaign influences related to this OCR.
*/
global without sharing class OppContactRolesUtil{   
    
    public static Opportunity oppRecord{get; set;}
    public Id accId{
         get;
         set {
            accId = value;
            System.debug('value: '+value);
        }
    }
    
     public Id oppId{
         get;
         set {
            oppId = value;
            System.debug('value: '+value);
        }
    }
    public List<OpportunityContactRole> ocrs {set;get;}
    
    global  OppContactRolesUtil(ApexPages.standardcontroller controller){ 
        oppRecord = (Opportunity)controller.getRecord();
        ocrs = new List<OpportunityContactRole> () ;
    }
    
   
  
  //ssirikonda - Aug 08, 2017 - delete dupliacte OCRs taht are not bluesheet roles
    public PageReference deleteDuplicateOCR() {
        //ssirikonda - Aug 08,2017 - rmeove duplicate contactroles if bluesheet role is added. Keep bluesheet role and delete existing
        String BS_roles = 'test';
        String opportunityid= oppRecord.id;
        List<id> dupContacts = new List<id>();
        Map<id, String> dupContactWithRolesMap = new Map<id, String>();
        for(AggregateResult ar:[SELECT contactid, count(Id) FROM OpportunityContactRole where opportunityid=:opportunityid GROUP BY contactid HAVING count(Id)>1]){
            dupContacts.add((Id)ar.get('contactid'));   
        }
        
        for(OpportunityContactRole oc : [select id, contactid, role, opportunityid from OpportunityContactRole where opportunityid=:opportunityid and contactid in :dupcontacts]){
            if(dupContactWithRolesMap.get(oc.contactid)==null){
                dupContactWithRolesMap.put(oc.contactid, oc.role+'%');
            }else{
                dupContactWithRolesMap.put(oc.contactid, dupContactWithRolesMap.get(oc.contactid) +oc.role+'%');
            }
        }
        
        List<id> Contacts_withBSRoles = new List<id>();
        for(Id i : dupContactWithRolesMap.keySet() ){
            String l= dupContactWithRolesMap.get(i);
            System.debug('l sstring'+ l);
            List<String> m = l.split('%');
            System.debug('m list'+ m);
            for(String n: m){               
                //if a specific contact has bluesheet role then duplicates must be deleted for that specific contact on the opportunity only                
                if(BS_roles.contains(n)){
                    Contacts_withBSRoles.add(i);                    
                }
            }
        }
        
        //Now find the duplicates for contacts that have existing bluesheet roles and needs to be deleted.
        List<OpportunityContactRole> dupOCRtoDelete = new List<OpportunityContactRole>();
        for(OpportunityContactRole oc1 : [select id, contactid, role, opportunityid from OpportunityContactRole where opportunityid=:opportunityid and contactid in :Contacts_withBSRoles]){
            if(!BS_roles.contains(oc1.role)){
                dupOCRtoDelete.add(new OpportunityContactRole(id= oc1.id));
            }           
        }
        
        if(dupOCRtoDelete.size()>0){
            System.debug('dupOCRtoDelete=='+dupOCRtoDelete);
            delete dupOCRtoDelete;          
        } 
        
        // Now set ocrs variable so that deleted OCRs are not displayed
        ocrs = [select Id,Contact.Name,Contact.Account.Name,Contact.Email,Contact.Phone,Role,IsPrimary from OpportunityContactRole where OpportunityId = :oppRecord.Id];
        
        return null;  
        
    }      
    
  
}