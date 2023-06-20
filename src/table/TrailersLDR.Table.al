/// <summary>
/// Table Trailers_LDR (ID 50003)
/// </summary>
table 50003 Trailers_LDR
{
    Caption = 'Trailers';
    DataPerCompany = false;
    LookupPageID = "Trailers";

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Cod. Towing';
        }
        field(2; Description; Text[50])
        {
            Caption = 'Desciption Towing';
        }
        field(4; Length; Decimal)
        {
            Caption = 'Lenght';
        }
        field(5; Width; Decimal)
        {
            Caption = 'Width';
        }
        field(6; "Bed Height"; Decimal)
        {
            Caption = 'Bed Height';
        }
        field(7; "Neck Height"; Decimal)
        {
            Caption = 'Neck Height';
        }
        field(8; "Distance Between Axis 1-2"; Decimal)
        {
            Caption = 'Distance Between Axis (1-2)';
        }
        field(9; "Distance Between Axis 2-3"; Decimal)
        {
            Caption = 'Distance Between Axis (2-3)';
        }
        field(10; "Distance Between Axis 3-4"; Decimal)
        {
            Caption = 'Distance Between Axis (3-4)';
        }
        field(11; "Distance Between Axis 4-5"; Decimal)
        {
            Caption = 'Distance Between Axis (4-5)';
        }
        field(12; "Distance Between Axis 5-6"; Decimal)
        {
            Caption = 'Distance Between Axis (5-6)';
        }
        field(13; "Fifth wheel Distance"; Decimal)
        {
            Caption = 'Fifth Wheel Distance To Last Axis';
        }
        field(14; Overhang; Decimal)
        {
            Caption = 'Overhang';
        }
        field(15; "Rear Overhang"; Decimal)
        {
            Caption = 'Rear Overhang';
        }
        field(16; Tare; Decimal)
        {
            Caption = 'Tare';
        }
        field(17; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Gondola,Platform';
            OptionMembers = Gondola,Platform;
        }
        field(18; "Max Charge"; Decimal)
        {
            Caption = 'Max Charge';
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

    trigger OnDelete()
    var
        TowingAllocation: Record "Trailer Allocation_LDR";
        errorre: Label 'There are associated Towing';
    begin
        //Si tiene algun registro mensaje de error
        CLEAR(TowingAllocation);
        TowingAllocation.SETRANGE("Towing Code", Code);
        IF TowingAllocation.FINDFIRST THEN
            ERROR(errorre);
    end;
}