@isTest
public class TestDataFactory {

    public static list<Account> createAccountsWithOpps(Integer numAccts, Integer numOppsPerAcct){
        list<Account> acct = new list<Account>();
        for(Integer i=0;i<numAccts;i++){
            Account ac = new Account(name='Test Account'+i);
            acct.add(ac);
        }
        insert acct;
        
        list<Opportunity> opps= new list<Opportunity>();
        for(Integer j=0;j<numAccts;j++){
			Account accts = acct[j];
            for(integer k=0;k<numOppsPerAcct;k++){
                opps.add(new Opportunity(name=accts.name+' opporutnity'+k,StageName='Prospecting',
                                        CloseDate=System.today().addMonths(1),AccountId = accts.id));
            }
        }
        insert Opps;
        return acct;
    }
}