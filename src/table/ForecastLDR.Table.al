/// <summary>
/// Table Forecast_LDR (ID 50030)
/// </summary>
table 50030 Forecast_LDR
{
    Caption = 'Forecast';

    fields
    {
        field(1; "No."; Code[10])
        {
            Caption = 'No.';

            trigger OnValidate()
            var
                PurchSetup: Record "Purchases & Payables Setup";
                NoSeriesMgt: Codeunit "NoSeriesManagement";
                ResponsibilityCenter: Record "Responsibility Center";
            begin
                IF "No." <> xRec."No." THEN BEGIN
                    PurchSetup.GET;
                    NoSeriesMgt.TestManual(PurchSetup."Forecast Nos._LDR");
                END;

                CLEAR(ResponsibilityCenter);
                IF ResponsibilityCenter.FINDFIRST THEN
                    VALIDATE(Delegation, ResponsibilityCenter.Code);
            end;
        }
        field(2; Delegation; Code[10])
        {
            Caption = 'Delegation';
            TableRelation = "Responsibility Center";

            trigger OnValidate()
            var
                ResponsibilityCenter: Record "Responsibility Center";
            begin
                IF ResponsibilityCenter.GET(Delegation) THEN
                    "Delegation description" := ResponsibilityCenter.Name;
            end;
        }
        field(3; "Delegation description"; Text[50])
        {
            Caption = 'Delegation description';
        }
        field(4; Annuality; Integer)
        {
            Caption = 'Annuality';
        }
        field(5; Number; Integer)
        {
            Caption = 'Number';
        }
        field(6; Status; Option)
        {
            Caption = 'State';
            OptionCaption = 'OPEN,CLOSED';
            OptionMembers = OPEN,CLOSED;
        }
        field(7; Nature; Code[10])
        {
            Caption = 'Nature';
            TableRelation = "Nature Forecast_LDR";

            trigger OnValidate()
            var
                NatureForecast: Record "Nature Forecast_LDR";
            begin
                IF NatureForecast.GET(Nature) THEN
                    "Nature description" := NatureForecast.Description;
            end;
        }
        field(8; "Nature description"; Text[50])
        {
            Caption = 'Nature description';
        }
        field(9; "Generates obligation"; BoolEAN)
        {
            Caption = 'Generates obligation';
        }
        field(10; "Obligation type"; Code[10])
        {
            Caption = 'Obligation type';
            TableRelation = "Obligation Types_LDR";

            trigger OnValidate()
            var
                ObligationTypes: Record "Obligation Types_LDR";
            begin
                IF ObligationTypes.GET("Obligation type") THEN
                    "Obligation description" := ObligationTypes.Description;
            end;
        }
        field(11; "Obligation description"; Text[50])
        {
            Caption = 'Obligation description';
        }
        field(12; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            TableRelation = Vendor;

            trigger OnValidate()
            var
                Vendor: Record "Vendor";
            begin
                IF Vendor.GET("Vendor No.") THEN BEGIN
                    "Vendor name" := Vendor.Name;
                    "Bank Forecast" := Vendor."Bank Forecast_LDR";
                END;
            end;
        }
        field(13; "Vendor name"; Text[50])
        {
            Caption = 'Vendor name';
        }
        field(14; "Document type"; Code[10])
        {
            Caption = 'Document type';
            TableRelation = "Payment Method";

            trigger OnValidate()
            var
                PaymentMethod: Record "Payment Method";
            begin
                IF PaymentMethod.GET("Document type") THEN
                    "Document description" := PaymentMethod.Description;
            end;
        }
        field(15; "Document description"; Text[50])
        {
            Caption = 'Document description';
        }
        field(16; "Summary declaration"; Option)
        {
            Caption = 'Summary declaration';
            OptionCaption = 'ANOTHER CHARGE,INVOICE,WITHOUT CHARGE';
            OptionMembers = "OTRO CARGO",FACTURA,"SIN CARGO";
        }
        field(17; "Forecast description"; Text[50])
        {
            Caption = 'Forecast description';
        }
        field(18; "AA Deferred int. expenses"; Code[10])
        {
            Caption = 'Deferred interest expenses AA';
            TableRelation = "G/L Account";

            trigger OnValidate()
            var
                GLAccount: Record "G/L Account";
            begin
                IF GLAccount.GET("AA Deferred int. expenses") THEN
                    "AA Deferres int. description" := GLAccount.Name;
            end;
        }
        field(19; "AA Deferres int. description"; Text[50])
        {
            Caption = 'AA Deferres int. description';
        }
        field(20; "No. of quotes"; Integer)
        {
            Caption = 'No. of quotes';

            trigger OnValidate()
            begin
                CalculateQuotes;
            end;
        }
        field(21; Periodicity; Integer)
        {
            Caption = 'Periodicity';

            trigger OnValidate()
            begin
                CalculateQuotes;
            end;
        }
        field(22; "Start date"; Date)
        {
            Caption = 'Start date';
        }
        field(23; "Last payment date"; Date)
        {
            Caption = 'Last payment date';
        }
        field(24; "Contract reference"; Code[20])
        {
            Caption = 'Contract reference';
        }
        field(25; "Net quote amount"; Decimal)
        {
            Caption = 'Net quote amount';

            trigger OnValidate()
            begin
                CalculateQuotes;
            end;
        }
        field(26; "VAT %"; Code[10])
        {
            Caption = 'VAT %';
            TableRelation = "VAT Product Posting Group";

            trigger OnValidate()
            begin
                CalculateQuotes;
            end;
        }
        field(27; "VAT base amount"; Decimal)
        {
            Caption = 'VAT base amount';
        }
        field(28; "Total quota amount"; Decimal)
        {
            Caption = 'Total quota amount';
        }
        field(29; "Total net amount"; Decimal)
        {
            Caption = 'Total net amount';
        }
        field(30; "Total VAT amount"; Decimal)
        {
            Caption = 'Total VAT amount';
        }
        field(31; "Total amount"; Decimal)
        {
            Caption = 'Total amount';
        }
        field(32; "Bank Forecast"; Code[20])
        {
            Caption = 'Bank forecast';
            TableRelation = "Bank Account";
        }
        field(33; "AA Bank interest"; Code[10])
        {
            Caption = 'AA Bank interest';
            TableRelation = "G/L Account";
        }
        field(34; "No. Series"; Code[10])
        {
            Caption = 'Nos. Serie';
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; Delegation, "Bank Forecast", "Vendor No.")
        {
        }
        key(Key3; Delegation, "Vendor No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        PurchSetup: Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit "NoSeriesManagement";
        ResponsibilityCenter: Record "Responsibility Center";
    begin
        IF "No." = '' THEN BEGIN
            PurchSetup.GET;
            PurchSetup.TESTFIELD("Forecast Nos._LDR");
            NoSeriesMgt.InitSeries(PurchSetup."Forecast Nos._LDR", xRec."No. Series", 0D, "No.", "No. Series");

            CLEAR(ResponsibilityCenter);
            IF ResponsibilityCenter.FINDFIRST THEN
                VALIDATE(Delegation, ResponsibilityCenter.Code);
        END;
    end;

    /// <summary>
    /// AssistEdit()
    /// </summary>
    procedure AssistEdit(OldForecast: Record "Forecast_LDR"): BoolEAN
    var
        Forecast: Record "Forecast_LDR";
        PurchSetup: Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit "NoSeriesManagement";
    begin
        WITH Forecast DO BEGIN
            Forecast := Rec;
            PurchSetup.GET;
            PurchSetup.TESTFIELD("Forecast Nos._LDR");
            IF NoSeriesMgt.SelectSeries(PurchSetup."Forecast Nos._LDR", OldForecast."No. Series", "No. Series") THEN BEGIN
                NoSeriesMgt.SetSeries("No.");
                Rec := Forecast;
                EXIT(TRUE);
            END;
        END;
    end;

    /// <summary>
    /// CalculateQuotes()
    /// </summary>
    local procedure CalculateQuotes()
    var
        VATPosting: Record "VAT Posting Setup";
        Vendor: Record "Vendor";
    begin
        IF Vendor.GET("Vendor No.") THEN
            VATPosting.SETRANGE("VAT Bus. Posting Group", Vendor."VAT Bus. Posting Group");
        VATPosting.SETRANGE("VAT Prod. Posting Group", "VAT %");
        IF VATPosting.FINDFIRST AND ("Net quote amount" > 0) THEN BEGIN
            "VAT base amount" := "Net quote amount";
            "Total quota amount" := ROUND("Net quote amount" * (1 + VATPosting."VAT %" / 100), 0.01);
            "Total VAT amount" := "No. of quotes" * ROUND("Net quote amount" * VATPosting."VAT %" / 100, 0.01);
            "Total net amount" := "No. of quotes" * "Net quote amount";
            "Total amount" := "No. of quotes" * ROUND("Net quote amount" * (1 + VATPosting."VAT %" / 100), 0.01);
        END;
    end;
}