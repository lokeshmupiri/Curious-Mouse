/*****************************************************************************************************************************
* Appirio, Inc
* Name: caseTriggerHandler
* Description: [Create Handler to replace Process Builder (Case Proess)]
* Created Date: [3/6/2017]
* Created By: [Kate Jovanovic] (Appirio)
*
* Date Modified           Modified By              Description of the update
* [23-Mar2017]            [Aashish Sajwan]        [Optimization of code]
* [12-April-2017]         [Neeraj Kumawat]        [T-590411 Update to create case comments]
* [18-April-2017]         [Gaurav Dudani ]        [T-592212 updated to create complaint]
* [25-April-2017]         [Gaurav Dudani ]        [T-594827 updated to create case using Email2case functionality]
* [1 May 2017]            [Kate Jovanovic]        [updating OnAfterInsert to make Email-to-case work]
* [4 May 2017]            [Neeraj Kumawat]        [Added method insertUserLanguage to add user language to case T-599785]
* [11 May 2017]           [Neeraj Kumawat]        [Added method createWorkOrder to create workorder on case and checkWorkOrderExist
And Update the caseToCreateTask method for new Profile. T-601144]
* [17/05/2017]            [Aashish Sajwan]        [Added required field for Complaint object record]
* [18/05/2017]            [Gaurav Dudani]         [Added method to prevent Prevent Case Closer with new unread email as
per task # T-603030]
* [12/05/2017]            [Poornima Bhardwaj]     [Added code to createWorkOrder method as per task # T-592161]
* [22 May 2017]           [Neeraj Kumawat]        [Added account and Contact Id to WorkOrder Creation from Case. T-601144]
* [23 May 2017]           [Neeraj Kumawat]        [Updated Assigning Work order based on Processing center id. T-601144]
* [24 May 2017]           [Poornima Bhardwaj]     [Updated create work order as per Task T-604033]
* [31 May 2017]           [Neeraj Kumawat]        [Added preventCaseClosureForOpenWorkOrders for prevent case closure
when there are open work order on case.T-606953]
* [31 May 2017]           [Bobby Cheek]           [Enforcing CRUD and FLS Security in the Apex Class - T-600197]
* [01/06/2017]            [Gaurav Dudani]         [Added to create a task on Complaint creation (On Complaint) When new case is created with Complaint Applicability is "Yes" as per S-470695.]
* [05/06/2017]            [Gaurav Dudani]         [Added comments to the code]
* [12 June 2017]          [Neeraj Kumawat]        [Added Method preventUnselectingWorkItemMultiPickList #T-608973]
* [13 June 2017]          [Gaurav Dudani]         [Added Required fields on createCaseComplaint method as per issue # I-278864.]
* [14 June 2017]          [Gaurav Dudani]         [Optimied code to update complaint creation filter criteria]
* [14 June 2017]          [Neeraj Kumawat]        [Updated insertUserLanguage method for getting user language instead of user Locale T-609575]
* [15 June 2017]          [Gaurav Dudani]         [Added nullifyCaseContact method for inserting contact on case as null as per I-242653/T-609666.]
* [15 June 2017]          [Bobby Cheek]           [Enforcing CRUD and FLS Security in the Apex Class]
* [15 June 2017]          [Neeraj Kumawat]        [Added Method updateUserLanguage to updated case userLanguage field when case owner changed T-609952]
* [15 June 2017]          [Neeraj Kumawat]        [T-610217 Added Custom Label on showing error message on preventCaseClosureForUnreadEmails]
* [20 June 2017]          [Kate Jovanovic]        [I-280192 removing soql query for profile in method createWorkOrder ]
* [22 June 2017]          [Neeraj Kumawat]        [T-608730/I-278559 Updated createWorkOrder to get the value of queue id from common method od utilitycls class.]
* [23 June 2017]          [Neeraj Kumawat]        [T-610968 Getting record type Id from UtilityCls.getRecordTypeId and fetching record type name from Custom Label.]
* [26 June 2017]          [Kate Jovanovic]        [Deactivating all Complaint methods/references]
* [03 July 2017]          [Gaurav Dudani]         [Added Method to Auto create a Complaint Work Order if Requires Complaint to be Documented is Yes as per S-490684/T-611112]
* [04-July-2017]          [Poornima Bhardwaj]     [Added restrictCaseStatusToBeNewInformationManually method as per task #T-614291]
* [06-July-2017]          [Gaurav Dudani]         [T-611808 Added recordType check for Complaint Work Order on Query to allow user to manually clase the case with open Complaint Type Work Orders.]
* [07-July-2017]          [Neeraj Kumawat]        [T-611575 Created Method updateComplaintWorkOrder and  checkCaseComplaintFieldChange to update work order comaplaint record.]
* [17 July 2017]          [Kate Jovanovic]        [removing COmplaint work]
* [21-July-2017]          [Neeraj Kumawat]        [T-618796 Added PM and RM profile on creation of new task on case creation.]
* [3-Aug-2017]            [Neeraj Kumawat]        [Added check for Not creating work order on closed cases in createWorkOrder method]
* [09-Aug-2017]           [Gaurav Dudani]         [I-242653 Updated the method name and added accountId check for inserting contact and account on case as null.]
* [21-Nov-2017]           [Srinivas Reddy]        [I-302756,I-301251 Changed the DML statement from inside the for loop line no 539 and placed in line 544]
* [18-Jan-2018]           [Subha A]               [S-528229 - NA and MX Process adjustment on Closed Merchant Account - Include new method createWorkOrderforClosedAccount
*                                                 When creating the Work Order through case we are updating the following fields Settlement Type, Account Number and Routing Number on the Work Order from the Bank Information record on the account for
*                                                 deposit account settlement type ]
* [24-Jan-2018]           [Subha A]               [S-528229 - Updated the changes in the createWorkOrder method to display the bank info on the work order for only when the Account Status is not Open,Reopened and New
* [27-Jun-2018]           [Srinivas Reddy]        [B-99979 - First Contact Resolution Calculation created by Srinivas Reddy]
* [17-July-2018]          [Srinivas Reddy]        [I-11422- Case Type needs to be Replaced with CSR Case Type]
* [13-Aug-2018]           [Srinivas Reddy]        [D-23326 I-12258/B-68909 - MX users are not able to close cases in Prod and checking CSR Case Type null values]
* [13-Aug-2018]           [Suresh Kumar]          [D-23835 Fuse adjustment updates failing due to SC Validation rule]
* [09-Oct-2018]           [Srinivas Reddy]        [B-124215 CSR Case Type Field Mapping]
* [17-Oct-2018]           [Pallavi Anipindi]      [B-122457 Refactor Lockbox Post MID Update]
* [27-Nov-2018]           [Srinivas Reddy]        [B-145888 - Refactor Process Builder - Case Copy MID  logic added.]
* [27-Nov-2018]           [Suresh Kumar]          [B-145889 - Refactor Process Builder - Update Case Last Modified By department.]
* [10-Dec-2018]           [Subha A ]              [B-124547 - Customer Follow Up Inquiry Child Case
* [12-Dec-2018]           [Srinivas Reddy]        [B-121805 - SFDC - Account Closure - Identify Attributes on Successful Closure  Case]
* [13-Dec-2018]           [Subha A ]              [B-121805 - SFDC - Account Closure - Identify Attributes on Successful Closure Case - Created method updateAccountStatus to update Account Status and Status Reason when Case is Closed]
* [23-Jan-2019]           [Deborah Orth]          [B-143522 - Visibility of receiving mailbox & B-143523 - Language indicator on Case records]
* [07-feb-2019]           [Suresh Kumar]          [B-167330 - SFDC - Account Closure - Identify Attributes on Successful Closure  Case - Missed EGC Auth Fees]
* [12-feb-2019]           [Subha A]               [B-169927 (SFDC) Final Account Status- Renaming Options]
* [03-Mar-2019]           [Zain B]                [B-161504 - Updated the method SaveReceivedEmailAddressAndSetLanguage() ]
******************************************************************************************************************************/

public class caseTriggerHandler {
    public static Map<string, string> recTypeMap = new Map<string, string>();
    /* Keeps Case Currency Matching Account Currency */

    public static void onBeforeInsert (List<Case> newCases) {
        //[B-145889 - Refactor Process Builder - Update Case Last Modified By department.]
        Lastmodifiedbydepartment(newCases);
        updateCaseCurrency(newCases);
        restrictCaseStatusToBeNewInformationManually(null,newCases);
        //Method to insert user language to case field
        //Date 4 May 2017 Neeraj Kumawat
        insertUserLanguage(newCases);
        // Calling Method to insert case Contact and account as Null.
        // Added By Gaurav Dudani on 15 June 2017 as per I-242653/T-609666.
        // Updated method name By Gaurav Dudani on 09 August 2017 as per I-242653.
        nullifyCaseContactAndAccount(newCases);
        /*B-99979 - First Contact Resolution Calculation created by Srinivas Reddy*/
        beforeinsertFRCValidation(newCases);
        /* B-124215 CSR Case Type Field Mapping */
        String profileName = [select id,name from profile where id=:userinfo.getProfileId()].name;
        if(Constants.CSRCaseTypeMappingProfiles.contains(profileName)){
            CSRcaseTypeMapping(newCases,null);
        }
        prepopulateSubjectonChildCase(newCases, true);
        //* [12-Dec-2018]           [Srinivas Reddy]        [B-121805 - SFDC - Account Closure - Identify Attributes on Successful Closure  Case]
        SuccessfulClosureCase(newCases,null);
        //caseOwnership(newCases,new map<Id,case>());

        //* [23-Jan-2019]             [Deborah Orth]          [B-143522 - Visibility of receiving mailbox & B-143523 - Language indicator on Case records]
        SaveReceivedEmailAddressAndSetLanguage(newCases);
    }

