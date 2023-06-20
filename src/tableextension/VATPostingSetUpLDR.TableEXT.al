/// <summary>
/// tableextension 50051 "VAT Posting Setup_LDR"
/// </summary>
tableextension 50051 "VAT Posting Setup_LDR" extends "VAT Posting Setup"
{
    fields
    {
        field(50000; "VAT Text_LDR"; Text[20])
        {
            Caption = 'Nombre Impuesto';
            DataClassification = ToBeClassified;
        }
    }
}