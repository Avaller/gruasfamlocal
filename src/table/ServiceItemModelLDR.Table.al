/// <summary>
/// Table Service Item Model_LDR (ID 50007)
/// </summary>
table 50007 "Service Item Model_LDR"
{
    Caption = 'Mod. Service Item';
    DataPerCompany = false;
    LookupPageID = "Service Item Model";

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Manufacturer Code';
            TableRelation = Manufacturer;
        }
        field(2; "Model Code"; Code[10])
        {
            Caption = ' Model Code';
        }
        field(3; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(4; Tonnage; Decimal)
        {
            Caption = 'Tonnage';
        }
        field(5; "Working Height"; Decimal)
        {
            Caption = 'Working Height';
        }
    }

    keys
    {
        key(Key1; "Code", "Model Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        ServiceItemBreakdown: Record "Service Item Breakdown_LDR";
    begin
        //RQ19.23.069   MSOPENA   16/06/2020
        ServiceItemBreakdown.SETRANGE(Code, Code);
        ServiceItemBreakdown.SETRANGE("Model No.", "Model Code");
        ServiceItemBreakdown.DELETEALL(TRUE);
        //----------------------------------
    end;
}