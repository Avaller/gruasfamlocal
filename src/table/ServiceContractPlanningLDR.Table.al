/// <summary>
/// Table Service Contract Planning_LDR (ID 50201)
/// </summary>
table 50201 "Service Contract Planning_LDR"
{
    // CIC IALFONSO 20070312 Almacena la periodicidad de las lineas de contrato.


    fields
    {
        field(1; "Contract Type"; Option)
        {
            Caption = 'Contract Type';
            OptionCaption = 'Quote,Contract';
            OptionMembers = Quote,Contract;
        }
        field(2; "Contract No."; Code[20])
        {
            Caption = 'Contract No.';
            TableRelation = IF ("Source Table" = CONST(5965)) "Service Contract Header"."Contract No." WHERE("Contract Type" = FIELD("Contract Type"));
            /*IF ("Source Table" = CONST(7122021)) "Table70028"."Field1" WHERE("Field2" = FIELD("Contract No."), "Field1" = FIELD("Contract No."));*/
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(4; Date; Date)
        {
            Caption = 'Date';
        }
        field(5; "Service Item No."; Code[20])
        {
            Caption = 'Service Item No.';
            TableRelation = "Service Item";
        }
        field(6; "Source Table"; Integer)
        {
            Caption = 'Source Table';
        }
    }

    keys
    {
        key(Key1; "Source Table", "Contract Type", "Contract No.", "Line No.", Date, "Service Item No.")
        {
            Clustered = true;
            SQLIndex = "Date", "Service Item No.", "Source Table", "Contract Type", "Contract No.", "Line No.";
        }
        key(Key2; "Service Item No.", Date, "Source Table")
        {
        }
    }

    fieldgroups
    {
    }
}