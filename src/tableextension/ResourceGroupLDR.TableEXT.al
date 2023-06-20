/// <summary>
/// tableextension 50030 "Resource Group_LDR"
/// </summary>
tableextension 50030 "Resource Group_LDR" extends "Resource Group"
{
    fields
    {
        field(50000; "Base Calendar Code_LDR"; Code[10])
        {
            Caption = 'Código Calendario Base';
            DataClassification = ToBeClassified;
            TableRelation = "Base Calendar";
        }
    }
}