    /* Updates Prior Owner and Owner on Cases by Manual Case Change, Queue Case Change or Returning to Previous User */
    public static void onBeforeUpdate (Map<Id,Case> oldMap, List<Case> newCases){
        //[B-145889 - Refactor Process Builder - Update Case Last Modified By department.]
        Lastmodifiedbydepartment(newCases);

        restrictCaseStatusToBeNewInformationManually(oldMap,newCases);
        updateCaseOwner(newCases);
        UpdateCasePriorOwner(oldMap,newCases);
        updateCaseCurrency(newCases);
        //Calling preventCaseClosureForUnreadEmails method
        //Date 18 May 2017 Gaurav Dudani T-603030.
        //D-23835 Fuse adjustment updates failing due to SC Validation rule
        String profileName = [select id,name from profile where id=:userinfo.getProfileId()].name;
        if(profileName!='System Administrator' && profileName!='Custom: Integration')
        {
            preventCaseClosureForUnreadEmails(oldMap,newCases);
        }
        //Added by Subha as part of B-121805
        if(profileName == 'Custom: MFM Agent'){
            updateAccountStatus(newCases,oldMap);
        }
        //Calling preventCaseClosureForOpenWorkOrders method
        //31 May 2017 Neeraj Kumawat T-606953.
        preventCaseClosureForOpenWorkOrders(oldMap,newCases);
        // #T-608973 12 June 2017  Neeraj Kumawat calling preventUnselectingWorkItemMultiPickList
        preventUnselectingWorkItemMultiPickList(oldMap,newCases);
        //16 June 2017 Neeraj Kumawat T-609952 calling updateUserLanguage method
        updateUserLanguage(oldMap,newCases);
        /*B-99979 - First Contact Resolution Calculation created by Srinivas Reddy*/
        beforeUpdateFRCValidation(newCases,oldMap);
        /* B-124215 CSR Case Type Field Mapping */
        if(Constants.CSRCaseTypeMappingProfiles.contains(profileName)){
            CSRcaseTypeMapping(newCases,oldMap);
        }
        prepopulateSubjectonChildCase(newCases, false);
        //* [12-Dec-2018]           [Srinivas Reddy]        [B-121805 - SFDC - Account Closure - Identify Attributes on Successful Closure  Case]
        SuccessfulClosureCase(newCases,oldMap);
        //caseOwnership(newCases,oldMap);
    }

    /* Collection of newly created cases by Custom Agent or Manager*/
    public static void OnAfterInsert(List<Case> newCases) {
        caseToCreateTask(newCases);
        createCaseComment(null,newCases);
        //Calling createWorkOrder method
        //Date 11 May 2017 Neeraj Kumawat T-601144
        createWorkOrder(newCases);
        // Calling Method to insert case Contact and account as Null.
        // Added By Gaurav Dudani on 15 June 2017 as per I-242653/T-609666.
        // Updated method name By Gaurav Dudani on 09 August 2017 as per I-242653.
        nullifyCaseContactAndAccount(newCases);
        // Start
        // Calling Method to Auto Assign Complaint Work Order
        // Added By Gaurav Dudani on 3rd July 2017 as per S-490684/T-611112.
        createAutoAssignedComplaintWorkOrder(null,newCases);
        // End


    }
    /* This method will call on after update of case*/
    public static void OnAfterUpdate(Map<Id,Case>oldMap,List<Case> newCases) {

        createCaseComment(oldMap,newCases);
        //Calling createWorkOrder method
        //Date 11 May 2017 Neeraj Kumawat T-601144
        createWorkOrder(newCases);
        // Start
        // Calling Method to Auto Assign Complaint Work Order
        // Added By Gaurav Dudani on 3rd July 2017 as per S-490684/T-611112.
        createAutoAssignedComplaintWorkOrder(oldMap,newCases);
        // End
        //6-July-2017 T-611575  calling updateComplaintWorkOrder method
        updateComplaintWorkOrder(oldMap,newCases);

    }


    /*Creates a new task when a case was created by a Agent or Manager */
    public static void caseToCreateTask(List<Case> newCases) {

        Id profileId=userinfo.getProfileId();
        // Start
        // Updated by Gaurav Dudani on 25th April 2017 to fix issue as per task # T-594827.
        String profileName = '';
        for(Profile objProfile: [Select Id,Name from Profile where Id=:profileId]){
            profileName = objProfile.Name;
        }
        //End

        List<Case> caseToTask = new List<Case>();
        // Start
        // Updated by Gaurav Dudani on 25th April 2017 to fix issue as per task # T-594827.
        // Updated By Neeraj Kumawat as per new Profile for Agent and Manager. 22-May-2017
        // Updated By Neeraj Kumawat as Added Custom PM and RM profile for creation
        // of new task on case create. 21-July-2017 #T-618796
        if(!string.isBlank(profileName) && (profileName == 'Custom: NA Manager' || profileName == 'Custom: NA Agent' ||
                profileName == 'Custom: MX Manager' || profileName == 'Custom: MX Agent' ||
                profileName == 'Custom: Partner Manager' || profileName == 'Custom: Relationship Manager')){
            // End
            for(Case c : newCases){
                caseToTask.add(c);
            }
        }

        createTask(caseToTask);
    }


    /*Creates Task and inserts to associated Case */
    public static void createTask(List<Case> newCases){

        Id userId = UserInfo.getUserId();


        List<Task> insertNewTask = new List<Task>();
        for(Case c : newCases){

            Task newTask = new Task();
            // 07 June 2017 Bobby Cheek checking FLS on Task fields
            if(Schema.sObjectType.Task.fields.ActivityDate.isCreateable()){newTask.ActivityDate = Date.today();}
            if(Schema.sObjectType.Task.fields.CurrencyISOCode.isCreateable()){newTask.CurrencyISOCode = c.CurrencyIsoCode;}
            if(Schema.sObjectType.Task.fields.Description.isCreateable()){newTask.Description = c.Description;}
            if(Schema.sObjectType.Task.fields.OwnerId.isCreateable()){newTask.OwnerId = userId;}
            if(Schema.sObjectType.Task.fields.Priority.isCreateable()){newTask.Priority = 'Normal';}
            if(Schema.sObjectType.Task.fields.Status.isCreateable()){newTask.Status = 'Complete';}
            if(Schema.sObjectType.Task.fields.Subject.isCreateable()){newTask.Subject = c.Subject;}
            if(Schema.sObjectType.Task.fields.Type.isCreateable()){newTask.Type = 'Call';}
            if(Schema.sObjectType.Task.fields.WhatId.isCreateable()){newTask.WhatId = c.Id;}
            //DJO 11/27/2018
            // if(Schema.sObjectType.Task.fields.Requires_Complaint_to_Be_Documented__c.isCreateable()){
            //     newTask.Requires_Complaint_to_Be_Documented__c = c.Requires_Complaint_to_Be_Documented__c;
            // }
            // if(Schema.sObjectType.Task.fields.Incoming_Communication_Method__c.isCreateable()){
            //     newTask.Incoming_Communication_Method__c  = c.Incoming_Communication_Method__c;
            // }
            // if(Schema.sObjectType.Task.fields.Complaint_Description__c.isCreateable()){
            //     newTask.Complaint_Description__c  = c.Complaint_Description__c;
            // }
            // if(Schema.sObjectType.Task.fields.Steps_Taken_Toward_Resolution__c.isCreateable()){
            //     newTask.Steps_Taken_Toward_Resolution__c  = c.Steps_Taken_Toward_Resolution__c;
            // }
            // if(Schema.sObjectType.Task.fields.Complaint_Created_By_Department__c.isCreateable()){
            //     newTask.Complaint_Created_By_Department__c = c.Complaint_Created_By_Department__c;
            // }
            insertNewTask.add(newTask);

        }
        if(Schema.sObjectType.Task.isCreateable()){
            insert insertNewTask;
        }
    }


    /*If Case Currency and Account Currency does not match or is null.
Update the Case currency with the Account currency */
    /*public static void updateCaseCurrency (List<Case> newCases){

List<Case> caseList = new List<Case>();
Set<Id> caseAccount = new Set<Id>();
for(Case c : newCases){
caseAccount.add(c.AccountId);
}

List<Account> accList = [SELECT ID, CurrencyIsoCode
FROM Account
WHERE ID IN : caseAccount];
for(Account accounts : accList){
for(Case ca : newCases){
if(accounts.CurrencyIsoCode != ca.CurrencyIsoCode){
// 15 June 2017 Bobby Cheek checking FLS on Case fields
if(Schema.sObjectType.Case.fields.CurrencyIsoCode.isUpdateable()){
ca.CurrencyIsoCode = accounts.CurrencyIsoCode;
caseList.add(ca);
}
}
}
}
}*/
    /*If Case Currency and Account Currency does not match or is null.
Update the Case currency with the Account currency */
    /*B-145888 - Refactor Process Builder - Case Copy MID  logic added by Srinivas 11/27/2018.*/
    public static void updateCaseCurrency (List<Case> newCases){

        List<Case> caseList = new List<Case>();
        Set<Id> caseAccount = new Set<Id>();
        for(Case c : newCases){
            caseAccount.add(c.AccountId);
        }
        Map<String,Account> accountCaseMap=new Map<String,Account>([SELECT ID, CurrencyIsoCode,MID__c FROM Account WHERE ID IN : caseAccount]);

        for(Case ca : newCases){
            if(accountCaseMap.get(ca.AccountId)!=null){
                Account caseAcc=accountCaseMap.get(ca.AccountId);
                if(caseAcc.CurrencyIsoCode != ca.CurrencyIsoCode){
                    if(Schema.sObjectType.Case.fields.CurrencyIsoCode.isUpdateable()){
                        ca.CurrencyIsoCode = caseAcc.CurrencyIsoCode;
                    }
                }
                ca.MID_TEXT__c=caseAcc.MID__c;
            }

        }
    }

