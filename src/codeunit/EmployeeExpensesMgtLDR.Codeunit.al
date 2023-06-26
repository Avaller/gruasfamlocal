/// <summary>
/// Codeunit Employee Expenses Mgt_LDR (ID 50012)
/// </summary>
codeunit 50012 "Employee Expenses Mgt_LDR"
{
    trigger OnRun()
    begin
        CreateOrUpdateExpenses;
    end;

    var
        PlannedH: Decimal;
        RealH: Decimal;
        Events: Decimal;

    /// <summary>
    /// CreateOrUpdateExpenses()
    /// </summary>
    procedure CreateOrUpdateExpenses()
    var
        Employee: Record "Employee";
        ResLedgerEntry: Record "Res. Ledger Entry";
        EmplExpensesJustification: Record "Empl. Expenses Justificat_LDR";
        EmployeeExpenses: Record "Employee Expenses_LDR";
    begin
        ResLedgerEntry.SETRANGE("Posting Date", CALCDATE('<-1M>', WORKDATE), WORKDATE);
        IF ResLedgerEntry.FINDSET THEN BEGIN
            REPEAT
                //Obtener el empleado
                CLEAR(Employee);
                Employee.SETRANGE("Resource No.", ResLedgerEntry."Resource No.");
                Employee.FINDFIRST;
                IF NOT Employee."Avoid Expenses_LDR" THEN BEGIN
                    EmployeeExpenses.RESET;
                    EmployeeExpenses.SETRANGE(Date, ResLedgerEntry."Posting Date");
                    EmployeeExpenses.SETRANGE("Resource No.", ResLedgerEntry."Resource No.");
                    IF NOT EmployeeExpenses.FINDFIRST THEN BEGIN
                        CreateNewEntry(ResLedgerEntry."Posting Date", ResLedgerEntry."Resource No.")
                    END ELSE BEGIN
                        UpdateEntry(ResLedgerEntry."Posting Date", ResLedgerEntry."Resource No.");
                    END;
                END;
            UNTIL ResLedgerEntry.NEXT = 0;
        END;

        EmplExpensesJustification.SETRANGE(Date, CALCDATE('<-1M>', WORKDATE), WORKDATE);
        IF EmplExpensesJustification.FINDSET THEN BEGIN
            REPEAT
                //Obtener el empleado
                Employee.GET(EmplExpensesJustification."Employee No.");
                IF NOT Employee."Avoid Expenses_LDR" THEN BEGIN
                    EmployeeExpenses.RESET;
                    EmployeeExpenses.SETRANGE(Date, EmplExpensesJustification.Date);
                    EmployeeExpenses.SETRANGE("Resource No.", EmplExpensesJustification."Resource No.");
                    IF NOT EmployeeExpenses.FINDFIRST THEN BEGIN
                        CreateNewEntry(EmplExpensesJustification.Date, EmplExpensesJustification."Resource No.");
                    END ELSE BEGIN
                        UpdateEntry(EmplExpensesJustification.Date, EmplExpensesJustification."Resource No.");
                    END;
                END;
            UNTIL EmplExpensesJustification.NEXT = 0;
        END;
    end;

    /// <summary>
    /// CreateNewEntry()
    /// </summary>
    procedure CreateNewEntry(NewDate: Date; NewResource: Code[20])
    var
        Employee: Record "Employee";
        EmployeeExpenses: Record "Employee Expenses_LDR";
        text001: Label 'There is more than one employee assigned to resource number %1';
    begin
        Employee.SETRANGE("Resource No.", NewResource);
        IF Employee.FINDSET THEN BEGIN
            IF Employee.COUNT > 1 THEN
                MESSAGE(text001, NewResource);

            EmployeeExpenses.INIT;
            EmployeeExpenses.VALIDATE(Date, NewDate);
            EmployeeExpenses.VALIDATE("Employee No.", Employee."No.");
            EmployeeExpenses.UpdateCapacityPlanned;
            EmployeeExpenses.UpdateRealWorks;
            EmployeeExpenses.UpdateEvents;
            EmployeeExpenses.INSERT;
        END ELSE BEGIN
            CLEAR(Employee);
            Employee.SETRANGE("No.", NewResource);
            IF Employee.FINDSET THEN BEGIN
                IF Employee.COUNT > 1 THEN
                    MESSAGE(text001, NewResource);
                EmployeeExpenses.INIT;
                EmployeeExpenses.VALIDATE(Date, NewDate);
                EmployeeExpenses.VALIDATE("Employee No.", Employee."No.");
                EmployeeExpenses.UpdateCapacityPlanned;
                EmployeeExpenses.UpdateRealWorks;
                EmployeeExpenses.UpdateEvents;
                EmployeeExpenses.INSERT;
            END;
        END;
    end;

    /// <summary>
    /// UpdateEntry()
    /// </summary>
    local procedure UpdateEntry(NewDate: Date; ResourceNo: Code[20])
    var
        Employee: Record "Employee";
        EmployeeExpenses: Record "Employee Expenses_LDR";
        Expense: Decimal;
        text001: Label 'There is more than one employee assigned to resource number %1';
    begin

        Employee.SETRANGE("Resource No.", ResourceNo);
        IF Employee.FINDSET THEN BEGIN
            IF Employee.COUNT > 1 THEN
                MESSAGE(text001, ResourceNo);

            EmployeeExpenses.VALIDATE(Date, NewDate);
            EmployeeExpenses.VALIDATE("Employee No.", Employee."No.");
            EmployeeExpenses.UpdateCapacityPlanned;
            EmployeeExpenses.UpdateRealWorks;
            EmployeeExpenses.UpdateEvents;
            EmployeeExpenses.MODIFY;
        END;
    end;
}