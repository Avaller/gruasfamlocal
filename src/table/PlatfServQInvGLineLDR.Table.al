/// <summary>
/// Table Platf. Serv. Q. Inv G Line_LDR (ID 50054)
/// </summary>
table 50054 "Platf. Serv. Q. Inv G Line_LDR"
{
    Caption = 'Platform Quote Line - Invoice Group';
    LookupPageID = "Crane Serv. Q. Op. Inv. G Line";

    fields
    {
        field(1; "Quote No."; Code[20])
        {
            Caption = 'Quote No.';
            TableRelation = "Crane Service Quote Header_LDR";
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(4; "Invoice Group No."; Code[10])
        {
            Caption = 'Invoice Group No.';
            TableRelation = "Service Item Invoice Group_LDR" WHERE("Group Type" = CONST("Platform"));

            trigger OnValidate()
            var
                ServInvGroup: Record "Service Item Invoice Group_LDR";
            begin
                ServInvGroup.GET("Invoice Group No.");
                "Print Order" := ServInvGroup."Print Order";
            end;
        }
        field(5; "Invoice Group Description"; Text[50])
        {
            CalcFormula = Lookup("Service Item Invoice Group_LDR"."Description" WHERE("Code" = FIELD("Invoice Group No.")));
            Caption = 'Invoice Group Description';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7; "Rate No."; Code[20])
        {
            Caption = 'Rate No.';

            trigger OnLookup()
            begin
                // codigo lookup condicional
            end;

            trigger OnValidate()
            begin
                RateNoAfterValidate;
            end;
        }
        field(8; "Rate Description"; Text[60])
        {
            CalcFormula = Lookup("Service Item Rate Header_LDR"."Description" WHERE("Code" = FIELD("Rate No.")));
            Caption = 'Rate Description';
            Editable = false;
            FieldClass = FlowField;
        }
        field(9; "Day Cost"; Decimal)
        {
            Caption = 'Day Cost';
        }
        field(10; "Mouth Cost"; Decimal)
        {
            Caption = 'Mouth Cost';
        }
        field(11; "Year Cost"; Decimal)
        {
            Caption = 'Year Cost';
        }
        field(12; "Deliver/Pickup Price"; Decimal)
        {
            Caption = 'Deliver/Pickup Price';
        }
        field(28; "Print Order"; Integer)
        {
            BlankZero = true;
            Caption = 'Print Order';
            MinValue = 0;
        }
    }

    keys
    {
        key(Key1; "Quote No.", "Line No.")
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
        ServiceCommentLine: Record "Service Comment Line";
        CraneServiceQuoteHeader: Record "Crane Service Quote Header_LDR";
    begin
        CraneServiceQuoteHeader.GET("Quote No.");
        CraneServiceQuoteHeader.TESTFIELD("Quote Status", CraneServiceQuoteHeader."Quote Status"::Open);

        CLEAR(ServiceCommentLine);
        ServiceCommentLine.SETRANGE("Table Name", ServiceCommentLine."Table Name"::"Service Header");
        ServiceCommentLine.SETRANGE("No.", "Quote No.");
        ServiceCommentLine.SETRANGE(Type, ServiceCommentLine.Type::General);
        ServiceCommentLine.SETRANGE("Table Line No.", 0);
        ServiceCommentLine.DELETEALL(TRUE);
    end;

    trigger OnInsert()
    var
        CraneServiceQuoteHeader: Record "Crane Service Quote Header_LDR";
    begin
        CALCFIELDS("Rate Description");
        CALCFIELDS("Invoice Group Description");

        CraneServiceQuoteHeader.GET("Quote No.");
    end;

    trigger OnModify()
    var
        CraneServiceQuoteHeader: Record "Crane Service Quote Header_LDR";
    begin
        CraneServiceQuoteHeader.GET("Quote No.");
        CraneServiceQuoteHeader.TESTFIELD("Quote Status", CraneServiceQuoteHeader."Quote Status"::Open);
    end;

    /// <summary>
    /// RateNoAfterValidate()
    /// </summary>
    local procedure RateNoAfterValidate()
    var
        QuoteHeader: Record "Crane Service Quote Header_LDR";
        PlatformRateLine: Record "Servic Item Rat Lin - Plat_LDR";
    begin
        QuoteHeader.GET("Quote No.");
        PlatformRateLine.GET("Rate No.", "Invoice Group No.");
        "Day Cost" := PlatformRateLine."Day Cost";
        "Mouth Cost" := PlatformRateLine."Mouth Cost";
        "Year Cost" := PlatformRateLine."Year Cost";

        MODIFY;
    end;
}