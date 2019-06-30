public class channel {

    public PageReference section() {
        return page.accountchaa;
    }


    public PageReference tabs() {
        return page.accountcha;
    }




list<account> directchannel = [select name,accountnumber,type,industry,rating from account];

    public list<account> getrest(){
        return directchannel;
    }

}