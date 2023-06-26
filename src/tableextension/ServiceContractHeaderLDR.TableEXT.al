/// <summary>
/// tableextension 50078 "Service Contract Header_LDR"
/// </summary>
tableextension 50078 "Service Contract Header_LDR" extends "Service Contract Header"
{
    fields
    {
        field(50000; "Service Item Tariff No._LDR"; Code[20])
        {
            Caption = 'Código Tarifa Producto de Servicio';
            DataClassification = ToBeClassified;
            TableRelation = "Service Item Rate Header_LDR";

            trigger OnValidate()
            begin
                //CheckChangeStatus();
            end;
        }
        field(50001; "Service Quote Type_LDR"; Option)
        {
            Caption = 'Tipo Oferta';
            DataClassification = ToBeClassified;
            OptionCaption = 'General,Tarifa';
            OptionMembers = General,Tariff;

            trigger OnValidate()
            begin

            end;
        }
        field(50002; Retained_LDR; Boolean)
        {
            Caption = 'Retenido';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                txtRetained: TextConst ENU = 'Debe introducir No. Pedido Cliente';
            begin
                if ("Invoicing Type_LDR" = "Invoicing Type_LDR"::Order) then
                    if (not Retained_LDR) and ("Customer Order No._LDR" = '') then begin
                        Message(txtRetained);
                        Retained_LDR := true;
                    end;
            end;
        }
        field(50003; "Customer Order No._LDR"; Code[20])
        {
            Caption = 'Nº Pedido Cliente';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if ("Customer Order No._LDR" = '') and ("Invoicing Type_LDR" = "Invoicing Type_LDR"::Order) then
                    Retained_LDR := true
                else
                    if ("Customer Order No._LDR" <> '') then begin
                        Retained_LDR := false;
                    end;
            end;
        }
        field(50004; "Invoicing Type_LDR"; Option)
        {
            Caption = 'Tipo Facturación';
            DataClassification = ToBeClassified;
            OptionCaption = 'Obra,Oferta,Independiente,Pedido';
            OptionMembers = Work,Offer,Standalone,Order;
        }
        field(50005; "Service Quote no._LDR"; Code[20])
        {
            Caption = 'Código Oferta';
            DataClassification = ToBeClassified;
            TableRelation = "Crane Service Quote Header_LDR"."Quote no." WHERE("Platform Quote" = CONST(true));

            trigger OnValidate()
            var
                CraneServiceQuoteHeader: Record "Crane Service Quote Header_LDR";
            begin
                if CraneServiceQuoteHeader.Get("Service Quote no._LDR") then begin
                    if CraneServiceQuoteHeader."Salesperson Code" <> '' then begin
                        "Salesperson Code" := CraneServiceQuoteHeader."Salesperson Code";
                    end;
                end;
            end;
        }
        field(50006; "Old Worksheet No._LDR"; Code[20])
        {
            Caption = 'Nº Parte Antiguo';
            DataClassification = ToBeClassified;
        }
        field(50007; "Day Invoicing_LDR"; Boolean)
        {
            Caption = 'Facturar por Precio Día';
            DataClassification = ToBeClassified;
            Description = 'Permite Especificar si se Factura por Precio Día';

            trigger OnValidate()
            var
                ServLedgerEntry: Record "Service Ledger Entry";
            begin
                if (Status <> Status::Cancelled) and
                    (not SuspendChangeStatus)
                then
                    TestField("Change Status", "Change Status"::Open);

                TestField("Annual Amount", 0);

                Clear(ServLedgerEntry);
                ServLedgerEntry.SetRange(ServLedgerEntry."Service Contract No.", "Contract No.");
                ServLedgerEntry.SetRange(ServLedgerEntry."Service Order No.", '');
                if ServLedgerEntry.Find('-') then
                    Error(TextHayMovimientos, FieldCaption("Day Invoicing_LDR"));
            end;
        }
        field(50008; "Invoice Day of Month_LDR"; Integer)
        {
            Caption = 'Facturar a Día';
            DataClassification = ToBeClassified;
            MaxValue = 31;
            MinValue = 0;
        }
        field(50009; Lineal_LDR; Boolean)
        {
            Caption = 'Lineal';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                ServLedgerEntry: Record "Service Ledger Entry";
            begin
                if (Status <> Status::Cancelled) and
                    (not SuspendChangeStatus)
                then
                    TestField("Change Status", "Change Status"::Open);

                TestField("Annual Amount", 0);

                Clear(ServLedgerEntry);
                ServLedgerEntry.SetRange(ServLedgerEntry."Service Contract No.", "Contract No.");
                ServLedgerEntry.SetRange(ServLedgerEntry."Service Order No.", '');
                if ServLedgerEntry.Find('-') then
                    Error(TextHayMovimientos, FieldCaption(Lineal_LDR));
            end;
        }
        field(50010; "Next Inv. Lineal Period Start_LDR"; Date)
        {
            Caption = 'Inicio Siguiente Período Factura Lineal';
            DataClassification = ToBeClassified;
        }
        field(50011; "Next Inv. Lineal Period End_LDR"; Date)
        {
            Caption = 'Fin Siguiente Período Factura Lineal';
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(50012; "Serv. Contract Inv. Group_LDR"; Code[20])
        {
            Caption = 'Código Grupo Facturación Contrato Servicio';
            DataClassification = ToBeClassified;
            //TableRelation = "Service Contract Invoice Group" WHERE ("Customer No."=FIELD("Bill-to Customer No.")); 

            trigger OnValidate()
            begin
                if "Serv. Contract Inv. Group_LDR" <> '' then
                    TestField("Combine Invoices", true);
            end;
        }
        field(50013; "Payment Method Code_LDR"; Code[10])
        {
            Caption = 'Código Forma Pago';
            DataClassification = ToBeClassified;
            TableRelation = "Payment Method";
        }
        field(50014; "Internal Contract No._LDR"; Code[20])
        {
            Caption = 'Contrato Interno Relacionado';
            DataClassification = ToBeClassified;
            //TableRelation = "Table70028"."Field1" WHERE(Field2 = CONST(1)); 

            trigger OnValidate()
            begin
                if (Status <> Status::Cancelled) and
                    (not SuspendChangeStatus)
                then
                    TestField("Change Status", "Change Status"::Open);
            end;
        }
        field(50015; "Pay-at Code_LDR"; Code[20])
        {
            Caption = 'Pago en Código';
            DataClassification = ToBeClassified;
            TableRelation = "Customer Pmt. Address"."Code" WHERE("Customer No." = FIELD("Bill-to Customer No."));
        }
        field(50016; Historical_LDR; Boolean)
        {
            Caption = 'Histórico';
            DataClassification = ToBeClassified;
        }
        field(50017; "ELESOFT Contract Amount_LDR"; Decimal)
        {
            Caption = 'Importe Contrato ELESOFT';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50018; "Invoice Series No._LDR"; Code[10])
        {
            Caption = 'Nº Serie Facturas';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";

            trigger OnValidate()
            var
                NoSeriesMgt: Codeunit "NoSeriesManagement";
                ServSetup: Record "Service Mgt. Setup";
            begin
                if "Invoice Series No._LDR" <> '' then begin
                    ServSetup.Get();
                    ServSetup.TestField(ServSetup."Posted Service Invoice Nos.");
                    NoSeriesMgt.TestSeries(ServSetup."Posted Service Invoice Nos.", "Invoice Series No._LDR");
                end;
                TestField("Invoice Series No._LDR");
            end;

            trigger OnLookup()
            var
                NoSeriesMgt: Codeunit "NoSeriesManagement";
                ServiceContractHeader: Record "Service Contract Header";
                ServSetup: Record "Service Mgt. Setup";
            begin
                with ServiceContractHeader do begin
                    ServiceContractHeader := Rec;
                    ServSetup.Get();
                    ServSetup.TestField(ServSetup."Posted Service Invoice Nos.");
                    if NoSeriesMgt.LookupSeries(ServSetup."Posted Service Invoice Nos.", "Invoice Series No._LDR") then
                        Validate("Invoice Series No._LDR");
                    Rec := ServiceContractHeader;
                end;
            end;
        }
        field(50019; "Shipping Agent Code_LDR"; Code[10])
        {
            Caption = 'Código Transportista';
            DataClassification = ToBeClassified;
            TableRelation = "Shipping Agent";

            trigger OnValidate()
            begin
                if (Status <> Status::Cancelled) and
                    (not SuspendChangeStatus)
                then
                    TestField("Change Status", "Change Status"::Open);
            end;
        }
        field(50020; "Renting Contract_LDR"; Boolean)
        {
            Caption = 'Contrato de Renting';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key12; "Historical_LDR")
        {

        }
    }

    trigger OnAfterInsert()
    var
        SalesSetup: Record "Sales & Receivables Setup";
        ServSetup: Record "Service Mgt. Setup";
    begin
        SalesSetup.Get();
        ServSetup.Get();
        Validate("Invoice Series No._LDR", ServSetup."Posted Service Invoice Nos.");
    end;

    trigger OnAfterDelete()
    var
        Conceptos: Record "Contract Concepts_LDR";
    begin
        CalendarMgt.DeleteAllContractReservation("Contract Type", "Contract No.", Database::"Service Contract Line", '');

        Clear(Conceptos);
        Conceptos.SetRange(Conceptos."Source Table", Database::"Service Contract Header");
        Conceptos.SetRange(Conceptos."Contract Type", "Contract Type");
        Conceptos.SetRange(Conceptos."Contract No.", "Contract No.");
        Conceptos.DeleteAll(true);
    end;

    var
        Text027: TextConst ENU = '%1 to %2', ESP = '%1 hasta %2';
        CalendarMgt: Report "Service Contract Planning";
        TextHayMovimientos: TextConst ENU = 'It is not posible to modify field %1 because exist contract ledger entries', ESP = 'No se puede modificar el valor del campo %1 por que ya existen movimientos para el contrato';
        txtEntregaRecogida: TextConst ENU = 'Journal generated for %1 Service Items.', ESP = 'Se ha generado correctamente el diario correpondiente a %1 Productos de Servicio';
        SourceCodeSetup: Record "Source Code Setup";
        Text50001: TextConst ENU = 'You may have changed a dimension. Do you want to update the lines?', ESP = 'Puede que haya cambiado una dimensión. ¿Desea actualizar las líneas?';
        Text50002: TextConst ENU = 'There can only be one General Type Quote by Customer', ESP = 'Solo puede existir una oferta de tipo General por Cliente';

    procedure ValidateNextInvoicePeriodLinde(var ServCLine: Record "Service Contract Line"; CurrLine: Record "Service Contract Line");
    var
        InvFrom: Date;
        InvTo: Date;
        NoOfMonths: Integer;
        NoOfDays: Integer;
        DiasEntre: Integer;
        nDias: Integer;
        Lineas: Record "Service Contract Line";
        ImporteLinea: Decimal;
        TotalLineas: Decimal;
        TempDate2: Date;
        TempFechaInicial: Date;
        TempFechaFinal: Date;
        Currency: Record "Currency";
        ServContractMgt: Codeunit "ServContractManagement";
        DaysInThisInvPeriod: Integer;
        TempDate: Date;
        DaysInFullInvPeriod: Integer;
    begin
        /*if NextInvoicePeriod = '' then begin
            "Amount per Period" := 0;
            exit;
        end;

        Currency.InitRoundingPrecision;
        InvFrom := "Next Invoice Period Start";
        InvTo := "Next Invoice Period End";

        if Lineal_LDR then begin
            "Amount per Period" := 0;
            if ServCLine.Find('-') then begin
                repeat
                    ServContractMgt.GetNextLineLinealInvoicePeriod(Rec, ServCLine, TempFechaInicial, TempFechaFinal);

                    if "Day Invoicing_LDR" then begin
                        "Amount per Period" := "Amount per Period" +
                                            Round(ServContractMgt.CalcContractLineAmountRentDto(ServCLine, ServCLine."Day Amount_LDR",
                                                               TempFechaInicial, TempFechaFinal), Currency."Amount Rounding Precision");
                    end else begin
                        ServContractMgt.NOfMonthsAndDaysInLinealPeriod(TempFechaInicial, TempFechaFinal, NoOfMonths, NoOfDays);
                        "Amount per Period" := "Amount per Period" +
                                             (ServCLine."Line Amount" / 12 * NoOfMonths) +
                                             (ServCLine."Line Amount" / ServContractMgt.NoOfDayInYear(TempFechaInicial) * NoOfDays);
                    end;
                until ServCLine.Next() = 0;
            end;

            ServContractMgt.GetNextLineLinealInvoicePeriod(Rec, CurrLine, TempFechaInicial, TempFechaFinal);
            if (TempFechaInicial <> 0D) and (TempFechaFinal <> 0D) then begin
                if "Day Invoicing_LDR" then begin
                    "Amount per Period" := "Amount per Period" +
                                          Round(ServContractMgt.CalcContractLineAmountRentDto(CurrLine, CurrLine."Day Amount_LDR",
                                               TempFechaInicial, TempFechaFinal), Currency."Amount Rounding Precision");
                end else begin
                    ServContractMgt.NOfMonthsAndDaysInLinealPeriod(TempFechaInicial, TempFechaFinal, NoOfMonths, NoOfDays);
                    "Amount per Period" := "Amount per Period" +
                                         (CurrLine."Line Amount" / 12 * NoOfMonths) +
                                         (CurrLine."Line Amount" / ServContractMgt.NoOfDayInYear(TempFechaInicial) * NoOfDays);
                end;
            end;

        end else begin
            "Amount per Period" := 0;
            if ServCLine.Find('-') then begin
                repeat
                    if "Day Invoicing_LDR" then begin
                        "Amount per Period" := "Amount per Period" +
                                           Round(ServContractMgt.CalcContractLineAmountRentDto(ServCLine, ServCLine."Day Amount_LDR",
                                                              InvFrom, InvTo), Currency."Amount Rounding Precision");
                    end else begin
                        ServContractMgt.GetNextLineInvoicePeriod(Rec, ServCLine, TempFechaInicial, TempFechaFinal);
                        if (TempFechaInicial <> 0D) and (TempFechaFinal <> 0D) then begin
                            DaysInThisInvPeriod := TempFechaFinal - TempFechaInicial + 1;

                            if Prepaid then begin
                                TempDate := CalculateEndPeriodDate(true, CalcDate('<CM>', "Next Invoice Date"));
                                DaysInFullInvPeriod := TempDate - CalcDate('<-CM>', "Next Invoice Date") + 1;
                            end else begin
                                TempDate := CalculateEndPeriodDate(false, "Next Invoice Date");
                                DaysInFullInvPeriod := "Next Invoice Date" - TempDate + 1;
                            end;

                            if DaysInFullInvPeriod = DaysInThisInvPeriod then
                                "Amount per Period" := "Amount per Period" + Round((ServCLine."Line Amount" / ReturnNoOfPer("Invoice Period")), Currency."Amount Rounding Precision")
                            else
                                if Prepaid then begin
                                    if (Date2DMY(TempFechaInicial, 2) = Date2DMY(TempFechaFinal, 2)) and (Date2DMY(TempFechaInicial, 3) = Date2DMY(TempFechaFinal, 3))
                                       then begin
                                        "Amount per Period" := "Amount per Period" + Round((ServCLine."Line Amount" / ServContractMgt.NoOfDayInYear(TempFechaFinal)) * DaysInThisInvPeriod, Currency."Amount Rounding Precision");
                                    end else begin
                                        ServContractMgt.NoOfMonthsAndDaysInPeriod(TempFechaInicial, TempFechaFinal, NoOfMonths, NoOfDays);
                                        "Amount per Period" := "Amount per Period" + (ServCLine."Line Amount" / 12 * NoOfMonths) + (ServCLine."Line Amount" / ServContractMgt.NoOfDayInYear(TempFechaInicial) * NoOfDays);
                                    end;
                                end else
                                    "Amount per Period" := "Amount per Period" + Round((ServCLine."Line Amount" / ServContractMgt.NoOfDayInYear(TempFechaFinal)) * DaysInThisInvPeriod, Currency."Amount Rounding Precision");
                        end;
                    end;
                until ServCLine.Next() = 0;
            end;

            if "Day Invoicing_LDR" then begin
                "Amount per Period" := "Amount per Period" +
                                     Round(ServContractMgt.CalcContractLineAmountRentDto(CurrLine, CurrLine."Day Amount_LDR",
                                           InvFrom, InvTo), Currency."Amount Rounding Precision");

            end else begin
                ServContractMgt.GetNextLineInvoicePeriod(Rec, CurrLine, TempFechaInicial, TempFechaFinal);
                if (TempFechaInicial <> 0D) and (TempFechaFinal <> 0D) then begin
                    DaysInThisInvPeriod := TempFechaFinal - TempFechaInicial + 1;

                    if Prepaid then begin
                        TempDate := CalculateEndPeriodDate(true, CalcDate('<CM>', "Next Invoice Date"));
                        DaysInFullInvPeriod := TempDate - CalcDate('<-CM>', "Next Invoice Date") + 1;
                    end else begin
                        TempDate := CalculateEndPeriodDate(false, "Next Invoice Date");
                        DaysInFullInvPeriod := "Next Invoice Date" - TempDate + 1;
                    end;

                    if DaysInFullInvPeriod = DaysInThisInvPeriod then
                        "Amount per Period" := "Amount per Period" +
                          Round((CurrLine."Line Amount" / ServContractMgt.NoOfDayInYear(TempFechaFinal)) * DaysInFullInvPeriod, Currency."Amount Rounding Precision")
                    else
                        if Prepaid then begin
                            if (Date2DMY(TempFechaInicial, 2) = Date2DMY(TempFechaFinal, 2)) and
                               (Date2DMY(TempFechaInicial, 3) = Date2DMY(TempFechaFinal, 3))
                               then begin
                                "Amount per Period" := "Amount per Period" +
                                  Round((CurrLine."Line Amount" / ServContractMgt.NoOfDayInYear(TempFechaFinal)) * DaysInThisInvPeriod,
                                    Currency."Amount Rounding Precision");
                            end else begin
                                ServContractMgt.NoOfMonthsAndDaysInPeriod(TempFechaInicial, TempFechaFinal, NoOfMonths, NoOfDays);
                                "Amount per Period" := "Amount per Period" +
                                     (CurrLine."Line Amount" / 12 * NoOfMonths) +
                                     (CurrLine."Line Amount" / ServContractMgt.NoOfDayInYear(TempFechaInicial) * NoOfDays);
                            end;
                        end else
                            "Amount per Period" := "Amount per Period" +
                              Round((CurrLine."Line Amount" / ServContractMgt.NoOfDayInYear(TempFechaFinal)) * DaysInThisInvPeriod,
                                Currency."Amount Rounding Precision");
                end;
            end;
        end; */
    end;

    procedure GetConceptPeriodAmount() valor: Decimal;
    var
        Conceptos: Record "Contract Concepts_LDR";
        FechaInicio: Date;
        FechaFin: Date;
        LineasContrato: Record "Service Contract Line";
    begin
        if Lineal_LDR then begin
            GetLinealInvoicePeriod(FechaInicio, FechaFin);
        end else begin
            FechaInicio := "Next Invoice Period Start";
            FechaFin := "Next Invoice Period End";
        end;

        if (FechaInicio <> 0D) and (FechaFin <> 0D) then begin
            Clear(Conceptos);
            Conceptos.SetCurrentKey("Source Table", "Contract No.", "Contract Type", "Contract Line No.", Periodicity, Date, Invoiced);
            Conceptos.SetRange(Conceptos."Source Table", Database::"Service Contract Header");
            Conceptos.SetRange(Conceptos."Contract No.", "Contract No.");
            Conceptos.SetRange(Conceptos."Contract Type", "Contract Type");
            Conceptos.SetRange(Conceptos."Contract Line No.", 0);
            Conceptos.SetRange(Conceptos.Periodicity, Conceptos.Periodicity::"Date expecific");
            Conceptos.SetRange(Conceptos.Date, FechaInicio, FechaFin);
            Conceptos.SetRange(Conceptos.Invoiced, false);
            Conceptos.CalcSums(Conceptos.Amount);
            valor := Conceptos.Amount;

            Clear(Conceptos);
            Conceptos.SetCurrentKey("Source Table", "Contract No.", "Contract Type", "Contract Line No.", Periodicity, Date, Invoiced);
            Conceptos.SetRange(Conceptos."Source Table", Database::"Service Contract Header");
            Conceptos.SetRange(Conceptos."Contract No.", "Contract No.");
            Conceptos.SetRange(Conceptos."Contract Type", "Contract Type");
            Conceptos.SetRange(Conceptos."Contract Line No.", 0);
            Conceptos.SetRange(Conceptos.Periodicity, Conceptos.Periodicity::"Service Contract");
            Conceptos.CalcSums(Conceptos.Amount);
            valor := valor + Conceptos.Amount;
        end;

        Clear(LineasContrato);
        LineasContrato.SetRange(LineasContrato."Contract Type", "Contract Type");
        LineasContrato.SetRange(LineasContrato."Contract No.", "Contract No.");
        if LineasContrato.Find('-') then begin
            repeat
                valor := valor + LineasContrato.GetConceptPeriodAmount;
            until LineasContrato.Next() = 0;
        end;
    end;

    procedure GetLinealInvoicePeriod(var InitialDate: Date; var EndDate: Date);
    var
        ServContractLine: Record "Service Contract Line";
        ServContractMgt: Codeunit "ServContractManagement";
        TempInitialDate: Date;
        TempEndDate: Date;
    begin
        InitialDate := 0D;
        EndDate := 0D;
        if Lineal_LDR then begin
            Clear(ServContractLine);
            ServContractLine.SetRange(ServContractLine."Contract Type", "Contract Type");
            ServContractLine.SetRange(ServContractLine."Contract No.", "Contract No.");
            if ServContractLine.Find('-') then begin
                repeat
                    if (ServContractLine."Starting Date" <= "Next Invoice Period End") and
                       (ServContractLine."Contract Expiration Date" >= "Next Invoice Period Start") and
                       ((ServContractLine."Invoiced to Date" < "Next Invoice Date") or
                        ((Lineal_LDR) and
                           (ServContractLine."Contract Expiration Date" <> ServContractLine."Invoiced to Date")))
                       then begin

                        //ServContractMgt.GetNextLineLinealInvoicePeriod(Rec, ServContractLine, TempInitialDate, TempEndDate);
                        if TempInitialDate <> 0D then begin
                            if (TempInitialDate < InitialDate) or (InitialDate = 0D) then
                                InitialDate := TempInitialDate;
                        end;
                        if TempEndDate <> 0D then begin
                            if (TempEndDate > EndDate) or (EndDate = 0D) then
                                EndDate := TempEndDate;
                        end;
                    end;
                until ServContractLine.Next() = 0;
            end;
        end;
    end;

    procedure GetLinealInvoicePeriodText(): Text[250];
    var
        InitialDate: Date;
        EndDate: Date;
    begin
        GetLinealInvoicePeriod(InitialDate, EndDate);

        if (InitialDate <> 0D) and (EndDate <> 0D) then
            exit(StrSubstNo(Text027, InitialDate, EndDate))
        else
            exit('');
    end;

    procedure NextInvoiceLinealPeriod(): Text[250];
    var
        InitialDate: Date;
        EndDate: Date;
    begin
        if ("Next Inv. Lineal Period Start_LDR" <> 0D) and ("Next Inv. Lineal Period End_LDR" <> 0D) then
            exit(StrSubstNo(Text027, "Next Inv. Lineal Period Start_LDR", "Next Inv. Lineal Period End_LDR"));
    end;

    procedure GenerateDelivery(var SelectedServContractLines: Record "Service Contract Line"; Fast: Boolean);
    var
        TempLinDiarioMovimiento: Record "Serv.Item. Entry Journal_LDR";
        LinDiarioMovimiento: Record "Serv.Item. Entry Journal_LDR";
        ContactGroup: Record "Contract Group";
        ServItem: Record "Service Item";
        ServMgtSetup: Record "Service Mgt. Setup";
        Contador: Integer;
        JournalBatch: Record "Serv.Item Entr Journ Batch_LDR";
        DocNo: Code[20];
        NoSeriesMgt: Codeunit "NoSeriesManagement";
    begin
        TestField("Contract Group Code");
        TestField(Status, Status::Signed);
        ContactGroup.Get("Contract Group Code");
        ContactGroup.TestField(ContactGroup."Impresion type_LDR", ContactGroup."Impresion type_LDR"::Rent);

        SourceCodeSetup.Get();
        SourceCodeSetup.TestField(SourceCodeSetup."Service Item Entry Journal_LDR");
        ServMgtSetup.Get();

        if not GetJournalBatch(SourceCodeSetup."Service Item Entry Journal_LDR", JournalBatch) then
            Error('');

        if SelectedServContractLines.FindSet() then begin
            repeat
                SelectedServContractLines.CalcFields("Delivery Planified_LDR", "Delivery Realiced_LDR");
                if (SelectedServContractLines."Delivery Planified_LDR" = false) and
                   (SelectedServContractLines."Delivery Realiced_LDR" = false) then begin

                    ServItem.Get(SelectedServContractLines."Service Item No.");

                    Clear(TempLinDiarioMovimiento);
                    TempLinDiarioMovimiento.SetRange(TempLinDiarioMovimiento."Journal Template Name",
                         SourceCodeSetup."Service Item Entry Journal_LDR");
                    TempLinDiarioMovimiento.SetRange(TempLinDiarioMovimiento."Journal Batch Name", JournalBatch.Name);
                    if TempLinDiarioMovimiento.FindLast() then;

                    if JournalBatch."No. Series" = '' then begin
                        DocNo := "Contract No.";
                    end else begin
                        Clear(NoSeriesMgt);
                        DocNo := NoSeriesMgt.TryGetNextNo(JournalBatch."No. Series", SelectedServContractLines."Contract Expiration Date");
                    end;

                    Clear(LinDiarioMovimiento);
                    LinDiarioMovimiento.Validate(LinDiarioMovimiento."Journal Template Name",
                      SourceCodeSetup."Service Item Entry Journal_LDR");
                    LinDiarioMovimiento.Validate(LinDiarioMovimiento."Journal Batch Name", JournalBatch.Name);
                    LinDiarioMovimiento.Validate(LinDiarioMovimiento."Line No.", TempLinDiarioMovimiento."Line No." + 10000);
                    LinDiarioMovimiento.Insert(true);
                    LinDiarioMovimiento.Validate("Entry Type", LinDiarioMovimiento."Entry Type"::"Entrega Inicio Contrato Alquiler");
                    LinDiarioMovimiento.Validate(LinDiarioMovimiento."Posting Date", SelectedServContractLines."Starting Date");
                    LinDiarioMovimiento.Validate(LinDiarioMovimiento."Document No.", DocNo);
                    LinDiarioMovimiento.Validate(LinDiarioMovimiento."Service Item No.", SelectedServContractLines."Service Item No.");
                    LinDiarioMovimiento.Validate(LinDiarioMovimiento.Description, SelectedServContractLines.Description);
                    LinDiarioMovimiento.Validate(LinDiarioMovimiento."Originally Customer", ServItem."Customer No.");
                    LinDiarioMovimiento.Validate(LinDiarioMovimiento."Originally Cust Ship Address", ServItem."Ship-to Code");
                    LinDiarioMovimiento.Validate(LinDiarioMovimiento."Assignment Customer", "Customer No.");
                    //{
                    LinDiarioMovimiento.Validate(LinDiarioMovimiento."Assignment Name", Name);
                    LinDiarioMovimiento.Validate(LinDiarioMovimiento."Assignment Name 2", "Name 2");
                    LinDiarioMovimiento.Validate(LinDiarioMovimiento."Assignment Address", Address);
                    LinDiarioMovimiento.Validate(LinDiarioMovimiento."Assignment Address 2", "Address 2");
                    LinDiarioMovimiento.Validate(LinDiarioMovimiento."Assignment City", City);
                    LinDiarioMovimiento.Validate(LinDiarioMovimiento."Assignment Post Code", "Post Code");
                    LinDiarioMovimiento.Validate(LinDiarioMovimiento."Assignment County", County);
                    LinDiarioMovimiento.Validate(LinDiarioMovimiento."Assignment Country Code", "Country/Region Code");
                    LinDiarioMovimiento.Validate(LinDiarioMovimiento."Assignment Contact", "Contact Name");
                    //}
                    LinDiarioMovimiento.Validate(LinDiarioMovimiento."Assignment Cust Ship Address", "Ship-to Code");
                    //{
                    LinDiarioMovimiento.Validate(LinDiarioMovimiento."Assignment Ship-to Name", "Ship-to Name");
                    LinDiarioMovimiento.Validate(LinDiarioMovimiento."Assignment Ship-to Name 2", "Ship-to Name 2");
                    LinDiarioMovimiento.Validate(LinDiarioMovimiento."Assignment Ship-to Address", "Ship-to Address");
                    LinDiarioMovimiento.Validate(LinDiarioMovimiento."Assignment Ship-to Address 2", "Ship-to Address 2");
                    LinDiarioMovimiento.Validate(LinDiarioMovimiento."Assignment Ship-to City", "Ship-to City");
                    LinDiarioMovimiento.Validate(LinDiarioMovimiento."Assignment Ship-to Post Code", "Ship-to Post Code");
                    LinDiarioMovimiento.Validate(LinDiarioMovimiento."Assignment Ship-to County", "Ship-to County");
                    LinDiarioMovimiento.Validate(LinDiarioMovimiento."Assignment Ship-to Country Cod", "Ship-to Country/Region Code");
                    //}
                    LinDiarioMovimiento.Validate(LinDiarioMovimiento.Printed, false);
                    LinDiarioMovimiento.Validate(LinDiarioMovimiento."CMR Necessary", false);
                    LinDiarioMovimiento.Validate(LinDiarioMovimiento."Responsibility Center", "Responsibility Center");
                    LinDiarioMovimiento.Validate(LinDiarioMovimiento."User Id", UserId);
                    LinDiarioMovimiento.Validate(LinDiarioMovimiento."Global Dimension 1 Code",
                                                 SelectedServContractLines."Shortcut Dimension 1 Code_LDR");
                    LinDiarioMovimiento.Validate(LinDiarioMovimiento."Global Dimension 2 Code",
                                                 SelectedServContractLines."Shortcut Dimension 2 Code_LDR");
                    LinDiarioMovimiento."Dimension Set ID" := SelectedServContractLines."Dimension Set ID_LDR";
                    LinDiarioMovimiento.Validate(LinDiarioMovimiento."Source Table Id", Database::"Service Contract Line");
                    LinDiarioMovimiento.Validate(LinDiarioMovimiento."Source Type", "Contract Type");
                    LinDiarioMovimiento.Validate(LinDiarioMovimiento."Source Document No.", "Contract No.");
                    LinDiarioMovimiento.Validate(LinDiarioMovimiento."Source Line No.", SelectedServContractLines."Line No.");
                    LinDiarioMovimiento.Validate(LinDiarioMovimiento."Shipping Agent Code", "Shipping Agent Code_LDR");
                    LinDiarioMovimiento.CalcFields("Serial No.", Own);
                    if Fast then begin
                        LinDiarioMovimiento."Fast Register" := true;
                    end;
                    LinDiarioMovimiento.Modify(true);

                    Contador := Contador + 1;

                    if Fast then begin
                        LinDiarioMovimiento.SetRecFilter();
                        //Report.Run(Report::Report7122055, false, true, LinDiarioMovimiento);
                        Codeunit.Run(Codeunit::"Service Item Entry-Post_LDR", LinDiarioMovimiento);
                    end;
                end;
            until SelectedServContractLines.Next() = 0;

            Message(StrSubstNo(txtEntregaRecogida, Contador));
        end;
    end;

    procedure GenerateCollection(var SelectedServContractLines: Record "Service Contract Line"; Fast: Boolean);
    var
        TempLinDiarioMovimiento: Record "Serv.Item. Entry Journal_LDR";
        LinDiarioMovimiento: Record "Serv.Item. Entry Journal_LDR";
        ContactGroup: Record "Contract Group";
        ServItem: Record "Service Item";
        ServMgtSetup: Record "Service Mgt. Setup";
        Contador: Integer;
        DocNo: Code[20];
        JournalBatch: Record "Serv.Item Entr Journ Batch_LDR";
        NoSeriesMgt: Codeunit "NoSeriesManagement";
    begin
        ServMgtSetup.Get();
        ServMgtSetup.TestField("No. Internal Customer_LDR");

        SourceCodeSetup.Get();
        SourceCodeSetup.TestField(SourceCodeSetup."Service Item Entry Journal_LDR");

        TestField("Contract Group Code");
        TestField(Status, Status::Signed);

        ContactGroup.Get("Contract Group Code");
        ContactGroup.TestField(ContactGroup."Impresion type_LDR", ContactGroup."Impresion type_LDR"::Rent);

        if not GetJournalBatch(SourceCodeSetup."Service Item Entry Journal_LDR", JournalBatch) then
            Error('');

        if SelectedServContractLines.FindSet() then begin
            repeat
                SelectedServContractLines.CalcFields("Collection Planified_LDR", "Collection Realiced_LDR");
                if (SelectedServContractLines."Collection Planified_LDR" = false) and
                   (SelectedServContractLines."Collection Realiced_LDR" = false) then begin

                    ServItem.Get(SelectedServContractLines."Service Item No.");

                    Clear(TempLinDiarioMovimiento);
                    TempLinDiarioMovimiento.SetRange(TempLinDiarioMovimiento."Journal Template Name",
                      SourceCodeSetup."Service Item Entry Journal_LDR");
                    TempLinDiarioMovimiento.SetRange(TempLinDiarioMovimiento."Journal Batch Name", JournalBatch.Name);
                    if TempLinDiarioMovimiento.FindLast() then;

                    if JournalBatch."No. Series" = '' then begin
                        DocNo := "Contract No.";
                    end else begin
                        Clear(NoSeriesMgt);
                        DocNo := NoSeriesMgt.TryGetNextNo(JournalBatch."No. Series", SelectedServContractLines."Contract Expiration Date");
                    end;

                    Clear(LinDiarioMovimiento);
                    LinDiarioMovimiento.Validate(LinDiarioMovimiento."Journal Template Name",
                       SourceCodeSetup."Service Item Entry Journal_LDR");
                    LinDiarioMovimiento.Validate(LinDiarioMovimiento."Journal Batch Name", JournalBatch.Name);
                    LinDiarioMovimiento.Validate(LinDiarioMovimiento."Line No.", TempLinDiarioMovimiento."Line No." + 10000);
                    LinDiarioMovimiento.Insert(true);
                    LinDiarioMovimiento.Validate("Entry Type", LinDiarioMovimiento."Entry Type"::"Recogida Fin Contrato Alquiler");
                    LinDiarioMovimiento.Validate(LinDiarioMovimiento."Posting Date", SelectedServContractLines."Contract Expiration Date");
                    LinDiarioMovimiento.Validate(LinDiarioMovimiento."Document No.", DocNo);
                    LinDiarioMovimiento.Validate(LinDiarioMovimiento."Service Item No.", SelectedServContractLines."Service Item No.");
                    LinDiarioMovimiento.Validate(LinDiarioMovimiento.Description, SelectedServContractLines.Description);
                    LinDiarioMovimiento.Validate(LinDiarioMovimiento."Originally Customer", "Customer No.");
                    //{
                    LinDiarioMovimiento.Validate(LinDiarioMovimiento."Originally Name", Name);
                    LinDiarioMovimiento.Validate(LinDiarioMovimiento."Originally Name 2", "Name 2");
                    LinDiarioMovimiento.Validate(LinDiarioMovimiento."Originally Address", Address);
                    LinDiarioMovimiento.Validate(LinDiarioMovimiento."Originally Address 2", "Address 2");
                    LinDiarioMovimiento.Validate(LinDiarioMovimiento."Originally City", City);
                    LinDiarioMovimiento.Validate(LinDiarioMovimiento."Originally Post Code", "Post Code");
                    LinDiarioMovimiento.Validate(LinDiarioMovimiento."Originally County", County);
                    LinDiarioMovimiento.Validate(LinDiarioMovimiento."Originally Country Code", "Country/Region Code");
                    LinDiarioMovimiento.Validate(LinDiarioMovimiento."Originally Contact", "Contact Name");
                    //}
                    LinDiarioMovimiento.Validate(LinDiarioMovimiento."Originally Cust Ship Address", "Ship-to Code");
                    //{
                    LinDiarioMovimiento.Validate(LinDiarioMovimiento."Originally Ship-to Name", "Ship-to Name");
                    LinDiarioMovimiento.Validate(LinDiarioMovimiento."Originally Ship-to Name 2", "Ship-to Name 2");
                    LinDiarioMovimiento.Validate(LinDiarioMovimiento."Originally Ship-to Address", "Ship-to Address");
                    LinDiarioMovimiento.Validate(LinDiarioMovimiento."Originally Ship-to Address 2", "Ship-to Address 2");
                    LinDiarioMovimiento.Validate(LinDiarioMovimiento."Originally Ship-to City", "Ship-to City");
                    LinDiarioMovimiento.Validate(LinDiarioMovimiento."Originally Ship-to Post Code", "Ship-to Post Code");
                    LinDiarioMovimiento.Validate(LinDiarioMovimiento."Originally Ship-to County", "Ship-to County");
                    LinDiarioMovimiento.Validate(LinDiarioMovimiento."Originally Ship-to Country Cod", "Ship-to Country/Region Code");
                    //}
                    LinDiarioMovimiento.Validate(LinDiarioMovimiento."Assignment Customer", ServMgtSetup."No. Internal Customer_LDR");
                    LinDiarioMovimiento.Validate(LinDiarioMovimiento."Assignment Cust Ship Address", LinDiarioMovimiento.GetLastInternalShipCode);
                    LinDiarioMovimiento.Validate(LinDiarioMovimiento.Printed, false);
                    LinDiarioMovimiento.Validate(LinDiarioMovimiento."CMR Necessary", false);
                    LinDiarioMovimiento.Validate(LinDiarioMovimiento."Responsibility Center", "Responsibility Center");
                    LinDiarioMovimiento.Validate(LinDiarioMovimiento."User Id", UserId);
                    LinDiarioMovimiento.Validate(LinDiarioMovimiento."Global Dimension 1 Code",
                                                 SelectedServContractLines."Shortcut Dimension 1 Code_LDR");
                    LinDiarioMovimiento.Validate(LinDiarioMovimiento."Global Dimension 2 Code",
                                                 SelectedServContractLines."Shortcut Dimension 2 Code_LDR");
                    LinDiarioMovimiento."Dimension Set ID" := SelectedServContractLines."Dimension Set ID_LDR";
                    LinDiarioMovimiento.Validate(LinDiarioMovimiento."Source Table Id", Database::"Service Contract Line");
                    LinDiarioMovimiento.Validate(LinDiarioMovimiento."Source Type", "Contract Type");
                    LinDiarioMovimiento.Validate(LinDiarioMovimiento."Source Document No.", "Contract No.");
                    LinDiarioMovimiento.Validate(LinDiarioMovimiento."Source Line No.", SelectedServContractLines."Line No.");
                    LinDiarioMovimiento.Validate(LinDiarioMovimiento."Shipping Agent Code", "Shipping Agent Code_LDR");
                    LinDiarioMovimiento.CalcFields("Serial No.", Own);
                    if Fast then begin
                        LinDiarioMovimiento."Fast Register" := true;
                    end;

                    LinDiarioMovimiento.Modify(true);

                    Contador := Contador + 1;

                    if Fast then begin
                        LinDiarioMovimiento.SetRecFilter();
                        //Report.Run(Report::Report7122055, false, true, LinDiarioMovimiento);
                        Codeunit.Run(Codeunit::"Service Item Entry-Post_LDR", LinDiarioMovimiento);
                    end;
                end;
            until SelectedServContractLines.Next() = 0;
            Message(StrSubstNo(txtEntregaRecogida, Contador));
        end;
    end;

    procedure GetJournalBatch(TemplateName: Code[20]; var SelectedJournalBatch: Record "Serv.Item Entr Journ Batch_LDR"): Boolean;
    var
    //frmJournalBatch: Page 70060;
    begin
        Clear(SelectedJournalBatch);
        SelectedJournalBatch.SetRange("Journal Template Name", TemplateName);
        SelectedJournalBatch.FindSet();
        // Clear(frmJournalBatch);
        // frmJournalBatch.LookupMode(true);
        // frmJournalBatch.SetTableView(SelectedJournalBatch);
        // if frmJournalBatch.RunModal = Action::LookupOK then begin
        //     frmJournalBatch.GetRecord(SelectedJournalBatch);
        //     exit(true);
        // end else begin
        //     exit(false);
        // end;
    end;

    procedure Register();
    var
        txtWorkDate: TextConst ENU = 'Contract ending date has not expired', ESP = 'La fecha de fin del contrato aún no ha vencido';
        txtLineInvoicing: TextConst ENU = '%1 can not be less than %2 in Contract %3 line No. %4', ESP = '%1 no puede ser inferior a %2 en Contrato %3 No. línea %4';
        TxtConfirm: TextConst ENU = 'Do you want to Post Service Contract?', ESP = '¿Confirma que desea pasar a Histórico el Contrato?';
        ServContractLine: Record "Service Contract Line";
    begin
        TestField(Historical_LDR, false);

        IF not Confirm(TxtConfirm, false) then
            exit;

        case Status of
            Status::Cancelled:
                begin
                    ServContractLine.Reset();
                    ServContractLine.SetRange("Contract Type", "Contract Type");
                    ServContractLine.SetRange("Contract No.", "Contract No.");
                    ServContractLine.ModifyAll(Historical_LDR, true);

                    Validate(Historical_LDR, true);
                    Modify(true);
                end;
            else begin
                TestField("Expiration Date");
                if WorkDate < "Expiration Date" then
                    Error(txtWorkDate);

                ServContractLine.Reset();
                ServContractLine.SetRange("Contract Type", "Contract Type");
                ServContractLine.SetRange("Contract No.", "Contract No.");
                if ServContractLine.FindSet() then begin
                    ServContractLine.TestField("Contract Expiration Date");
                    if ServContractLine."Invoiced to Date" < ServContractLine."Contract Expiration Date" then begin
                        Error(txtLineInvoicing, ServContractLine.FieldCaption("Invoiced to Date"),
                                               ServContractLine.FieldCaption("Contract Expiration Date"),
                                               ServContractLine."Contract No.", ServContractLine."Line No.");
                    end;
                end;
            end;
        end;

        ServContractLine.Reset();
        ServContractLine.SetRange("Contract Type", "Contract Type");
        ServContractLine.SetRange("Contract No.", "Contract No.");
        ServContractLine.ModifyAll(Historical_LDR, true, false);

        Validate(Historical_LDR, true);
        Modify(false);
    end;

    procedure UnRegister();
    var
        TxtConfirm: TextConst ENU = 'Do you want to Re-activate Service Contract?', ESP = '¿Confirma que desea reactivar el Contrato?';
        ServContractLine: Record "Service Contract Line";
    begin
        TestField(Historical_LDR, true);

        if not Confirm(TxtConfirm, false) then
            exit;

        ServContractLine.Reset();
        ServContractLine.SetRange("Contract Type", "Contract Type");
        ServContractLine.SetRange("Contract No.", "Contract No.");
        ServContractLine.ModifyAll(Historical_LDR, false, false);

        Validate(Historical_LDR, false);
        Modify(false);
    end;

    procedure CreateLinkedInternalContract();
    var
        //CreateRelatedInternal: Report 70107;
        TempServContract: Record "Service Contract Header";
    begin
        TestField("Change Status", "Change Status"::Open);
        TestField(Status, Status::Signed);
        TestField("Internal Contract No._LDR", '');

        TempServContract.Copy(Rec);
        TempServContract.SetRecFilter();
        //CreateRelatedInternal.SetTableView(TempServContract);
        //CreateRelatedInternal.RunModal();
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
                    NewAlarm."Serv. Contract" := true;
                    NewAlarm.Insert(true);
                end;
            2:
                begin

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
                    NewAlarm.Insert(true);
                end;
        end;

        // Clear(AlarmCard);
        // AlarmCard.SetTableView(NewAlarm);
        // AlarmCard.SetRecord(NewAlarm);
        // AlarmCard.Run();
    end;

    procedure CreateAlarmForLine(var servContractLine: Record "Service Contract Line");
    var
        NewAlarm: Record "Alarms_LDR";
    //AlarmCard: Page 70104;
    begin
        Clear(NewAlarm);
        NewAlarm."Alarm No." := NewAlarm.GetNextAlarmNo;
        NewAlarm."Start Date" := WorkDate;
        NewAlarm."Source Type" := NewAlarm."Source Type"::"Service Item";
        NewAlarm."Source No." := servContractLine."Service Item No.";
        NewAlarm."User ID" := UserId;
        NewAlarm."Serv. Contract" := true;
        NewAlarm.Insert(true);

        // Clear(AlarmCard);
        // AlarmCard.SetTableView(NewAlarm);
        // AlarmCard.SetRecord(NewAlarm);
        // AlarmCard.Run();
    end;

    local procedure UpdateAllLineDim(NewParentDimSetID: Integer; OldParentDimSetID: Integer);
    var
        ATOLink: Record "Assemble-to-Order Link";
        NewDimSetID: Integer;
        ServContractLine: Record "Service Contract Line";
        DimMgt: Codeunit "DimensionManagement";
    begin
        if NewParentDimSetID = OldParentDimSetID then
            exit;
        if not HideValidationDialog and GuiAllowed then
            if not Confirm(Text50001) then
                exit;

        ServContractLine.Reset();
        ServContractLine.SetRange("Contract Type", "Contract Type");
        ServContractLine.SetRange("Contract No.", "Contract No.");
        ServContractLine.LockTable();
        if ServContractLine.Find('-') then
            repeat
                NewDimSetID := DimMgt.GetDeltaDimSetID(ServContractLine."Dimension Set ID_LDR", NewParentDimSetID, OldParentDimSetID);
                if ServContractLine."Dimension Set ID_LDR" <> NewDimSetID then begin
                    ServContractLine."Dimension Set ID_LDR" := NewDimSetID;
                    DimMgt.UpdateGlobalDimFromDimSetID(
                      ServContractLine."Dimension Set ID_LDR", ServContractLine."Shortcut Dimension 1 Code_LDR", ServContractLine."Shortcut Dimension 2 Code_LDR");
                    ServContractLine.Modify();
                end;
            until ServContractLine.Next() = 0;
    end;

    procedure TestCustGeneralQuote(CustNo: Code[20]);
    var
        PlatformQuote: Record "Service Contract Header";
    begin
        Clear(PlatformQuote);
        PlatformQuote.SetRange("Customer No.", CustNo);
        PlatformQuote.SetRange("Service Quote Type_LDR", PlatformQuote."Service Quote Type_LDR"::General);
        PlatformQuote.SetRange(Historical_LDR, false);
        if PlatformQuote.FindFirst() then
            Error(Text50002);
    end;
}