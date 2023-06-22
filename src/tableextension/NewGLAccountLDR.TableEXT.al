/// <summary>
/// tableextension 50117 "New G/L Account_LDR"
/// </summary>
tableextension 50117 "New G/L Account_LDR" extends "New G/L Account"
{
    fields
    {
        field(12; Comment; Boolean)
        {
            Caption = 'Comment';
            FieldClass = FlowField;
            CalcFormula = Exist("Comment Line" WHERE("Table Name" = CONST("Historic G/L Account"), "No." = FIELD("No.")));
            Editable = false;
        }
    }
}