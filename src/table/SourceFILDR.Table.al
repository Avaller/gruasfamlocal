/// <summary>
/// Table Source FI_LDR (ID 50209)
/// </summary>
table 50209 "Source FI_LDR"
{
    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; Description; Text[50])
        {
        }
        field(3; "Excel Column Cuadro"; Code[20])
        {
        }
        field(4; "Visible en Form. Cuadro"; BoolEAN)
        {
        }
        field(5; "Visible en Form. Rentabilidad"; BoolEAN)
        {
        }
        field(6; "Visible en Excel Cuadro"; BoolEAN)
        {
        }
        field(7; "Visible en Excel Rentabilidad"; BoolEAN)
        {
        }
        field(8; "Excel Column Rentabilidad"; Code[20])
        {
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