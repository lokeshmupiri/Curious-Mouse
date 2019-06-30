public class picklist_values_based_on_recordtype {
    public String selectedRT {get;set;}
    public List<SelectOption> recordTypeList {get;set;}
    public Task customer {get;set;}
     
    public picklist_values_based_on_recordtype (){
     
        customer = new task();
        recordTypeList = new List<SelectOption>();
        getRecordTypeList();
     
    }
     
    public void getRecordTypeList(){
          
        List<RecordType> rtList = [SELECT Id,Name FROM RecordType WHERE SObjectType='task'];
        recordTypeList.add(new SelectOption('--None--', '--None--'));
        for(RecordType rt : rtList)
        {
            recordTypeList.add(new SelectOption(rt.Id, rt.Name));
        }
    }
     
     public void getPickListValues(){
      
        if(selectedRT != null){
            customer = new task(RecordTypeId = selectedRT);
        }
    }
}