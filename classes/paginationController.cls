global class paginationController {

    public String accountName { get; set; }
    public static Account account { get; set; }
    public paginationController () { } // empty constructor
    
     @RemoteAction
    global static Account getAccount(String accountName) {
        account = [SELECT Id, Name, Phone, Type, NumberOfEmployees 
                   FROM Account WHERE Name = :accountName];
        return account;
    }
    
}