/// <summary>
/// Table Resource Discount Group_LDR (ID 50216)
/// </summary>
table 50216 "Resource Discount Group_LDR"
{
    Caption = 'Resource Discount Group';
    LookupPageID = "Resource Disc. Groups";

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Description; Text[30])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        SalesLineDiscount: Record "Sales Line Discount";
    begin
        SalesLineDiscount.SETRANGE(Type, SalesLineDiscount.Type::"Item Disc. Group");
        SalesLineDiscount.SETRANGE(Code, Code);
        SalesLineDiscount.DELETEALL(TRUE);
    end;
}