    /*Case owner and previous Owner is updated to when cases are return if 'Return to Previous Owner' is true.  */
    public static void updateCaseOwner(List<Case> newCases){

        // List<Case> caseToUpdate = new List<Case>();
        String oldOwner;

        for(Case c : newCases){

            if(c.Return_Case_to_Previous_Owner__c && c.Prior_Owner__c !=null){
                c.ownerID = c.Prior_Owner__c;
                c.Return_Case_to_Previous_Owner__c = false;
                //caseToUpdate.add(c);
            }
            //if there is no previous owner, set return to previous owner as false
            c.Return_Case_to_Previous_Owner__c = false;
            // c.addError(Label.Prior_Owner_Error);
        }
    }

    /*If Case Owner is manually changed (NOT BY RETURN TO PREVIOUS OWNER) set prior owner. */
    public static void UpdateCasePriorOwner(Map<Id,Case> oldMap, List<Case> newCases){
        String setPriorOwner;
        for(case c : newCases){
            if(oldMap.get(c.Id).ownerId != c.ownerId) {
                setPriorOwner = oldMap.get(c.Id).OwnerId;
                c.Prior_Owner__c = setPriorOwner;
            }
        }

    }

    //****************************************************************************
    // Method to Creates case  comments when case internal comments field is changed
    // @param oldMap: Map of old case
    // @param newCases: List of Case object
    // @return void
    //****************************************************************************
    public static void createCaseComment(Map<Id,Case> oldMap,List<Case> newCases) {
        List<CaseComment> caseCommentList = new List<CaseComment>();
        for(Case objCase: newCases){
            if(objCase.Internal_Comments__c!=null){
                if(oldMap!=null){
                    //update case comment list on case update
                    String oldCaseComment=oldMap.get(objCase.Id).Internal_Comments__c;
                    //check is internal comment change
                    if(oldCaseComment!=objCase.Internal_Comments__c){
                        updateCaseCommentList(caseCommentList,objCase);
                    }

                }else{
                    //update case comment list on insert
                    updateCaseCommentList(caseCommentList,objCase);
                }
            }
        }

        insert caseCommentList;
    }
    //****************************************************************************
    // Method to update provided caseCommentList
    // @param caseCommentList: List of Case Comment
    // @param objCase: Case object
    // @return void
    //****************************************************************************
    public static void updateCaseCommentList(List<CaseComment> caseCommentList,Case objCase){

        CaseComment objCaseComment=new CaseComment();

        // 07 June 2017 Bobby Cheek checking FLS on CaseComment fields
        if(Schema.sObjectType.CaseComment.fields.CommentBody.isCreateable()){
            objCaseComment.CommentBody=objCase.Internal_Comments__c;}
        if(Schema.sObjectType.CaseComment.fields.isPublished.isCreateable()){
            objCaseComment.isPublished=false;}
        if(Schema.sObjectType.CaseComment.fields.ParentId.isCreateable()){
            objCaseComment.ParentId=objCase.Id;}

        caseCommentList.add(objCaseComment);
    }

    //****************************************************************************
    // Method to Insert User Language in User_Language__c Field
    // @param newCases: List of Case
    // @return void
    // 4 May 2017 Neeraj Kumawat T-599785
    //14 June Neeraj Kumawat Updated for getting user language instead of user Locale T-609575
    //****************************************************************************
    public static void insertUserLanguage(List<Case> newCases){
        string Language=UserInfo.getLanguage();
        for(Case c: newCases){
            c.User_Language__c=Language;
        }
    }
    //****************************************************************************
    // Method to update User Language in User_Language__c Field when case owner changed
    // @param newCases: List of Case
    // @param newCases: Map of old Case
    // @return void
    // 16 May 2017 Neeraj Kumawat  T-609952
    //Updated for setting user language from case owner language when case owner id changed
    //****************************************************************************
    /* Commented by Pallavi as this piece of code is hitting governor limits
public static void updateUserLanguage(Map<Id,Case> oldMap,List<Case> newCases){
for(Case caseObj: newCases){
Case oldCase=oldMap.get(caseObj.Id);
if(caseObj.OwnerId!=oldCase.OwnerId){
List<User> userList=[Select Id, LanguageLocaleKey From User Where Id=:caseObj.OwnerId];
if(userList.size()>0){
caseObj.User_Language__c=userList.get(0).LanguageLocaleKey;
}
}
}
}*/
    //****************************************************************************
    // Method to update User Language in User_Language__c Field when case owner changed
    // @param newCases: List of Case
    // @param newCases: Map of old Case
    // @return void
    // 16 May 2017 Neeraj Kumawat  T-609952
    //Updated for setting user language from case owner language when case owner id changed
    // 16 Jul 2018 - Updated by Pallavi as this piece of code was hitting governor limits
    //****************************************************************************
    public static void updateUserLanguage(Map<Id,Case> oldMap,List<Case> newCases){
        map<case,id> caseAndownerIds = new map<case,id>();
        map<id,user> userMap = new map<id, user>();
        for(Case caseObj: newCases){
            Case oldCase=oldMap.get(caseObj.Id);
            if(caseObj.OwnerId!=oldCase.OwnerId){
                caseAndownerIds.put(caseObj, caseObj.OwnerId);
            }
        }
        List<user> userRecs = [Select Id, LanguageLocaleKey From User Where Id IN:caseAndownerIds.values()];
        for(User u: userRecs){
            userMap.put(u.id, u);
        }
        for(case cs: caseAndownerIds.keySet()){
            if(userMap.containskey(cs.OwnerId)){
                cs.User_Language__c = userMap.get(cs.OwnerId).LanguageLocaleKey;
            }
        }
    }

