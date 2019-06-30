trigger preventDuplicationName on Account (before insert,before update) {

    integer counter,a;
    if(trigger.isInsert && trigger.isBefore)
    for(account b : trigger.new)
    {
         counter = [select count() from account where name=:b.name];
         if(counter>0)
         b.name.addError('Name is already exist');
    }
     if(trigger.isUpdate && trigger.isBefore)
     for(account c : trigger.new)
     {
         a = [select count() from account where name =: c.name and id !=: c.id];
         if(a>0)
         c.name.addError('name is already used');
     }
}