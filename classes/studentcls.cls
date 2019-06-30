public class studentcls
{
    student__c s;
    
    public studentcls()
    {
            s = new student__c();
    }
    
    public student__c getstu()
    {
        return s; 
    }
    
    public pagereference save1()
    {    
        insert s;
        pagereference p = new pagereference('/'+s.id);
        return p;    
    } 
    
    public pagereference savenew1()  
    {
        insert s;
        pagereference p = new pagereference('https://c.ap2.visual.force.com/apex/ex11stu');
        return p;
    } 
    
    public pagereference cancel1()
    {
        pagereference p = new pagereference('https://ap2.salesforce.com/a08/o');
        return p;
    }
}