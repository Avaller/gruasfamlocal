/// <summary>
/// tableextension 50066 "Service Item Line_LDR"
/// </summary>
tableextension 50066 "Service Item Line_LDR" extends "Service Item Line"
{
    fields
    {
        field(50030; "Service Item Type_LDR"; Option)
        {
            CalcFormula = Lookup("Service Item"."Service Item Type_LDR" WHERE("No." = FIELD("Service Item No.")));
            Caption = 'Tipo Producto Servicio';
            Editable = false;
            FieldClass = FlowField;
            OptionCaption = 'Grúa,Plataforma';
            OptionMembers = Crane,Platform;
        }
        field(50049; "Operation Code_LDR"; Code[20])
        {
            Caption = 'Código Operación';
            DataClassification = ToBeClassified;
        }
        field(50050; "Crane Service Quote No._LDR"; Code[20])
        {
            Caption = 'Código Oferta Servicio Grúa';
            DataClassification = ToBeClassified;
            TableRelation = "Crane Service Quote Header_LDR"."Quote no." WHERE("Historical" = CONST(false));
        }
        field(50051; "Service Item Tariff No._LDR"; Code[20])
        {
            Caption = 'Código Tarifa Producto Servicio';
            DataClassification = ToBeClassified;
            TableRelation = "Service Item Rate Header_LDR";
        }
        field(50052; "Sent to Device_LDR"; Boolean)
        {
            Caption = 'Enviado a Dispositivo';
            DataClassification = ToBeClassified;
        }
        field(50053; "Closed by Device_LDR"; Boolean)
        {
            Caption = 'Cerrado por Dispositivo';
            DataClassification = ToBeClassified;
        }
        field(50054; "Requested Starting Date_LDR"; Date)
        {
            Caption = 'Fecha Inicio Solicitada';
            DataClassification = ToBeClassified;
        }
        field(50055; "Requested Starting Time_LDR"; Time)
        {
            Caption = 'Hora Inicio Solicitada';
            DataClassification = ToBeClassified;
        }
        field(50056; "Requested Ending Date_LDR"; Date)
        {
            Caption = 'Fecha Final Solicitada';
            DataClassification = ToBeClassified;
        }
        field(50057; "Requested Ending Time_LDR"; Time)
        {
            Caption = 'Hora Final Solicitada';
            DataClassification = ToBeClassified;
        }
        field(50058; "Service Inv. Group No._LDR"; Code[10])
        {
            Caption = 'Código Grupo Facturación';
            DataClassification = ToBeClassified;
            TableRelation = "Service Item Invoice Group_LDR";

            trigger OnValidate()
            var
                CraneServQOpInvGLine: Record "Crane Serv Q Op Inv G Line_LDR";
                ServiceHeader: Record "Service Header";
                CraneServiceQuoteOpLine: Record "Crane Servic Quote Op. Lin_LDR";
            begin
                if "Crane Service Quote No._LDR" <> '' then begin
                    Clear(CraneServQOpInvGLine);
                    CraneServQOpInvGLine.SetRange("Quote No.", "Crane Service Quote No._LDR");
                    CraneServQOpInvGLine.SetRange("Invoice Group No.", "Service Inv. Group No._LDR");
                    CraneServQOpInvGLine.SetRange("Operation Line No.", "Crane Serv. Quote Op. Line No_LDR");
                    if CraneServQOpInvGLine.FindFirst() then begin
                        "Service Item Tariff No._LDR" := CraneServQOpInvGLine."Rate No.";
                        ServiceHeader.Get("Document Type", "Document No.");
                        ServiceHeader."Service Item Rate No._LDR" := "Service Item Tariff No._LDR";
                        ServiceHeader.Modify();
                    end else begin
                        CraneServiceQuoteOpLine.Get("Crane Service Quote No._LDR", "Crane Serv. Quote Op. Line No_LDR");
                        Error(Text50009, "Service Inv. Group No._LDR", CraneServiceQuoteOpLine."Operation Description", "Crane Service Quote No._LDR");
                    end;
                end;
            end;
        }
        field(50059; "Crane Serv. Quote Op. Line No_LDR"; Integer)
        {
            Caption = 'Nº Línea Opción Oferta Servicio Grúa';
            DataClassification = ToBeClassified;
        }
        field(50060; "Role Center Filter_LDR"; Boolean)
        {
            CalcFormula = Lookup("Service Header"."Role Center Filter_LDR" WHERE("Document Type" = FIELD("Document Type"),
            "No." = field("Document No.")));
            Caption = 'Filtro Role Center';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50061; "Exported to Device_LDR"; Boolean)
        {
            Caption = 'Exportado a Dispositivo';
            DataClassification = ToBeClassified;
        }
        field(50062; "Service Item Code Filter_LDR"; Code[20])
        {
            Caption = 'Filtro Código Producto Servicio';
            FieldClass = FlowFilter;
            TableRelation = "Service Item"."No.";
        }
        field(50063; "Use Saturdays_LDR"; Boolean)
        {
            Caption = 'Utilizar Sábados';
            DataClassification = ToBeClassified;
        }
        field(50064; "Use Sundays_LDR"; Boolean)
        {
            Caption = 'Utilizar Domingos';
            DataClassification = ToBeClassified;
        }
        field(50065; "Service Inv. Group Description_LDR"; Text[50])
        {
            CalcFormula = Lookup("Service Item Invoice Group_LDR"."Description" WHERE("Code" = FIELD("Service Inv. Group No._LDR")));
            Caption = 'Descripción Grupo Facturación';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50066; "Original Pickup Date_LDR"; Date)
        {
            Caption = 'Fecha Recogida Original';
            DataClassification = ToBeClassified;
        }
        field(50067; "Explotation Customer No._LDR"; Code[20])
        {
            Caption = 'Nº Cliente Explotación';
            DataClassification = ToBeClassified;
            TableRelation = "Customer";
        }
        field(50068; "Serv. Item Planner No_LDR"; Code[20])
        {
            CalcFormula = Lookup("Service Item"."Planner No_LDR" WHERE("No." = FIELD("Service Item No.")));
            Caption = 'Nº Planificador';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50069; "Old Worksheet No._LDR"; Code[20])
        {
            Caption = 'Nº Parte Antiguo';
            DataClassification = ToBeClassified;
        }
        field(50070; "Serv. Item Counter Code_LDR"; Integer)
        {
            Caption = 'Código Contador Producto Servicio';
            DataClassification = ToBeClassified;
            TableRelation = "Service Item Counter_LDR"."Counter No." WHERE("Code" = FIELD("Service Item No."));
        }
        field(50071; "Serv. Item Counter Description_LDR"; Text[50])
        {
            CalcFormula = Lookup("Service Item Counter_LDR"."Description" WHERE("Code" = FIELD("Service Item No."), "Counter No." = FIELD("Serv. Item Counter Code_LDR")));
            Caption = 'Descripción Contador Producto Servicio';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50072; "Service Task Code_LDR"; Code[20])
        {
            Caption = 'Código Tarea Servicio';
            DataClassification = ToBeClassified;
            Description = 'Permite Almacenar la Tarea a Realizar';
            //TableRelation = Table70001.Field1; 

            trigger OnValidate()
            var
            //TareasServicio: Record 70001;
            begin
                TestField("Service Item No.");

                //Clear(TareasServicio);
                //TareasServicio.SetRange(TareasServicio.Code, "Service Task Code_LDR");
                //if TareasServicio.Find('-') then;
            end;

        }
        field(50073; nonfacturable_LDR; Boolean)
        {
            Caption = 'Nº Facturable';
            DataClassification = ToBeClassified;
            Description = 'Indica si se Aplica 100% Descuento a la Hoja de Trabajo';

            trigger OnValidate()
            var
                ServInvLine: Record "Service Line";
                txtHayLineas: TextConst ENU = 'It is not posible to modify %1 value because exist worksheet lines with discount not equal to %2 %.', ESP = 'No es posible modificar el valor del campo %1 por que existen líneas de hoja de trabajo asociadas con un porcentaje de descuento distino a %2 %.';
            begin
                if nonfacturable_LDR <> xRec.nonfacturable_LDR then BEGIN
                    Clear(ServInvLine);
                    ServInvLine.SetRange(ServInvLine."Document Type", "Document Type");
                    ServInvLine.SetRange(ServInvLine."Document No.", "Document No.");
                    if nonfacturable_LDR then begin
                        ServInvLine.SetFilter(ServInvLine."Line Discount %", '<%1', 100);
                    end else begin
                        ServInvLine.SetFilter(ServInvLine."Line Discount %", '>%1', 0);
                    end;
                    if ServInvLine.Find('-') then begin
                        if nonfacturable_LDR then begin
                            Error(txtHayLineas, FieldCaption(nonfacturable_LDR), 100);
                        end else begin
                            Error(txtHayLineas, FieldCaption(nonfacturable_LDR), 0);
                        end;
                    end;
                end;
            end;
        }
        field(50074; "No of hours_LDR"; Integer)
        {
            Caption = 'Valor Contador';
            DataClassification = ToBeClassified;
            Description = 'Nº Horas de la Máquina';
        }
        field(50075; "Quote No._LDR"; Code[20])
        {
            Caption = 'Nº Oferta';
            DataClassification = ToBeClassified;
            Description = 'Nº Oferta';
            Editable = false;
        }
        field(50076; "Quote Line No._LDR"; Integer)
        {
            Caption = 'Nº Línea Oferta';
            DataClassification = ToBeClassified;
            Description = 'Nº Línea Oferta';
            Editable = false;
        }
        field(50077; "Warranty Generated_LDR"; Boolean)
        {
            Caption = 'Garantía Tramitada';
            DataClassification = ToBeClassified;
            Description = 'Garantía Tramitada';
            Editable = false;
        }
        field(50078; "Warranty No._LDR"; Code[20])
        {
            Caption = 'Nº Garantía';
            DataClassification = ToBeClassified;
            Description = 'Nº Garantía';
            Editable = false;
        }
        field(50079; "Source Type_LDR"; Option)
        {
            Caption = 'Tipo Origen';
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Transfer';
            OptionMembers = Transfer;
        }
        field(50080; "Service Order Description_LDR"; Text[50])
        {
            CalcFormula = Lookup("Service Header"."Description" WHERE("Document Type" = FIELD("Document Type"),
            "No." = FIELD("Document No.")));
            Caption = 'Descripción Pedido';
            Description = 'Descripción del PS';
            FieldClass = FlowField;
        }
        field(50081; "Service Order Shortcut Dim 1_LDR"; Code[20])
        {
            CalcFormula = Lookup("Service Header"."Shortcut Dimension 1 Code" WHERE("Document Type" = FIELD("Document Type"),
            "No." = FIELD("Document No.")));
            Caption = 'Código Dimensión Acceso Directo 1';
            CaptionClass = '1,2,1';
            Description = 'Código Dimensión Acceso Directo 1';
            FieldClass = FlowField;
        }
        field(50082; "Service Order Shortcut Dim 2_LDR"; Code[20])
        {
            CalcFormula = Lookup("Service Header"."Shortcut Dimension 2 Code" WHERE("Document Type" = FIELD("Document Type"),
            "No." = FIELD("Document No.")));
            Caption = 'Código Dimensión Acceso Directo 2';
            CaptionClass = '1,2,2';
            Description = 'Código Dimensión Acceso Directo 2';
            FieldClass = FlowField;
        }
        field(50083; "Existe Dto_LDR"; Boolean)
        {
            CalcFormula = Exist("Service Line" WHERE("Document No." = FIELD("Document No."), "Service Item Line No." = FIELD("Line No."),
            "Line Discount %" = FILTER(<> 0)));
            Caption = 'Existe Descuento';
            Description = 'Existe Descuento en la Hoja de Trabajo';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50084; "Warranty in effect_LDR"; Boolean)
        {
            Caption = 'Garantía en Vigor Fabricante';
            DataClassification = ToBeClassified;
            Description = 'Garantía en Vigor Fabricante';
            Editable = false;
        }
        field(50085; "Manuf. Warranty Initial Date_LDR"; Date)
        {
            Caption = 'Fecha Inicial Garantía Fabricante';
            DataClassification = ToBeClassified;
            Description = 'Fecha Inicial Garantía Fabricante';
            Editable = false;
        }
        field(50086; "Manuf. Warranty End Date_LDR"; Date)
        {
            Caption = 'Fecha Final Garantía Fabricante';
            DataClassification = ToBeClassified;
            Description = 'Fecha Final Garantía Fabricante';
            Editable = false;
        }
        field(50087; "Manuf. Warranty Type_LDR"; Option)
        {
            Caption = 'Tipo Garantía Fabricante';
            DataClassification = ToBeClassified;
            Description = 'Tipo Garantía Fabricante';
            OptionCaption = 'Garantía,Petición de acuerdo';
            OptionMembers = "Warranty","According request";
        }
        field(50088; "Serive Order Type_LDR"; Code[10])
        {
            CalcFormula = Lookup("Service Header"."Service Order Type" WHERE("Document Type" = FILTER("Order"),
            "No." = FIELD("Document No.")));
            Caption = 'Tipo Pedido Servicio';
            Description = 'Tipo Pedido Servicio';
            FieldClass = FlowField;
        }
        field(50089; "Reval Service Item_LDR"; Boolean)
        {
            Caption = 'Revalorizar Máquina';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                ServiceMgtSetup: Record "Service Mgt. Setup";
                Serviceheader: Record "Service Header";
                ServItem: Record "Service Item";
            begin
                Serviceheader.Get("Document Type", "Document No.");
                Serviceheader.TestField("Service Order Type");

                if "Service Item No." <> '' then begin
                    ServItem.Get("Service Item No.");
                    if not ServItem.Own_LDR then
                        Error(TextNoespropia);
                end;

                ServiceMgtSetup.Get();
                if ServiceMgtSetup."Assembly Service Order Type_LDR" = Serviceheader."Service Order Type" then
                    Error(TextErrorMontaje);
            end;
        }
        field(50090; "Service Zone Code_LDR"; Code[10])
        {
            CalcFormula = Lookup("Service Header"."Service Zone Code" WHERE("Document Type" = FIELD("Document Type"),
            "No." = FIELD("Document No.")));
            Caption = 'Código Zona Servicio';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50091; "No of Active Service Orders_LDR"; Integer)
        {
            CalcFormula = Count("Service Item Line" WHERE("Document Type" = CONST("Order"),
             "Service Item No." = FIELD("Service Item No.")));
            Caption = 'Nº Pedidos Activos';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50092; "Service Order Date_LDR"; Date)
        {
            CalcFormula = Lookup("Service Header"."Order Date" WHERE("Document Type" = FILTER("Order"),
            "No." = FIELD("Document No.")));
            Caption = 'Fecha Pedido';
            Description = 'Fecha Pedido';
            FieldClass = FlowField;
        }
        field(50093; "Actual Location Cust No._LDR"; Code[20])
        {
            CalcFormula = Lookup("Service Item"."Customer No." WHERE("No." = FIELD("Service Item No.")));
            Caption = 'Nº Cliente Ubicación Actual';
            FieldClass = FlowField;
        }
        field(50094; "Actual Location Ship to Code_LDR"; Code[20])
        {
            CalcFormula = Lookup("Service Item"."Ship-to Code" WHERE("No." = FIELD("Service Item No.")));
            Caption = 'Código Dirección Envío Ubicación Actual';
            FieldClass = FlowField;
        }
        field(50095; "Default Invoice Lines Created_LDR"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50096; "Allocated Date_LDR"; Date)
        {
            CalcFormula = Lookup("Service Order Allocation"."Allocation Date" WHERE("Document Type" = FIELD("Document Type"),
            "Document No." = FIELD("Document No."), "Service Item Line No." = FIELD("Line No."),
            "Allocation Date" = FIELD("Date Filter"), "Resource No." = FIELD("Resource Filter"), "Status" = FILTER("Active"),
            "Resource Group No." = FIELD("Resource Group Filter")));
            Caption = 'Fecha Asignación';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50097; "Assignation Priority_LDR"; Integer)
        {
            CalcFormula = Lookup("Service Order Allocation"."Assignation Priority_LDR" WHERE("Document Type" = FIELD("Document Type"), "Document No." = FIELD("Document No."), "Service Item Line No." = FIELD("Line No."), "Allocation Date" = FIELD("Date Filter"), "Resource No." = FIELD("Resource Filter"), "Status" = FILTER("Active"), "Resource Group No." = FIELD("Resource Group Filter")));
            Caption = 'Prioridad Asignación';
            FieldClass = FlowField;
        }
        field(50098; "Historical Quote_LDR"; Boolean)
        {
            CalcFormula = Lookup("Service Header"."Historical Quote_LDR" WHERE("Document Type" = FIELD("Document Type"), "No." = field("Document No.")));
            Caption = 'Oferta Histórica';
            FieldClass = FlowField;
        }
        field(50099; "Order Type_LDR"; Option)
        {
            CalcFormula = Lookup("Service Header"."Order Type_LDR" WHERE("Document Type" = FILTER("Order"), "No." = FIELD("Document No.")));
            Caption = 'Tipo Pedido';
            FieldClass = FlowField;
            OptionMembers = FSI,FSIEC,FS,FSEC,FE,OFF;
        }
    }

    trigger OnAfterInsert()
    var
        ServItemLine: Record "Service Item Line";
    begin
        CraneMgtSetup.Get();
        ServItemLine.Reset();
        ServItemLine.SetRange("Document Type", "Document Type");
        ServItemLine.SetRange("Document No.", "Document No.");
        ServItemLine.SetRange("Repair Status Code", CraneMgtSetup."Ready to Invoice Repair Status");
        if ServItemLine.FindFirst() then
            Error(Text50008, CraneMgtSetup."Ready to Invoice Repair Status");
    end;

    trigger OnAfterDelete()
    var
        HideDialogBox: Boolean;
        ServOrderMgt: Codeunit "ServOrderManagement";
    begin
        if not HideDialogBox then begin
            ServOrderMgt.UpdateResponseDateTime(Rec, true);
            UpdateStartFinishDateTime("Document Type", "Document No.", "Line No.", CalcDate('<CY+1D-1Y>', WorkDate), 0T, 0D, 0T, true);
            ServOrderMgt.UpdatePriority(Rec, true);
        end;
    end;

    var
        bOmitirFacturarA: Boolean;
        TextErrorMontaje: TextConst ENU = 'It is not posible to revaluate a machine on an Assembly Service Order', ESP = 'No se puede revalorizar la máquina en un pedido de montaje';
        TextNoespropia: TextConst ENU = 'It is not posible to revaluate a not own machine', ESP = 'No se puede revalorizar una máquina que no es propia';
        CraneMgtSetup: Record "Crane Mgt. Setup_LDR";
        Text50008: TextConst ENU = 'Its not possible to add new lines when any Service Item Line has %1 repair Status', ESP = 'No se puede añadir ninguna línea nueva cuando cualquier línea de producto de servicio tiene el Cód. Estado Reparación %1';
        Text50009: TextConst ENU = 'El Grupo de Facturación %1, no existe en la Operación %2 de la Oferta %3', ESP = 'El Grupo de Facturación %1, no existe en la Operación %2 de la Oferta %3';

    procedure ActualizaFechas(var recLineaActual: Record "Service Line");
    var
        recLineasHoja: Record "Service Line";
        FechaMinima: Date;
        FechaMaxima: Date;
        HoraMinima: Time;
        HoraMaxima: Time;
        ServMgtSetup: Record "Service Mgt. Setup";
    begin
        exit;

        ServMgtSetup.Get();
        if ServMgtSetup."Basic Response Times_LDR" then exit;

        Clear(recLineasHoja);
        recLineasHoja.SetRange(recLineasHoja."Document Type", "Document Type");
        recLineasHoja.SetRange(recLineasHoja."Document No.", "Document No.");
        recLineasHoja.SetRange(recLineasHoja."Service Item Line No.", "Line No.");
        if recLineasHoja.Find('-') then begin
            repeat
                if (recLineasHoja."Posting Date" <= FechaMinima) or (FechaMinima = 0D) then begin
                    if (recLineasHoja."Posting Date" < FechaMinima) and (FechaMinima <> 0D) then
                        HoraMinima := 0T;
                    FechaMinima := recLineasHoja."Posting Date";
                    if recLineasHoja."Initial Time_LDR" <> 0T then begin
                        if (recLineasHoja."Initial Time_LDR" < HoraMinima) or (HoraMinima = 0T) then
                            HoraMinima := recLineasHoja."Initial Time_LDR"
                    end;
                end;

                if (recLineasHoja."Posting Date" >= FechaMaxima) or (FechaMaxima = 0D) then begin
                    if (recLineasHoja."Posting Date" > FechaMaxima) and (FechaMaxima <> 0D) then
                        HoraMaxima := 0T;
                    FechaMaxima := recLineasHoja."Posting Date";
                    if recLineasHoja."End Time_LDR" <> 0T then begin
                        if (recLineasHoja."End Time_LDR" > HoraMaxima) or (HoraMaxima = 0T) then
                            HoraMaxima := recLineasHoja."End Time_LDR"
                    end;
                end;

            until recLineasHoja.Next() = 0;
        end;

        if (recLineaActual."Posting Date" <= FechaMinima) or (FechaMinima = 0D) then begin
            if (recLineaActual."Posting Date" < FechaMinima) and (FechaMinima <> 0D) then
                HoraMinima := 0T;
            FechaMinima := recLineaActual."Posting Date";
            if recLineaActual."Initial Time_LDR" <> 0T then begin
                if (recLineaActual."Initial Time_LDR" < HoraMinima) or (HoraMinima = 0T) then
                    HoraMinima := recLineaActual."Initial Time_LDR"
            end;
        end;

        if (recLineaActual."Posting Date" >= FechaMaxima) or (FechaMaxima = 0D) then begin
            if (recLineaActual."Posting Date" > FechaMaxima) and (FechaMaxima <> 0D) then
                HoraMaxima := 0T;

            FechaMaxima := recLineaActual."Posting Date";
            if recLineaActual."End Time_LDR" <> 0T then begin
                if (recLineaActual."End Time_LDR" > HoraMaxima) or (HoraMaxima = 0T) then
                    HoraMaxima := recLineaActual."End Time_LDR"
            end;
        end;

        "Starting Date" := FechaMinima;
        "Starting Time" := HoraMinima;
        "Finishing Date" := FechaMaxima;
        "Finishing Time" := HoraMaxima;
        Modify();
    end;

    procedure bOmitirComprobarFacturarA(bValor: BoolEAN);
    begin
        bOmitirFacturarA := bValor;
    end;

    procedure CreateDefaultInvoiceLines();
    var
        Cust: Record "Customer";
        StdSalesLine: Record "Standard Sales Line";
        LineNo: Integer;
        ServInvoiceLine: Record "Service Line";
        ServSetup: Record "Service Mgt. Setup";
        DefaultCustSalesCode: Code[20];
    begin
        if "Line No." = 0 then
            exit;

        if "Default Invoice Lines Created_LDR" then
            exit;

        ServSetup.Get();

        DefaultCustSalesCode := '';
        if "Customer No." <> '' then begin
            Cust.Get("Customer No.");
            if Cust."Service Customer Sales Code_LDR" <> '' then begin
                DefaultCustSalesCode := Cust."Service Customer Sales Code_LDR";
            end else
                if ServSetup."Default Customer Sales Code_LDR" <> '' then begin
                    DefaultCustSalesCode := ServSetup."Default Customer Sales Code_LDR";
                end;
        end;

        "Default Invoice Lines Created_LDR" := true;
        Modify();

        if DefaultCustSalesCode = '' then
            exit;

        Clear(ServInvoiceLine);
        ServInvoiceLine.SetRange("Document Type", "Document Type");
        ServInvoiceLine.SetRange("Document No.", "Document No.");
        if ServInvoiceLine.FindLast then
            LineNo := ServInvoiceLine."Line No." + 10000;

        Clear(StdSalesLine);
        StdSalesLine.SetRange(StdSalesLine."Standard Sales Code", DefaultCustSalesCode);
        if StdSalesLine.FindSet() then begin
            repeat
                case StdSalesLine.Type of
                    StdSalesLine.Type::Item:
                        begin
                            ServInvoiceLine.Init();
                            ServInvoiceLine.Validate("Document Type", "Document Type");
                            ServInvoiceLine.Validate("Document No.", "Document No.");
                            ServInvoiceLine."Service Item Line No." := "Line No.";
                            ServInvoiceLine.Validate("Line No.", LineNo);
                            ServInvoiceLine.Insert(true);
                            ServInvoiceLine.Validate(ServInvoiceLine.Type, ServInvoiceLine.Type::Item);
                            ServInvoiceLine.Validate(ServInvoiceLine."No.", StdSalesLine."No.");
                            ServInvoiceLine.Validate(ServInvoiceLine."Unit of Measure Code", StdSalesLine."Unit of Measure Code");
                            ServInvoiceLine.Validate(ServInvoiceLine."Variant Code", StdSalesLine."Variant Code");
                            ServInvoiceLine."Replaced Item No." := '';
                            ServInvoiceLine."Component Line No." := 0;
                            ServInvoiceLine."Spare Part Action" := ServInvoiceLine."Spare Part Action"::" ";
                            ServInvoiceLine.Validate("Internal Quantity_LDR", StdSalesLine.Quantity);
                            ServInvoiceLine.Validate(Quantity, StdSalesLine.Quantity);
                            ServInvoiceLine.Validate(ServInvoiceLine."Posting Date", WorkDate);
                            ServInvoiceLine.Validate(ServInvoiceLine.Description, StdSalesLine.Description);
                            ServInvoiceLine.Modify(true);
                            LineNo := LineNo + 10000;
                        end;
                    // StdSalesLine.Type::"Service Cost":
                    //     begin
                    //         ServInvoiceLine.Init();
                    //         ServInvoiceLine.Validate("Document Type", "Document Type");
                    //         ServInvoiceLine.Validate("Document No.", "Document No.");
                    //         ServInvoiceLine."Service Item Line No." := "Line No.";
                    //         ServInvoiceLine.Validate("Line No.", LineNo);
                    //         ServInvoiceLine.Insert(true);
                    //         ServInvoiceLine.Validate(ServInvoiceLine.Type, ServInvoiceLine.Type::Cost);
                    //         ServInvoiceLine.Validate(ServInvoiceLine."No.", StdSalesLine."No.");
                    //         ServInvoiceLine.Validate(ServInvoiceLine."Unit of Measure Code", StdSalesLine."Unit of Measure Code");
                    //         ServInvoiceLine.Validate(ServInvoiceLine."Variant Code", StdSalesLine."Variant Code");
                    //         ServInvoiceLine."Replaced Item No." := '';
                    //         ServInvoiceLine."Component Line No." := 0;
                    //         ServInvoiceLine."Spare Part Action" := ServInvoiceLine."Spare Part Action"::" ";
                    //         ServInvoiceLine.Validate("Internal Quantity_LDR", StdSalesLine.Quantity);
                    //         ServInvoiceLine.Validate(Quantity, StdSalesLine.Quantity);
                    //         ServInvoiceLine.Validate(ServInvoiceLine."Posting Date", WorkDate);
                    //         ServInvoiceLine.Validate(ServInvoiceLine.Description, StdSalesLine.Description);
                    //         ServInvoiceLine.Modify(true);
                    //         LineNo := LineNo + 10000;
                    //     end;
                    StdSalesLine.Type::Resource:
                        begin
                            ServInvoiceLine.Init();
                            ServInvoiceLine.Validate("Document Type", "Document Type");
                            ServInvoiceLine.Validate("Document No.", "Document No.");
                            ServInvoiceLine."Service Item Line No." := "Line No.";
                            ServInvoiceLine.Validate("Line No.", LineNo);
                            ServInvoiceLine.Insert(true);
                            ServInvoiceLine.Validate(ServInvoiceLine.Type, ServInvoiceLine.Type::Resource);
                            ServInvoiceLine.Validate(ServInvoiceLine."No.", StdSalesLine."No.");
                            ServInvoiceLine.Validate(ServInvoiceLine."Unit of Measure Code", StdSalesLine."Unit of Measure Code");
                            ServInvoiceLine.Validate(ServInvoiceLine."Variant Code", StdSalesLine."Variant Code");
                            ServInvoiceLine."Replaced Item No." := '';
                            ServInvoiceLine."Component Line No." := 0;
                            ServInvoiceLine."Spare Part Action" := ServInvoiceLine."Spare Part Action"::" ";
                            ServInvoiceLine.Validate("Internal Quantity_LDR", StdSalesLine.Quantity);
                            ServInvoiceLine.Validate(Quantity, StdSalesLine.Quantity);
                            ServInvoiceLine.Validate(ServInvoiceLine."Posting Date", WorkDate);
                            ServInvoiceLine.Validate(ServInvoiceLine.Description, StdSalesLine.Description);
                            ServInvoiceLine.Modify(true);
                            LineNo := LineNo + 10000;
                        end;
                end;
            until StdSalesLine.Next() = 0;
        end;
    end;

    procedure UpdateStartEndDateTimes();
    var
        recLineasHoja: Record "Service Line";
        FechaMinima: Date;
        FechaMaxima: Date;
        HoraMinima: Time;
        HoraMaxima: Time;
    begin
        Clear(recLineasHoja);
        recLineasHoja.SetRange(recLineasHoja."Document Type", "Document Type");
        recLineasHoja.SetRange(recLineasHoja."Document No.", "Document No.");
        recLineasHoja.SetRange(recLineasHoja."Service Item Line No.", "Line No.");
        recLineasHoja.SetRange(recLineasHoja.Type, recLineasHoja.Type::Resource);
        if recLineasHoja.FindSet() then begin
            repeat
                if (recLineasHoja."Posting Date" <= FechaMinima) or (FechaMinima = 0D) then begin
                    if recLineasHoja."Initial Time_LDR" <> 0T then begin
                        if (recLineasHoja."Posting Date" < FechaMinima) and (FechaMinima <> 0D) then
                            HoraMinima := 0T;
                        FechaMinima := recLineasHoja."Posting Date";
                        if (recLineasHoja."Initial Time_LDR" < HoraMinima) or (HoraMinima = 0T) then
                            HoraMinima := recLineasHoja."Initial Time_LDR"
                    end;
                end;

                if (recLineasHoja."Posting Date" >= FechaMaxima) or (FechaMaxima = 0D) then begin
                    if recLineasHoja."End Time_LDR" <> 0T then begin
                        if (recLineasHoja."Posting Date" > FechaMaxima) and (FechaMaxima <> 0D) then
                            HoraMaxima := 0T;
                        FechaMaxima := recLineasHoja."Posting Date";
                        if (recLineasHoja."End Time_LDR" > HoraMaxima) or (HoraMaxima = 0T) then
                            HoraMaxima := recLineasHoja."End Time_LDR"
                    end;
                end;

            until recLineasHoja.Next() = 0;
        end;

        "Starting Date" := FechaMinima;
        "Starting Time" := HoraMinima;
        "Finishing Date" := FechaMaxima;
        "Finishing Time" := HoraMaxima;
        Modify();
    end;

    procedure ShowAdvancedComments(Type: Option "General","Fault","Resolution","Accessory","Internal","Service Item Loaner");
    var
        ServHeader: Record "Service Header";
        CduEditor: Report "CommentEditorMgt";
    begin
        ServHeader.Get("Document Type", "Document No.");
        ServHeader.TestField("Customer No.");
        TestField("Line No.");
        CduEditor.EditOrderComment(Database::"Service Header", "Document No.", "Line No.", Type);
    end;
}