/// <summary>
/// tableextension 50016 "BOM Component_LDR"
/// </summary>
tableextension 50016 "BOM Component_LDR" extends "BOM Component"
{
    fields
    {
        field(50000; Blocked_LDR; Boolean)
        {
            CalcFormula = Lookup(Item.Blocked WHERE("No." = FIELD("No.")));
            Caption = 'Bloqueado';
            Description = 'Refleja si el Producto está Bloqueado en su Ficha';
            FieldClass = FlowField;
        }
    }

}