/// <summary>
/// Table Kilometric distance_LDR (ID 50204)
/// </summary>
table 50204 "Kilometric distance_LDR"
{
    // UPG2016 23/12/2015 1CF_RPB Post Code functionality reimplemented

    Caption = 'Kilometric distance';

    fields
    {
        field(1; "From City"; Text[30])
        {
            Caption = 'From City';
            Editable = false;
            NotBlank = true;
        }
        field(2; "From Post Code"; Code[20])
        {
            Caption = 'From Post Code';
            NotBlank = true;
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                PostCode.ValidatePostCode("From City", "From Post Code", "From County", CountryCode, (CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(3; "From County"; Text[30])
        {
            Caption = 'From County';
            Editable = false;
        }
        field(4; "To City"; Text[30])
        {
            Caption = 'To City';
            Editable = false;
            NotBlank = true;
        }
        field(5; "To Post Code"; Code[20])
        {
            Caption = 'To Post Code';
            NotBlank = true;
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                PostCode.ValidatePostCode("To City", "To Post Code", "To County", CountryCode, (CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(6; "To County"; Text[30])
        {
            Caption = 'To County';
            Editable = false;
        }
        field(7; "Distance (Km)"; Decimal)
        {
            Caption = 'Distance (Km)';
        }
        field(8; Duration; Decimal)
        {
            Caption = 'Duration (Hours)';
        }
    }

    keys
    {
        key(Key1; "From City", "From Post Code", "To City", "To Post Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        PostCode: Record "Post Code";
        CountryCode: Code[10];
}