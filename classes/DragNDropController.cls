global class DragNDropController{
    
    @RemoteAction
    global static Account getRecordInfo(Id recordid){
        return [SELECT RecordType.Name , Name FROM Account WHERE Id=: recordid ];
    }
    public String description {set;get;}
     //Utility method to populate Attachment types
    public static List<SelectOption> getDocumentOptions() {
        List<SelectOption> docOptions = new List<SelectOption>();
        docOptions.add(new SelectOption('Account Statement','Account Statement'));
        docOptions.add(new SelectOption('PoC Document','PoC Document'));  
        docOptions.add(new SelectOption('Letter of Release','Letter of Release'));   
        docOptions.add(new SelectOption('Demand Notice','Demand Notice'));   
        docOptions.add(new SelectOption('Proof of Security','Proof of Security'));       
        docOptions.add(new SelectOption('Other','Other'));
        
        return docOptions;
    }
    
    public List<Attachment> attList {set;get;}
    public void refreshAttList(){
        attList = [SELECT Id, Name,Description FROM Attachment WHERE ParentId =: ApexPages.currentPage().getPArameters().get('Id')];
    }
    public DragNDropController() {
    
    refreshAttList();
    }

    public Account insAcc;
    public DragNDropController(ApexPages.StandardController controller) {
        insAcc = (Account)controller.getRecord();
    }

    
    
}