    //****************************************************************************
    // Method to create Work Order on case
    // @param newCases: List of Case
    // @return void
    // 11 May 2017 Neeraj Kumawat T-601144
    //****************************************************************************
    //Commented by Pallavi as this method is consolidated and re-written below
    /*public static void createWorkOrder(List<Case> newCases){
List<WorkOrder> workOrderList=new List<WorkOrder>();
Map<Id,Case> caseMap=new Map<Id,Case>([Select Id, Subject,Account.Processing_Center_ID__c, (Select Id, Subject,RecordTypeId From WorkOrders)
From Case Where Id IN :newCases]);
//Calling getCETQueueMap to get queueName with Id
Map<String,String> queueNameMap= UtilityCls.getCETQueueMap();
String  naCetQueueId=queueNameMap.get('NA_CET_Team_General_Release');
String mxCetQueueId=queueNameMap.get('MX_CET_Team_General_Release');
//Fetching work Order record type details
for(Case cse: newCases){
//Added check for closed case to not create work order
if(cse.Status!=null && cse.Status!='Closed'){
Id caseId=cse.Id;
String workItems=cse.Work_Items__c;
// Creating General Release Work Order
if(workItems!=null && workItems.contains('General Release')){
//T-610968 Getting record type Id from UtilityCls.getRecordTypeId
String genReleaseWekOrderTypeId=UtilityCls.getRecordTypeId('WorkOrder',System.Label.General_Release);
Boolean isWorkOrderExists=checkWorkOrderExist(caseId,caseMap,genReleaseWekOrderTypeId);
if(!isWorkOrderExists){

WorkOrder wrkOrder= new WorkOrder();

// 07 June 2017 Bobby Cheek checking FLS on WorkOrder fields
if(Schema.sObjectType.WorkOrder.fields.Subject.isCreateable())
wrkOrder.Subject=System.Label.General_Release;
if(Schema.sObjectType.WorkOrder.fields.caseId.isCreateable())
wrkOrder.caseId=cse.Id;
if(Schema.sObjectType.WorkOrder.fields.recordTypeId.isCreateable())
wrkOrder.recordTypeId=genReleaseWekOrderTypeId;
//Added account and Contact Id to WorkOrder Creation from Case.
//22-May-2017 Neeraj Kumawat T-601144
if(Schema.sObjectType.WorkOrder.fields.accountId.isCreateable())
wrkOrder.accountId=cse.AccountId;
if(Schema.sObjectType.WorkOrder.fields.contactId.isCreateable())
wrkOrder.contactId=cse.contactId;
Case cseObj=caseMap.get(cse.Id);
//Updated assiging of workorder based on processing center id
//Updated by Neraj Kumawat 23-May-2017  T-601144
if(cseObj.Account!=null && cseObj.Account.Processing_Center_ID__c!=null){
if(naCetQueueId!=null && cseObj.Account.Processing_Center_ID__c=='NA'){
if(Schema.sObjectType.WorkOrder.fields.OwnerId.isCreateable())
wrkOrder.OwnerId=naCetQueueId;
}else if(mxCetQueueId!=null && cseObj.Account.Processing_Center_ID__c=='QUERE'){
if(Schema.sObjectType.WorkOrder.fields.OwnerId.isCreateable())
wrkOrder.OwnerId=mxCetQueueId;
}
}
workOrderList.add(wrkOrder);
}
}
//Creates workOrder when Fee Maintenance is selected in WorkLine Item
//12-May-2017 Poornima Bhardwaj T-592161
if(workItems!=null && workItems.contains('Fee Maintenance')){
//T-610968 Getting record type Id from UtilityCls.getRecordTypeId
String feeMaintainanceWekOrderTypeId=UtilityCls.getRecordTypeId('WorkOrder',System.Label.Fee_Maintenance);
//Checking whether workOrder already exists
Boolean isWorkOrderExists=checkWorkOrderExist(caseId,caseMap,feeMaintainanceWekOrderTypeId);
if(!isWorkOrderExists){
//Creating new workorder
WorkOrder wrkOrder= new WorkOrder();
// 07 June 2017 Bobby Cheek checking FLS on WorkOrder fields
if(Schema.sObjectType.WorkOrder.fields.Subject.isCreateable())
wrkOrder.Subject=System.Label.Fee_Maintenance;
if(Schema.sObjectType.WorkOrder.fields.caseId.isCreateable())
wrkOrder.caseId=cse.Id;
if(Schema.sObjectType.WorkOrder.fields.recordTypeId.isCreateable())
wrkOrder.recordTypeId=feeMaintainanceWekOrderTypeId;
//Added account and Contact Id to WorkOrder Creation from Case.
//22-May-2017 Neeraj Kumawat T-601144
if(Schema.sObjectType.WorkOrder.fields.accountId.isCreateable())
wrkOrder.accountId=cse.AccountId;
if(Schema.sObjectType.WorkOrder.fields.contactId.isCreateable())
wrkOrder.contactId=cse.contactId;
//Adding workorder to workOrderList
workOrderList.add(wrkOrder);
}
}
//Creates workOrder when Adjustment is selected in WorkLine Item
//12-May-2017 Poornima Bhardwaj T-603987
if(workItems!=null && workItems.contains('Adjustment')){
//T-610968 Getting record type Id from UtilityCls.getRecordTypeId
String adjustmentWekOrderTypeId=UtilityCls.getRecordTypeId('WorkOrder',System.Label.Adjustment);
//Checking whether workOrder already exists
Boolean isWorkOrderExists=checkWorkOrderExist(caseId,caseMap,adjustmentWekOrderTypeId);
if(!isWorkOrderExists){
//Creating new workorder
WorkOrder wrkOrder= new WorkOrder();

// 07 June 2017 Bobby Cheek checking FLS on WorkOrder fields
if(Schema.sObjectType.WorkOrder.fields.Subject.isCreateable())
wrkOrder.Subject=System.Label.Adjustment;
if(Schema.sObjectType.WorkOrder.fields.caseId.isCreateable())
wrkOrder.caseId=cse.Id;
if(Schema.sObjectType.WorkOrder.fields.recordTypeId.isCreateable())
wrkOrder.recordTypeId=adjustmentWekOrderTypeId;
//Added account and Contact Id to WorkOrder Creation from Case.
//22-May-2017 Neeraj Kumawat T-601144
if(Schema.sObjectType.WorkOrder.fields.accountId.isCreateable())
wrkOrder.accountId=cse.AccountId;
if(Schema.sObjectType.WorkOrder.fields.contactId.isCreateable())
wrkOrder.contactId=cse.contactId;
//Adding workorder to workOrderList
workOrderList.add(wrkOrder);
}
}
}
}
insert workOrderList;
}*

/* Added by Pallavi
* Method to create Work Order on case
* Added adjustment type functionality for creating adjustment Credit and Debit work orders and
* also consolidated and commented the method above
*/
    public static void createWorkOrder(List<Case> newCases){
        List<WorkOrder> workOrderList=new List<WorkOrder>();
        //Added by Subha as part of user story S-528229
        map<String,list<Banking_Information__c>> accountBankInfoMap=new map<String,list<Banking_Information__c>>();
        //String recordTypeId = UtilityCls.getRecordTypeId(System.Label.WorkOrder, System.Label.Adjustment);
        for(Case cs:newCases){
            if(cs.Status!='Closed' && cs.AccountId!=null && !string.IsBlank(cs.Work_Items__c)){
                if(String.valueof(cs.Work_Items__c).containsIgnoreCase('Adjustment'))
                    accountBankInfoMap.put(cs.AccountId,new list<Banking_Information__c>());
            }
        }
        if(accountBankInfoMap.size()>0){
            //Updated the Account Status to show the bank info on work order when it is not Open and Reopened as per user story S-528229
            for(Account acc:[select id,Account_Status__c , (select id,account__c,Settlement_Type__c,Account_Number__c,Routing_Number__c from Bank_Accounts__r where account__c!=null and Settlement_Type__c='Deposit Account')  from Account where (Account_Status__c != 'Open' AND Account_Status__c != 'Re-Opened' AND Account_Status__c != 'New') and id=:accountBankInfoMap.keyset()])
            {
                accountBankInfoMap.put(acc.id,acc.Bank_Accounts__r);
            }
        }

        Map<Id,Case> caseMap=new Map<Id,Case>([Select Id, Subject,Account.Account_Status__c,Account.Processing_Center_ID__c, (Select Id, Subject,RecordTypeId, Adjustment_Type__c,Account_Number__c,Routing_Number__c,Settlement_Type__c From WorkOrders)
        From Case Where Id IN :newCases]);


        //Calling getCETQueueMap to get queueName with Id
        Map<String,String> queueNameMap= UtilityCls.getCETQueueMap();
        String  naCetQueueId=queueNameMap.get('NA_CET_Team_General_Release');
        String mxCetQueueId=queueNameMap.get('MX_CET_Team_General_Release');

        //Fetching work Order record type details
        for(Case cse: newCases){
            //Added check for closed case to not create work order
            if(cse.Status!=null && cse.Status!='Closed'&& cse.AccountId!=null){
                Id caseId=cse.Id;
                if(!string.IsBlank(cse.Work_Items__c)){
                    for(String workItem: cse.Work_Items__c.split(';')){
                        String recordTypeId = '';
                        Boolean isWorkOrderExists = false;
                        // 10/15/2017 Changed all workItem.contains to have string values instead of labels as it is comparing against translated values
                        if(workItem.contains('Adjustment')){
                            recordTypeId = UtilityCls.getRecordTypeId(System.Label.WorkOrder, System.Label.Adjustment);
                            recTypeMap.put(recordTypeId, System.Label.Adjustment);
                            if(workItem.contains(System.Label.Credit)){
                                isWorkOrderExists=checkWorkOrderExist(caseId,caseMap,recordTypeId,System.Label.CustomerCredit);
                            }else if(workItem.contains(System.Label.Debit)){
                                isWorkOrderExists=checkWorkOrderExist(caseId,caseMap,recordTypeId,System.Label.CustomerDebit);
                            }

                        }else if(workItem.contains('General Release')){
                            recordTypeId = UtilityCls.getRecordTypeId(System.Label.WorkOrder, System.Label.General_Release);
                            isWorkOrderExists = checkWorkOrderExist(caseId,caseMap,recordTypeId,null);
                        }else if(workItem.contains('Fee Maintenance')){
                            recordTypeId = UtilityCls.getRecordTypeId(System.Label.WorkOrder, System.Label.Fee_Maintenance);
                            isWorkOrderExists = checkWorkOrderExist(caseId,caseMap,recordTypeId,null);
                        }
                        if(!isWorkOrderExists){
                            WorkOrder wrkOrder= new WorkOrder();
                            // Added by Subha as part of user story S-528229
                            if(workItem.contains('Adjustment')){
                                if(accountBankInfoMap.get(cse.AccountId)!=null){
                                    for(Banking_Information__c bkinfoWorkOrder:accountBankInfoMap.get(cse.AccountId)){
                                        if(Schema.sObjectType.WorkOrder.fields.Settlement_Type__c.isCreateable()){
                                            wrkOrder.Settlement_Type__c = bkinfoWorkOrder.Settlement_Type__c ;}
                                        if(Schema.sObjectType.WorkOrder.fields.Account_Number__c.isCreateable()){
                                            wrkOrder.Account_Number__c = bkinfoWorkOrder.Account_Number__c ;}
                                        if(Schema.sObjectType.WorkOrder.fields.Routing_Number__c.isCreateable()){
                                            wrkOrder.Routing_Number__c = bkinfoWorkOrder.Routing_Number__c ;}
                                    }
                                }
                                //10/15/2017 Commenting this because it does not put translated subject for mexico users
                                //if(Schema.sObjectType.WorkOrder.fields.Subject.isCreateable())
                                //  wrkOrder.Subject = workItem;
                                if(Schema.sObjectType.WorkOrder.fields.caseId.isCreateable()){
                                    wrkOrder.caseId=cse.Id;}
                                if(Schema.sObjectType.WorkOrder.fields.recordTypeId.isCreateable()){
                                    wrkOrder.recordTypeId = recordTypeId;}
                                if(Schema.sObjectType.WorkOrder.fields.accountId.isCreateable()){
                                    wrkOrder.accountId=cse.AccountId;}
                                if(Schema.sObjectType.WorkOrder.fields.contactId.isCreateable()){
                                    wrkOrder.contactId=cse.contactId;}
                                if(workItem.contains('Adjustment')){
                                    if(Schema.sObjectType.WorkOrder.fields.Subject.isCreateable()){
                                        wrkOrder.Subject = System.Label.Adjustment;}
                                    if(Schema.sObjectType.WorkOrder.fields.Adjustment_Type__c.isCreateable()){
                                        if(workItem.contains(System.Label.Credit)){
                                            wrkOrder.Adjustment_Type__c=System.Label.CustomerCredit;
                                        }else{
                                            wrkOrder.Adjustment_Type__c=System.Label.CustomerDebit;
                                        }
                                    }
                                    /*if(workItem.contains('Adjustment')){
if(Schema.sObjectType.WorkOrder.fields.Adjustment_Type__c.isCreateable()){

}
}*/
                                }
                            }
                            if(workItem.contains('Fee Maintenance')){
                                if(Schema.sObjectType.WorkOrder.fields.Subject.isCreateable()){
                                    wrkOrder.Subject = System.Label.Fee_Maintenance; }
                                //Added by Subha as part of user story S-528229
                                if(Schema.sObjectType.WorkOrder.fields.recordTypeId.isCreateable()){
                                    wrkOrder.recordTypeId=recordTypeId ;}
                                if(Schema.sObjectType.WorkOrder.fields.accountId.isCreateable()) {
                                    wrkOrder.accountId=cse.AccountId;}
                                if(Schema.sObjectType.WorkOrder.fields.contactId.isCreateable()){
                                    wrkOrder.contactId=cse.contactId;  }
                                if(Schema.sObjectType.WorkOrder.fields.caseId.isCreateable()) {
                                    wrkOrder.caseId = cse.Id;}
                            }
                            if(workItem.contains('General Release')) {
                                if(Schema.sObjectType.WorkOrder.fields.Subject.isCreateable()) {
                                    wrkOrder.Subject = System.Label.General_Release;}
                                //Added by Subha as part of user story S-528229
                                if(Schema.sObjectType.WorkOrder.fields.recordTypeId.isCreateable()){
                                    wrkOrder.recordTypeId=recordTypeId ;}
                                if(Schema.sObjectType.WorkOrder.fields.accountId.isCreateable()) {
                                    wrkOrder.accountId=cse.AccountId;  }
                                if(Schema.sObjectType.WorkOrder.fields.contactId.isCreateable()) {
                                    wrkOrder.contactId=cse.contactId;        }
                                if(Schema.sObjectType.WorkOrder.fields.caseId.isCreateable()) {
                                    wrkOrder.caseId = cse.Id;}
                                Case cseObj=caseMap.get(cse.Id);
                                //Updated assiging of workorder based on processing center id
                                //Updated by Neraj Kumawat 23-May-2017  T-601144
                                if(cseObj.Account!=null && cseObj.Account.Processing_Center_ID__c!=null) {
                                    if(naCetQueueId!=null && cseObj.Account.Processing_Center_ID__c=='NA'){
                                        if(Schema.sObjectType.WorkOrder.fields.OwnerId.isCreateable()){
                                            wrkOrder.OwnerId=naCetQueueId;}
                                    }else if(mxCetQueueId!=null && cseObj.Account.Processing_Center_ID__c=='QUERE'){
                                        if(Schema.sObjectType.WorkOrder.fields.OwnerId.isCreateable()){
                                            wrkOrder.OwnerId=mxCetQueueId;}
                                    }
                                }
                            }
                            workOrderList.add(wrkOrder);
                        }
                    }
                }
            }
        }
        if(workOrderList.size()>0) {
            insert workOrderList;
        }
    }
    //****************************************************************************
    // Method to check Work Order exist of not in case
    // @param newCases: List of Case
    // @return void
    // 11 May 2017 Neeraj Kumawat T-601144
    //****************************************************************************
    //Commented by Pallavi as this method is re-written below
    /*public static Boolean checkWorkOrderExist(Id caseId, Map<Id,Case> caseMap, String recordTypeId){
Case caseObj=caseMap.get(caseId);
for(WorkOrder wrk: caseObj.WorkOrders){
if(wrk.RecordTypeId==recordTypeId){
return true;
}
}
return false;
}*/
    /* Added by Pallavi
* Method to check Work Order exist of not in case
* Added new parameter for including adjustment type for creating adjustment work orders
*/
    public static Boolean checkWorkOrderExist(Id caseId, Map<Id,Case> caseMap, String recordTypeId, String adjustmentType){
        Case caseObj=caseMap.get(caseId);
        for(WorkOrder wrk: caseObj.WorkOrders){
            if(wrk.RecordTypeId==recordTypeId && adjustmentType==null){
                return true;
            }else if(wrk.RecordTypeId==recordTypeId && adjustmentType!=null){
                if(recTypeMap.containskey(recordTypeId)){
                    if(wrk.Adjustment_Type__c == adjustmentType){
                        return true;
                    }
                }
            }
        }
        return false;
    }
    //****************************************************************************
    // Method to prevent Prevent Case Closer with new unread email.
    // 18 May 2017 Gaurav Dudani as per task # T-603030
    //****************************************************************************
    public static void preventCaseClosureForUnreadEmails(Map<Id,Case> oldMap,List<Case> newCases){


        Map<Id, Case> closedCaseMap = new Map<Id, Case>();
        for(Case cas : newCases) {
            if (cas.status != oldMap.get(cas.Id).status
                    && cas.status == 'Closed') {
                closedCaseMap.put(cas.Id, cas);

            }
        }

        Set<Id> caseIdWithUnreadEmails= new Set<Id>();
        if(closedCaseMap.keySet().size() > 0) {    //AND Status = '0'
            for(EmailMessage emailMsg :[SELECT Id,Status,RelatedToID FROM EmailMessage WHERE ParentID IN :closedCaseMap.keySet()]){
                if(emailMsg.Status == '0')
                    closedCaseMap.get(emailMsg.RelatedToID).addError(System.Label.CaseClosureOnUnreadEmail);
            }
        }
    }
    //****************************************************************************
    // Method to prevent Case Closer when there are open Workorder on case
    // @param oldMap: Map of old Case
    // @param newCases: List of new Case
    // @return void
    // 31 May 2017 Neeraj Kumawat as per task #T-606953
    // 06 July 2017 Gaurav Dudani as per Task # T-611808.
    //****************************************************************************
    public static void preventCaseClosureForOpenWorkOrders(Map<Id,Case> oldMap,List<Case> newCases){
        // Start
        // Added to get the Complaint work order recordType.
        // On 6th July 2017 By Gaurav Dudani as per T-611808.
        String complaintWrkOrderTypeId=UtilityCls.getRecordTypeId('WorkOrder',System.Label.Complaint);
        // End

        //List of Work Order open status
        List<String> workOrderOpenStatus=new List<String>{'New','In Progress','On Hold'};
        //Map of case with closed status
        Map<Id, Case> closedCaseMap = new Map<Id, Case>();
        for(Case cas : newCases){
            if (cas.status != oldMap.get(cas.Id).status && cas.status == 'Closed'){
                closedCaseMap.put(cas.Id, cas);
            }
        }
        // Start
        // Added recordType check for Complaint Work Order on Query to allow user
        // to manually clase the case with open Complaint Type Work Orders.
        // On 6th July 2017 By Gaurav Dudani as per T-611808.
        List<Case> caseList=[Select Id, Subject,Status, (Select Id, Subject,Status
        From WorkOrders Where Status IN :workOrderOpenStatus AND RecordTypeId !=: complaintWrkOrderTypeId)
        From Case Where Id IN :closedCaseMap.keySet()];
        // End
        for(Case cse: caseList){
            List<WorkOrder> openWorkOrderList=cse.WorkOrders;
            //Showing error message on case clsoe when there is open work order on it
            if(openWorkOrderList.size()>0){
                closedCaseMap.get(cse.Id).addError(Label.Case_Close_When_Open_WorkOrder);
            }
        }
    }
    //****************************************************************************
    // Method to prevent unselecting the WorkItem MultiPickList values
    // @param oldMap: Map of old Cas
    // @param newCases: List of new Case
    // @return void
    // 12 June 2017 Neeraj Kumawat as per task #T-608973
    //****************************************************************************
    //Commented by Pallavi as this method is causing issues
    /* public static void preventUnselectingWorkItemMultiPickList(Map<Id,Case> oldMap,List<Case> newCases){
//List of updated cases
for(Case cse: newCases){
String newWorkItems=cse.Work_Items__c;
String oldWorkItems=oldMap.get(cse.Id).Work_Items__c;
//Check work item multi select value is changed or not
if(newWorkItems!=oldWorkItems){
if(oldWorkItems==null){
oldWorkItems='';
}
if(newWorkItems==null){
newWorkItems='';
}
//Showing error when user try to unselect Work item value in case
if(!newWorkItems.contains(oldWorkItems)){
cse.addError(System.Label.PreventUnselectWorkItem);
}
}
}
}*/
    /* Added by Pallavi
* Method to prevent unselecting the WorkItem MultiPickList values
* This method is updated to add work items to set instead of using string
* Commented the method above because of a bug
*/
    public static void preventUnselectingWorkItemMultiPickList(Map<Id,Case> oldMap,List<Case> newCases){
        //List of updated cases
        for(Case cse: newCases){
            set<string> newWorkItems = new set<string>();
            set<string> oldWorkItems = new set<string>();
            if(!string.IsBlank(cse.Work_Items__c)){
                for(String workItem : cse.Work_Items__c.split(';')){
                    newWorkItems.add(workItem);
                }
            }
            if(!string.IsBlank(oldMap.get(cse.Id).Work_Items__c)){
                for(String workItem : oldMap.get(cse.Id).Work_Items__c.split(';')){
                    oldWorkItems.add(workItem);
                }
            }
            //Check work item multi select value is changed or not
            if(newWorkItems!=oldWorkItems){
                //Showing error when user try to unselect Work item value in case
                if(!newWorkItems.containsAll(oldWorkItems)){
                    cse.addError(System.Label.PreventUnselectWorkItem);
                }
            }
        }
    }
    //****************************************************************************
    // Method to insert case contact and account as null.
    // 15 June 2017 Gaurav Dudani as per I-242653/T-609666.
    // 09 August 2017 by Gaurav Dudani as per I-242653.
    //****************************************************************************
    // Updated appropriate method name as per I-242653.
    public static void nullifyCaseContactAndAccount(List<Case> newCaseList) {
        List<Case> caseToUpdate = new List<Case>();
        // Added AccountId attribute to the query as per I-242653.
        for (Case cas : [SELECT ContactId,AccountId,CreatedBy.LastName
        FROM Case
        WHERE Id IN :newCaseList]) {
            // Checking if Created By lastname is System, conatct Id is not null and account Id is not null.
            if(cas.CreatedBy.LastName.endsWith('System')
                    && (cas.ContactId != null && cas.AccountId != null)) {
                if(Schema.sObjectType.Case.fields.ContactId.isUpdateable()) {
                    cas.ContactId = null;
                }
                // Added to update accountId as null as per I-242653.
                if(Schema.sObjectType.Case.fields.AccountId.isUpdateable()) {
                    cas.AccountId = null;}
                caseToUpdate.add(cas);
            }
        }
        if (caseToUpdate.size()>0) {
            update caseToUpdate;
        }
    }



