public class StringArrayTest {
    public static list<string> generateStringArray(integer n)
    {
     list<string> test=new list<string>();
        for(integer i=0;i<n;i++)
        {
            test.add('Test '+i);
            system.debug(test[i]);
        }
        return test;
        
    }

}