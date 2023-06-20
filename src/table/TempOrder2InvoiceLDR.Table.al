/// <summary>
/// Table TempOrder2Invoice_LDR (ID 50029)
/// </summary>
table 50029 TempOrder2Invoice_LDR
{
    fields
    {
        field(1; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Order No."; Code[20])
        {
        }
        field(3; "No."; Code[20])
        {
        }
        field(4; "Work Type Code"; Code[10])
        {
        }
        field(5; UOM; Code[10])
        {
        }
        field(6; Qty; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Line No")
        {
            Clustered = true;
        }
        key(Key2; "Order No.", "Work Type Code")
        {
            SumIndexFields = Qty;
        }
    }

    fieldgroups
    {
    }
}