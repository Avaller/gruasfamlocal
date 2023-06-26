/// <summary>
/// Table Break Hours Compensation_LDR (ID 50227)
/// </summary>
table 50227 "Break Hours Compensation_LDR"
{
    fields
    {
        field(1; "Accumulated Hours Entry No."; Integer)
        {
            Caption = 'Accumulated Hours Entry No.';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Accumulated Employee Hours_LDR"."Entry No.";
        }
        field(2; "Entry No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;
        }
        field(3; Date; Date)
        {
            Caption = 'Date';
            DataClassification = ToBeClassified;
        }
        field(4; "Starting Hour"; Time)
        {
            Caption = 'Starting Hour';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                UpdateHours();
            end;
        }
        field(5; "Ending Hour"; Time)
        {
            Caption = 'Ending Hour';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                UpdateHours();
            end;
        }
        field(6; Hours; Decimal)
        {
            Caption = 'Hours';
            DataClassification = ToBeClassified;
        }
        field(7; "Absence Cause"; Code[10])
        {
            Caption = 'Absence Cause';
            DataClassification = ToBeClassified;
        }
        field(8; Posted; BoolEAN)
        {
            Caption = 'Posted';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(9; "Employee No."; Code[10])
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
        field(10; "Employee Name"; Text[30])
        {
            Caption = 'Employee Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Accumulated Hours Entry No.", "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        TESTFIELD(Posted, FALSE);
    end;

    trigger OnInsert()
    var
        ResourcesSetup: Record "Resources Setup";
    begin
        ResourcesSetup.GET;
        ResourcesSetup.TESTFIELD("Absence Cause_LDR");
        "Absence Cause" := ResourcesSetup."Absence Cause_LDR";
    end;

    /// <summary>
    /// UpdateHours()
    /// </summary>
    local procedure UpdateHours()
    begin
        IF ("Ending Hour" <> 0T) AND ("Starting Hour" <> 0T) THEN
            Hours := ("Ending Hour" - "Starting Hour") / 3600000
        ELSE
            Hours := 0;
    end;

    /// <summary>
    /// PostEntry()
    /// </summary>
    procedure PostEntry()
    var
        AccumulatedEmployeeHours: Record "Accumulated Employee Hours_LDR";
        TxtError001: Label 'The introduced hours are incorrect.';
        EmployeeAbsence: Record "Employee Absence";
        TxtError002: Label 'There''s already an employee absence in that date.';
    begin
        AccumulatedEmployeeHours.GET("Accumulated Hours Entry No.");

        IF (Hours = 0) OR (Hours > AccumulatedEmployeeHours."Remaining Hours") THEN
            ERROR(TxtError001);

        EmployeeAbsence.SETRANGE("Employee No.", Rec."Employee No.");
        EmployeeAbsence.SETFILTER("From Date", '>=%1', Rec.Date);
        EmployeeAbsence.SETFILTER("To Date", '<=%1', Rec.Date);
        IF NOT EmployeeAbsence.ISEMPTY THEN
            ERROR(TxtError002);

        CLEAR(EmployeeAbsence);
        EmployeeAbsence.INIT;
        EmployeeAbsence.VALIDATE("Employee No.", Rec."Employee No.");
        EmployeeAbsence.VALIDATE("From Date", Rec.Date);
        EmployeeAbsence.VALIDATE("To Date", Rec.Date);
        EmployeeAbsence.VALIDATE("Cause of Absence Code", Rec."Absence Cause");
        EmployeeAbsence.VALIDATE(Quantity, Rec.Hours);
        EmployeeAbsence.VALIDATE("To Time_LDR", Rec."Ending Hour");
        EmployeeAbsence.VALIDATE("From Time_LDR", Rec."Starting Hour");
        EmployeeAbsence.VALIDATE("Accumulated Hours Entry No._LDR", Rec."Accumulated Hours Entry No.");
        EmployeeAbsence.INSERT(TRUE);

        Rec.VALIDATE(Posted, TRUE);
        Rec.MODIFY;

        AccumulatedEmployeeHours.GET("Accumulated Hours Entry No.");
        AccumulatedEmployeeHours.VALIDATE("Remaining Hours", AccumulatedEmployeeHours."Remaining Hours" - Rec.Hours);
        AccumulatedEmployeeHours.MODIFY;
    end;
}