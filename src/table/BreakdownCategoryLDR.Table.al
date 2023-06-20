/// <summary>
/// Table Breakdown Category_LDR (ID 50002)
/// </summary>
table 50002 "Breakdown Category_LDR"
{
    Caption = 'Breakdown Category';
    DataPerCompany = false;
    LookupPageID = "Breakdown Category";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Cod. Breakdown Category';
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
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
        BreakdownSubcategory: Record "Breakdown Subcategory_LDR";
    begin
        CLEAR(BreakdownSubcategory);
        BreakdownSubcategory.SETFILTER(Code, Code);
        BreakdownSubcategory.DELETEALL(TRUE);
    end;
}