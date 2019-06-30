public class OlderAccountsUtility {

    public static void updateOlderAccounts()
    {
    	Account[] oldAccounts = [SELECT Id, Description From Account Order by CreatedDate Asc limit 5];
    	for(Account acct : oldAccounts)
        {
            acct.Description = 'Heritage Account';
        }
    	update oldAccounts;
    }
}