global class remoteActionPractice {
public String accountName { get; set; }
    public static List<Account> accounts { get; set; }

    public remoteActionPractice(){}

    @RemoteAction
    global static List<Account> getAccount(String accountName){
        System.debug('Account Size : ');
        String updatedAccName = '%'+accountName+'%';
        accounts = [select id, name, phone, type, numberofemployees from Account where name LIKE :updatedAccName];
        System.debug('Account Size : '+accounts.size());
        return accounts;
    }
}