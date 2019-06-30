public with sharing class calculateParkingFee {
    private Contact c;
    public String contactJson {get;set;}
    public calculateParkingFee(ApexPages.StandardController controller) {
        c = (Contact) controller.getRecord();
        contactJson = JSON.serializePretty(c);
    }
    
    public void save()
    {
        c = (Contact)JSON.deserialize(contactJson, Contact.class);
        upsert c;
    }
}