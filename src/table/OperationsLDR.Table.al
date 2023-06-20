/// <summary>
/// Table Operations_LDR (ID 50035)
/// </summary>
table 50035 Operations_LDR
{
    Caption = 'Operations';
    DataPerCompany = false;
    LookupPageID = "Operations";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(3; "Operation Type"; Option)
        {
            Caption = 'Operation Type';
            OptionCaption = 'Administrative,Technical';
            OptionMembers = Administrative,Technical;
        }
        field(4; "Period Type"; Option)
        {
            Caption = 'Period Type';
            OptionCaption = 'Time,Hours';
            OptionMembers = Time,Hours;
        }
        field(5; Image; BLOB)
        {
            Caption = 'Image';
            SubType = Bitmap;
        }
        field(6; "Require Serv. Order"; BoolEAN)
        {
            Caption = 'Require Serv. Order';
        }
        field(7; "Self/External"; Option)
        {
            Caption = 'Self/External';
            OptionCaption = 'Self,External';
            OptionMembers = Self,External;
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
        ServItemOperations: Record "Serv. Item Operations_LDR";
        ServItemOperationsEntry: Record "Serv. Item Operat Entry_LDR";
    begin
        ServItemOperations.SETRANGE("Operation Code", Code);
        IF ServItemOperations.FINDFIRST THEN
            ERROR(Text001, TABLECAPTION, Code, ServItemOperations.TABLECAPTION);

        ServItemOperationsEntry.SETRANGE("Operation Code", Code);
        ServItemOperationsEntry.SETRANGE(Closed, FALSE);
        IF ServItemOperationsEntry.FINDFIRST THEN
            ERROR(Text002, TABLECAPTION, Code, ServItemOperationsEntry.TABLECAPTION);
    end;

    var
        Text001: Label '%1 %2 can''t be deleted because there are %3 related.';
        Text002: Label '%1 %2 can''t be deleted because there are open %3 related.';
}