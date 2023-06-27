/// <summary>
/// tableextension 50033 "Resource Price_LDR"
/// </summary>
tableextension 50033 "Resource Price_LDR" extends "Resource Price"
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