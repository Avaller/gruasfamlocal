/// <summary>
/// Table Purchase Discounts Groups_LDR (ID 50225)
/// </summary>
table 50225 "Purchase Discounts Groups_LDR"
{
    DataPerCompany = false;

    fields
    {
        field(1; "Vendor No"; Code[20])
        {
            Caption = 'Vendor No.';
            TableRelation = "Vendor"."No.";
        }
        field(2; "Discount Group"; Code[10])
        {
            Caption = 'Discount Group';
        }
        field(3; "Discount %"; Decimal)
        {
            Caption = '% Discount';
        }
        field(4; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
        }
        field(5; "Finish Date"; Date)
        {
            Caption = 'Finish Date';
        }
    }

    keys
    {
        key(Key1; "Vendor No", "Discount Group", "Starting Date")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}