/// <summary>
/// Table Ingestrel Setup_LDR (ID 50013)
/// </summary>
table 50013 "Ingestrel Setup_LDR"
{
    Caption = 'Ingestrel Setup';
    LookupPageID = "Ingestrel Setup";

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
        }
        field(2; "Server IP Address"; Text[15])
        {
            Caption = 'Server IP Address';

            trigger OnValidate()
            var
                Matches: Record Matches;
                Regex: Codeunit Regex;
                Pattern, Value : Text;
            begin
                Pattern := '^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$';
                if not Regex.IsMatch("Server IP Address", Pattern, 0) then
                    error(Text001);
            end;
        }
        field(3; User; Text[50])
        {
            Caption = 'User';
        }
        field(4; Password; Text[50])
        {
            Caption = 'Password';
            ExtendedDatatype = Masked;
        }
        field(5; BBDD; Text[50])
        {
            Caption = 'BBDD';
        }
        field(6; "FTP Address"; Text[250])
        {
            Caption = 'FTP Addres';
        }
        field(7; "FTP User"; Text[50])
        {
            Caption = 'FTP User';
        }
        field(8; "FTP Password"; Text[50])
        {
            Caption = 'FTP Password';
            ExtendedDatatype = Masked;
        }
        field(9; "FTP Directory"; Text[30])
        {
            Caption = 'FTP Directory';
        }
        field(10; "Server TCP Port"; Integer)
        {
            Caption = 'Server TCP Port';
        }
        field(11; "Last Export Date"; Date)
        {
            Caption = 'Last Export Date';
            Editable = false;
        }
        field(12; "FTP Port"; Integer)
        {
            Caption = 'FTP Port';
        }
        field(13; "Vehicle Book Directory"; Text[250])
        {
            Caption = 'Vehicle History Book Directory';
        }
        field(14; "Update Company Data"; BoolEAN)
        {
            Caption = 'Update Company Data';
        }
        field(15; "Update Customer Data"; BoolEAN)
        {
            Caption = 'Update Customer Data';
        }
        field(16; "Update Employees Data"; BoolEAN)
        {
            Caption = 'Update Employees Data';
        }
        field(17; "Update Serv. Item Data"; BoolEAN)
        {
            Caption = 'Update Serv. Item Data';
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

    var
        Text001: Label 'The Printer''s IP doesn''t have a valid format';
}