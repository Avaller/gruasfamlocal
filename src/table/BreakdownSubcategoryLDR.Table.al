/// <summary>
/// Table Breakdown Subcategory_LDR (ID 50010)
/// </summary>
table 50010 "Breakdown Subcategory_LDR"
{
    Caption = 'Breakdown Subcategory ';
    DataPerCompany = false;
    LookupPageID = "Breakdown Subcategory";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            TableRelation = "Breakdown Category_LDR";
        }
        field(2; Subcategory; Code[20])
        {
            Caption = 'Subcategory Code';
        }
        field(3; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(4; "Category Name"; Text[50])
        {
            CalcFormula = Lookup("Breakdown Category_LDR".Description WHERE(Code = FIELD(Code)));
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Code", Subcategory)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}