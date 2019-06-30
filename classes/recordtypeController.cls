public class recordtypeController {
    public static Map<Id, String> recordtypemap {get;set;}
    
   @AuraEnabled        
    public static List<String> fetchRecordTypeValues(){
        List<Schema.RecordTypeInfo> recordtypes = Account.SObjectType.getDescribe().getRecordTypeInfos();    
        recordtypemap = new Map<Id, String>();
        for(RecordTypeInfo rt : recordtypes){
            if(rt.getName() != 'Master')
            recordtypemap.put(rt.getRecordTypeId(), rt.getName());
        }        
        return recordtypemap.values();
    }
    
    @AuraEnabled
    public static Id getRecTypeId(String recordTypeLabel){
        Id recid = Schema.SObjectType.Account.getRecordTypeInfosByName().get(recordTypeLabel).getRecordTypeId();        
        return recid;
    }      
    
    public Map<String,Id> mapofOppRecordTypeNameandId {set;get;}
    public recordtypeController(){
        mapofOppRecordTypeNameandId = new Map<String,Id>();
        List<RecordTypeInfo> infos = Account.sObjectType.getDescribe().getRecordTypeInfos();
        if (infos.size() > 1) {
            for (RecordTypeInfo i : infos) {
                if (i.isAvailable() && !String.valueOf(i.getRecordTypeId()).endsWith('AAA'))
                    mapofOppRecordTypeNameandId.put(i.getName(),i.getRecordTypeId());
            }
        } else {
            mapofOppRecordTypeNameandId.put(infos[0].getName(),infos[0].getRecordTypeId());
        }
    }
}