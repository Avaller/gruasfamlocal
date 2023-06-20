/// <summary>
/// Table Service Item Invoice Group_LDR (ID 50005)
/// </summary>
table 50005 "Service Item Invoice Group_LDR"
{
    Caption = 'Group Invoice Service Item';
    DataPerCompany = false;
    LookupPageID = "Service Item Invoice Group";

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Group Invoice Code';
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(3; "Average Speed"; Integer)
        {
            Caption = 'Average Speed';
        }
        field(4; "Group Type"; Option)
        {
            Caption = 'Group Type';
            OptionCaption = 'Crane,Platform';
            OptionMembers = Crane,Platform;
        }
        field(5; "Rate Type"; Option)
        {
            Caption = 'Rate Type';
            OptionCaption = 'Crane < 100,Crane > 100,Crane-Truck,Truck,Platform';
            OptionMembers = "crane-100","crane+100",cranetruck,truck,platform;
        }
        field(6; "Print Order"; Integer)
        {
            BlankZero = true;
            Caption = 'Print Order';
            MinValue = 0;
        }
        field(7; Height; Text[10])
        {
            Caption = 'Height/Jib';
        }
        field(8; Branch; Code[30])
        {
            Caption = 'Branch';
        }
        field(9; Model; Code[30])
        {
            Caption = 'Model';
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
        key(Key2; "Print Order")
        {
        }
    }

    fieldgroups
    {
    }
}