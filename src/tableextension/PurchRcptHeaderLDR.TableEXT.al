/// <summary>
/// tableextension 50024 "Purch. Rcpt. Header_LDR"
/// </summary>
tableextension 50024 "Purch. Rcpt. Header_LDR" extends "Purch. Rcpt. Header"
{
    fields
    {
        field(50000; "Machine Purchase Document_LDR"; BoolEAN)
        {
            Caption = 'Compra de Máquina';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50001; "Machine Status_LDR"; Option)
        {
            Caption = 'Estado de la Máquina';
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Pendiente Montaje,Orden Montaje Adjudicada,Montaje Realizado';
            OptionMembers = Pending,"Service Order",Mounted;
        }
        field(50002; "Sended to AS400_LDR"; BoolEAN)
        {
            Caption = 'Enviado a AS400';
            DataClassification = ToBeClassified;
            Description = 'AS400';
            Editable = false;
        }
        field(50003; Resupply_LDR; BoolEAN)
        {
            Caption = 'Reaprovisionamiento';
            DataClassification = ToBeClassified;
            Description = 'AS400';
            Editable = false;
        }
        field(50004; Notas1_LDR; Text[100])
        {
            Caption = 'Notas';
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }
}