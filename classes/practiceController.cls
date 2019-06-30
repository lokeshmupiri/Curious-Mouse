public class practiceController {
    public Map<Id,String> availableUserMap{set;get;}
    public List<String> selectedUserId {set;get;}
    
    public practiceController(){
        availableUserMap = new Map<Id,String>();
        selectedUserId = new List<String>();
        for(User u : [SELECT Id,Name FROM User]){
            availableUserMap.put(u.id,u.name);
        }
    }
    
    public List<SelectOption> getavailableUsers(){
        List<SelectOption> availableUsers = new List<SelectOption>();
        for(Id curId : availableUserMap.keySet()){
            availableUsers.add(new SelectOption(curId,availableUserMap.get(curId)));
        }
        return availableUsers;
    }
}