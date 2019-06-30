global class SampleRemoteActionPageController {
    @RemoteAction
    global static List<contact> myContacts() {
        return [select id, name, email from Contact Order By LastModifiedDate DESC LIMIT 5000];
    }
}