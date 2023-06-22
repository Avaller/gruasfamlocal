/// <summary>
/// tableextension 50116 "Historic G/L Account_LDR"
/// </summary>
tableextension 50116 "Historic G/L Account_LDR" extends "Historic G/L Account"
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