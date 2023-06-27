/// <summary>
/// tableextension 50022 "Sales Cr.Memo Header_LDR"
/// </summary>
tableextension 50022 "Sales Cr.Memo Header_LDR" extends "Sales Cr.Memo Header"
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
            Caption = 'E-mail de destino';
            DataClassification = ToBeClassified;
            ExtendedDatatype = EMail;
        }
    }

    keys
    {
        key(Key10; "Sell-to Customer No.", "Posting Date")
        {
        }
    }

    trigger OnBeforeModify()
    begin
        if "Send Document By Mail_LDR" then
            TestField("E-Mail Destination_LDR");
    end;

    //[Internal]
    procedure SendRecords();
    var
        DocumentSendingProfile: Record "Document Sending Profile";
        DocTxt: Text;
        DummyReportSelections: Record "Report Selections";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        //OnBeforeSendRecords(DummyReportSelections, Rec, DocTxt, IsHandled);
        if IsHandled then
            exit;

        DocumentSendingProfile.SendCustomerRecords(
          DummyReportSelections.Usage::"S.Cr.Memo", Rec, DocTxt, "Bill-to Customer No.", "No.",
          FieldNo("Bill-to Customer No."), FieldNo("No."));
    end;

    //[External]
    procedure SendProfile(var DocumentSendingProfile: Record "Document Sending Profile");
    var
        DocTxt: Text;
        DummyReportSelections: Record "Report Selections";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        //OnBeforeSendProfile(DummyReportSelections, Rec, DocTxt, IsHandled, DocumentSendingProfile);
        if IsHandled then
            exit;

        DocumentSendingProfile.Send(
          DummyReportSelections.Usage::"S.Cr.Memo", Rec, "No.", "Bill-to Customer No.",
          DocTxt, FieldNo("Bill-to Customer No."), FieldNo("No."));
    end;

    //[External]
    local procedure IsSingleCustomerSelected(ShowRequestPage: Boolean): Boolean;
    var
        SelectedCount: Integer;
        CustomerCount: Integer;
        BillToCustomerNoFilter: Text;
        DocumentSendingProfile: Record "Document Sending Profile";
        DummyReportSelections: Record "Report Selections";
        IsHandled: Boolean;
    begin
        SelectedCount := Count;
        IsHandled := false;
        //OnBeforePrintRecords(DummyReportSelections, Rec, ShowRequestPage, IsHandled);
        if IsHandled then
            exit;

        if SelectedCount < 1 then
            exit(false);

        if SelectedCount = 1 then
            exit(true);

        BillToCustomerNoFilter := GetFilter("Bill-to Customer No.");
        SetRange("Bill-to Customer No.", "Bill-to Customer No.");
        CustomerCount := Count;
        SetFilter("Bill-to Customer No.", BillToCustomerNoFilter);

        exit(SelectedCount = CustomerCount);
    end;

    //[External]
    procedure PrintRecords(ShowRequestPage: Boolean);
    var
        DocumentSendingProfile: Record "Document Sending Profile";
        DummyReportSelections: Record "Report Selections";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        //OnBeforePrintRecords(DummyReportSelections, Rec, ShowRequestPage, IsHandled);
        if IsHandled then
            exit;

        DocumentSendingProfile.TrySendToPrinter(
          DummyReportSelections.Usage::"S.Cr.Memo", Rec, FieldNo("Bill-to Customer No."), ShowRequestPage);
    end;

    //[External]
    procedure EmailRecords(ShowRequestPage: Boolean);
    var
        DocumentSendingProfile: Record "Document Sending Profile";
        DocTxt: Text;
        DummyReportSelections: Record "Report Selections";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        //OnBeforeEmailRecords(DummyReportSelections, Rec, DocTxt, ShowRequestPage, IsHandled);
        if IsHandled then
            exit;

        DocumentSendingProfile.TrySendToEMail(
          DummyReportSelections.Usage::"S.Cr.Memo", Rec, FieldNo("No."), DocTxt, FieldNo("Bill-to Customer No."), ShowRequestPage);
    end;
}