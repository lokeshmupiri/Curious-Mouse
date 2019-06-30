<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>rejected_mail</fullName>
        <ccEmails>kumarhemanth373@gmail.com</ccEmails>
        <description>rejected mail</description>
        <protected>false</protected>
        <recipients>
            <recipient>lokesh.mupiri@sfdc.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/SupportCaseAssignmentNotification</template>
    </alerts>
    <fieldUpdates>
        <fullName>approved</fullName>
        <field>status__c</field>
        <literalValue>approved</literalValue>
        <name>approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>rejected_update</fullName>
        <field>status__c</field>
        <literalValue>rejected</literalValue>
        <name>rejected update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>staus_update</fullName>
        <field>status__c</field>
        <literalValue>pending</literalValue>
        <name>staus update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
</Workflow>
