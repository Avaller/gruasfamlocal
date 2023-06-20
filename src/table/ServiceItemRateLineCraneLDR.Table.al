/// <summary>
/// Table Servic Item Rat Li - Crane_LDR (ID 50016)
/// </summary>
table 50016 "Servic Item Rat Li - Crane_LDR"
{
    Caption = 'Crane Lines';
    Description = 'ENU=Service Item Tariff Line - Crane;ESP=Linea de Tarifa de Producto de Servicio - Grua';
    LookupPageID = "Serv. Item Rate Subfo. - Crane";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(2; "Invoice Group No."; Code[10])
        {
            Caption = 'Invoice Group No.';
            NotBlank = true;
            TableRelation = "Service Item Invoice Group_LDR"."Code" WHERE("Group Type" = CONST("Crane"));

            trigger OnValidate()
            var
                ServInvGroup: Record "Service Item Invoice Group_LDR";
            begin
                ServInvGroup.GET("Invoice Group No.");
                "Print Order" := ServInvGroup."Print Order";
            end;
        }
        field(3; "KM Price"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'KM Price';
        }
        field(4; "Min working Time"; Decimal)
        {
            Caption = 'Min working Time';
            DecimalPlaces = 0 : 2;
        }
        field(5; "Hour Price"; Decimal)
        {
            Caption = 'Hour Price';

            trigger OnValidate()
            begin
                UpdatePrices;
            end;
        }
        field(6; "Stop Hour Price"; Decimal)
        {
            Caption = 'Stop Hour Price';
            Editable = true;
        }
        field(7; "% Night Increment"; Decimal)
        {
            Caption = '% Night Increment';
            DecimalPlaces = 0 : 2;

            trigger OnValidate()
            begin
                UpdatePrices;
            end;
        }
        field(8; "Night Hour Price"; Decimal)
        {
            Caption = 'Night Hour Price';
            Editable = false;
        }
        field(9; "Min Night Hours"; Decimal)
        {
            Caption = 'Min Night Hours';
            DecimalPlaces = 0 : 2;
        }
        field(10; "Exit Fee Price"; Decimal)
        {
            Caption = 'Exit Fee Price';
        }
        field(11; "Min Saturday Hours"; Decimal)
        {
            Caption = 'Min Saturday Hours';
            DecimalPlaces = 0 : 2;
        }
        field(12; "% Saturday Increment"; Decimal)
        {
            Caption = '% Saturday Increment';
            DecimalPlaces = 0 : 2;

            trigger OnValidate()
            begin
                UpdatePrices;
            end;
        }
        field(13; "Saturday Hour Price"; Decimal)
        {
            Caption = 'Saturday Hour Price';
            Editable = false;
        }
        field(14; "% Saturday Stop Increment"; Decimal)
        {
            Caption = '% Saturday Stop Increment';
            DecimalPlaces = 0 : 2;

            trigger OnValidate()
            begin
                UpdatePrices;
            end;
        }
        field(15; "Saturday Stop Hour Price"; Decimal)
        {
            Caption = 'Saturday Stop Hour Price';
            Editable = false;
        }
        field(16; "% Saturday Night Increment"; Decimal)
        {
            Caption = '% Saturday Night Increment';
            DecimalPlaces = 0 : 2;
        }
        field(17; "Saturday Nigth Hour Price"; Decimal)
        {
            Caption = 'Saturday Nigth Hour Price';
            Editable = false;
        }
        field(18; "% Saturday Exit Fee Increment"; Decimal)
        {
            Caption = '% Saturday Exit Fee Increment';
            DecimalPlaces = 0 : 2;

            trigger OnValidate()
            begin
                UpdatePrices;
            end;
        }
        field(19; "Saturday Exit Fee Price"; Decimal)
        {
            Caption = 'Saturday Exit Fee Price';
            Editable = false;
        }
        field(20; "Min Holiday Time"; Decimal)
        {
            Caption = 'Min Holiday Time';
            DecimalPlaces = 0 : 2;
        }
        field(21; "% Holiday Increment"; Decimal)
        {
            Caption = '% Holiday Increment';
            DecimalPlaces = 0 : 2;

            trigger OnValidate()
            begin
                UpdatePrices;
            end;
        }
        field(22; "Holiday Hour Price"; Decimal)
        {
            Caption = 'Holiday Hour Price';
            Editable = false;
        }
        field(23; "% Holiday Stop Increment"; Decimal)
        {
            Caption = '% Holiday Stop Increment';
            DecimalPlaces = 0 : 2;

            trigger OnValidate()
            begin
                UpdatePrices;
            end;
        }
        field(24; "Holiday Stop Hour Price"; Decimal)
        {
            Caption = 'Holiday Stop Hour Price';
            Editable = false;
        }
        field(25; "% Holiday Night Increment"; Decimal)
        {
            Caption = '% Holiday Night Increment';
            DecimalPlaces = 0 : 2;

            trigger OnValidate()
            begin
                UpdatePrices;
            end;
        }
        field(26; "Holiday Night Hour Price"; Decimal)
        {
            Caption = 'Holiday Night Hour Price';
            Editable = false;
        }
        field(27; "% Holiday Exit Fee Increment"; Decimal)
        {
            Caption = '% Holiday Exit Fee Increment';
            DecimalPlaces = 0 : 2;

            trigger OnValidate()
            begin
                UpdatePrices;
            end;
        }
        field(28; "Holiday Exit Fee Price"; Decimal)
        {
            Caption = 'Holiday Exit Fee Price';
            Editable = false;
        }
        field(29; "Header Valid Start Date"; Date)
        {
            CalcFormula = Lookup("Service Item Rate Header_LDR"."Valid Start Date" WHERE("Code" = FIELD("Code")));
            Caption = 'Header Valid Start Date';
            Editable = false;
            FieldClass = FlowField;
        }
        field(30; "Header Valid End Date"; Date)
        {
            CalcFormula = Lookup("Service Item Rate Header_LDR"."Valid End Date" WHERE("Code" = FIELD("Code")));
            Caption = 'Header Valid End Date';
            Editable = false;
            FieldClass = FlowField;
        }
        field(31; "Header Status"; Option)
        {
            CalcFormula = Lookup("Service Item Rate Header_LDR"."Status" WHERE("Code" = FIELD("Code")));
            Caption = 'Tariff Status';
            FieldClass = FlowField;
            OptionCaption = 'Open,Locked';
            OptionMembers = Open,Locked;
        }
        field(32; "Invoice Group Description"; Text[50])
        {
            CalcFormula = Lookup("Service Item Invoice Group_LDR"."Description" WHERE("Code" = FIELD("Invoice Group No.")));
            Caption = 'Invoice Group Description';
            Editable = false;
            FieldClass = FlowField;
        }
        field(33; "Rate Type"; Option)
        {
            CalcFormula = Lookup("Service Item Invoice Group_LDR"."Rate Type" WHERE("Code" = FIELD("Invoice Group No.")));
            Caption = 'Rate Type';
            Editable = false;
            FieldClass = FlowField;
            OptionCaption = 'Crane < 100,Crane > 100,Crane-Truck,Truck,Platform';
            OptionMembers = "crane-100","crane+100",cranetruck,truck,platform;
        }
        field(34; "Print Order"; Integer)
        {
            BlankZero = true;
            Caption = 'Print Order';
            MinValue = 0;
        }
    }

    keys
    {
        key(Key1; "Code", "Invoice Group No.")
        {
            Clustered = true;
        }
        key(Key2; "Print Order")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        ServiceItemLine: Record "Service Item Line";
    begin
        ServiceItemRateHeader.GET(Code);
        ServiceItemRateHeader.TESTFIELD(Status, ServiceItemRateHeader.Status::Open);

        //No PS con tarifa
        CLEAR(ServiceItemLine);
        ServiceItemLine.SETRANGE("Document Type", ServiceItemLine."Document Type"::Order);
        ServiceItemLine.SETRANGE("Service Item Tariff No._LDR", Code);
        ServiceItemLine.SETRANGE("Service Inv. Group No._LDR", "Invoice Group No.");
        IF ServiceItemLine.FINDFIRST THEN
            ERROR(Text003, TABLECAPTION, Code, ServiceItemLine.TABLECAPTION);
    end;

    trigger OnInsert()
    begin
        ServiceItemRateHeader.GET(Code);
        ServiceItemRateHeader.TESTFIELD(Status, ServiceItemRateHeader.Status::Open);

        "Header Valid Start Date" := ServiceItemRateHeader."Valid Start Date";
        "Header Valid End Date" := ServiceItemRateHeader."Valid End Date";

        UpdatePrices;
    end;

    trigger OnModify()
    var
        ServiceItemRateHeader: Record "Service Item Rate Header_LDR";
    begin
        ServiceItemRateHeader.GET(Code);
        ServiceItemRateHeader.TESTFIELD(Status, ServiceItemRateHeader.Status::Open);

        UpdatePrices;
    end;

    var
        ServiceItemRateHeader: Record "Service Item Rate Header_LDR";
        Text003: Label '%1 %2 can''t be deleted because there are %3 related.';

    /// <summary>
    /// UpdatePrices()
    /// </summary>
    local procedure UpdatePrices()
    begin
        IF "Hour Price" > 0 THEN BEGIN

            "Night Hour Price" := "Hour Price" + ("Hour Price" * "% Night Increment" / 100);
            "Saturday Hour Price" := "Hour Price" + ("Hour Price" * "% Saturday Increment" / 100);
            "Saturday Stop Hour Price" := "Stop Hour Price" + ("Stop Hour Price" * "% Saturday Stop Increment" / 100);
            "Saturday Nigth Hour Price" := "Night Hour Price" + ("Night Hour Price" * "% Saturday Night Increment" / 100);
            "Saturday Exit Fee Price" := "Exit Fee Price" + ("Exit Fee Price" * "% Saturday Exit Fee Increment" / 100);
            "Holiday Hour Price" := "Hour Price" + ("Hour Price" * "% Holiday Increment" / 100);
            "Holiday Stop Hour Price" := "Stop Hour Price" + ("Stop Hour Price" * "% Holiday Stop Increment" / 100);
            "Holiday Night Hour Price" := "Night Hour Price" + ("Night Hour Price" * "% Holiday Night Increment" / 100);
            "Holiday Exit Fee Price" := "Exit Fee Price" + ("Exit Fee Price" * "% Holiday Exit Fee Increment" / 100);

        END;
    end;
}