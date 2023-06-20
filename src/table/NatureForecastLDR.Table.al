/// <summary>
/// Table Nature Forecast_LDR (ID 50031)
/// </summary>
table 50031 "Nature Forecast_LDR"
{
    Caption = 'Nature Forecast';

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