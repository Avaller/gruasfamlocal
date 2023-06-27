/// <summary>
/// tableextension 50028 "Purch. Cr. Memo Hdr._LDR"
/// </summary>
tableextension 50028 "Purch. Cr. Memo Hdr._LDR" extends "Purch. Cr. Memo Hdr."
{
    fields
    {
        field(50000; "Vendor Contract No._LDR"; Code[20])
        {
            Caption = 'Nº Contrato Proveedor';
            DataClassification = ToBeClassified;
            Editable = false;
            //TableRelation = Table70072.Field1 WHERE (Field2=CONST(1)); 
        }
    }
}