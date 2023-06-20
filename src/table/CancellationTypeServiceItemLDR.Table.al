/// <summary>
/// Table Cancellat Type Servic Item_LDR (ID 50001)
/// </summary>
table 50001 "Cancellat Type Servic Item_LDR"
{
    Caption = 'Cancellation Type Service Item';
    DataPerCompany = false;
    LookupPageID = "Service Item Cancellation Type";

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Cod. Low Type';
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description Low Type';
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