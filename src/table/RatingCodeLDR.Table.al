/// <summary>
/// Table Rating Code_LDR (ID 50224)
/// </summary>
table 50224 "Rating Code_LDR"
{
    Caption = 'Rating Code';

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;

        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
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
        TxtCustExist: Label 'Can''t delete. There are Customers with this Rating.';
        TxtVendExist: Label 'Can''t delete. There are Vendors with this Rating.';
        Customer: Record "Customer";
        Vendor: Record "Vendor";
    begin
        Clear(Customer);
        Customer.SetRange("Rating Code_LDR", Code);
        if Customer.FindLast Then Error(TxtCustExist);

        Clear(Vendor);
        Vendor.SETRANGE("Rating Code_LDR", Code);
        if Vendor.FindLast Then Error(TxtVendExist);
    end;
}