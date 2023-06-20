/// <summary>
/// Table Service Item Subtype_LDR (ID 50009)
/// </summary>
table 50009 "Service Item Subtype_LDR"
{
    Caption = 'Service Item SubType';
    DataPerCompany = false;
    LookupPageID = "Service Item Subtype";

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            TableRelation = "Service Item Type_LDR";
        }
        field(2; "Service Item Subtype Code"; Code[10])
        {
            Caption = 'Service Item Subtype Code';
        }
        field(3; Description; Text[50])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(Key1; "Code", "Service Item Subtype Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}