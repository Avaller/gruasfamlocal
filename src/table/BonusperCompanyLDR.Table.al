/// <summary>
/// Table Bonus per Company_LDR (ID 50051)
/// </summary>
table 50051 "Bonus per Company_LDR"
{
    fields
    {
        field(1; "Invoicing Group"; Code[10])
        {
            Caption = 'Invoicing Group';
            TableRelation = "Service Item Invoice Group_LDR";
        }
        field(2; Company; Text[30])
        {
            Caption = 'Company';
            TableRelation = Company;
        }
        field(3; "Bonus %"; Decimal)
        {
            Caption = 'Bonus %';
        }
    }

    keys
    {
        key(Key1; "Invoicing Group", Company)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}