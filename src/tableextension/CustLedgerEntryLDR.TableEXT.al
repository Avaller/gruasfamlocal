/// <summary>
/// tableextension 50004 "Cust. Ledger Entry_LDR"
/// </summary>
tableextension 50004 "Cust. Ledger Entry_LDR" extends "Cust. Ledger Entry"
{
    fields
    {
        field(50000; "Accepted"; Option)
        {
            CalcFormula = Lookup("Cartera Doc.".Accepted WHERE("Entry No." = FIELD("Entry No.")));
            Caption = 'Aceptado';
            Description = 'Determina si el Documento en Cartera esta aceptado';
            Editable = false;
            FieldClass = FlowField;
            OptionCaption = 'Innecesario,Si,No';
            OptionMembers = "Not Required",Yes,No;
        }
    }
}