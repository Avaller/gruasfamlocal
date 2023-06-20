/// <summary>
/// Table Crane Servic Quote Op. Lin_LDR (ID 50022)
/// </summary>
table 50022 "Crane Servic Quote Op. Lin_LDR"
{
    Caption = 'Crane Service Quote Op. Line';
    LookupPageID = "Service Crane Quote Op. Subf.";

    fields
    {
        field(1; "Quote No."; Code[20])
        {
            Caption = 'Quote No.';
            TableRelation = "Crane Service Quote Header_LDR";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Operation No."; Integer)
        {
            Caption = 'Operation No.';
            MaxValue = 99999;
            MinValue = 1;
            NotBlank = true;
        }
        field(4; "Operation Description"; Text[50])
        {
            Caption = 'Operation Description';
        }
        field(5; "Forfait Amount"; Decimal)
        {
            CalcFormula = Sum("Crane Serv Q. Forf Calend_LDR"."Amount" WHERE("Quote No." = FIELD("Quote No."),
                                                                             "Quote Op. Line No." = FIELD("Line No.")));
            Caption = 'Forfait Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(6; Processed; BoolEAN)
        {
            Caption = 'Processed';
        }
        field(7; "Quote Type"; Option)
        {
            CalcFormula = Lookup("Crane Service Quote Header_LDR"."Quote Type" WHERE("Quote no." = FIELD("Quote No.")));
            Caption = 'Quote Type';
            Editable = false;
            FieldClass = FlowField;
            OptionCaption = 'General,Tariff,,Forfait';
            OptionMembers = General,Tariff,"Sprecial Operations",Forfait;
        }
    }

    keys
    {
        key(Key1; "Quote No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        CraneServQOpMicSLine: Record "Crane Serv Q Op Mic S Line_LDR";
        CraneServQOpInvGLine: Record "Crane Serv Q Op Inv G Line_LDR";
        ServiceCommentLine: Record "Service Comment Line";
        CraneServQForfaitCalendar: Record "Crane Serv Q. Forf Calend_LDR";
        CraneServiceQuoteHeader: Record "Crane Service Quote Header_LDR";
    begin
        CraneServiceQuoteHeader.GET("Quote No.");
        CraneServiceQuoteHeader.TESTFIELD("Quote Status", CraneServiceQuoteHeader."Quote Status"::Open);

        CLEAR(CraneServQOpMicSLine);
        CraneServQOpMicSLine.SETRANGE("Quote No.", "Quote No.");
        CraneServQOpMicSLine.SETRANGE("Operation Line No.", "Line No.");
        CraneServQOpMicSLine.DELETEALL(TRUE);

        CLEAR(CraneServQOpInvGLine);
        CraneServQOpInvGLine.SETRANGE("Quote No.", "Quote No.");
        CraneServQOpInvGLine.SETRANGE("Operation Line No.", "Line No.");
        CraneServQOpInvGLine.DELETEALL(TRUE);

        CLEAR(ServiceCommentLine);
        ServiceCommentLine.SETRANGE("Table Name", ServiceCommentLine."Table Name"::"Service Header");
        ServiceCommentLine.SETRANGE("Table Subtype", 0);
        ServiceCommentLine.SETRANGE("No.", "Quote No.");
        ServiceCommentLine.SETRANGE(Type, ServiceCommentLine.Type::General);
        ServiceCommentLine.SETRANGE("Table Line No.", "Line No.");
        ServiceCommentLine.DELETEALL(TRUE);

        CLEAR(CraneServQForfaitCalendar);
        CraneServQForfaitCalendar.SETRANGE("Quote No.", "Quote No.");
        CraneServQForfaitCalendar.SETRANGE("Quote Op. Line No.", "Line No.");
        CraneServQForfaitCalendar.DELETEALL(TRUE);
    end;

    trigger OnInsert()
    begin
        // IF "Operation No." = 0 THEN
        //  ERROR(Text001);
    end;

    trigger OnModify()
    var
        CraneServiceQuoteHeader: Record "Crane Service Quote Header_LDR";
    begin
        // IF "Operation No." = 0 THEN
        //  ERROR(Text001);

        CraneServiceQuoteHeader.GET("Quote No.");
        CraneServiceQuoteHeader.TESTFIELD("Quote Status", CraneServiceQuoteHeader."Quote Status"::Open);
    end;

    var
        Text001: Label 'You must introduce an Operation No. greater than 1';
}