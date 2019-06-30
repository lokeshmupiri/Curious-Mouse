public class c2 {

    list<Account> acts = [select id,name,Accountnumber,industry from account where industry = 'energy'];
    public list<account> getActs() {
        return acts;
    }

}