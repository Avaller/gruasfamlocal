/// <summary>
/// Table Expenses Concepts_LDR (ID 50034)
/// </summary>
table 50034 "Expenses Concepts_LDR"
{
    Caption = 'Expenses Concepts';

    fields
    {
        field(1; "Forecast Code"; Code[20])
        {
            Caption = 'Forecast Code';
        }
        field(2; Number; Integer)
        {
            Caption = 'Number';
        }
        field(3; Concept; Text[50])
        {
            Caption = 'Concept';
        }
        field(4; Observations; Text[250])
        {
            Caption = 'Observations';
        }
        field(5; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(6; "Accounting account"; Code[20])
        {
            Caption = 'Accounting Account';
            TableRelation = "G/L Account";
        }
    }

    keys
    {
        key(Key1; "Forecast Code", Number)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}