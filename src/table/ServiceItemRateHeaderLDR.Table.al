/// <summary>
/// Table Service Item Rate Header_LDR (ID 50014)
/// </summary>
table 50014 "Service Item Rate Header_LDR"
{
    Caption = 'Service Item Tariff Header';
    LookupPageID = "Service Item Rate List";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Rate Code';
        }
        field(2; Description; Text[60])
        {
            Caption = 'Rate Description';
        }
        field(3; "Valid Start Date"; Date)
        {
            Caption = 'Valid Start Date';
            NotBlank = true;

            trigger OnValidate()
            begin
                IF ("Valid End Date" <> 0D) AND ("Valid Start Date" <> 0D) AND ("Valid End Date" < "Valid Start Date") THEN
                    ERROR(Text002, FIELDCAPTION("Valid Start Date"), FIELDCAPTION("Valid End Date"));
            end;
        }
        field(4; "Valid End Date"; Date)
        {
            Caption = 'Valid end date';
            NotBlank = true;

            trigger OnValidate()
            begin
                IF ("Valid End Date" <> 0D) AND ("Valid Start Date" <> 0D) AND ("Valid End Date" < "Valid Start Date") THEN
                    ERROR(Text001, FIELDCAPTION("Valid End Date"), FIELDCAPTION("Valid Start Date"));
            end;
        }
        field(5; "Workday Starting Time"; Time)
        {
            Caption = 'Start Work';
            NotBlank = true;

            trigger OnValidate()
            begin
                IF "Workday Starting Time" = 0T THEN
                    ERROR(FORMAT("Workday Starting Time"));
            end;
        }
        field(6; "Workday Ending Time"; Time)
        {
            Caption = 'End Date';
            NotBlank = true;

            trigger OnValidate()
            begin
                IF "Workday Ending Time" = 0T THEN
                    ERROR(FORMAT("Workday Ending Time"));
            end;
        }
        field(7; "Saturday Starting Time"; Time)
        {
            Caption = 'Saturday Start';
        }
        field(8; "Saturday Ending Time"; Time)
        {
            Caption = 'Saturday End';
        }
        field(9; "Holiday Starting Time"; Time)
        {
            Caption = 'Holiday Start';
        }
        field(10; "Holiday Ending Time"; Time)
        {
            Caption = 'Holiday End';
        }
        field(11; "Workday Night Starting Time"; Time)
        {
            Caption = 'Night Start Work';
            NotBlank = true;

            trigger OnValidate()
            begin
                IF "Workday Night Starting Time" = 0T THEN
                    ERROR(FORMAT("Workday Night Starting Time"));
            end;
        }
        field(12; "Workday Night Ending Time"; Time)
        {
            Caption = 'Night End Work';
            NotBlank = true;

            trigger OnValidate()
            begin
                IF "Workday Night Ending Time" = 0T THEN
                    ERROR(FORMAT("Workday Night Ending Time"));
            end;
        }
        field(13; "Saturday Night Starting Time"; Time)
        {
            Caption = 'Saturday Night Start';
        }
        field(14; "Saturday Night Ending Time"; Time)
        {
            Caption = 'Saturday Night End';
        }
        field(15; "Holiday Night Starting Time"; Time)
        {
            Caption = 'Holiday Night Start';
        }
        field(16; "Holiday Night Ending Time"; Time)
        {
            Caption = 'Holiday Night End';
        }
        field(17; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(18; Status; Option)
        {
            Caption = 'Tariff Status';
            OptionCaption = 'Open,Locked';
            OptionMembers = Open,Locked;
        }
        field(19; "Source Code"; Code[20])
        {
            Caption = 'Source Rate Code';
        }
        field(20; ResourcePriceFactor; Decimal)
        {
            Caption = 'Resource Price Factor';
        }
        field(21; SmallCranePriceFactor; Decimal)
        {
            Caption = 'Small Crane Price Factor';
        }
        field(22; BigCranePriceFactor; Decimal)
        {
            Caption = 'Big Crane Price Factor';
        }
        field(23; TruckPriceFactor; Decimal)
        {
            Caption = 'TruckPriceFactor';
        }
        field(24; PlatformPriceFactor; Decimal)
        {
            Caption = 'PlatformPriceFactor';
        }
        field(25; SourceCompany; Text[30])
        {
            Caption = 'Source Company';
        }
        field(26; TargetCompamy; Text[30])
        {
            Caption = 'Target Compamy';
        }
        field(27; CraneTruckPriceFactor; Decimal)
        {
            Caption = 'Crane-Truck Price Factor';
        }
        field(28; NewInitialdate; Date)
        {
            Caption = 'New Initial Date';
        }
        field(29; NewEndingDate; Date)
        {
            Caption = 'New Ending Date';
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        ServiceItemResourceLine: Record "Servic Item Rat Lin - Res_LDR";
        ServiceItemBreakdownLine: Record "Servic Item Rat Li - Crane_LDR";
        ServiceItemPlatformLine: Record "Servic Item Rat Lin - Plat_LDR";
        CraneServQOpInvGLine: Record "Crane Serv Q Op Inv G Line_LDR";
        ServiceContractLine: Record "Service Contract Line";
        ServiceItemLine: Record "Service Item Line";
    begin
        //Comprobaciones

        //No Ofertas Grua con tarifa
        CLEAR(CraneServQOpInvGLine);
        CraneServQOpInvGLine.SETRANGE("Rate No.", Code);
        IF CraneServQOpInvGLine.FINDFIRST THEN
            ERROR(Text003, TABLECAPTION, Code, CraneServQOpInvGLine.TABLECAPTION);

        //No PS con tarifa
        CLEAR(ServiceItemLine);
        ServiceItemLine.SETRANGE("Document Type", ServiceItemLine."Document Type"::Order);
        ServiceItemLine.SETRANGE("Service Item Tariff No._LDR", Code);
        IF ServiceItemLine.FINDFIRST THEN
            ERROR(Text003, TABLECAPTION, Code, ServiceItemLine.TABLECAPTION);

        //No contratos con tarifa
        CLEAR(ServiceContractLine);
        ServiceContractLine.SETRANGE("Service Item Tariff No._LDR", Code);
        ServiceContractLine.SETRANGE(Historical_LDR, FALSE);
        IF ServiceContractLine.FINDFIRST THEN
            ERROR(Text003, TABLECAPTION, Code, ServiceContractLine.TABLECAPTION);

        //Borrar en cascada
        CLEAR(ServiceItemBreakdownLine);
        ServiceItemBreakdownLine.SETRANGE(Code, Code);
        ServiceItemBreakdownLine.DELETEALL(TRUE);

        CLEAR(ServiceItemPlatformLine);
        ServiceItemPlatformLine.SETRANGE(Code, Code);
        ServiceItemPlatformLine.DELETEALL(TRUE);

        CLEAR(ServiceItemResourceLine);
        ServiceItemResourceLine.SETRANGE(Code, Code);
        ServiceItemResourceLine.DELETEALL(TRUE);
    end;

    trigger OnInsert()
    begin

        ServSetup.GET;
        IF Code = '' THEN BEGIN
            CraneSetup.GET;
            CraneSetup.TESTFIELD("Service Item Tariff Nos.");
            NoSeriesMgt.InitSeries(CraneSetup."Service Item Tariff Nos.", xRec."No. Series", 0D, Code, "No. Series");
        END;
    end;

    trigger OnModify()
    begin
        TESTFIELD(Status, Status::Open);
    end;

    var
        Text001: Label '%1 must be greater than %2';
        Text002: Label '%1 must be lesser than %2';
        NoSeriesMgt: Codeunit "NoSeriesManagement";
        ServSetup: Record "Service Mgt. Setup";
        Text003: Label '%1 %2 can''t be deleted because there are %3 related.';
        CraneSetup: Record "Crane Mgt. Setup_LDR";

    /// <summary>
    /// AssistEdit()
    /// </summary>
    procedure AssistEdit(OldTarifHeader: Record "Service Item Rate Header_LDR"): BoolEAN
    var
        TarifHeader: Record "Service Item Rate Header_LDR";
    begin
        WITH TarifHeader DO BEGIN
            TarifHeader := Rec;
            CraneSetup.GET;
            CraneSetup.TESTFIELD("Service Item Tariff Nos.");
            IF NoSeriesMgt.SelectSeries(CraneSetup."Service Item Tariff Nos.", OldTarifHeader."No. Series", "No. Series") THEN BEGIN
                NoSeriesMgt.SetSeries(Code);
                Rec := TarifHeader;
                EXIT(TRUE);
            END;
        END;
    end;

    /// <summary>
    /// LockTariff()
    /// </summary>
    procedure LockTariff()
    begin

        TESTFIELD("Valid Start Date");
        TESTFIELD("Valid End Date");

        Status := Status::Locked;
        MODIFY;
    end;

    /// <summary>
    /// OpenTariff()
    /// </summary>
    procedure OpenTariff()
    begin
        Status := Status::Open;
        MODIFY;
    end;

    /// <summary>
    /// SetDefaultTimes()
    /// </summary>
    procedure SetDefaultTimes()
    begin
        "Workday Starting Time" := CraneSetup."Standard Starting Time";
        "Workday Ending Time" := CraneSetup."Standard Ending Time";
        "Workday Night Starting Time" := CraneSetup."Standard Ending Time";
        "Workday Night Ending Time" := CraneSetup."Standard Starting Time";

        "Saturday Starting Time" := CraneSetup."Standard Starting Time";
        "Saturday Ending Time" := CraneSetup."Standard Ending Time";
        "Saturday Night Starting Time" := CraneSetup."Standard Ending Time";
        "Saturday Night Ending Time" := CraneSetup."Standard Starting Time";

        "Holiday Starting Time" := CraneSetup."Standard Starting Time";
        "Holiday Ending Time" := CraneSetup."Standard Ending Time";
        "Holiday Night Starting Time" := CraneSetup."Standard Ending Time";
        "Holiday Night Ending Time" := CraneSetup."Standard Starting Time";
    end;
}