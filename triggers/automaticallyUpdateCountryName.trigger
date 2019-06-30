trigger automaticallyUpdateCountryName on Vehicles__c (before Insert , Before Update) {
   
   for(vehicles__c v : trigger.new)
   {
       if(v.contact_number__c != null)
       {
           String stdcode = v.contact_number__c.subString(0,2);
           if(stdcode == '91')
           v.location__c = 'India';
           else if(stdcode == '60')
           v.location__c = 'Malasiya';
           else if(stdcode == '97')
           v.location__c = 'Nepal';
           else if(stdcode == '92')
           v.location__c = 'Pakisthan';
           else if(stdcode == '86')
           v.location__c = 'Chaina';
           else if(stdcode == '88')
           v.location__c = 'Bangladesh';
       }
   }
    
}