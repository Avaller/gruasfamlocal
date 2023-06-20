/// <summary>
/// Table PDF Mail Report Params_LDR (ID 50231)
/// </summary>
table 50231 "PDF Mail Report Params_LDR"
{
    // UPG2016 23/12/2015 1CF_RPB Obsolete table 2000000009 Session, Use new table 2000000110 Active session

    Caption = 'PDF Mail Report Params';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "PDF Notification C.C"; Text[250])
        {
            Caption = 'PDF Notification C.C';
            ExtendedDatatype = EMail;
        }
        field(3; "PDF Sales Invoice Template"; BLOB)
        {
            Caption = 'PDF Sales Invoice Template';
        }
        field(4; "PDF Sales Cr.Memo Template"; BLOB)
        {
            Caption = 'PDF Sales Cr.Memo Template';
        }
        field(5; "PDF Service Invoice Template"; BLOB)
        {
            Caption = 'PDF Service Invoice Template';
        }
        field(6; "PDF Service Cr.Memo Template"; BLOB)
        {
            Caption = 'PDF Service Cr.Memo Template';
        }
        field(7; "Mail Body HTML"; BLOB)
        {
            Caption = 'Mail Body HTML';
        }
        field(8; "Email Sending Delay"; DateFormula)
        {
            Caption = 'PDF Email Sending Delay';
        }
        field(9; "Temp URL"; Text[250])
        {
            Caption = 'Temp URL';
        }
        field(10; "Sales Invoice Document Date"; Option)
        {
            Caption = 'Document Date';
            OptionCaption = 'Posting Date,Document Date';
            OptionMembers = "Posting Date","Document Date";
        }
        field(11; "Service Invoice Document Date"; Option)
        {
            Caption = 'Document Date';
            OptionCaption = 'Posting Date,Document Date';
            OptionMembers = "Posting Date","Document Date";
        }
        field(12; "Sales Invoice Header Picture"; Option)
        {
            Caption = 'Header Picture';
            OptionCaption = 'Big Color Picture,Big B/N Picture,Small Color Picture,Small B/N Picture,None';
            OptionMembers = "Big Color","Big B/W","Small Color","Small B/W","None";
        }
        field(13; "Service Invoice Header Picture"; Option)
        {
            Caption = 'Header Picture';
            OptionCaption = 'Big Color Picture,Big B/N Picture,Small Color Picture,Small B/N Picture,None';
            OptionMembers = "Big Color","Big B/W","Small Color","Small B/W","None";
        }
        field(14; "Sales Invoice Footer Picture"; Option)
        {
            Caption = 'Footer Picture';
            OptionCaption = 'Color Picture,B/N Picture,None';
            OptionMembers = Color,"B/W","None";
        }
        field(15; "Service Invoice Footer Picture"; Option)
        {
            Caption = 'Footer Picture';
            OptionCaption = 'Color Picture,B/N Picture,None';
            OptionMembers = Color,"B/W","None";
        }
        field(16; "Sales Invoice Show Internal"; BoolEAN)
        {
            Caption = 'Show Internal Information';
        }
        field(17; "Service Invoice Show Internal"; BoolEAN)
        {
            Caption = 'Show Internal Information';
        }
        field(18; "Sales Invoice Show Discounts"; BoolEAN)
        {
            Caption = 'Show 100% Discount Lines';
        }
        field(19; "Service Invoice Show Discounts"; BoolEAN)
        {
            Caption = 'Show 100% Discount Lines';
        }
        field(20; "Sales Invoice Group Disp."; BoolEAN)
        {
            Caption = 'Group Displacement';
        }
        field(21; "Service Invoice Group Disp."; BoolEAN)
        {
            Caption = 'Group Displacement';
        }
        field(22; "Sales Invoice Contract Dtls"; BoolEAN)
        {
            Caption = 'Show Contract Details';
        }
        field(23; "Service Invoice Contract Dtls"; BoolEAN)
        {
            Caption = 'Show Contract Details';
        }
        field(24; "Sales Invoice Components"; BoolEAN)
        {
            Caption = 'Show Component List';
        }
        field(25; "Service Invoice Components"; BoolEAN)
        {
            Caption = 'Show Component List';
        }
        field(27; "Service Invoice Show Dates"; BoolEAN)
        {
            Caption = 'Service Invoice Show Dates';
        }
        field(29; "Service Invoice Hide Prices"; BoolEAN)
        {
            Caption = 'Service Invoice Hide Prices';
        }
        field(30; "Sales Invoice LOPD"; BoolEAN)
        {
            Caption = 'Sales Invoice LOPD';
        }
        field(31; "Service Invoice LOPD"; BoolEAN)
        {
            Caption = 'Service Invoice LOPD';
        }
        field(33; "Service Invoice Res. Comments"; BoolEAN)
        {
            Caption = 'Show Resolution Comments';
        }
        field(38; "Sales Cr.Memo Document Date"; Option)
        {
            Caption = 'Document Date';
            OptionCaption = 'Posting Date,Document Date';
            OptionMembers = "Posting Date","Document Date";
        }
        field(39; "Service Cr.Memo Document Date"; Option)
        {
            Caption = 'Document Date';
            OptionCaption = 'Posting Date,Document Date';
            OptionMembers = "Posting Date","Document Date";
        }
        field(40; "Sales Cr.Memo Header Picture"; Option)
        {
            Caption = 'Header Picture';
            OptionCaption = 'Big Color Picture,Big B/N Picture,Small Color Picture,Small B/N Picture,None';
            OptionMembers = "Big Color","Big B/W","Small Color","Small B/W","None";
        }
        field(41; "Service Cr.Memo Header Picture"; Option)
        {
            Caption = 'Header Picture';
            OptionCaption = 'Big Color Picture,Big B/N Picture,Small Color Picture,Small B/N Picture,None';
            OptionMembers = "Big Color","Big B/W","Small Color","Small B/W","None";
        }
        field(42; "Sales Cr.Memo Footer Picture"; Option)
        {
            Caption = 'Footer Picture';
            OptionCaption = 'Color Picture,B/N Picture,None';
            OptionMembers = Color,"B/W","None";
        }
        field(43; "Service Cr.Memo Footer Picture"; Option)
        {
            Caption = 'Footer Picture';
            OptionCaption = 'Color Picture,B/N Picture,None';
            OptionMembers = Color,"B/W","None";
        }
        field(44; "Sales Cr.Memo Show Internal"; BoolEAN)
        {
            Caption = 'Show Internal Information';
        }
        field(45; "Service Cr.Memo Show Internal"; BoolEAN)
        {
            Caption = 'Show Internal Information';
        }
        field(46; "Sales Cr.Memo Show LOPD"; BoolEAN)
        {
            Caption = 'Sales Cr.Memo Show LOPD';
        }
        field(47; "Service Cr.Memo Show LOPD"; BoolEAN)
        {
            Caption = 'Service Cr.Memo Show LOPD';
        }
        field(100; "Process Sales Invoices"; BoolEAN)
        {
            Caption = 'Send';
        }
        field(101; "Process Sales Cr. Memos"; BoolEAN)
        {
            Caption = 'Send';
        }
        field(102; "Process Service Invoices"; BoolEAN)
        {
            Caption = 'Send';
        }
        field(103; "Process Service Cr. Memos"; BoolEAN)
        {
            Caption = 'Send';
        }
        field(104; "Sales Invoices Email Subject"; Text[100])
        {
            Caption = 'Subject';
        }
        field(105; "Sales Cr.Memos Email Subject"; Text[100])
        {
            Caption = 'Subject';
        }
        field(106; "Service Invoices Email Subject"; Text[100])
        {
            Caption = 'Subject';
        }
        field(107; "Service Cr.Memos Email Subject"; Text[100])
        {
            Caption = 'Subject';
        }
        field(108; "Documents to PDF Path"; Text[250])
        {
            Caption = 'Documents to PDF Path';

            trigger OnValidate()
            begin
                IF STRLEN("Documents to PDF Path") > 0 THEN
                    IF COPYSTR("Documents to PDF Path", STRLEN("Documents to PDF Path"), 1) <> '\' THEN
                        "Documents to PDF Path" := "Documents to PDF Path" + '\';
            end;
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        ReportSelection2: Record "Report Selections";

    /// <summary>
    /// SetSalesInvoiceParams()
    /// </summary>
    procedure SetSalesInvoiceParams(var DocumentDateParam: Option "Posting Date","Document Date"; var HeaderPictureParam: Option "Big Color","Big B/W","Small Color","Small B/W","None"; var FooterPictureParam: Option Color,"B/W","None"; var ShowLOPD: BoolEAN)
    begin
        IF FINDFIRST THEN;
        DocumentDateParam := "Sales Invoice Document Date";
        HeaderPictureParam := "Sales Invoice Header Picture";
        FooterPictureParam := "Sales Invoice Footer Picture";
        //ShowInternalInfoParam := "Sales Invoice Show Internal";
        //ShowDiscountLinesParam := "Sales Invoice Show Discounts";
        //GroupDisplacementParam := "Sales Invoice Group Disp.";
        //ShowContractDetailsParam := "Sales Invoice Contract Dtls";
        //ShowComponentListParam := "Sales Invoice Components";
        ShowLOPD := "Sales Invoice LOPD"
    end;

    /// <summary>
    /// SetServInvoiceParams()
    /// </summary>
    procedure SetServInvoiceParams(var DocumentDateParam: Option "Posting Date","Document Date"; var HeaderPictureParam: Option "Big Color","Big B/W","Small Color","Small B/W","None"; var FooterPictureParam: Option Color,"B/W","None"; var ShowInternalInfoParam: BoolEAN; var ShowDiscountLinesParam: BoolEAN; var ShowResCommentsParam: BoolEAN; var GroupDisplacementParam: BoolEAN; var ShowContractDetailsParam: BoolEAN; var ShowComponentListParam: BoolEAN; var ShowDates: BoolEAN; var ShowLOPD: BoolEAN; var HidePrices: BoolEAN)
    begin
        IF FINDFIRST THEN;
        DocumentDateParam := "Service Invoice Document Date";
        HeaderPictureParam := "Service Invoice Header Picture";
        FooterPictureParam := "Service Invoice Footer Picture";
        ShowInternalInfoParam := "Service Invoice Show Internal";
        ShowDiscountLinesParam := "Service Invoice Show Discounts";
        GroupDisplacementParam := "Service Invoice Group Disp.";
        ShowResCommentsParam := "Service Invoice Res. Comments";
        ShowContractDetailsParam := "Service Invoice Contract Dtls";
        ShowComponentListParam := "Service Invoice Components";
        ShowDates := "Service Invoice Show Dates";
        ShowLOPD := "Service Invoice LOPD";
        HidePrices := "Service Invoice Hide Prices";
    end;

    /// <summary>
    /// SetSalesCrMemoParams()
    /// </summary>
    procedure SetSalesCrMemoParams(var DocumentDateParam: Option "Posting Date","Document Date"; var HeaderPictureParam: Option "Big Color","Big B/W","Small Color","Small B/W","None"; var FooterPictureParam: Option Color,"B/W","None"; var ShowInternalInfoParam: BoolEAN; var ShowLOPD: BoolEAN)
    begin
        IF FINDFIRST THEN;
        DocumentDateParam := "Sales Cr.Memo Document Date";
        HeaderPictureParam := "Sales Cr.Memo Header Picture";
        FooterPictureParam := "Sales Cr.Memo Footer Picture";
        ShowInternalInfoParam := "Sales Cr.Memo Show Internal";
        ShowLOPD := "Sales Cr.Memo Show LOPD";
    end;

    /// <summary>
    /// SetServCrMemoParams()
    /// </summary>
    procedure SetServCrMemoParams(var DocumentDateParam: Option "Posting Date","Document Date"; var HeaderPictureParam: Option "Big Color","Big B/W","Small Color","Small B/W","None"; var FooterPictureParam: Option Color,"B/W","None"; var ShowInternalInfoParam: BoolEAN; var ShowLOPD: BoolEAN)
    begin
        IF FINDFIRST THEN;

        DocumentDateParam := "Service Cr.Memo Document Date";
        HeaderPictureParam := "Service Cr.Memo Header Picture";
        FooterPictureParam := "Service Cr.Memo Footer Picture";
        ShowInternalInfoParam := "Service Cr.Memo Show Internal";
        ShowLOPD := "Service Cr.Memo Show LOPD";
    end;

    /// <summary>
    /// NASActive()
    /// </summary>
    procedure NASActive(): BoolEAN
    var
        Conections: Record "Active Session";
    begin
        //>> UPG2016_RPB Start
        CLEAR(Conections);
        //Conections.SETRANGE(Conections."My Session",TRUE);
        Conections.SETRANGE("User ID", USERID);
        IF Conections.FINDSET THEN
            //EXIT(Conections."Application Name" = 'Application Server for Microsoft Dynamics NAV Classic');
            EXIT(Conections."Client Type" = Conections."Client Type"::NAS);
        //>> UPG2016_RPB End
    end;
}