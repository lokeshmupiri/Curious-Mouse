public class Emailing {

    public void sendMail(String address, String subject, String body){
        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddress = new String[]{address};
        mail.setToAddresses(toAddress);
        mail.setSubject(subject);
        mail.setPlainTextBody(body);
        Messaging.sendEmailResult[] results = Messaging.SendEmail(new Messaging.SingleEmailMessage[]{mail});
        inspectResults(results);
    }
    
    private static boolean inspectResults(Messaging.SendEmailResult[] results){
        
        boolean sendResult = true;
        for(Messaging.SendEmailResult res:results){
            if(res.isSuccess())
            System.debug('Email sent Sucessfully');
            else{
                sendResult = false;
                System.debug('The following error occurs :'+res.getErrors());
            }
          }
        return sendResult;
    }
}