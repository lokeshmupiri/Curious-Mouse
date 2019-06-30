global class AccountRemoteActionController {

    @RemoteAction
     global static List<Account> getAccount(){
    //global static List<Account> getAccount(String searchName){
        //String name = '%'+searchName+'%';
        //List<Account> accList = [SELECT Id,Name FROM Account WHERE Name LIKE :name];
        List<Account> accList = [SELECT Id,Name FROM Account];
        system.debug('-------'+accList);
        return accList;
    }
}