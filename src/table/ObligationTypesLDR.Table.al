/// <summary>
/// Table Obligation Types_LDR (ID 50032)
/// </summary>
table 50032 "Obligation Types_LDR"
{
    Caption = 'Obligation Types';

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
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
}