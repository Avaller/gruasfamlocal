/// <summary>
/// tableextension 50026 "Purch. Inv. Header_LDR"
/// </summary>
tableextension 50026 "Purch. Inv. Header_LDR" extends "Purch. Inv. Header"
{
    fields
    {
        field(50000; "Machine Purchase Document_LDR"; BoolEAN)
        {
            Caption = 'Compra de Máquina';
            DataClassification = ToBeClassified;
            Description = 'Determina si se trata de una Compra de una Máquina';
        }
        field(50001; "Sended to AS400_LDR"; BoolEAN)
        {
            Caption = 'Enviado a AS400';
            DataClassification = ToBeClassified;
            Description = 'AS400';
            Editable = false;
        }
        field(50002; Resupply_LDR; BoolEAN)
        {
            Caption = 'Reaprovisionamiento';
            DataClassification = ToBeClassified;
            Description = 'AS400';
            Editable = false;
        }
        field(50003; "Vendor Contract No._LDR"; Code[20])
        {
            Caption = 'Nº Contrato Proveedor';
            DataClassification = ToBeClassified;
            Editable = false;
            //TableRelation = Table70072.Field1 WHERE (Field2=CONST(1)); //TODO: Revisar si conservamos la tabla
        }
    }
}