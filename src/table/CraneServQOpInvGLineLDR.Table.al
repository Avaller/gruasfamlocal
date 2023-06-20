/// <summary>
/// Table Crane Serv Q Op Inv G Line_LDR (ID 50025)
/// </summary>
table 50025 "Crane Serv Q Op Inv G Line_LDR"
{
    Caption = 'Crane Service Quote Operation Line - Invoice Group';
    LookupPageID = "Crane Serv. Q. Op. Inv. G Line";

    fields
    {
        field(1; "Quote No."; Code[20])
        {
            Caption = 'Quote No.';
            TableRelation = "Crane Service Quote Header_LDR";
        }
        field(2; "Operation Line No."; Integer)
        {
            Caption = 'Operation Line No.';
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(4; "Invoice Group No."; Code[10])
        {
            Caption = 'Invoice Group No.';
            TableRelation = "Service Item Invoice Group_LDR" WHERE("Group Type" = CONST("Crane"));

            trigger OnValidate()
            var
                ServInvGroup: Record "Service Item Invoice Group_LDR";
                ServiceItemLine: Record "Service Item Line";
            begin
                IF (xRec."Invoice Group No." <> Rec."Invoice Group No.") AND (xRec."Invoice Group No." <> '') THEN BEGIN

                    //No PS con tarifa
                    CLEAR(ServiceItemLine);
                    ServiceItemLine.SETRANGE("Document Type", ServiceItemLine."Document Type"::Order);
                    ServiceItemLine.SETRANGE("Crane Service Quote No._LDR", "Quote No.");
                    ServiceItemLine.SETRANGE("Service Item Tariff No._LDR", xRec."Invoice Group No.");
                    IF ServiceItemLine.FINDFIRST THEN
                        ERROR(Text004, TABLECAPTION, "Invoice Group No.", ServiceItemLine.TABLECAPTION);

                END;

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
        field(6; "Vehicles Number"; Integer)
        {
            Caption = 'Number of Vehicles';
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
                RateNoAfterValidate();
            end;
        }
        field(8; "Rate Description"; Text[60])
        {
            CalcFormula = Lookup("Service Item Rate Header_LDR"."Description" WHERE("Code" = FIELD("Rate No.")));
            Caption = 'Rate Description';
            Editable = false;
            FieldClass = FlowField;
        }
        field(9; "Invoice Displacement"; BoolEAN)
        {
            Caption = 'Invoice Displacement';
        }
        field(10; "Fill minimum with Displ."; BoolEAN)
        {
            Caption = 'Fill Minimum Displacement';
        }
        field(11; "Invoice Exit Fee"; BoolEAN)
        {
            Caption = 'Invoice Exit Fee';
        }
        field(12; "Apply standard KM"; BoolEAN)
        {
            Caption = 'Apply standard KM';
        }
        field(13; "Displacement Type"; Option)
        {
            Caption = 'Displacement Type';
            OptionCaption = 'KMs,Hours';
            OptionMembers = KMs,Hours;
        }
        field(14; "Displacement Percent"; Decimal)
        {
            Caption = '% Displacement';
            MaxValue = 100;
            MinValue = 0;
        }
        field(15; "Displ. Calculation Type"; Option)
        {
            Caption = 'Calculation Displacement Type';
            OptionCaption = 'Standard,Specific';
            OptionMembers = Standard,Specific;
        }
        field(16; "KM Franchise"; Decimal)
        {
            Caption = 'KM Franchise';
        }
        field(17; "KM-Time Qty."; Decimal)
        {
            Caption = 'KM/Time';
        }
        field(18; "Displacement Amount"; Decimal)
        {
            Caption = 'Amount Displacement';
        }
        field(19; "Minimum Treatment Type"; Option)
        {
            Caption = 'Minimum Treatment Type';
            OptionCaption = 'Continuous,Discontinuos';
            OptionMembers = Continuous,Discontinuos;
        }
        field(20; "Minimum Laboral Hours"; Decimal)
        {
            Caption = 'Minimum Laboral Hours';
        }
        field(21; "Minimum Saturday Hours"; Decimal)
        {
            Caption = 'Minimum Saturday Hours';
        }
        field(22; "Minimum Holiday Hours"; Decimal)
        {
            Caption = 'Minimum Holiday Hours';
        }
        field(23; "Minimum Night Hours"; Decimal)
        {
            Caption = 'Minimum Night Hours';
        }
        field(24; "Maximum Hours"; Decimal)
        {
            Caption = 'Maximum Hours';
        }
        field(25; "Misc. S Line Line No."; Integer)
        {
            Caption = 'Crane Quote Misc. Services Line No.';
            TableRelation = "Crane Serv Q Op Mic S Line_LDR"."Line No." WHERE("Quote No." = FIELD("Quote No."),
                                                                               "Operation Line No." = FIELD("Operation Line No."));
        }
        field(26; "Misc. S Line Description"; Text[50])
        {
            CalcFormula = Lookup("Crane Serv Q Op Mic S Line_LDR"."Description" WHERE("Quote No." = FIELD("Quote No."),
                                                                                     "Operation Line No." = FIELD("Operation Line No."),
                                                                                     "Line No." = FIELD("Misc. S Line Line No.")));
            Caption = 'Crane Quote Misc. Services Description';
            Editable = false;
            FieldClass = FlowField;
        }
        field(27; "Hour Price"; Decimal)
        {
            Caption = 'Hour Price';
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
        key(Key1; "Quote No.", "Operation Line No.", "Line No.")
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
        ServiceItemLine: Record "Service Item Line";
    begin
        CraneServiceQuoteHeader.GET("Quote No.");
        CraneServiceQuoteHeader.TESTFIELD("Quote Status", CraneServiceQuoteHeader."Quote Status"::Open);

        //No PS con tarifa
        CLEAR(ServiceItemLine);
        ServiceItemLine.SETRANGE("Document Type", ServiceItemLine."Document Type"::Order);
        ServiceItemLine.SETRANGE("Crane Service Quote No._LDR", "Quote No.");
        ServiceItemLine.SETRANGE("Service Inv. Group No._LDR", "Invoice Group No.");
        IF ServiceItemLine.FINDFIRST THEN
            ERROR(Text003, TABLECAPTION, "Invoice Group No.", ServiceItemLine.TABLECAPTION);

        CLEAR(ServiceCommentLine);
        ServiceCommentLine.SETRANGE("Table Name", ServiceCommentLine."Table Name"::"Service Header");
        ServiceCommentLine.SETRANGE("Table Subtype", 2);
        ServiceCommentLine.SETRANGE("No.", "Quote No.");
        ServiceCommentLine.SETRANGE(Type, ServiceCommentLine.Type::General);
        ServiceCommentLine.SETRANGE("Table Line No.", "Operation Line No.");
        ServiceCommentLine.DELETEALL(TRUE);
    end;

    trigger OnInsert()
    var
        CraneServiceQuoteHeader: Record "Crane Service Quote Header_LDR";
        CraneServQOpInvGLine: Record "Crane Serv Q Op Inv G Line_LDR";
    begin
        CALCFIELDS("Rate Description");
        CALCFIELDS("Invoice Group Description");

        CraneServiceQuoteHeader.GET("Quote No.");
        //VALIDATE("Rate No.",CraneServiceQuoteHeader."Rate Code");

        //CAS-20254-X0J6
        CraneServiceQuoteHeader.TESTFIELD("Quote Status", CraneServiceQuoteHeader."Quote Status"::Open);
        CraneServQOpInvGLine.SETRANGE("Quote No.", "Quote No.");
        CraneServQOpInvGLine.SETRANGE("Operation Line No.", "Operation Line No.");
        IF CraneServQOpInvGLine.FINDLAST THEN BEGIN
            "Line No." := CraneServQOpInvGLine."Line No." + 10000;
        END;
        //FIN CAS-20254-X0J6

        VALIDATE("Invoice Displacement", CraneServiceQuoteHeader."Invoice Displacement");
        VALIDATE("Fill minimum with Displ.", CraneServiceQuoteHeader."Fill minimum with Displ.");
        VALIDATE("Invoice Exit Fee", CraneServiceQuoteHeader."Invoice Exit Fee");
        VALIDATE("Apply standard KM", CraneServiceQuoteHeader."Apply Standard KMs");
        VALIDATE("Displacement Type", CraneServiceQuoteHeader."Displacement Type");
        VALIDATE("Displacement Percent", CraneServiceQuoteHeader."Displacement %");
        VALIDATE("Displ. Calculation Type", CraneServiceQuoteHeader."Displ. Calculation Type");
        VALIDATE("KM Franchise", CraneServiceQuoteHeader."KM Franchise");
        VALIDATE("KM-Time Qty.", CraneServiceQuoteHeader."KM/Time");
        VALIDATE("Displacement Amount", CraneServiceQuoteHeader."Displacement Amount");
        VALIDATE("Minimum Treatment Type", Rec."Minimum Treatment Type"::Discontinuos);
    end;

    trigger OnModify()
    var
        CraneServiceQuoteHeader: Record "Crane Service Quote Header_LDR";
        ServiceItemLine: Record "Service Item Line";
    begin
        CraneServiceQuoteHeader.GET("Quote No.");
        CraneServiceQuoteHeader.TESTFIELD("Quote Status", CraneServiceQuoteHeader."Quote Status"::Open);
    end;

    var
        Text003: Label '%1 %2 can''t be deleted because there are %3 related.';
        Text004: Label '%1 %2 can''t be deleted because there are %3 related.';

    /// <summary>
    /// RateNoAfterValidate()
    /// </summary>
    local procedure RateNoAfterValidate()
    var
        QuoteHeader: Record "Crane Service Quote Header_LDR";
        CraneRateLine: Record "Servic Item Rat Li - Crane_LDR";
    begin
        QuoteHeader.GET("Quote No.");
        CraneRateLine.GET("Rate No.", "Invoice Group No.");
        IF QuoteHeader."Quote Type" = QuoteHeader."Quote Type"::Forfait THEN BEGIN
            "Hour Price" := CraneRateLine."Hour Price";
        END;

        "Minimum Laboral Hours" := CraneRateLine."Min working Time";
        "Minimum Saturday Hours" := CraneRateLine."Min Saturday Hours";
        "Minimum Holiday Hours" := CraneRateLine."Min Holiday Time";
        "Minimum Night Hours" := CraneRateLine."Min Night Hours";

        MODIFY;
    end;
}