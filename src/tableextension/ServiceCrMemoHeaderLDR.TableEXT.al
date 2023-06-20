/// <summary>
/// tableextension 50089 "Service Cr.Memo Header_LDR"
/// </summary>
tableextension 50089 "Service Cr.Memo Header_LDR" extends "Service Cr.Memo Header"
{
    fields
    {
        field(50000; "Amount IncludingVAT2_LDR"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Service Cr.Memo Line"."Amount Including VAT" WHERE("Document No." = FIELD("No.")));
            Caption = 'Importe IVA Incluido';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50001; "External Document No._LDR"; Code[20])
        {
            Caption = 'Nº Documento Externo';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50002; "Send Document By Mail_LDR"; BoolEAN)
        {
            Caption = 'Enviar Documento por Mail';
            DataClassification = ToBeClassified;
        }
        field(50003; "Mail Status_LDR"; Option)
        {
            Caption = 'Estado Mail';
            DataClassification = ToBeClassified;
            OptionCaption = 'Pendiente,Enviando,Enviado';
            OptionMembers = Pending,Sending,Sended;
        }
        field(50004; "E-Mail Destination_LDR"; Text[250])
        {
            Caption = 'E-mail de Destino';
            DataClassification = ToBeClassified;
            ExtendedDatatype = EMail;
        }
    }

    keys
    {
        key(Key7; "Customer No.", "Posting Date")
        {

        }
    }
}