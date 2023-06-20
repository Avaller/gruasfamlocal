/// <summary>
/// Table Displacement Entry_LDR (ID 50050)
/// </summary>
table 50050 "Displacement Entry_LDR"
{
    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Entry No.';
        }
        field(2; "Resource No."; Code[20])
        {
            Caption = 'Resource No.';
            TableRelation = Resource WHERE(Type = CONST(Person));

            trigger OnValidate()
            var
                Emp: Record "Employee";
            begin
                //Obtenemos el empleado asociado al recurso.
                CLEAR(Emp);
                Emp.SETRANGE("Resource No.", Rec."Resource No.");
                IF NOT Emp.FINDFIRST THEN
                    ERROR(Text003, Rec."Resource No.");

                VALIDATE("Employee No.", Emp."No.");
            end;
        }
        field(3; "Resource Name"; Text[50])
        {
            CalcFormula = Lookup("Resource"."Name" WHERE("No." = FIELD("Resource No.")));
            Caption = 'Resource Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(4; "Displacement Type"; Option)
        {
            Caption = 'Displacement Type';
            OptionCaption = 'ServItem,Vehicle,Self/Others';
            OptionMembers = ServItem,Vehicle,"Self/Others";
        }
        field(5; "Code"; Code[20])
        {
            Caption = 'Code';
            TableRelation = IF ("Displacement Type" = CONST("ServItem")) "Service Item" WHERE("Displacement Vehicle_LDR" = CONST(true))
            ELSE
            IF ("Displacement Type" = CONST("Vehicle")) "Resource" WHERE("Type" = CONST("Machine"));
        }
        field(6; "Initial Time"; Time)
        {
            Caption = 'Initial Time';

            trigger OnValidate()
            begin
                IF "Ending Time" <> 0T THEN BEGIN
                    IF "Ending Time" < "Initial Time" THEN
                        ERROR(Text001);

                    VALIDATE(Quantity, ROUND(("Ending Time" - "Initial Time") / 3600000, 0.00001));
                END;
            end;
        }
        field(7; "Ending Time"; Time)
        {
            Caption = 'Ending Time';

            trigger OnValidate()
            begin
                // BEGIN: ALQUINTA
                IF "Initial Time" <> 0T THEN BEGIN
                    IF "Ending Time" < "Initial Time" THEN
                        ERROR(Text002);

                    VALIDATE(Quantity, ROUND(("Ending Time" - "Initial Time") / 3600000, 0.00001));
                END;
            end;
        }
        field(8; Quantity; Decimal)
        {
            Caption = 'Quantity';
        }
        field(9; UOM; Code[10])
        {
            Caption = 'Unit of Measure Code';
        }
        field(10; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = Employee;
        }
        field(11; "Employee Name"; Text[50])
        {
            CalcFormula = Lookup("Employee"."Name" WHERE("No." = FIELD("Employee No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(12; Description; Text[50])
        {
            Caption = 'Description';
            Editable = false;
        }
        field(13; Date; Date)
        {
            Caption = 'Displacement Date';
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

    var
        Text001: Label 'Starting Time is bigger than End Time';
        Text002: Label 'End Time is lower than Starting Time';
        Text003: Label 'There is no employee associated with Resource No. %1';
}