/// <summary>
/// Table Empl. Graph. Just. Setup_LDR (ID 50048)
/// </summary>
table 50048 "Empl. Graph. Just. Setup_LDR"
{
    Caption = 'Empl. Graph. Just. Setup';
    DrillDownPageID = "Empl. Graph. Just. Setup";
    LookupPageID = "Empl. Graph. Just. Setup";

    fields
    {
        field(1; "No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'No.';
        }
        field(2; Description; Text[30])
        {
            Caption = 'Description';
        }
        field(3; Enabled; BoolEAN)
        {
            Caption = 'Enabled';
        }
        field(4; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Marking Entries,Internal Works,Service Works,Crane Displacements,Vehicle Displacements,External Works,Lunch Time';
            OptionMembers = Marking,InternalWork,ServiceWork,CraneDisplacement,VehicleDisplacement,ExternalWork,LunchTime;
        }
        field(5; Color; Code[10])
        {
            Caption = 'Color';
        }
        field(6; TextColor; Code[10])
        {
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}