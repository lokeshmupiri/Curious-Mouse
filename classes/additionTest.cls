@isTest
public class additionTest {
    @isTest static void testAdd(){
        integer val = addition.add(9,19);
        system.assertEquals(28,val,'test mathod fails');
    }
}