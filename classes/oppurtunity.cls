public class oppurtunity {
    
        list<opportunity> oops = [select name,amount,stagename,closedate,ExpectedRevenue from opportunity];
        
    public list<opportunity> getoops() {
        return oops;
    }

}