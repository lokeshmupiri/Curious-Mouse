public class calculator {

public integer firstNumber{get;set;}
public integer secondNumber{get;set;}
public double result{get;set;}

public pagereference Addition(){

result=firstNumber+secondNumber;
//system.debug('ressss'+result);
return null;
}

public pagereference substraction(){

result=firstNumber-secondNumber;
//system.debug('ressss'+result);
return null;
}

public pagereference multiplication(){

result=firstNumber*secondNumber;
//system.debug('ressss'+result);
return null;
}

public pagereference division(){

if(secondnumber==0){
    ApexPages.Addmessage(new Apexpages.Message(ApexPages.Severity.Error,'Division Operation Cannot be performed whwn 2nd number Zero.'));

        }
        else
        {
            result = firstNumber / secondNumber;
                        
        }
                    return null;
}
}