    //****************************************************************************
    // Method to Auto Generate Complaint Work Order when Requires Complaint to Be Documented is yes.
    // On 3rd July, 2017 Gaurav Dudani as per S-490684/T-611112.
    //****************************************************************************

    public static void createAutoAssignedComplaintWorkOrder(Map<Id,Case>oldMap,List<Case> newCases) {
        List<WorkOrder> workOrderToBeCreate = new List<WorkOrder>();
        String complaintWORtId = UtilityCls.getRecordTypeId('WorkOrder',System.Label.Complaint);
        for(Case cas: newCases){
            if(cas.Requires_Complaint_to_Be_Documented__c == 'Yes'
                    &&(oldMap == null || (oldMap != null && cas.Requires_Complaint_to_Be_Documented__c != oldMap.get(cas.Id).Requires_Complaint_to_Be_Documented__c))){
                WorkOrder wo = new WorkOrder();
                if(Schema.sObjectType.WorkOrder.fields.RecordTypeId.isCreateable()){
                    wo.RecordTypeId = complaintWORtId;
                }
                if(Schema.sObjectType.WorkOrder.fields.CaseId.isCreateable()){
                    wo.CaseId = cas.Id;
                }
                if(Schema.sObjectType.WorkOrder.fields.AccountId.isCreateable()){
                    wo.AccountId = cas.AccountId;
                }
                if(Schema.sObjectType.WorkOrder.fields.ContactId.isCreateable()){
                    wo.ContactId = cas.ContactId;
                }
                if(Schema.sObjectType.WorkOrder.fields.Incoming_Communication_Method__c.isCreateable()){
                    wo.Incoming_Communication_Method__c =  cas.Incoming_Communication_Method__c;
                }
                if(Schema.sObjectType.WorkOrder.fields.Complaint_Description__c.isCreateable()){
                    wo.Complaint_Description__c = cas.Complaint_Description__c;
                }
                if(Schema.sObjectType.WorkOrder.fields.Issue_Resolved__c.isCreateable()){
                    wo.Issue_Resolved__c = cas.Issue_Resolved__c;
                }
                if(Schema.sObjectType.WorkOrder.fields.Steps_Taken_Toward_Resolution__c.isCreateable()){
                    wo.Steps_Taken_Toward_Resolution__c = cas.Steps_Taken_Toward_Resolution__c;
                }
                if(Schema.sObjectType.WorkOrder.fields.Resolution_Communicated_Via__c.isCreateable()){
                    wo.Resolution_Communicated_Via__c = cas.Resolution_Communicated_Via__c;
                }
                if(Schema.sObjectType.WorkOrder.fields.Complaint_Created_By_Department__c.isCreateable()){
                    wo.Complaint_Created_By_Department__c = cas.Complaint_Created_By_Department__c;
                }
                if(Schema.sObjectType.WorkOrder.fields.Created_By_Department_Other__c.isCreateable()){
                    wo.Created_By_Department_Other__c = cas.Created_By_Department_Other__c;
                }
                if(Schema.sObjectType.WorkOrder.fields.Sensitive_Words__c.isCreateable()){
                    wo.Sensitive_Words__c = cas.Sensitive_Words__c;
                }
                if(Schema.sObjectType.WorkOrder.fields.Generated_By__c.isCreateable()){
                    wo.Generated_By__c = 'Case';
                }
                workOrderToBeCreate.add(wo);
            }
        }
        if(!workOrderToBeCreate.isEmpty()){
            insert workOrderToBeCreate;
        }
    }
    //****************************************************************************
    // Method to update workorder when complaint field on case updated
    // @param oldMap: Map of old Cas
    // @param newCases: List of new Case
    // @return void
    // 5 July 2017 Neeraj Kumawat as per task #T-611575
    //****************************************************************************
    public static void updateComplaintWorkOrder(Map<Id,Case>oldMap,List<Case> newCases) {
        List<WorkOrder> workOrderToBeUpdate = new List<WorkOrder>();
        String complaintWORtId = UtilityCls.getRecordTypeId('WorkOrder',System.Label.Complaint);
        List<WorkOrder> complaintWorkOrderList=[Select Id, Subject,CaseId,Status from WorkOrder Where CaseId In:newCases AND RecordTypeId=:complaintWORtId AND Generated_By__c='Case'];
        Map<Id,WorkOrder> complaintWorkOrderMap=new Map<Id,WorkOrder>();
        if(complaintWorkOrderList.size()>0){
            for(WorkOrder complaintWorkOrder: complaintWorkOrderList){
                complaintWorkOrderMap.put(complaintWorkOrder.CaseId, complaintWorkOrder);
            }
            for(Case cas: newCases){
                WorkOrder wo=complaintWorkOrderMap.get(cas.Id);
                Boolean isComplaintFieldUpdated=false;
                if(oldMap != null){
                    //Updated boolean variable to true if case complaint detail fields are changed
                    isComplaintFieldUpdated= checkCaseComplaintFieldChange(cas,oldMap.get(cas.Id));
                }
                if(isComplaintFieldUpdated){
                    //Shwoing error when user tried to update complaint Work Order fields on case and work order
                    //is closed
                    if(wo!=null && wo.Status=='Closed'){
                        cas.addError(System.Label.Restrict_Closed_Complaint_Work_Order_From_Case);
                    }else{
                        if(Schema.sObjectType.WorkOrder.fields.Incoming_Communication_Method__c.isUpdateable()){
                            wo.Incoming_Communication_Method__c =  cas.Incoming_Communication_Method__c;
                        }
                        if(Schema.sObjectType.WorkOrder.fields.Complaint_Description__c.isUpdateable()){
                            wo.Complaint_Description__c = cas.Complaint_Description__c;
                        }
                        if(Schema.sObjectType.WorkOrder.fields.Issue_Resolved__c.isUpdateable()){
                            wo.Issue_Resolved__c = cas.Issue_Resolved__c;
                        }
                        if(Schema.sObjectType.WorkOrder.fields.Steps_Taken_Toward_Resolution__c.isUpdateable()){
                            wo.Steps_Taken_Toward_Resolution__c = cas.Steps_Taken_Toward_Resolution__c;
                        }
                        if(Schema.sObjectType.WorkOrder.fields.Resolution_Communicated_Via__c.isUpdateable()){
                            wo.Resolution_Communicated_Via__c = cas.Resolution_Communicated_Via__c;
                        }
                        if(Schema.sObjectType.WorkOrder.fields.Complaint_Created_By_Department__c.isUpdateable()){
                            wo.Complaint_Created_By_Department__c = cas.Complaint_Created_By_Department__c;
                        }
                        if(Schema.sObjectType.WorkOrder.fields.Created_By_Department_Other__c.isUpdateable()){
                            wo.Created_By_Department_Other__c = cas.Created_By_Department_Other__c;
                        }
                        if(Schema.sObjectType.WorkOrder.fields.Sensitive_Words__c.isUpdateable()){
                            wo.Sensitive_Words__c = cas.Sensitive_Words__c;
                        }
                        if(Schema.sObjectType.WorkOrder.fields.Generated_By__c.isUpdateable()){
                            wo.Generated_By__c = 'Case';
                        }
                        workOrderToBeUpdate.add(wo);
                    }
                }
            }
            if(!workOrderToBeUpdate.isEmpty()){
                update workOrderToBeUpdate;
            }
        }
    }
    //****************************************************************************
    // Method to check comaplaint detail fields on case are updated or not
    // @param newCase: new Case object
    // @param oldCase: old case object
    // @return Boolean: return true if comaplaint detail fields on case are updated else return false
    // 6 July 2017 Neeraj Kumawat as per task #T-611575
    //****************************************************************************
    public static Boolean checkCaseComplaintFieldChange(Case newCase, Case oldCase){
        if(newCase.Requires_Complaint_to_Be_Documented__c == 'Yes'
                && newCase.Requires_Complaint_to_Be_Documented__c == oldCase.Requires_Complaint_to_Be_Documented__c
                && (newCase.Incoming_Communication_Method__c!=oldCase.Incoming_Communication_Method__c
                || newCase.Complaint_Description__c!=oldCase.Complaint_Description__c
                ||newCase.Steps_Taken_Toward_Resolution__c!= oldCase.Steps_Taken_Toward_Resolution__c
                ||newCase.Issue_Resolved__c!= oldCase.Issue_Resolved__c
                ||newCase.Created_By_Department_Other__c!= oldCase.Created_By_Department_Other__c
                ||newCase.Resolution_Communicated_Via__c!= oldCase.Resolution_Communicated_Via__c
                ||newCase.Complaint_Created_By_Department__c!= oldCase.Complaint_Created_By_Department__c
                ||newCase.Sensitive_Words__c!= oldCase.Sensitive_Words__c)){
            return true;
        }else{
            return false;
        }
    }
    //****************************************************************************
    // Method to prevent manually selection of new information value in case status field
    // @param newCases: List of new Case
    // @return void
    // 04 July 2017 Poornima Bhadwaj as per task #T-614291
    //****************************************************************************
    public static void restrictCaseStatusToBeNewInformationManually(Map<Id,Case>oldMap,List<Case> newCases) {
        for(Case cas:newCases){
            if(cas.NewInformationSelected__c==True){
                cas.NewInformationSelected__c=False;
            }else if(cas.NewInformationSelected__c==False && cas.status=='New Information' && (oldMap == null || (oldMap!=null && oldMap.get(cas.Id).status != cas.status))){
                cas.addError(Label.Case_Status_New_Information_Restriction);

            }
        }

    }
    /*B-99979 - First Contact Resolution Calculation created by Srinivas Reddy*/
    public static void beforeinsertFRCValidation(List<Case> newCases){
        datetime hrsDate24=system.now().adddays(-1);
        datetime hrsDate48=system.now().adddays(-2);
        set<String> CaseIds=new set<String>();
        set<String> duplicateCaseIds=new set<String>();
        set<String> haveingChildCases=new set<String>();

        set<String> parentIds=new set<String>();
        set<String> caseTypeValues=new set<String>();
        set<String> caseTypeValues2=new set<String>();
        set<String> AccountIds=new set<String>();
        set<String> midTypes=new set<String>();
        for(Case c:newCases){
            if(c.CSR_Case_Type__c!=null && c.AccountID!=null){
                for(String CSRType:c.CSR_Case_Type__c.split(';'))
                    caseTypeValues.add(CSRType);
                AccountIds.add(c.AccountID);
                if(c.parentId!=null)
                    parentIds.add(c.parentid);
            }
        }
        if(caseTypeValues.size()>0){
            list<Case> updateCases=new list<Case>();
            //Making FCR false when creatiing new case with same type and MID wiht in 48hrs and also making parent case of FCR to false,if case having parent case.
            for(case c:[select id,CSR_Case_Type__c,FCRcase__c,AccountID,isClosed from case where createddate>=:hrsDate48 and (accountId=:AccountIds or id=:parentIds) and CSR_Case_Type__c!=null]){
                for(String CSRType:c.CSR_Case_Type__c.split(';')){
                    if((caseTypeValues.contains(CSRType) || parentIds.contains(c.id)) && c.FCRcase__c==true ){
                        c.FCRcase__c=false;
                        updateCases.add(c);
                        break;
                    }
                }
            }
            if(updateCases.size()>0)
                update updateCases;
        }
    }
    /*B-99979 - First Contact Resolution Calculation created by Srinivas Reddy*/
    public static void beforeUpdateFRCValidation(List<Case> newCases,map<id,Case> oldmap){
        datetime hrsDate24=system.now().adddays(-1);
        datetime hrsDate48=system.now().adddays(-2);
        set<String> CaseIds=new set<String>();
        set<String> duplicateCaseIds=new set<String>();
        set<String> haveingChildCases=new set<String>();

        set<String> parentIds=new set<String>();
        set<String> caseTypeValues=new set<String>();
        set<String> caseTypeValues2=new set<String>();
        set<String> AccountIds=new set<String>();
        set<String> midTypes=new set<String>();
        for(Case c:newCases){
            // considring cases which have changes the account or type or parentId or Status values
            if((oldmap.get(c.id).status!=c.status ||
                    (c.AccountID!=null && oldmap.get(c.id).AccountID!=c.AccountID) ||
                    (c.CSR_Case_Type__c!=null && oldmap.get(c.id).CSR_Case_Type__c!=c.CSR_Case_Type__c) ||
                    oldmap.get(c.id).parentId != c.parentId)){
                // checking the case status is Closed with in 24hrs
                if(c.Status == 'Closed' && c.createddate>=hrsDate24) {
                    CaseIds.add(c.id);
                    if(c.CSR_Case_Type__c!=null)
                        for(String CSRType:c.CSR_Case_Type__c.split(';'))
                            caseTypeValues2.add(CSRType);
                    AccountIds.add(c.AccountID);
                }
                // Chening cases which are updated with in 48hrs
                else if(c.createddate>=hrsDate48){
                    if(c.FCRcase__c==true)
                        c.FCRcase__c=false;
                    if(c.CSR_Case_Type__c!=null)
                        for(String CSRType:c.CSR_Case_Type__c.split(';'))
                            caseTypeValues.add(CSRType);
                    AccountIds.add(c.AccountID);
                    duplicateCaseIds.add(c.id);
                }
                if(c.parentID!=null)
                    parentIds.add(c.parentid);
            }

        }
        if(CaseIds.size()>0){
            //checking whether case haveing child ot not and mapping MID and Case Type.
            String caseCsrTypes='';
            for(String str:caseTypeValues2){
                if(caseCsrTypes=='')
                    caseCsrTypes=str;
                else caseCsrTypes+=','+str;
            }
            for(case c:[select id,parentID,accountid,CSR_Case_Type__c from case where id!=:CaseIds and (ParentID=:CaseIds or (CSR_Case_Type__c includes (:caseCsrTypes) and accountid=:AccountIds and createddate>=:hrsDate24))]){
                if(CaseIds.contains(c.parentid))
                    haveingChildCases.add(c.parentID);
                //[13-Aug-2018]           [Srinivas Reddy]        [D-23326 I-12258/B-68909 - MX users are not able to close cases in Prod
                else if(c.CSR_Case_Type__c!=null){
                    for(String CSRType:c.CSR_Case_Type__c.split(';'))
                        midTypes.add(c.AccountID+CSRType);
                }
            }

        }
        if(caseTypeValues.size()>0 || parentIds.size()>0){
            list<Case> updateCases=new list<Case>();
            set<String> uniqueCaseIds=new set<String>();
            //Making FCR false when creatiing new case with same type and MID wiht in 48hrs and also making parent case of FCR to false,if case having parent case.
            for(case c:[select id,CSR_Case_Type__c,FCRcase__c,AccountID,isClosed from case where createddate>=:hrsDate48 and ((AccountId=:AccountIds and id!=:duplicateCaseIds) or id=:parentIds)]){
                //[13-Aug-2018]           [Srinivas Reddy]        [D-23326 I-12258/B-68909 - MX users are not able to close cases in Prod
                if(c.CSR_Case_Type__c!=null){
                    for(String CSRType:c.CSR_Case_Type__c.split(';')){
                        if(caseTypeValues.contains(CSRType) && c.FCRcase__c==true ){
                            c.FCRcase__c=false;
                            uniqueCaseIds.add(c.id);
                            updateCases.add(c);
                            break;
                        }
                    }
                }
                if(!uniqueCaseIds.contains(c.id) && parentIds.contains(c.id) && c.FCRcase__c==true ){
                    c.FCRcase__c=false;
                    updateCases.add(c);
                }
            }
            if(updateCases.size()>0)
                update updateCases;
        }

        for(Case c:newCases){
            // Making FCR to true when case is closing and not having childs and
            if(c.createddate>=hrsDate24){
                if(c.status=='Closed' && (oldmap.get(c.id).status!=c.status || oldmap.get(c.id).CSR_Case_Type__c!=c.CSR_Case_Type__c || oldmap.get(c.id).accountid!=c.accountid) && !haveingChildCases.contains(c.id)){
                    boolean isFCRtrue=false;
                    if(c.CSR_Case_Type__c!=null)
                        for(String CSRType:c.CSR_Case_Type__c.split(';')){
                            if(!midTypes.contains(c.accountId+CSRType)){
                                c.FCRcase__c=true;
                                isFCRtrue=true;
                            }
                        }
                    if(isFCRtrue==false) {
                        c.FCRcase__c=false;
                    } else c.FCRcase__c=false;
                }
            }
        }
    }
    //* [09-Oct-2018]           [Srinivas Reddy]        [B-124215 CSR Case Type Field Mapping]
    public static void CSRcaseTypeMapping(List<Case> newCases,map<id,Case> oldmap){

        Map<ID, Schema.RecordTypeInfo> rtMap = Schema.SObjectType.case.getRecordTypeInfosById();
        string recordtype;
        list<string> callTypes = new list<string>();
        for(case c:newCases){
            if(c.RecordTypeId!=null){
                recordtype= rtMap.get(c.RecordTypeId).getName();
                String CSRCaseType='';
                boolean isMappingCSR=false;

                if(oldmap==null && c.Call_Type__c!=null)
                    isMappingCSR=true;
                else if(oldmap!=null){
                    if((oldmap.get(c.id).Call_Type__c!=c.Call_Type__c && c.Call_Type__c!=null) || c.Product_Topic__c==null)
                        isMappingCSR=true;
                }

                callTypes = c.Call_Type__c != null ? c.Call_Type__c.split(';') : new List<String>();
                // Added by Subha as part of B-124547
                if(isMappingCSR && (recordtype==Constants.NArecordtype || recordtype==label.CustomerfollowupRT)){
                    // added parent id check to bypass null issue temporarily&& c.ParentId==null && c.RecordType.DeveloperName=='Customer'
                    //if(isMappingCSR && (c.ParentId!=null && recordtype=='Customer Follow Up Inquiry')){
                    Map<String,Call_Type__mdt> selectedCallTypeVals=new Map<String,Call_Type__mdt>();
                    for(String callType:callTypes){
                        selectedCallTypeVals.put(callType,null);
                    }
                    for(Call_Type__mdt ctypeMtd:[select id,MasterLabel, CSR_Case_Type__c,Is_Required_Product_Topic__c from Call_Type__mdt where CSR_Case_Type__c!=null and MasterLabel=:selectedCallTypeVals.keyset()  ]){
                        selectedCallTypeVals.put(ctypeMtd.MasterLabel,ctypeMtd);
                    }
                    set<String> duplicateVal=new set<String>();
                    for(String callType:callTypes){
                        if(selectedCallTypeVals.get(callType)!=null){

                            Call_Type__mdt mtd= selectedCallTypeVals.get(callType);
                            if(mtd.Is_Required_Product_Topic__c && c.Product_Topic__c==null){
                                c.Product_Topic__c.adderror(label.Please_select_Product_Topic);
                                break;
                            }else if(!duplicateVal.contains(mtd.CSR_Case_Type__c)){
                                if(CSRCaseType=='')
                                    CSRCaseType=mtd.CSR_Case_Type__c;
                                else CSRCaseType=CSRCaseType+';'+mtd.CSR_Case_Type__c;
                                duplicateVal.add(mtd.CSR_Case_Type__c);
                            }
                        }
                    }
                    if(Schema.sObjectType.case.fields.CSR_Case_Type__c.isCreateable())
                    {
                        c.CSR_Case_Type__c=CSRCaseType;
                    }
                }
            }
        }
    }


