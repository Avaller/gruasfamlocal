/// <summary>
/// Table Concept_LDR (ID 50208)
/// </summary>
table 50208 Concept_LDR
{
    Caption = 'Concept';
    LookupPageID = "Concepts";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            NotBlank = true;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(3; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            NotBlank = true;
            TableRelation = "G/L Account";
        }
        field(4; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Internal,External';
            OptionMembers = Internal,External;
        }
        field(50001; "Unit Price"; Decimal)
        {
            Caption = 'Unit Price';
        }
    }

    keys
    {
        key(Key1; "No.", Type)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}