public class autoCompleteLightning {

    @AuraEnabled
    public static List<Account> searchAcc(String searchText){
        String findText = searchText+'%';
        return [SELECT Name FROM Account WHERE Name Like:findText];
     
    }
}