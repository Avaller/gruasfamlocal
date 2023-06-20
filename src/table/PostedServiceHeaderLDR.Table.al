/// <summary>
/// Table Posted Service Header_LDR (ID 50217)
/// </summary>
table 50217 "Posted Service Header_LDR"
{
    // UPG2016 23/12/2015 1CF_RPB Dimension functionality reimplemented
    //                            Field 'User Id' Code20 -> Code50

    Caption = 'Posted Service Header';
    DataCaptionFields = "No.", "Description";
    DrillDownPageID = "Posted Service Order List";
    LookupPageID = "Posted Service Order List";

    fields
    {
        field(2; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            NotBlank = true;
            TableRelation = Customer;
        }
        field(3; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(4; "Bill-to Customer No."; Code[20])
        {
            Caption = 'Bill-to Customer No.';
            NotBlank = true;
            TableRelation = Customer;
        }
        field(5; "Bill-to Name"; Text[100])
        {
            Caption = 'Bill-to Name';
        }
        field(6; "Bill-to Name 2"; Text[50])
        {
            Caption = 'Bill-to Name 2';
        }
        field(7; "Bill-to Address"; Text[100])
        {
            Caption = 'Bill-to Address';
        }
        field(8; "Bill-to Address 2"; Text[50])
        {
            Caption = 'Bill-to Address 2';
        }
        field(9; "Bill-to City"; Text[30])
        {
            Caption = 'Bill-to City';
        }
        field(10; "Bill-to Contact"; Text[100])
        {
            Caption = 'Bill-to Contact';
        }
        field(11; "Your Reference"; Text[35])
        {
            Caption = 'Your Reference';
        }
        field(12; "Ship-to Code"; Code[10])
        {
            Caption = 'Ship-to Code';
            TableRelation = "Ship-to Address"."Code" WHERE("Customer No." = FIELD("Customer No."));
        }
        field(13; "Ship-to Name"; Text[100])
        {
            Caption = 'Ship-to Name';
        }
        field(14; "Ship-to Name 2"; Text[50])
        {
            Caption = 'Ship-to Name 2';
        }
        field(15; "Ship-to Address"; Text[100])
        {
            Caption = 'Ship-to Address';
        }
        field(16; "Ship-to Address 2"; Text[50])
        {
            Caption = 'Ship-to Address 2';
        }
        field(17; "Ship-to City"; Text[30])
        {
            Caption = 'Ship-to City';
        }
        field(18; "Ship-to Contact"; Text[100])
        {
            Caption = 'Ship-to Contact';
        }
        field(19; "Order Date"; Date)
        {
            Caption = 'Order Date';
            NotBlank = true;
        }
        field(20; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(22; "Posting Description"; Text[100])
        {
            Caption = 'Posting Description';
        }
        field(23; "Payment Terms Code"; Code[10])
        {
            Caption = 'Payment Terms Code';
            TableRelation = "Payment Terms";
        }
        field(24; "Due Date"; Date)
        {
            Caption = 'Due Date';
        }
        field(25; "Payment Discount %"; Decimal)
        {
            Caption = 'Payment Discount %';
            DecimalPlaces = 0 : 6;
        }
        field(26; "Pmt. Discount Date"; Date)
        {
            Caption = 'Pmt. Discount Date';
        }
        field(27; "Shipment Method Code"; Code[10])
        {
            Caption = 'Shipment Method Code';
            TableRelation = "Shipment Method";
        }
        field(28; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = "Location" WHERE("Use As In-Transit" = CONST(false));
        }
        field(29; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value"."Code" WHERE("Global Dimension No." = CONST(1));
        }
        field(30; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value"."Code" WHERE("Global Dimension No." = CONST(2));
        }
        field(31; "Customer Posting Group"; Code[10])
        {
            Caption = 'Customer Posting Group';
            Editable = false;
            TableRelation = "Customer Posting Group";
        }
        field(32; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            Editable = false;
            TableRelation = Currency;
        }
        field(33; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DecimalPlaces = 0 : 15;
            MinValue = 0;
        }
        field(34; "Customer Price Group"; Code[10])
        {
            Caption = 'Customer Price Group';
            TableRelation = "Customer Price Group";
        }
        field(35; "Prices Including VAT"; BoolEAN)
        {
            Caption = 'Prices Including VAT';
        }
        field(37; "Invoice Disc. Code"; Code[20])
        {
            Caption = 'Invoice Disc. Code';
        }
        field(40; "Customer Disc. Group"; Code[10])
        {
            Caption = 'Customer Disc. Group';
            TableRelation = "Customer Discount Group";
        }
        field(41; "Language Code"; Code[10])
        {
            Caption = 'Language Code';
            TableRelation = Language;
        }
        field(43; "Salesperson Code"; Code[10])
        {
            Caption = 'Salesperson Code';
            TableRelation = "Salesperson/Purchaser";
        }
        field(44; "Order No."; Code[20])
        {
            Caption = 'Order No.';
        }
        field(46; Comment; BoolEAN)
        {
            CalcFormula = Exist("Service Comment Line" WHERE("Table Name" = CONST(50217),
                                                              "No." = FIELD("No."),
                                                              "Type" = CONST("General")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(47; "No. Printed"; Integer)
        {
            Caption = 'No. Printed';
            Editable = false;
        }
        field(52; "Applies-to Doc. Type"; Option)
        {
            Caption = 'Applies-to Doc. Type';
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund,,,,,,,,,,,,,,,Bill';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund,,,,,,,,,,,,,,,Bill;
        }
        field(53; "Applies-to Doc. No."; Code[20])
        {
            Caption = 'Applies-to Doc. No.';
        }
        field(55; "Bal. Account No."; Code[20])
        {
            Caption = 'Bal. Account No.';
            TableRelation = IF ("Bal. Account Type" = CONST("G/L Account")) "G/L Account"
            ELSE
            IF ("Bal. Account Type" = CONST("Bank Account")) "Bank Account";
        }
        field(70; "VAT Registration No."; Text[20])
        {
            Caption = 'VAT Registration No.';
        }
        field(73; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            TableRelation = "Reason Code";
        }
        field(74; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";
        }
        field(75; "EU 3-Party Trade"; BoolEAN)
        {
            Caption = 'EU 3-Party Trade';
        }
        field(76; "Transaction Type"; Code[10])
        {
            Caption = 'Transaction Type';
            TableRelation = "Transaction Type";
        }
        field(77; "Transport Method"; Code[10])
        {
            Caption = 'Transport Method';
            TableRelation = "Transport Method";
        }
        field(78; "VAT Country/Region Code"; Code[10])
        {
            Caption = 'VAT Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(79; Name; Text[100])
        {
            Caption = 'Name';
        }
        field(80; "Name 2"; Text[50])
        {
            Caption = 'Name 2';
        }
        field(81; Address; Text[100])
        {
            Caption = 'Address';
        }
        field(82; "Address 2"; Text[50])
        {
            Caption = 'Address 2';
        }
        field(83; City; Text[30])
        {
            Caption = 'City';
        }
        field(84; "Contact Name"; Text[100])
        {
            Caption = 'Contact Name';
        }
        field(85; "Bill-to Post Code"; Code[20])
        {
            Caption = 'Bill-to Post Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(86; "Bill-to County"; Text[30])
        {
            Caption = 'Bill-to County';
        }
        field(87; "Bill-to Country/Region Code"; Code[10])
        {
            Caption = 'Bill-to Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(88; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(89; County; Text[30])
        {
            Caption = 'County';
        }
        field(90; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(91; "Ship-to Post Code"; Code[20])
        {
            Caption = 'Ship-to Post Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(92; "Ship-to County"; Text[30])
        {
            Caption = 'Ship-to County';
        }
        field(93; "Ship-to Country/Region Code"; Code[10])
        {
            Caption = 'Ship-to Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(94; "Bal. Account Type"; Option)
        {
            Caption = 'Bal. Account Type';
            OptionCaption = 'G/L Account,Bank Account';
            OptionMembers = "G/L Account","Bank Account";
        }
        field(97; "Exit Point"; Code[10])
        {
            Caption = 'Exit Point';
            TableRelation = "Entry/Exit Point";
        }
        field(98; Correction; BoolEAN)
        {
            Caption = 'Correction';
        }
        field(99; "Document Date"; Date)
        {
            Caption = 'Document Date';
        }
        field(101; "Area"; Code[10])
        {
            Caption = 'Area';
            TableRelation = Area;
        }
        field(102; "Transaction Specification"; Code[10])
        {
            Caption = 'Transaction Specification';
            TableRelation = "Transaction Specification";
        }
        field(104; "Payment Method Code"; Code[10])
        {
            Caption = 'Payment Method Code';
            TableRelation = "Payment Method";
        }
        field(109; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(110; "Order No. Series"; Code[10])
        {
            Caption = 'Order No. Series';
            TableRelation = "No. Series";
        }
        field(112; "User ID"; Code[50])
        {
            Caption = 'User ID';
            Description = 'UPG2016';
            TableRelation = User;

            trigger OnLookup()
            var
                LoginMgt: Codeunit "User Management";
            begin
            end;
        }
        field(113; "Source Code"; Code[10])
        {
            Caption = 'Source Code';
            TableRelation = "Source Code";
        }
        field(114; "Tax Area Code"; Code[20])
        {
            Caption = 'Tax Area Code';
            TableRelation = "Tax Area";
        }
        field(115; "Tax Liable"; BoolEAN)
        {
            Caption = 'Tax Liable';
        }
        field(116; "VAT Bus. Posting Group"; Code[10])
        {
            Caption = 'VAT Bus. Posting Group';
            TableRelation = "VAT Business Posting Group";
        }
        field(119; "VAT Base Discount %"; Decimal)
        {
            Caption = 'VAT Base Discount %';
            DecimalPlaces = 0 : 6;
            MaxValue = 100;
            MinValue = 0;
        }
        field(121; "Invoice Discount Calculation"; Option)
        {
            Caption = 'Invoice Discount Calculation';
            Editable = false;
            OptionCaption = 'None,%,Amount';
            OptionMembers = "None","%",Amount;
        }
        field(122; "Invoice Discount Value"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Invoice Discount Value';
            Editable = false;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Description = 'UPG2016';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                ShowDimensions();
            end;
        }
        field(5052; "Contact No."; Code[20])
        {
            Caption = 'Contact No.';
            TableRelation = Contact;
        }
        field(5053; "Bill-to Contact No."; Code[20])
        {
            Caption = 'Bill-to Contact No.';
            TableRelation = Contact;
        }
        field(5700; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center";
        }
        field(5796; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(5902; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(5904; "Service Order Type"; Code[10])
        {
            Caption = 'Service Order Type';
            TableRelation = "Service Order Type";
        }
        field(5905; "Link Service to Service Item"; BoolEAN)
        {
            Caption = 'Link Service to Service Item';
        }
        field(5907; Priority; Option)
        {
            Caption = 'Priority';
            Editable = false;
            OptionCaption = 'Low,Medium,High';
            OptionMembers = Low,Medium,High;
        }
        field(5911; "Allocated Hours"; Decimal)
        {
            CalcFormula = Sum("Service Order Allocation"."Allocated Hours" WHERE("Document Type" = CONST("Order"),
                                                                                  "Document No." = FIELD("Order No."),
                                                                                  "Resource No." = FIELD("Resource Filter"),
                                                                                  "Resource Group No." = FIELD("Resource Group Filter"),
                                                                                  "Status" = FILTER("Active" | "Finished")));
            Caption = 'Allocated Hours';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(5915; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            ExtendedDatatype = PhoneNo;
        }
        field(5916; "E-Mail"; Text[80])
        {
            Caption = 'E-Mail';
            ExtendedDatatype = EMail;
        }
        field(5917; "Phone No. 2"; Text[30])
        {
            Caption = 'Phone No. 2';
            ExtendedDatatype = PhoneNo;
        }
        field(5918; "Fax No."; Text[30])
        {
            Caption = 'Fax No.';
        }
        field(5921; "No. of Unallocated Items"; Integer)
        {
            CalcFormula = Count("Service Item Line" WHERE("Document Type" = CONST("Order"),
                                                           "Document No." = FIELD("No."),
                                                           "No. of Active/Finished Allocs" = CONST(0)));
            Caption = 'No. of Unallocated Items';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5923; "Order Time"; Time)
        {
            Caption = 'Order Time';
        }
        field(5924; "Default Response Time (Hours)"; Decimal)
        {
            Caption = 'Default Response Time (Hours)';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(5925; "Actual Response Time (Hours)"; Decimal)
        {
            Caption = 'Actual Response Time (Hours)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            MinValue = 0;
        }
        field(5926; "Service Time (Hours)"; Decimal)
        {
            Caption = 'Service Time (Hours)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(5927; "Response Date"; Date)
        {
            Caption = 'Response Date';
            Editable = false;
        }
        field(5928; "Response Time"; Time)
        {
            Caption = 'Response Time';
            Editable = false;
        }
        field(5929; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
        }
        field(5930; "Starting Time"; Time)
        {
            Caption = 'Starting Time';
        }
        field(5931; "Finishing Date"; Date)
        {
            Caption = 'Finishing Date';
        }
        field(5932; "Finishing Time"; Time)
        {
            Caption = 'Finishing Time';
        }
        field(5933; "Contract Serv. Hours Exist"; BoolEAN)
        {
            CalcFormula = Exist("Service Hour" WHERE("Service Contract No." = FIELD("Contract No.")));
            Caption = 'Contract Serv. Hours Exist';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5934; "Reallocation Needed"; BoolEAN)
        {
            CalcFormula = Exist("Service Order Allocation" WHERE("Status" = CONST("Reallocation Needed"),
                                                                  "Resource No." = FIELD("Resource Filter"),
                                                                  "Document Type" = CONST("Order"),
                                                                  "Document No." = FIELD("No."),
                                                                  "Resource Group No." = FIELD("Resource Group Filter")));
            Caption = 'Reallocation Needed';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5936; "Notify Customer"; Option)
        {
            Caption = 'Notify Customer';
            OptionCaption = 'No,By Phone 1,By Phone 2,By Fax,By E-Mail';
            OptionMembers = No,"By Phone 1","By Phone 2","By Fax","By E-Mail";
        }
        field(5937; "Max. Labor Unit Price"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 2;
            BlankZero = true;
            Caption = 'Max. Labor Unit Price';
        }
        field(5938; "Warning Status"; Option)
        {
            Caption = 'Warning Status';
            OptionCaption = ' ,First Warning,Second Warning,Third Warning';
            OptionMembers = " ","First Warning","Second Warning","Third Warning";
        }
        field(5939; "No. of Allocations"; Integer)
        {
            CalcFormula = Count("Service Order Allocation" WHERE("Document Type" = CONST("Order"),
                                                                  "Document No." = FIELD("No."),
                                                                  "Resource No." = FIELD("Resource Filter"),
                                                                  "Resource Group No." = FIELD("Resource Group Filter"),
                                                                  "Status" = FILTER("Active" | "Finished")));
            Caption = 'No. of Allocations';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5940; "Contract No."; Code[20])
        {
            Caption = 'Contract No.';
            TableRelation = "Service Contract Header"."Contract No." WHERE("Contract Type" = CONST("Contract"),
                                                                            "Customer No." = FIELD("Customer No."),
                                                                            "Ship-to Code" = FIELD("Ship-to Code"),
                                                                            "Bill-to Customer No." = FIELD("Bill-to Customer No."));
        }
        field(5951; "Type Filter"; Option)
        {
            Caption = 'Type Filter';
            FieldClass = FlowFilter;
            OptionCaption = ' ,Resource,Item,Service Cost,Service Contract';
            OptionMembers = " ",Resource,Item,"Service Cost","Service Contract";
        }
        field(5952; "Customer Filter"; Code[20])
        {
            Caption = 'Customer Filter';
            FieldClass = FlowFilter;
            TableRelation = "Customer"."No.";
        }
        field(5953; "Resource Filter"; Code[20])
        {
            Caption = 'Resource Filter';
            FieldClass = FlowFilter;
            TableRelation = Resource;
        }
        field(5954; "Contract Filter"; Code[20])
        {
            Caption = 'Contract Filter';
            FieldClass = FlowFilter;
            TableRelation = "Service Contract Header"."Contract No." WHERE("Contract Type" = CONST("Contract"));
        }
        field(5955; "Ship-to Fax No."; Text[30])
        {
            Caption = 'Ship-to Fax No.';
        }
        field(5956; "Ship-to E-Mail"; Text[80])
        {
            Caption = 'Ship-to E-Mail';
            ExtendedDatatype = EMail;
        }
        field(5957; "Resource Group Filter"; Code[20])
        {
            Caption = 'Resource Group Filter';
            FieldClass = FlowFilter;
            TableRelation = "Resource Group";
        }
        field(5958; "Ship-to Phone"; Text[30])
        {
            Caption = 'Ship-to Phone';
            ExtendedDatatype = PhoneNo;
        }
        field(5959; "Ship-to Phone 2"; Text[30])
        {
            Caption = 'Ship-to Phone 2';
            ExtendedDatatype = PhoneNo;
        }
        field(5966; "Service Zone Filter"; Code[10])
        {
            Caption = 'Service Zone Filter';
            FieldClass = FlowFilter;
            TableRelation = "Service Zone".Code;
        }
        field(5968; "Service Zone Code"; Code[10])
        {
            Caption = 'Service Zone Code';
            TableRelation = "Service Zone".Code;
        }
        field(5981; "Expected Finishing Date"; Date)
        {
            Caption = 'Expected Finishing Date';
        }
        field(7001; "Allow Line Disc."; BoolEAN)
        {
            Caption = 'Allow Line Disc.';
        }
        field(50001; "Quote No."; Code[20])
        {
            Caption = 'Quote No.';
        }
        field(50002; "Converted to Order"; BoolEAN)
        {
            Caption = 'Converted to Order';
            Editable = false;
        }
        field(50003; "Customer Comment"; BoolEAN)
        {
            CalcFormula = Exist("Comment Line" WHERE("Table Name" = CONST("Customer"),
                                                      "No." = FIELD("Customer No.")));
            Caption = 'Customer Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50004; "Invoice No. Series"; Code[20])
        {
            Caption = 'Invoice No. Series';
            TableRelation = "No. Series";

            trigger OnLookup()
            var
                ServiceHeader: Record "Service Header";
                SalesSetup: Record "Sales & Receivables Setup";
                NoSeriesMgt: Codeunit "NoSeriesManagement";
            begin
            end;

            trigger OnValidate()
            var
                SalesSetup: Record "Sales & Receivables Setup";
                NoSeriesMgt: Codeunit "NoSeriesManagement";
            begin
            end;
        }
        field(50005; "Contract group Code"; Code[10])
        {
            CalcFormula = Lookup("Service Contract Header"."Contract Group Code" WHERE("Contract No." = FIELD("Contract No.")));
            Caption = 'Contract group Code';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50008; "Default Work Type Code"; Code[20])
        {
            Caption = 'Default Work Type Code';
            TableRelation = "Work Type" WHERE("Res. Journal Type_LDR" = FILTER(false));

            trigger OnValidate()
            var
                ServInvLine: Record "Service Line";
                txtTipoTrabajoDefecto: Label 'There are Service Invoice Lines without Work type Code. Do you want to update that?';
            begin
            end;
        }
        field(50009; "Internal Contract No."; Code[20])
        {
            Caption = 'Internal Contract No.';
            //TableRelation = "Table70028"."Field1" WHERE("Field2" = CONST(1)); 

        }
        field(50010; "Review No."; Integer)
        {
            Caption = 'Revision No.';
        }
        field(50011; "Review Contract Line No."; Integer)
        {
            Caption = 'Review Contract Line No.';
        }
        field(50012; "Review Template No."; Code[20])
        {
            Caption = 'Review Template No.';
            //TableRelation = "Table70002"; 
        }
        field(50013; "Shipping Agent Code"; Code[10])
        {
            Caption = 'Shipping Agent Code';
            TableRelation = "Shipping Agent";
        }
        field(50014; "Rejected Quote"; BoolEAN)
        {
            Caption = 'Rejected Quote';
        }
        field(50021; "External Document No."; Code[20])
        {
            Caption = 'External Document No.';
        }
        field(50050; "Crane Service Quote No."; Code[20])
        {
            Caption = 'Service Order Crane No.';
            Description = 'FAM';
            TableRelation = "Crane Service Quote Header_LDR";
        }
        field(50051; "Service Item Rate No."; Code[20])
        {
            Caption = 'Service Item Rate No.';
            TableRelation = "Service Item Rate Header_LDR";
        }
        field(50052; "Serv. Item Operation Entry No."; Integer)
        {
            Caption = 'Serv. Item Operation Entry No.';
        }
        field(50055; "Crane Serv. Quote Op. Line No"; Integer)
        {
            Caption = 'Crane Serv. Quote Op. Line No';
        }
        field(50057; "Customer Order No."; Code[20])
        {
            Caption = 'Customer Order No.';
        }
        field(60000; "Historico ELESOFT"; BoolEAN)
        {
            Caption = 'ELESOFT Historial';
        }
        field(60001; "No. of Posted Invoices"; Integer)
        {
            CalcFormula = Count("Service Document Register" WHERE("Source Document Type" = CONST("Order"),
                                                                   "Source Document No." = FIELD("No."),
                                                                   "Destination Document Type" = CONST("Posted Invoice")));
            Caption = 'No. of Posted Invoices';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60002; "No. of Unposted Invoices"; Integer)
        {
            CalcFormula = Count("Service Document Register" WHERE("Source Document Type" = CONST("Order"),
                                                                   "Source Document No." = FIELD("No."),
                                                                   "Destination Document Type" = CONST("Invoice")));
            Caption = 'No. of Unposted Invoices';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7000000; "Applies-to Bill No."; Code[20])
        {
            Caption = 'Applies-to Bill No.';
        }
        field(7000001; "Cust. Bank Acc. Code"; Code[20])
        {
            Caption = 'Cust. Bank Acc. Code';
            TableRelation = "Customer Bank Account"."Code" WHERE("Customer No." = FIELD("Bill-to Customer No."));
        }
        field(7000003; "Pay-at Code"; Code[20])
        {
            Caption = 'Pay-at Code';
            TableRelation = "Customer Pmt. Address"."Code" WHERE("Customer No." = FIELD("Bill-to Customer No."));
        }
        field(7121999; "Direct Debit Mandate ID"; Code[35])
        {
            Caption = 'Direct Debit Mandate ID';
            Editable = false;
            TableRelation = "SEPA Direct Debit Mandate" WHERE("Customer No." = FIELD("Bill-to Customer No."),
                                                               "Closed" = CONST(false),
                                                               "Blocked" = CONST(false));
        }
        field(7122000; "Source Type"; Option)
        {
            Caption = 'Source Type';
            Editable = false;
            OptionCaption = ' ,Transfer';
            OptionMembers = ,Transfer;
        }
        field(7122009; "Linked Service Order No."; Code[20])
        {
            Caption = 'Linked Service Order No.';
            TableRelation = "Service Header"."No." WHERE("Document Type" = CONST("Order"),
                                                        "Customer No." = FIELD("Customer No."),
                                                        "Bill-to Customer No." = FIELD("Bill-to Customer No."),
                                                        "Ship-to Code" = FIELD("Ship-to Code"));
        }
        field(7122015; "Direct sales"; BoolEAN)
        {
            Caption = 'Direct sales';
        }
        field(7122018; "Calculate Maint. Type"; Option)
        {
            Caption = 'Calculate Maintenance Type';
            Description = 'Indica el tipo de Calculo que se utilizara para sacar las Horas/Dia de una maquina';
            NotBlank = true;
            OptionCaption = 'By Service Config,Contract Calculate,Period Calculate,Orders Calculate';
            OptionMembers = " ","Según Contrato","Por Período","Por Nº Pedidos";
        }
        field(7122019; "Calculate Maint. Type Period"; DateFormula)
        {
            Caption = 'Calculate Maint. Type Period';
            Description = 'Indica el Periodo que se utilizara para el calculo de Horas/Dia de una maquina por Periodo';
        }
        field(7122020; "Calculate Maint. Type Order"; Integer)
        {
            Caption = 'Calculate Maint. Type Order';
            Description = 'Indica el numero de pedidos que se utilizaran para el calculo de Horas/Dia de una maquina por Pedidos Servicio';
            MinValue = 0;
            NotBlank = true;
        }
        field(7122021; "Maintenance Order"; BoolEAN)
        {
            Caption = 'Maintenance Order';
        }
        field(7122030; "Send Document By Mail"; BoolEAN)
        {
            Caption = 'Send Document By Mail';

            trigger OnLookup()
            var
                ServiceHeader: Record "Service Header";
                SalesSetup: Record "Sales & Receivables Setup";
                NoSeriesMgt: Codeunit "NoSeriesManagement";
            begin
            end;

            trigger OnValidate()
            var
                SalesSetup: Record "Sales & Receivables Setup";
                NoSeriesMgt: Codeunit "NoSeriesManagement";
            begin
            end;
        }
        field(7122032; "E-Mail Destination"; Text[250])
        {
            Caption = 'E-Mail Destination';
            ExtendedDatatype = EMail;
        }
        field(7122037; "Amount Including VAT"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Posted Service Line_LDR"."Amount Including VAT" WHERE("Document No." = FIELD("No.")));
            Caption = 'Amount Including VAT';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7122038; "Order Type"; Option)
        {
            Caption = 'Tipo Ordine Assistenza';
            Description = 'EVO FIELDEAS MODEN, ALQ con FMI,ALQ con FSI Extra Contra,FS Externo,FS Externo Extra Contrato,Fact. Externa,Oferta';
            OptionCaption = 'Internal Maintenance,Internal Maintenanze Extra Contract,External Maintenance,External Maintenanze Extra Contract,External Invoicing,From Service Quote';
            OptionMembers = FSI,FSIEC,FS,FSEC,FE,OFF;
        }
        field(7122039; "Interruption Reason"; Text[100])
        {
            Caption = 'Motivo Interruzione';
            Description = 'EVO FIELDEAS MODEN';
        }
        field(7122040; Amount; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Posted Service Line_LDR"."Amount" WHERE("Document No." = FIELD("No.")));
            Caption = 'Amount';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Customer No.", "Posting Date")
        {
        }
        key(Key3; "Contract No.", "Posting Date")
        {
        }
        key(Key4; "Responsibility Center", "Posting Date")
        {
        }
        key(Key5; "Posting Date")
        {
        }
        key(Key6; "Contract No.", "Review Contract Line No.", "Review Template No.", "Review No.")
        {
        }
        key(Key7; "Posting Date", "Finishing Date")
        {
        }
    }

    fieldgroups
    {
    }

    var
        PostCode: Record "Post Code";
        DimMgt: Codeunit "DimensionManagement";
        ItemTrackingMgt: Codeunit "Item Tracking Management";

    /// <summary>
    /// Navigate()
    /// </summary>
    procedure Navigate()
    begin

    end;

    /// <summary>
    /// LookupAdjmtValueEntries()
    /// </summary>
    procedure LookupAdjmtValueEntries(QtyType: Option General,Invoicing)
    var
        ItemLedgEntry: Record "Item Ledger Entry";
        ServiceLine: Record "Posted Service Line_LDR";
        ServiceShptLine: Record "Service Shipment Line";
        TempValueEntry: Record "Value Entry" temporary;
    begin
        ServiceLine.SETRANGE("Document No.", "No.");
        TempValueEntry.RESET;
        TempValueEntry.DELETEALL;

        IF ServiceLine.FINDSET THEN
            REPEAT
                IF (ServiceLine.Type = ServiceLine.Type::Item) AND (ServiceLine.Quantity <> 0) THEN
                    WITH ServiceShptLine DO BEGIN
                        SETCURRENTKEY("Order No.", "Order Line No.");
                        SETRANGE("Order No.", ServiceLine."Document No.");
                        SETRANGE("Order Line No.", ServiceLine."Line No.");
                        SETRANGE(Correction, FALSE);
                        IF QtyType = QtyType::Invoicing THEN
                            SETFILTER("Qty. Shipped Not Invoiced", '<>0');

                        IF FINDSET THEN
                            REPEAT
                                FilterPstdDocLnItemLedgEntries(ItemLedgEntry);
                                IF ItemLedgEntry.FINDSET THEN
                                    REPEAT
                                        CreateTempAdjmtValueEntries(TempValueEntry, ItemLedgEntry."Entry No.");
                                    UNTIL ItemLedgEntry.NEXT = 0;
                            UNTIL NEXT = 0;
                    END;
            UNTIL ServiceLine.NEXT = 0;
        PAGE.RUNMODAL(0, TempValueEntry);
    end;

    /// <summary>
    /// CreateTempAdjmtValueEntries()
    /// </summary>
    procedure CreateTempAdjmtValueEntries(var TempValueEntry: Record "Value Entry" temporary; ItemLedgEntryNo: Integer)
    var
        ValueEntry: Record "Value Entry";
    begin
        WITH ValueEntry DO BEGIN
            SETCURRENTKEY("Item Ledger Entry No.");
            SETRANGE("Item Ledger Entry No.", ItemLedgEntryNo);
            IF FINDSET THEN
                REPEAT
                    IF Adjustment THEN BEGIN
                        TempValueEntry := ValueEntry;
                        IF TempValueEntry.INSERT THEN;
                    END;
                UNTIL NEXT = 0;
        END;
    end;

    /// <summary>
    /// CheckInvoiceEntries()
    /// </summary>
    procedure CheckInvoiceEntries(PostServHeaderNo: Code[20]) InvoiceEntries: BoolEAN
    var
        ServLedgerEntryUsage: Record "Service Ledger Entry";
        ServLedgerEntrySale: Record "Service Ledger Entry";
    begin
        CLEAR(ServLedgerEntrySale);
        ServLedgerEntrySale.SETRANGE(ServLedgerEntrySale."Service Order No.", PostServHeaderNo);
        ServLedgerEntrySale.SETRANGE(ServLedgerEntrySale."Entry Type", ServLedgerEntrySale."Entry Type"::Sale);
        ServLedgerEntrySale.SETRANGE(ServLedgerEntrySale."Document Type", ServLedgerEntrySale."Document Type"::Invoice);
        IF ServLedgerEntrySale.FINDSET THEN
            InvoiceEntries := TRUE
        ELSE
            InvoiceEntries := FALSE;
    end;

    /// <summary>
    /// ShowDimensions()
    /// </summary>
    procedure ShowDimensions()
    begin
        //>> UPG2016_RPB Start
        DimMgt.ShowDimensionSet("Dimension Set ID", STRSUBSTNO('%1 %2', TABLECAPTION, "No."));
        //>> UPG2016_RPB End
    end;
}