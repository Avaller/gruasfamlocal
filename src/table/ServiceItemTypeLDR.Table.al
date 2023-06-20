/// <summary>
/// Table Service Item Type_LDR (ID 50006)
/// </summary>
table 50006 "Service Item Type_LDR"
{
    Caption = 'Type Service Item';
    DataPerCompany = false;
    LookupPageID = "Service Item Type";

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Service Item Type Code';
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description Service Item';
        }
        field(3; "Accept Towing"; BoolEAN)
        {
            Caption = 'Accept Towing';
        }
        field(4; "Features Type"; Option)
        {
            Caption = 'Features Type';
            OptionCaption = 'Crane,Truck,Platform';
            OptionMembers = Crane,Truck,Platform;
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
        ServiceItemSubtype: Record "Service Item Subtype_LDR";
    begin
        CLEAR(ServiceItemSubtype);
        ServiceItemSubtype.SETRANGE(Code, Code);
        ServiceItemSubtype.DELETEALL(TRUE);
    end;
}