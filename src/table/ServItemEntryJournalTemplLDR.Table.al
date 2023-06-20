/// <summary>
/// Table Serv Item Entr Journ Templ_LDR (ID 50233)
/// </summary>
table 50233 "Serv Item Entr Journ Templ_LDR"
{
    Caption = 'Serv.Item Entry Journal Templ.';
    DrillDownPageID = "Serv. Item Bin Ent. Jour Temp.";
    LookupPageID = "Serv. Item Bin Ent. Jour Temp.";

    fields
    {
        field(1; Name; Code[10])
        {
            Caption = 'Name';
            NotBlank = true;
        }
        field(2; Description; Text[80])
        {
            Caption = 'Description';
        }
        field(5; "Test Report ID"; Integer)
        {
            Caption = 'Test Report ID';
            TableRelation = Object.ID WHERE(Type = CONST(Report));
        }
        field(6; "Form ID"; Integer)
        {
            Caption = 'Form ID';
            TableRelation = Object.ID WHERE(Type = CONST(Page));

            trigger OnValidate()
            begin
                IF "Form ID" = 0 THEN
                    VALIDATE(Recurring);
            end;
        }
        field(7; "Posting Report ID"; Integer)
        {
            Caption = 'Posting Report ID';
            TableRelation = Object.ID WHERE(Type = CONST(Report));
        }
        field(8; "Force Posting Report"; BoolEAN)
        {
            Caption = 'Force Posting Report';
        }
        field(10; "Source Code"; Code[10])
        {
            Caption = 'Source Code';
            TableRelation = "Source Code";

            trigger OnValidate()
            begin
                ServiceItemJnlLine.SETRANGE("Journal Template Name", Name);
                //ServiceItemJnlLine.MODIFYALL("Source Code","Source Code");
                MODIFY;
            end;
        }
        field(12; Recurring; BoolEAN)
        {
            Caption = 'Recurring';

            trigger OnValidate()
            begin
                IF Recurring THEN
                    //"Form ID" := PAGE::Page70061 
                    //"Form ID" := PAGE::Page70061; 
                    // "Test Report ID" := REPORT::"Job Journal - Test";
                    // "Posting Report ID" := REPORT::"Job Register";
                    SourceCodeSetup.GET;
                "Source Code" := SourceCodeSetup."Service Journal_LDR";
                IF Recurring THEN
                    TESTFIELD("No. Series", '');
            end;
        }
        field(13; "Test Report Name"; Text[80])
        {
            CalcFormula = Lookup("AllObjWithCaption"."Object Caption" WHERE("Object Type" = CONST("Report"),
                                                                           "Object ID" = FIELD("Test Report ID")));
            Caption = 'Test Report Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(14; "Form Name"; Text[80])
        {
            CalcFormula = Lookup("AllObjWithCaption"."Object Caption" WHERE("Object Type" = CONST("Page"),
                                                                             "Object ID" = FIELD("Form ID")));
            Caption = 'Form Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(15; "Posting Report Name"; Text[80])
        {
            CalcFormula = Lookup("AllObjWithCaption"."Object Caption" WHERE("Object Type" = CONST("Report"),
                                                                           "Object ID" = FIELD("Posting Report ID")));
            Caption = 'Posting Report Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(16; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";

            trigger OnValidate()
            begin
                IF "No. Series" <> '' THEN BEGIN
                    IF Recurring THEN
                        ERROR(
                          Text000,
                          FIELDCAPTION("Posting No. Series"));
                    IF "No. Series" = "Posting No. Series" THEN
                        "Posting No. Series" := '';
                END;
            end;
        }
        field(17; "Posting No. Series"; Code[10])
        {
            Caption = 'Posting No. Series';
            TableRelation = "No. Series";

            trigger OnValidate()
            begin
                IF ("Posting No. Series" = "No. Series") AND ("Posting No. Series" <> '') THEN
                    FIELDERROR("Posting No. Series", STRSUBSTNO(Text001, "Posting No. Series"));
            end;
        }
    }

    keys
    {
        key(Key1; Name)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        ServiceItemJnlBatch: Record "Serv.Item Entr Journ Batch_LDR";
        ServiceItemJnlLine: Record "Serv.Item. Entry Journal_LDR";
        SourceCodeSetup: Record "Source Code Setup";
        Text000: Label 'Only the %1 field can be filled in on recurring journals.';
        Text001: Label 'must not be %1';
}