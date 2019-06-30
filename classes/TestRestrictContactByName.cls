@isTest private class TestRestrictContactByName{
    Static testMethod void testing(){
        list<contact> con = new list<contact>();
    contact c1 = new contact(lastname='lokesh');
    contact c2 = new contact(lastname='InvalidName');
    con.add(c1);
    con.add(c2);
    Test.startTest();
    try{
        insert con;
    }
    catch(Exception e){
        
    }
    Test.stopTest();
    }  
}