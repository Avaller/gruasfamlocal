/// <summary>
/// tableextension 50083 "Contract/Service Discount_LDR"
/// </summary>
tableextension 50083 "Contract/Service Discount_LDR" extends "Contract/Service Discount"
{
    fields
    {
        field(50000; "Work type_LDR"; Code[20])
        {
            Caption = 'Tipo Trabajo';
            DataClassification = ToBeClassified;
            TableRelation = "Work Type"."Code";
        }
    }
}