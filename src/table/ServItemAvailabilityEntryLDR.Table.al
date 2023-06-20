/// <summary>
/// Table Serv. Item Avail Entry_LDR (ID 50038)
/// </summary>
table 50038 "Serv. Item Avail Entry_LDR"
{
    Caption = 'Serv. Item Availability Entry';
    DataPerCompany = false;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Entry No.';
        }
        field(2; "Service Item Code"; Code[20])
        {
            Caption = 'Service Item Code';
            NotBlank = true;
            TableRelation = "Service Item";
        }
        field(3; "Entry Type"; Option)
        {
            Caption = 'Entry Type';
            OptionCaption = 'Cession,Maintenance';
            OptionMembers = cession,maintenance;
        }
        field(4; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
        }
        field(5; "Ending Date"; Date)
        {
            Caption = 'Ending Date';
        }
        field(6; "Serv. Order No."; Code[20])
        {
            Caption = 'Serv. Order No.';
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Service Item Code", "Entry Type", "Starting Date")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        TESTFIELD("Service Item Code");
    end;
}