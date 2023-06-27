/// <summary>
/// tableextension 50052 "Resource Price Change_LDR"
/// </summary>
tableextension 50052 "Resource Price Change_LDR" extends "Resource Price Change"
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