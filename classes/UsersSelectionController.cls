public class UsersSelectionController {
    public List<String> selectedUserIds { get; set; }
    public Map<String,Id> curSelectedUserIds;
    public List<String> removedUserIds { get; set; }
    public String whereClause { get; set; }
    private Map<Id, String> availableUsersMap;
    private Map<Id, String> selectedUsersMap;
    List<SelectOption> selectedUsers ;
    
    Integer i;
    private Map<String, Integer> selectedUsersIndexMap;
    private Map<Integer,String> selectedUsersRevIndexMap;

    public UsersSelectionController() {
        initializeCollections();
        getUsers();
    }
    
    private void initializeCollections() {
        selectedUserIds = new List<String>();
        removedUserIds = new List<String>();
        availableUsersMap = new Map<Id, String>();
        selectedUsersMap = new Map<Id, String>();
        selectedUsersIndexMap = new Map<String, Integer>();
        selectedUsersRevIndexMap = new Map<Integer,String>();
        selectedUsers = new List<SelectOption>();
        
    }

    private void getUsers() {
        for (User u : [SELECT id, name FROM user WHERE IsActive = true]) {
            availableUsersMap.put(u.Id, u.Name);
        }
    }
    
    public void add() {
        if (!selectedUserIds.isEmpty()) {
            for (String userId : selectedUserIds) {
                selectedUsersMap.put(userId, availableUsersMap.get(userId));
                availableUsersMap.remove(userId);
            }
        }
    }
    
    public void up() {
        i=0;
        curSelectedUserIds= new Map<String,Id>();
        for(SelectOption s : selectedUsers){
            curSelectedUserIds.put(s.getlabel(),s.getValue());
             selectedUsersIndexMap.put(s.getLabel(),i);
            selectedUsersRevIndexMap.put(i,s.getLabel());
            i+=1;
        }
        system.debug(' curSelectedUserIds '+curSelectedUserIds);
        system.debug(' selectedUsersIndexMap '+selectedUsersIndexMap);
        system.debug(' selectedUsersRevIndexMap '+selectedUsersRevIndexMap);
        Map<Id,String> selectedUsersMapTemp = selectedUsersMap.clone();
        system.debug('selectedUsersMapTemp '+selectedUsersMapTemp);
        selectedUsersMap.clear();
        if (!removedUserIds.isEmpty()) {
            for (String userId : removedUserIds) {
                i = selectedUsersIndexMap.get(selectedUsersMapTemp.get(userId));
                if(i>0){
                    selectedUsersRevIndexMap.put(selectedUsersIndexMap.get(selectedUsersMapTemp.get(userId)),selectedUsersRevIndexMap.get(selectedUsersIndexMap.get(selectedUsersMapTemp.get(userId))-1));
                    selectedUsersRevIndexMap.put(i-1,selectedUsersMapTemp.get(userId));
                } else{
                    break;
                }
            }
        }
       for(integer i=0;i<selectedUsersRevIndexMap.size();i++){
            selectedUsersMap.put(curSelectedUserIds.get(selectedUsersRevIndexMap.get(i)),selectedUsersRevIndexMap.get(i));
        }
    }
    
    public void down() {
        i=0;
        curSelectedUserIds= new Map<String,Id>();
        for(SelectOption s : selectedUsers){
            curSelectedUserIds.put(s.getlabel(),s.getValue());
            selectedUsersIndexMap.put(s.getLabel(),i);
            selectedUsersRevIndexMap.put(i,s.getLabel());
            i+=1;
        }
        Map<Id,String> selectedUsersMapTemp = selectedUsersMap.clone();
        selectedUsersMap.clear();
        if (!removedUserIds.isEmpty()) {
            for (String userId : removedUserIds) {
                i = selectedUsersIndexMap.get(selectedUsersMapTemp.get(userId));
                if(i<selectedUsersMapTemp.size()){
                    selectedUsersRevIndexMap.put(selectedUsersIndexMap.get(selectedUsersMapTemp.get(userId)),selectedUsersRevIndexMap.get(selectedUsersIndexMap.get(selectedUsersMapTemp.get(userId))+1));
                    selectedUsersRevIndexMap.put(i+1,selectedUsersMapTemp.get(userId));
                } else{
                    break;
                }
            }
        }
       for(integer i=0;i<selectedUsersRevIndexMap.size();i++){
            selectedUsersMap.put(curSelectedUserIds.get(selectedUsersRevIndexMap.get(i)),selectedUsersRevIndexMap.get(i));
        }
    }
    
    public void remove() {
        
        if (!removedUserIds.isEmpty()) {
            for (String userId : removedUserIds) {
                availableUsersMap.put(userId, selectedUsersMap.get(userId));
                
                selectedUsersMap.remove(userId);
               
            }
        }
    }
    
    public List<SelectOption> getAvailableUsers() {
        List<SelectOption> availableUsers = new List<SelectOption>();
        for (Id userId : availableUsersMap.keySet()) {
            availableUsers.add(new SelectOption(userId, availableUsersMap.get(userId)));
        }
        return availableUsers;
    }
    
    public List<SelectOption> getSelectedUsers() {
        selectedUsers = new List<SelectOption>();
        for (String userId : selectedUsersMap.keySet()) {
            selectedUsers.add(new SelectOption(userId, selectedUsersMap.get(userId)));
        }
        return selectedUsers;
    }
    
    public void filterAvailableOptions() {
        availableUsersMap = new Map<Id, String>();
        selectedUserIds = new List<String>();
        String likeClause = '%' + whereClause + '%';
        for (User u : [SELECT id, name FROM User WHERE name like :likeClause]) {
            if (!selectedUsersMap.containsKey(u.Id)) {
                availableUsersMap.put(u.Id, u.Name);
            }
        }
    }
}