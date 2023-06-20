/// <summary>
/// Table Crane Serv Q Op Mic S Line_LDR (ID 50024)
/// </summary>
table 50024 "Crane Serv Q Op Mic S Line_LDR"
{
    Caption = 'Crane Serv. Q. Op. Line - Other Services';

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
        field(4; "Concept Code"; Code[10])
        {
            Caption = 'Concept Code';
            TableRelation = "Concept_LDR" WHERE("Type" = CONST("Internal"));

            trigger OnValidate()
            var
                Concept: Record "Concept_LDR";
            begin
                Concept.GET("Concept Code");
                Description := Concept.Description;
                "Unit Price" := Concept."Unit Price";
            end;
        }
        field(5; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(6; Quantity; Decimal)
        {
            Caption = 'Quantity';
        }
        field(7; "Unit Price"; Decimal)
        {
            Caption = 'Unit Price';
        }
        field(8; "Operation No."; Integer)
        {
            CalcFormula = Lookup("Crane Servic Quote Op. Lin_LDR"."Operation No." WHERE("Quote No." = FIELD("Quote No."),
                                                                                       "Line No." = FIELD("Operation Line No.")));
            Caption = 'Operation No.';
            Editable = false;
            FieldClass = FlowField;
            NotBlank = true;
        }
        field(9; "Operation Description"; Text[50])
        {
            CalcFormula = Lookup("Crane Servic Quote Op. Lin_LDR"."Operation Description" WHERE("Quote No." = FIELD("Quote No."),
                                                                                               "Line No." = FIELD("Operation Line No.")));
            Caption = 'Operation Description';
            Editable = false;
            FieldClass = FlowField;
        }
        field(10; "Included in Forfait"; BoolEAN)
        {
            CalcFormula = Exist("Crane Serv Q Op Inv G Line_LDR" WHERE("Quote No." = FIELD("Quote No."),
                                                                        "Operation Line No." = FIELD("Operation Line No."),
                                                                        "Misc. S Line Line No." = FIELD("Line No.")));
            Caption = 'Included in Forfait';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Quote No.", "Operation Line No.", "Line No.")
        {
            Clustered = true;
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
        ServiceCommentLine.SETRANGE("Table Subtype", 1);
        ServiceCommentLine.SETRANGE("No.", "Quote No.");
        ServiceCommentLine.SETRANGE(Type, ServiceCommentLine.Type::General);
        ServiceCommentLine.SETRANGE("Table Line No.", "Operation Line No.");
        ServiceCommentLine.DELETEALL(TRUE);
    end;

    trigger OnModify()
    var
        CraneServiceQuoteHeader: Record "Crane Service Quote Header_LDR";
    begin
        CraneServiceQuoteHeader.GET("Quote No.");
        CraneServiceQuoteHeader.TESTFIELD("Quote Status", CraneServiceQuoteHeader."Quote Status"::Open);
    end;
}