/// <summary>
/// Codeunit PDF Mail_LDR (ID 50210)
/// </summary>
codeunit 50210 "PDF Mail_LDR"
{
    // UPG2016 21/01/2016 1CF_MGF FileManagement funtionality reimplemented
    // UPG2016 20160121 1CF_SVD CREATE Automation function reimplemented
    // UPG2016 20160121 1CF_RPB Use new PDF functionality
    // UPG2016 2016-01-22 1CF_MBE Upgrade to NAV2016
    //                       Changes with files reimplemented
    // 
    // RQ18.0719 - Incluir resumen de partes de trabajo en el envio de facturas por email

    Permissions = TableData "Sales Invoice Header" = rm;
    TableNo = "Job Queue Entry";

    /*
    trigger OnRun()
    var
        SalesInvoice: Record "Sales Invoice Header";
        SalesCrMemo: Record "Sales Cr.Memo Header";
        ServiceInvoice: Record "Service Invoice Header";
        ServiceCrMemo: Record "Service Cr.Memo Header";
    begin
        GLOBALLANGUAGE(1034); // CIC

        PDFSetup.GET;

        IF PDFSetup."Process Sales Invoices" THEN BEGIN
            CLEAR(SalesInvoice);
            SalesInvoice.SETRANGE(SalesInvoice."Send Document By Mail", TRUE);
            SalesInvoice.SETFILTER(SalesInvoice."Mail Status", '<>%1', SalesInvoice."Mail Status"::Sended);
            IF FORMAT(PDFSetup."Email Sending Delay") <> '' THEN
                SalesInvoice.SETFILTER(SalesInvoice."Posting Date", '<=%1', (CALCDATE(PDFSetup."Email Sending Delay", TODAY)));
            IF SalesInvoice.FINDSET THEN BEGIN
                REPEAT
                    SalesInvoice.TESTFIELD(SalesInvoice."E-Mail Destination");
                    CreatePDF(DATABASE::"Sales Invoice Header", SalesInvoice."No.");
                UNTIL SalesInvoice.NEXT = 0;
            END;
        END;

        IF PDFSetup."Process Sales Cr. Memos" THEN BEGIN
            CLEAR(SalesCrMemo);
            SalesCrMemo.SETRANGE(SalesCrMemo."Send Document By Mail", TRUE);
            SalesCrMemo.SETFILTER(SalesCrMemo."Mail Status", '<>%1', SalesCrMemo."Mail Status"::Sended);
            IF FORMAT(PDFSetup."Email Sending Delay") <> '' THEN
                SalesCrMemo.SETFILTER(SalesCrMemo."Posting Date", '<=%1', (CALCDATE(PDFSetup."Email Sending Delay", TODAY)));
            IF SalesCrMemo.FINDSET THEN BEGIN
                REPEAT
                    SalesCrMemo.TESTFIELD(SalesCrMemo."E-Mail Destination");
                    CreatePDF(DATABASE::"Sales Cr.Memo Header", SalesCrMemo."No.");
                UNTIL SalesCrMemo.NEXT = 0;
            END;
        END;

        IF PDFSetup."Process Service Invoices" THEN BEGIN
            CLEAR(ServiceInvoice);
            ServiceInvoice.SETRANGE(ServiceInvoice."Send Document By Mail", TRUE);
            ServiceInvoice.SETFILTER(ServiceInvoice."Mail Status", '<>%1', ServiceInvoice."Mail Status"::Sended);
            IF FORMAT(PDFSetup."Email Sending Delay") <> '' THEN
                ServiceInvoice.SETFILTER(ServiceInvoice."Posting Date", '<=%1', (CALCDATE(PDFSetup."Email Sending Delay", TODAY)));
            IF ServiceInvoice.FINDSET THEN BEGIN
                REPEAT
                    ServiceInvoice.TESTFIELD(ServiceInvoice."E-Mail Destination");
                    CreatePDF(DATABASE::"Service Invoice Header", ServiceInvoice."No.");
                UNTIL ServiceInvoice.NEXT = 0;
            END;
        END;

        IF PDFSetup."Process Service Cr. Memos" THEN BEGIN
            CLEAR(ServiceCrMemo);
            ServiceCrMemo.SETRANGE(ServiceCrMemo."Send Document By Mail", TRUE);
            ServiceCrMemo.SETFILTER(ServiceCrMemo."Mail Status", '<>%1', ServiceCrMemo."Mail Status"::Sended);
            IF FORMAT(PDFSetup."Email Sending Delay") <> '' THEN
                ServiceCrMemo.SETFILTER(ServiceCrMemo."Posting Date", '<=%1', (CALCDATE(PDFSetup."Email Sending Delay", TODAY)));

            IF ServiceCrMemo.FINDSET THEN BEGIN
                REPEAT
                    ServiceCrMemo.TESTFIELD(ServiceCrMemo."E-Mail Destination");
                    CreatePDF(DATABASE::"Service Cr.Memo Header", ServiceCrMemo."No.");
                UNTIL ServiceCrMemo.NEXT = 0;
            END;
        END;
    end;

    var
        SMTP: Codeunit "SMTP Mail_LDR";
        CompanyInfo: Record "Company Information";
        SalesSetup: Record "Sales & Receivables Setup";
        PDFSetup: Record "PDF Mail Report Params_LDR";
        SInvoice: Record "Sales Invoice Header";
        SCrMemo: Record "Sales Cr.Memo Header";
        ServInvoice: Record "Service Invoice Header";
        ServCrMemo: Record "Service Cr.Memo Header";
        FileMgt: Codeunit "File Management";
        TempBlob: Record 99008535 temporary; //TODO: Error: No existe la tabla 99008535
        FileManagement: Codeunit "File Management";
        TempServerFileName: Text;

    /// <summary>
    /// CreateFileName()
    /// </summary>
    procedure CreateFileName(Path: Text[1024]; DocNo: Code[20]) FIleName: Text[1024]
    begin
        FIleName := Path + CONVERTSTR(DocNo, '/\', '__') + '.pdf';
    end;

    /// <summary>
    /// CreateBody()
    /// </summary>
    procedure CreateBody() Body: Text
    var
        InStream: InStream;
        TempText: Text;
    begin
        PDFSetup.CALCFIELDS("Mail Body HTML");
        PDFSetup."Mail Body HTML".CREATEINSTREAM(InStream);
        InStream.READ(TempText);
        EXIT(TempText);
    end;

    /// <summary>
    /// UndoInvoice()
    /// </summary>
    procedure UndoInvoice(InvoiceNo: Code[20])
    var
        Invoice: Record "Sales Invoice Header";
    begin
        Invoice.GET(InvoiceNo);
        Invoice."Mail Status" := Invoice."Mail Status"::Sended;
        Invoice.MODIFY;
    end;

    /// <summary>
    /// UndoCrMemo()
    /// </summary>
    procedure UndoCrMemo(CrMemoNo: Code[20])
    var
        CrMemo: Record "Sales Cr.Memo Header";
    begin
        CrMemo.GET(CrMemoNo);
        CrMemo."Mail Status" := CrMemo."Mail Status"::Sended;
        CrMemo.MODIFY;
    end;

    /// <summary>
    /// UndoServiceInvoice()
    /// </summary>
    procedure UndoServiceInvoice(InvoiceNo: Code[20])
    var
        Invoice: Record "Service Invoice Header";
    begin
        Invoice.GET(InvoiceNo);
        Invoice."Mail Status" := Invoice."Mail Status"::Sended;
        Invoice.MODIFY;
    end;

    /// <summary>
    /// UndoServiceCrMemo()
    /// </summary>
    procedure UndoServiceCrMemo(CrMemoNo: Code[20])
    var
        CrMemo: Record "Service Cr.Memo Header";
    begin
        CrMemo.GET(CrMemoNo);
        CrMemo."Mail Status" := CrMemo."Mail Status"::Sended;
        CrMemo.MODIFY;
    end;

    /// <summary>
    /// CreatePDF()
    /// </summary>
    procedure CreatePDF(TableNo: Integer; DocNo: Code[20])
    var
        BaseFolder: Text[1024];
        PdfFilename: Text[1024];
        StatusFileName: Text[1024];
        txtErrorCreate: Label 'Error Creating %1';
        DestinationMail: Text[250];
        DestinationSubject: Text[100];
        InvoiceTemplateFileName: Text[1024];
        CrMemoTemplateFileName: Text[1024];
        ServInvoiceTemplateFileName: Text[1024];
        ServCrMemoTemplateFileName: Text[1024];
        MailBodyFileName: Text[1024];
        ServerTempFileName: Text;
        ReportSelection: Record "Report Selections";
        PdfFilename2: Text[1024];
        FullPDFfilePath: Text;
        FullPDFfilePath2: Text;
    begin
        //>> UPG2016 SVD Begin
        CompanyInfo.GET;
        PDFSetup.GET;
        PDFSetup.CALCFIELDS("PDF Sales Invoice Template", "PDF Sales Cr.Memo Template",
                                 "PDF Service Invoice Template", "PDF Service Cr.Memo Template");
        PDFSetup.TESTFIELD(PDFSetup."Temp URL");

        CLEAR(SInvoice);
        CLEAR(SCrMemo);
        CLEAR(ServInvoice);
        CLEAR(ServCrMemo);

        BaseFolder := PDFSetup."Temp URL";
        PdfFilename := CreateFileName('', DocNo);
        PdfFilename2 := CreateFileNameWorkOrder('', 'Partes_' + DocNo);
        FullPDFfilePath := BaseFolder + PdfFilename;
        FullPDFfilePath2 := BaseFolder + PdfFilename2;
        StatusFileName := BaseFolder + 'status.ini';

        InvoiceTemplateFileName := BaseFolder + 'InvoiceTemplate.pdf';
        CrMemoTemplateFileName := BaseFolder + 'CrMemoTemplate.pdf';
        ServInvoiceTemplateFileName := BaseFolder + 'ServInvoiceTemplate.pdf';
        ServCrMemoTemplateFileName := BaseFolder + 'ServCrMemoTemplate.pdf';
        MailBodyFileName := BaseFolder + 'Body.html';

        CLEAR(ReportSelection);

        CASE TableNo OF
            DATABASE::"Sales Invoice Header":
                BEGIN
                    SetStatus(TableNo, DocNo, 1); // Enviando
                    SInvoice.SETRECFILTER;
                    DestinationMail := SInvoice."E-Mail Destination";
                    DestinationSubject := PDFSetup."Sales Invoices Email Subject" + ' ' + DocNo;
                    ReportSelection.SETRANGE(Usage, ReportSelection.Usage::"S.Invoice");
                    ReportSelection.FINDSET;
                    REPEAT
                        REPORT.SAVEASPDF(ReportSelection."Report ID", FullPDFfilePath, SInvoice);
                    UNTIL ReportSelection.NEXT = 0;
                END;
            DATABASE::"Sales Cr.Memo Header":
                BEGIN
                    SetStatus(TableNo, DocNo, 1);  // Enviando
                    SCrMemo.SETRECFILTER;
                    DestinationMail := SCrMemo."E-Mail Destination";
                    DestinationSubject := PDFSetup."Sales Cr.Memos Email Subject" + ' ' + DocNo;
                    ReportSelection.SETRANGE(Usage, ReportSelection.Usage::"S.Cr.Memo");
                    ReportSelection.FINDSET;
                    REPEAT
                        REPORT.SAVEASPDF(ReportSelection."Report ID", FullPDFfilePath, SCrMemo);
                    UNTIL ReportSelection.NEXT = 0;
                END;
            DATABASE::"Service Invoice Header":
                BEGIN
                    SetStatus(TableNo, DocNo, 1);  // Enviando
                    ServInvoice.SETRECFILTER;
                    DestinationMail := ServInvoice."E-Mail Destination";
                    DestinationSubject := PDFSetup."Service Invoices Email Subject" + ' ' + DocNo;
                    ReportSelection.SETRANGE(Usage, ReportSelection.Usage::"SM.Invoice");
                    ReportSelection.FINDSET;
                    REPEAT
                        REPORT.SAVEASPDF(ReportSelection."Report ID", FullPDFfilePath, ServInvoice);
                        REPORT.SAVEASPDF(50025, FullPDFfilePath2, ServInvoice);
                    UNTIL ReportSelection.NEXT = 0;
                END;
            DATABASE::"Service Cr.Memo Header":
                BEGIN
                    SetStatus(TableNo, DocNo, 1);  // Enviando
                    ServCrMemo.SETRECFILTER;
                    DestinationMail := ServCrMemo."E-Mail Destination";
                    DestinationSubject := PDFSetup."Service Cr.Memos Email Subject" + ' ' + DocNo;
                    ReportSelection.SETRANGE(Usage, ReportSelection.Usage::"SM.Credit Memo");
                    ReportSelection.FINDSET;
                    REPEAT
                        REPORT.SAVEASPDF(ReportSelection."Report ID", FullPDFfilePath, ServCrMemo);
                    UNTIL ReportSelection.NEXT = 0;
                END;
        END;

        CLEAR(SMTP);
        SMTP.CreateMessage(CompanyInfo.Name, CompanyInfo."E-Mail", DestinationMail,
                          DestinationSubject, CreateBody, TRUE);

        SMTP.AddAttachment(FullPDFfilePath, PdfFilename);

        //ACICATECH AJGONZALEZ - RQ18.0719
        //Se adjunta el parte de trabajo al enviar las facturas por email
        IF (TableNo = DATABASE::"Service Invoice Header") AND EXISTS(FullPDFfilePath2) THEN
            SMTP.AddAttachment(FullPDFfilePath2, PdfFilename2);
        //FIN AJGONZALEZ

        IF PDFSetup."PDF Notification C.C" <> '' THEN
            SMTP.AddBCC(PDFSetup."PDF Notification C.C");

        SMTP.Send;

        SetStatus(TableNo, DocNo, 2);  // Enviado
        //<< UPG2016 SVD End
    end;

    /// <summary>
    /// SetStatus()
    /// </summary>
    procedure SetStatus(TableNo: Integer; DocNo: Code[20]; Status: Option Pending,Sending,Sended)
    begin
        CASE TableNo OF
            DATABASE::"Sales Invoice Header":
                BEGIN
                    SInvoice.GET(DocNo);
                    SInvoice."Mail Status" := Status;
                    SInvoice.MODIFY;
                END;
            DATABASE::"Sales Cr.Memo Header":
                BEGIN
                    SCrMemo.GET(DocNo);
                    SCrMemo."Mail Status" := Status;
                    SCrMemo.MODIFY;
                END;
            DATABASE::"Service Invoice Header":
                BEGIN
                    ServInvoice.GET(DocNo);
                    ServInvoice."Mail Status" := Status;
                    ServInvoice.MODIFY;
                END;
            DATABASE::"Service Cr.Memo Header":
                BEGIN
                    ServCrMemo.GET(DocNo);
                    ServCrMemo."Mail Status" := Status;
                    ServCrMemo.MODIFY;
                END;
        END;
    end;

    /// <summary>
    /// CreateFileNameWorkOrder()
    /// </summary>
    procedure CreateFileNameWorkOrder(Path: Text[1024]; DocName: Text) FIleName: Text[1024]
    begin
        FIleName := Path + CONVERTSTR(DocName, '/\', '__') + '.pdf';
    end;
    */
}