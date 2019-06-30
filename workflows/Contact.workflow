<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Change_record_type</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Not_Google</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Change record type</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Include_google_button</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Sales</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Include google button</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Include google button</fullName>
        <actions>
            <name>Include_google_button</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contact.Inactive__c</field>
            <operation>notEqual</operation>
            <value>Retired,Resigned,Terminated</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Not Include google button</fullName>
        <actions>
            <name>Change_record_type</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contact.Inactive__c</field>
            <operation>equals</operation>
            <value>Retired,Resigned,Terminated</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
