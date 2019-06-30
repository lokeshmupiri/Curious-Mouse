trigger OppurtunityAmount on Opportunity (before insert,before update) {
for(opportunity a:Trigger.new){
if(Trigger.isInsert&&a.amount<5000)
a.addError('amount cannot be lessthan 5000');
else if(Trigger.isupdate&&a.amount<2000)
a.addError('amount cannot be lessthan 2000');

}

}