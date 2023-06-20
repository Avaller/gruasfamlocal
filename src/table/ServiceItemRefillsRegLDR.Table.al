/// <summary>
/// Table Service Item Refills Reg_LDR (ID 50021)
/// </summary>
table 50021 "Service Item Refills Reg_LDR"
{
    Caption = 'Service Item Refills Reg';
    LookupPageID = "Services Item Refills Reg";

    fields
    {
        field(1; No; Integer)
        {
            AutoIncrement = true;
            Caption = 'No';
        }
        field(2; "Transaction Type"; Code[5])
        {
            Caption = 'Transaction Type';
        }
        field(3; "Transaction Code"; Code[10])
        {
            Caption = 'Transaction Code';
        }
        field(4; "Terminal Code"; Code[10])
        {
            Caption = 'Terminal Code';
        }
        field(5; "Transaction Date"; Date)
        {
            Caption = 'Transaction Date';
        }
        field(6; "Transaction Time"; Time)
        {
            Caption = 'Transaction Time';
        }
        field(7; "Refill Type"; Code[5])
        {
            Caption = 'Refill Type';
        }
        field(8; "Vehicle No"; Code[10])
        {
            Caption = 'Vehicle No';
        }
        field(9; "Service Item Code"; Code[20])
        {
            Caption = 'Service Item Code';
            TableRelation = "Service Item";
        }
        field(10; "Serv. Item Counter No."; Integer)
        {
            Caption = 'Cont Service Item No.';
            TableRelation = "Service Item Counter_LDR";
        }
        field(11; "Driver No."; Code[20])
        {
            Caption = 'Driver No.';
            TableRelation = "Resource"."No.";
            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(12; "Cont Type"; Option)
        {
            Caption = 'Cont Type';
            OptionCaption = 'Time,Km';
            OptionMembers = Time,KM;
        }
        field(13; "Before Value"; Decimal)
        {
            Caption = 'Before Value';
        }
        field(14; "Actual Value"; Decimal)
        {
            Caption = 'Actual Value';
        }
        field(15; "Item Type"; Code[5])
        {
            Caption = 'Item Type';
        }
        field(16; "Transaction Volume"; Decimal)
        {
            Caption = 'Transaction Volume';
        }
        field(17; Process; BoolEAN)
        {
            Caption = 'Process';
        }
        field(18; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            TableRelation = Vendor;
        }
        field(19; "Unit Price"; Decimal)
        {
            Caption = 'Unit Price';
        }
        field(20; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(21; "Refill Type I/E"; Option)
        {
            Caption = 'Refill Type I/E';
            OptionCaption = 'Internal,External';
            OptionMembers = Internal,External;
        }
        field(22; "Distribution Refill"; BoolEAN)
        {
            Caption = 'Distribution Refill';
        }
        field(23; Distributed; BoolEAN)
        {
            Caption = 'Distributed';
        }
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        TESTFIELD(Process, FALSE);
    end;

    trigger OnModify()
    begin
        //TESTFIELD(Process,FALSE);
        IF Process THEN BEGIN
            IF NOT CONFIRM(Text001, FALSE) THEN
                ERROR(Text002);
        END;
    end;

    var
        Text001: Label 'You are about to modify a processed Serv. Item Refill Entry. Are you sure?';
        Text002: Label 'Process Interrupted';
}