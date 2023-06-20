/// <summary>
/// tableextension 50036 "Resource Unit of Measure_LDR"
/// </summary>
tableextension 50036 "Resource Unit of Measure_LDR" extends "Resource Unit of Measure"
{
    fields
    {
        field(50001; "UOM Description_LDR"; Text[50])
        {
            CalcFormula = Lookup("Unit of Measure".Description WHERE(Code = FIELD(Code)));
            Caption = 'Descripción';
            Editable = false;
            FieldClass = FlowField;
        }
    }
}