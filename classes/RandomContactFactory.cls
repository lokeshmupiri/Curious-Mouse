public class RandomContactFactory {

    public static list<contact> generateRandomContacts(Integer num,String str){
        
        list<contact> con = new list<contact>();
        for(Integer i=0;i<num;i++){
            contact c = new contact(firstname='test'+i,lastname=str);
            con.add(c);
        }
        
        return con;
    }
}