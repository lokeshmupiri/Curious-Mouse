global class AccountRemoter {

    @RemoteAction
    global static Account getAccount(String s){
        account acc = [SELECT Id, Name, Phone, Type, NumberOfEmployees 
                   FROM Account where name =: s];
        return acc;
    }
}