    //[27-11-2018] [Suresh Kumar]  [B-145889 - Refactor Process Builder - Update Case Last Modified By department.]
    public static void Lastmodifiedbydepartment(List<Case> newCases){

        List<user> u =[select id,Department from user where id=:UserInfo.getUserId()];
        if(u[0].Department!=null)
        {
            for(case department:newCases)
            {
                department.Last_Modified_by_Department__c = u[0].Department;
            }
        }
    }
    //Added by Subha as part of B-121805
    public static void updateAccountStatus(List<Case> newCases,map<id,Case> oldmap){
        List<Account> accList = new List<Account>();
        set<String> accIds=new set<String>();
        for(Case c : newCases)
        {
            // Added as part of B-169927
            If(c.Status == 'Closed' && !accIds.contains(c.Accountid) && c.AccountId!= null && oldmap.get(c.id).Status !=c.Status && c.recordtypeid==UtilityCls.getRecordTypeId('case',Constants.accountStatus_Update) && c.Final_Account_Status_Decision__c== Constants.updaccstatus && c.Requested_Account_Status__c!=null && c.Requested_Closure_Reason__c!=null){
                Account a = new Account();
                a.Account_Status__c = c.Requested_Account_Status__c;
                a.Account_Status_Reason__c = c.Requested_Closure_Reason__c;
                a.Id= c.AccountId;
                accIds.add(a.Id);
                accList.add(a);
            }
        }
        if(accList.size()>0)
        {
            try{
                update accList;
            }
            catch(Exception E){
                System.debug('The following exception has occurred: ' + e.getMessage());
            }
        }
    }

