trigger ForceforeCasting on Account (before insert) {

    for(Account accountInLoop : Trigger.new){
    
    accountInLoop.Name = 'teja';
    
    }
}