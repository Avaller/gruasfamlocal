/// <summary>
/// Table Employee Marking Entries_LDR (ID 50000)
/// </summary>
table 50000 "Employee Marking Entries_LDR"
{
    Caption = 'Employee Marking';
    DataPerCompany = false;
    LookupPageID = "Employee Marking Entries";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Entry No.';
            Description = 'Numero Movimiento';
        }
        field(2; "Entry Type"; Option)
        {
            Caption = 'Entry Type';
            OptionCaption = 'Entrance,Departure';
            OptionMembers = Entrance,Departure;
        }
        field(3; "Entry Date"; Date)
        {
            Caption = 'Entry Date';
        }
        field(4; "Entry Time"; Time)
        {
            Caption = 'Entry Time';
        }
        field(5; "Door Operation Code"; Code[3])
        {
            Caption = 'Door Operation Code';
        }
        field(6; "No Operation Card"; Code[4])
        {
            Caption = 'No Operation Card';
        }
        field(7; "Operation Employee Code"; Code[20])
        {
            Caption = 'Operation Employee Code';
            TableRelation = Employee;
        }
        field(8; "Operation Resource Code"; Code[20])
        {
            Caption = 'Operation Resource Code';
            TableRelation = Resource;
        }
        field(9; "Operation Employee Name"; Text[50])
        {
            CalcFormula = Lookup("Employee"."Name" WHERE("No." = FIELD("Operation Employee Code")));
            Caption = 'Operation Employee Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(10; "Operation Resource Name"; Text[50])
        {
            CalcFormula = Lookup("Resource"."Name" WHERE("No." = FIELD("Operation Resource Code")));
            Caption = 'Operation Resource Name';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}