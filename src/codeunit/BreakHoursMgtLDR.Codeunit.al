/// <summary>
/// Codeunit Break Hours Mgt._LDR (ID 50200)
/// </summary>
codeunit 50200 "Break Hours Mgt._LDR"
{
    trigger OnRun()
    var
        Text001: Label 'Do you want to launch the task to load all the employee accumulated hours?';
    begin
        IF GUIALLOWED THEN
            IF NOT CONFIRM(Text001) THEN
                EXIT;
        Code;
        MESSAGE('Proceso terminado.');
    end;

    var
        Company: Record "Company";
        ResLedgerEntry: Record "Res. Ledger Entry";
        ResourcesSetup: Record "Resources Setup";
        StartingDate: Date;
        EndingDate: Date;
        Resource: Record "Resource";
        CraneMgtSetup: Record "Crane Mgt. Setup_LDR";
        Dates: Record "Date";
        BreakHoursCalculationSetup: Record "Break Hours Calculat Setup_LDR";

    /// <summary>
    /// "Code"()
    /// </summary>
    procedure "Code"()
    begin
        ResourcesSetup.GET;
        ResourcesSetup.TESTFIELD("Process Delay");
        ResourcesSetup.TESTFIELD("Break Hours Weekdays");
        ResourcesSetup.TESTFIELD("Break Hours Weekend");
        IF ResourcesSetup."Last Process Date" <> 0D THEN
            StartingDate := ResourcesSetup."Last Process Date" + 1
        ELSE
            StartingDate := ResourcesSetup."Starting Process Date";
        EndingDate := CALCDATE(ResourcesSetup."Process Delay", WORKDATE);

        CraneMgtSetup.GET;
        CraneMgtSetup.TESTFIELD("Driver Resource Group");
        CraneMgtSetup.TESTFIELD("Normal Resource Group");
        CraneMgtSetup.TESTFIELD("Special Resource Group");
        CraneMgtSetup.TESTFIELD("Food Work Type Code");
        CraneMgtSetup.TESTFIELD("Aux Veh. Travel Work Type");
        CraneMgtSetup.TESTFIELD("Self Veh. Travel Work Type");

        Dates.SETRANGE("Period Type", Dates."Period Type"::Date);
        Dates.SETFILTER("Period Start", '>=%1&<=%2', StartingDate, EndingDate);
        IF Dates.FINDSET THEN BEGIN
            REPEAT
                CLEAR(Resource);
                Resource.SETRANGE("Company Dependence_LDR", COMPANYNAME);
                Resource.SETFILTER("Resource Group No.", '%1|%2|%3', CraneMgtSetup."Driver Resource Group", CraneMgtSetup."Normal Resource Group", CraneMgtSetup."Special Resource Group");
                IF Resource.FINDSET THEN BEGIN
                    REPEAT
                        CLEAR(BreakHoursCalculationSetup);
                        BreakHoursCalculationSetup.GET(DATE2DWY(Dates."Period Start", 1) - 1);
                        CASE BreakHoursCalculationSetup."Calculation Type" OF
                            BreakHoursCalculationSetup."Calculation Type"::"Break Hours":
                                BEGIN
                                    BreakHoursCalc();
                                END;
                            BreakHoursCalculationSetup."Calculation Type"::"Break Hour Start":
                                BEGIN
                                    BreakHourStartCalc();
                                END;
                        END;
                        ;
                    UNTIL Resource.NEXT = 0;
                END;
            UNTIL Dates.NEXT = 0;

            ResourcesSetup.GET;
            ResourcesSetup."Last Process Date" := EndingDate;
            ResourcesSetup.MODIFY;
        END;
    end;

    /// <summary>
    /// CreateAccumulatedHoursEntry()
    /// </summary>
    local procedure CreateAccumulatedHoursEntry(ResourceNo: Text; EntryDate: Date; HoursQty: Decimal)
    var
        AccumulatedEmployeeHours: Record "Accumulated Employee Hours_LDR";
        Employee: Record "Employee";
        ResourcesSetup: Record "Resources Setup";
    begin
        Employee.SETRANGE("Resource No.", ResourceNo);
        Employee.FINDFIRST;

        ResourcesSetup.GET;
        ResourcesSetup.TESTFIELD("Calc. Time Weekday Due Date");
        ResourcesSetup.TESTFIELD("Calc. Time Weekend Due Date");

        AccumulatedEmployeeHours.INIT;
        AccumulatedEmployeeHours.VALIDATE("Employee No.", Employee."No.");
        AccumulatedEmployeeHours.VALIDATE(Date, EntryDate);
        AccumulatedEmployeeHours.VALIDATE(Hours, HoursQty);

        IF DATE2DWY(EntryDate, 1) IN [1, 2, 3, 4, 5] THEN BEGIN // Entre semana. (de Lunes a Martes, Martes a Miércoles…Viernes a Sábado)
            AccumulatedEmployeeHours.VALIDATE("Due Date", CALCDATE(ResourcesSetup."Calc. Time Weekday Due Date", EntryDate));
            AccumulatedEmployeeHours.VALIDATE("Week Day Type", AccumulatedEmployeeHours."Week Day Type"::Weekday);
        END ELSE BEGIN // fines de semana. (Desde sábado a las 12h a Domingo 24h)
            AccumulatedEmployeeHours.VALIDATE("Due Date", CALCDATE(ResourcesSetup."Calc. Time Weekend Due Date", EntryDate));
            AccumulatedEmployeeHours.VALIDATE("Week Day Type", AccumulatedEmployeeHours."Week Day Type"::Weekend);
        END;

        AccumulatedEmployeeHours.INSERT(TRUE);
    end;

    /// <summary>
    /// BreakHoursCalc()
    /// </summary>
    local procedure BreakHoursCalc()
    var
        LatestHour: Time;
        EarliestHour: Time;
        NextDate: Date;
        BreakHoursQty: Decimal;
        RealBreakHoursQty: Decimal;
        LatestHourFound: BoolEAN;
    begin
        // Calculamos en base a un numero de horas que debe descansar el empleado desde que ACABA la jornada hasta que EMPIEZA la siguiente.

        // ----------- BEGIN
        // Recorremos todas las empresas, por cada una de ellas, recorremos los movs.recurso del empleado X y obtenemos:
        // El fin de jornada del dia especifico
        CLEAR(EarliestHour);
        CLEAR(LatestHour);
        CLEAR(NextDate);
        CLEAR(LatestHourFound);
        IF Company.FINDSET THEN
            REPEAT
                CLEAR(ResLedgerEntry);
                ResLedgerEntry.CHANGECOMPANY(Company.Name);
                ResLedgerEntry.SETRANGE("Posting Date", Dates."Period Start");
                ResLedgerEntry.SETRANGE("Resource No.", Resource."No.");
                ResLedgerEntry.SETRANGE(Replicated_LDR, FALSE);
                SetWorkTypeCodeFilter(ResLedgerEntry);
                IF ResLedgerEntry.FINDSET THEN BEGIN
                    REPEAT
                        LatestHourFound := TRUE;
                        IF (LatestHour = 0T) OR (ResLedgerEntry."End Time_LDR" > LatestHour) THEN BEGIN
                            LatestHour := ResLedgerEntry."End Time_LDR";
                        END;
                    UNTIL ResLedgerEntry.NEXT = 0;
                END;
            UNTIL Company.NEXT = 0;
        // ----------- END

        // ----------- BEGIN
        // Si hemos encontrado movs.recurso para ese dia, recorremos de nuevo todas las empresas, por cada una de ellas, recorremos los movs.recurso del empleado X para la fecha siguiente que se encuentre
        IF LatestHourFound THEN BEGIN
            IF Company.FINDSET THEN
                REPEAT
                    CLEAR(ResLedgerEntry);
                    ResLedgerEntry.CHANGECOMPANY(Company.Name);
                    ResLedgerEntry.SETFILTER("Posting Date", '>%1', Dates."Period Start");
                    ResLedgerEntry.SETRANGE("Resource No.", Resource."No.");
                    ResLedgerEntry.SETRANGE(Replicated_LDR, FALSE);
                    SetWorkTypeCodeFilter(ResLedgerEntry);
                    IF ResLedgerEntry.FINDFIRST THEN BEGIN
                        NextDate := ResLedgerEntry."Posting Date";

                        CLEAR(ResLedgerEntry);
                        ResLedgerEntry.CHANGECOMPANY(Company.Name);
                        ResLedgerEntry.SETRANGE("Posting Date", NextDate);
                        ResLedgerEntry.SETRANGE("Resource No.", Resource."No.");
                        ResLedgerEntry.SETRANGE(Replicated_LDR, FALSE);
                        SetWorkTypeCodeFilter(ResLedgerEntry);
                        IF ResLedgerEntry.FINDSET THEN
                            REPEAT
                                IF (EarliestHour = 0T) OR (ResLedgerEntry."Initial Time_LDR" < EarliestHour) THEN
                                    EarliestHour := ResLedgerEntry."Initial Time_LDR"; //Obtenemos cuando inicia la jornada el empleado el dia siguiente
                            UNTIL ResLedgerEntry.NEXT = 0;

                        IF (NextDate = 0D) THEN BEGIN
                            NextDate := ResLedgerEntry."Posting Date";
                            EarliestHour := ResLedgerEntry."Initial Time_LDR";
                        END ELSE
                            IF (NextDate > ResLedgerEntry."Posting Date") THEN BEGIN
                                NextDate := ResLedgerEntry."Posting Date";
                                EarliestHour := ResLedgerEntry."Initial Time_LDR";
                            END ELSE
                                IF (NextDate = ResLedgerEntry."Posting Date") AND (EarliestHour > ResLedgerEntry."Initial Time_LDR") THEN BEGIN
                                    EarliestHour := ResLedgerEntry."Initial Time_LDR";
                                END;
                    END;
                UNTIL Company.NEXT = 0;

            IF (NextDate <> 0D) AND (EarliestHour <> 0T) THEN BEGIN
                BreakHoursQty := BreakHoursCalculationSetup."Break Hours";

                RealBreakHoursQty := (CREATEDATETIME(NextDate, EarliestHour) - CREATEDATETIME(Dates."Period Start", LatestHour)) / 3600000;
                IF BreakHoursQty > RealBreakHoursQty THEN
                    CreateAccumulatedHoursEntry(Resource."No.", Dates."Period Start", BreakHoursQty - RealBreakHoursQty); // Creamos el registro
            END;
        END
    end;

    /// <summary>
    /// BreakHourStartCalc()
    /// </summary>
    local procedure BreakHourStartCalc()
    var
        LatestHour: Time;
        EarliestHour: Time;
        NextDate: Date;
        HoursQty: Decimal;
        LatestHourFound: BoolEAN;
    begin
        // Calculamos en base a una hora inicial, a partir de la cual, las horas que se inputen en ese día se contarán como horas a devolver.
        CLEAR(EarliestHour);
        CLEAR(LatestHour);
        CLEAR(NextDate);
        CLEAR(LatestHourFound);
        IF Company.FINDSET THEN
            REPEAT
                CLEAR(ResLedgerEntry);
                ResLedgerEntry.CHANGECOMPANY(Company.Name);
                ResLedgerEntry.SETRANGE("Posting Date", Dates."Period Start");
                ResLedgerEntry.SETFILTER("End Time_LDR", '>=%1', BreakHoursCalculationSetup."Break Hour Start");
                ResLedgerEntry.SETRANGE("Resource No.", Resource."No.");
                ResLedgerEntry.SETRANGE(Replicated_LDR, FALSE);
                SetWorkTypeCodeFilter(ResLedgerEntry);
                IF ResLedgerEntry.FINDSET THEN BEGIN
                    REPEAT
                        LatestHourFound := TRUE;
                        //      IF (LatestHour = 0T) OR (ResLedgerEntry."End Time" > LatestHour) THEN BEGIN
                        //        LatestHour := ResLedgerEntry."End Time";
                        //      END;
                        //      IF (EarliestHour = 0T) OR (ResLedgerEntry."Initial Time" < EarliestHour) THEN BEGIN
                        //        IF (ResLedgerEntry."Initial Time" < BreakHoursCalculationSetup."Break Hour Start") THEN
                        //          EarliestHour := BreakHoursCalculationSetup."Break Hour Start"
                        //        ELSE
                        //          EarliestHour := ResLedgerEntry."Initial Time";
                        //      END;
                        IF (ResLedgerEntry."Initial Time_LDR" < BreakHoursCalculationSetup."Break Hour Start") THEN
                            HoursQty += (CREATEDATETIME(Dates."Period Start", ResLedgerEntry."End Time_LDR") - CREATEDATETIME(Dates."Period Start", BreakHoursCalculationSetup."Break Hour Start")) / 3600000
                        ELSE
                            HoursQty += (CREATEDATETIME(Dates."Period Start", ResLedgerEntry."End Time_LDR") - CREATEDATETIME(Dates."Period Start", ResLedgerEntry."Initial Time_LDR")) / 3600000;
                    UNTIL ResLedgerEntry.NEXT = 0;
                END;
            UNTIL Company.NEXT = 0;

        IF LatestHourFound THEN BEGIN
            //IF (EarliestHour <> 0T) THEN BEGIN

            //HoursQty := (CREATEDATETIME(Dates."Period Start",LatestHour) - CREATEDATETIME(Dates."Period Start",EarliestHour)) / 3600000;
            IF HoursQty > 0 THEN
                CreateAccumulatedHoursEntry(Resource."No.", Dates."Period Start", HoursQty);
            //END;
        END
    end;

    /// <summary>
    /// SetWorkTypeCodeFilter()
    /// </summary>
    local procedure SetWorkTypeCodeFilter(var pResLedgerEntry: Record "Res. Ledger Entry")
    begin
        pResLedgerEntry.SETFILTER("Work Type Code", STRSUBSTNO('<>%1&<>%2&<>%3', CraneMgtSetup."Food Work Type Code", CraneMgtSetup."Aux Veh. Travel Work Type", CraneMgtSetup."Self Veh. Travel Work Type"));
    end;
}