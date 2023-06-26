/// <summary>
/// Table Employee Expenses_LDR (ID 50019)
/// </summary>
table 50019 "Employee Expenses_LDR"
{
    Caption = 'Employee Expenses';

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            NotBlank = true;
            TableRelation = Employee;

            trigger OnValidate()
            var
                Employee: Record "Employee";
            begin
                IF Employee.GET("Employee No.") THEN BEGIN
                    "Employee Name" := Employee.Name + ' ' + Employee."First Family Name" + ' ' + Employee."Second Family Name";
                    "Resource No." := Employee."Resource No.";
                    "Entry Time" := Employee."Journey Starting Time_LDR";
                    "Exit Time" := Employee."Journey Ending Time_LDR";
                END;
                UpdateCapacityPlanned;
                UpdateRealWorks;
                Events := Real - "Planned Hours";
            end;
        }
        field(2; Date; Date)
        {
            Caption = 'Date';
            NotBlank = true;
        }
        field(3; "Employee Name"; Text[90])
        {
            Caption = 'Name';
        }
        field(4; "Resource No."; Code[10])
        {
            Caption = 'Resource No.';
            TableRelation = Resource;
        }
        field(5; "Planned Hours"; Decimal)
        {
            Caption = 'Planned';
        }
        field(6; Real; Decimal)
        {
            Caption = 'Real';
        }
        field(7; Balance; Decimal)
        {
            Caption = 'Balance';
        }
        field(8; Events; Decimal)
        {
            Caption = 'Events';
        }
        field(9; "Entry Time"; Time)
        {
            Caption = 'Entry time';
        }
        field(10; "Exit Time"; Time)
        {
            Caption = 'Exit Time';
        }
        field(11; "Bonus Calculated"; BoolEAN)
        {
            Caption = 'Bonus Calculated';
        }
    }

    keys
    {
        key(Key1; "Employee No.", Date)
        {
            Clustered = true;
        }
        key(Key2; Date, "Employee No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        Employee: Record "Employee";
    begin
    end;

    /// <summary>
    /// UpdateCapacityPlanned()
    /// </summary>
    procedure UpdateCapacityPlanned()
    var
        ResCapEntry: Record "Res. Capacity Entry";
    begin
        IF (Date <> 0D) AND ("Resource No." <> '') THEN BEGIN
            CLEAR(ResCapEntry);
            ResCapEntry.SETRANGE("Resource No.", "Resource No.");
            ResCapEntry.SETRANGE(Date, Date);
            ResCapEntry.CALCSUMS(Capacity);
        END;

        VALIDATE("Planned Hours", ResCapEntry.Capacity);
    end;

    /// <summary>
    /// UpdateRealWorks()
    /// </summary>
    procedure UpdateRealWorks()
    var
        CraneMgtSetup: Record "Crane Mgt. Setup_LDR";
        ResLedgerEntry: Record "Res. Ledger Entry";
        UnitofMeasure: Record "Unit of Measure";
        UnifOfMeasureFilter: Text;
        bInclude: BoolEAN;
    begin
        CraneMgtSetup.GET;
        IF (Date <> 0D) AND ("Resource No." <> '') THEN BEGIN

            // buscar las unidades de medida de tipo tiempo y crear filtro
            CLEAR(UnitofMeasure);
            UnitofMeasure.SETRANGE("Time Measure Unit_LDR", TRUE);
            IF UnitofMeasure.FINDSET THEN BEGIN
                REPEAT
                    bInclude := FALSE;
                    IF CraneMgtSetup."Lunch Time UOM" <> '' THEN BEGIN
                        IF UnitofMeasure.Code <> CraneMgtSetup."Lunch Time UOM" THEN
                            bInclude := TRUE;
                    END ELSE
                        bInclude := TRUE;

                    IF bInclude THEN BEGIN
                        IF UnifOfMeasureFilter = '' THEN
                            UnifOfMeasureFilter += UnitofMeasure.Code
                        ELSE
                            UnifOfMeasureFilter += '|' + UnitofMeasure.Code;
                    END;
                UNTIL UnitofMeasure.NEXT = 0;
            END;

            CLEAR(ResLedgerEntry);
            ResLedgerEntry.SETRANGE("Resource No.", "Resource No.");
            ResLedgerEntry.SETRANGE("Posting Date", Date);
            ResLedgerEntry.SETFILTER("Unit of Measure Code", UnifOfMeasureFilter);
            ResLedgerEntry.CALCSUMS(Quantity);
        END;

        VALIDATE(Real, ResLedgerEntry.Quantity);
    end;

    /// <summary>
    /// UpdateEvents()
    /// </summary>
    procedure UpdateEvents()
    var
        ResCapEntry: Record "Res. Capacity Entry";
    begin
        IF (Date <> 0D) AND ("Resource No." <> '') THEN BEGIN
            VALIDATE(Events, Real - "Planned Hours");
        END;
    end;
}