public class NewCaseListController {
    list<case> newcase{get;set;}
public list<case> getNewCases(){
     newcase= [Select Id,CaseNumber from case where status='New'];
    return newcase;
}
}