/// <summary>
/// Table Alarms Log_LDR (ID 50222)
/// </summary>
table 50222 "Alarms Log_LDR"
{
    // UPG2016 23/12/2015 1CF_RPB Field 'User ID' Code20 -> Code50

    Caption = 'Alarms Log';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "Alarm No."; Integer)
        {
            Caption = 'Alarm No.';
            TableRelation = "Alarms_LDR"."Alarm No.";
        }
        field(3; Date; Date)
        {
            Caption = 'Date';
        }
        field(4; Time; Time)
        {
            Caption = 'Time';
        }
        field(5; "User ID"; Code[50])
        {
            Caption = 'User ID';
            Description = 'UPG2016';
        }
        field(6; "Action"; Option)
        {
            Caption = 'Action Realiced';
            OptionCaption = 'Accepted,Rejected';
            OptionMembers = Accepted,Rejected;
        }
        field(7; "Source table No."; Integer)
        {
            Caption = 'Source Table No.';
            TableRelation = Object.ID WHERE(Type = CONST(Table));

            trigger OnValidate()
            var
                "Object": Record "Object";
            begin
                IF "Source table No." <> 0 THEN BEGIN
                    Object.GET(Object.Type::Table, '', "Source table No.");
                    Object.CALCFIELDS(Caption);
                    "Source Table Caption" := Object.Caption;
                END ELSE BEGIN
                    "Source Table Caption" := '';
                END;
            end;
        }
        field(8; "Source Table Caption"; Text[250])
        {
            Caption = 'Source';
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Alarm No.", Date, Time)
        {
        }
    }

    fieldgroups
    {
    }
}