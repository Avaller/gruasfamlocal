/// <summary>
/// Table Accumulated Employee Hours_LDR (ID 50226)
/// </summary>
table 50226 "Accumulated Employee Hours_LDR"
{
    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Employee No."; Code[10])
        {
            Caption = 'Employee No.';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Employee"."No.";

            trigger OnValidate()
            var
                Employee: Record "Employee";
            begin
                IF "Employee No." <> '' THEN BEGIN
                    IF Employee.GET("Employee No.") THEN
                        "Employee Name" := Employee.Name
                    ELSE
                        "Employee Name" := '';
                END ELSE
                    "Employee Name" := '';
            end;
        }
        field(3; "Employee Name"; Text[30])
        {
            Caption = 'Employee Name';
            Editable = false;
        }
        field(4; "Date"; Date)
        {
            Caption = 'Date';
            DataClassification = ToBeClassified;
        }
        field(5; "Due Date"; Date)
        {
            Caption = 'Due Date';
            DataClassification = ToBeClassified;
        }
        field(6; Hours; Decimal)
        {
            Caption = 'Hours';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Remaining Hours" := Hours;
            end;
        }
        field(7; "Complete Compensation"; BoolEAN)
        {
            Caption = 'Complete Compensation';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(8; "Remaining Hours"; Decimal)
        {
            Caption = 'Remaining Hours';
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                "Complete Compensation" := "Remaining Hours" = 0;
            end;
        }
        field(9; "Week Day Type"; Option)
        {
            Caption = 'Week Day Type';
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Weekday,Weekend';
            OptionMembers = Weekday,Weekend;
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