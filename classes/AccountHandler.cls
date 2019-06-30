public class AccountHandler {
    public static account insertNewAccount(String acc)
    {
     	account a=new account(name=acc);   
            if(acc!='')
        {
            try
            {
                
                insert a;
                System.debug('');
            }catch(Exception ex){
            	system.debug('eeeee'+ex);
                return null;
            }
        }
        else
            	return null;
        return a;
    }

}