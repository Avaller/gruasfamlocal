/// <summary>
/// Table Serv. Item Insuranc/Author_LDR (ID 50039)
/// </summary>
table 50039 "Serv. Item Insuranc/Author_LDR"
{
    Caption = 'Serv. Item Insurance/Author.';

    fields
    {
        field(1; "Serv. Item No."; Code[20])
        {
            Caption = 'Serv Item No.';
        }
        field(2; "Document Code"; Code[40])
        {
            Caption = 'Document Code';
        }
        field(3; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = 'Insurance,Authorization';
            OptionMembers = insurance,authorization;
        }
        field(4; "Company Description"; Text[80])
        {
            Caption = 'Company Description';
        }
        field(6; "Document No."; Code[20])
        {
            Caption = 'Document/Policy No.';
        }
        field(7; "Renewal Period"; DateFormula)
        {
            CalcFormula = Lookup("Serv. Item Operations_LDR"."Period Value - Date" WHERE("Serv. Item Code" = FIELD("Serv. Item No."),
                                                                                      "Operation Code" = FIELD("Serv. Item Operation Code"),
                                                                                      "Period Type" = CONST("Time")));
            Caption = 'Renewal Period';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8; "Serv. Item Operation Code"; Code[20])
        {
            Caption = 'Serv. Item Operation Code';
            TableRelation = "Serv. Item Operations_LDR" WHERE("Serv. Item Code" = FIELD("Serv. Item No."),
                                                           "Operation Type" = CONST("Administrative"));
        }
    }

    keys
    {
        key(Key1; "Serv. Item No.", "Document Code", "Document Type")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}