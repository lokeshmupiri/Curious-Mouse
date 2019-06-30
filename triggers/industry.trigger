trigger industry on Account (before insert, before update) {
for(account a:Trigger.new)
{
a.industry='finance';
//a.addError('industry cannot be education');

}
}