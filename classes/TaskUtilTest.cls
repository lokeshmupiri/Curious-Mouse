@isTest
public class TaskUtilTest {

     @isTest static void testTaskPriority() {
        String pri = TaskUtil.getTaskPriority('NY');
         String pri1 = TaskUtil.getTaskPriority('Montana');
         String pri2 = TaskUtil.getTaskPriority('CA');
        System.assertEquals('Normal', pri);
         System.assertEquals('Normal', pri1);
         System.assertEquals('Normal', pri2);
     }
    
}