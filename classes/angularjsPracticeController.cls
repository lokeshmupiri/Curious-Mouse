public class angularjsPracticeController {

    
    public static String  getContact(){
        return JSON.Serialize([SELECT Id,
        Firstname,Lastname,Phone FROM contact ]);   
    }
}