/// <summary>
/// Table Order Planner Setup_LDR (ID 50229)
/// </summary>
table 50229 "Order Planner Setup_LDR"
{
    Caption = 'Order Planner Setup';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "Unassigned Order Calculation"; DateFormula)
        {
            Caption = 'Unassigned Order Calculation';
        }
        field(3; "Unassigned Repair Status Code"; Code[20])
        {
            Caption = 'Unassigned Repair Status Code';
            TableRelation = "Repair Status";
        }
        field(4; "Pending Res. Rep. Status Code"; Code[20])
        {
            Caption = 'Pending Resource Repair Status Code';
            TableRelation = "Repair Status";
        }
        field(5; "Pending Res. Planner Colour"; Code[20])
        {
            Caption = 'Pending Resource Planner Colour Code';
        }
        field(6; "Assigned Planner Colour"; Code[20])
        {
            Caption = 'Assigned Planner Colour Code';
        }
        field(7; "Blocked Serv.Item Plan. Colour"; Code[20])
        {
            Caption = 'Blocked Serv.Item Plan. Colour';
        }
        field(8; "Out Explotation Planner Colour"; Code[20])
        {
            Caption = 'Out Explotation Planner Colour';
        }
        field(9; "Serv. Order On Device Colour"; Code[20])
        {
            Caption = 'Serv. Order On Device Colour Code';
        }
        field(10; "Serv. Order No Device Colour"; Code[20])
        {
            Caption = 'Serv. Order No Device Colour';
        }
        field(11; "Event Description Type"; Option)
        {
            Caption = 'Event Description Type';
            OptionCaption = 'Customer,Resource Alias,Description';
            OptionMembers = Customer,Alias,Description;
        }
        field(12; "Comment Colour"; Code[20])
        {
            Caption = 'Comment Colour';
        }
        field(13; "Platform Trucks Pres. Code"; Code[10])
        {
            Caption = 'Platform Trucks Presentation Group Code';
            TableRelation = "Service Item Pres. Group_LDR";
        }
        field(14; "Ceded Colour"; Code[20])
        {
            Caption = 'Ceded Colour Code';
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}