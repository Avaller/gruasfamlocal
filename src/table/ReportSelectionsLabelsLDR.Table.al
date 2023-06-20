/// <summary>
/// Table Report Selections Labels_LDR (ID 50223)
/// </summary>
table 50223 "Report Selections Labels_LDR"
{
    Caption = 'Report Selections Labels';

    fields
    {
        field(1; Usage; Option)
        {
            Caption = 'Usage';
            OptionCaption = 'Item,Purchase Order,Purchase Shipment,Warranty,Service Item,Item Reclass,Item Transfer';
            OptionMembers = Item,"Purchase Order","Purchase Shipment",Warranty,"Serv. Item","Item Reclass","Item Transfer";
        }
        field(2; Sequence; Code[10])
        {
            Caption = 'Sequence';
            Numeric = true;
        }
        field(3; "Report ID"; Integer)
        {
            Caption = 'Report ID';
            TableRelation = Object.ID WHERE(Type = CONST(Report));

            trigger OnValidate()
            begin
                CALCFIELDS("Report Name");
            end;
        }
        field(4; "Report Name"; Text[80])
        {
            CalcFormula = Lookup("AllObjWithCaption"."Object Caption" WHERE("Object Type" = CONST("Report"),
                                                                           "Object ID" = FIELD("Report ID")));
            Caption = 'Report Name';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; Usage, Sequence)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        ReportSelection2: Record "Report Selections Labels_LDR";

    /// <summary>
    /// NewRecord()
    /// </summary>
    procedure NewRecord()
    begin
        ReportSelection2.SETRANGE(Usage, Usage);
        IF ReportSelection2.FIND('+') AND (ReportSelection2.Sequence <> '') THEN
            Sequence := INCSTR(ReportSelection2.Sequence)
        ELSE
            Sequence := '1';
    end;
}