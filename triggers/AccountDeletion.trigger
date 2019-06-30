trigger AccountDeletion on Account (before delete) {

    For(Account a : [select id from account where id in (select Accountid from opportunity) and id in:Trigger.old])
    Trigger.oldMap.get(a.id).addError('Cannot delete account with related opportunities');
}