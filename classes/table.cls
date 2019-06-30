public class table {
    public string sname{set;get;}
    public list<account> li{set;get;}
    public integer count{set;get;}
    public table(){
 
    }
    
    public String disp(){
        li=[select name from account where name=:sname];
        count = li.size();
        if(count<1){
            ApexPages.Message myMsg = new  ApexPages.Message(ApexPages.Severity.ERROR,'Error : No Records Found with ' + sname);
            ApexPages.addMessage(myMsg);
            return null;
        }
        return null;
    }

}