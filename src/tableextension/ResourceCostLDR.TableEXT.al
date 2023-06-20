/// <summary>
/// tableextension 50109 "Resource Cost_LDR"
/// </summary>
tableextension 50109 "Resource Cost_LDR" extends "Resource Cost"
{
    fields
    {
        field(50000; "Unit of Measure Code_LDR"; Code[20])
        {
            Caption = 'Unidad de Medida';
            DataClassification = ToBeClassified;
            TableRelation = "Unit of Measure";
        }
    }
}