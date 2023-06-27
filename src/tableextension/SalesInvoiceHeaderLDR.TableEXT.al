/// <summary>
/// tableextension 50020 "Sales Invoice Header_LDR"
/// </summary>
tableextension 50020 "Sales Invoice Header_LDR" extends "Sales Invoice Header"
{
    fields
    {
        field(50000; "Send Document By Mail_LDR"; Boolean)
        {
            Caption = 'Enviar Documento por Mail';
            DataClassification = ToBeClassified;
        }
        field(50001; "Mail Status_LDR"; Option)
        {
            Caption = 'Estado Mail';
            DataClassification = ToBeClassified;
            OptionCaption = 'Pendiente,Enviando,Enviado';
            OptionMembers = Pending,Sending,Sended;
        }
        field(50002; "E-Mail Destination_LDR"; Text[250])
        {
            Caption = 'E-mail de Destino';
            DataClassification = ToBeClassified;
            ExtendedDatatype = EMail;
        }
    }

    keys
    {
        key(Key14; "Sell-to Customer No.", "Posting Date")
        {
        }
    }

    trigger OnBeforeModify()
    begin
        if "Send Document By Mail_LDR" then
            TestField("E-Mail Destination_LDR");
    end;
}