/// <summary>
/// Table Change Dimens Servic Entry_LDR (ID 50210)
/// </summary>
table 50210 "Change Dimens Servic Entry_LDR"
{
    Caption = 'Change Dimension Service Entry';

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = ' ,Item,Resource,Cost';
            OptionMembers = " ",Resource,Item,Cost;
        }
        field(4; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(5; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(6; "Old Work Type Code"; Code[10])
        {
            Caption = 'Work Type Code';
            TableRelation = "Work Type";
        }
        field(7; "New Work Type Code"; Code[10])
        {
            Caption = 'Work Type Code';
            TableRelation = "Work Type";
        }
        field(8; USER; Code[20])
        {
            Caption = 'User';
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.", Type, USER)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}