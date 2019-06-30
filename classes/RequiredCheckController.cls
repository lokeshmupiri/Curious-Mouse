public class RequiredCheckController { 
public RequiredCheckController(ApexPages.StandardController controller) {} 
public void doAction(){ 
System.debug('zzz doAction is fired'); 
ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'DONE')); 
} 
}