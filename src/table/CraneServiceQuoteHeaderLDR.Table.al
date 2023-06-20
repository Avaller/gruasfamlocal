/// <summary>
/// Table Crane Service Quote Header_LDR (ID 50020)
/// </summary>
table 50020 "Crane Service Quote Header_LDR"
{
    // //VAC - CAS-30649-C4G2 - 12-05-2021 - Se amplia campo (4)Customer Name de 50 a 100, igual que en Customer

    Caption = 'Crane Service Quote Header';
    DrillDownPageID = "Crane Service Quotes";
    LookupPageID = "Crane Service Quotes";

    fields
    {
        field(1; "Quote no."; Code[20])
        {
            Caption = 'Quote no.';
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(3; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer;

            trigger OnValidate()
            var
                Cust: Record "Customer";
            begin
                Cust.GET("Customer No.");

                IF "Quote Type" = "Quote Type"::General THEN
                    TestCustGeneralQuote("Customer No.");

                "Salesperson Code" := Cust."Salesperson Code";
                "Responsability Center" := Cust."Responsibility Center";
                "Invoice Period" := Cust."Invoice Period_LDR";
            end;
        }
        field(4; "Customer Name"; Text[100])
        {
            CalcFormula = Lookup("Customer"."Name" WHERE("No." = FIELD("Customer No.")));
            Caption = 'Customer Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5; "Contact No."; Code[20])
        {
            Caption = 'Contact No.';
            TableRelation = Contact;

            trigger OnLookup()
            var
                Cont: Record "Contact";
                ContBusinessRelation: Record "Contact Business Relation";
            begin
                IF "Customer No." <> '' THEN
                    IF Cont.GET("Contact No.") THEN
                        Cont.SETRANGE("Company No.", Cont."Company No.")
                    ELSE BEGIN
                        ContBusinessRelation.RESET;
                        ContBusinessRelation.SETCURRENTKEY("Link to Table", "No.");
                        ContBusinessRelation.SETRANGE("Link to Table", ContBusinessRelation."Link to Table"::Customer);
                        ContBusinessRelation.SETRANGE("No.", "Customer No.");
                        IF ContBusinessRelation.FINDFIRST THEN
                            Cont.SETRANGE("Company No.", ContBusinessRelation."Contact No.")
                        ELSE
                            Cont.SETRANGE("No.", '');
                    END;

                IF "Contact No." <> '' THEN
                    IF Cont.GET("Contact No.") THEN;
                IF PAGE.RUNMODAL(0, Cont) = ACTION::LookupOK THEN BEGIN
                    xRec := Rec;
                    VALIDATE("Contact No.", Cont."No.");
                END;
            end;

            trigger OnValidate()
            var
                Cont: Record "Contact";
                ContBusinessRelation: Record "Contact Business Relation";
            begin
                IF ("Customer No." <> '') AND ("Contact No." <> '') THEN BEGIN
                    Cont.GET("Contact No.");
                    ContBusinessRelation.RESET;
                    ContBusinessRelation.SETCURRENTKEY("Link to Table", "No.");
                    ContBusinessRelation.SETRANGE("Link to Table", ContBusinessRelation."Link to Table"::Customer);
                    ContBusinessRelation.SETRANGE("No.", "Customer No.");
                    IF ContBusinessRelation.FINDFIRST AND
                       (ContBusinessRelation."Contact No." <> Cont."Company No.")
                    THEN
                        ERROR(Text038, Cont."No.", Cont.Name, "Customer No.");
                END;

                UpdateCust("Contact No.");
            end;
        }
        field(6; "Contact Name"; Text[50])
        {
            Caption = 'Contact Name';
        }
        field(7; "Ship-to Address Code"; Code[10])
        {
            Caption = 'Ship-to Address Code';
            TableRelation = "Ship-to Address"."Code" WHERE("Customer No." = FIELD("Customer No."));
        }
        field(8; "Ship-to Address Name"; Text[50])
        {
            CalcFormula = Lookup("Ship-to Address"."Name" WHERE("Customer No." = FIELD("Customer No."),
                                                               "Code" = FIELD("Ship-to Address Code")));
            Caption = 'Ship-to Address Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(9; "Quote Type"; Option)
        {
            Caption = 'Quote Type';
            OptionCaption = 'General,Tariff,,Forfait';
            OptionMembers = General,Tariff,"Sprecial Operations",Forfait;

            trigger OnValidate()
            begin
                IF "Quote Type" = "Quote Type"::General THEN
                    TestCustGeneralQuote("Customer No.");
            end;
        }
        field(10; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
        }
        field(11; "Ending Date"; Date)
        {
            Caption = 'Ending Date';
        }
        field(12; "Quote Date"; Date)
        {
            Caption = 'Quote Date';
        }
        field(13; "Quote Status"; Option)
        {
            Caption = 'Quote Status';
            OptionCaption = 'Open,Blocked,Rejected';
            OptionMembers = Open,Blocked,Rejected;
        }
        field(14; "External document No."; Code[20])
        {
            Caption = 'External document No.';
        }
        field(15; "Salesperson Code"; Code[10])
        {
            Caption = 'Salesperson Code';
            TableRelation = "Salesperson/Purchaser"."Code";
        }
        field(16; "Responsability Center"; Code[10])
        {
            Caption = 'Responsability Center';
            TableRelation = "Responsibility Center";
        }
        field(17; Historical; BoolEAN)
        {
            Caption = 'Historical';
        }
        field(18; "Rate Code"; Code[20])
        {
            Caption = 'Resource Rate Code';
            TableRelation = "Service Item Rate Header_LDR"."Code";
        }
        field(19; "Rate Description"; Text[50])
        {
            CalcFormula = Lookup("Service Item Rate Header_LDR"."Description" WHERE("Code" = FIELD("Rate Code")));
            Caption = 'Rate Description';
            FieldClass = FlowField;
        }
        field(20; "Apply Saturday Surcharge"; BoolEAN)
        {
            Caption = 'Apply Saturday Surcharge';
        }
        field(21; "Apply Festive Surcharge"; BoolEAN)
        {
            Caption = 'Apply Festive Surcharge';
        }
        field(22; "Apply Night Surcharge"; BoolEAN)
        {
            Caption = 'Apply Night Surcharge';
        }
        field(23; "Apply Minimum"; BoolEAN)
        {
            Caption = 'Apply Minimun';
        }
        field(24; "Invoice Displacement"; BoolEAN)
        {
            Caption = 'Bill Displacements';
        }
        field(25; "Fill minimum with Displ."; BoolEAN)
        {
            Caption = 'Complete minimun with Displ.';
        }
        field(26; "Invoice Exit Fee"; BoolEAN)
        {
            Caption = 'Bill Exit Fee';
        }
        field(27; "Apply Standard KMs"; BoolEAN)
        {
            Caption = 'Apply Standard KMs';
        }
        field(28; "Displacement Type"; Option)
        {
            Caption = 'Displacement Type';
            OptionCaption = 'KMs,Hours';
            OptionMembers = KMs,Hours;
        }
        field(29; "Displacement %"; Decimal)
        {
            Caption = 'Displacement %';
            MaxValue = 100;
            MinValue = 0;
        }
        field(30; "Displ. Calculation Type"; Option)
        {
            Caption = 'Calc Type';
            OptionCaption = 'Standard,Especifies';
            OptionMembers = Standard,Especifies;

            trigger OnValidate()
            begin
                //TESTFIELD("Displacement Type","Displacement Type"::Hours);
            end;
        }
        field(31; "KM Franchise"; Decimal)
        {
            Caption = 'Franchise KMs';
        }
        field(32; "KM/Time"; Decimal)
        {
            Caption = 'Applicable KMs Hours';

            trigger OnValidate()
            begin
                //TESTFIELD("Apply Standard KMs",FALSE);
            end;
        }
        field(33; "Displacement Amount"; Decimal)
        {
            Caption = 'Displacement amount';

            trigger OnValidate()
            begin
                //TESTFIELD("Apply Standard KMs",FALSE);
            end;
        }
        field(34; "Group Invoices"; BoolEAN)
        {
            Caption = 'Group Invoices';
        }
        field(35; "Inv. Group Code"; Code[10])
        {
            Caption = 'Inv. Group Code';
            TableRelation = "Servic Contra Invoic Group_LDR"."No.";
        }
        field(36; "Invoice Period"; Option)
        {
            Caption = 'Invoice Period';
            OptionCaption = ' ,Forthnightly,Monthly';
            OptionMembers = Week,TwoWeeks,Month,"Two Months",Quarter,"Half Year",Year;
        }
        field(37; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(39; Retained; BoolEAN)
        {
            Caption = 'Retained';

            trigger OnValidate()
            var
                txtRetained: Label 'Debe introducir Nº Pedido Cliente';
                Cust: Record "Customer";
            begin
                IF Cust.GET("Customer No.") AND (Cust."Invoicing Type_LDR" = Cust."Invoicing Type_LDR"::Order) THEN
                    IF (NOT Retained) AND ("Customer Order No." = '') THEN BEGIN
                        MESSAGE(txtRetained);
                        Retained := TRUE;
                    END;
            end;
        }
        field(40; "Customer Order No."; Code[20])
        {
            Caption = 'Customer Order No.';

            trigger OnValidate()
            begin
                IF "Customer Order No." = '' THEN
                    Retained := TRUE
                ELSE BEGIN
                    Retained := FALSE;
                END;
            end;
        }
        field(41; "Invoicing Type"; Option)
        {
            Caption = 'Invoicing Type';
            OptionCaption = 'Work,Offer,Standalone,Order';
            OptionMembers = Work,Offer,Standalone,"Order";
        }
        field(42; "Skip Invoice split on Orders"; BoolEAN)
        {
            Caption = 'Skip Invoice Periods split on Orders';
        }
        field(43; "Platform Quote"; BoolEAN)
        {
            Caption = 'Platform Quote';
        }
        field(44; "Description 2"; Text[50])
        {
            Caption = 'Description 2';
        }
        field(45; "Forfait Distributed"; BoolEAN)
        {
            Caption = 'Forfait Distributed';
        }
    }

    keys
    {
        key(Key1; "Quote no.")
        {
            Clustered = true;
        }
        key(Key2; "Ending Date")
        {
        }
        key(Key3; "Invoicing Type", "Ship-to Address Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        CraneServiceQuoteOpLine: Record "Crane Servic Quote Op. Lin_LDR";
        ServiceCommentLine: Record "Service Comment Line";
        ServHeader: Record "Service Header";
        ServItemLine: Record "Service Item Line";
        PostedServHeader: Record "Posted Service Header_LDR";
        PostedServItemLine: Record "Posted Service Item Line_LDR";
    begin
        //Comprobaciones
        //
        TESTFIELD("Quote Status", "Quote Status"::Open);

        //Comprobar no haber pedidos
        CLEAR(ServHeader);
        ServHeader.SETRANGE("Crane Service Quote No._LDR", Rec."Quote no.");
        IF ServHeader.FINDFIRST THEN
            ERROR(Text003, TABLECAPTION, "Quote no.", ServHeader.TABLECAPTION);

        CLEAR(PostedServHeader);
        PostedServHeader.SETRANGE("Crane Service Quote No.", Rec."Quote no.");
        IF PostedServHeader.FINDFIRST THEN
            ERROR(Text003, TABLECAPTION, "Quote no.", PostedServHeader.TABLECAPTION);

        CLEAR(CraneServiceQuoteOpLine);
        CraneServiceQuoteOpLine.SETRANGE("Quote No.", "Quote no.");
        CraneServiceQuoteOpLine.DELETEALL(TRUE);

        CLEAR(ServiceCommentLine);
        ServiceCommentLine.SETRANGE("Table Name", ServiceCommentLine."Table Name"::"Service Header");
        ServiceCommentLine.SETRANGE("Table Subtype", 0);
        ServiceCommentLine.SETRANGE("No.", "Quote no.");
        ServiceCommentLine.SETRANGE(Type, ServiceCommentLine.Type::General);
        ServiceCommentLine.SETRANGE("Table Line No.", 0);
        ServiceCommentLine.DELETEALL(TRUE);
    end;

    trigger OnInsert()
    var
        Customer: Record "Customer";
    begin
        CraneSetup.GET;
        IF "Quote no." = '' THEN BEGIN
            TestNoSeries;
            NoSeriesMgt.InitSeries(CraneSetup."Crane Quote Nos.", xRec."No. Series", 0D, "Quote no.", "No. Series");
        END;

        //ACICATECH AJGONZALEZ
        //RQ19.12.022 - Asignacion del periodo de facturacion
        IF Customer.GET("Customer No.") THEN BEGIN
            IF Customer."Invoice Period_LDR" = Customer."Invoice Period_LDR"::Fortnightly THEN // RQ19.25.128 - DPGARCIA - Los Option de Oferta Serv. no coinciden con Cliente, hay que traducirlos
                VALIDATE("Invoice Period", "Invoice Period"::TwoWeeks)
            ELSE
                VALIDATE("Invoice Period", "Invoice Period"::Month);
        END;
        //FIN AJGONZALEZ
    end;

    trigger OnModify()
    begin
        TESTFIELD("Quote Status", "Quote Status"::Open);
    end;

    var
        Text038: Label 'Contact %1 %2 is related to a different company than customer %3.', Comment = '%1=Contact number;%2=Contact name;%3=Customer number;';
        Text037: Label 'Contact %1 %2 is not related to customer %3.', Comment = '%1=Contact number;%2=Contact name;%3=Customer number;';
        SkipContact: BoolEAN;
        Text039: Label 'Contact %1 %2 is not related to a customer.', Comment = '%1=Contact number;%2=Contact name;';
        ServSetup: Record "Service Mgt. Setup";
        NoSeriesMgt: Codeunit "NoSeriesManagement";
        Text051: Label 'Crane Service Quote %1 already exist';
        Text001: Label 'There can only be one General Type Quote by Customer';
        Text002: Label 'Rejecting a Crane Service Quote will cause to automatically send them to historical, so it can''t be used anymore for creating another Order. Are you sure you want to continue?';
        CraneSetup: Record "Crane Mgt. Setup_LDR";
        Text003: Label '%1 %2 can''t be deleted because there are %3 related.';
        Text004: Label 'It''s not possible to recover the quote from a posted quote once the distribution has been done.';

    /// <summary>
    /// UpdateCust()
    /// </summary>
    local procedure UpdateCust(ContactNo: Code[20])
    var
        ContBusinessRelation: Record "Contact Business Relation";
        Cust: Record "Customer";
        Cont: Record "Contact";
    begin
        IF Cont.GET(ContactNo) THEN BEGIN
            "Contact No." := Cont."No.";
        END ELSE BEGIN
            "Contact Name" := '';
            EXIT;
        END;

        IF Cont.Type = Cont.Type::Person THEN
            "Contact Name" := Cont.Name
        ELSE
            IF Cust.GET("Customer No.") THEN
                "Contact Name" := Cust.Contact
            ELSE
                "Contact Name" := '';

        ContBusinessRelation.RESET;
        ContBusinessRelation.SETCURRENTKEY("Link to Table", "No.");
        ContBusinessRelation.SETRANGE("Link to Table", ContBusinessRelation."Link to Table"::Customer);
        ContBusinessRelation.SETRANGE("Contact No.", Cont."Company No.");
        IF ContBusinessRelation.FINDFIRST THEN BEGIN
            IF ("Customer No." <> '') AND
               ("Customer No." <> ContBusinessRelation."No.")
            THEN
                ERROR(Text037, Cont."No.", Cont.Name, "Customer No.");

            IF "Customer No." = '' THEN BEGIN
                SkipContact := TRUE;
                VALIDATE("Customer No.", ContBusinessRelation."No.");
                SkipContact := FALSE;
            END;
        END ELSE
            ERROR(Text039, Cont."No.", Cont.Name);
    end;

    /// <summary>
    /// TestNoSeries()
    /// </summary>
    local procedure TestNoSeries()
    begin
        CraneSetup.TESTFIELD("Crane Quote Nos.");
    end;

    /// <summary>
    /// AssistEdit()
    /// </summary>
    procedure AssistEdit(OldQuoteHeader: Record "Crane Service Quote Header_LDR"): BoolEAN
    var
        QuoteHeader2: Record "Crane Service Quote Header_LDR";
        QuoteHeader: Record "Crane Service Quote Header_LDR";
    begin
        WITH QuoteHeader DO BEGIN
            COPY(Rec);
            ServSetup.GET;
            TestNoSeries;
            IF NoSeriesMgt.SelectSeries(GetNoSeriesCode, OldQuoteHeader."No. Series", "No. Series") THEN BEGIN

                NoSeriesMgt.SetSeries("Quote no.");
                IF QuoteHeader2.GET("Quote no.") THEN
                    ERROR(Text051, "Quote no.");
                Rec := QuoteHeader;
                EXIT(TRUE);
            END;
        END;
    end;

    /// <summary>
    /// GetNoSeriesCode()
    /// </summary>
    local procedure GetNoSeriesCode(): Code[10]
    begin
        EXIT(CraneSetup."Crane Quote Nos.");
    end;

    /// <summary>
    /// TestCustGeneralQuote()
    /// </summary>
    procedure TestCustGeneralQuote(CustNo: Code[20])
    var
        CraneQuote: Record "Crane Service Quote Header_LDR";
    begin
        CLEAR(CraneQuote);
        CraneQuote.SETRANGE("Customer No.", CustNo);
        CraneQuote.SETRANGE("Quote Type", CraneQuote."Quote Type"::General);
        CraneQuote.SETRANGE(Historical, FALSE);
        CraneQuote.SETRANGE("Platform Quote", Rec."Platform Quote");
        IF CraneQuote.FINDFIRST THEN
            ERROR(Text001);
    end;

    /// <summary>
    /// LockQuote()
    /// </summary>
    procedure LockQuote()
    begin
        "Quote Status" := "Quote Status"::Blocked;
        MODIFY;
    end;

    /// <summary>
    /// OpenQuote()
    /// </summary>
    procedure OpenQuote()
    begin
        "Quote Status" := "Quote Status"::Open;
        MODIFY;
    end;

    /// <summary>
    /// RejectQuote()
    /// </summary>
    procedure RejectQuote()
    begin
        //Chequeos
        TESTFIELD("Quote Status", "Quote Status"::Open);

        IF NOT CONFIRM(Text002, FALSE) THEN
            ERROR('');

        "Quote Status" := "Quote Status"::Rejected;
        Historical := TRUE;
        MODIFY;
    end;

    /// <summary>
    /// SendToArchive()
    /// </summary>
    procedure SendToArchive()
    var
        ServiceQuoteMgt: Codeunit "Service Quote Mgt._LDR";
    begin
        // RQ19.26.582 - DPGARCIA
        IF "Quote Type" = "Quote Type"::Forfait THEN BEGIN
            ServiceQuoteMgt.ForfaitDistribution(Rec);
        END;

        //Chequeos
        Historical := TRUE;
        MODIFY;
    end;

    /// <summary>
    /// RecoverQuote()
    /// </summary>
    procedure RecoverQuote()
    begin
        IF ("Quote Type" = "Quote Type"::Forfait) AND ("Forfait Distributed") THEN
            ERROR(Text004);

        "Quote Status" := "Quote Status"::Open;
        Historical := FALSE;
        MODIFY;
    end;
}