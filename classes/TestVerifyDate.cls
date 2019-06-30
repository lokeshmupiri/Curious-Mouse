@isTest public class TestVerifyDate {

     static testMethod void meth(){
      Date done = Date.newInstance(2015,8,6);
      Date dtwo = Date.newInstance(2015,8,7);
      Date res= VerifyDate.CheckDates(done,dtwo);
      System.assertEquals(dtwo,res);
    }
    
    static testMethod void metho(){
        Date done = Date.newInstance(2015,8,7);
        Date dtwo = Date.newInstance(2015,4,6);
        Date res = VerifyDate.CheckDates(done,dtwo);
        Date except = Date.newInstance(2015, 08, 31);
        System.assertEquals(except,res);
    }
}