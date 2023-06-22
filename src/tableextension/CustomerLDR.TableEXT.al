/// <summary>
/// tableextension 50003 "Customer_LDR"
/// </summary>
tableextension 50003 "Customer_LDR" extends "Customer"
{
    fields
    {
        field(50000; "Ingestrel Export_LDR"; Boolean)
        {
            Caption = 'Exportar a Ingestrel';
            DataClassification = ToBeClassified;
        }
        field(50001; "Creation Date_LDR"; Date)
        {
            Caption = 'Fecha de Alta';
            DataClassification = ToBeClassified;
        }
        field(50002; "Ingestrel Export Date_LDR"; Date)
        {
            Caption = 'Fecha Exportación Ingestrel';
            DataClassification = ToBeClassified;
        }
        field(50003; "Last Export Date_LDR"; Date)
        {
            Caption = 'Fecha Última Exportación';
            DataClassification = ToBeClassified;
        }
        field(50004; "Invoice Period_LDR"; Option)
        {
            Caption = 'Período Facturación';
            DataClassification = ToBeClassified;
            InitValue = Fortnightly;
            OptionCaption = 'Mensual,Quincenal';
            OptionMembers = Monthly,Fortnightly;
        }
        field(50005; "Days Until Report_LDR"; Integer)
        {
            Caption = 'Días Hasta Parte';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Days Until Report_LDR" > 30 then
                    "Days Until Report_LDR" := 30;
                if "Days Until Report_LDR" < 0 then
                    "Days Until Report_LDR" := 1;
            end;
        }
        field(50006; "Invoicing Type_LDR"; Option)
        {
            Caption = 'Tipo Facturación';
            DataClassification = ToBeClassified;
            InitValue = 4;
            OptionCaption = 'Obra,Oferta,Independiente,Pedido';
            OptionMembers = Work,Offer,Standalone,Order;
        }
        field(50007; "Old Customer No._LDR"; Code[20])
        {
            Caption = 'Nº Cliente Antiguo';
            DataClassification = ToBeClassified;
        }
        field(50008; "Internal Customer_LDR"; Boolean)
        {
            Caption = 'Cliente Interno';
            DataClassification = ToBeClassified;
        }
        field(50009; "Last User Modified_LDR"; Code[50])
        {
            Caption = 'Usuario Última Modificación';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(50010; "Customer Vendor No._LDR"; Text[20])
        {
            Caption = 'Nº Proveedor Cliente';
            DataClassification = ToBeClassified;
            Description = 'Almacena el Nº Proveedor para el Cliente';
        }
        field(50011; "Group Serv. Contract Invoices_LDR"; Boolean)
        {
            Caption = 'Agrupar Facturas Contrato';
            DataClassification = ToBeClassified;
            Description = 'Determina si se agrupan las Facturas de Contrato Servicio';
        }
        field(50012; "Submit for Acceptance_LDR"; Boolean)
        {
            CalcFormula = Lookup("Payment Method"."Submit for Acceptance" WHERE(Code = FIELD("Payment Method Code")));
            Caption = 'Envío Al Acepto';
            Description = 'Envío al Acepto de la Forma de Pago';
            FieldClass = FlowField;
        }
        field(50013; "Financial Institution_LDR"; Boolean)
        {
            Caption = 'Entidad Financiera';
            DataClassification = ToBeClassified;
        }
        field(50014; "Serv Cont Payment Terms Code_LDR"; Code[10])
        {
            Caption = 'Código Términos Pago Contratos Servicio';
            DataClassification = ToBeClassified;
            TableRelation = "Payment Terms";
        }
        field(50015; "Serv Cont Payment Method Code_LDR"; Code[10])
        {
            Caption = 'Código Forma Pago Contratos Servicio';
            DataClassification = ToBeClassified;
            TableRelation = "Payment Method";
        }
        field(50016; "Serv Order Payment Terms Code_LDR"; Code[10])
        {
            Caption = 'Código Términos Pago Ofertas/Pedidos Servicio';
            DataClassification = ToBeClassified;
            TableRelation = "Payment Terms";
        }
        field(50017; "Serv Order Payment Method Code_LDR"; Code[10])
        {
            Caption = 'Código Forma Pago Ofertas/Pedidos Servicio';
            DataClassification = ToBeClassified;
            TableRelation = "Payment Method";
        }
        field(50018; "Sales Doc Payment Terms Code_LDR"; Code[10])
        {
            Caption = 'Código Términos Pago Ofertas/Documentos Ventas';
            DataClassification = ToBeClassified;
            TableRelation = "Payment Terms";
        }
        field(50019; "Sales Doc Payment Method Code_LDR"; Code[20])
        {
            Caption = 'Código Forma Pago Ofertas/Documentos Ventas';
            DataClassification = ToBeClassified;
            TableRelation = "Payment Method";
        }
        field(50020; "Service Customer Sales Code_LDR"; Code[10])
        {
            Caption = 'Código Ventas Cliente Servicio';
            DataClassification = ToBeClassified;
            TableRelation = "Standard Sales Code";
        }
        field(50021; "LINDE Distributor_LDR"; Code[10])
        {
            Caption = 'Código Concesionario LINDE';
            DataClassification = ToBeClassified;
        }
        field(50022; "Created Date_LDR"; DateTime)
        {
            Caption = 'Fecha Creación';
            DataClassification = ToBeClassified;
        }
        field(50023; "Modified Date_LDR"; DateTime)
        {
            Caption = 'Fecha Modificación';
            DataClassification = ToBeClassified;
        }
        field(50024; "Send Sales Documents By Mail_LDR"; Boolean)
        {
            Caption = 'Enviar Documentos de Venta Por Mail';
            DataClassification = ToBeClassified;
        }
        field(50025; "Sales E-Mail Destination_LDR"; Text[250])
        {
            Caption = 'E-Mail Destino Documentos Venta';
            ExtendedDatatype = EMail;
            DataClassification = ToBeClassified;
        }
        field(50026; "Send Service Documents By Mail_LDR"; Boolean)
        {
            Caption = 'Enviar Documentos de Servicio por Mail';
            DataClassification = ToBeClassified;
        }
        field(50027; "Service E-Mail Destination_LDR"; Text[250])
        {
            Caption = 'E-Mail Destino Documentos Servicio';
            ExtendedDatatype = EMail;
            DataClassification = ToBeClassified;
        }
        field(50028; "Rating Code_LDR"; Code[20])
        {
            Caption = 'Código de Calificación';
            DataClassification = ToBeClassified;
            TableRelation = "Rating Code_LDR";
        }
        field(50029; "Extranet Deletion_LDR"; Boolean)
        {
            Caption = 'Eliminar de Ingestrel';
            DataClassification = ToBeClassified;
        }
        modify("VAT Registration No.")
        {
            trigger OnBeforeValidate()
            var
                SalesSetup: Record "Sales & Receivables Setup";
                txtErrorCIF: Label 'Debe especificar un CIF/NIF válido';
            begin
                SalesSetup.Get();
                if (SalesSetup."CIF/NIF Obligatory") and (Rec."VAT Registration No." = '') and (Rec."No." <> '') then
                    Error(txtErrorCIF);
            end;
        }
    }

    fieldgroups
    {
        addlast(DropDown; "Search Name")
        { }
    }

    trigger OnAfterInsert()
    var
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
    begin
        SalesReceivablesSetup.Get;
        UpdateReferencedIds();
        SetLastModifiedDateTime();
        Rec."Created Date_LDR" := CurrentDateTime();
        Rec."Invoicing Type_LDR" := Rec."Invoicing Type_LDR"::Offer;
    end;

    trigger OnAfterModify()
    begin
        Rec."Last User Modified_LDR" := UserId;
        if IsContactUpdateNeeded() then begin
            Clear("Last Export Date_LDR");
        end;
        Rec."Modified Date_LDR" := CurrentDateTime;
    end;

    trigger OnAfterDelete()
    var
        PriceListLine: Record "Price List Line";
        SalesOrderLine: Record "Sales Line";
        Text50000: Label 'No puede borrar %1 %2 porque hay al menos una venta pendiente %3 para este cliente en la empresa %4';
    begin
        PriceListLine.SetRange("Source Type", PriceListLine."Source Type"::Customer);
        PriceListLine.SetRange("Price List Code", "No.");
        PriceListLine.DeleteAll();

        SalesOrderLine.SetCurrentKey("Document Type", "Bill-to Customer No.");
        SalesOrderLine.SetFilter("Document Type", '%1|%2', SalesOrderLine."Document Type"::Order, SalesOrderLine."Document Type"::"Return Order");
        SalesOrderLine.SetRange("Bill-to Customer No.", "No.");
        if SalesOrderLine.FindFirst then
            Error(Text50000, TableCaption, "No.", SalesOrderLine."Document Type", CompanyName);
    end;

    procedure CreateAlarmFor(Type: Integer)
    var
        ServItemLine: Record "Service Item Line";
        NewAlarm: Record "Alarms_LDR";
    //AlarmCard: Page 70104;
    begin
        case Type of
            1:
                begin
                    TestField("No.");
                    Clear(NewAlarm);
                    NewAlarm."Alarm No." := NewAlarm.GetNextAlarmNo;
                    NewAlarm."Start Date" := WorkDate();
                    NewAlarm."Source Type" := NewAlarm."Source Type"::Customer;
                    NewAlarm."Source No." := "No.";
                    NewAlarm.insert(true);
                end;
        end;

        //Clear(AlarmCard);
        //AlarmCard.setTableView(NewAlarm);
        //AlarmCard.SetRecord(NewAlarm);
        //AlarmCard.Run();
    end;
}