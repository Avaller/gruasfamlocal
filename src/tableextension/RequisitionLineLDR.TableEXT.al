/// <summary>
/// tableextension 50042 "Requisition Line_LDR"
/// </summary>
tableextension 50042 "Requisition Line_LDR" extends "Requisition Line"
{
    fields
    {
        field(50000; Notas1_LDR; Text[100])
        {
            Caption = 'Notas';
            DataClassification = ToBeClassified;
        }
    }
}