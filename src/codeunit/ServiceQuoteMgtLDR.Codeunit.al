/// <summary>
/// Codeunit Service Quote Mgt._LDR (ID 50001)
/// </summary>
codeunit 50001 "Service Quote Mgt._LDR"
{
    trigger OnRun()
    begin
        QuoteStartTemp.INSERT;
        PAGE.RUN(PAGE::"Insert Quote", QuoteStartTemp);
    end;

    var
        QuoteStartTemp: Record "Quote Start Temp_LDR" temporary;
        Text001: Label 'Default Operation';
        CraneMgtSetup: Record "Crane Mgt. Setup_LDR";
        Text002: Label 'General Terms Quote';
        Text003: Label 'For Customer %3 - %4 has been automatically created:\Crane General Terms Quote No. %1\Platform General Terms Quote No. %2';
        Text004: Label 'For Customer %2 - %3 has been automatically created:\Crane General Terms Quote No. %1';
        Text005: Label 'For Customer %2 - %3 has been automatically created:\Platform General Terms Quote No. %1';
        Text006: Label 'Quote dont have %1 overdued\ Continue?';
        Text007: Label 'There are no service requests associated with the Crane Quote\ Continue?';
        Text008: Label 'This detail has already been invoiced. \ Continue?';
        Text009: Label 'Service Invoice No. %1 has been created.';
        Text010: Label 'Ref. Quote No. %1';
        Text011: Label 'Service Order No. %1 has some lines with %2 different from %3\Do you want to continue?';
        Text012: Label 'The process has been interrupted to respect the warning.';
        Text013: Label 'Automatic Quote creation is activated. Which type of Quote do you want to create?';
        Text014: Label '&None,&Crane,&Platform,&Both Crane and Platform';
        Text015: Label 'There can only be one General Type Quote by Customer';
        Text016: Label 'Quote No. %1 has pending Forfait Calendar Entries. ';
        Text017: Label 'By distributing a Fofait Quote, you won''t be able to create new linked Serv. Orders, such it will be impossible to recover that quote from archive. Are you sure yo want to proceed?';
        Text018: Label 'Quote No. %1 has been properly distributed. Please, verify the set up journal';
        Text019: Label 'Please, post the Service Invoice No %1 before distributing this Crane Quote.';
        Text020: Label 'Operation %1 - %2 has no Service Order linked, so the amount of %3 won''t be distributed. Do you want to continue?';
        Text021: Label 'There is already a Displacement Amount. Doy you want to overwrite it?';

    /// <summary>
    /// CreateCraneQuote()
    /// </summary>
    procedure CreateCraneQuote(pQuoteStartTemp: Record "Quote Start Temp_LDR")
    var
        CraneServiceQuote: Record "Crane Service Quote Header_LDR";
        Cust: Record "Customer";
    begin
        /*
        CraneMgtSetup.GET;

        CraneServiceQuote.INIT;
        CraneServiceQuote.Description := pQuoteStartTemp.Description;
        CraneServiceQuote."Customer No." := pQuoteStartTemp."Customer No.";
        CraneServiceQuote."Contact No." := pQuoteStartTemp."Contact No.";
        CraneServiceQuote."Contact Name" := pQuoteStartTemp."Contact Name";
        CraneServiceQuote."Ship-to Address Code" := pQuoteStartTemp."Ship-to Address Code";
        CraneServiceQuote."Quote Type" := pQuoteStartTemp."Quote Type";
        CraneServiceQuote."Starting Date" := pQuoteStartTemp."Starting Date";
        CraneServiceQuote."Ending Date" := pQuoteStartTemp."Ending Date";
        CraneServiceQuote."Quote Date" := WORKDATE;
        IF pQuoteStartTemp."Quote Type" = pQuoteStartTemp."Quote Type"::General THEN
            CheckExistGeneralQuote(pQuoteStartTemp."Customer No.");

        Cust.GET(pQuoteStartTemp."Customer No.");

        IF Cust."Invoice Period" = Cust."Invoice Period"::Fortnightly THEN
            CraneServiceQuote."Invoice Period" := CraneServiceQuote."Invoice Period"::TwoWeeks
        ELSE
            CraneServiceQuote."Invoice Period" := CraneServiceQuote."Invoice Period"::Month;

        CraneServiceQuote."Invoicing Type" := Cust."Invoicing Type";
        //Valores por defecto
        CraneServiceQuote."Displacement %" := 100;
        CraneServiceQuote."Apply Saturday Surcharge" := TRUE;
        CraneServiceQuote."Apply Festive Surcharge" := TRUE;
        CraneServiceQuote."Apply Night Surcharge" := TRUE;
        CraneServiceQuote."Apply Minimum" := TRUE;
        CraneServiceQuote."Invoice Displacement" := TRUE;
        CraneServiceQuote."Fill minimum with Displ." := TRUE;
        CraneServiceQuote."Rate Code" := CraneMgtSetup."General Rate No";
        CraneServiceQuote."Apply Standard KMs" := TRUE;

        CraneServiceQuote.INSERT(TRUE);

        IF pQuoteStartTemp."Quote Type" = pQuoteStartTemp."Quote Type"::General THEN BEGIN
            CompleteGeneralCraneQuote(CraneServiceQuote."Quote no.");
            MESSAGE(Text004, CraneServiceQuote."Quote no.", CraneServiceQuote."Customer No.", CraneServiceQuote."Customer Name");
        END ELSE
            IF pQuoteStartTemp."Quote Type" = pQuoteStartTemp."Quote Type"::Forfait THEN
                CompleteForfaitCraneQuote(CraneServiceQuote."Quote no.");

        // Abrir la pagina destino
        PAGE.RUN(PAGE::"Crane Service Quote Card", CraneServiceQuote);
    end;

    /// <summary>
    /// CreatePLatformQuote()
    /// </summary>
    procedure CreatePLatformQuote(pQuoteStartTemp: Record "Quote Start Temp_LDR")
    var
        CraneServiceQuote: Record "Crane Service Quote Header_LDR";
        Cust: Record "Customer";
    begin
        CraneMgtSetup.GET;

        CraneServiceQuote.INIT;
        CraneServiceQuote.Description := pQuoteStartTemp.Description;
        CraneServiceQuote."Quote Type" := pQuoteStartTemp."Quote Type";
        CraneServiceQuote.VALIDATE("Customer No.", pQuoteStartTemp."Customer No.");
        //CraneServiceQuote."Customer No." := pQuoteStartTemp."Customer No.";
        CraneServiceQuote."Contact No." := pQuoteStartTemp."Contact No.";
        CraneServiceQuote."Contact Name" := pQuoteStartTemp."Contact Name";
        CraneServiceQuote."Ship-to Address Code" := pQuoteStartTemp."Ship-to Address Code";
        CraneServiceQuote."Starting Date" := pQuoteStartTemp."Starting Date";
        CraneServiceQuote."Ending Date" := pQuoteStartTemp."Ending Date";
        CraneServiceQuote."Quote Date" := WORKDATE;
        CraneServiceQuote."Platform Quote" := TRUE;
        IF pQuoteStartTemp."Quote Type" = pQuoteStartTemp."Quote Type"::General THEN
            CheckExistGeneralPlatformQuote(pQuoteStartTemp."Customer No.");

        Cust.GET(pQuoteStartTemp."Customer No.");

        IF Cust."Invoice Period" = Cust."Invoice Period"::Fortnightly THEN
            CraneServiceQuote."Invoice Period" := CraneServiceQuote."Invoice Period"::TwoWeeks
        ELSE
            CraneServiceQuote."Invoice Period" := CraneServiceQuote."Invoice Period"::Month;

        CraneServiceQuote."Invoicing Type" := Cust."Invoicing Type";

        CraneServiceQuote.INSERT(TRUE);

        IF pQuoteStartTemp."Quote Type" = pQuoteStartTemp."Quote Type"::General THEN BEGIN
            CompleteGeneralPlatformQuote(CraneServiceQuote."Quote no.");
            MESSAGE(Text004, CraneServiceQuote."Quote no.", CraneServiceQuote."Customer No.", CraneServiceQuote."Customer Name");
        END;

        // Abrir la pagina destino
        PAGE.RUN(PAGE::"Platform Service Quote Card", CraneServiceQuote);
        */
    end;

    /// <summary>
    /// CreatePlatformQuoteOLD()
    /// </summary>
    procedure CreatePlatformQuoteOLD(pQuoteStartTemp: Record "Quote Start Temp_LDR")
    var
        ServiceContractHeader: Record "Service Contract Header";
        Cust: Record "Customer";
    begin
        /*
        CraneMgtSetup.GET;
        Cust.GET(pQuoteStartTemp."Customer No.");

        ServiceContractHeader.INIT;
        ServiceContractHeader."Contract Type" := ServiceContractHeader."Contract Type"::Contract;
        ServiceContractHeader.Description := pQuoteStartTemp.Description;
        ServiceContractHeader.VALIDATE("Customer No.", pQuoteStartTemp."Customer No.");

        IF pQuoteStartTemp."Quote Type" = pQuoteStartTemp."Quote Type"::General THEN
            CheckExistGeneralContract(pQuoteStartTemp."Customer No.");

        ServiceContractHeader.VALIDATE("Contact No.", pQuoteStartTemp."Contact No.");
        ServiceContractHeader."Contact Name" := pQuoteStartTemp."Contact Name";
        ServiceContractHeader.VALIDATE("Ship-to Code", pQuoteStartTemp."Ship-to Address Code");
        ServiceContractHeader."Quote Type" := pQuoteStartTemp."Quote Type";
        ServiceContractHeader."Starting Date" := pQuoteStartTemp."Starting Date";
        ServiceContractHeader."First Service Date" := pQuoteStartTemp."Starting Date";
        IF pQuoteStartTemp."Ending Date" <> 0D THEN
            ServiceContractHeader."Expiration Date" := pQuoteStartTemp."Ending Date"
        ELSE
            ServiceContractHeader."Expiration Date" := CALCDATE('<CY+2Y>', WORKDATE);

        ServiceContractHeader."Day Invoicing" := TRUE;

        IF Cust."Invoice Period" = Cust."Invoice Period"::Monthly THEN BEGIN
            ServiceContractHeader."Invoice Period" := ServiceContractHeader."Invoice Period"::Month;
            ServiceContractHeader."Invoice Day of Month" := Cust."Days Until Report";
        END ELSE
            ServiceContractHeader."Invoice Period" := ServiceContractHeader."Invoice Period"::Fortnight; //TODO: Error: Invoice Period no contiene la definición Fortnight

        ServiceContractHeader."Contract Group Code" := CraneMgtSetup."Platf. Serv. Contract Group";
        ServiceContractHeader."Serv. Contract Acc. Gr. Code" := CraneMgtSetup."Platf. Serv. Cont. Acc. Group";
        ServiceContractHeader."Service Order Type" := '';

        ServiceContractHeader."Service Period" := CraneMgtSetup."Default Service Period";
        ServiceContractHeader."Service Quote Type" := pQuoteStartTemp."Quote Type";

        ServiceContractHeader."Serv. Contract Inv. Group" := '';

        ServiceContractHeader."Service Item Tariff No." := CraneMgtSetup."General Rate No";


        ServiceContractHeader."Invoicing Type" := Cust."Invoicing Type";
        //Si el cliente tiene facturación por pedido, se marca como retenido el pedido.
        IF Cust."Invoicing Type" = Cust."Invoicing Type"::Order THEN
            ServiceContractHeader.Retained := TRUE;

        ServiceContractHeader.INSERT(TRUE);

        IF pQuoteStartTemp."Quote Type" = pQuoteStartTemp."Quote Type"::General THEN BEGIN
            CompleteGeneralPlatformQuoteOLD(ServiceContractHeader);
            MESSAGE(Text005, ServiceContractHeader."Contract No.", ServiceContractHeader."Customer No.", ServiceContractHeader.Name);
        END;

        // Abrir la pagina destino
        PAGE.RUN(PAGE::"Service Contract", ServiceContractHeader);
        */
    end;

    /// <summary>
    /// CheckExistGeneralQuote()
    /// </summary>
    procedure CheckExistGeneralQuote(pCustomerNo: Code[20])
    var
        CraneServiceQuote: Record "Crane Service Quote Header_LDR";
    begin
        CLEAR(CraneServiceQuote);
        CraneServiceQuote.SETRANGE("Customer No.", pCustomerNo);
        CraneServiceQuote.SETRANGE("Quote Type", CraneServiceQuote."Quote Type"::General);
        CraneServiceQuote.SETRANGE(Historical, FALSE);
        CraneServiceQuote.SETRANGE("Platform Quote", FALSE);
        IF NOT CraneServiceQuote.ISEMPTY THEN
            ERROR(Text015);
    end;

    /// <summary>
    /// CheckExistGeneralPlatformQuote()
    /// </summary>
    procedure CheckExistGeneralPlatformQuote(pCustomerNo: Code[20])
    var
        CraneServiceQuote: Record "Crane Service Quote Header_LDR";
    begin
        CLEAR(CraneServiceQuote);
        CraneServiceQuote.SETRANGE("Customer No.", pCustomerNo);
        CraneServiceQuote.SETRANGE("Quote Type", CraneServiceQuote."Quote Type"::General);
        CraneServiceQuote.SETRANGE(Historical, FALSE);
        CraneServiceQuote.SETRANGE("Platform Quote", TRUE);
        IF NOT CraneServiceQuote.ISEMPTY THEN
            ERROR(Text015);
    end;

    /// <summary>
    /// CheckExistGeneralContract()
    /// </summary>
    procedure CheckExistGeneralContract(pCustomerNo: Code[20])
    var
        ServiceContractHeader: Record "Service Contract Header";
    begin
        CLEAR(ServiceContractHeader);
        ServiceContractHeader.SETRANGE("Customer No.", pCustomerNo);
        ServiceContractHeader.SETRANGE("Service Quote Type_LDR", ServiceContractHeader."Service Quote Type_LDR"::General);
        ServiceContractHeader.SETRANGE(Historical_LDR, FALSE);
        IF NOT ServiceContractHeader.ISEMPTY THEN
            ERROR(Text015);
    end;

    /// <summary>
    /// CreateGeneralQuote()
    /// </summary>
    procedure CreateGeneralQuote(pCust: Record "Customer")
    var
        CraneServQuoteHeader: Record "Crane Service Quote Header_LDR";
        ServiceContractHeader: Record "Service Contract Header";
        bCraneQuoteCreated: BoolEAN;
        bPlatformQuoteCreated: BoolEAN;
        SignServContractDoc: Codeunit "SignServContractDoc";
        Selection: Integer;
        CraneServiceQuote: Record "Crane Service Quote Header_LDR";
        Cust: Record "Customer";
    begin
        CraneMgtSetup.GET;
        /*
        IF (DT2DATE(pCust."Created Date") = WORKDATE) THEN BEGIN


            Selection := STRMENU(Text014, 1, Text013);
            //ERROR('');

            IF Selection IN [2, 4] THEN BEGIN

                CLEAR(CraneServQuoteHeader);
                CraneServQuoteHeader.SETRANGE("Customer No.", pCust."No.");
                CraneServQuoteHeader.SETRANGE("Quote Type", CraneServQuoteHeader."Quote Type"::General);
                CraneServQuoteHeader.SETFILTER("Quote Status", '<>%1', CraneServQuoteHeader."Quote Status"::Rejected);

                IF NOT CraneServQuoteHeader.FINDFIRST THEN BEGIN
                    CLEAR(CraneServQuoteHeader);

                    CraneServQuoteHeader.INIT;
                    CraneServQuoteHeader.Description := Text002;
                    CraneServQuoteHeader."Customer No." := pCust."No.";
                    CraneServQuoteHeader."Quote Type" := CraneServQuoteHeader."Quote Type"::General;
                    CraneServQuoteHeader."Starting Date" := CALCDATE('<-CY>', WORKDATE);
                    CraneServQuoteHeader."Ending Date" := CALCDATE('<10Y>', CALCDATE('<CY>', WORKDATE));
                    CraneServQuoteHeader."Quote Date" := WORKDATE;
                    CraneServQuoteHeader."Rate Code" := CraneMgtSetup."General Rate No";

                    //Valores por defecto
                    CraneServQuoteHeader."Displacement %" := 100;
                    CraneServQuoteHeader."Apply Saturday Surcharge" := TRUE;
                    CraneServQuoteHeader."Apply Festive Surcharge" := TRUE;
                    CraneServQuoteHeader."Apply Night Surcharge" := TRUE;
                    CraneServQuoteHeader."Apply Minimum" := TRUE;
                    CraneServQuoteHeader."Invoice Displacement" := TRUE;
                    CraneServQuoteHeader."Fill minimum with Displ." := TRUE;

                    IF pCust."Invoice Period" = pCust."Invoice Period"::Fortnightly THEN
                        CraneServQuoteHeader."Invoice Period" := CraneServQuoteHeader."Invoice Period"::TwoWeeks
                    ELSE
                        CraneServQuoteHeader."Invoice Period" := CraneServQuoteHeader."Invoice Period"::Month;

                    CraneServQuoteHeader."Invoicing Type" := pCust."Invoicing Type";

                    CraneServQuoteHeader.INSERT(TRUE);

                    CompleteGeneralCraneQuote(CraneServQuoteHeader."Quote no.");

                    bCraneQuoteCreated := TRUE;
                END;
            END;
            IF Selection IN [3, 4] THEN BEGIN
                //CREAR OFERTA GENERAL DE PLATAFORMAS
                CraneServiceQuote.INIT;
                CraneServiceQuote.Description := Text002;
                CraneServiceQuote."Customer No." := pCust."No.";
                //CraneServiceQuote."Contact No." := pQuoteStartTemp."Contact No.";
                //CraneServiceQuote."Contact Name" := pQuoteStartTemp."Contact Name";
                //CraneServiceQuote."Ship-to Address Code" := pQuoteStartTemp."Ship-to Address Code";
                CraneServiceQuote."Quote Type" := CraneServiceQuote."Quote Type"::General;
                CraneServiceQuote."Starting Date" := CALCDATE('<-CY>', WORKDATE);
                CraneServiceQuote."Ending Date" := CALCDATE('<10Y>', CALCDATE('<CY>', WORKDATE));
                CraneServiceQuote."Quote Date" := WORKDATE;
                CraneServiceQuote."Platform Quote" := TRUE;
                CheckExistGeneralPlatformQuote(pCust."No.");

                IF pCust."Invoice Period" = pCust."Invoice Period"::Fortnightly THEN
                    CraneServiceQuote."Invoice Period" := CraneServiceQuote."Invoice Period"::TwoWeeks
                ELSE
                    CraneServiceQuote."Invoice Period" := CraneServiceQuote."Invoice Period"::Month;

                CraneServiceQuote."Invoicing Type" := pCust."Invoicing Type";

                CraneServiceQuote.INSERT(TRUE);

                CompleteGeneralPlatformQuote(CraneServiceQuote."Quote no.");
            END;

            IF bCraneQuoteCreated AND bPlatformQuoteCreated THEN
                MESSAGE(Text003, CraneServQuoteHeader."Quote no.", ServiceContractHeader."Contract No.", pCust."No.", pCust.Name)
            ELSE
                IF bCraneQuoteCreated AND NOT bPlatformQuoteCreated THEN
                    MESSAGE(Text004, CraneServQuoteHeader."Quote no.", pCust."No.", pCust.Name)
                ELSE
                    IF NOT bCraneQuoteCreated AND bPlatformQuoteCreated THEN
                        MESSAGE(Text005, ServiceContractHeader."Contract No.", pCust."No.", pCust.Name);
        END;
        */
    end;

    /// <summary>
    /// CompleteGeneralCraneQuote()
    /// </summary>
    procedure CompleteGeneralCraneQuote(QuoteNo: Code[20])
    var
        QuoteHeader: Record "Crane Service Quote Header_LDR";
        QuoteOpLine: Record "Crane Servic Quote Op. Lin_LDR";
        QuoteInvGrLine: Record "Crane Serv Q Op Inv G Line_LDR";
        ServiceItemRateLineCrane: Record "Servic Item Rat Li - Crane_LDR";
        LineNo: Integer;
    begin
        CraneMgtSetup.GET;
        CraneMgtSetup.TESTFIELD("General Rate No");
        //Cuando la oferta es "General", hay que aplicarle la tarifa general, crear una operacion "Generica" e introducir todos los grupos de facturacion de dicha tarifa.

        QuoteHeader.GET(QuoteNo);
        QuoteHeader."Rate Code" := CraneMgtSetup."General Rate No";
        QuoteHeader."Apply Saturday Surcharge" := TRUE;
        QuoteHeader."Apply Festive Surcharge" := TRUE;
        QuoteHeader."Apply Night Surcharge" := TRUE;
        QuoteHeader."Apply Minimum" := TRUE;
        QuoteHeader."Invoice Displacement" := TRUE;
        QuoteHeader."Displacement Type" := QuoteHeader."Displacement Type"::KMs;
        QuoteHeader."Displacement %" := 100;
        QuoteHeader."Apply Standard KMs" := TRUE;
        QuoteHeader.MODIFY(TRUE);

        CLEAR(QuoteOpLine);
        QuoteOpLine."Quote No." := QuoteHeader."Quote no.";
        QuoteOpLine."Line No." := 10000;
        QuoteOpLine."Operation No." := 1;
        QuoteOpLine."Operation Description" := Text001;
        QuoteOpLine.INSERT(TRUE);

        CLEAR(ServiceItemRateLineCrane);
        ServiceItemRateLineCrane.SETRANGE(Code, CraneMgtSetup."General Rate No");
        IF ServiceItemRateLineCrane.FINDSET THEN BEGIN
            REPEAT
                LineNo += 10000;
                CLEAR(QuoteInvGrLine);
                QuoteInvGrLine."Quote No." := QuoteHeader."Quote no.";
                QuoteInvGrLine."Operation Line No." := QuoteOpLine."Line No.";
                QuoteInvGrLine."Line No." := LineNo;
                QuoteInvGrLine."Invoice Group No." := ServiceItemRateLineCrane."Invoice Group No.";
                QuoteInvGrLine."Vehicles Number" := 1;
                QuoteInvGrLine."Rate No." := CraneMgtSetup."General Rate No";
                QuoteInvGrLine."Invoice Displacement" := TRUE;
                QuoteInvGrLine."Invoice Exit Fee" := TRUE;
                QuoteInvGrLine."Displacement Type" := QuoteInvGrLine."Displacement Type"::Hours;
                QuoteInvGrLine."Displacement Percent" := 100;
                QuoteInvGrLine."Apply standard KM" := TRUE;
                QuoteInvGrLine."Minimum Laboral Hours" := ServiceItemRateLineCrane."Min working Time";
                QuoteInvGrLine."Minimum Saturday Hours" := ServiceItemRateLineCrane."Min Saturday Hours";
                QuoteInvGrLine."Minimum Holiday Hours" := ServiceItemRateLineCrane."Min Holiday Time";
                QuoteInvGrLine."Minimum Night Hours" := ServiceItemRateLineCrane."Min Night Hours";
                QuoteInvGrLine."Minimum Treatment Type" := QuoteInvGrLine."Minimum Treatment Type"::Discontinuos;
                QuoteInvGrLine.INSERT(TRUE);
            UNTIL ServiceItemRateLineCrane.NEXT = 0;
        END;

        QuoteHeader."Quote Status" := QuoteHeader."Quote Status"::Blocked;
        QuoteHeader.MODIFY;
    end;

    /// <summary>
    /// CompleteGeneralPlatformQuote()
    /// </summary>
    procedure CompleteGeneralPlatformQuote(QuoteNo: Code[20])
    var
        QuoteHeader: Record "Crane Service Quote Header_LDR";
        QuoteOpLine: Record "Crane Servic Quote Op. Lin_LDR";
        PlatfServQInvGLine: Record "Platf. Serv. Q. Inv G Line_LDR";
        ServiceItemRateLinePlatf: Record "Servic Item Rat Lin - Plat_LDR";
        LineNo: Integer;
    begin
        CraneMgtSetup.GET;
        CraneMgtSetup.TESTFIELD("General Rate No");
        //Cuando la oferta es "General", hay que aplicarle la tarifa general, crear una operacion "Generica" e introducir todos los grupos de facturacion de dicha tarifa.

        QuoteHeader.GET(QuoteNo);
        QuoteHeader."Rate Code" := CraneMgtSetup."General Rate No";
        QuoteHeader.MODIFY(TRUE);

        CLEAR(ServiceItemRateLinePlatf);
        ServiceItemRateLinePlatf.SETRANGE(Code, CraneMgtSetup."General Rate No");
        IF ServiceItemRateLinePlatf.FINDSET THEN BEGIN
            REPEAT
                LineNo += 10000;
                CLEAR(PlatfServQInvGLine);

                PlatfServQInvGLine."Quote No." := QuoteHeader."Quote no.";
                PlatfServQInvGLine."Line No." := LineNo;
                PlatfServQInvGLine.INSERT(TRUE);
                PlatfServQInvGLine."Invoice Group No." := ServiceItemRateLinePlatf."Invoice Group No.";
                PlatfServQInvGLine.VALIDATE("Rate No.", CraneMgtSetup."General Rate No");
                PlatfServQInvGLine.MODIFY(TRUE);
            UNTIL ServiceItemRateLinePlatf.NEXT = 0;
        END;

        QuoteHeader."Quote Status" := QuoteHeader."Quote Status"::Blocked;
        QuoteHeader.MODIFY;
    end;

    /// <summary>
    /// CompleteGeneralPlatformQuoteOLD()
    /// </summary>
    procedure CompleteGeneralPlatformQuoteOLD(pContract: Record "Service Contract Header")
    var
        ServiceItemRateLinePlatf: Record "Servic Item Rat Lin - Plat_LDR";
        ServContractLine: Record "Service Contract Line";
        LineNo: Integer;
    begin
        CraneMgtSetup.GET;
        CraneMgtSetup.TESTFIELD("General Rate No");

        CLEAR(ServiceItemRateLinePlatf);
        ServiceItemRateLinePlatf.SETRANGE(Code, CraneMgtSetup."General Rate No");
        IF ServiceItemRateLinePlatf.FINDSET THEN BEGIN
            REPEAT
                LineNo += 10000;
                CLEAR(ServContractLine);
                ServContractLine.INIT;
                ServContractLine."Contract Type" := pContract."Contract Type";
                ServContractLine."Contract No." := pContract."Contract No.";
                ServContractLine."Line No." := LineNo;

                ServContractLine."Starting Date" := pContract."Starting Date";
                ServContractLine."Contract Expiration Date" := pContract."Expiration Date";

                ServContractLine."Customer No." := pContract."Customer No.";
                ServContractLine."Ship-to Code" := pContract."Ship-to Code";
                ServContractLine."Contract Status" := pContract.Status;
                ServContractLine."Contract Expiration Date" := pContract."Expiration Date";
                ServContractLine."Credit Memo Date" := ServContractLine."Contract Expiration Date";
                ServContractLine."Service Period" := pContract."Service Period";

                IF ServContractLine."Starting Date" > pContract."First Service Date" THEN
                    ServContractLine."Next Planned Service Date" := ServContractLine."Starting Date"
                ELSE
                    ServContractLine."Next Planned Service Date" := pContract."First Service Date";

                ServContractLine."Service Item Tariff No._LDR" := pContract."Service Item Tariff No._LDR";
                ServContractLine.VALIDATE("Serv. Item Invoice Group Code_LDR", ServiceItemRateLinePlatf."Invoice Group No.");
                ServContractLine.INSERT(TRUE);
            UNTIL ServiceItemRateLinePlatf.NEXT = 0;
        END;
    end;

    /// <summary>
    /// CompleteForfaitCraneQuote()
    /// </summary>
    procedure CompleteForfaitCraneQuote(QuoteNo: Code[20])
    var
        QuoteHeader: Record "Crane Service Quote Header_LDR";
        QuoteOpLine: Record "Crane Servic Quote Op. Lin_LDR";
        QuoteInvGrLine: Record "Crane Serv Q Op Inv G Line_LDR";
        ServiceItemRateLineCrane: Record "Servic Item Rat Li - Crane_LDR";
        LineNo: Integer;
    begin
        CraneMgtSetup.GET;
        CraneMgtSetup.TESTFIELD("General Rate No");
        //Cuando la oferta es "General", hay que aplicarle la tarifa general, crear una operacion "Generica" e introducir todos los grupos de facturacion de dicha tarifa.

        QuoteHeader.GET(QuoteNo);
        QuoteHeader."Rate Code" := CraneMgtSetup."General Rate No";
        QuoteHeader."Apply Saturday Surcharge" := TRUE;
        QuoteHeader."Apply Festive Surcharge" := TRUE;
        QuoteHeader."Apply Night Surcharge" := TRUE;
        QuoteHeader."Apply Minimum" := TRUE;
        QuoteHeader."Invoice Displacement" := TRUE;
        QuoteHeader."Displacement Type" := QuoteHeader."Displacement Type"::KMs;
        QuoteHeader."Displacement %" := 100;
        QuoteHeader."Apply Standard KMs" := TRUE;
        QuoteHeader.MODIFY(TRUE);

        CLEAR(QuoteOpLine);
        QuoteOpLine."Quote No." := QuoteHeader."Quote no.";
        QuoteOpLine."Line No." := 10000;
        QuoteOpLine."Operation No." := 1;
        QuoteOpLine."Operation Description" := Text001;
        QuoteOpLine.INSERT(TRUE);
    end;

    /// <summary>
    ///  InvoiceForfaitCraneQuote()
    /// </summary>
    procedure InvoiceForfaitCraneQuote(CraneServiceQuoteHeader: Record "Crane Service Quote Header_LDR")
    var
        TestServiceHeader: Record "Service Header";
        TestServiceItemLine: Record "Service Item Line";
        CraneMgtSetup: Record "Crane Mgt. Setup_LDR";
        TestCraneServQForfaitCalendar: Record "Crane Serv Q. Forf Calend_LDR";
        CraneServQuoteCalendar: Page "Crane Serv. Quote Calendar";
        CraneServQForfaitCalendar: Record "Crane Serv Q. Forf Calend_LDR";
        NewServiceHeader: Record "Service Header";
        NewServiceLine: Record "Service Line";
        LineNo: Integer;
        InvoiceNo: Code[20];
        CreatedInvoiceNo: Code[20];
        ServLineType: Option " ",Item,Resource,Cost,"G/L Account";
        PostedServHeader: Record "Posted Service Header_LDR";
        Temp: Action;
        CraneServQOpMicSLLUp: Page "Crane Serv. Q.Op.Mic S.L. LUp";
        CraneServQOpMicSLine: Record "Crane Serv Q Op Mic S Line_LDR";
        Concept: Record "Concept_LDR";
    begin
        /*
        CraneMgtSetup.GET;
        CraneMgtSetup.TESTFIELD("Crane Invoice Account No");
        WITH CraneServiceQuoteHeader DO BEGIN

            TESTFIELD("Quote Type", "Quote Type"::Forfait); //TODO: Error: Quote Type no existe en este TestField
            TESTFIELD("Quote Status", "Quote Status"::Blocked); //TODO: Error: Quote Status no existe en este TestField

            // Comprobar que exista algun detalle de calendario vencido
            CLEAR(TestCraneServQForfaitCalendar);
            TestCraneServQForfaitCalendar.SETRANGE("Quote No.", "Quote no.");
            TestCraneServQForfaitCalendar.SETFILTER("Scheduled Date", '..%1', WORKDATE);
            IF TestCraneServQForfaitCalendar.ISEMPTY THEN
                IF NOT CONFIRM(Text006, FALSE, TestCraneServQForfaitCalendar.TABLECAPTION) THEN
                    ERROR(Text012);

            // Abrir pagina con los detalles de calendario con colores
            CraneServQForfaitCalendar.SETRANGE("Quote No.", "Quote no.");
            CLEAR(CraneServQuoteCalendar);
            CraneServQuoteCalendar.SETTABLEVIEW(CraneServQForfaitCalendar);
            CraneServQuoteCalendar.LOOKUPMODE(TRUE);

            IF CraneServQuoteCalendar.RUNMODAL <> ACTION::LookupOK THEN
                ERROR('');

            CraneServQuoteCalendar.SETSELECTIONFILTER(CraneServQForfaitCalendar);
            IF CraneServQForfaitCalendar.FINDSET THEN BEGIN
                REPEAT
                    // Si hay alguno ya facturado mostrar aviso
                    IF CraneServQForfaitCalendar.Processed THEN
                        IF NOT CONFIRM(Text008, FALSE) THEN
                            ERROR(Text012);

                    CheckCraneQuoteOp_ServOrderStatus(CraneServQForfaitCalendar."Quote No.", CraneServQForfaitCalendar."Quote Op. Line No.");

                    // Crear la cabecera o buscarla si ya hay una para facturacion agrupada
                    IF CreatedInvoiceNo <> '' THEN
                        NewServiceHeader.GET(NewServiceHeader."Document Type"::Invoice, CreatedInvoiceNo)
                    ELSE BEGIN
                        CLEAR(NewServiceHeader);
                        NewServiceHeader.VALIDATE("Document Type", NewServiceHeader."Document Type"::Invoice);
                        NewServiceHeader.INSERT(TRUE);
                        NewServiceHeader.VALIDATE("Customer No.", CraneServiceQuoteHeader."Customer No.");
                        NewServiceHeader.VALIDATE("Ship-to Code", CraneServiceQuoteHeader."Ship-to Code");
                        NewServiceHeader.VALIDATE("Posting Date", WORKDATE);
                        NewServiceHeader."Crane Service Quote No." := CraneServiceQuoteHeader."Quote no.";
                        NewServiceHeader."Customer Order No." := CraneServiceQuoteHeader."Customer No."; // RQ19.23.633 - DPGARCIA - Llevar el Nº Ped. Cliente

                        NewServiceHeader.MODIFY(TRUE);
                        CreatedInvoiceNo := NewServiceHeader."No.";
                        //Generar la linea de referencia a oferta.
                        AddServInvoiceLine(CreatedInvoiceNo, ServLineType::" ", '', STRSUBSTNO(Text010, CraneServQForfaitCalendar."Quote No."), 0, '', 0, '', 0, 0);
                    END;

                    CraneServQForfaitCalendar.CALCFIELDS("Operation Description");
                    // Marcar como procesado
                    AddServInvoiceLine(CreatedInvoiceNo,
                                       ServLineType::"G/L Account",
                                       CraneMgtSetup."Crane Invoice Account No",
                                       CraneServQForfaitCalendar."Operation Description",
                                       1,
                                       '',
                                       CraneServQForfaitCalendar.Amount,
                                       CraneServQForfaitCalendar."Quote No.",
                                       CraneServQForfaitCalendar."Quote Op. Line No.",
                                       CraneServQForfaitCalendar."Line No.");
                    CraneServQForfaitCalendar.Processed := TRUE;
                    CraneServQForfaitCalendar."Invoice No." := CreatedInvoiceNo;
                    CraneServQForfaitCalendar.MODIFY;
                UNTIL CraneServQForfaitCalendar.NEXT = 0;
                COMMIT;
                //Si hay lineas de "adicionales" no ligadas a grupos de facturacion...
                IF ExistQuoteMisSLineToInv(CraneServiceQuoteHeader."Quote no.") THEN BEGIN
                    // Abrir pagina con los detalles de calendario con colores
                    CLEAR(CraneServQOpMicSLine);
                    CraneServQOpMicSLine.SETRANGE("Quote No.", "Quote no.");
                    CraneServQOpMicSLine.SETRANGE("Included in Forfait", FALSE);

                    CLEAR(CraneServQOpMicSLLUp);
                    CraneServQOpMicSLLUp.SETTABLEVIEW(CraneServQOpMicSLine);
                    CraneServQOpMicSLLUp.LOOKUPMODE(TRUE);

                    IF CraneServQOpMicSLLUp.RUNMODAL = ACTION::LookupOK THEN BEGIN

                        CraneServQOpMicSLLUp.SETSELECTIONFILTER(CraneServQOpMicSLine);
                        IF CraneServQOpMicSLine.FINDSET THEN BEGIN
                            REPEAT
                                Concept.GET(CraneServQOpMicSLine."Concept Code");
                                AddServInvoiceLine(CreatedInvoiceNo,
                                                    ServLineType::"G/L Account",
                                                    Concept."Account No.",
                                                    CraneServQOpMicSLine.Description,
                                                    CraneServQOpMicSLine.Quantity,
                                                    '',
                                                    CraneServQOpMicSLine."Unit Price",
                                                    CraneServQOpMicSLine."Quote No.",
                                                    CraneServQOpMicSLine."Operation Line No.",
                                                    0);

                            UNTIL CraneServQOpMicSLine.NEXT = 0;
                        END;
                    END;
                END;
            END;

            MESSAGE(Text009, CreatedInvoiceNo);
        END;
        */
    end;

    /// <summary>
    /// AddServInvoiceLine()
    /// </summary>
    local procedure AddServInvoiceLine(pServHeader: Code[20]; pType: Option; pNo: Code[20]; pDescription: Text[50]; pQty: Decimal; pUOM: Code[10]; pUnitPrice: Decimal; pQuoteNo: Code[20]; pQuoteOpLineNo: Integer; pQuoteLineNo: Integer)
    var
        ServLine: Record "Service Line";
        LastLineNo: Integer;
        ServHeader: Record "Service Header";
        ServItemLine: Record "Service Item Line";
        LastServItemLineNo: Integer;
    begin
        ServHeader.GET(ServHeader."Document Type"::Invoice, pServHeader);

        CLEAR(ServLine);
        ServLine.SETRANGE("Document Type", ServHeader."Document Type");
        ServLine.SETRANGE("Document No.", ServHeader."No.");
        IF ServLine.FINDLAST THEN
            LastLineNo := ServLine."Line No."
        ELSE
            LastLineNo := 0;

        CLEAR(ServLine);
        ServLine.VALIDATE("Document Type", ServHeader."Document Type");
        ServLine.VALIDATE("Document No.", ServHeader."No.");
        ServLine."Line No." := LastLineNo + 10000;
        ServLine.INSERT(TRUE);
        ServLine."Customer No." := ServHeader."Customer No.";
        ServLine.Type := pType;
        ServLine.VALIDATE("No.", pNo);
        IF pQty > 0 THEN
            ServLine.VALIDATE(Quantity, pQty);
        IF pUnitPrice > 0 THEN
            ServLine.VALIDATE("Unit Price", pUnitPrice);

        ServLine.Description := pDescription;
        ServLine."Crane Quote No._LDR" := pQuoteNo;
        ServLine."Crane Quote Op. Line No._LDR" := pQuoteOpLineNo;
        ServLine."Crane Quote Line No._LDR" := pQuoteLineNo;

        ServLine.MODIFY(TRUE);
    end;

    /// <summary>
    /// CheckCraneQuoteOp_ServOrderStatus()
    /// </summary>
    local procedure CheckCraneQuoteOp_ServOrderStatus(pQuoteNo: Code[20]; pQuoteOpLineNo: Integer)
    var
        TestServiceHeader: Record "Service Header";
        TestServiceItemLine: Record "Service Item Line";
        PostedServHeader: Record "Posted Service Header_LDR";
    begin
        /*

        // Comprobar que la oferta tenga pedido de servicio con todas las lineas con estado "A FACTURAR"

        CraneMgtSetup.GET;

        CLEAR(TestServiceHeader);
        TestServiceHeader.SETRANGE("Document Type", TestServiceHeader."Document Type"::Order);
        TestServiceHeader.SETRANGE("Crane Service Quote No.", pQuoteNo);
        TestServiceHeader.SETRANGE("Crane Serv. Quote Op. Line No", pQuoteOpLineNo);
        IF TestServiceHeader.FINDSET THEN BEGIN
            REPEAT
                CLEAR(TestServiceItemLine);
                TestServiceItemLine.SETRANGE("Document Type", TestServiceHeader."Document Type");
                TestServiceItemLine.SETRANGE("Document No.", TestServiceHeader."No.");
                TestServiceItemLine.SETFILTER("Repair Status Code", '<>%1', CraneMgtSetup."Ready to Invoice Repair Status");
                IF TestServiceItemLine.FINDFIRST THEN
                    IF NOT CONFIRM(Text011, FALSE, TestServiceItemLine."Document No.", TestServiceItemLine.FIELDCAPTION("Repair Status Code"), CraneMgtSetup."Ready to Invoice Repair Status") THEN
                        ERROR(Text012);
            UNTIL TestServiceHeader.NEXT = 0;
        END ELSE BEGIN
            CLEAR(PostedServHeader);
            PostedServHeader.SETRANGE("Crane Service Quote No.", pQuoteNo);
            IF NOT PostedServHeader.FINDFIRST THEN BEGIN
                // Mostrar mensaje de confirmacion al usuario
                IF NOT CONFIRM(Text007, FALSE) THEN
                    ERROR(Text012);
            END;
        END;
        */
    end;

    /// <summary>
    /// ExistQuoteMisSLineToInv()
    /// </summary>
    local procedure ExistQuoteMisSLineToInv(pQuoteNo: Code[20]): BoolEAN
    var
        CraneServQOpMicSLine: Record "Crane Serv Q Op Mic S Line_LDR";
        CraneServQOpInvGLine: Record "Crane Serv Q Op Inv G Line_LDR";
    begin
        CLEAR(CraneServQOpMicSLine);
        CraneServQOpMicSLine.SETRANGE("Quote No.", pQuoteNo);
        IF CraneServQOpMicSLine.FINDSET THEN BEGIN
            REPEAT
                CLEAR(CraneServQOpInvGLine);
                CraneServQOpInvGLine.SETRANGE("Quote No.", pQuoteNo);
                CraneServQOpInvGLine.SETRANGE("Misc. S Line Line No.", CraneServQOpMicSLine."Line No.");
                IF NOT CraneServQOpInvGLine.FINDSET THEN
                    EXIT(TRUE);
            UNTIL CraneServQOpMicSLine.NEXT = 0;
        END;

        EXIT(FALSE);
    end;

    /// <summary>
    /// UpdateDocNoForfaitCalendar()
    /// </summary>
    procedure UpdateDocNoForfaitCalendar(DocNo: Code[20]; PostedDocNo: Code[20])
    var
        CraneServQForfaitCalendar: Record "Crane Serv Q. Forf Calend_LDR";
    begin
        CLEAR(CraneServQForfaitCalendar);
        CraneServQForfaitCalendar.SETRANGE(CraneServQForfaitCalendar."Invoice No.", DocNo);
        IF CraneServQForfaitCalendar.FINDSET THEN BEGIN
            REPEAT
                CraneServQForfaitCalendar."Invoice No." := PostedDocNo;
                CraneServQForfaitCalendar.MODIFY;
            UNTIL CraneServQForfaitCalendar.NEXT = 0;
        END;
    end;

    /// <summary>
    /// ForfaitDistribution()
    /// </summary>
    procedure ForfaitDistribution(var CraneServiceQuoteHeader: Record "Crane Service Quote Header_LDR")
    var
        CraneServQOpInvGLine: Record "Crane Serv Q Op Inv G Line_LDR";
        TotalForfaitAmount: Decimal;
        WorkAmount: Decimal;
        DisplacementAmount: Decimal;
        ServiceItemRateLineCrane: Record "Servic Item Rat Li - Crane_LDR";
        Branch: Record "Branch_LDR";
        Customer: Record "Customer";
        CraneServQOpMicSLine: Record "Crane Serv Q Op Mic S Line_LDR";
        TotalNoVehicles: Integer;
        ServiceItemLine: Record "Service Item Line";
        PostedServiceItemLine: Record "Posted Service Item Line_LDR";
        CalculatedAmount: Decimal;
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        ServiceItem: Record "Service Item";
        KMvalue: Integer;
        LineType: Option Credit,Debit;
        DestPostCode: Code[20];
        DestCity: Code[30];
        DurationValue: Decimal;
    begin
        /*
        CraneMgtSetup.GET;
        CraneMgtSetup.TESTFIELD("Forfait Calc. Source Branch");

        IF NOT CONFIRM(Text017, FALSE) THEN
            ERROR(Text012);

        CheckReadyToDistribute(CraneServiceQuoteHeader);

        // Calcular el importe total estimado a facturar y Nº vehiculos reales
        CLEAR(CraneServQOpInvGLine);
        CraneServQOpInvGLine.SETRANGE("Quote No.", CraneServiceQuoteHeader."Quote no.");
        IF CraneServQOpInvGLine.FINDSET THEN
            REPEAT
                CLEAR(TotalNoVehicles);
                CLEAR(TotalForfaitAmount);

                IF CraneServQOpInvGLine."Misc. S Line Line No." = 0 THEN BEGIN
                    CLEAR(WorkAmount);
                    WorkAmount := (CraneServQOpInvGLine."Vehicles Number" * CraneServQOpInvGLine."Maximum Hours" * CraneServQOpInvGLine."Hour Price");

                    CLEAR(DisplacementAmount);
                    IF CraneServQOpInvGLine."Apply standard KM" THEN BEGIN
                        CLEAR(ServiceItemRateLineCrane);
                        ServiceItemRateLineCrane.SETRANGE(Code, CraneServQOpInvGLine."Rate No.");
                        ServiceItemRateLineCrane.SETRANGE("Invoice Group No.", CraneServQOpInvGLine."Invoice Group No.");
                        ServiceItemRateLineCrane.FINDFIRST;

                        Branch.GET(CraneMgtSetup."Forfait Calc. Source Branch");
                        GetDestPostCodeCity(CraneServiceQuoteHeader, DestPostCode, DestCity);
                        // RQ19.29.058 - DPGARCIA - Diferenciar calculo si el Tipo Desplazamiento es KMs o Horas
                        IF CraneServQOpInvGLine."Displacement Type" = CraneServQOpInvGLine."Displacement Type"::KMs THEN BEGIN
                            KMvalue := GetKMValue(Branch."Post Code", Branch.City, DestPostCode, DestCity);
                            DisplacementAmount := (CraneServQOpInvGLine."Vehicles Number" * ServiceItemRateLineCrane."KM Price" * KMvalue);
                        END ELSE
                            IF CraneServQOpInvGLine."Displacement Type" = CraneServQOpInvGLine."Displacement Type"::Hours THEN BEGIN
                                DurationValue := GetDurationValue(Branch."Post Code", Branch.City, DestPostCode, DestCity);
                                DisplacementAmount := (CraneServQOpInvGLine."Vehicles Number" * ServiceItemRateLineCrane."Hour Price" * DurationValue);
                            END;

                    END ELSE BEGIN
                        CLEAR(ServiceItemRateLineCrane);
                        ServiceItemRateLineCrane.SETRANGE(Code, CraneServQOpInvGLine."Rate No.");
                        ServiceItemRateLineCrane.SETRANGE("Invoice Group No.", CraneServQOpInvGLine."Invoice Group No.");
                        ServiceItemRateLineCrane.FINDFIRST;

                        //DisplacementAmount := (CraneServQOpInvGLine."Vehicles Number" * ServiceItemRateLineCrane."KM Price" * CraneServQOpInvGLine."KM-Time Qty.");
                        DisplacementAmount := (CraneServQOpInvGLine."Vehicles Number" * CraneServQOpInvGLine."Displacement Amount");

                    END;

                    TotalForfaitAmount += (WorkAmount + DisplacementAmount);

                END ELSE BEGIN
                    CLEAR(CraneServQOpMicSLine);
                    CraneServQOpMicSLine.SETRANGE("Quote No.", CraneServiceQuoteHeader."Quote no.");
                    CraneServQOpMicSLine.SETRANGE("Operation Line No.", CraneServQOpInvGLine."Operation Line No.");
                    CraneServQOpMicSLine.SETRANGE("Line No.", CraneServQOpInvGLine."Line No.");
                    CraneServQOpMicSLine.FINDFIRST;

                    TotalForfaitAmount += (CraneServQOpInvGLine."Vehicles Number" * CraneServQOpMicSLine."Unit Price");
                END;

                CLEAR(ServiceItemLine);
                ServiceItemLine.SETRANGE("Crane Service Quote No.", CraneServQOpInvGLine."Quote No.");
                ServiceItemLine.SETRANGE("Crane Serv. Quote Op. Line No", CraneServQOpInvGLine."Operation Line No.");
                ServiceItemLine.SETRANGE("Service Inv. Group No.", CraneServQOpInvGLine."Invoice Group No.");
                TotalNoVehicles += ServiceItemLine.COUNT;

                CLEAR(PostedServiceItemLine);
                PostedServiceItemLine.SETRANGE("Crane Service Quote No.", CraneServQOpInvGLine."Quote No.");
                PostedServiceItemLine.SETRANGE("Crane Serv. Quote Op. Line No", CraneServQOpInvGLine."Operation Line No.");
                PostedServiceItemLine.SETRANGE("Service Inv. Group No.", CraneServQOpInvGLine."Invoice Group No.");
                TotalNoVehicles += PostedServiceItemLine.COUNT;

                // una vez calculado el importe total estimado a facturar y calculado el Nº Vehiculos Reales
                // recorrer cada uno de los registros vinculados de las TB 5901 y 7122048 y para cada uno de ellos, generar una serie de lineas de diario general
                IF TotalNoVehicles > 0 THEN BEGIN
                    CLEAR(CalculatedAmount);
                    CalculatedAmount := TotalForfaitAmount / TotalNoVehicles;

                    CLEAR(ServiceItemLine);
                    ServiceItemLine.SETRANGE("Crane Service Quote No.", CraneServQOpInvGLine."Quote No.");
                    ServiceItemLine.SETRANGE("Crane Serv. Quote Op. Line No", CraneServQOpInvGLine."Operation Line No.");
                    ServiceItemLine.SETRANGE("Service Inv. Group No.", CraneServQOpInvGLine."Invoice Group No.");
                    IF ServiceItemLine.FINDSET THEN
                        REPEAT
                            ServiceItem.GET(ServiceItemLine."Service Item No.");
                            CreateForfaitGenJnlLine(LineType::Debit, '', CalculatedAmount, ServiceItem, ServiceItemLine, PostedServiceItemLine, FALSE, CraneServiceQuoteHeader."Quote no.");
                            ServiceItemLine.CALCFIELDS("Service Inv. Group Description");
                            CreateForfaitGenJnlLine(LineType::Credit, STRSUBSTNO('%1 - %2', ServiceItemLine."Document No.", ServiceItemLine."Service Inv. Group Description"),
                                                    CalculatedAmount, ServiceItem, ServiceItemLine, PostedServiceItemLine, FALSE, CraneServiceQuoteHeader."Quote no.");
                        UNTIL ServiceItemLine.NEXT = 0;

                    CLEAR(PostedServiceItemLine);
                    PostedServiceItemLine.SETRANGE("Crane Service Quote No.", CraneServQOpInvGLine."Quote No.");
                    PostedServiceItemLine.SETRANGE("Crane Serv. Quote Op. Line No", CraneServQOpInvGLine."Operation Line No.");
                    PostedServiceItemLine.SETRANGE("Service Inv. Group No.", CraneServQOpInvGLine."Invoice Group No.");
                    IF PostedServiceItemLine.FINDSET THEN
                        REPEAT
                            ServiceItem.GET(PostedServiceItemLine."Service Item No.");
                            CreateForfaitGenJnlLine(LineType::Debit, '', CalculatedAmount, ServiceItem, ServiceItemLine, PostedServiceItemLine, TRUE, CraneServiceQuoteHeader."Quote no.");
                            PostedServiceItemLine.CALCFIELDS("Service Inv. Group Description");
                            CreateForfaitGenJnlLine(LineType::Credit, STRSUBSTNO('%1 - %2', PostedServiceItemLine."No.", PostedServiceItemLine."Service Inv. Group Description"),
                                                    CalculatedAmount, ServiceItem, ServiceItemLine, PostedServiceItemLine, TRUE, CraneServiceQuoteHeader."Quote no.");
                        UNTIL PostedServiceItemLine.NEXT = 0;
                END;
            UNTIL CraneServQOpInvGLine.NEXT = 0;

        CraneServiceQuoteHeader.Historical := TRUE;
        CraneServiceQuoteHeader."Forfait Distributed" := TRUE;
        CraneServiceQuoteHeader.MODIFY;

        MESSAGE(Text018, CraneServiceQuoteHeader."Quote no.");
        */
    end;

    /// <summary>
    /// CheckReadyToDistribute()
    /// </summary>
    local procedure CheckReadyToDistribute(pCraneServiceQuoteHeader: Record "Crane Service Quote Header_LDR")
    var
        CraneServQForfaitCalendar: Record "Crane Serv Q. Forf Calend_LDR";
        CraneServiceQuoteOpLine: Record "Crane Servic Quote Op. Lin_LDR";
        ServItemLine: Record "Service Item Line";
        PostedServItemLine: Record "Posted Service Item Line_LDR";
        ServHeader: Record "Service Header";
    begin
        /*
        //Verificamos que todos los registros de calendario hayan sido procesados
        CLEAR(CraneServQForfaitCalendar);
        CraneServQForfaitCalendar.SETRANGE("Quote No.", pCraneServiceQuoteHeader."Quote no.");
        CraneServQForfaitCalendar.SETRANGE(Processed, FALSE);
        IF NOT CraneServQForfaitCalendar.ISEMPTY THEN
            ERROR(Text016, pCraneServiceQuoteHeader."Quote no.");

        //Verificamos que los documentos asociados en calendario NO sEAN prefacturas
        CLEAR(CraneServQForfaitCalendar);
        CraneServQForfaitCalendar.SETRANGE("Quote No.", pCraneServiceQuoteHeader."Quote no.");
        IF CraneServQForfaitCalendar.FINDSET THEN BEGIN
            REPEAT
                IF ServHeader.GET(ServHeader."Document Type"::Invoice, CraneServQForfaitCalendar."Invoice No.") THEN
                    ERROR(Text019, CraneServQForfaitCalendar."Invoice No.");
            UNTIL CraneServQForfaitCalendar.NEXT = 0;
        END;

        //Verificamos que las lineas de operacion tengan al menos 1 pedido de servicio.
        CLEAR(CraneServiceQuoteOpLine);
        CraneServiceQuoteOpLine.SETRANGE("Quote No.", pCraneServiceQuoteHeader."Quote no.");
        IF CraneServiceQuoteOpLine.FINDSET THEN BEGIN
            REPEAT
                CLEAR(ServItemLine);
                ServItemLine.SETRANGE("Document Type", ServItemLine."Document Type"::Order);
                ServItemLine.SETRANGE("Crane Service Quote No.", CraneServiceQuoteOpLine."Quote No.");
                ServItemLine.SETRANGE("Crane Serv. Quote Op. Line No", CraneServiceQuoteOpLine."Line No.");

                CLEAR(PostedServItemLine);
                PostedServItemLine.SETRANGE("Crane Service Quote No.", CraneServiceQuoteOpLine."Quote No.");
                PostedServItemLine.SETRANGE("Crane Serv. Quote Op. Line No", CraneServiceQuoteOpLine."Line No.");

                CraneServiceQuoteOpLine.CALCFIELDS("Forfait Amount");
                IF (ServItemLine.ISEMPTY) AND (PostedServItemLine.ISEMPTY) THEN
                    IF NOT CONFIRM(Text020, FALSE, CraneServiceQuoteOpLine."Operation No.", CraneServiceQuoteOpLine."Operation Description", CraneServiceQuoteOpLine."Forfait Amount") THEN
                        ERROR(Text012);
            UNTIL CraneServiceQuoteOpLine.NEXT = 0;
        END;
        */
    end;

    /// <summary>
    /// GetDestPostCodeCity()
    /// </summary>
    local procedure GetDestPostCodeCity(pCraneQuoteHeader: Record "Crane Service Quote Header_LDR"; var vPostCode: Code[20]; var vCity: Code[30])
    var
        Customer: Record "Customer";
        ShiptoAddress: Record "Ship-to Address";
    begin

        IF pCraneQuoteHeader."Ship-to Address Code" = '' THEN BEGIN
            Customer.GET(pCraneQuoteHeader."Customer No.");
            vPostCode := Customer."Post Code";
            vCity := Customer.City;
        END ELSE BEGIN
            ShiptoAddress.GET(pCraneQuoteHeader."Customer No.", pCraneQuoteHeader."Ship-to Address Code");
            vPostCode := ShiptoAddress."Post Code";
            vCity := ShiptoAddress.City;
        END;
    end;

    /// <summary>
    /// GetKMValue()
    /// </summary>
    local procedure GetKMValue(pFromCP: Code[20]; pFromCity: Code[30]; pToCP: Code[20]; pToCity: Code[30]): Decimal
    var
        KMDistance: Record "Kilometric distance_LDR";
        CalcQty: Decimal;
    begin
        CLEAR(KMDistance);
        KMDistance.SETRANGE("From City", pFromCity);
        KMDistance.SETRANGE("From Post Code", pFromCP);
        KMDistance.SETRANGE("To City", pToCity);
        KMDistance.SETRANGE("To Post Code", pToCP);
        IF NOT KMDistance.FINDFIRST THEN BEGIN
            CLEAR(KMDistance);
            KMDistance.SETRANGE("From City", pToCity);
            KMDistance.SETRANGE("From Post Code", pToCP);
            KMDistance.SETRANGE("To City", pFromCity);
            KMDistance.SETRANGE("To Post Code", pFromCP);
            IF NOT KMDistance.FINDFIRST THEN BEGIN
                EXIT(0);
            END ELSE BEGIN
                CalcQty := KMDistance."Distance (Km)";
            END;
        END ELSE BEGIN
            CalcQty := KMDistance."Distance (Km)";
        END;

        EXIT(CalcQty);
    end;

    /// <summary>
    /// CreateForfaitGenJnlLine()
    /// </summary>
    local procedure CreateForfaitGenJnlLine(pLineType: Option Credit,Debit; pDescription: Text; pAmount: Decimal; pServItem: Record "Service Item"; pServItemLine: Record "Service Item Line"; pPostedServItemLine: Record "Posted Service Item Line_LDR"; bPosted: BoolEAN; pQuoteNo: Code[20])
    var
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        DimMgt: Codeunit "DimensionManagement";
    begin
        CraneMgtSetup.GET;
        CraneMgtSetup.TESTFIELD("Forfait Gen. Journal Template");
        CraneMgtSetup.TESTFIELD("Forfait Gen. Journal Batch");

        CLEAR(GenJournalLine);
        GenJournalLine.SETRANGE("Journal Template Name", CraneMgtSetup."Forfait Gen. Journal Template");
        GenJournalLine.SETRANGE("Journal Batch Name", CraneMgtSetup."Forfait Gen. Journal Batch");
        IF GenJournalLine.FINDLAST THEN
            LineNo := GenJournalLine."Line No." + 10000
        ELSE
            LineNo := 10000;

        CLEAR(GenJournalLine);
        GenJournalLine.INIT;
        GenJournalLine."Journal Template Name" := CraneMgtSetup."Forfait Gen. Journal Template";
        GenJournalLine."Journal Batch Name" := CraneMgtSetup."Forfait Gen. Journal Batch";
        GenJournalLine."Line No." := LineNo;

        GenJournalLine.VALIDATE("Account Type", GenJournalLine."Account Type"::"G/L Account");
        GenJournalLine.VALIDATE("Account No.", CraneMgtSetup."Crane Invoice Account No");
        GenJournalLine."Posting Date" := WORKDATE;
        GenJournalLine.VALIDATE("Document Type", GenJournalLine."Document Type"::"Finance Charge Memo");
        IF pLineType = pLineType::Debit THEN
            GenJournalLine.VALIDATE("Debit Amount", pAmount)
        ELSE
            IF pLineType = pLineType::Credit THEN BEGIN
                GenJournalLine.VALIDATE("Credit Amount", pAmount);
                GenJournalLine.CreateDim(DATABASE::"Service Item", pServItem."No.", 0, '', 0, '', 0, '', 0, '');
            END;
        GenJournalLine.Description := pDescription;
        GenJournalLine."Document No." := pQuoteNo;
        GenJournalLine.INSERT(TRUE);
    end;

    /// <summary>
    /// UpdateDisplacementAmount()
    /// </summary>
    [EventSubscriber(ObjectType::Table, 50025, 'OnAfterValidateEvent', 'KM-Time Qty.', false, false)]
    local procedure UpdateDisplacementAmount(var Rec: Record "Crane Serv Q Op Inv G Line_LDR"; var xRec: Record "Crane Serv Q Op Inv G Line_LDR"; CurrFieldNo: Integer)
    var
        ServItemRateLineCrane: Record "Servic Item Rat Li - Crane_LDR";
    begin

        IF Rec."Displacement Amount" <> 0 THEN
            IF NOT CONFIRM(Text021, FALSE) THEN
                ERROR(Text012);

        IF ServItemRateLineCrane.GET(Rec."Rate No.", Rec."Invoice Group No.") THEN BEGIN

            IF Rec."Displacement Type" = Rec."Displacement Type"::Hours THEN
                Rec."Displacement Amount" := Rec."KM-Time Qty." * ServItemRateLineCrane."Hour Price"
            ELSE
                Rec."Displacement Amount" := Rec."KM-Time Qty." * ServItemRateLineCrane."KM Price";
        END;
    end;

    /// <summary>
    /// GetDurationValue()
    /// </summary>
    local procedure GetDurationValue(pFromCP: Code[20]; pFromCity: Code[30]; pToCP: Code[20]; pToCity: Code[30]): Decimal
    var
        KMDistance: Record "Kilometric distance_LDR";
        CalcQty: Decimal;
    begin
        CLEAR(KMDistance);
        KMDistance.SETRANGE("From City", pFromCity);
        KMDistance.SETRANGE("From Post Code", pFromCP);
        KMDistance.SETRANGE("To City", pToCity);
        KMDistance.SETRANGE("To Post Code", pToCP);
        IF NOT KMDistance.FINDFIRST THEN BEGIN
            CLEAR(KMDistance);
            KMDistance.SETRANGE("From City", pToCity);
            KMDistance.SETRANGE("From Post Code", pToCP);
            KMDistance.SETRANGE("To City", pFromCity);
            KMDistance.SETRANGE("To Post Code", pFromCP);
            IF NOT KMDistance.FINDFIRST THEN BEGIN
                EXIT(0);
            END ELSE BEGIN
                CalcQty := KMDistance.Duration;
            END;
        END ELSE BEGIN
            CalcQty := KMDistance.Duration;
        END;

        EXIT(CalcQty);
    end;
}