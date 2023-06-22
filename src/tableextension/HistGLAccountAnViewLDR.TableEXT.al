/// <summary>
/// tableextension 50118 "Hist. G/L Acc (An. View)_LDR"
/// </summary>
tableextension 50118 "Hist. G/L Acc (An. View)_LDR" extends "Hist. G/L Account (An. View)"
{
    fields
    {
        field(12; Comment; Boolean)
        {
            Caption = 'Comment';
            FieldClass = FlowField;
            CalcFormula = Exist("Comment Line" WHERE("Table Name" = CONST(24), "No." = FIELD("No.")));
            Editable = false;
        }
    }
}