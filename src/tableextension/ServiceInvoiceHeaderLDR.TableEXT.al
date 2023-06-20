/// <summary>
/// tableextension 50087 "Service Invoice Header_LDR"
/// </summary>
tableextension 50087 "Service Invoice Header_LDR" extends "Service Invoice Header"
{
    fields
    {
        field(50050; "Crane Service Quote No._LDR"; Code[20])
        {
            Caption = 'Código Oferta Servicio Grúa';
            DataClassification = ToBeClassified;
            //TableRelation = "Crane Service Quote Header"."Quote no." WHERE ("Historical"=CONST(false)); //TODO: Revisar si conservamos la tabla
        }
        field(50057; "Customer Order No._LDR"; Code[20])
        {
            Caption = 'Nº Pedido Cliente';
            DataClassification = ToBeClassified;
        }
        /*field(50058; "Direct Debit Mandate ID_LDR"; Code[35])
        {
            Caption = 'ID de Orden de Domiciliación de Adeudo Directo';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "SEPA Direct Debit Mandate" WHERE("Customer No." = FIELD("Bill-to Customer No."),
            "Closed" = CONST(false), "Blocked" = CONST(false));
        }*/
        field(50059; "External Document No._LDR"; Code[20])
        {
            Caption = 'Nº Documento Externo';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50060; "Send Document By Mail_LDR"; BoolEAN)
        {
            Caption = 'Enviar Documento por Mail';
            DataClassification = ToBeClassified;
        }
        field(50061; "Mail Status_LDR"; Option)
        {
            Caption = 'Estado Mail';
            DataClassification = ToBeClassified;
            OptionCaption = 'Pendiente,Enviando,Enviado';
            OptionMembers = Pending,Sending,Sended;
        }
        field(50062; "E-Mail Destination_LDR"; Text[250])
        {
            Caption = 'E-mail de Destino';
            DataClassification = ToBeClassified;
            ExtendedDatatype = EMail;
        }
        field(50063; Replicate_LDR; BoolEAN) //TODO: Revisar warning del atributo CalcFormula del field
        {
            //CalcFormula = Exist("Service Invoice Line" WHERE("Customer No." = FIELD("Customer No."), "Document No." = FIELD("No."), "Replicate" = CONST(true), "Replicate Company" = FIELD("CompanyFilter"))); //TODO: Revisar si conservamos el atributo CalcFormula
            Caption = 'Replicar';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50064; "Replicate Pending_LDR"; BoolEAN) //TODO: Revisar warning del atributo CalcFormula del field
        {
            //CalcFormula = Exist("Service Invoice Line" WHERE("Customer No." = FIELD("Customer No."), "Document No." = FIELD("No."), "Replicate" = CONST(true), "Replicated" = CONST(false), "Replicate Company" = FIELD("CompanyFilter"))); //TODO: Revisar si conservamos el atributo CalcFormula
            Caption = 'Pendiente Replicar';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50065; CompanyFilter_LDR; Text[30])
        {
            FieldClass = FlowFilter;
        }
    }

    keys
    {
        key(Key8; "Customer No.", "Posting Date")
        {

        }
    }

    trigger OnAfterModify()
    begin
        if "Send Document By Mail_LDR" then
            TestField("E-Mail Destination_LDR");
    end;
}