    //* [16-Oct-2018]           [Pallavi Anipindi]        [B-122457 Refactor Lockbox Post MID Update]
    public static void prepopulateSubjectonChildCase(List<Case> newCases, boolean isInsert){
        Schema.DescribeFieldResult caseActivityResult = Case.Activity__c.getDescribe();
        List<Schema.PicklistEntry> picklistValues = caseActivityResult.getPicklistValues();
        List<string> activityValues = new List<string>();
        for(Schema.PicklistEntry sple:picklistValues){
            activityValues.add(sple.getLabel());
        }
        Schema.DescribeSObjectResult caseResult = Case.SObjectType.getDescribe();
        List<Schema.RecordTypeInfo> RT = caseResult.getRecordTypeInfos();
        Map<Id, string> recTypeMap = new Map<Id, string>();
        for(Schema.RecordTypeInfo recInfo : RT){
            if(recInfo.isAvailable()) {
                recTypeMap.put(recInfo.getRecordTypeId(), recInfo.getName());
            }
        }
        string recLabel = '';
        for(Case c:newCases){
            if(recTypeMap.ContainsKey(c.RecordtypeId) ){
                recLabel = recTypeMap.get(c.RecordtypeId);
            }
            // Added by Subha as part of B-124547
            if(!recLabel.contains(label.CustomerfollowupRT)){
                if(c.ParentId!=null && activityValues.contains(recLabel)){
                    if(isInsert){
                        if(Schema.sObjectType.Case.fields.Subject.isCreateable()){
                            c.Subject = recLabel;
                        }
                    }else{
                        if(c.subject != recLabel){
                            if(Schema.sObjectType.Case.fields.Subject.isCreateable()){
                                c.Subject = recLabel;
                            }
                        }
                    }
                }
            }
        }
    }
    //* [12-Dec-2018]           [Srinivas Reddy]        [B-121805 - SFDC - Account Closure - Identify Attributes on Successful Closure  Case
    public static void SuccessfulClosureCase(list<Case> newCases,map<Id,Case> oldMap){
        map<String,boolean> multiMidValueMap=new map<String,boolean>();
        for(case cs:newCases){
            if(cs.accountid!=null && cs.recordtypeid==UtilityCls.getRecordTypeId('case',Constants.accountStatus_Update)){
                if(oldMap==null)
                    multiMidValueMap.put(cs.accountid,false);
                else if(oldMap.get(cs.id).Accountid!=cs.accountid)
                    multiMidValueMap.put(cs.accountid,false);
            }
        }
        if(multiMidValueMap.size()>0){
            for(Asset asst:[select id,accountid,Multi_Mid__c from asset where accountid=:multiMidValueMap.keyset()]){
                if(asst.Multi_Mid__c==true){
                    multiMidValueMap.put(asst.accountid,true);
                }
            }
            map<String,boolean> fanFareValueMap=new map<String,boolean>();
            map<String,boolean> ElectronicGiftCardValueMap=new map<String,boolean>();
            for(Value_Added_Service__c vService:[select id,Account__c,VAS_Type__c from Value_Added_Service__c where Account__c=:multiMidValueMap.keyset()]){
                if(vService.VAS_Type__c==Constants.Fanfare){
                    fanFareValueMap.put(vService.Account__c,true);
                }
                //[B-167330 - SFDC - Account Closure - Identify Attributes on Successful Closure  Case - Missed EGC Auth Fees]
                if(vService.VAS_Type__c==Constants.ElectronicGiftCard || vService.VAS_Type__c.contains(Constants.EGC)){
                    ElectronicGiftCardValueMap.put(vService.Account__c,true);
                }
            }
            for(case cs:newCases){
                if(cs.accountid!=null){
                    cs.Multi_Mid__c=multiMidValueMap.get(cs.accountid);
                    if(fanFareValueMap.get(cs.accountid)!=null)
                        cs.Fanfare__c=true;
                    else cs.Fanfare__c=false;

                    if(ElectronicGiftCardValueMap.get(cs.accountid)!=null)
                        cs.Electronic_Gift_Card__c=true;
                    else cs.Electronic_Gift_Card__c=false;
                }
            }
        }
    }

