public class c1
{

    public String getGetdirr() {
        return null;
    }


   

    list<Account> directchannel = [select name,accountnumber,type,rating,industry from account];
    
    public list<Account> getdirr()
    {
        return directchannel;
    }
}