public with sharing class AutoCompleteControllerr {
    
    //Cage 3.5 shiyam added the below block
    @RemoteAction
    
    public static SObject[] findTitles(string searchTerm) {
      List<sObject> result = new List<sObject>();
      try {
        String filter = ' like \'%' + String.escapeSingleQuotes(searchTerm) + '%\'';
        //begin building the dynamic soql query
        String soql = 'select id, Title from account where name '+ filter +' order by title limit 3';
       
          System.Debug('soql' + soql);
        result = Database.query(soql);  
          
      } catch (Exception e) {
            return null;
        }
        return result;
    }
    
    
}