/// <summary>
/// Codeunit Intercompany invoicing_LDR (ID 50010)
/// </summary>
codeunit 50010 "Intercompany invoicing_LDR"
{
    TableNo = "Service Header";

    /*
    trigger OnRun()
    var
        ServicePost: Codeunit "Service-Post";
        Ship: BoolEAN;
        Consume: BoolEAN;
        Invoice: BoolEAN;
        ServiceHeader: Record "Service Header";
        DummyServLine: Record "Service Line";
    begin
        ServiceOrderGenerate(Rec);

        CLEAR(ServiceHeader);                              //Registro automático de pedido traspasado
        ServiceHeader.GET(SourceType, DestinationNo);
        // CLEAR(ServiceLine);
        // ServiceLine.SETRANGE("Document Type", SourceType);
        // ServiceLine.SETRANGE("Document No.", DestinationNo);
        // IF ServiceLine.FINDSET THEN BEGIN

        //  Ship := TRUE;
        //  ServicePost.SetPreviewMode(TRUE);
        //  ServicePost.PostWithLines(ServiceHeader, DummyServLine, Ship, Consume, Invoice);

        // END;
    end;

    var
        ServiceItem: Record "Service Item";
        ServiceItemLine: Record "Service Item Line";
        SourceServiceItemLine: Record "Service Item Line";
        SourceServiceLine: Record "Service Line";
        SourceCompany: Text;
        SourceType: Option;
        SourceNo: Code[20];
        DestinationNo: Code[20];
        CompanyRelation: Record "Company Relation_LDR";
        CraneMgtSetup: Record "Crane Mgt. Setup_LDR";
        Txt001: Label 'Original Company: %1';
        Txt002: Label 'Original Invoice No.: %1';
        Txt003: Label 'Contract No.: %1';
        txtDescripcion: Label ' Veh. %1 - Nº %2 from %3';
        PostingDate: Date;
        StartingDate: Date;
        EndingDate: Date;
        txtEntrega: Label 'Delivery';
        txtRecogida: Label 'Pickup';
        txtDescripcion2: Label ' Veh. %1';

    /// <summary>
    /// ServiceOrderGenerate()
    /// </summary>
    procedure ServiceOrderGenerate(SourceServiceHeader: Record "Service Header")
    var
        ServiceMgtSetup: Record "Service Mgt. Setup";
        ServiceHeader: Record "Service Header";
        NoSeriesMgt: Codeunit "NoSeriesManagement";
    begin
        SourceCompany := SourceServiceHeader."Your Reference";
        SourceType := SourceServiceHeader."Document Type";
        SourceNo := SourceServiceHeader."No.";
        CLEAR(CompanyRelation);
        CompanyRelation.SETRANGE("Related Company", SourceCompany);

        CLEAR(ServiceHeader);                                         //Cabecera del pedido
        ServiceHeader.INIT;
        ServiceHeader.COPY(SourceServiceHeader);
        ServiceHeader."No." := '';

        //=== RQ19.16.148 - LBARQUIN - 15.11.2019 ===
        CraneMgtSetup.GET;
        CraneMgtSetup.TESTFIELD("Crane Serv. Order Nos.");
        NoSeriesMgt.InitSeries(CraneMgtSetup."Crane Serv. Order Nos.", ServiceHeader."No. Series", 0D, ServiceHeader."No.", ServiceHeader."No. Series");
        ServiceHeader."New Order No. Series" := CraneMgtSetup."Crane Serv. Order Nos.";
        //===========================================

        ServiceHeader."Document Type" := SourceServiceHeader."Document Type";
        ServiceHeader.INSERT(TRUE);
        DestinationNo := ServiceHeader."No.";

        ServiceHeader."Ship-to Code" := '';
        IF CompanyRelation.FINDFIRST THEN
            ServiceHeader.VALIDATE("Customer No.", CompanyRelation."Customer Code");
        ServiceHeader.VALIDATE("Your Reference", SourceNo);
        ServiceHeader.VALIDATE("Shortcut Dimension 1 Code");
        ServiceHeader.VALIDATE("Shortcut Dimension 2 Code");
        ServiceHeader.VALIDATE("Salesperson Code");
        ServiceHeader.VALIDATE("Responsibility Center");
        ServiceHeader.VALIDATE("Service Order Type");
        // RQ19.22.843    MSOPENA   08/06/2020   Quitamos validate para evitar mensaje en registro que corta la inserción.
        // ServiceHeader.VALIDATE("Order Date",SourceServiceHeader."Order Date");
        // ServiceHeader.VALIDATE("Posting Date",SourceServiceHeader."Posting Date");
        // ServiceHeader.VALIDATE("Document Date",SourceServiceHeader."Document Date");
        ServiceHeader."Order Date" := SourceServiceHeader."Order Date";
        ServiceHeader."Posting Date" := SourceServiceHeader."Posting Date";
        ServiceHeader."Document Date" := SourceServiceHeader."Document Date";
        ServiceHeader."Starting Date" := SourceServiceHeader."Starting Date";
        ServiceHeader."Finishing Date" := SourceServiceHeader."Finishing Date";
        ServiceHeader."Starting Time" := SourceServiceHeader."Starting Time";
        ServiceHeader."Finishing Time" := SourceServiceHeader."Finishing Time";
        //-------------------------------------
        ServiceHeader.MODIFY(TRUE);
        COMMIT;

        GenerateServiceItemLine;
    end;

    /// <summary>
    /// GenerateServiceItemLine()
    /// </summary>
    local procedure GenerateServiceItemLine()
    var
        RepairStatus: Record "Repair Status";
        Text001: Label 'You need to set a Reparation Status for replication Orders.';
    begin
        CraneMgtSetup.GET;
        CraneMgtSetup.TESTFIELD("Ready to Invoice Repair Status");
        CLEAR(SourceServiceItemLine);
        SourceServiceItemLine.CHANGECOMPANY(SourceCompany);
        SourceServiceItemLine.SETRANGE("Document No.", SourceNo);
        SourceServiceItemLine.SETRANGE("Document Type", SourceType);
        IF SourceServiceItemLine.FINDSET THEN BEGIN
            REPEAT
                CLEAR(ServiceItemLine);                                   //Lineas producto servicio
                ServiceItemLine.INIT;
                ServiceItemLine.COPY(SourceServiceItemLine);
                ServiceItemLine."Document No." := DestinationNo;
                ServiceItemLine.VALIDATE("Customer No.", CompanyRelation."Customer Code");
                ServiceItemLine.VALIDATE("Service Item No.");
                ServiceItemLine.VALIDATE("Shortcut Dimension 1 Code");
                ServiceItemLine.VALIDATE("Shortcut Dimension 2 Code");
                ServiceItemLine.VALIDATE("Service Item No.");
                ServiceItemLine.VALIDATE("Service Item Group Code");
                //RQ19.16.645   MSOPENA   27/11/2019
                //ServiceItemLine."Repair Status Code" := CraneMgtSetup."Finished Repair Status";

                //Buscamos el estado para las líneas en estados de reparación.
                RepairStatus.SETRANGE("Serv. Order Replication Status", TRUE);
                IF RepairStatus.FINDFIRST THEN
                    ServiceItemLine.VALIDATE("Repair Status Code", RepairStatus.Code)
                ELSE
                    ERROR(Text001);
                //----------------------------------
                ServiceItemLine."Exported to Device" := TRUE;
                ServiceItemLine.INSERT(TRUE);
                COMMIT;
            UNTIL SourceServiceItemLine.NEXT = 0;
            GenerateServiceLine;
        END;
        //Repito para cambiar el estado
        CLEAR(ServiceItemLine);
        ServiceItemLine.SETRANGE("Document No.", SourceNo);
        ServiceItemLine.SETRANGE("Document Type", SourceType);
        IF ServiceItemLine.FINDSET THEN BEGIN
            REPEAT
                ServiceItemLine."Repair Status Code" := CraneMgtSetup."Ready to Invoice Repair Status";
                ServiceItemLine.MODIFY(TRUE);
                COMMIT;
            UNTIL ServiceItemLine.NEXT = 0;
        END;
    end;

    /// <summary>
    /// GenerateServiceLine()
    /// </summary>
    local procedure GenerateServiceLine()
    var
        LineDiscount: Decimal;
        ServiceLine: Record "Service Line";
        Cust: Record "Customer";
    begin
        CLEAR(SourceServiceLine);
        SourceServiceLine.CHANGECOMPANY(SourceCompany);
        SourceServiceLine.SETRANGE("Document No.", SourceNo);
        SourceServiceLine.SETRANGE("Document Type", SourceType);

        IF SourceServiceLine.FINDSET THEN
            REPEAT
                CLEAR(ServiceLine);                                       //Lineas de servicio
                ServiceLine.INIT;
                ServiceLine.COPY(SourceServiceLine);
                ServiceLine."Document No." := DestinationNo;
                ServiceLine.VALIDATE("Customer No.", CompanyRelation."Customer Code");
                ServiceLine.VALIDATE("Bill-to Customer No.", CompanyRelation."Customer Code");
                ServiceLine."Outstanding Quantity" := SourceServiceLine."Quantity Shipped";
                ServiceLine."Qty. to Invoice" := SourceServiceLine."Quantity Invoiced";
                ServiceLine."Qty. to Ship" := SourceServiceLine."Quantity Shipped";
                ServiceLine."Outstanding Amount" := SourceServiceLine."VAT Base Amount" * (1 + SourceServiceLine."VAT %" / 100) * ((100 - SourceServiceLine."Line Discount %") / 100);
                ServiceLine."Outstanding Amount (LCY)" := SourceServiceLine."VAT Base Amount" * (1 + SourceServiceLine."VAT %" / 100) * ((100 - SourceServiceLine."Line Discount %") / 100);
                ServiceLine."Quantity Shipped" := 0;
                ServiceLine."Quantity Invoiced" := 0;
                ServiceLine.Planned := FALSE;
                ServiceLine."Outstanding Qty. (Base)" := SourceServiceLine."Quantity Shipped";
                ServiceLine."Qty. to Invoice (Base)" := SourceServiceLine."Qty. Invoiced (Base)";
                ServiceLine."Qty. to Ship (Base)" := SourceServiceLine."Qty. Shipped (Base)";
                ServiceLine."Qty. Shipped (Base)" := 0;
                ServiceLine."Qty. Invoiced (Base)" := 0;
                ServiceLine."Completely Shipped" := FALSE;
                ServiceLine."Invoice Line Amount" := ServiceLine."Outstanding Amount";
                // RGBLANCO Al pasar las líneas de servicio de una empresa a otra, las marcamos como replicadas.
                ServiceLine.Replicated := TRUE;
                LineDiscount := SourceServiceLine."Line Discount %";
                IF SourceServiceLine."Work Type Code" = CraneMgtSetup."Forfait Work Type" THEN BEGIN
                    ServiceLine.VALIDATE("Work Type Code", CraneMgtSetup."Billiable Work Type Code");
                    LineDiscount := 0;
                END;

                IF ServiceLine.Type <> 0 THEN BEGIN
                    IF Cust.GET(CompanyRelation."Customer Code") THEN BEGIN
                        ServiceLine."VAT Bus. Posting Group" := Cust."VAT Bus. Posting Group";
                        ServiceLine."Gen. Bus. Posting Group" := Cust."Gen. Bus. Posting Group";
                    END;
                    ServiceLine.VALIDATE("Document No.");
                    ServiceLine.VALIDATE(Quantity);
                    ServiceLine.VALIDATE("Unit of Measure Code");
                    ServiceLine.VALIDATE("Responsibility Center");
                    ServiceLine.VALIDATE("Service Item No.");
                    ServiceLine.VALIDATE("Shortcut Dimension 1 Code");
                    ServiceLine.VALIDATE("Shortcut Dimension 2 Code");
                    IF LineDiscount > 0 THEN
                        ServiceLine.VALIDATE("Line Discount %", LineDiscount);
                    ServiceLine.VALIDATE("Work Type Code");

                    // RQ19.26.851 - DPGARCIA - Calcular Tipo Cálculo IVA
                    ServiceLine.VALIDATE("VAT Bus. Posting Group");
                END;
                ServiceLine.INSERT(TRUE);
                COMMIT;
            UNTIL SourceServiceLine.NEXT = 0;
    end;

    /// <summary>
    /// PlatformProcess()
    /// </summary>
    procedure PlatformProcess()
    var
        Company: Record "Company";
        CompanyRelation: Record "Company Relation_LDR";
    begin
        CLEAR(CompanyRelation);
        CompanyRelation.SETFILTER("Related Company", '<>%1', COMPANYNAME);
        IF CompanyRelation.FINDSET THEN
            REPEAT

                PlatformProcessForCompany(CompanyRelation."Related Company");

            UNTIL CompanyRelation.NEXT = 0;
    end;

    /// <summary>
    /// PlatformProcessForCompany()
    /// </summary>
    local procedure PlatformProcessForCompany(CurrCompany: Text[30])
    var
        SourceServiceInvoiceHeader: Record "Service Invoice Header";
    begin
        CLEAR(SourceServiceInvoiceHeader);
        SourceServiceInvoiceHeader.CHANGECOMPANY(CurrCompany);
        SourceServiceInvoiceHeader.SETRANGE(CompanyFilter, COMPANYNAME);
        SourceServiceInvoiceHeader.SETRANGE(Replicate, TRUE);
        SourceServiceInvoiceHeader.SETRANGE("Replicate Pending", TRUE);
        // RQ19.23.133 - DPGARCIA - Filtrar por las fechas del request page
        IF (StartingDate <> 0D) AND (EndingDate <> 0D) THEN BEGIN
            SourceServiceInvoiceHeader.SETFILTER("Posting Date", '>=%1&<=%2', StartingDate, EndingDate);
        END ELSE BEGIN
            IF StartingDate <> 0D THEN
                SourceServiceInvoiceHeader.SETFILTER("Posting Date", '>=%1', StartingDate);
            IF EndingDate <> 0D THEN
                SourceServiceInvoiceHeader.SETFILTER("Posting Date", '<=%1', EndingDate);
        END;
        IF SourceServiceInvoiceHeader.FINDSET THEN
            REPEAT

                PlatformServiceInvoiceGenerate(SourceServiceInvoiceHeader, CurrCompany);

            UNTIL SourceServiceInvoiceHeader.NEXT = 0;
    end;

    /// <summary>
    /// PlatformServiceInvoiceGenerate()
    /// </summary>
    procedure PlatformServiceInvoiceGenerate(var SourceServiceHeader: Record "Service Invoice Header"; CurrCompany: Text[30])
    var
        ServiceMgtSetup: Record "Service Mgt. Setup";
        ServiceHeader: Record "Service Header";
        NoSeriesMgt: Codeunit "NoSeriesManagement";
        SourceServiceInvoiceHeader2: Record "Service Invoice Header";
    begin
        CLEAR(CompanyRelation);
        CompanyRelation.SETRANGE("Related Company", CurrCompany);
        CompanyRelation.FINDFIRST;

        CLEAR(ServiceHeader);
        ServiceHeader.SETRANGE("Document Type", ServiceHeader."Document Type"::Invoice);
        ServiceHeader.SETRANGE("Release Status", ServiceHeader."Release Status"::Open);
        ServiceHeader.SETRANGE("Customer No.", CompanyRelation."Customer Code");
        IF NOT ServiceHeader.FINDSET THEN BEGIN

            CLEAR(ServiceHeader);                                         //Cabecera del pedido
            ServiceHeader.INIT;
            ServiceHeader.TRANSFERFIELDS(SourceServiceHeader);
            ServiceHeader.SetHideValidationDialog(TRUE);
            ServiceHeader."No." := '';

            ServiceMgtSetup.GET;
            ServiceMgtSetup.TESTFIELD("Contract Invoice Nos.");
            NoSeriesMgt.InitSeries(ServiceMgtSetup."Contract Invoice Nos.", '', 0D, ServiceHeader."No.", ServiceHeader."No. Series");
            ServiceHeader."Document Type" := ServiceHeader."Document Type"::Invoice;

            ServiceHeader.INSERT(TRUE);
            DestinationNo := ServiceHeader."No.";

            ServiceHeader."Ship-to Code" := '';
            ServiceHeader."Contract No." := '';
            ServiceHeader."Posting No." := '';

            ServiceHeader.VALIDATE("Customer No.", CompanyRelation."Customer Code");
            ServiceHeader.VALIDATE("Your Reference", SourceNo);
            ServiceHeader.VALIDATE("Shortcut Dimension 1 Code");
            ServiceHeader.VALIDATE("Shortcut Dimension 2 Code");
            ServiceHeader.VALIDATE("Salesperson Code");
            ServiceHeader.VALIDATE("Responsibility Center");
            ServiceHeader.VALIDATE("Service Order Type");
            IF PostingDate <> 0D THEN // RQ19.23.133 - DPGARCIA - Rellenar la Fecha de Registro con la fecha del request page
                ServiceHeader.VALIDATE("Posting Date", PostingDate);
            ServiceHeader.MODIFY(TRUE);
            COMMIT;
        END;

        PlatformGenerateServiceLine(SourceServiceHeader, CurrCompany, ServiceHeader."No.");
    end;

    /// <summary>
    /// PlatformGenerateServiceLine()
    /// </summary>
    local procedure PlatformGenerateServiceLine(var SourceServiceHeader: Record "Service Invoice Header"; CurrCompany: Text[30]; NewDocumentNo: Code[20])
    var
        LineDiscount: Decimal;
        ServiceLine: Record "Service Line";
        SourceServiceInvoiceLine: Record "Service Invoice Line";
        NewLineNo: Integer;
        SourceServiceInvoiceLine2: Record "Service Invoice Line";
        ServiceLine2: Record "Service Line" temporary;
        GLAccount: Record "G/L Account";
        ServiceMgtSetup: Record "Service Mgt. Setup";
        CraneMgtSetup: Record "Crane Mgt. Setup_LDR";
        Concept: Record "Crane Mgt. Setup_LDR";
        ServiceContractAccountGroup: Record "Service Contract Account Group";
        ServiceItem: Record "Service Item";
        SourceServiceContractHeader: Record "Service Contract Header";
        SourceContractConcepts: Record "Contract Concepts_LDR";
        DimMgt: Codeunit "DimensionManagement";
        Cust: Record "Customer";
    begin
        ServiceMgtSetup.GET;
        CraneMgtSetup.GET;

        CLEAR(SourceServiceLine);
        SourceServiceInvoiceLine.CHANGECOMPANY(CurrCompany);
        SourceServiceInvoiceLine.SETRANGE("Document No.", SourceServiceHeader."No.");
        SourceServiceInvoiceLine.SETRANGE(Replicate, TRUE);
        SourceServiceInvoiceLine.SETRANGE("Replicate Company", COMPANYNAME);
        SourceServiceInvoiceLine.SETRANGE(Replicated, FALSE);
        IF SourceServiceInvoiceLine.FINDSET THEN BEGIN

            //Introducimos lineas de texto previas

            CLEAR(ServiceLine);
            ServiceLine.SETRANGE("Document Type", ServiceLine."Document Type"::Invoice);
            ServiceLine.SETRANGE("Document No.", NewDocumentNo);
            IF ServiceLine.FINDLAST THEN
                NewLineNo := ServiceLine."Line No." + 10000
            ELSE
                NewLineNo := 10000;

            // Linea de Texto Nombre Empresa Origen
            CLEAR(ServiceLine);                                       //Lineas de servicio
            ServiceLine.INIT;
            ServiceLine."Document Type" := ServiceLine."Document Type"::Invoice;
            ServiceLine."Document No." := NewDocumentNo;
            ServiceLine."Line No." := NewLineNo;
            NewLineNo += 10000;

            ServiceLine."Customer No." := CompanyRelation."Customer Code";
            ServiceLine."Bill-to Customer No." := CompanyRelation."Customer Code";
            ServiceLine.Replicated := TRUE;
            ServiceLine.Type := ServiceLine.Type::" ";
            ServiceLine.Description := STRSUBSTNO(Txt001, CurrCompany);
            ServiceLine.INSERT(TRUE);

            // Linea de Texto Nº Factura Origen
            ServiceLine.Description := STRSUBSTNO(Txt002, SourceServiceHeader."No.");
            ServiceLine."Line No." := NewLineNo;
            ServiceLine.INSERT(TRUE);
            NewLineNo += 10000;

            //   // Linea de Texto Nº Contrato -  FALTA DE MODIFICAR LA VARIABLE SourceServiceHeader."No."
            ServiceLine.Description := STRSUBSTNO(Txt003, SourceServiceHeader."Contract No.");
            ServiceLine."Line No." := NewLineNo;
            ServiceLine.INSERT(TRUE);
            NewLineNo += 10000;

            REPEAT

                CLEAR(ServiceLine);                                       //Lineas de servicio
                ServiceLine.INIT;
                ServiceLine.TRANSFERFIELDS(SourceServiceInvoiceLine);
                ServiceLine.SetHideDialog(TRUE); //TODO: Error: ServiceLine no contiene la definición SetHideDialog
                ServiceLine."Document Type" := ServiceLine."Document Type"::Invoice;
                ServiceLine."Document No." := NewDocumentNo;
                ServiceLine."Line No." := NewLineNo;
                ServiceLine."Customer No." := CompanyRelation."Customer Code";
                ServiceLine."Bill-to Customer No." := CompanyRelation."Customer Code";
                ServiceLine.Replicated := TRUE;
                ServiceLine.Replicate := FALSE;
                ServiceLine."Replicate Company" := '';
                ServiceLine."Contract No." := '';
                ServiceLine."Contract Line No." := 0;
                ServiceLine."Appl.-to Service Entry" := 0;
                ServiceLine2.TRANSFERFIELDS(ServiceLine);
                IF SourceServiceInvoiceLine.Type = SourceServiceInvoiceLine.Type::"G/L Account" THEN BEGIN
                    IF SourceServiceInvoiceLine."Replicate Service Item" <> '' THEN BEGIN
                        Concept.GET(CraneMgtSetup."Platform Delivery Concept", Concept.Type::External); //TODO: Error: Crane Mgt. Setup_LDR no contiene la definición Type
                        ServiceLine2.VALIDATE("No.", Concept."Account No."); //TODO: Error: Crane Mgt. Setup_LDR no contiene la definición Account No.
                        ServiceLine."No." := Concept."Account No."; //TODO: Error: Crane Mgt. Setup_LDR no contiene la definición Account No.
                    END ELSE BEGIN
                        ServiceContractAccountGroup.GET(CraneMgtSetup."Platf. Serv. Cont. Acc. Group");
                        ServiceLine2.VALIDATE("No.", ServiceContractAccountGroup."Non-Prepaid Contract Acc.");
                        ServiceLine."No." := ServiceContractAccountGroup."Non-Prepaid Contract Acc.";
                    END;
                END;


                LineDiscount := SourceServiceInvoiceLine."Line Discount %";

                IF ServiceLine.Type <> 0 THEN BEGIN
                    // DPGARCIA - RQ19.39.432 - Coger nuevo Grupo Registro IVA Neg. al copiar lineas
                    IF Cust.GET(CompanyRelation."Customer Code") THEN BEGIN
                        ServiceLine."VAT Bus. Posting Group" := Cust."VAT Bus. Posting Group";
                        ServiceLine."Gen. Bus. Posting Group" := Cust."Gen. Bus. Posting Group";
                    END;
                    // DPGARCIA - RQ19.39.432
                    ServiceLine.VALIDATE("Document No.");
                    ServiceLine.VALIDATE(Quantity);
                    ServiceLine.VALIDATE("Outstanding Quantity", ServiceLine."Qty. to Invoice");
                    ServiceLine.VALIDATE("Qty. to Ship", ServiceLine."Qty. to Invoice");
                    ServiceLine.VALIDATE("Unit of Measure Code");
                    ServiceLine.VALIDATE("Responsibility Center");
                    ServiceLine.VALIDATE("Service Item No.");
                    ServiceLine.VALIDATE("Shortcut Dimension 1 Code");
                    ServiceLine.VALIDATE("Shortcut Dimension 2 Code");
                    ServiceLine.VALIDATE("Service Item No.", SourceServiceInvoiceLine."Service Item No.");
                    IF SourceServiceInvoiceLine."Replicate Service Item" <> '' THEN
                        ServiceLine.VALIDATE("Service Item No.", SourceServiceInvoiceLine."Replicate Service Item");
                    IF LineDiscount > 0 THEN
                        ServiceLine.VALIDATE("Line Discount %", LineDiscount);
                    ServiceLine.VALIDATE(Amount, SourceServiceInvoiceLine.Amount);

                    // RQ19.26.851 - DPGARCIA - Calcular Tipo Cálculo IVA
                    ServiceLine.VALIDATE("VAT Bus. Posting Group");
                END;

                // DPGARCIA - RQ19.22.145 - Si la línea de factura es de tipo Producto, rellenamos el Nº planificador
                IF (ServiceLine."Service Item No." <> '') THEN BEGIN
                    ServiceItem.GET(ServiceLine."Service Item No.");
                    CLEAR(SourceContractConcepts);
                    SourceContractConcepts.CHANGECOMPANY(CurrCompany);
                    SourceContractConcepts.SETRANGE("Contract Type", SourceContractConcepts."Contract Type"::Contract);
                    SourceContractConcepts.SETRANGE("Source Table", DATABASE::"Service Contract Line");
                    SourceContractConcepts.SETRANGE("Contract No.", SourceServiceInvoiceLine."Contract No.");
                    SourceContractConcepts.SETRANGE("Contract Line No.", SourceServiceInvoiceLine."Contract Line No.");
                    SourceContractConcepts.SETRANGE("Concept No.", SourceServiceInvoiceLine."Concept No.");
                    IF SourceContractConcepts.FINDFIRST THEN;

                    IF SourceServiceInvoiceLine."Concept No." = CraneMgtSetup."Platform Delivery Concept" THEN
                        //ServiceLine.VALIDATE(Description, COPYSTR(STRSUBSTNO((ServiceLine.Description+txtDescripcion),ServiceItem."Planner No"), 1, 50))
                        ServiceLine.VALIDATE(Description, COPYSTR(txtEntrega + STRSUBSTNO(txtDescripcion, ServiceItem."Planner No", SourceContractConcepts."Service Order No.", SourceServiceHeader."Order Date"), 1, 50))
                    ELSE
                        IF SourceServiceInvoiceLine."Concept No." = CraneMgtSetup."Platform Pickup Concept" THEN
                            ServiceLine.VALIDATE(Description, COPYSTR(txtRecogida + STRSUBSTNO(txtDescripcion, ServiceItem."Planner No", SourceContractConcepts."Service Order No.", SourceServiceHeader."Order Date"), 1, 50))
                        ELSE
                            ServiceLine.VALIDATE(Description, COPYSTR(STRSUBSTNO((ServiceLine.Description + txtDescripcion2), ServiceItem."Planner No"), 1, 50));

                    // RQ19.27.621 - DPGARCIA - Heredar dimensiones del Prod.Servicio
                    IF (SourceServiceInvoiceLine."Concept No." = CraneMgtSetup."Platform Delivery Concept") OR (SourceServiceInvoiceLine."Concept No." = CraneMgtSetup."Platform Pickup Concept") THEN
                        ServiceLine.CreateDim( //TODO: Error: Service Line no define bien el método CreateDim
                            DATABASE::"Service Item", ServiceLine."Service Item No.",
                            DimMgt.TypeToTableID5(ServiceLine.Type), ServiceLine."No.",
                            DATABASE::"Work Type", ServiceLine."Work Type Code",
                            DATABASE::"Responsibility Center", ServiceLine."Responsibility Center",
                            DATABASE::"Unit of Measure", ServiceLine."Unit of Measure Code",
                            DATABASE::Job, ServiceLine."Job No.");
                END;

                ServiceLine.INSERT(TRUE);
                NewLineNo += 10000;

                // Marcamos Original como replicado
                CLEAR(SourceServiceInvoiceLine2);
                SourceServiceInvoiceLine2.CHANGECOMPANY(CurrCompany);
                SourceServiceInvoiceLine2.GET(SourceServiceInvoiceLine.RECORDID);
                SourceServiceInvoiceLine2.Replicated := TRUE;
                SourceServiceInvoiceLine2.MODIFY;

                COMMIT;
            UNTIL SourceServiceInvoiceLine.NEXT = 0;
        END;
    end;

    /// <summary>
    /// CreateOrUpdateExpenses()
    /// </summary>
    procedure SetDates(pPostingDate: Date; pStartingDate: Date; pEndingDate: Date)
    begin
        PostingDate := pPostingDate;
        StartingDate := pStartingDate;
        EndingDate := pEndingDate;
    end;
    */
}