/// <summary>
/// Table Service Item Breakdown_LDR (ID 50018)
/// </summary>
table 50018 "Service Item Breakdown_LDR"
{
    DataPerCompany = false;
    LookupPageID = "Service Item Breakdown";

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            TableRelation = Manufacturer;
        }
        field(2; "Model No."; Code[10])
        {
            Caption = 'Model No.';
            TableRelation = "Service Item Model_LDR"."Model Code" WHERE("Code" = FIELD("Code"));
        }
        field(3; Default; BoolEAN)
        {
            Caption = 'Default Breakdown';

            trigger OnValidate()
            begin
                TestSingleDefault();
            end;
        }
        field(4; "Manufacturer Name"; Text[50])
        {
            CalcFormula = Lookup(Manufacturer.Name WHERE(Code = FIELD(Code)));
            Caption = 'Manufacturer Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5; "Model Name"; Text[50])
        {
            CalcFormula = Lookup("Service Item Model_LDR"."Description" WHERE("Code" = FIELD("Code"),
                                                                         "Model Code" = FIELD("Model No.")));
            Caption = 'Model Name';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Code", "Model No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        ServiceItemBreakdownDetail: Record "Servic Item Breakd Detail_LDR";
    begin
        ServiceItemBreakdownDetail.SETRANGE("Manufacturer Code", Code);
        ServiceItemBreakdownDetail.SETRANGE("Model Code", "Model No.");
        ServiceItemBreakdownDetail.DELETEALL(TRUE);
    end;

    var
        Text001: Label 'There can be only one Default Breakdown';

    /// <summary>
    /// TestSingleDefault()
    /// </summary>
    local procedure TestSingleDefault()
    var
        ServItemBreakdown: Record "Service Item Breakdown_LDR";
    begin

        CLEAR(ServItemBreakdown);
        //ServItemBreakdown.SETFILTER(Code,'<>%1',Rec.Code);
        //ServItemBreakdown.SETFILTER("Model No.",'<>%1',Rec."Model No.");
        ServItemBreakdown.SETRANGE(Default, TRUE);
        IF ServItemBreakdown.FINDSET THEN BEGIN
            REPEAT
                IF (ServItemBreakdown.Code <> Rec.Code) OR (ServItemBreakdown."Model No." <> Rec."Model No.") THEN
                    ERROR(Text001);
            UNTIL ServItemBreakdown.NEXT = 0;
        END;
    end;
}