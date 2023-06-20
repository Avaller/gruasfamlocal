/// <summary>
/// Table Alarms_LDR (ID 50221)
/// </summary>
table 50221 Alarms_LDR
{
    // UPG2016 20/01/2016 1CF_MGF Field "User ID" code 20 to code 50

    Caption = 'Alarms';
    LookupPageID = "Alarm List";

    fields
    {
        field(1; "Alarm No."; Integer)
        {
            Caption = 'Alarm No.';
            Editable = false;
        }
        field(2; "Start Date"; Date)
        {
            Caption = 'Start Date';

            trigger OnValidate()
            begin
                TestDates();
            end;
        }
        field(3; "End Date"; Date)
        {
            Caption = 'End Date';

            trigger OnValidate()
            begin
                TestDates();
            end;
        }
        field(4; "Message Type"; Option)
        {
            Caption = 'Message Type';
            OptionCaption = 'Warning,Error';
            OptionMembers = Warning,Error;
        }
        field(5; "Source Type"; Option)
        {
            Caption = 'Source Type';
            OptionCaption = 'Customer,Vendor,Service Item,Contract';
            OptionMembers = Customer,Vendor,"Service Item",Contract;

            trigger OnValidate()
            begin
                IF "Source Type" <> xRec."Source Type" THEN InitChecks;
                VALIDATE("Source No.", '');
                VALIDATE("Source No. 2", '');
            end;
        }
        field(6; "Source No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = IF ("Source Type" = CONST("Customer")) "Customer"."No."
            ELSE
            IF ("Source Type" = CONST("Vendor")) "Vendor"."No."
            ELSE
            IF ("Source Type" = CONST("Service Item")) "Service Item"."No."
            ELSE
            IF ("Source Type" = CONST("Contract")) "Service Contract Header"."Contract No."
                            WHERE("Contract Type" = CONST("Contract"));

            trigger OnValidate()
            var
                Customer: Record "Customer";
                Vendor: Record "Vendor";
                ServiceItem: Record "Service Item";
                Contract: Record "Service Contract Header";
            begin

                VALIDATE("Source No. 2", '');
                IF "Source No." <> '' THEN BEGIN
                    CASE "Source Type" OF
                        "Source Type"::Customer:
                            BEGIN
                                Customer.GET("Source No.");
                                VALIDATE("Source Description", Customer.Name);
                            END;
                        "Source Type"::Vendor:
                            BEGIN
                                Vendor.GET("Source No.");
                                VALIDATE("Source Description", Vendor.Name);
                            END;
                        "Source Type"::"Service Item":
                            BEGIN
                                ServiceItem.GET("Source No.");
                                VALIDATE("Source Description", ServiceItem.Description);
                            END;
                        "Source Type"::Contract:
                            BEGIN
                                Contract.GET(Contract."Contract Type"::Contract, "Source No.");
                                VALIDATE("Source Description", Contract.Description);
                            END;
                    END;
                END ELSE BEGIN
                    VALIDATE("Source Description", '');
                END;
            end;
        }
        field(7; "Source No. 2"; Code[20])
        {
            Caption = 'Shipping No. 2';
            TableRelation = IF ("Source Type" = CONST("Customer")) "Ship-to Address"."Code" WHERE("Customer No." = FIELD("Source No."))
            ELSE
            IF ("Source Type" = CONST("Vendor")) "Order Address"."Code" WHERE("Vendor No." = FIELD("Source No."));

            trigger OnValidate()
            var
                ShipToAddr: Record "Ship-to Address";
                OrderAddr: Record "Order Address";
            begin
                IF "Source No. 2" <> '' THEN BEGIN
                    IF ("Source Type" <> "Source Type"::Customer) AND
                       ("Source Type" <> "Source Type"::Vendor) THEN
                        ERROR(txtType, FIELDCAPTION("Source Type"), "Source Type");

                    CASE "Source Type" OF
                        "Source Type"::Customer:
                            BEGIN
                                ShipToAddr.GET("Source No.", "Source No. 2");
                                VALIDATE("Source Description 2", ShipToAddr.Name);
                            END;
                        "Source Type"::Vendor:
                            BEGIN
                                OrderAddr.GET("Source No.", "Source No. 2");
                                VALIDATE("Source Description 2", OrderAddr.Name);
                            END;
                    END;
                END ELSE BEGIN
                    VALIDATE("Source Description 2", '');
                END;
            end;
        }
        field(8; Message; Text[250])
        {
            Caption = 'Message';
        }
        field(9; "User ID"; Code[50])
        {
            Caption = 'User ID';
            Description = 'UPG2016';
            Editable = false;
        }
        field(10; "Sales Quote"; BoolEAN)
        {
            Caption = 'Sales Quote';
        }
        field(11; "Sales Order"; BoolEAN)
        {
            Caption = 'Sales Order';
        }
        field(12; "Sales Invoice"; BoolEAN)
        {
            Caption = 'Sales Invoice';
        }
        field(13; "Sales Cr. Memo"; BoolEAN)
        {
            Caption = 'Sales Credit Memo';
        }
        field(14; "Purch. Quote"; BoolEAN)
        {
            Caption = 'Purchase Quote';
        }
        field(15; "Purch. Order"; BoolEAN)
        {
            Caption = 'Purchase Order';
        }
        field(16; "Purch. Invoice"; BoolEAN)
        {
            Caption = 'Purchase Invoice';
        }
        field(17; "Purch. Cr. Memo"; BoolEAN)
        {
            Caption = 'Purchase Credit Memo';
        }
        field(18; "Serv. Quote"; BoolEAN)
        {
            Caption = 'Service Quote';
        }
        field(19; "Serv. Order"; BoolEAN)
        {
            Caption = 'Service Order';
        }
        field(20; "Serv. Invoice"; BoolEAN)
        {
            Caption = 'Service Invoice';
        }
        field(21; "Serv. Cr. Memo"; BoolEAN)
        {
            Caption = 'Service Credit Memo';
        }
        field(22; "Serv. Contract"; BoolEAN)
        {
            Caption = 'Service Contract';
        }
        field(23; "Int. Serv. Contract"; BoolEAN)
        {
            Caption = 'Internal Contract';
        }
        field(24; "Message 2"; Text[250])
        {
            Caption = 'Message 2';
        }
        field(25; "Source Description"; Text[80])
        {
            Caption = 'Source Description';
            Editable = false;
        }
        field(26; "Source Description 2"; Text[80])
        {
            Caption = 'Source Description 2';
            Editable = false;
        }
        field(27; "Off on next use"; BoolEAN)
        {
            Caption = 'Off on next use';
        }
        field(28; "Serv. Shipment"; BoolEAN)
        {
            Caption = 'Service Shipment';
        }
    }

    keys
    {
        key(Key1; "Alarm No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        CLEAR(AlarmLogs);
        AlarmLogs.SETCURRENTKEY(AlarmLogs."Alarm No.", AlarmLogs.Date, AlarmLogs.Time);
        AlarmLogs.SETRANGE(AlarmLogs."Alarm No.", "Alarm No.");
        AlarmLogs.DELETEALL(TRUE);

        // BOrrar filtros
        /*CLEAR(AlarmFilters);
        AlarmFilters.SETRANGE(AlarmFilters."Alarm No.", "Alarm No.");
        AlarmFilters.DELETEALL(TRUE);*/
    end;

    trigger OnInsert()
    begin
        "User ID" := USERID;
    end;

    trigger OnModify()
    begin
        IF ("Source Type" <> xRec."Source Type") OR
           ("Source No." <> xRec."Source No.") OR
           ("Source No. 2" <> xRec."Source No. 2") THEN BEGIN
            // COmprobar si ya existen logs
            CLEAR(AlarmLogs);
            AlarmLogs.SETCURRENTKEY(AlarmLogs."Alarm No.", AlarmLogs.Date, AlarmLogs.Time);
            AlarmLogs.SETRANGE(AlarmLogs."Alarm No.", "Alarm No.");
            IF AlarmLogs.FINDFIRST THEN
                ERROR(txtLogs, "Alarm No.");

            //CheckFIltersExist;
        END;
    end;

    var
        AlarmLogs: Record "Alarms Log_LDR";
        txtType: Label '%1 cannot be %1';
        txtLogs: Label 'It is nos posible to modify Alarm No. %1 because it has linked logs. Delete alarm or create new one.';
    //AlarmFilters: Record 70071; 

    /// <summary>
    /// GetNextAlarmNo()
    /// </summary>
    procedure GetNextAlarmNo() NewAlarmNo: Integer
    var
        TempAlarm: Record "Alarms_LDR";
    begin
        IF TempAlarm.FINDLAST THEN;
        NewAlarmNo := TempAlarm."Alarm No." + 1;
    end;

    /// <summary>
    /// TestDates()
    /// </summary>
    procedure TestDates()
    var
        txtDates: Label '%1 cannot be lower than %2 in alarm No. %3';
    begin
        IF ("Start Date" <> 0D) AND ("End Date" <> 0D) THEN BEGIN
            IF "End Date" < "Start Date" THEN
                ERROR(txtDates, FIELDCAPTION("End Date"), FIELDCAPTION("Start Date"), "Alarm No.");
        END;
    end;

    /// <summary>
    /// InitChecks()
    /// </summary>
    procedure InitChecks()
    begin
        "Sales Quote" := FALSE;
        "Sales Order" := FALSE;
        "Sales Invoice" := FALSE;
        "Sales Cr. Memo" := FALSE;
        "Purch. Quote" := FALSE;
        "Purch. Order" := FALSE;
        "Purch. Invoice" := FALSE;
        "Purch. Cr. Memo" := FALSE;
        "Serv. Quote" := FALSE;
        "Serv. Order" := FALSE;
        "Serv. Invoice" := FALSE;
        "Serv. Cr. Memo" := FALSE;
        "Serv. Contract" := FALSE;
        "Int. Serv. Contract" := FALSE;
        "Serv. Shipment" := FALSE;
    end;

    /// <summary>
    /// CheckFIltersExist()
    /// </summary>
    /*procedure CheckFIltersExist()
    var
        AlarmFilters: Record 70071; 
        txtFilterExist: Label 'There is Alarm Filters that will be deleted. Continue?';
    begin
        CLEAR(AlarmFilters);
        AlarmFilters.SETRANGE(AlarmFilters."Alarm No.", "Alarm No.");
        IF AlarmFilters.FINDSET THEN BEGIN
            IF CONFIRM(txtFilterExist, FALSE) THEN BEGIN
                AlarmFilters.DELETEALL(TRUE);
            END ELSE BEGIN
                ERROR('');
            END;

        END;
    end;*/
}