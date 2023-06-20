/// <summary>
/// Table User Date_LDR (ID 50042)
/// </summary>
table 50042 "User Date_LDR"
{
    fields
    {
        field(1; "User Id"; Code[50])
        {
            Caption = 'User Id';
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(2; Date; Date)
        {
            Caption = 'Date';
        }
    }

    keys
    {
        key(Key1; "User Id")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}