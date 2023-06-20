/// <summary>
/// tableextension 50091 "Sales Line Discount_LDR"
/// </summary>
tableextension 50091 "Sales Line Discount_LDR" extends "Sales Line Discount" //TODO: Revisar warning de la extends de la tableextension
{
    fields
    {
        field(50000; "Work Type Code"; Code[10])
        {
            Caption = 'Código Tipo Trabajo';
            DataClassification = ToBeClassified;
            TableRelation = "Work Type";
        }
    }
}