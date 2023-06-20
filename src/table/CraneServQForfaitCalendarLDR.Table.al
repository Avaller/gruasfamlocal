/// <summary>
/// Table Crane Serv Q. Forf Calend_LDR (ID 50041)
/// </summary>
table 50041 "Crane Serv Q. Forf Calend_LDR"
{
    Caption = 'Crane Serv Q. Forfait Calendar';
    DrillDownPageID = "Crane Serv. Q. Forfait Calenda";
    LookupPageID = "Crane Serv. Q. Forfait Calenda";

    fields
    {
        field(1; "Quote No."; Code[20])
        {
            Caption = 'Quote no.';
        }
        field(2; "Quote Op. Line No."; Integer)
        {
            Caption = 'Operation Line No.';
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(4; "Scheduled Date"; Date)
        {
            Caption = 'Scheduled Date';
        }
        field(5; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(6; Processed; BoolEAN)
        {
            Caption = 'Processed';
        }
        field(7; "Invoice No."; Code[20])
        {
            Caption = 'Invoice No.';
        }
        field(8; "Operation No."; Integer)
        {
            CalcFormula = Lookup("Crane Servic Quote Op. Lin_LDR"."Operation No." WHERE("Quote No." = FIELD("Quote No."),
                                                                                       "Line No." = FIELD("Quote Op. Line No.")));
            Caption = 'Operation No.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(9; "Operation Description"; Text[50])
        {
            CalcFormula = Lookup("Crane Servic Quote Op. Lin_LDR"."Operation Description" WHERE("Quote No." = FIELD("Quote No."),
                                                                                               "Line No." = FIELD("Quote Op. Line No.")));
            Caption = 'Operation Description';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Quote No.", "Quote Op. Line No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnModify()
    var
        CraneServiceQuoteHeader: Record "Crane Service Quote Header_LDR";
    begin
        CraneServiceQuoteHeader.GET("Quote No.");
        CraneServiceQuoteHeader.TESTFIELD("Quote Status", CraneServiceQuoteHeader."Quote Status"::Open);

        TESTFIELD(Processed, FALSE);
        TESTFIELD("Invoice No.", '');
    end;
}