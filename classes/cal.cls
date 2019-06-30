public class cal {
    public List<String> picklistFields{set;get;}
    
    public cal(){
        picklistFields = new List<String>();
        Map<String,Schema.FieldSet> fieldSetMap = Schema.SObjectType.Account.fieldSets.getMap();
        for(String sf : fieldSetMap.keyset()){
            picklistFields.add(sf);
        }
    }
}