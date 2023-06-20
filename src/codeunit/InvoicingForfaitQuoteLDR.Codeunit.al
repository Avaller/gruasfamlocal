/// <summary>
/// Codeunit Invoicing Forfait Quote_LDR (ID 50011)
/// </summary>
codeunit 50011 "Invoicing Forfait Quote_LDR"
{
    TableNo = "Crane Service Quote Header_LDR";
    /*
    trigger OnRun()
    begin
        InvoiceForfaitQuote(Rec);
    end;

    var
        Text0001: Label 'Quote dont have %1 overdued\ Continue?';
        Text0002: Label 'There are no service requests associated with the Crane Quote\ Continue?';
        Text0003: Label 'Detail has already been invoiced. \ Continue?';
        InvoiceNo: Code[20];
        CreatedInvoiceNo: Code[20];

    /// <summary>
    /// InvoiceForfaitQuote()
    /// </summary>
    local procedure InvoiceForfaitQuote(CraneServiceQuoteHeader: Record "Crane Service Quote Header_LDR")
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
    begin
        CraneMgtSetup.GET;
        CraneMgtSetup.TESTFIELD("Crane Invoice Account No");
        WITH CraneServiceQuoteHeader DO BEGIN
            TESTFIELD("Quote Type", "Quote Type"::Forfait);
            TESTFIELD("Quote Status", "Quote Status"::Blocked);
            // Comprobar que la oferta tenga pedido de servicio con todas las lineas con estado "A FACTURAR"
            CLEAR(TestServiceHeader);
            CLEAR(TestServiceItemLine);
            TestServiceHeader.SETRANGE("Crane Service Quote No.", "Quote no.");
            IF TestServiceHeader.FINDFIRST THEN BEGIN
                TestServiceItemLine.SETRANGE("Document Type", TestServiceHeader."Document Type");
                TestServiceItemLine.SETRANGE("Document No.", TestServiceHeader."No.");
                TestServiceItemLine.FINDSET;
                REPEAT
                    // Comporbar que todas las lineas tengan estado a facturar
                    TestServiceItemLine.TESTFIELD(TestServiceItemLine."Repair Status Code", CraneMgtSetup."Ready to Invoice Repair Status");
                    // Comprobar que exista algun detalle de calendario vencido
                    TestCraneServQForfaitCalendar.SETRANGE("Quote No.", "Quote no.");
                    TestCraneServQForfaitCalendar.SETFILTER("Scheduled Date", '..%1', WORKDATE);
                    IF TestCraneServQForfaitCalendar.ISEMPTY THEN
                        IF NOT CONFIRM(Text0001, FALSE, TestCraneServQForfaitCalendar.TABLECAPTION) THEN
                            ERROR('');

                UNTIL TestServiceItemLine.NEXT = 0;
            END ELSE BEGIN
                // Mostrar mensaje de confirmacion al usuario
                IF NOT CONFIRM(Text0002, FALSE) THEN
                    ERROR('');
            END;
            // Abrir pagina con los detalles de calendario con colores
            CraneServQForfaitCalendar.SETRANGE("Quote No.", "Quote no.");
            CLEAR(CraneServQuoteCalendar);
            CraneServQuoteCalendar.SETTABLEVIEW(CraneServQForfaitCalendar);
            CraneServQuoteCalendar.RUNMODAL;
            CraneServQuoteCalendar.SETSELECTIONFILTER(CraneServQForfaitCalendar);
            CraneServQForfaitCalendar.FINDSET;
            REPEAT
                // Si hay alguno ya facturado mostrar aviso
                IF CraneServQForfaitCalendar.Processed THEN
                    IF NOT CONFIRM(Text0003, FALSE) THEN
                        ERROR('');
            UNTIL CraneServQForfaitCalendar.NEXT = 0;

            // Crear la factura
            IF NOT CraneServQForfaitCalendar.ISEMPTY THEN BEGIN
                CraneServQForfaitCalendar.FINDSET;
                // Crear la cabecera o buscarla si ya hay una para facturacion agrupada
                IF InvoiceNo <> '' THEN
                    NewServiceHeader.GET(NewServiceHeader."Document Type"::Invoice, InvoiceNo)
                ELSE BEGIN
                    CLEAR(NewServiceHeader);
                    NewServiceHeader.VALIDATE("Document Type", NewServiceHeader."Document Type"::Invoice);
                    NewServiceHeader.INSERT(TRUE);
                    NewServiceHeader.VALIDATE("Customer No.", CraneServiceQuoteHeader."Customer No.");
                    NewServiceHeader.VALIDATE("Ship-to Code", CraneServiceQuoteHeader."Ship-to Address Code");
                    NewServiceHeader.VALIDATE("Posting Date", WORKDATE);

                    NewServiceHeader.MODIFY(TRUE);
                    CreatedInvoiceNo := NewServiceHeader."No.";
                END;
                // Generar las lineas
                REPEAT
                    CLEAR(NewServiceLine);
                    NewServiceLine.VALIDATE("Document Type", NewServiceHeader."Document Type");
                    NewServiceLine.VALIDATE("Document No.", NewServiceHeader."No.");
                    NewServiceLine."Line No." := LineNo + 10000;
                    LineNo += 10000;
                    NewServiceLine.INSERT;
                    NewServiceLine."Customer No." := NewServiceHeader."Customer No.";
                    NewServiceLine.Type := NewServiceLine.Type::"G/L Account";
                    NewServiceLine.VALIDATE("No.", CraneMgtSetup."Crane Invoice Account No");
                    NewServiceLine.VALIDATE(Quantity, 1);
                    NewServiceLine.VALIDATE(Amount, CraneServQForfaitCalendar.Amount);
                    NewServiceLine.Description := CraneServQForfaitCalendar."Operation Description";
                    NewServiceLine."Crane Quote No." := CraneServQForfaitCalendar."Quote No.";
                    NewServiceLine."Crane Quote Op. Line No." := CraneServQForfaitCalendar."Quote Op. Line No.";
                    NewServiceLine."Crane Quote Line No." := CraneServQForfaitCalendar."Line No.";

                    NewServiceLine.MODIFY;
                    // Marcar como procesado
                    CraneServQForfaitCalendar.Processed := TRUE;
                    CraneServQForfaitCalendar.MODIFY;
                UNTIL CraneServQForfaitCalendar.NEXT = 0;
            END;

        END;
    end;

    /// <summary>
    /// SetInvoiceNo()
    /// </summary>
    procedure SetInvoiceNo(InvoiceNoParam: Code[20])
    begin
        InvoiceNo := InvoiceNoParam;
    end;

    /// <summary>
    /// GetInvoiceNo()
    /// </summary>
    procedure GetInvoiceNo(): Code[20]
    begin
        EXIT(CreatedInvoiceNo);
    end;
    */
}