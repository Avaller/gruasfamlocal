/// <summary>
/// Table Branch_LDR (ID 50203)
/// </summary>
table 50203 Branch_LDR
{
    // UPG2016 23/12/2015 1CF_RPB Post Code functionality reimplemented

    Caption = 'Branch';
    LookupPageID = "Branches";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(3; City; Text[30])
        {
            Caption = 'City';
            Description = 'UPG2016';
            TableRelation = "Post Code".City;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                PostCode.ValidateCity(City, "Post Code", County, CountryCode, (CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(4; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                PostCode.ValidatePostCode(City, "Post Code", County, CountryCode, (CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(5; County; Text[30])
        {
            Caption = 'County';
        }
        field(6; "Fixed value"; Decimal)
        {
            Caption = 'Fixed value';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(7; Fuel; Decimal)
        {
            Caption = 'Fuel';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(8; Maintenance; Decimal)
        {
            Caption = 'Maintenance';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
    }

    keys
    {
        key(Key1; "No.")
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