    /* commenting to test PBs and validations by Pallavi
public static void caseOwnership(list<Case> newCases,map<Id,Case> oldMap){
for(Case c:newCases){
Boolean iscasePreviusOwnerChanged=false;
Boolean isOwnerChangeed=false;
if(oldMap.get(c.id)!=null)
{
if(c.Return_Case_to_Previous_Owner__c != oldMap.get(c.id).Return_Case_to_Previous_Owner__c)
iscasePreviusOwnerChanged=true;
else iscasePreviusOwnerChanged=false;
if(c.Ownerid!= oldMap.get(c.id).Ownerid)
isOwnerChangeed=true;
else isOwnerChangeed=false;
}
else {
iscasePreviusOwnerChanged=true;
isOwnerChangeed=true;
}
If(c.Prior_Owner__c!=null && c.Return_Case_to_Previous_Owner__c == true && iscasePreviusOwnerChanged){
if(c.Prior_Owner_Type__c == 'User' ){
c.Ownerid= c.Prior_Owner__c;
}
c.Return_Case_to_Previous_Owner__c  = false;
}
else if(isOwnerChangeed ){
c.Prior_Owner__c = oldMap.get(c.id).Ownerid;
}
else if(c.Return_Case_to_Previous_Owner__c == true && c.Prior_Owner_Type__c == 'User' ){
c.Return_Case_to_Previous_Owner__c = false;

}
}
}
*/

    //* [23-Jan-2019]             [Deborah Orth]          [B-143522 - Visibility of receiving mailbox & B-143523 - Language indicator on Case records]
    /**
* B-143522 - Visibility of receiving mailbox - since NA & MX users want the origin removed, EU has asked this value be stored in a new field for their reference
* B-143523 - Language indicator on Case records - EU would like to know the language of the case which can be determined by the email used to log the case
* B-161504 - Updated to only populate Received by Mailbox with Case Origin value when Case Origin contains "@"
*
* @Author  NTTD - Deborah Orth
* @Date    January 2019
*
* @param   List<Case> - the list of trigger new records in the buffer
* @return
**/
    public static void SaveReceivedEmailAddressAndSetLanguage( List<Case> tNew){
        Set<String> inboundEmailAddresses = new Set<String>();
        Map<String, String> emailLanguageMap = new Map<String, String>();

        //persist the Origin to the new field & get the distinct list of inbound email addresses in this block
        for( Case c : tNew){
            if(c.Origin.contains('@')) {
                c.Received_By_Mailbox__c = c.Origin;
                inboundEmailAddresses.add(c.Origin.toLowerCase());
            }
        }

        //do we need to do any language processing?
        if( inboundEmailAddresses.isEmpty()){
            return;
        }

        //build a map of email, (in lower case since both Label and MasterLabel fields seem to match on exact case),
        //to language from the inbound email list
        for( Received_By_Mailbox__mdt rbe : [SELECT Label, Language__c
        FROM Received_By_Mailbox__mdt
        WHERE Label IN :inboundEmailAddresses]){
            if( !emailLanguageMap.containsKey(rbe.Label.toLowerCase())){
                emailLanguageMap.put( rbe.Label.toLowerCase(), rbe.Language__c);
            }
        }

        //apply the correct language values to the case record
        for( Case c : tNew){
            if( emailLanguageMap.containsKey(c.Origin.toLowerCase())){
                c.Language_Indicator__c = emailLanguageMap.get(c.Origin.toLowerCase());
            }
        }
    }
}