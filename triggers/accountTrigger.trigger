trigger accountTrigger on Account (before insert) {
for(Account acc:Trigger.new)
{
 acc.Site = acc.Name;
}

}