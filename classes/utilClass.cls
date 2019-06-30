public class utilClass{
    public static boolean sameNameContacts=true;
    public static integer runOnce=0;
    
    public static boolean sameNameContacts(){
        if(runOnce<1){
            runOnce+=1;
            return sameNameContacts;
        } else {
            sameNameContacts = false;
            return sameNameContacts ;
        }
    }
}