/// <summary>
/// tableextension 50065 "Service Header_LDR"
/// </summary>
tableextension 50065 "Service Header_LDR" extends "Service Header"
{
    fields
    {
        modify("Customer No.")
        {
            trigger OnAfterValidate()
            var
                AlarmMgt: Codeunit "Alarm Mgt._LDR";
            begin
                AlarmMgt.CheckAlarm(Database::"Service Header", FieldName("Customer No."), "Customer No.", "Ship-to Code", WorkDate, 0, 0, "Document Type");
            end;
        }
        modify("Bill-to Customer No.")
        {
            trigger OnAfterValidate()
            var
                RecPmtAdress: Record "Customer Pmt. Address";
                Cust: Record Customer;
            begin
                "Pay-at Code" := '';

                if (Cust."Serv Order Payment Terms Code_LDR" = '') or (Cust."Serv Order Payment Method Code_LDR" = '') then begin
                    Validate("Payment Terms Code", Cust."Payment Terms Code");

                    if "Document Type" = "Document Type"::"Credit Memo" then begin
                        "Payment Method Code" := '';
                        if PaymentTerms.Get("Payment Terms Code") then
                            if PaymentTerms."Calc. Pmt. Disc. on Cr. Memos" then
                                "Payment Method Code" := Cust."Payment Method Code"
                    end else
                        "Payment Method Code" := Cust."Payment Method Code";

                end else begin
                    Validate("Payment Terms Code", Cust."Serv Order Payment Terms Code_LDR");
                    Validate("Payment Method Code", Cust."Serv Order Payment Method Code_LDR");
                end;

                Clear(RecPmtAdress);
                RecPmtAdress.SetRange(RecPmtAdress."Customer No.", "Bill-to Customer No.");
                //RecPmtAdress.SetRange(RecPmtAdress."Cust. Pmt. Address Predet.", RecPmtAdress."Cust. Pmt. Address Predet."::"1");
                if RecPmtAdress.FindFirst() then
                    Validate("Pay-at Code", RecPmtAdress.Code);

                GLSetup.Get();
                if GLSetup."Bill-to/Sell-to VAT Calc." = GLSetup."Bill-to/Sell-to VAT Calc."::"Bill-to/Pay-to No." then begin
                    "VAT Bus. Posting Group" := Cust."VAT Bus. Posting Group";
                    "VAT Registration No." := Cust."VAT Registration No.";
                    "VAT Country/Region Code" := Cust."Country/Region Code";
                    "Gen. Bus. Posting Group" := Cust."Gen. Bus. Posting Group";
                end;
                "Customer Posting Group" := Cust."Customer Posting Group";
                "Currency Code" := Cust."Currency Code";
                "Customer Price Group" := Cust."Customer Price Group";
                "Prices Including VAT" := Cust."Prices Including VAT";
                "Allow Line Disc." := Cust."Allow Line Disc.";
                "Invoice Disc. Code" := Cust."Invoice Disc. Code";
                "Customer Disc. Group" := Cust."Customer Disc. Group";
                "Language Code" := Cust."Language Code";
                "Salesperson Code" := Cust."Salesperson Code";
                Reserve := Cust.Reserve;

                "Send Document By Mail_LDR" := Cust."Send Service Documents By Mail_LDR";
                "E-Mail Destination_LDR" := Cust."Service E-Mail Destination_LDR";

                Validate("Posting Description", "Bill-to Name");
            end;
        }
        modify("Ship-to Code")
        {
            trigger OnAfterValidate()
            var
                ServItemLine: Record "Service Item Line";
            begin
                if "Ship-to Code" <> xRec."Ship-to Code" then
                    AlarmMgt.CheckAlarm(Database::"Service Header", FieldName("Ship-to Code"),
                                        "Customer No.", "Ship-to Code", WorkDate, 0, 0, "Document Type");
                if not "Direct sales_LDR" then begin
                end else begin
                    ServItemLine.Reset();
                    ServItemLine.SetRange("Document Type", "Document Type");
                    ServItemLine.SetRange("Document No.", "No.");
                    if ServItemLine.FindSet() then begin
                        repeat
                            ServItemLine.Validate("Ship-to Code", "Ship-to Code");
                            ServItemLine.Modify();
                        until ServItemLine.Next() = 0;
                    end;
                end;
            end;
        }
        modify("Posting Date")
        {
            trigger OnAfterValidate()
            begin
                if "Posting Date" <> xRec."Posting Date" then begin
                    ComprobarClienteProductoServ;
                end;
                UpdatePmtDiscDate();
            end;
        }
        modify("Due Date")
        {
            trigger OnAfterValidate()
            begin
                "Due Date Modified_LDR" := true;
            end;
        }
        modify("Payment Discount %")
        {
            trigger OnAfterValidate()
            begin
                UpdatePmtDiscDate();
            end;
        }
        modify("Pmt. Discount Date")
        {
            trigger OnAfterValidate()
            begin
                UpdatePmtDiscDate();
            end;
        }
        modify("Applies-to Doc. No.")
        {
            trigger OnAfterValidate()
            begin
                CheckBillSituation();
            end;
        }
        modify("Payment Method Code")
        {
            trigger OnAfterValidate()
            var
                SEPADirectDebitMandate: Record "SEPA Direct Debit Mandate";
                PaymentMethod: Record "Payment Method";
            begin
                if PaymentMethod.Get("Payment Method Code") then begin
                    if PaymentMethod."Direct Debit" then begin
                        if "Direct Debit Mandate ID" = '' then
                            "Direct Debit Mandate ID" := SEPADirectDebitMandate.GetDefaultMandate("Bill-to Customer No.", "Due Date");
                        if "Payment Terms Code" = '' then
                            "Payment Terms Code" := PaymentMethod."Direct Debit Pmt. Terms Code";
                    end;
                end;
            end;
        }
        // modify("Shipping No. Series")
        // {
        //     trigger OnLookup()
        //     var
        //         ServiceHeader: Record "Service Header";
        //         ServSetup: Record "Service Mgt. Setup";
        //         NoSeriesMgt: Codeunit NoSeriesManagement;
        //     begin
        //         with ServiceHeader do begin
        //             ServiceHeader := Rec;
        //             ServSetup.Get();
        //             ServSetup.TestField("Posted Service Shipment Nos.");
        //             if NoSeriesMgt.LookupSeries(ServSetup."Posted Service Shipment Nos.", "Shipping No. Series") then
        //                 Validate("Shipping No. Series");
        //             Rec := ServiceHeader;
        //         end;
        //     end;
        // }
        modify("Service Order Type")
        {
            trigger OnAfterValidate()
            var
                CraneMgtSetup: Record "Crane Mgt. Setup_LDR";
            begin
                CraneMgtSetup.Get();
                if ("Service Order Type" = CraneMgtSetup."Serv. Order Type - Crane") or
                   ("Service Order Type" = CraneMgtSetup."Serv. Order Type - Platf. Del.") or
                   ("Service Order Type" = CraneMgtSetup."Serv. Order Type - Platf. Pick") then
                    "Role Center Filter_LDR" := true
                else
                    "Role Center Filter_LDR" := false;

                if ("Service Order Type" = CraneMgtSetup."Serv. Order Type - Maintenance") or
                  ("Service Order Type" = CraneMgtSetup."Serv. Order Type - Repair") then
                    "Role Center Filter 2_LDR" := true
                else
                    "Role Center Filter 2_LDR" := false;
            end;
        }
        modify("Contract No.")
        {
            trigger OnAfterValidate()
            begin
                if "Internal Contract No._LDR" = '' then
                    if "Contract No." <> xRec."Contract No." then
                        AlarmMgt.CheckAlarm(Database::"Service Header", FieldName("Contract No."), "Contract No.", '', WorkDate, 0, 0, "Document Type");
            end;
        }
        modify("Ship-to E-Mail")
        {
            trigger OnAfterValidate()
            var
                MailManagement: Codeunit "Mail Management";
            begin
                if "Ship-to E-Mail" <> '' then
                    MailManagement.CheckValidEmailAddresses("Ship-to E-Mail");
            end;
        }
        field(50050; "Crane Service Quote No._LDR"; Code[20])
        {
            Caption = 'Código Oferta Servicio Grúa';
            DataClassification = ToBeClassified;
            //TableRelation = "Crane Service Quote Header"."Quote no."; //TODO: Revisar si conservamos la tabla

            trigger OnValidate()
            var
                CraneServiceQuoteHeader: Record "Crane Service Quote Header_LDR";
            begin
                if CraneServiceQuoteHeader.Get("Crane Service Quote No._LDR") then begin
                    if CraneServiceQuoteHeader."Salesperson Code" <> '' then
                        "Salesperson Code" := CraneServiceQuoteHeader."Salesperson Code";
                end;
            end;
        }
        field(50051; "Service Item Rate No._LDR"; Code[20])
        {
            Caption = 'Código Tarifa Producto Servicio';
            DataClassification = ToBeClassified;
            //TableRelation = "Service Item Rate Header"; //TODO: Revisar si conservamos la tabla
        }
        field(50052; "Serv. Item Operation Entry No._LDR"; Integer)
        {
            Caption = 'Nº Movimiento Operación Producto Servicio';
            DataClassification = ToBeClassified;
            //TableRelation = "Serv. Item Operations Entry"."Entry No."; //TODO: Revisar si conservamos la tabla
        }
        field(50053; "Role Center Filter_LDR"; Boolean)
        {
            Caption = 'Visible Role Center';
            DataClassification = ToBeClassified;
            Description = 'Se usará para Filtrar el RoleCenter por Pedidos de Tipo Grúa", "Entrega de Plataforma" y "Recogida de Plataforma"';
        }
        field(50054; "Role Center Filter 2_LDR"; Boolean)
        {
            Caption = 'Visible Role Center 2';
            DataClassification = ToBeClassified;
            Description = 'Se usará para Filtrar el RoleCenter por Pedidos de Tipo Reparación y Mantenimiento';
        }
        field(50055; "Crane Serv. Quote Op. Line No_LDR"; Integer)
        {
            Caption = 'Nº Línea Opción Oferta Servicio Grúa';
            DataClassification = ToBeClassified;
        }
        field(50056; Retained_LDR; Boolean)
        {
            Caption = 'Retenido';
            DataClassification = ToBeClassified;
            Enabled = false;

            trigger OnValidate()
            var
                txtRetained: TextConst ENU = 'Debe introducir No. Pedido Cliente';
            begin
                if "Invoicing Type_LDR" = "Invoicing Type_LDR"::Order then
                    if (not Retained_LDR) and ("Customer Order No._LDR" = '') then begin
                        Message(txtRetained);
                        Retained_LDR := true;
                    end;
                ServiceShipUpdate();
            end;
        }
        field(50057; "Customer Order No._LDR"; Code[20])
        {
            Caption = 'Nº Pedido Cliente';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Customer Order No._LDR" = '' then
                    Retained_LDR := true
                else begin
                    Retained_LDR := false;
                    ServiceShipUpdate();
                end;
            end;
        }
        field(50058; "Travel Type_LDR"; Option)
        {
            OptionCaption = 'Simple,Complejo';
            DataClassification = ToBeClassified;
            OptionMembers = Simple,Complex;
        }
        field(50059; "Destination City_LDR"; Text[30])
        {
            Caption = 'Población Regreso';
            DataClassification = ToBeClassified;
            TableRelation = if ("Country/Region Code" = CONST()) "Post Code"."City" else
            if ("Country/Region Code" = FILTER(<> ''))
            "Post Code"."City" WHERE("Country/Region Code" = FIELD("Country/Region Code"));
            TestTableRelation = false; //TODO: Revisar warning del atributo TestTableRelation de este field
            ValidateTableRelation = false;
        }
        field(50060; "Destination Post Code_LDR"; Code[20])
        {
            Caption = 'C.P. Regreso';
            DataClassification = ToBeClassified;
            TableRelation = if ("Country/Region Code" = CONST()) "Post Code" else
            if ("Country/Region Code" = FILTER(<> '')) "Post Code" WHERE("Country/Region Code" = FIELD("Country/Region Code"));
            TestTableRelation = false; //TODO: Revisar warning del atributo TestTableRelation de este field
            ValidateTableRelation = false;
        }
        field(50061; "Destination County_LDR"; Text[30])
        {
            Caption = 'Provincia Retorno';
            DataClassification = ToBeClassified;
        }
        field(50062; "Dest. Country/Region Code_LDR"; Date)
        {
            Caption = 'Código País/Región Retorno';
            DataClassification = ToBeClassified;
            TableRelation = "Country/Region";
        }
        field(50063; "Requested Starting Date_LDR"; Date) //TODO: Revisar warning del atributo CalcFormula del field
        {
            //CalcFormula = Lookup("Service Item Line"."Requested Starting Date" WHERE ("Document No."=FIELD("No."),"Document Type"=FIELD("Document Type"))); //TODO: Revisar si conservamos el atributo CalcFormula
            Caption = 'Fecha Inicio Solicitada';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50064; "Requested ending Date_LDR"; Date) //TODO: Revisar warning del atributo CalcFormula del field
        {
            //CalcFormula = Lookup("Service Item Line"."Requested ending Date" WHERE("Document No." = FIELD("No."), "Document Type" = FIELD("Document Type"))); //TODO: Revisar si conservamos el atributo CalcFormula
            Caption = 'Fecha Final Solicitada';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50065; "Old Worksheet No._LDR"; Code[20]) //TODO: Revisar warning del atributo CalcFormula del field
        {
            //CalcFormula = Lookup("Service Item Line"."Old Worksheet No." WHERE ("Document No."=FIELD("No."),"Document Type"=FIELD("Document Type"))); //TODO: Revisar si conservamos el atributo CalcFormula
            Caption = 'Nº. Albarán Antiguo';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50066; "Invoicing Type_LDR"; Option) //TODO: Revisar warning del atributo CalcFormula del field
        {
            //CalcFormula = Lookup("Crane Service Quote Header"."Invoicing Type" WHERE("Quote no." = FIELD("Crane Service Quote No."))); //TODO: Revisar si conservamos el atributo CalcFormula
            Caption = 'Tipo Facturación';
            FieldClass = FlowField;
            OptionCaption = 'Obra,Oferta,Independiente,Pedido';
            OptionMembers = Work,Offer,Standalone,Order;

        }
        field(50067; "Converted to Order_LDR"; Boolean)
        {
            Caption = 'Convertida en Pedido';
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(50068; "Customer Comment_LDR"; Boolean)
        {
            CalcFormula = Exist("Comment Line" WHERE("Table Name" = CONST("Customer"), "No." = FIELD("Customer No.")));
            Caption = 'Comentario Cliente';
            Enabled = false;
            FieldClass = FlowField;
        }
        field(50069; "Invoice No. Series_LDR"; Code[20])
        {
            Caption = 'Nº Serie Facturas';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";

            trigger OnValidate()
            var
                SalesSetup: Record "Sales & Receivables Setup";
                NoSeriesMgt: Codeunit "NoSeriesManagement";
            begin
                if "Invoice No. Series_LDR" <> '' then begin
                    SalesSetup.Get();
                    SalesSetup.TestField("Posted Invoice Nos.");
                    NoSeriesMgt.TestSeries(SalesSetup."Posted Invoice Nos.", "Invoice No. Series_LDR");
                end;
                TestField("Invoice No. Series_LDR");
            end;

            trigger OnLookup()
            var
                ServiceHeader: Record "Service Header";
                SalesSetup: Record "Sales & Receivables Setup";
                NoSeriesMgt: Codeunit "NoSeriesManagement";
            begin
                with ServiceHeader do begin
                    ServiceHeader := Rec;
                    SalesSetup.Get();
                    SalesSetup.TestField(SalesSetup."Posted Invoice Nos.");
                    if NoSeriesMgt.LookupSeries(SalesSetup."Posted Invoice Nos.", "Invoice No. Series_LDR") then
                        Validate("Invoice No. Series_LDR");
                    Rec := ServiceHeader;
                end;
            end;
        }
        field(50070; "Contract group Code_LDR"; Code[10])
        {
            CalcFormula = Lookup("Service Contract Header"."Contract Group Code" WHERE("Contract No." = FIELD("Contract No.")));
            Caption = 'Código Grupo Contrato';
            Editable = false;
            FieldClass = FlowField;
        }
        /*field(50071; "Direct Debit Mandate ID_LDR"; Code[35]) //TODO: Revisar si conservamos el field
        {
            Caption = 'Id. de Orden de Domiciliación de Adeudo Directo';
            DataClassification = ToBeClassified;
            //TableRelation = "SEPA Direct Debit Mandate" WHERE("Customer No." = FIELD("Bill-to Customer No."), "Closed" = CONST("No"), "Blocked" = CONST("No")); //TODO: Revisar si conservamos la tabla
        }*/
        field(50072; "Source Type_LDR"; Option)
        {
            Caption = 'Tipo Origen';
            Editable = false;
            DataClassification = ToBeClassified;
            OptionMembers = Transfer;
            OptionCaption = 'Transfer';
        }
        field(50073; "Default Work Type Code_LDR"; Code[20])
        {
            Caption = 'Código Tipo Trabajo por Defecto';
            DataClassification = ToBeClassified;
            //TableRelation = "Work Type" WHERE ("Res. Journal Type"=FILTER("No")); //TODO: Revisar si conservamos la tabla

            trigger OnValidate()
            var
                ServInvLine: Record "Service Line";
                txtTipoTrabajoDefecto: TextConst ENU = 'There are Service Invoice Lines without Work type Code. Do you want to update that?', ESP = 'Existen líneas de factura de servicio sin registrar con Cód Tipo Trabajo en blanco. ¿Desea actualizar su valor ?';
            begin
                Clear(ServInvLine);
                ServInvLine.SetRange(ServInvLine."Document Type", "Document Type");
                ServInvLine.SetRange(ServInvLine."Document No.", "No.");
                ServInvLine.SetRange(ServInvLine."Work Type Code", '');
                ServInvLine.SetFilter(ServInvLine."Outstanding Quantity", '<>0');
                if ServInvLine.Find('-') then begin
                    if Confirm(txtTipoTrabajoDefecto) then begin
                        repeat
                            ServInvLine.Validate("Work Type Code", "Default Work Type Code_LDR");
                            ServInvLine.Modify(true);
                        until ServInvLine.Next() = 0;
                    end;
                end;
            end;
        }
        field(50074; "Internal Contract No._LDR"; Code[20])
        {
            Caption = 'Nº Contrato Interno';
            DataClassification = ToBeClassified;
            //TableRelation = Table70028.Field1 WHERE(Field2 = CONST(1)); //TODO: Revisar si conservamos la tabla

            trigger OnValidate()
            var
                //IntServContract: Record 70028;
                ServMgtSetup: Record "Service Mgt. Setup";
                ServItemLine: Record "Service Item Line";
            begin
                ServMgtSetup.Get();

                ServMgtSetup.TestField("No. Internal Customer_LDR");
                TestField("Customer No.", ServMgtSetup."No. Internal Customer_LDR");
                if "Internal Contract No._LDR" <> xRec."Internal Contract No._LDR" then begin
                    if "Internal Contract No._LDR" <> '' then begin
                        TestField("Order Date");
                        //IntServContract.Get(IntServContract."Contract Type"::"1", "Internal Contract No._LDR");
                        //IntServContract.CalcFields("Starting Date", "Expiration Date");

                        //if IntServContract."Starting Date" > "Order Date" then
                        Error(Text042, "Contract No.");
                        //if (IntServContract."Expiration Date" <> 0D) and
                        //(IntServContract."Expiration Date" <= "Order Date")
                        //then
                        Error(Text043, "Contract No.");
                    end;

                    ServItemLine.Reset();
                    ServItemLine.SetRange("Document Type", "Document Type");
                    ServItemLine.SetRange("Document No.", "No.");
                    if ServItemLine.Find('-') then
                        Error(Text028,
                          FieldCaption("Internal Contract No._LDR"), ServItemLine.TableCaption);
                end;
            end;
        }
        field(50075; "Review No._LDR"; Integer)
        {
            Caption = 'Nº Revisión';
            DataClassification = ToBeClassified;
        }
        field(50076; "Review Contract Line No._LDR"; Integer)
        {
            Caption = 'Nº Línea Contrato Revisión';
            DataClassification = ToBeClassified;
        }
        field(50077; "Review Template No._LDR"; Code[20])
        {
            Caption = 'Nº Plantilla Revisión';
            DataClassification = ToBeClassified;
            //TableRelation = Table70002; //TODO: Revisar si conservamos la tabla
        }
        field(50078; "Rejected Quote_LDR"; Boolean)
        {
            Caption = 'Oferta Rechazada';
            DataClassification = ToBeClassified;
        }
        field(50079; "Historical Quote_LDR"; Boolean)
        {
            Caption = 'Oferta Histórica';
            DataClassification = ToBeClassified;
        }
        field(50080; "Linked Service Order No._LDR"; Code[20])
        {
            Caption = 'Nº Pedido Servicio Vinculado';
            DataClassification = ToBeClassified;
            TableRelation = "Service Header"."No." WHERE("Document Type" = CONST("Order"), "Customer No." = FIELD("Customer No."),
            "Bill-to Customer No." = FIELD("Bill-to Customer No."), "Ship-to Code" = FIELD("Ship-to Code"));
        }
        field(50081; "New Order No. Series_LDR"; Code[10])
        {
            Caption = 'Nº Serie Nuevo Pedido Servicio';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50082; "Allocated Date_LDR"; Date)
        {
            CalcFormula = Lookup("Service Order Allocation"."Allocation Date" WHERE("Document Type" = FIELD("Document Type"),
            "Document No." = FIELD("No."), "Allocation Date" = FIELD("Date Filter"), "Resource No." = FIELD("Resource Filter"),
            "Status" = FILTER("Active"), "Resource Group No." = FIELD("Resource Group Filter")));
            Caption = 'Fecha Asignación';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50083; "External Document No._LDR"; Code[20])
        {
            Caption = 'Nº Documento Externo';
            DataClassification = ToBeClassified;
        }
        field(50084; "Direct sales_LDR"; Boolean)
        {
            Caption = 'Venta Directa';
            DataClassification = ToBeClassified;
        }
        field(50085; "Calculate Maint. Type_LDR"; Option)
        {
            Caption = 'Tipo Cálculo Mantenimiento';
            DataClassification = ToBeClassified;
            Description = 'Indica el Tipo de Cálculo que se utilizará para sacar las Horas/Día de una Máquina';
            notBlank = true;
            OptionCaption = 'Según configuración,Según Contrato,Por Período,Por Nº Pedidos';
            OptionMembers = "Según Contrato","Por Período","Por Nº Pedidos";
        }
        field(50086; "Calculate Maint. Type Period_LDR"; DateFormula)
        {
            Caption = 'Período Cálculo Mantenimiento';
            DataClassification = ToBeClassified;
            Description = 'Indica el PerÍodo que se utilizará para el Cálculo de Horas/Día de una Máquina por Período';
        }
        field(50087; "Calculate Maint. Type Order_LDR"; Integer)
        {
            Caption = 'Nº Pedidos Cálculo Mantenimiento';
            DataClassification = ToBeClassified;
            Description = 'Indica el Número de Pedidos que se utilizarán para el Cálculo de Horas/Día de una Máquina por Pedidos Servicio';
            MinValue = 0;
            notBlank = true;
        }
        field(50088; "Maintenance Order_LDR"; Boolean)
        {
            Caption = 'Pedido Mantenimiento';
            DataClassification = ToBeClassified;
        }
        field(50089; "Assignation Priority_LDR"; Integer) //TODO: Revisar warning del atributo CalcFormula del field
        {
            //CalcFormula = Lookup("Service Order Allocation"."Assignation Priority" WHERE("Document Type" = FIELD("Document Type"),"Document No." = FIELD("No."), "Allocation Date" = FIELD("Date Filter"), "Resource No." = FIELD("Resource Filter"), "Status" = FILTER("Active"),"Resource Group No." = FIELD("Resource Group Filter"))); //TODO: Revisar si conservamos el atributo CalcFormula
            Caption = 'Prioridad Asignación';
            FieldClass = FlowField;
        }
        field(50090; "Created Date_LDR"; DateTime)
        {
            Caption = 'Fecha Creación';
            DataClassification = ToBeClassified;
        }
        field(50091; "Modified Date_LDR"; DateTime)
        {
            Caption = 'Fecha Modificación';
            DataClassification = ToBeClassified;
        }
        field(50092; note_LDR; Text[250])
        {
            Caption = 'notas';
            DataClassification = ToBeClassified;
            Description = 'Planner';
        }
        field(50093; "Send Document By Mail_LDR"; Boolean)
        {
            Caption = 'Enviar Documento por Mail';
            DataClassification = ToBeClassified;
        }
        field(50094; "E-Mail Destination_LDR"; Text[250])
        {
            Caption = 'E-Mail de Destino';
            DataClassification = ToBeClassified;
            ExtendedDatatype = EMail;
        }
        field(50095; "Due Date Modified_LDR"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50096; Amount_LDR; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Service Line"."Amount" WHERE("Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.")));
            Caption = 'Importe';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50097; "Amount Including VAT_LDR"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Service Line"."Amount Including VAT" WHERE("Document Type" = FIELD("Document Type"),
            "Document No." = FIELD("No.")));
            Caption = 'Importe IVA Incluido';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50098; "Order Type_LDR"; Option)
        {
            Caption = 'Tipo Pedido';
            DataClassification = ToBeClassified;
            Description = 'EVO FIELDEAS MODEN, ALQ con FMI,ALQ con FSI Extra Contra,FS Externo,FS Externo Extra Contrato,Fact. Externa,Oferta';
            OptionCaption = 'Mantenimiento Interno,Mantenimiento Interno Extra Contrato,Mantenimiento Externo,Mantenimiento Externo Extra Contrato,Facturación Externa,Oferta de Servicio';
            OptionMembers = FSI,FSIEC,FS,FSEC,FE,OFF;
        }
        field(50099; "Interruption Reason_LDR"; Text[100])
        {
            Caption = 'Motivo Interrupción';
            DataClassification = ToBeClassified;
            Description = 'EVO FIELDEAS MODEN';
        }
        field(50100; "Fault Comment_LDR"; Boolean)
        {
            CalcFormula = Exist("Service Comment Line" WHERE("Table Name" = CONST("Service Header"),
            "Table Subtype" = FIELD("Document Type"), "No." = FIELD("No."), "Type" = CONST("Fault")));
            Caption = 'Comentarios Defectos';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50101; "Resolution Comment_LDR"; Boolean)
        {
            CalcFormula = Exist("Service Comment Line" WHERE("Table Name" = CONST("Service Header"),
            "Table Subtype" = FIELD("Document Type"), "No." = FIELD("No."), "Type" = CONST("Resolution")));
            Caption = 'Comentarios Resoluciones';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50102; "Internal Comment_LDR"; Boolean)
        {
            CalcFormula = Exist("Service Comment Line" WHERE("Table Name" = CONST("Service Header"),
            "Table Subtype" = FIELD("Document Type"), "No." = FIELD("No."), "Type" = CONST("Internal")));
            Caption = 'Comentarios Internos';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50103; Replicate_LDR; Boolean) //TODO: Revisar warning del atributo CalcFormula del field
        {
            //CalcFormula = Exist("Service Line" WHERE("Document Type" = FIELD("Document Type"), "Customer No." = FIELD("Customer No."), "Document No." = FIELD("No."), "Replicate" = CONST(true), "Replicate Company" = FIELD("CompanyFilter"))); //TODO: Revisar si conservamos el atributo CalcFormula
            Caption = 'Replicar';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50104; "Replicate Pending_LDR"; Boolean) //TODO: Revisar warning del atributo CalcFormula del field
        {
            //CalcFormula = Exist("Service Line" WHERE("Document Type" = FIELD("Document Type"), "Customer No." = FIELD("Customer No."), "Document No." = FIELD("No."), "Replicate" = CONST(true), "Replicated" = CONST("No"), "Replicate Company" = FIELD("CompanyFilter"))); //TODO: Revisar si conservamos el atributo CalcFormula
            Caption = 'Pendiente Replicar';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50105; CompanyFilter_LDR; Text[30])
        {
            FieldClass = FlowFilter;
        }
    }

    keys
    {

        key(Key8; "Order Date")
        {
            MaintainSQLIndex = false;
            MaintainSiftIndex = false;
        }
        key(Key9; "Direct sales_LDR")
        {

        }
    }

    fieldgroups
    {
        addlast(DropDown; "Description", "Name")
        { }
    }

    trigger OnAfterInsert()
    begin
        "New Order No. Series_LDR" := ServSetup."Service Order Nos.";
        if "Document Type" = "Document Type"::Order then
            CheckPostedNo("No.");
        SalesSetup.Get;
        Validate("Invoice No. Series_LDR", SalesSetup."Posted Invoice Nos.");
        "Created Date_LDR" := CurrentDateTime;
    end;

    trigger OnAfterModify()
    begin
        "Modified Date_LDR" := CurrentDateTime;
    end;

    trigger OnAfterDelete()
    var
        Deshacer: Integer;
        Salesline2: Record "Service Line";
        NContrato: Code[20];
        ServShptHeader: Record "Service Shipment Header";
        ServInvHeader: Record "Service Invoice Header";
        ServCrMemoHeader: Record "Service Cr.Memo Header";
        //LocationCodeModifyLog: Record 70087;
        ServItemOperationsEntry: Record "Serv. Item Operat Entry_LDR";
        CraneServQForfaitCalendar: Record "Crane Serv Q. Forf Calend_LDR";
        CraneServQForfaitCalendar2: Record "Crane Serv Q. Forf Calend_LDR";
    begin
        if "Document Type" = "Document Type"::Invoice then begin
            Salesline2.Reset;
            Salesline2.SetFilter(Salesline2."Contract No.", '<>%1', '');
            if Salesline2.FindSet() then begin
                Deshacer := StrMenu(TextDeshacerContrato, 2);
                if Deshacer = 0 then
                    Error('');
                repeat
                    if Deshacer = 2 then begin
                        DeshacerLineaContrato(Salesline2);
                        DeshacerConcepto(Salesline2);
                        EliminarMovsServicio(Salesline2);
                    end else begin
                        EliminarMovsServicio(Salesline2);
                    end;
                until Salesline2.Next() = 0;
                if Deshacer = 2 then begin
                    Salesline2.FindSet();
                    repeat
                        if NContrato <> Salesline2."Contract No." then
                            DeshacerCabeceraContrato(Salesline2);
                        NContrato := Salesline2."Contract No.";
                    until Salesline2.Next() = 0;
                end;

                Salesline2.ModifyAll(Salesline2."Appl.-to Service Entry", 0);
            end;
        end;
        if (ServShptHeader."No." <> '') or
              (ServInvHeader."No." <> '') or
              (ServCrMemoHeader."No." <> '')
           then begin
            Commit();

            if ServShptHeader."No." <> '' then
                if Confirm(Text048, true, ServShptHeader."No.") then begin
                    ServShptHeader.SetRecFilter;
                    ServShptHeader.PrintRecords(true);
                end;

            if ServInvHeader."No." <> '' then
                if Confirm(Text049, true, ServInvHeader."No.") then begin
                    ServInvHeader.SetRecFilter;
                    ServInvHeader.PrintRecords(true);
                end;

            if ServCrMemoHeader."No." <> '' then
                if Confirm(Text002, true, ServCrMemoHeader."No.") then begin
                    ServCrMemoHeader.SetRecFilter;
                    ServCrMemoHeader.PrintRecords(true);
                end;
        end;

        //LocationCodeModifyLog.Reset();
        //LocationCodeModifyLog.SetCurrentKey("Document Type", "Document No.");
        //LocationCodeModifyLog.SetRange("Document Type", "Document Type");
        //LocationCodeModifyLog.SetRange("Document No.", "No.");
        //LocationCodeModifyLog.DeleteAll();

        Clear(ServItemOperationsEntry);
        ServItemOperationsEntry.SetRange("Serv. Order No.", Rec."No.");
        ServItemOperationsEntry.ModifyAll("Serv. Order No.", '');

        CraneServQForfaitCalendar.SetRange("Invoice No.", "No.");
        if CraneServQForfaitCalendar.FindSet() then
            repeat
                CraneServQForfaitCalendar2.Get(CraneServQForfaitCalendar."Quote No.", CraneServQForfaitCalendar."Quote Op. Line No.", CraneServQForfaitCalendar."Line No.");
                CraneServQForfaitCalendar2."Invoice No." := '';
                CraneServQForfaitCalendar2.Modify();
            until CraneServQForfaitCalendar.Next() = 0;
    end;

    var
        Text002: TextConst ENU = 'Do you want to print credit memo %1?', ESP = '¿Confirma que desea imprimir el abono %1?';
        Text028: TextConst ENU = 'You cannot change the %1 because %2 exists.', ESP = 'No puede cambiar %1 porque hay un %2.';
        Text3: TextConst ENU = 'It is not possible to close %1 because it is included on bill group.', ESP = '%1 No se puede liquidar ya que esta incluido en una remesa.';
        Text4: TextConst ENU = 'Delete it from bill group and try.', ESP = 'Borrelo de la remesa e intentelo de nuevo.';
        TextDeshacerContrato: TextConst ENU = '&Delete Invoice,&Delete and Undo invoice', ESP = '&Borrar la Factura,&Borrar y deshacer la Factura';
        Text0622: TextConst ENU = 'It is not possible to open a Cancelled Contract', ESP = 'No es posible abrir un contrato cancelado';
        Text0632: TextConst ENU = 'Entry No. %1 does not exist for Contract No. %2', ESP = 'El movimiento %1 no existe para el contrato %2';
        ServiceContractLine: Record "Service Contract Line";
        GLSetup: Record "General Ledger Setup";
        Text042: TextConst ENU = 'The service period for contract %1 has not yet started.', ESP = 'El periodo servicio para contrato %1 todavía no ha comenzado.';
        Text043: TextConst ENU = 'The service period for contract %1 has expired.', ESP = 'Ha vencido el periodo servicio para contrato %1.';
        Text048: TextConst ENU = 'Do you want to print shipment %1?', ESP = '¿Confirma que desea imprimir el albarán %1?';
        Text049: TextConst ENU = 'Do you want to print invoice %1?', ESP = '¿Confirma que desea imprimir la factura %1?';
        Text50060: TextConst ENU = 'Exist more than one invoice without post for contract %1', ESP = 'Existe más de una factura sin registrar para el contrato %1';
        TextErrorPed: TextConst ENU = 'A posted order already exists with the number %1', ESP = 'Ya existe un pedido de servicio histórico con el número %1';
        SalesSetup: Record "Sales & Receivables Setup";
        ServSetup: Record "Service Mgt. Setup";
        AlarmMgt: Codeunit "Alarm Mgt._LDR";
        Text50001: TextConst ENU = 'All Serv. Item Lines should be in %1 repair status', ESP = 'Todas las líneas de Prod. Servicio deben estar en el estado %1';
        Text50002: TextConst ENU = 'Counter Value is mandatory when the Service Item has counters', ESP = 'Debe introducir un valor contador si el Prod. Servicio trabaja con contadores.';
        Text50003: TextConst ENU = 'Forfait Calendar from %3 inside Operation No. %1 of Quote No. %2, is currently unprocessed', ESP = 'El Calendario de Facturación del %3 dentro de la operación No. %1 de la Oferta No. %2 está actualmente sin procesar.';
        Text50004: TextConst ENU = 'Forfait Calendar from %3 inside Operation No. %1 of Quote No. %2, is currently unposted.', ESP = 'El Calendario de Facturación del %3 dentro de la operación No. %1 de la Oferta No. %2 está actualmente sin registrar.';
        PaymentTerms: Record "Payment Terms";

    procedure CheckPostedNo(NpedServ: Code[20]);
    var
        RecPostedService: Record "Posted Service Header_LDR";
    begin
        Clear(RecPostedService);

        if RecPostedService.Get(NpedServ) then
            Error(TextErrorPed, NpedServ);
    end;

    procedure ComprobarClienteProductoServ();
    var
        ServItemLine: Record "Service Item Line";
        FacturarA: Code[20];
    begin
        Clear(ServItemLine);
        ServItemLine.SetRange(ServItemLine."Document Type", "Document Type");
        ServItemLine.SetRange(ServItemLine."Document No.", "No.");
        if ServItemLine.Find('-') then begin
            repeat

                if FacturarA <> '' then
                    Validate("Bill-to Customer No.", FacturarA);

            until ServItemLine.Next() = 0;
        end;
    end;

    procedure QuoteToOrderAssistEdit(OldServHeader: Record "Service Header"): BoolEAN;
    var
        ServHeader: Record "Service Header";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        with ServHeader do begin
            ServHeader := Rec;
            ServSetup.Get();
            case "Document Type" of
                "Document Type"::Quote:
                    begin
                        ServSetup.TestField("Service Order Nos.");
                        if NoSeriesMgt.SelectSeries(ServSetup."Service Order Nos.",
                                                   OldServHeader."New Order No. Series_LDR", "New Order No. Series_LDR") then begin
                            Rec := ServHeader;
                            exit(true);
                        end;
                    end;
            end;
        end;
    end;

    procedure CheckBillSituation();
    var
        Doc: Record "Cartera Doc.";
        CustLedgerEntry2: Record "Cust. Ledger Entry";
    begin
        CustLedgerEntry2.SetCurrentKey("Document No.", "Document Type", "Customer No.");
        CustLedgerEntry2.SetRange("Document No.", "Applies-to Doc. No.");
        CustLedgerEntry2.SetRange("Bill No.", "Applies-to Bill No.");
        CustLedgerEntry2.SetFilter("Document Status", '<>%1', CustLedgerEntry2."Document Status"::" ");
        if CustLedgerEntry2.Find('-') then begin
            CustLedgerEntry2.TestField("Document Status", CustLedgerEntry2."Document Status"::Open);
            if Doc.Get(Doc.Type::Receivable, CustLedgerEntry2."Entry No.") then
                if Doc."Bill Gr./Pmt. Order No." <> '' then
                    Error(
                      Text3 +
                      Text4,
                      CustLedgerEntry2.Description);
        end;
    end;

    procedure EliminarMovsServicio(RecSalesline: Record "Service Line");
    var
        ServiceEntry: Record "Service Ledger Entry";
    begin
        Clear(ServiceEntry);
        if not ServiceEntry.Get(RecSalesline."Appl.-to Service Entry") then
            Error(
              Text0632,
              ServiceEntry."Entry No.",
              ServiceEntry."Service Contract No.");


        if ServiceEntry."Apply Until Entry No." <> 0 then
            ServiceEntry.SetRange("Entry No.", ServiceEntry."Entry No.", ServiceEntry."Apply Until Entry No.")
        else
            ServiceEntry.SetRange("Entry No.", ServiceEntry."Entry No.", ServiceEntry."Entry No.");

        ServiceEntry.Find('-');
        repeat
            ServiceEntry.TestField(Type, ServiceEntry.Type::"Service Contract");
        until ServiceEntry.Next() = 0;

        ServiceEntry.DeleteAll(true);
    end;

    procedure DeshacerLineaContrato(RecSalesline: Record "Service Line");
    var
        ServiceContractHeader: Record "Service Contract Header";
        //LockOpenServContract: Codeunit 5943;
        ServiceEntry: Record "Service Ledger Entry";
        Estado: BoolEAN;
    begin
        ServiceContractHeader.Get(ServiceContractHeader."Contract Type"::Contract, RecSalesline."Contract No.");

        ServiceContractHeader.CalcFields("No. of Posted Invoices");
        ServiceContractHeader.CalcFields("No. of Unposted Invoices");

        Clear(ServiceEntry);
        if not ServiceEntry.Get(RecSalesline."Appl.-to Service Entry") then
            Error(Text0632,
              RecSalesline."Appl.-to Service Entry",
              "No.");

        if ServiceEntry."Service Contract Concept Entry_LDR" then
            exit;

        if (ServiceContractHeader."No. of Posted Invoices" = 0) and
           (ServiceContractHeader."No. of Unposted Invoices" = 1) then begin

            Clear(ServiceContractLine);
            ServiceContractLine.SetRange("Contract Type", ServiceContractHeader."Contract Type");
            ServiceContractLine.SetRange("Contract No.", ServiceContractHeader."Contract No.");
            ServiceContractLine.SetRange(ServiceContractLine."Line No.", ServiceEntry."Service Contract Line No._LDR");
            if ServiceContractLine.Find('-') then begin
                ServiceContractLine.Validate("Invoiced to Date", 0D);
                ServiceContractLine.Modify();
            end;
        end else begin
            Clear(ServiceContractLine);
            ServiceContractLine.SetRange("Contract Type", ServiceContractHeader."Contract Type");
            ServiceContractLine.SetRange("Contract No.", ServiceContractHeader."Contract No.");
            ServiceContractLine.SetRange(ServiceContractLine."Line No.", ServiceEntry."Service Contract Line No._LDR");
            if ServiceContractLine.Find('-') then begin
                if ServiceContractHeader.Lineal_LDR then
                    ServiceContractLine."Invoiced to Date" := ServiceEntry."Undo Serv. Contract Inv. Date_LDR"
                else
                    ServiceContractLine."Invoiced to Date" := CalcDate(FormulaFechaFinMes(ServiceContractHeader."Contract No.", ServiceContractLine."Invoiced to Date")
                                                                   , ServiceContractLine."Invoiced to Date");
                if (ServiceContractHeader.Prepaid) and
                   (ServiceContractLine."Starting Date" > ServiceContractLine."Invoiced to Date") then
                    ServiceContractLine.Validate("Invoiced to Date", 0D);

                ServiceContractLine.Modify();
            end;
        end;
    end;

    procedure DeshacerCabeceraContrato(RecSalesline: Record "Service Line");
    var
        ServiceContractHeader: Record "Service Contract Header";
        //LockOpenServContract: Codeunit 5943;
        Estado: BoolEAN;
        ServDocRegister: Record "Service Document Register";
        ServiceHeader: Record "Service Header";
    begin
        ServiceContractHeader.Get(ServiceContractHeader."Contract Type"::Contract, RecSalesline."Contract No.");

        ServiceContractHeader.CalcFields("No. of Unposted Invoices");
        if ServiceContractHeader."No. of Unposted Invoices" <> 1 then
            Error(
              Text50060,
              ServiceContractHeader."Contract No.");

        ServDocRegister.Reset();
        Estado := false;

        ServDocRegister.SetRange("Destination Document No.", RecSalesline."Document No.");
        if ServDocRegister.Find('-') then begin
            if ServiceContractHeader."Change Status" = ServiceContractHeader."Change Status"::Locked then begin
                if (ServiceContractHeader.Status = ServiceContractHeader.Status::Cancelled) and
                   (ServiceContractHeader."Contract Type" = ServiceContractHeader."Contract Type"::Contract) then
                    Error(Text0622);
                ServiceContractHeader."Change Status" := ServiceContractHeader."Change Status"::Open;
                ServiceContractHeader.Modify();
                Estado := true;
            end;
        end;

        ServiceContractHeader.CalcFields("No. of Posted Invoices");
        ServiceContractHeader.CalcFields("No. of Unposted Invoices");

        if (ServiceContractHeader."No. of Posted Invoices" = 0) and
           (ServiceContractHeader."No. of Unposted Invoices" = 1) then begin

            ServiceContractHeader."Last Invoice Date" := 0D;
            ServiceContractHeader."Last Invoice Period End" := 0D;

            if ServiceContractHeader.Prepaid THEN
                ServiceContractHeader."Next Invoice Date" := ServiceContractHeader."Starting Date"
            else
                ServiceContractHeader."Next Invoice Date" := CalcDate(FormulaFechaFinMesComienzoFact(ServiceContractHeader."Contract No.", ServiceContractHeader."Starting Date"),
                ServiceContractHeader."Starting Date")
        end else begin
            if ServiceContractHeader.Prepaid then begin
                if ServiceContractHeader."Next Invoice Date" = 0D then
                    ServiceContractHeader."Next Invoice Date" := CalcDate('<-CM>', ServiceContractHeader."Last Invoice Period End")
                else
                    ServiceContractHeader."Next Invoice Date" := CalcDate(FormulaFechaInicioMes(ServiceContractHeader."Contract No.", ServiceContractHeader."Next Invoice Date"),
                                                                          ServiceContractHeader."Next Invoice Date");
                ServiceContractHeader."Last Invoice Date" := CalcDate(FormulaFechaInicioMes(ServiceContractHeader."Contract No.", ServiceContractHeader."Last Invoice Date"),
                                                                      ServiceContractHeader."Last Invoice Date");
                ServiceContractHeader."Last Invoice Period End" := CalcDate(FormulaFechaFinMesComienzoFact(ServiceContractHeader."Contract No.", ServiceContractHeader."Last Invoice Period End"),
                                                                          ServiceContractHeader."Last Invoice Period End");
            end else begin
                if ServiceContractHeader."Next Invoice Date" = 0D then
                    ServiceContractHeader."Next Invoice Date" := ServiceContractHeader."Last Invoice Period End"
                else
                    ServiceContractHeader."Next Invoice Date" := CalcDate(FormulaFechaFinMes(ServiceContractHeader."Contract No.", ServiceContractHeader."Next Invoice Date"),
                                                                          ServiceContractHeader."Next Invoice Date");
                ServiceContractHeader."Last Invoice Date" := CalcDate(FormulaFechaFinMes(ServiceContractHeader."Contract No.", ServiceContractHeader."Last Invoice Date"),
                                                                     ServiceContractHeader."Last Invoice Date");
                ServiceContractHeader."Last Invoice Period End" := CalcDate(FormulaFechaFinMesComienzoFact(ServiceContractHeader."Contract No.", ServiceContractHeader."Last Invoice Period End"),
                                                                         ServiceContractHeader."Last Invoice Period End");
            end;
        end;

        ServiceContractHeader.Validate("Next Invoice Date");
        ServiceContractHeader.Modify(true);
        ServiceContractHeader.Validate("Next Invoice Date");
        ServiceContractHeader.Modify(true);

        if ServiceHeader.Get(RecSalesline."Document Type", RecSalesline."Document No.") then begin
            if ServiceHeader."Customer Order No._LDR" <> '' then begin
                ServiceContractHeader.Validate("Customer Order No._LDR", ServiceHeader."Customer Order No._LDR");
                ServiceContractHeader.Modify(true);
            end;
        end;

        //if Estado then
        //LockOpenServContract.LockServContract(ServiceContractHeader);
    end;

    procedure FormulaFechaFinMesComienzoFact(NContrato: Code[20]; ReferenceDate: Date) Formula: Text[30];
    var
        ServiceContractHeader: Record "Service Contract Header";
    begin
        Clear(ServiceContractHeader);
        ServiceContractHeader.Get(ServiceContractHeader."Contract Type"::Contract, NContrato);
        case ServiceContractHeader."Invoice Period" of
            ServiceContractHeader."Invoice Period"::Month:
                Formula := '<+CM>';
            ServiceContractHeader."Invoice Period"::"Two Months":
                Formula := '<+CM+1M>';
            ServiceContractHeader."Invoice Period"::Quarter:
                Formula := '<+CM+2M>';
            ServiceContractHeader."Invoice Period"::"Half Year":
                Formula := '<CM+5M>';
            ServiceContractHeader."Invoice Period"::Year:
                Formula := '<+CM+11M>';
        //ServiceContractHeader."Invoice Period"::"Third of a year":
        //Formula := '<CM+3M>';
        //ServiceContractHeader."Invoice Period"::Fortnight:
        /*begin
            if Date2DMY(ReferenceDate, 1) <= 15 then
                exit('<-CM+14D>')
            else
                exit('<CM>');
        end;*/
        end;
    end;

    procedure FormulaFechaFinMes(NContrato: Code[20]; ReferenceDate: Date) Formula: Text[30];
    var
        ServiceContractHeader: Record "Service Contract Header";
    begin
        Clear(ServiceContractHeader);
        ServiceContractHeader.Get(ServiceContractHeader."Contract Type"::Contract, NContrato);
        case ServiceContractHeader."Invoice Period" of
            ServiceContractHeader."Invoice Period"::Month:
                Formula := '<-1M+CM>';
            ServiceContractHeader."Invoice Period"::"Two Months":
                Formula := '<-2M+CM>';
            ServiceContractHeader."Invoice Period"::Quarter:
                Formula := '<-3M+CM>';
            ServiceContractHeader."Invoice Period"::"Half Year":
                Formula := '<-6M+CM>';
            ServiceContractHeader."Invoice Period"::Year:
                Formula := '<-12M+CM>';
        //ServiceContractHeader."Invoice Period"::"Third of a year":
        //Formula := '<-4M+CM>';
        //ServiceContractHeader."Invoice Period"::Fortnight:
        /*begin
            if Date2DMY(ReferenceDate, 1) <= 15 then
                exit('<-1M+CM>')
            else
                exit('<-CM+14D>');
        end;*/
        end;
    end;

    procedure FormulaFechaInicioMes(NContrato: Code[20]; ReferenceDate: Date) Formula: Text[30];
    var
        ServiceContractHeader: Record "Service Contract Header";
    begin
        Clear(ServiceContractHeader);
        ServiceContractHeader.Get(ServiceContractHeader."Contract Type"::Contract, NContrato);

        if ServiceContractHeader.Prepaid then begin
            case ServiceContractHeader."Invoice Period" of
                ServiceContractHeader."Invoice Period"::Month:
                    Formula := '<-1M-CM>';
                ServiceContractHeader."Invoice Period"::"Two Months":
                    Formula := '<-2M-CM>';
                ServiceContractHeader."Invoice Period"::Quarter:
                    Formula := '<-3M-CM>';
                ServiceContractHeader."Invoice Period"::"Half Year":
                    Formula := '<-6M-CM>';
                ServiceContractHeader."Invoice Period"::Year:
                    Formula := '<-12M-CM>';
            //ServiceContractHeader."Invoice Period"::"Third of a year":
            //Formula := '<-4M-CM>';
            //ServiceContractHeader."Invoice Period"::Fortnight:
            /*if Date2DMY(ReferenceDate, 1) <= 15 then
                exit('<-1M-CM+15D>')
            else
                exit('<-CM>');*/
            end;
        end else begin
            case ServiceContractHeader."Invoice Period" of
                ServiceContractHeader."Invoice Period"::Month:
                    Formula := '<-CM-1D>';
                ServiceContractHeader."Invoice Period"::"Two Months":
                    Formula := '<+CM-2M>';
                ServiceContractHeader."Invoice Period"::Quarter:
                    Formula := '<+CM-3M>';
                ServiceContractHeader."Invoice Period"::"Half Year":
                    Formula := '<+CM-6M>';
                ServiceContractHeader."Invoice Period"::Year:
                    Formula := '<+CM-12M>';
            //ServiceContractHeader."Invoice Period"::"Third of a year":
            //Formula := '<+CM-4M>';
            //ServiceContractHeader."Invoice Period"::Fortnight:
            /*if Date2DMY(ReferenceDate, 1) <= 15 then
                exit('<-1M+CM>')
            else
                exit('<-CM+14D>');*/
            end;
        end;
    end;

    procedure DeshacerConcepto(RecSalesline: Record "Service Line");
    var
        ServiceContractHeader: Record "Service Contract Header";
        ServiceEntry: Record "Service Ledger Entry";
        ServiceConcept: Record "Contract Concepts_LDR";
        ServLine2: Record "Service Line";
    begin
        ServiceContractHeader.Get(ServiceContractHeader."Contract Type"::Contract, RecSalesline."Contract No.");

        ServiceContractHeader.CalcFields("No. of Posted Invoices");
        ServiceContractHeader.CalcFields("No. of Unposted Invoices");

        Clear(ServiceEntry);
        if not ServiceEntry.Get(RecSalesline."Appl.-to Service Entry") then
            Error(Text0632,
               ServiceEntry."Entry No.",
               "No.");

        if not ServiceEntry."Service Contract Concept Entry_LDR" then
            exit;

        Clear(ServiceConcept);
        ServiceConcept.SetRange(ServiceConcept."Contract No.", ServiceContractHeader."Contract No.");
        ServiceConcept.SetRange(ServiceConcept."Contract Type", ServiceContractHeader."Contract Type");
        ServiceConcept.SetRange(ServiceConcept."Contract Line No.", ServiceEntry."Service Contract Line No._LDR");
        ServiceConcept.SetRange(ServiceConcept."Line No.", ServiceEntry."Service Contract Concept Line_LDR");
        if ServiceConcept.Find('-') then begin
            ServiceConcept.Invoiced := false;
            ServiceConcept.Modify();
        end;

        Clear(ServLine2);
        ServLine2.SetRange("Document No.", RecSalesline."Document No.");
        ServLine2.SetRange("Document Type", RecSalesline."Document Type");
        ServLine2.SetRange("Contract No.", RecSalesline."Contract No.");
        ServLine2.SetRange("Contract Line No._LDR", RecSalesline."Contract Line No._LDR");
        ServLine2.SetFilter("Contract Concept Line No._LDR", '%1', 0);
        if ServLine2.IsEmpty() then begin
            if (ServiceContractHeader."No. of Posted Invoices" = 0) and
               (ServiceContractHeader."No. of Unposted Invoices" = 1) then begin

                Clear(ServiceContractLine);
                ServiceContractLine.SetRange("Contract Type", ServiceContractHeader."Contract Type");
                ServiceContractLine.SetRange("Contract No.", ServiceContractHeader."Contract No.");
                ServiceContractLine.SetRange(ServiceContractLine."Line No.", ServiceEntry."Service Contract Line No._LDR");
                if ServiceContractLine.FindSet() then begin
                    ServiceContractLine.Validate("Invoiced to Date", 0D);
                    ServiceContractLine.Modify();
                end;
            end else begin
                Clear(ServiceContractLine);
                ServiceContractLine.SetRange("Contract Type", ServiceContractHeader."Contract Type");
                ServiceContractLine.SetRange("Contract No.", ServiceContractHeader."Contract No.");
                ServiceContractLine.SetRange(ServiceContractLine."Line No.", ServiceEntry."Service Contract Line No._LDR");
                if ServiceContractLine.FindSet() then begin
                    if ServiceContractHeader.Lineal_LDR then
                        ServiceContractLine."Invoiced to Date" := ServiceEntry."Undo Serv. Contract Inv. Date_LDR"
                    else
                        ServiceContractLine."Invoiced to Date" := CalcDate(FormulaFechaFinMes(ServiceContractHeader."Contract No.", ServiceContractLine."Invoiced to Date")
                                                                       , ServiceContractLine."Invoiced to Date");
                    if (ServiceContractHeader.Prepaid) and
                       (ServiceContractLine."Starting Date" > ServiceContractLine."Invoiced to Date") then
                        ServiceContractLine.Validate("Invoiced to Date", 0D);

                    ServiceContractLine.Modify();
                end;
            end;
        end;
    end;

    procedure ComprobarPedidoCompleto(bMostrarError: BoolEAN): BoolEAN;
    VAR
        ServiceOrderLine: Record "Purchase Line";
        txtPendiente: TextConst ENU = 'There is outstanding quantities on Service Order %1', ESP = 'Existen cantidades pendientes para el pedido de Servicio %1';
        txtEstado: TextConst ENU = 'Service Order %1 does not have Finished Status', ESP = 'El pedido de Servicio %1 no tiene el estado Terminado';
        txtPendienteFacturar: TextConst ENU = 'There is outstanding invoicing quantities on Service Order %1', ESP = 'Existen cantidades pendientes de facturar para el pedido de Servicio %1';
        PurchaseOrderLine: Record "Purchase Line";
        txtPedidoCompraPendiente: TextConst ENU = 'There are related non invoiced lines on purchase order No. %1', ESP = 'El Pedido de Compra No. %1 tiene líneas asociadas sin facturar';
        ServSetup: Record "Service Mgt. Setup";
        ServiceOrderItemLine: Record "Service Item Line";
        CraneMgtSetup: Record "Crane Mgt. Setup_LDR";
        ServItem: Record "Service Item";
        ServHeader: Record "Service Header";
        CraneServQForfaitCalendar: Record "Crane Serv Q. Forf Calend_LDR";
        CraneServiceQuoteOpLine: Record "Crane Servic Quote Op. Lin_LDR";
        CraneServiceQuoteHeader: Record "Crane Service Quote Header_LDR";
        Cust: Record Customer;
    begin
        if Status <> Status::Finished then
            if bMostrarError then
                Error(txtEstado, "No.")
            else
                exit(false);

        ServiceOrderLine.Reset();
        ServiceOrderLine.SetRange("Document Type", "Document Type");
        ServiceOrderLine.SetRange("Document No.", "No.");
        //ServiceOrderLine.SetRange(Chargeable, true);
        if ServiceOrderLine.FindSet() then begin
            ServiceOrderLine.SetFilter("Outstanding Quantity", '<>0');
            if not ServiceOrderLine.FindSet() then begin
                ServiceOrderLine.SetRange("Outstanding Quantity");
                ServiceOrderLine.SetFilter("Qty. to Invoice", '<>0');
                if ServiceOrderLine.Find('-') then begin
                    if bMostrarError then
                        Error(txtPendienteFacturar, "No.")
                    else
                        exit(false);
                end;
            end else begin
                if bMostrarError then
                    Error(txtPendiente, "No.")
                else
                    exit(false);
            end;
        end;

        ServiceOrderLine.Reset();
        ServiceOrderLine.SetRange("Document Type", "Document Type");
        ServiceOrderLine.SetRange("Document No.", "No.");
        //ServiceOrderLine.SetRange(Chargeable, false);
        if ServiceOrderLine.FindSet() then begin
            repeat
                //if ServiceOrderLine.Quantity <> ServiceOrderLine."Quantity Shipped" then begin
                if bMostrarError then
                    Error(txtPendiente, "No.")
                else
                    exit(false);
                //end else
                if ServiceOrderLine."Qty. to Invoice" <> 0 then begin
                    if bMostrarError then
                        Error(txtPendienteFacturar, "No.")
                    else
                        exit(false);
                end;
            until ServiceOrderLine.Next() = 0;
        end;

        ServSetup.Get();
        if not ServSetup."Order Post not Purch. Test_LDR" then begin
            PurchaseOrderLine.Reset();
            PurchaseOrderLine.SetRange("Document Type", PurchaseOrderLine."Document Type"::Order);
            PurchaseOrderLine.SetRange("Service Order No._LDR", "No.");
            PurchaseOrderLine.SetFilter("Qty. Rcd. Not Invoiced", '<>%1', 0);
            if PurchaseOrderLine.FindFirst() then begin
                if bMostrarError then
                    Error(txtPedidoCompraPendiente, PurchaseOrderLine."Document No.")
                else
                    exit(false);
            end;
        end;

        CraneMgtSetup.Get();
        ServiceOrderItemLine.Reset();
        ServiceOrderItemLine.SetRange("Document Type", "Document Type");
        ServiceOrderItemLine.SetRange("Document No.", "No.");
        if ServiceOrderItemLine.FindSet() then
            repeat
                if Rec."Service Order Type" in [CraneMgtSetup."Serv. Order Type - Crane",
                                                CraneMgtSetup."Serv. Order Type - Platf. Del.",
                                                CraneMgtSetup."Serv. Order Type - Platf. Pick"] then begin
                    if ServiceOrderItemLine."Repair Status Code" <> CraneMgtSetup."Ready to Invoice Repair Status" then
                        if bMostrarError then
                            Error(Text50001, CraneMgtSetup."Ready to Invoice Repair Status")
                        else
                            exit(false);

                    Clear(Cust);
                    Cust.Get("Customer No.");
                    // if not Cust."Internal Customer" then begin
                    Clear(CraneServiceQuoteHeader);
                    CraneServiceQuoteHeader.Get(ServiceOrderItemLine."Crane Service Quote No._LDR");
                    if CraneServiceQuoteHeader."Quote Type" = CraneServiceQuoteHeader."Quote Type"::Forfait then begin
                        Clear(CraneServQForfaitCalendar);
                        CraneServQForfaitCalendar.SetRange("Quote No.", ServiceOrderItemLine."Crane Service Quote No._LDR");
                        CraneServQForfaitCalendar.SetRange("Quote Op. Line No.", ServiceOrderItemLine."Crane Serv. Quote Op. Line No_LDR");
                        if CraneServQForfaitCalendar.FindSet() then begin
                            repeat
                                if CraneServQForfaitCalendar.Processed then begin
                                    if ServHeader.Get(ServHeader."Document Type"::Invoice, CraneServQForfaitCalendar."Invoice No.") then begin
                                        CraneServiceQuoteOpLine.Get(ServiceOrderItemLine."Crane Service Quote No._LDR", ServiceOrderItemLine."Crane Serv. Quote Op. Line No_LDR");
                                        if bMostrarError then
                                            Error(Text50004, CraneServiceQuoteOpLine."Operation No.", CraneServiceQuoteOpLine."Quote No.", Format(CraneServQForfaitCalendar."Scheduled Date"))
                                        else
                                            exit(false);
                                    end;
                                end else begin
                                    CraneServiceQuoteOpLine.Get(ServiceOrderItemLine."Crane Service Quote No._LDR", ServiceOrderItemLine."Crane Serv. Quote Op. Line No_LDR");
                                    if bMostrarError then
                                        Error(Text50003, CraneServiceQuoteOpLine."Operation No.", CraneServiceQuoteOpLine."Quote No.", Format(CraneServQForfaitCalendar."Scheduled Date"))
                                    else
                                        exit(false);
                                end;
                            until CraneServQForfaitCalendar.Next() = 0;
                        end;
                    end;
                end;
                //end else begin
                ServItem.Get(ServiceOrderItemLine."Service Item No.");
                if not ServItem."Without Counters_LDR" then begin
                    if ServiceOrderItemLine."No of hours_LDR" = 0 then
                        if bMostrarError then
                            Error(Text50002)
                        else
                            exit(false);
                end;

            //end;
            until ServiceOrderItemLine.Next() = 0;
        exit(true);
    end;

    procedure CalcServiceOrderResponseTimes();
    var
        ServiceItemLine: Record "Service Item Line";
        ServOrderMgt: Codeunit "ServOrderManagement";
    begin
        ServiceItemLine.Reset();
        ;
        ServiceItemLine.SetRange("Document Type", Rec."Document Type");
        ServiceItemLine.SetRange("Document No.", Rec."No.");
        if ServiceItemLine.FindSet() then begin
            repeat
            //ServiceItemLine.UpdateStartEndDateTimes();
            until ServiceItemLine.Next() = 0;
            UpdateResponseDateTime;
            //UpdateStartingDateTime();
            //UpdateFinishingDateTime();
            "Actual Response Time (Hours)" := ServOrderMgt.CalcServTime(
                  "Order Date", "Order Time", "Starting Date", "Starting Time", "Contract No.", "Contract Serv. Hours Exist");
            "Service Time (Hours)" := ServOrderMgt.CalcServTime(
                "Starting Date", "Starting Time", "Finishing Date", "Finishing Time", "Contract No.", "Contract Serv. Hours Exist");
            Modify();
        end;
    end;

    procedure CreateAlarmFor(Type: Integer);
    var
        ServItemLine: Record "Service Item Line";
        NewAlarm: Record "Alarms_LDR";
    //AlarmCard: Page 70104;
    begin
        case Type of
            1:
                begin
                    TestField("Customer No.");

                    Clear(NewAlarm);
                    NewAlarm."Alarm No." := NewAlarm.GetNextAlarmNo;
                    NewAlarm."Start Date" := WorkDate;
                    NewAlarm."Source Type" := NewAlarm."Source Type"::Customer;
                    NewAlarm."Source No." := "Customer No.";
                    if "Ship-to Code" <> '' then
                        NewAlarm."Source No. 2" := "Ship-to Code";
                    NewAlarm."User ID" := UserId;
                    NewAlarm."Serv. Order" := true;
                    NewAlarm.Insert(true);
                end;
            2:
                begin
                    Clear(ServItemLine);
                    ServItemLine.SetRange(ServItemLine."Document Type", "Document Type");
                    ServItemLine.SetRange(ServItemLine."Document No.", "No.");
                    if ServItemLine.FindFirst() then
                        ServItemLine.TestField("Service Item No.");


                    Clear(NewAlarm);
                    NewAlarm."Alarm No." := NewAlarm.GetNextAlarmNo;
                    NewAlarm."Start Date" := WorkDate;
                    NewAlarm."Source Type" := NewAlarm."Source Type"::"Service Item";
                    NewAlarm."Source No." := ServItemLine."Service Item No.";
                    NewAlarm."User ID" := UserId;
                    NewAlarm."Serv. Order" := true;
                    NewAlarm.Insert(true);
                end;
            3:
                begin
                    TestField("Contract No.");

                    Clear(NewAlarm);
                    NewAlarm."Alarm No." := NewAlarm.GetNextAlarmNo;
                    NewAlarm."Start Date" := WorkDate;
                    NewAlarm."Source Type" := NewAlarm."Source Type"::Contract;
                    NewAlarm."Source No." := "Contract No.";
                    NewAlarm."User ID" := UserId;
                    NewAlarm."Serv. Order" := true;
                    NewAlarm.Insert(true);
                end;
        end;

        //Clear(AlarmCard);
        //AlarmCard.SetTableView(NewAlarm);
        //AlarmCard.SetRecord(NewAlarm);
        //AlarmCard.Run();
    end;

    local procedure ServiceShipUpdate();
    var
        ServShipHeader: Record "Service Shipment Header";
    begin
        Clear(ServShipHeader);
        ServShipHeader.SetRange("Order No.", "No.");
        if ServShipHeader.FindSet() then begin
            repeat
                ServShipHeader.Retained_LDR := Retained_LDR;
                ServShipHeader.Validate("Customer Order No._LDR", "Customer Order No._LDR");
                ServShipHeader.Modify(true);
            until ServShipHeader.Next() = 0;
        end;
    end;

    local procedure UpdatePmtDiscDate();
    begin
        if "Payment Discount %" = 0 then
            if "Document Type" <> "Document Type"::"Credit Memo" then
                "Pmt. Discount Date" := "Due Date";
    end;
}