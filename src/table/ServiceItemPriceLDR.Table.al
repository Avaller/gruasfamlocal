/// <summary>
/// Table Service Item Price_LDR (ID 50202)
/// </summary>
table 50202 "Service Item Price_LDR"
{
    Caption = 'Service Item Group Price';
    LookupPageID = "Service Item Prices_LDR";

    fields
    {
        field(1; "Service Price Group"; Code[20])
        {
            Caption = 'Service Price Group';
            TableRelation = "Service Price Group";
        }
        field(2; "Month Price"; Decimal)
        {
            Caption = 'Month Price';
        }
        field(3; "Week Price"; Decimal)
        {
            Caption = 'Week Price';
        }
        field(4; "Day Price"; Decimal)
        {
            Caption = 'Day Price';
        }
        field(5; "Hour Price"; Decimal)
        {
            Caption = 'Hour Price';
        }
        field(6; "Version No."; Code[20])
        {
            Caption = 'Version No.';
            Editable = true;
        }
    }

    keys
    {
        key(Key1; "Service Price Group", "Version No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}