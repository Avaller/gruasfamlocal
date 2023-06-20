/// <summary>
/// tableextension 50017 "User Setup_LDR"
/// </summary>
tableextension 50017 "User Setup_LDR" extends "User Setup"
{
    fields
    {
        field(50001; "Order planner Res. Ctr. Filter_LDR"; Code[10])
        {
            Caption = 'Filtro Centro Responsable Planificador';
            DataClassification = ToBeClassified;
            TableRelation = "Responsibility Center";
        }
    }
}