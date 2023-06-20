/// <summary>
/// Table Empl. Graph. Just. Detail_LDR (ID 50052)
/// </summary>
table 50052 "Empl. Graph. Just. Detail_LDR"
{
    fields
    {
        field(1; "entry no"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; ID; Integer)
        {
        }
        field(3; "ID Description"; Text[30])
        {
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
        field(6; Time; DateTime)
        {
        }
        field(7; StartTime; DateTime)
        {
        }
        field(8; EndTime; DateTime)
        {
        }
        field(9; TimeText; Text[20])
        {
        }
        field(10; StartTimeText; Text[20])
        {
        }
        field(11; EndTimeText; Text[20])
        {
        }
        field(12; InnerText; Text[30])
        {
        }
        field(13; BubbleText; Text[150])
        {
        }
        field(14; TextColor; Code[10])
        {
        }
        field(15; LineColor; Code[10])
        {
        }
    }

    keys
    {
        key(Key1; "entry no")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}