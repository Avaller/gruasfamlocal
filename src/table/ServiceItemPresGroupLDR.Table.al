/// <summary>
/// Table Service Item Pres. Group_LDR (ID 50004)
/// </summary>
table 50004 "Service Item Pres. Group_LDR"
{
    Caption = 'Group Pres. Service Item';
    DataPerCompany = false;
    LookupPageID = "Service Item Pres. Group";

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Cod. Group Presentation';
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(3; "Group Type"; Option)
        {
            Caption = 'Group Type';
            OptionCaption = 'Crane,Platform';
            OptionMembers = Crane,Platform;
        }
        field(4; "Planner Colour"; Code[20])
        {
            Caption = 'Planner Colour';
        }
        field(5; "Planner Visible"; BoolEAN)
        {
            Caption = 'Planner Visible';
        }
        field(6; Subcontracted; BoolEAN)
        {
            Caption = 'Subcontracted';
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}