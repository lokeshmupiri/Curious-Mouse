public class HelloWorld {
   @AuraEnabled
    public static User getUser() {
        User myUser = [SELECT Id, Name  FROM User WHERE Id =: UserInfo.getUserId() LIMIT 1];
        system.debug('dfdfdfdf');
        return myUser;  
    }
}