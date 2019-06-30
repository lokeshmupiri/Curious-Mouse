public class angularJsPractice2Controller {
    public String getContacts(){  
        return JSON.serialize([SELECT ID,Name,Phone,firstname,lastname FROM Contact]);
    }
}