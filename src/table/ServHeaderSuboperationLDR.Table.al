/// <summary>
/// Table Serv. Header Suboperation_LDR (ID 50053)
/// </summary>
table 50053 "Serv. Header Suboperation_LDR"
{
    Caption = 'Serv. Header Suboperation';

    fields
    {
        field(1; "Document Type"; Option)
        {
            Caption = 'Document Type';
            Editable = false;
            OptionCaption = 'Quote,Order';
            OptionMembers = Quote,"Order";
        }
        field(2; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            Editable = false;
            TableRelation = "Service Header"."No." WHERE("Document Type" = FIELD("Document Type"));
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(4; "Serv. Item Code"; Code[20])
        {
            Caption = 'Cod. Serv. Item';
            TableRelation = "Service Item"."No.";

            trigger OnValidate()
            var
                error50002: Label 'Are you sure you want to overwrite the service product?';
            begin
            end;
        }
        field(5; "Operation Code"; Code[20])
        {
            Caption = 'Cod. Operation';
            TableRelation = "Operations_LDR"."Code" WHERE("Operation Type" = FILTER("Technical"),
                                                   "Require Serv. Order" = FILTER(true));
        }
        field(6; "Suboperation Code"; Code[20])
        {
            Caption = 'Cod. Suboperation';
            TableRelation = "Suboperation_LDR"."Suboperation Code" WHERE("Operation Code" = FIELD("Operation Code"));

            trigger OnValidate()
            var
                Suboperation: Record "Suboperation_LDR";
            begin
            end;
        }
        field(7; "Area"; Option)
        {
            Caption = 'Area';
            OptionCaption = 'Base,Structure';
            OptionMembers = Base,Structure;
        }
        field(8; Element; Code[50])
        {
            Caption = 'Elment';
        }
        field(9; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(10; Completed; BoolEAN)
        {
            Caption = 'Completed';
        }
        field(11; "Completed by User"; Text[50])
        {
            Caption = 'Completed by User';
        }
        field(12; "DateTime Completed"; DateTime)
        {
            Caption = 'DateTime Completed';
        }
    }

    keys
    {
        key(Key1; "Document Type", "Document No.", "Line No.", "Operation Code", "Suboperation Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Text001: Label 'Are you sure you want to undo the selected Suboperation';

    /// <summary>
    /// Complete()
    /// </summary>
    procedure Complete()
    begin
        TESTFIELD(Completed, FALSE);
        Completed := TRUE;
        "Completed by User" := USERID;
        "DateTime Completed" := CURRENTDATETIME;
        MODIFY;
    end;

    /// <summary>
    /// Undo()
    /// </summary>
    procedure Undo()
    var
        Blank: DateTime;
    begin
        IF CONFIRM(Text001, FALSE) THEN BEGIN
            Completed := FALSE;
            "Completed by User" := '';
            "DateTime Completed" := Blank;
            MODIFY;
        END;
    end;
}