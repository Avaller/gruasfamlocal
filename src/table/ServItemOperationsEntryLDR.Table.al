/// <summary>
/// Table Serv. Item Operat Entry_LDR (ID 50037)
/// </summary>
table 50037 "Serv. Item Operat Entry_LDR"
{
    Caption = 'Serv. Item Operations Entry';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Entry No.';
        }
        field(2; "Serv. Item Code"; Code[20])
        {
            Caption = 'Service Item Code';
            TableRelation = "Service Item";
        }
        field(3; "Operation Code"; Code[20])
        {
            Caption = 'Operation Code';
            TableRelation = Operations_LDR;
        }
        field(4; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(5; "Operation Type"; Option)
        {
            Caption = 'Operation Type';
            OptionCaption = 'Administrative,Technical';
            OptionMembers = Administrative,Technical;
        }
        field(6; "Period Type"; Option)
        {
            Caption = 'Period Type';
            OptionCaption = 'Time,Hours,None';
            OptionMembers = Time,Hours,"None";
        }
        field(7; "Creation Date"; Date)
        {
            Caption = 'Creation Date';
        }
        field(8; "Next Planned Date"; Date)
        {
            Caption = 'Next Planned Date';
        }
        field(9; "Last Planned Date"; Date)
        {
            Caption = 'Last Planned Date';
        }
        field(10; "Next Planned Hours"; Integer)
        {
            Caption = 'Next Planned Hours';
        }
        field(11; "Actual Hours"; Integer)
        {
            Caption = 'Actual Hours';
        }
        field(12; "Last Planned Hours"; Integer)
        {
            Caption = 'Last Planned Hours';
        }
        field(13; Closed; BoolEAN)
        {
            Caption = 'Closed';
        }
        field(14; "Serv. Order No."; Code[20])
        {
            Caption = 'Service Order No.';
        }
        field(15; "Serv. Item Counter Code"; Integer)
        {
            Caption = 'Serv. Item Counter Code';
            TableRelation = "Service Item Counter_LDR"."Counter No." WHERE("Code" = FIELD("Serv. Item Code"));
        }
        field(16; "Serv. Item Counter Description"; Text[50])
        {
            CalcFormula = Lookup("Service Item Counter_LDR"."Description" WHERE("Code" = FIELD("Serv. Item Code"),
                                                                           "Counter No." = FIELD("Serv. Item Counter Code")));
            Caption = 'Serv. Item Counter Description';
            FieldClass = FlowField;
        }
        field(17; "Period Value - Date"; DateFormula)
        {
            Caption = 'Periodicity';
        }
        field(18; "Period Value - Hours"; Integer)
        {
            Caption = 'Periodicity';
        }
        field(19; "Self/External"; Option)
        {
            Caption = 'Self/External';
            OptionCaption = 'Self,External';
            OptionMembers = Self,External;
        }
        field(20; "Serv. Item Description"; Text[100])
        {
            CalcFormula = Lookup("Service Item"."Description" WHERE("No." = FIELD("Serv. Item Code")));
            Caption = 'Service Item Description';
            FieldClass = FlowField;
        }
        field(21; "Requested Resource No."; Code[10])
        {
            Caption = 'Requested Resource No.';
            TableRelation = "Resource"."No." WHERE("Type" = CONST("Person"));
        }
        field(22; "Requested Resource Name"; Text[50])
        {
            CalcFormula = Lookup("Resource"."Name" WHERE("No." = FIELD("Requested Resource No.")));
            Caption = 'Requested Resource Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(23; Urgent; BoolEAN)
        {
            Caption = 'Urgent';
        }
        field(24; "Serv. Order Type"; Code[10])
        {
            Caption = 'Service Order Type';
            TableRelation = "Service Order Type";

            trigger OnValidate()
            var
                CraneMgtSetup: Record "Crane Mgt. Setup_LDR";
            begin
            end;
        }
        field(25; "Execution Date"; Date)
        {
            Caption = 'Execution Date';
        }
        field(26; "Serv. Item Planner No"; Code[20])
        {
            CalcFormula = Lookup("Service Item"."Planner No_LDR" WHERE("No." = FIELD("Serv. Item Code")));
            Caption = 'Planner No';
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
        key(Key2; "Serv. Item Code", "Operation Code", "Next Planned Date")
        {
        }
        key(Key3; "Serv. Item Code", "Operation Code", "Next Planned Hours")
        {
        }
        key(Key4; "Serv. Item Code", "Creation Date")
        {
        }
    }

    fieldgroups
    {
    }
}