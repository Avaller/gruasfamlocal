/// <summary>
/// Table Expected Expenditures_LDR (ID 50033)
/// </summary>
table 50033 "Expected Expenditures_LDR"
{
    Caption = 'Expected Expenditures';

    fields
    {
        field(1; "Forecast Code"; Code[20])
        {
            Caption = 'Forecast Code';
        }
        field(2; "Quote number"; Integer)
        {
            Caption = 'Quote number';
        }
        field(3; "Payment date"; Date)
        {
            Caption = 'Payment date';
        }
        field(4; "Net amount"; Decimal)
        {
            Caption = 'Net amount';
        }
        field(5; "VAT posting group"; Code[10])
        {
            Caption = 'VAT %';
            TableRelation = "VAT Product Posting Group";
        }
        field(6; "VAT amount"; Decimal)
        {
            Caption = 'VAT amount';
        }
        field(7; "VAT base amount"; Decimal)
        {
            Caption = 'VAT base amount';
        }
        field(8; "Financial burden"; Decimal)
        {
            Caption = 'Financial burden';
        }
        field(9; "Payment amount"; Decimal)
        {
            Caption = 'Payment amount';
        }
        field(10; Generated; BoolEAN)
        {
            Caption = 'Generated';
        }
    }

    keys
    {
        key(Key1; "Forecast Code", "Quote number")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}