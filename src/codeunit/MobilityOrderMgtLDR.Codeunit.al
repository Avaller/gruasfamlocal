/// <summary>
/// Codeunit Mobility Order Mgt._LDR (ID 50006)
/// </summary>
codeunit 50006 "Mobility Order Mgt._LDR"
{
    /*
    trigger OnRun()
    begin
    end;

    var
        Companyinfo: Record "Company Information";
        CraneMgtSetup: Record "Crane Mgt. Setup_LDR";
        ServiceMgtSetup: Record "Service Mgt. Setup";
        Text004: Label 'There is no Serv. Item Counter with Terminal Code %1 for Serv. Item No. %2';
        Text001: Label 'There is no employee associated with Resource No. %1';
        Text002: Label 'The type of expense %2 was not found for Employee No %1';
        Text003: Label 'The Expenses Code %2 was not found for Employee No %1';
        PlannerMgt: Codeunit "Planner Mgt._LDR";

    /// <summary>
    /// InsertServLines()
    /// </summary>
    procedure InsertServLines(pServOrderNo: Code[20]; pServItemLineNo: Integer; pType: Option " ",Item,Resource,Cost,"G/L Account"; pNo: Code[20]; pQty2Invoice: Decimal; pQty: Decimal; pStartingTime: Text[6]; pEndingTime: Text[6]; pDate: Text[8]; pUOM: Code[10])
    var
        ServHeader: Record "Service Header";
        ServItemLine: Record "Service Item Line";
        lDate: Date;
        lStartingTime: Time;
        lEndingTime: Time;
        Res: Record "Resource";
        BaseCalendarCode: Code[10];
        DayType: Option Workday,Saturday,Holiday,LocalHoliday;
        HourType: Option Day,Night;
        RateHeader: Record "Service Item Rate Header_LDR";
        StartingPeriodTime: Time;
        EndingPeriodTime: Time;
    begin
        //Esta funcion global actua de punto de entrada de datos para la aplicacion de movilidad. Recibirá una linea unica por
        //fraccion de tiempo, que será procesada dentro de Dynamics NAV para subdividirla en las lineas necesarias para la correcta imputacion
        //de tiempos segun los horarios de la tarifa asignada, y posteriormente de calendarios de los empleados

        CraneMgtSetup.GET;
        ServiceMgtSetup.GET;

        //Recuperamos la linea de producto de servicio
        CLEAR(ServHeader);
        CLEAR(ServItemLine);
        ServHeader.GET(ServHeader."Document Type"::Order, pServOrderNo);
        ServItemLine.GET(ServHeader."Document Type", pServOrderNo, pServItemLineNo);
        ServItemLine.TESTFIELD("Service Item No.");

        //Evaluamos las variables de texto en variables correctas.
        EVALUATE(lDate, pDate);
        EVALUATE(lStartingTime, pStartingTime);
        EVALUATE(lEndingTime, pEndingTime);

        //Obtenemos el Recurso
        IF pType = pType::Resource THEN BEGIN
            Res.GET(pNo);
            //Clasificamos el dia segun Laborable, SAbado o Festivo para el recurso actual. Se devuelve el dato en variable local por referencia
            GetDayType(Res, lDate, DayType);
        END;

        //Obtenemos la hora de inicio y fin de la tarifa. Determina el horario de la empresa.
        RateHeader.GET(ServItemLine."Service Item Tariff No.");

        GetServRateTimes(DayType, RateHeader, StartingPeriodTime, EndingPeriodTime);

        //Realizamos el primer corte en base al horario de la empresa (tarifa)
        IF lStartingTime < StartingPeriodTime THEN BEGIN
            //Si el inicio se produce antes de la hora de inicio de la tarifa
            IF lEndingTime < StartingPeriodTime THEN BEGIN
                //Si el fin se produce antes de la hora inicio de la tarifa
                //Metemos todo en nocturna
                SplitServLines1(pServOrderNo, pServItemLineNo, pType, pNo, pQty2Invoice, pQty, lStartingTime, lEndingTime, lDate, DayType, HourType::Night);
            END ELSE BEGIN
                IF lEndingTime < EndingPeriodTime THEN BEGIN
                    //Si el fin se produce antes del hora fin de la tarifa
                    //Metemos tiempo en nocturna desde inicio hasta hora inicio de la tarifa
                    SplitServLines1(pServOrderNo, pServItemLineNo, pType, pNo, pQty2Invoice, pQty, lStartingTime, StartingPeriodTime, lDate, DayType, HourType::Night);
                    //Metemos tiempo en diurna desde hora inicio de la tarifa hasta finalizacion
                    SplitServLines1(pServOrderNo, pServItemLineNo, pType, pNo, pQty2Invoice, pQty, StartingPeriodTime, lEndingTime, lDate, DayType, HourType::Day);
                END ELSE BEGIN
                    //Si no
                    //Metemos tiempo en nocturna desde inicio hasta hora inicio de la tarifa
                    SplitServLines1(pServOrderNo, pServItemLineNo, pType, pNo, pQty2Invoice, pQty, lStartingTime, StartingPeriodTime, lDate, DayType, HourType::Night);
                    //Metemos tiempo en diurna desde hora inicio de la tarifa hasta fin de la tarifa
                    SplitServLines1(pServOrderNo, pServItemLineNo, pType, pNo, pQty2Invoice, pQty, StartingPeriodTime, EndingPeriodTime, lDate, DayType, HourType::Day);
                    //Metermos tiempo en nocturna desde hora fin de la tarifa hasta finalizacion
                    SplitServLines1(pServOrderNo, pServItemLineNo, pType, pNo, pQty2Invoice, pQty, EndingPeriodTime, lEndingTime, lDate, DayType, HourType::Night);
                END;
            END;
        END ELSE BEGIN
            //Si el inicio se produce despues de la hora de inicio de la tarifa
            IF lStartingTime > EndingPeriodTime THEN BEGIN
                //Si el inicio se produce despues de la hora de fin de la tarifa
                //Metemos tiempo en nocturna desde hora inicio hasta finalizacion
                SplitServLines1(pServOrderNo, pServItemLineNo, pType, pNo, pQty2Invoice, pQty, lStartingTime, lEndingTime, lDate, DayType, HourType::Night);
            END ELSE BEGIN
                IF lEndingTime > EndingPeriodTime THEN BEGIN
                    //Metemos inicio en diurna desde la hora inicio de la tarifa hasta la hora fin de la tarifa
                    SplitServLines1(pServOrderNo, pServItemLineNo, pType, pNo, pQty2Invoice, pQty, lStartingTime, EndingPeriodTime, lDate, DayType, HourType::Day);
                    //Metemos fin en nocturna desde la hora fin de la tarifa hasta finalizacion
                    SplitServLines1(pServOrderNo, pServItemLineNo, pType, pNo, pQty2Invoice, pQty, EndingPeriodTime, lEndingTime, lDate, DayType, HourType::Night);
                END ELSE BEGIN
                    //Si todo el trabajo se realiza en horario de la tarifa
                    //Metemos todo el tiempo en diurna
                    SplitServLines1(pServOrderNo, pServItemLineNo, pType, pNo, pQty2Invoice, pQty, lStartingTime, lEndingTime, lDate, DayType, HourType::Day);
                END;
            END;
        END;
    end;

    /// <summary>
    /// SplitServLines1()
    /// </summary>
    local procedure SplitServLines1(pServOrderNo: Code[20]; pServItemLineNo: Integer; pType: Option " ",Item,Resource,Cost,"G/L Account"; pNo: Code[20]; pQty2Invoice: Decimal; pQty: Decimal; pStartingTime: Time; pEndingTime: Time; pDate: Date; pDayType: Option Workday,Saturday,Holiday,LocalHoliday; pHourType: Option Day,Night)
    begin
        //Esta funcion realiza una division en funcion del tipo de dia y tipo de hora

        //Comprobamos los campos de configuracion necesarios.
        TestSetupFields;

        IF (pDayType = pDayType::Workday) AND (pHourType = pHourType::Day) THEN BEGIN
            SplitServLines2(pServOrderNo, pServItemLineNo, pType, pNo, 0, 0, pStartingTime, pEndingTime, pDate, CraneMgtSetup."Daytime Workday UOM", CraneMgtSetup."Daytime Workday UOM", pDayType, pHourType);
        END ELSE
            IF (pDayType = pDayType::Workday) AND (pHourType = pHourType::Night) THEN BEGIN
                SplitServLines2(pServOrderNo, pServItemLineNo, pType, pNo, 0, 0, pStartingTime, pEndingTime, pDate, CraneMgtSetup."Nighttime Workday UOM", CraneMgtSetup."Nighttime Workday UOM", pDayType, pHourType);
            END ELSE
                IF (pDayType = pDayType::Saturday) AND (pHourType = pHourType::Day) THEN BEGIN
                    SplitServLines2(pServOrderNo, pServItemLineNo, pType, pNo, 0, 0, pStartingTime, pEndingTime, pDate, CraneMgtSetup."Daytime Saturday UOM", CraneMgtSetup."Daytime Saturday UOM", pDayType, pHourType);
                END ELSE
                    IF (pDayType = pDayType::Saturday) AND (pHourType = pHourType::Night) THEN BEGIN
                        SplitServLines2(pServOrderNo, pServItemLineNo, pType, pNo, 0, 0, pStartingTime, pEndingTime, pDate, CraneMgtSetup."Nighttime Saturday UOM", CraneMgtSetup."Nighttime Saturday UOM", pDayType, pHourType);
                    END ELSE
                        IF (pDayType = pDayType::Holiday) AND (pHourType = pHourType::Day) THEN BEGIN
                            SplitServLines2(pServOrderNo, pServItemLineNo, pType, pNo, 0, 0, pStartingTime, pEndingTime, pDate, CraneMgtSetup."Daytime Holiday UOM", CraneMgtSetup."Daytime Holiday UOM", pDayType, pHourType);
                        END ELSE
                            IF (pDayType = pDayType::Holiday) AND (pHourType = pHourType::Night) THEN BEGIN
                                SplitServLines2(pServOrderNo, pServItemLineNo, pType, pNo, 0, 0, pStartingTime, pEndingTime, pDate, CraneMgtSetup."Nighttime Holiday UOM", CraneMgtSetup."Nighttime Holiday UOM", pDayType, pHourType);
                            END ELSE
                                IF (pDayType = pDayType::LocalHoliday) AND (pHourType = pHourType::Day) THEN BEGIN
                                    SplitServLines2(pServOrderNo, pServItemLineNo, pType, pNo, 0, 0, pStartingTime, pEndingTime, pDate, CraneMgtSetup."Daytime Holiday UOM", CraneMgtSetup."Daytime Workday UOM", pDayType, pHourType);
                                END ELSE
                                    IF (pDayType = pDayType::LocalHoliday) AND (pHourType = pHourType::Night) THEN BEGIN
                                        SplitServLines2(pServOrderNo, pServItemLineNo, pType, pNo, 0, 0, pStartingTime, pEndingTime, pDate, CraneMgtSetup."Nighttime Holiday UOM", CraneMgtSetup."Nighttime Workday UOM", pDayType, pHourType);
                                    END;
    end;

    /// <summary>
    /// SplitServLines2()
    /// </summary>
    local procedure SplitServLines2(pServOrderNo: Code[20]; pServItemLineNo: Integer; pType: Option " ",Item,Resource,Cost,"G/L Account"; pNo: Code[20]; pQty2Invoice: Decimal; pQty: Decimal; pStartingTime: Time; pEndingTime: Time; pDate: Date; pUOM: Code[10]; pUOM2Invoice: Code[10]; pDayType: Option Workday,Saturday,Holiday,LocalHoliday; pHourType: Option Day,Night)
    var
        Res: Record "Resource";
        Emp: Record "Employee";
    begin
        //Esta segunda funcion de subdivisaion de lineas de tiempo permite clasificar las lineas segun la configuracion de horario asignado a la tarifa de grua
        //asignada a la linea de producto de servicio. Funciona de forma similar a la primera clasificacion, pero tomando el horario de la tarifa

        //Obtenemos el Recurso
        IF pType = pType::Resource THEN BEGIN
            Res.GET(pNo);

            //Obtenemos el empleado asociado al recurso.
            CLEAR(Emp);
            Emp.SETRANGE("Resource No.", Res."No.");
            Emp.FINDFIRST;
        END;

        IF pHourType = pHourType::Night THEN BEGIN
            //Si la hora es nocturna, no se divide. Va segun entra
            InsertServLine(pServOrderNo, pServItemLineNo, pType, pNo, pQty2Invoice, pQty, pStartingTime, pEndingTime, pDate, pUOM, GetInvoicingUOM(pUOM2Invoice));
        END ELSE BEGIN
            // Si el tipo de dia es NO LABORAL //DPGARCIA - RQ19.18.361
            IF pDayType IN [pDayType::Saturday, pDayType::LocalHoliday, pDayType::Holiday] THEN
                //Metemos todo en HS/HF
                InsertServLine(pServOrderNo, pServItemLineNo, pType, pNo, pQty2Invoice, pQty, pStartingTime, pEndingTime, pDate, pUOM, GetInvoicingUOM(pUOM2Invoice))
            //Si la hora es diurna, realizo la particion en funcion del horario del empleado.
            ELSE
                IF pStartingTime < Emp."Journey Starting Time" THEN BEGIN
                    //Si el inicio se produce antes de la hora de inicio del empleado
                    IF pEndingTime < Emp."Journey Starting Time" THEN BEGIN
                        //Si el fin es anterior al inicio de la jornada del empleado
                        //metemos todo en HE
                        InsertServLine(pServOrderNo, pServItemLineNo, pType, pNo, pQty2Invoice, pQty, pStartingTime, pEndingTime, pDate, CraneMgtSetup."Extratime UOM", GetInvoicingUOM(pUOM2Invoice));
                    END ELSE BEGIN
                        // Metemos tiempo en HE desde inicio hasta hora inicio del empleado
                        IF pEndingTime > Emp."Journey Ending Time" THEN BEGIN
                            //si el fin se produce despues de la hora de fin del empleado
                            //Metemos tiempo en HE desde inicio hasta hora inicio del empleado
                            InsertServLine(pServOrderNo, pServItemLineNo, pType, pNo, pQty2Invoice, pQty, pStartingTime, Emp."Journey Starting Time", pDate, CraneMgtSetup."Extratime UOM", GetInvoicingUOM(pUOM2Invoice));
                            //Metemos tiempo en H/HS/HF desde la hora inicio del empleado hasta la hora fin del empleado
                            InsertServLine(pServOrderNo, pServItemLineNo, pType, pNo, pQty2Invoice, pQty, Emp."Journey Starting Time", Emp."Journey Ending Time", pDate, pUOM, GetInvoicingUOM(pUOM2Invoice));
                            //Metemos fin en HE desde la hora fin del empleado hasta finalizacion
                            InsertServLine(pServOrderNo, pServItemLineNo, pType, pNo, pQty2Invoice, pQty, Emp."Journey Ending Time", pEndingTime, pDate, CraneMgtSetup."Extratime UOM", GetInvoicingUOM(pUOM2Invoice));
                        END ELSE BEGIN
                            //Metemos tiempo en HE desde inicio hasta hora inicio del empleado
                            InsertServLine(pServOrderNo, pServItemLineNo, pType, pNo, pQty2Invoice, pQty, pStartingTime, Emp."Journey Starting Time", pDate, CraneMgtSetup."Extratime UOM", GetInvoicingUOM(pUOM2Invoice));
                            //Metemos en H/HS/HF desde inicio hora empleado hasta fin
                            InsertServLine(pServOrderNo, pServItemLineNo, pType, pNo, pQty2Invoice, pQty, Emp."Journey Starting Time", pEndingTime, pDate, pUOM, GetInvoicingUOM(pUOM2Invoice));
                        END;
                    END;
                END ELSE BEGIN
                    //Si el inicio se produce despues de la hora de inicio del empleado
                    IF pEndingTime > Emp."Journey Ending Time" THEN BEGIN
                        //Si el fin se produce despues de la hora de fin del empleado
                        IF pStartingTime < Emp."Journey Ending Time" THEN BEGIN
                            //Si el inicio es anterior al fin de la jornada del empleado
                            //Metemos inicio en H/HS/HF desde la hora inicio del empleado hasta la hora fin del empleado
                            InsertServLine(pServOrderNo, pServItemLineNo, pType, pNo, pQty2Invoice, pQty, pStartingTime, Emp."Journey Ending Time", pDate, pUOM, GetInvoicingUOM(pUOM2Invoice));
                            //Metemos fin en HE desde la hora fin del empleado hasta finalizacion
                            InsertServLine(pServOrderNo, pServItemLineNo, pType, pNo, pQty2Invoice, pQty, Emp."Journey Ending Time", pEndingTime, pDate, CraneMgtSetup."Extratime UOM", GetInvoicingUOM(pUOM2Invoice));
                        END ELSE BEGIN
                            //Si el inicio es Posterior al fin de la jornada del empleado
                            //metemos todo en HE
                            InsertServLine(pServOrderNo, pServItemLineNo, pType, pNo, pQty2Invoice, pQty, pStartingTime, pEndingTime, pDate, CraneMgtSetup."Extratime UOM", GetInvoicingUOM(pUOM2Invoice));
                        END;
                    END ELSE BEGIN
                        //Metemos todo en H/HS/HF
                        InsertServLine(pServOrderNo, pServItemLineNo, pType, pNo, pQty2Invoice, pQty, pStartingTime, pEndingTime, pDate, pUOM, GetInvoicingUOM(pUOM2Invoice));
                    END;
                END;
        END;
    end;

    /// <summary>
    /// InsertServLine()
    /// </summary>
    local procedure InsertServLine(pServOrderNo: Code[20]; pServItemLineNo: Integer; pType: Option " ",Item,Resource,Cost,"G/L Account"; pNo: Code[20]; pQty2Invoice: Decimal; pQty: Decimal; pStartingTime: Time; pEndingTime: Time; pDate: Date; pUOM: Code[10]; pInvoicingUOM: Code[10])
    var
        ServLine: Record "Service Line";
        ServItemLine: Record "Service Item Line";
        LastLine: Integer;
        LineNo: Integer;
        ServHeader: Record "Service Header";
        ItemJnlLine: Record "Item Journal Line";
        SourceCodeSetup: Record "Source Code Setup";
    begin
        //Esta funcion realizará la intercion final de las lineas de servicio.
        //Funciona de forma muy similar a la existente en LINDE 2016

        ServItemLine.GET(ServItemLine."Document Type"::Order, pServOrderNo, pServItemLineNo);

        ServLine.SETCURRENTKEY("Document Type", "Document No.", "Line No.");
        ServLine.SETRANGE("Document Type", ServItemLine."Document Type");
        ServLine.SETRANGE("Document No.", ServItemLine."Document No.");
        IF ServLine.FINDLAST THEN;
        LastLine := ServLine."Line No." + 10000;

        ServLine.INIT;
        ServLine.VALIDATE("Document Type", ServItemLine."Document Type");
        ServLine.VALIDATE("Document No.", ServItemLine."Document No.");
        ServLine.VALIDATE("Service Item Line No.", ServItemLine."Line No.");
        ServLine.VALIDATE("Line No.", LastLine);
        ServLine.INSERT(TRUE);
        ServLine.VALIDATE(Type, pType);
        ServLine.VALIDATE("No.", pNo);

        IF ServLine.Type <> ServLine.Type::Item THEN
            ServLine.VALIDATE("Unit of Measure Code", pUOM);

        ServLine."Replaced Item No." := '';
        ServLine."Component Line No." := 0;
        ServLine."Spare Part Action" := ServLine."Spare Part Action"::" ";

        ServLine.Quantity := 0;
        IF (ServLine.Type = ServLine.Type::Resource) AND (pStartingTime <> 0T) AND (pEndingTime <> 0T) THEN BEGIN
            ServLine.VALIDATE("Initial Time", pStartingTime);
            ServLine.VALIDATE("End Time", pEndingTime);
        END;

        ServLine.VALIDATE("Posting Date", pDate);

        // ServInvoiceLine.VALIDATE(ServInvoiceLine.Quantity,pQty);
        // ServInvoiceLine.VALIDATE(ServInvoiceLine."Internal Quantity",pQty);
        // ServInvoiceLine.VALIDATE(ServInvoiceLine."Qty. to Invoice",pQty2Invoice);


        //Obtenemos el tipo de trabajo segun el recurso que estamos imoutando.
        ServLine.VALIDATE("Work Type Code", GetWorkType(ServItemLine, pNo));

        //Establecemos la Unidad de medida para facturar. Comprobaciones parecidas a las ya existentes, pero basado en los horarios de la tarifa asociada a la Lin Prod. Servicio
        ServLine."Invoicing UOM Code" := pInvoicingUOM;

        ServLine.MODIFY(TRUE);
    end;

    /// <summary>
    /// GetWorkType()
    /// </summary>
    local procedure GetWorkType(pServItemLine: Record "Service Item Line"; pResourceNo: Code[20]) WorkTypeCode: Code[10]
    var
        ServiceOrderAllocation: Record "Service Order Allocation";
    begin
        //Funcion que determina el codigo de trabajo a imputar en la linea de servicio. En base al recurso que estamos introduciendo y su asignacion
        CLEAR(ServiceOrderAllocation);
        //ServiceOrderAllocation.SETRANGE(Status,ServiceOrderAllocation.Status::Active);
        ServiceOrderAllocation.SETRANGE("Document No.", pServItemLine."Document No.");
        ServiceOrderAllocation.SETRANGE("Service Item Line No.", pServItemLine."Line No.");
        ServiceOrderAllocation.SETRANGE(Responsible, TRUE);
        ServiceOrderAllocation.SETRANGE("Resource No.", pResourceNo);
        IF ServiceOrderAllocation.FINDFIRST THEN
            EXIT(CraneMgtSetup."Main Operator Work Type")
        ELSE
            EXIT(CraneMgtSetup."Ass. Operator Work Type");
    end;

    /// <summary>
    /// GetInvoicingUOM()
    /// </summary>
    local procedure GetInvoicingUOM(pUOM: Code[10]) UOM: Code[10]
    var
        UnitofMeasure: Record "Unit of Measure";
    begin
        //Esta funcion devuelve la unidad de medida a utilizar como "de facturacion" segun el tipo de unidad de medida original, tipo de dia y tipo de horario

        //DEsactualizado
        // CASE pUOM OF
        //    CraneMgtSetup."Daytime Displacement UOM",CraneMgtSetup."Nighttime Displacement UOM":
        //      BEGIN
        //        IF          (pHourType = pHourType::Day) THEN BEGIN
        //          EXIT(CraneMgtSetup."Daytime Workday UOM");
        //        END ELSE IF (pHourType = pHourType::Night) THEN BEGIN
        //          EXIT(CraneMgtSetup."Nighttime Workday UOM");
        //        END;
        //      END;
        //    ServiceMgtSetup."Displacement Unit Of Measure":
        //      BEGIN
        //        EXIT(ServiceMgtSetup."Displacement Unit Of Measure");
        //      END;
        //    CraneMgtSetup."Daytime Standby UOM",CraneMgtSetup."Nighttime Standby UOM":
        //      BEGIN
        //        IF          (pHourType = pHourType::Day) THEN BEGIN
        //          EXIT(CraneMgtSetup."Daytime Workday UOM");
        //        END ELSE IF (pHourType = pHourType::Night) THEN BEGIN
        //          EXIT(CraneMgtSetup."Nighttime Workday UOM");
        //        END;
        //      END;
        //    ELSE
        //      BEGIN
        //        IF          (pDayType = pDayType::Workday) AND (pHourType = pHourType::Day) THEN BEGIN
        //          EXIT(CraneMgtSetup."Daytime Workday UOM");
        //        END ELSE IF (pDayType = pDayType::Workday) AND (pHourType = pHourType::Night) THEN BEGIN
        //          EXIT(CraneMgtSetup."Nighttime Workday UOM");
        //        END ELSE IF (pDayType = pDayType::Saturday) AND (pHourType = pHourType::Day) THEN BEGIN
        //          EXIT(CraneMgtSetup."Daytime Saturday UOM");
        //        END ELSE IF (pDayType = pDayType::Saturday) AND (pHourType = pHourType::Night) THEN BEGIN
        //          EXIT(CraneMgtSetup."Nighttime Saturday UOM");
        //        END ELSE IF (pDayType = pDayType::Holiday) AND (pHourType = pHourType::Day) THEN BEGIN
        //          EXIT(CraneMgtSetup."Daytime Holiday UOM");
        //        END ELSE IF (pDayType = pDayType::Holiday) AND (pHourType = pHourType::Night) THEN BEGIN
        //          EXIT(CraneMgtSetup."Nighttime Holiday UOM");
        //        END ELSE IF (pDayType = pDayType::LocalHoliday) AND (pHourType = pHourType::Day) THEN BEGIN
        //          EXIT(CraneMgtSetup."Daytime Workday UOM");
        //        END ELSE IF (pDayType = pDayType::LocalHoliday) AND (pHourType = pHourType::Night) THEN BEGIN
        //          EXIT(CraneMgtSetup."Nighttime Workday UOM");
        //        END;
        //      END;
        // END;

        CLEAR(UnitofMeasure);
        UnitofMeasure.GET(pUOM);
        IF UnitofMeasure."Invoicing UOM" <> '' THEN
            EXIT(UnitofMeasure."Invoicing UOM")
        ELSE
            EXIT(pUOM);
    end;

    /// <summary>
    /// GetDayType()
    /// </summary>
    procedure GetDayType(pRes: Record "Resource"; pDate: Date; var vDayType: Option Workday,Saturday,Holiday,LocalHoliday)
    var
        BaseCalendarCode: Code[10];
        CalendarMgmt: Codeunit "Calendar Management";
        CalendarCustomized: BoolEAN;
        Holiday: BoolEAN;
        CalChange: Record "Customized Calendar Change";
        NewDescription: Text;
        Day: Option " ",Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday;
        DateTable: Record "Date";
        LocalHoliday: BoolEAN;
    begin
        //Esta funcion devuelve el tipo de dia para un recurso y fecha indicado por parametros.
        //Se basa en funcionalidad estadar de Calendar Management.

        BaseCalendarCode := GetCalendarCode(pRes);

        IF BaseCalendarCode <> '' THEN
            CalendarCustomized := CalendarMgmt.CustomizedChangesExist(CalChange."Source Type"::Company, '', '', BaseCalendarCode); //TODO: Error: El método CustomizedChangesExist no contiene 4 argumentos sino 1 argumento en esta versión

        IF CalendarCustomized THEN BEGIN
            Holiday :=
                CalendarMgmt.CheckCustomizedDateStatus( //TODO: Error: El Codeunit "Calendar Management" no contiene el método CheckCustomizedDateStatus
                  CalChange."Source Type"::Company, '', '', BaseCalendarCode, pDate, NewDescription)
        END ELSE BEGIN
            Holiday := CalendarMgmt.CheckDateStatus(BaseCalendarCode, pDate, NewDescription); //TODO: Error: El método CustomizedChangesExist no contiene 3 argumentos sino 1 argumento en esta versión
            LocalHoliday := CalendarMgmt.CheckDateStatus(BaseCalendarCode, pDate); //TODO: Error: El método CustomizedChangesExist no contiene 2 argumentos sino 1 argumento en esta versión
        END;

        CLEAR(DateTable);
        DateTable.SETRANGE("Period Type", DateTable."Period Type"::Date);
        DateTable.SETRANGE("Period Start", pDate);
        if DateTable.FINDFIRST then
            Day := DateTable."Period No.";

        if Holiday then begin
            IF LocalHoliday THEN
                vDayType := vDayType::LocalHoliday
            ELSE
                vDayType := vDayType::Holiday;
        END ELSE
            IF Day = Day::Saturday THEN
                vDayType := vDayType::Saturday
            ELSE
                vDayType := vDayType::Workday;
    end;

    /// <summary>
    /// GetCalendarCode()
    /// </summary>
    local procedure GetCalendarCode(TempResource: Record "Resource") retCalendarCode: Code[10]
    var
        ResourceGroup: Record "Resource Group";
    begin
        //Esta funcion devuelve el Cod. Calendario Base aplicable para un recurso pasado por parametros.
        //Recoge el calendario base de la ficha del recurso, si no tuviese, del grupo de recurso asignado y si aun no tuviese, de la configuracion de empresa.
        Companyinfo.GET;

        IF TempResource."Base Calendar Code" <> '' THEN
            EXIT(TempResource."Base Calendar Code")
        ELSE BEGIN
            IF TempResource."Resource Group No." <> '' THEN BEGIN
                ResourceGroup.GET(TempResource."Resource Group No.");
                IF ResourceGroup."Base Calendar Code" <> '' THEN
                    EXIT(ResourceGroup."Base Calendar Code");
            END ELSE BEGIN
                IF Companyinfo."Base Calendar Code" <> '' THEN
                    EXIT(Companyinfo."Base Calendar Code");
            END;
        END;

        ERROR('');
    end;

    /// <summary>
    /// GetServRateTimes()
    /// </summary>
    local procedure GetServRateTimes(pDayType: Option Workday,Saturday,Holiday,LocalHoliday; pRateHeader: Record "Service Item Rate Header_LDR"; var vStartingTime: Time; var vEndingTime: Time)
    begin
        //En funcion del tipo de dia, asignamos un inicio periodo y fin periodo diferente.
        CASE pDayType OF
            pDayType::Workday, pDayType::LocalHoliday:
                BEGIN
                    vStartingTime := pRateHeader."Workday Starting Time";
                    vEndingTime := pRateHeader."Workday Ending Time";
                END;
            pDayType::Saturday:
                BEGIN
                    vStartingTime := pRateHeader."Saturday Starting Time";
                    vEndingTime := pRateHeader."Saturday Ending Time";
                END;
            pDayType::Holiday:
                BEGIN
                    vStartingTime := pRateHeader."Holiday Starting Time";
                    vEndingTime := pRateHeader."Holiday Ending Time";
                END;
        END;
    end;

    /// <summary>
    /// UpdateServLineStatus()
    /// </summary>
    procedure UpdateServLineStatus(pServOrderNo: Code[20]; pServItemLineNo: Integer; pRepairStatusIndex: Integer; pCloseServiceOrder: BoolEAN)
    var
        ServItemLine: Record "Service Item Line";
        RepairStatus: Record "Repair Status";
        ServOrderAlloc: Record "Service Order Allocation";
        ServLine: Record "Service Line";
        MinDate: Date;
        MaxDate: Date;
        MinTime: Time;
        MaxTime: Time;
        ServHeader: Record "Service Header";
        ServContractLine: Record "Service Contract Line";
        ServItemEntryJournal: Record "Serv.Item. Entry Journal_LDR";
        ServItem: Record "Service Item";
    begin
        //Esta funcion global permite a la aplicacion de movilidad cambiar el estado de una linea de producto de servicio.
        //Funciona de manera similar a la funcion de LINDE 2016, pero simplificada.
        CraneMgtSetup.GET;

        ServItemLine.GET(ServItemLine."Document Type"::Order, pServOrderNo, pServItemLineNo);
        ServHeader.GET(ServItemLine."Document Type", ServItemLine."Document No.");

        CLEAR(RepairStatus);
        RepairStatus.SETRANGE("Index of AMPLUS", pRepairStatusIndex);
        RepairStatus.FINDFIRST;

        IF pCloseServiceOrder THEN BEGIN
            CLEAR(ServOrderAlloc);
            ServOrderAlloc.SETRANGE("Document Type", ServItemLine."Document Type");
            ServOrderAlloc.SETRANGE("Document No.", ServItemLine."Document No.");
            ServOrderAlloc.SETRANGE("Service Item Line No.", pServItemLineNo);
            ServOrderAlloc.SETRANGE(Status, ServOrderAlloc.Status::Active);
            IF ServOrderAlloc.FINDSET THEN BEGIN
                REPEAT
                    //Buscar la ultima hora de trabajo del operario
                    CLEAR(ServLine);
                    ServLine.SETRANGE("Document Type", ServOrderAlloc."Document Type");
                    ServLine.SETRANGE("Document No.", ServOrderAlloc."Document No.");
                    ServLine.SETRANGE("Service Item Line No.", ServOrderAlloc."Service Item Line No.");
                    ServLine.SETRANGE(Type, ServLine.Type::Resource);
                    ServLine.SETRANGE("No.", ServOrderAlloc."Resource No.");
                    IF ServLine.FINDSET THEN BEGIN
                        REPEAT
                            IF (ServLine."Posting Date" <= MinDate) OR (MinDate = 0D) THEN BEGIN
                                IF ServLine."Initial Time" <> 0T THEN BEGIN
                                    IF (ServLine."Posting Date" < MinDate) AND (MinDate <> 0D) THEN
                                        MinTime := 0T;
                                    MinDate := ServLine."Posting Date";
                                    IF (ServLine."Initial Time" < MinTime) OR (MinTime = 0T) THEN
                                        MinTime := ServLine."Initial Time"
                                END;
                            END;

                            IF (ServLine."Posting Date" >= MaxDate) OR (MaxDate = 0D) THEN BEGIN
                                IF ServLine."End Time" <> 0T THEN BEGIN
                                    IF (ServLine."Posting Date" > MaxDate) AND (MaxDate <> 0D) THEN
                                        MaxTime := 0T;
                                    MaxDate := ServLine."Posting Date";
                                    IF (ServLine."End Time" > MaxTime) OR (MaxTime = 0T) THEN
                                        MaxTime := ServLine."End Time"
                                END;
                            END;
                        UNTIL ServLine.NEXT = 0;

                        //Si es diferente de la hora de fin esperada,
                        ServOrderAlloc."Starting Time" := MinTime;
                        ServOrderAlloc."Finishing Time" := MaxTime;
                        ServOrderAlloc.MODIFY(TRUE);

                        IF ServOrderAlloc.Responsible THEN BEGIN
                            ServItemLine."Requested Starting Date" := MinDate;
                            ServItemLine."Requested Starting Time" := MinTime;
                            ServItemLine."Requested Ending Date" := MaxDate;
                            ServItemLine."Requested Ending Time" := MaxTime;
                            ServItemLine.MODIFY(TRUE);
                        END;
                    END;
                UNTIL ServOrderAlloc.NEXT = 0;
            END;

            IF (ServHeader."Service Order Type" = CraneMgtSetup."Serv. Order Type - Platf. Del.") THEN BEGIN
                CLEAR(ServItemLine);
                ServItemLine.SETRANGE("Document Type", ServHeader."Document Type");
                ServItemLine.SETRANGE("Document No.", ServHeader."No.");
                IF ServItemLine.FINDSET THEN BEGIN
                    REPEAT
                        ServItemLine.VALIDATE("Repair Status Code", RepairStatus.Code);
                        ServItemLine.MODIFY(TRUE);
                        IF ServItemLine."Contract Line No." <> 0 THEN BEGIN
                            ServContractLine.GET(ServContractLine."Contract Type"::Contract, ServItemLine."Contract No.", ServItemLine."Contract Line No.");
                            ServItem.GET(ServContractLine."Service Item No.");
                            PlannerMgt.PostServItemJournal(ServItemEntryJournal."Entry Type"::"Entrega Inicio Contrato Alquiler", ServContractLine, ServItem);
                        END;
                    UNTIL ServItemLine.NEXT = 0;
                END;
            END ELSE
                IF (ServHeader."Service Order Type" = CraneMgtSetup."Serv. Order Type - Platf. Pick") THEN BEGIN
                    CLEAR(ServItemLine);
                    ServItemLine.SETRANGE("Document Type", ServHeader."Document Type");
                    ServItemLine.SETRANGE("Document No.", ServHeader."No.");
                    IF ServItemLine.FINDSET THEN BEGIN
                        REPEAT
                            ServItemLine.VALIDATE("Repair Status Code", RepairStatus.Code);
                            ServItemLine.MODIFY(TRUE);
                            IF ServItemLine."Contract Line No." <> 0 THEN BEGIN
                                ServContractLine.GET(ServContractLine."Contract Type"::Contract, ServItemLine."Contract No.", ServItemLine."Contract Line No.");
                                ServItem.GET(ServContractLine."Service Item No.");
                                PlannerMgt.PostServItemJournal(ServItemEntryJournal."Entry Type"::"Recogida Fin Contrato Alquiler", ServContractLine, ServItem);
                            END;
                        UNTIL ServItemLine.NEXT = 0;
                    END;
                END;
        END;

        ServItemLine.VALIDATE("Repair Status Code", RepairStatus.Code);
        ServItemLine.MODIFY(TRUE);
    end;

    /// <summary>
    /// InsertResourceJournalLine()
    /// </summary>
    procedure InsertResourceJournalLine(pDocNo: Code[20]; pNo: Code[20]; pQty: Decimal; pStartingTime: Text; pEndingTime: Text; pDate: Text; pDescription: Text[50]; pWorkTypeCode: Code[10]; pUOM: Code[10])
    var
        lStartingTime: Time;
        lEndingTime: Time;
        lDate: Date;
        Res: Record "Resource";
        PartialTime: Decimal;
        DayType: Option;
        HourType: Option Day,Night;
    begin
        EVALUATE(lStartingTime, pStartingTime);
        EVALUATE(lEndingTime, pEndingTime);
        EVALUATE(lDate, pDate);

        Res.GET(pNo);
        CraneMgtSetup.GET;
        CraneMgtSetup.TESTFIELD("Standard Ending Time");
        CraneMgtSetup.TESTFIELD("Standard Starting Time");
        //Clasificamos el dia segun Laborable, Sabado o Festivo para el recurso actual. Se devuelve el dato en variable local por referencia
        GetDayType(Res, lDate, DayType);
        //Dividimos por el horario de la configuracion de grua (EMPRESA)

        IF lStartingTime < CraneMgtSetup."Standard Starting Time" THEN BEGIN
            //Si el inicio se produce antes de la hora de inicio de la empresa
            IF lEndingTime < CraneMgtSetup."Standard Starting Time" THEN BEGIN
                //metemos todo en nocturno
                SplitResourceJournalLine1_2(pDocNo, pNo, pQty, lStartingTime, lEndingTime, lDate, pDescription, pWorkTypeCode, pUOM, DayType, HourType::Night);
            END ELSE
                IF lEndingTime < CraneMgtSetup."Standard Ending Time" THEN BEGIN
                    //Parte nocturna
                    SplitResourceJournalLine1_2(pDocNo, pNo, pQty, lStartingTime, CraneMgtSetup."Standard Starting Time", lDate, pDescription, pWorkTypeCode, pUOM, DayType, HourType::Night);
                    //parte diurna
                    SplitResourceJournalLine1_2(pDocNo, pNo, pQty, CraneMgtSetup."Standard Starting Time", lEndingTime, lDate, pDescription, pWorkTypeCode, pUOM, DayType, HourType::Day);
                END ELSE BEGIN
                    //Parte nocturna
                    SplitResourceJournalLine1_2(pDocNo, pNo, pQty, lStartingTime, CraneMgtSetup."Standard Starting Time", lDate, pDescription, pWorkTypeCode, pUOM, DayType, HourType::Night);
                    //parte diurna
                    SplitResourceJournalLine1_2(pDocNo, pNo, pQty, CraneMgtSetup."Standard Starting Time", CraneMgtSetup."Standard Ending Time", lDate, pDescription, pWorkTypeCode, pUOM, DayType, HourType::Day);
                    //Parte nocturna
                    SplitResourceJournalLine1_2(pDocNo, pNo, pQty, CraneMgtSetup."Standard Ending Time", lEndingTime, lDate, pDescription, pWorkTypeCode, pUOM, DayType, HourType::Night);
                END;
        END ELSE
            IF lStartingTime < CraneMgtSetup."Standard Ending Time" THEN BEGIN
                IF lEndingTime < CraneMgtSetup."Standard Ending Time" THEN BEGIN
                    //Todo diurno
                    SplitResourceJournalLine1_2(pDocNo, pNo, pQty, lStartingTime, lEndingTime, lDate, pDescription, pWorkTypeCode, pUOM, DayType, HourType::Day);
                END ELSE BEGIN
                    //Parte diurna
                    SplitResourceJournalLine1_2(pDocNo, pNo, pQty, lStartingTime, CraneMgtSetup."Standard Ending Time", lDate, pDescription, pWorkTypeCode, pUOM, DayType, HourType::Day);
                    //Parte nocturna
                    SplitResourceJournalLine1_2(pDocNo, pNo, pQty, CraneMgtSetup."Standard Ending Time", lEndingTime, lDate, pDescription, pWorkTypeCode, pUOM, DayType, HourType::Night);
                END;
            END ELSE BEGIN
                //todo nocturno
                SplitResourceJournalLine1_2(pDocNo, pNo, pQty, lStartingTime, lEndingTime, lDate, pDescription, pWorkTypeCode, pUOM, DayType, HourType::Night);
            END;
    end;

    /// <summary>
    /// InsertResourceJournalLine2()
    /// </summary>
    local procedure InsertResourceJournalLine2(pDocNo: Code[20]; pNo: Code[20]; pQty: Decimal; pStartingTime: Time; pEndingTime: Time; pDate: Date; pDescription: Text[50]; pWorkTypeCode: Code[10]; pUOM: Code[10])
    var
        ResJnlLine: Record "Res. Journal Line";
        xResJnlLine: Record "Res. Journal Line";
        LastLine: Integer;
        NLinea: Integer;
        CraneMgtSetup: Record "Crane Mgt. Setup_LDR";
    begin
        //Esta funcion permite la introduccion de lineas de diario de recursos tal y como hace en LINDE 2016.

        IF (ROUND((pEndingTime - pStartingTime) / 3600000, 0.00001) = 0) THEN // No insertar una linea de recurso si la cantidad va a ser CERO
            EXIT;

        CraneMgtSetup.GET;
        CraneMgtSetup.TESTFIELD("WorkLoad Jnl. Tmpl.");
        CraneMgtSetup.TESTFIELD("WorkLoad Jnl. Batch.");

        CLEAR(xResJnlLine);
        xResJnlLine.SETCURRENTKEY("Journal Template Name", "Journal Batch Name", "Line No.");
        xResJnlLine.SETRANGE("Journal Template Name", CraneMgtSetup."WorkLoad Jnl. Tmpl.");
        xResJnlLine.SETRANGE("Journal Batch Name", CraneMgtSetup."WorkLoad Jnl. Batch.");
        IF xResJnlLine.FINDLAST THEN;
        LastLine := xResJnlLine."Line No." + 10000;

        ResJnlLine.INIT;
        ResJnlLine.VALIDATE("Journal Template Name", CraneMgtSetup."WorkLoad Jnl. Tmpl.");
        ResJnlLine.VALIDATE("Journal Batch Name", CraneMgtSetup."WorkLoad Jnl. Batch.");
        ResJnlLine.VALIDATE("Line No.", LastLine);
        ResJnlLine.SetUpNewLine(xResJnlLine);
        ResJnlLine.INSERT(TRUE);

        ResJnlLine.VALIDATE("Resource No.", pNo);
        ResJnlLine.VALIDATE(ResJnlLine."Initial Time", pStartingTime);
        ResJnlLine.VALIDATE(ResJnlLine."End Time", pEndingTime);
        ResJnlLine.VALIDATE(ResJnlLine.Quantity, ROUND((pEndingTime - pStartingTime) / 3600000, 0.00001));
        ResJnlLine.VALIDATE(ResJnlLine.Description, pDescription);
        ResJnlLine.VALIDATE("Posting Date", pDate);
        ResJnlLine.VALIDATE(ResJnlLine."Work Type Code", pWorkTypeCode);
        ResJnlLine.VALIDATE("Unit of Measure Code", pUOM);
        ResJnlLine.MODIFY(TRUE);
    end;

    /// <summary>
    /// TestSetupFields()
    /// </summary>
    local procedure TestSetupFields()
    begin
        //Esta funcion agrupa todos los TESTFIELDS de configuracion

        CraneMgtSetup.TESTFIELD("Daytime Workday UOM");
        CraneMgtSetup.TESTFIELD("Nighttime Workday UOM");
        CraneMgtSetup.TESTFIELD("Daytime Saturday UOM");
        CraneMgtSetup.TESTFIELD("Nighttime Saturday UOM");
        CraneMgtSetup.TESTFIELD("Daytime Holiday UOM");
        CraneMgtSetup.TESTFIELD("Nighttime Holiday UOM");
        CraneMgtSetup.TESTFIELD("Daytime Standby UOM");
        CraneMgtSetup.TESTFIELD("Nighttime Standby UOM");
        CraneMgtSetup.TESTFIELD("Daytime Displacement UOM");
        CraneMgtSetup.TESTFIELD("Nighttime Displacement UOM");
        CraneMgtSetup.TESTFIELD("Traveltime Saturday UOM");
        CraneMgtSetup.TESTFIELD("Nighttraveltime Saturday UOM");
        CraneMgtSetup.TESTFIELD("Traveltime Holiday UOM");
        CraneMgtSetup.TESTFIELD("Nighttraveltime Holiday UOM");
        CraneMgtSetup.TESTFIELD("Ass. Operator Work Type");
        CraneMgtSetup.TESTFIELD("Main Operator Work Type");
        CraneMgtSetup.TESTFIELD("Crane Service Cost Code");
        CraneMgtSetup.TESTFIELD("Work Type Code PS Platform");
        CraneMgtSetup.TESTFIELD("Ext Travel Work Type");

        ServiceMgtSetup.TESTFIELD("Work Time Unit Of Measure");
        ServiceMgtSetup.TESTFIELD("Disp. Time Unit Of Measure");
        ServiceMgtSetup.TESTFIELD("Displacement Unit Of Measure");
    end;

    /// <summary>
    /// SetServOrderExported()
    /// </summary>
    procedure SetServOrderExported(pServOrderNo: Code[20]; pServItemLineNo: Integer; pResourceNo: Code[20])
    var
        ServOrderAllocation: Record "Service Order Allocation";
        ServItemLine: Record "Service Item Line";
    begin
        //Esta funcion global permitirá a la aplicacion de movilidad establecer una linea de asignacion y linea de pedido de servicio como exportada, para no volver
        //a descargar esta informacion. Sustituye a la funcionalidad de fecha de creacion utilizada en LINDE 2016
        CraneMgtSetup.GET;
        CraneMgtSetup.TESTFIELD("Sent to Device Repair Status");

        CLEAR(ServOrderAllocation);
        ServOrderAllocation.SETRANGE(Status, ServOrderAllocation.Status::Active);
        ServOrderAllocation.SETRANGE("Document Type", ServOrderAllocation."Document Type"::Order);
        ServOrderAllocation.SETRANGE("Document No.", pServOrderNo);
        ServOrderAllocation.SETRANGE("Service Item Line No.", pServItemLineNo);
        ServOrderAllocation.SETRANGE("Resource No.", pResourceNo);
        IF ServOrderAllocation.FINDFIRST THEN BEGIN
            ServOrderAllocation."Exported to Device" := TRUE;
            ServOrderAllocation.MODIFY(TRUE);

            IF ServItemLine.GET(ServItemLine."Document Type"::Order, pServOrderNo, pServItemLineNo) THEN BEGIN
                ServItemLine."Exported to Device" := TRUE;
                ServItemLine."Repair Status Code" := CraneMgtSetup."Sent to Device Repair Status";
                ServItemLine.MODIFY(TRUE);
            END;
        END;
    end;

    /// <summary>
    /// InsertServItemLineComment()
    /// </summary>
    procedure InsertServItemLineComment(pServOrderNo: Code[20]; pServItemLineNo: Integer; pCommentType: Option General,Fault,Resolution,Accessory,Internal,"Service Item Loaner"; pComment: Text)
    var
        CommentEditorMgt: Report "CommentEditorMgt";
    begin
        //Esta funcion global permitirá a la aplicacion de movilidad en modo "bloque", pasando una variable de texto sin limite, y haciendose
        //La division en lineas de comentario en Dynamics NAV

        CommentEditorMgt.InsertComments(DATABASE::"Service Header", pServOrderNo, pServItemLineNo, pCommentType, pComment);
    end;

    /// <summary>
    /// CreateServiceRequest()
    /// </summary>
    procedure CreateServiceRequest(pServItemNo: Code[20]; pResourceNo: Code[20]; pRequestType: Option Maintenance,Reform,Repair; pDescription: Text[50]; pComment: Text; pUrgent: BoolEAN; pBlockMaintenance: BoolEAN) ServOrderNo: Code[20]
    var
        CommentEditorMgt: Report "CommentEditorMgt";
        ServHeader: Record "Service Header";
        SelectedNoSeries: Code[20];
        NoSeriesRelationship: Record "No. Series Relationship";
        NoSeriesMgt: Codeunit "NoSeriesManagement";
        ServItem: Record "Service Item";
        ServItemLine: Record "Service Item Line";
        RepairStatus: Record "Repair Status";
        CommentType: Option General,Fault,Resolution,Accessory,Internal,"Service Item Loaner";
        ServItemOperationsEntry: Record "Serv. Item Operat Entry_LDR";
        ServItemAvailabilityEntry: Record "Serv. Item Avail Entry_LDR";
    begin
        //Esta funcion permite la creacion de Pedidos de Servicio de Reparacion desde los terminales Fieldeas.

        CraneMgtSetup.GET;
        ServiceMgtSetup.GET;
        CraneMgtSetup.TESTFIELD("Serv. Order Type - Maintenance");
        CraneMgtSetup.TESTFIELD("Maint. Serv. Order Nos.");
        ServItem.GET(pServItemNo);

        IF pUrgent THEN BEGIN
            CLEAR(ServHeader);
            ServHeader.INIT;
            ServHeader.SetHideValidationDialog(TRUE);
            ServHeader."Document Type" := ServHeader."Document Type"::Order;

            ServHeader.VALIDATE("No. Series", CraneMgtSetup."Maint. Serv. Order Nos.");

            ServHeader.INSERT(TRUE);
            ServHeader.SetHideValidationDialog(TRUE);
            ServHeader.VALIDATE("Order Date", WORKDATE);

            ServHeader.VALIDATE("Customer No.", ServItem."Owner Customer No.");
            //ServHeader.VALIDATE("Responsibility Center",CentroResponsabilidad);
            //ServHeader.VALIDATE("Ship-to Code",pOrderStartTemp."Ship-to Address Code");

            //ServHeader.VALIDATE("Contact No.",pOrderStartTemp."Contact No.");

            // IF Cust."Bill-to Customer No." <> '' THEN
            //  ServHeader.VALIDATE("Bill-to Customer No.",Cust."Bill-to Customer No.");
            //

            //Condicionar segun opcion
            CASE pRequestType OF
                pRequestType::Maintenance:
                    ServHeader.VALIDATE(ServHeader."Service Order Type", CraneMgtSetup."Serv. Order Type - Maintenance");
                pRequestType::Reform:
                    ServHeader.VALIDATE(ServHeader."Service Order Type", CraneMgtSetup."Serv. Order Type - Reform");
                pRequestType::Repair:
                    ServHeader.VALIDATE(ServHeader."Service Order Type", CraneMgtSetup."Serv. Order Type - Repair");
            END;

            IF pUrgent THEN
                ServHeader.VALIDATE(Priority, ServHeader.Priority::High);

            ServHeader.Description := pDescription;

            ServHeader.MODIFY(TRUE);

            ServHeader.SETRECFILTER;

            ServItemLine.INIT;
            ServItemLine.bOmitirComprobarFacturarA(TRUE); //TODO: Error: La tabla "Service Item Line" no contiene la definición bOmitirComprobarFacturarA
            ServItemLine.SetHideDialogBox(TRUE);
            ServItemLine."Document No." := ServHeader."No.";
            ServItemLine."Document Type" := ServHeader."Document Type";
            RepairStatus.RESET;
            RepairStatus.Initial := TRUE;

            ServItemLine."Repair Status Code" := RepairStatus.ReturnStatusCode(RepairStatus);

            ServItemLine."Line No." := 10000;

            ServItemLine.VALIDATE("Service Item No.", pServItemNo);
            ServItemLine."Location of Service Item" := ServItem."Location of Service Item";

            ServItemLine.VALIDATE(Priority, ServItemLine.Priority::High);

            ServItemLine."Serial No." := ServItem."Serial No.";

            ServItemLine.UpdateResponseTimeHours;
            ServItemLine.INSERT(TRUE);

            CommentEditorMgt.InsertComments(DATABASE::"Service Header", ServHeader."No.", ServItemLine."Line No.", CommentType::Fault, pComment);
        END;

        CLEAR(ServItemOperationsEntry);
        ServItemOperationsEntry."Serv. Item Code" := pServItemNo;
        ServItemOperationsEntry."Operation Code" := CraneMgtSetup."Repair Operation Code";
        ServItemOperationsEntry.Description := pDescription;
        ServItemOperationsEntry."Operation Type" := ServItemOperationsEntry."Operation Type"::Technical;
        ServItemOperationsEntry."Period Type" := ServItemOperationsEntry."Period Type"::None;
        ServItemOperationsEntry."Self/External" := ServItemOperationsEntry."Self/External"::Self;
        ServItemOperationsEntry."Creation Date" := WORKDATE;
        IF pUrgent THEN
            ServItemOperationsEntry."Serv. Order No." := ServHeader."No.";
        ServItemOperationsEntry."Requested Resource No." := pResourceNo;
        ServItemOperationsEntry.Urgent := pUrgent;
        //Condicionar segun opcion
        CASE pRequestType OF
            pRequestType::Maintenance:
                ServItemOperationsEntry."Serv. Order Type" := CraneMgtSetup."Serv. Order Type - Maintenance";
            pRequestType::Reform:
                ServItemOperationsEntry."Serv. Order Type" := CraneMgtSetup."Serv. Order Type - Reform";
            pRequestType::Repair:
                ServItemOperationsEntry."Serv. Order Type" := CraneMgtSetup."Serv. Order Type - Repair";
        END;
        ServItemOperationsEntry.INSERT;

        // RQ19.20.791 - DPGARCIA - Llevar el Nº Movimiento Operacion a la cabecera del pedido (Cuando sea Urgente)
        IF pUrgent THEN BEGIN
            ServHeader."Serv. Item Operation Entry No." := ServItemOperationsEntry."Entry No.";
            ServHeader.MODIFY;
        END;

        IF pBlockMaintenance THEN BEGIN
            CLEAR(ServItemAvailabilityEntry);
            ServItemAvailabilityEntry."Service Item Code" := pServItemNo;
            ServItemAvailabilityEntry."Entry Type" := ServItemAvailabilityEntry."Entry Type"::maintenance;
            ServItemAvailabilityEntry."Starting Date" := WORKDATE;
            ServItemAvailabilityEntry."Ending Date" := CALCDATE('<CY>', WORKDATE);
            ServItemAvailabilityEntry."Serv. Order No." := ServHeader."No.";
            ServItemAvailabilityEntry.INSERT(TRUE);
        END;

        EXIT(ServHeader."No.");
    end;

    /// <summary>
    /// InsertExpensesSheet()
    /// </summary>
    procedure InsertExpensesSheet(pResourceNo: Code[20]; pExpensesType: Option accomodation,breakfast,food,dinner,completeDiet; pExpensesDate: Text[8]; pExpInitialTime: Text[6]; pExtEndingTime: Text[6]; pAmount: Decimal)
    var
        EmplExpensesTypes: Record "Empl. Expenses Types_LDR";
        Employee: Record "Employee";
        EmplExpensesJustification: Record "Empl. Expenses Justificat_LDR";
        lStartingTime: Time;
        lEndingTime: Time;
        lDate: Date;
    begin
        EVALUATE(lStartingTime, pExpInitialTime);
        EVALUATE(lEndingTime, pExtEndingTime);
        EVALUATE(lDate, pExpensesDate);

        CraneMgtSetup.GET;

        //Coger el empleado desde el recurso
        CLEAR(Employee);
        Employee.SETRANGE("Resource No.", pResourceNo);
        IF NOT Employee.FINDFIRST THEN
            ERROR(Text001, pResourceNo);

        //Coger el tipo de gasto con la opcion + empleado
        CLEAR(EmplExpensesTypes);
        EmplExpensesTypes.SETRANGE("Employee No.", Employee."No.");
        EmplExpensesTypes.SETRANGE("Mobility Exp. Type", pExpensesType);
        IF NOT EmplExpensesTypes.FINDFIRST THEN
            ERROR(Text002, Employee."No.", pExpensesType);

        //grabar datos en la tabla de gastos.
        CLEAR(EmplExpensesJustification);
        EmplExpensesJustification.INIT;
        EmplExpensesJustification.VALIDATE("Employee No.", Employee."No.");
        EmplExpensesJustification.Date := lDate;
        EmplExpensesJustification.VALIDATE("Expense Type", EmplExpensesTypes.Code);
        EmplExpensesJustification.Quantity := pAmount;
        EmplExpensesJustification."Initial Time" := lStartingTime;
        EmplExpensesJustification."Ending Time" := lEndingTime;
        //EmplExpensesJustification.Price := pAmount;
        //EmplExpensesJustification.Amount := pAmount;

        //Msopena 12/02/2019 recoger el precio del tipo de gasto correspondiente de la tabla "Empl. Expenses Types"
        EmplExpensesJustification.Price := EmplExpensesTypes.Price;
        EmplExpensesJustification.Amount := pAmount * EmplExpensesTypes.Price;
        //Fin Msopena
        EmplExpensesJustification.INSERT(TRUE);

        IF pExpensesType = pExpensesType::food THEN BEGIN
            InsertResourceJournalLine2('', pResourceNo, 0, lStartingTime, lEndingTime, lDate, '', CraneMgtSetup."Food Work Type Code", CraneMgtSetup."Lunch Time UOM"); // RQ19.51.692 - JAGUTIERREZ - Añadimos Cod. Tipo Trabajo Comida
        END;
    end;

    /// <summary>
    /// InsertDisplacementEntry()
    /// </summary>
    procedure InsertDisplacementEntry(pResourceNo: Code[20]; pDisplacementType: Option ServItem,Vehicle,"Self/Others"; pCode: Code[20]; pInitialDate: Text[8]; pInitialTime: Text[6]; pEndingDate: Text[8]; pEndingTime: Text[6]; pKm: Decimal)
    var
        DisplacementEntry: Record "Displacement Entry_LDR";
        lInitialDate: Date;
        lInitialTime: Time;
        lEndingDate: Date;
        lEndingTime: Time;
        Res: Record "Resource";
        Emp: Record "Employee";
        ServItem: Record "Service Item";
        mRes: Record "Resource";
        UOM: Record "Unit of Measure";
    begin
        CraneMgtSetup.GET;
        ServiceMgtSetup.GET;

        Res.GET(pResourceNo);

        EVALUATE(lInitialDate, pInitialDate);
        EVALUATE(lInitialTime, pInitialTime);
        EVALUATE(lEndingDate, pEndingDate);
        EVALUATE(lEndingTime, pEndingTime);

        CLEAR(DisplacementEntry);
        DisplacementEntry.VALIDATE("Resource No.", pResourceNo);
        DisplacementEntry."Displacement Type" := pDisplacementType;
        DisplacementEntry.Code := pCode;
        DisplacementEntry.Date := lInitialDate;
        DisplacementEntry."Initial Time" := lInitialTime;
        DisplacementEntry."Ending Time" := lEndingTime;
        IF pDisplacementType = pDisplacementType::"Self/Others" THEN BEGIN
            DisplacementEntry.UOM := ServiceMgtSetup."Displacement Unit Of Measure";
            DisplacementEntry.Quantity := pKm;
        END ELSE BEGIN
            DisplacementEntry.UOM := ServiceMgtSetup."Disp. Time Unit Of Measure";
            DisplacementEntry.Quantity := ROUND((lEndingTime - lInitialTime) / 3600000, 0.00001);
        END;
        //DisplacementEntry."Employee No." := Emp."No.";

        IF pDisplacementType = pDisplacementType::ServItem THEN BEGIN
            ServItem.GET(pCode);
            DisplacementEntry.Description := ServItem.Description;
        END ELSE
            IF pDisplacementType = pDisplacementType::Vehicle THEN BEGIN
                mRes.GET(pCode);
                DisplacementEntry.Description := mRes.Name;
            END;

        DisplacementEntry.INSERT(TRUE);

        //Ahora hay que introducir los tiempos registrados del empleado.
        //RGBLANCO
        //MSOPENA/PCOLINA si es tipo "Self/Others" por ahora solo insertamos gasto, no imputamos horas de trabajo.
        //MSOPENA 06/05/2019 A partir de la fecha el procedimiento para vehículo particular debe comportarse de la misma manera que si fuera una furgoneta.
        //Se comenta la inserción de gasto de desplazamiento ya que se efectuará más adelante en la función InsertEmployeeTravelTime.
        IF pDisplacementType = pDisplacementType::"Self/Others" THEN BEGIN
            UOM.GET(DisplacementEntry.UOM);
            IF UOM."Expenses Type" <> '' THEN
                InsertDisplacementKmExpenses(pResourceNo, pDisplacementType, UOM."Expenses Type", lInitialDate, lInitialTime, lEndingTime, pKm);
        END;
        InsertEmployeeTravelTime(pResourceNo, lInitialDate, lInitialTime, lEndingTime, pKm, pDisplacementType);
    end;

    /// <summary>
    /// InsertEmployeeTravelTime()
    /// </summary>
    local procedure InsertEmployeeTravelTime(pResourceNo: Code[20]; pDate: Date; pInitialTime: Time; pEndingTime: Time; pKM: Integer; pDisplacementType: Option ServItem,Vehicle,"Self/Others")
    var
        ServHeader: Record "Service Header";
        ServItemLine: Record "Service Item Line";
        Res: Record "Resource";
        BaseCalendarCode: Code[10];
        DayType: Option Workday,Saturday,Holiday,LocalHoliday;
        HourType: Option Day,Night;
        TotalTime: Decimal;
        PartialTime: Decimal;
    begin
        Res.GET(pResourceNo);
        CraneMgtSetup.GET;
        CraneMgtSetup.TESTFIELD("Standard Ending Time");
        CraneMgtSetup.TESTFIELD("Standard Starting Time");
        //Clasificamos el dia segun Laborable, Sabado o Festivo para el recurso actual. Se devuelve el dato en variable local por referencia
        GetDayType(Res, pDate, DayType);

        //Dividimos por el horario de la configuracion de grua (EMPRESA)

        IF pInitialTime < CraneMgtSetup."Standard Starting Time" THEN BEGIN
            //Si el inicio se produce antes de la hora de inicio de la empresa
            IF pEndingTime < CraneMgtSetup."Standard Starting Time" THEN BEGIN
                //metemos todo en nocturno
                SplitResourceJournalLine1('', Res."No.", pInitialTime, pEndingTime, pDate, DayType, HourType::Night, pKM, pDisplacementType);
            END ELSE
                IF pEndingTime < CraneMgtSetup."Standard Ending Time" THEN BEGIN
                    //Parte nocturna
                    SplitResourceJournalLine1('', Res."No.", pInitialTime, CraneMgtSetup."Standard Starting Time", pDate, DayType, HourType::Night, pKM, pDisplacementType);
                    //parte diurna
                    SplitResourceJournalLine1('', Res."No.", CraneMgtSetup."Standard Starting Time", pEndingTime, pDate, DayType, HourType::Day, pKM, pDisplacementType);
                END ELSE BEGIN
                    //Parte nocturna
                    SplitResourceJournalLine1('', Res."No.", pInitialTime, CraneMgtSetup."Standard Starting Time", pDate, DayType, HourType::Night, pKM, pDisplacementType);
                    //parte diurna
                    SplitResourceJournalLine1('', Res."No.", CraneMgtSetup."Standard Starting Time", CraneMgtSetup."Standard Ending Time", pDate, DayType, HourType::Day, pKM, pDisplacementType);
                    //Parte nocturna
                    SplitResourceJournalLine1('', Res."No.", CraneMgtSetup."Standard Ending Time", pEndingTime, pDate, DayType, HourType::Night, pKM, pDisplacementType);
                END;
        END ELSE
            IF pInitialTime < CraneMgtSetup."Standard Ending Time" THEN BEGIN
                IF pEndingTime < CraneMgtSetup."Standard Ending Time" THEN BEGIN
                    //Todo diurno
                    SplitResourceJournalLine1('', Res."No.", pInitialTime, pEndingTime, pDate, DayType, HourType::Day, pKM, pDisplacementType);
                END ELSE BEGIN
                    //Parte diurna
                    SplitResourceJournalLine1('', Res."No.", pInitialTime, CraneMgtSetup."Standard Ending Time", pDate, DayType, HourType::Day, pKM, pDisplacementType);
                    //Parte nocturna
                    SplitResourceJournalLine1('', Res."No.", CraneMgtSetup."Standard Ending Time", pEndingTime, pDate, DayType, HourType::Night, pKM, pDisplacementType);
                END;
            END ELSE BEGIN
                //todo nocturno
                SplitResourceJournalLine1('', Res."No.", pInitialTime, pEndingTime, pDate, DayType, HourType::Night, pKM, pDisplacementType);
            END;
    end;

    /// <summary>
    /// SplitResourceJournalLine1()
    /// </summary>
    local procedure SplitResourceJournalLine1(pDocNo: Code[20]; pNo: Code[20]; pInitialTime: Time; pEndingTime: Time; pDate: Date; pDayType: Option Workday,Saturday,Holiday,LocalHoliday; pHourType: Option Day,Night; pKm: Integer; var pDisplacementType: Option ServItem,Vehicle,"Self/Others")
    var
        UnitofMeasure: Record "Unit of Measure";
        UOMCode: Code[20];
        TotalTime: Decimal;
        PartialTime: Decimal;
        Emp: Record "Employee";
        lHourType2: Option Day,Night,Extra;
    begin
        //Obtenemos el empleado asociado al recurso.
        CLEAR(Emp);
        Emp.SETRANGE("Resource No.", pNo);
        Emp.FINDFIRST;


        IF pDayType <> pDayType::Workday THEN BEGIN
            //No divido
            SplitResourceJournalLine2(pDocNo, pNo, pInitialTime, pEndingTime, pDate, pDayType, pHourType, pKm, pDisplacementType);
        END ELSE BEGIN
            //solo se divide el dia: de 6 a 22 (configurable)
            IF pHourType = pHourType::Day THEN BEGIN
                IF pInitialTime < Emp."Journey Starting Time" THEN BEGIN
                    IF pEndingTime < Emp."Journey Starting Time" THEN BEGIN
                        //Todo HE
                        SplitResourceJournalLine2(pDocNo, pNo, pInitialTime, pEndingTime, pDate, pDayType, lHourType2::Extra, pKm, pDisplacementType);
                    END ELSE
                        IF pEndingTime < Emp."Journey Ending Time" THEN BEGIN
                            //Parte HE
                            SplitResourceJournalLine2(pDocNo, pNo, pInitialTime, Emp."Journey Starting Time", pDate, pDayType, lHourType2::Extra, pKm, pDisplacementType);
                            //Parte Diurna
                            SplitResourceJournalLine2(pDocNo, pNo, Emp."Journey Starting Time", pEndingTime, pDate, pDayType, pHourType, pKm, pDisplacementType);
                        END ELSE BEGIN
                            //Parte HE
                            SplitResourceJournalLine2(pDocNo, pNo, pInitialTime, Emp."Journey Starting Time", pDate, pDayType, lHourType2::Extra, pKm, pDisplacementType);
                            //Parte Diurna
                            SplitResourceJournalLine2(pDocNo, pNo, Emp."Journey Starting Time", Emp."Journey Ending Time", pDate, pDayType, pHourType, pKm, pDisplacementType);
                            //parte HE
                            SplitResourceJournalLine2(pDocNo, pNo, Emp."Journey Ending Time", pEndingTime, pDate, pDayType, lHourType2::Extra, pKm, pDisplacementType);
                        END;
                END ELSE
                    IF pInitialTime < Emp."Journey Ending Time" THEN BEGIN
                        IF pEndingTime < Emp."Journey Ending Time" THEN BEGIN
                            //todo Diurno
                            SplitResourceJournalLine2(pDocNo, pNo, pInitialTime, pEndingTime, pDate, pDayType, pHourType, pKm, pDisplacementType);
                        END ELSE BEGIN
                            //parte Diurno
                            SplitResourceJournalLine2(pDocNo, pNo, pInitialTime, Emp."Journey Ending Time", pDate, pDayType, pHourType, pKm, pDisplacementType);
                            //parte HE
                            SplitResourceJournalLine2(pDocNo, pNo, Emp."Journey Ending Time", pEndingTime, pDate, pDayType, lHourType2::Extra, pKm, pDisplacementType);
                        END;
                    END ELSE BEGIN
                        //Tod0 HE
                        SplitResourceJournalLine2(pDocNo, pNo, pInitialTime, pEndingTime, pDate, pDayType, lHourType2::Extra, pKm, pDisplacementType);
                    END;
            END ELSE
                //Nocturno
                SplitResourceJournalLine2(pDocNo, pNo, pInitialTime, pEndingTime, pDate, pDayType, pHourType, pKm, pDisplacementType);
        END;
    end;

    /// <summary>
    /// GetDisplacementWorkTypeCode()
    /// </summary>
    local procedure GetDisplacementWorkTypeCode(pDisplacementType: Option ServItem,Vehicle,"Self/Others"): Code[10]
    begin
        CraneMgtSetup.GET;
        CraneMgtSetup.TESTFIELD("Ext Travel Work Type");
        CraneMgtSetup.TESTFIELD("Aux Veh. Travel Work Type");
        CraneMgtSetup.TESTFIELD("Self Veh. Travel Work Type");

        CASE pDisplacementType OF
            pDisplacementType::ServItem:
                EXIT(CraneMgtSetup."Ext Travel Work Type");
            pDisplacementType::Vehicle:
                EXIT(CraneMgtSetup."Aux Veh. Travel Work Type");
            pDisplacementType::"Self/Others":
                EXIT(CraneMgtSetup."Self Veh. Travel Work Type");
        END;
    end;

    /// <summary>
    /// SplitResourceJournalLine2()
    /// </summary>
    local procedure SplitResourceJournalLine2(pDocNo: Code[20]; pNo: Code[20]; pStartingTime: Time; pEndingTime: Time; pDate: Date; pDayType: Option Workday,Saturday,Holiday,LocalHoliday; pHourType2: Option Day,Night,Extra; pKm: Integer; pDisplacementType: Option ServItem,Vehicle,"Self/Others")
    var
        UnitofMeasure: Record "Unit of Measure";
        UOMCode: Code[20];
        TotalTime: Decimal;
    begin
        CraneMgtSetup.GET;
        ServiceMgtSetup.GET;

        //Comprobamos los campos de configuracion necesarios.
        TestSetupFields;

        TotalTime := ROUND((pEndingTime - pStartingTime) / 3600000, 0.00001);

        //Clasificamos el tiempo segun unidad de medida tipo de dia, y tipo de horario.
        IF (pDayType = pDayType::Workday) AND (pHourType2 = pHourType2::Day) THEN BEGIN
            UOMCode := ServiceMgtSetup."Disp. Time Unit Of Measure";
            //IF pDisplacementType <> pDisplacementType::"Self/Others" THEN
            InsertResourceJournalLine2(pDocNo, pNo, TotalTime, pStartingTime, pEndingTime, pDate, '', GetDisplacementWorkTypeCode(pDisplacementType), UOMCode);

        END ELSE
            IF (pDayType = pDayType::Workday) AND (pHourType2 = pHourType2::Extra) THEN BEGIN
                UOMCode := CraneMgtSetup."Extra traveltime UOM";
                IF pDisplacementType = pDisplacementType::ServItem THEN
                    InsertResourceJournalLine2(pDocNo, pNo, TotalTime, pStartingTime, pEndingTime, pDate, '', GetDisplacementWorkTypeCode(pDisplacementType), UOMCode)
                ELSE //IF pDisplacementType = pDisplacementType::Vehicle THEN
                    IF UnitofMeasure.GET(UOMCode) THEN
                        IF UnitofMeasure."Expenses Type" <> '' THEN
                            InsertDispExpensesSheet(pNo, pDisplacementType, UnitofMeasure."Expenses Type", pDate, pStartingTime, pEndingTime, pKm);

            END ELSE
                IF (pDayType = pDayType::Workday) AND (pHourType2 = pHourType2::Night) THEN BEGIN

                    UOMCode := CraneMgtSetup."Nighttime Displacement UOM";
                    IF pDisplacementType = pDisplacementType::ServItem THEN
                        InsertResourceJournalLine2(pDocNo, pNo, TotalTime, pStartingTime, pEndingTime, pDate, '', GetDisplacementWorkTypeCode(pDisplacementType), UOMCode)
                    ELSE //IF pDisplacementType = pDisplacementType::Vehicle THEN
                        IF UnitofMeasure.GET(UOMCode) THEN
                            IF UnitofMeasure."Expenses Type" <> '' THEN
                                InsertDispExpensesSheet(pNo, pDisplacementType, UnitofMeasure."Expenses Type", pDate, pStartingTime, pEndingTime, pKm);
                END ELSE
                    IF (pDayType = pDayType::Saturday) AND (pHourType2 = pHourType2::Day) THEN BEGIN

                        UOMCode := CraneMgtSetup."Traveltime Saturday UOM";
                        IF pDisplacementType = pDisplacementType::ServItem THEN
                            InsertResourceJournalLine2(pDocNo, pNo, TotalTime, pStartingTime, pEndingTime, pDate, '', GetDisplacementWorkTypeCode(pDisplacementType), UOMCode)
                        ELSE //IF pDisplacementType = pDisplacementType::Vehicle THEN
                            IF UnitofMeasure.GET(UOMCode) THEN
                                IF UnitofMeasure."Expenses Type" <> '' THEN
                                    InsertDispExpensesSheet(pNo, pDisplacementType, UnitofMeasure."Expenses Type", pDate, pStartingTime, pEndingTime, pKm);

                    END ELSE
                        IF (pDayType = pDayType::Saturday) AND (pHourType2 = pHourType2::Night) THEN BEGIN
                            UOMCode := CraneMgtSetup."Nighttraveltime Saturday UOM";
                            IF pDisplacementType = pDisplacementType::ServItem THEN
                                InsertResourceJournalLine2(pDocNo, pNo, TotalTime, pStartingTime, pEndingTime, pDate, '', GetDisplacementWorkTypeCode(pDisplacementType), UOMCode)
                            ELSE //IF pDisplacementType = pDisplacementType::Vehicle THEN
                                IF UnitofMeasure.GET(UOMCode) THEN
                                    IF UnitofMeasure."Expenses Type" <> '' THEN
                                        InsertDispExpensesSheet(pNo, pDisplacementType, UnitofMeasure."Expenses Type", pDate, pStartingTime, pEndingTime, pKm);

                        END ELSE
                            IF (pDayType IN [pDayType::Holiday, pDayType::LocalHoliday]) AND (pHourType2 = pHourType2::Day) THEN BEGIN
                                UOMCode := CraneMgtSetup."Traveltime Holiday UOM";
                                IF pDisplacementType = pDisplacementType::ServItem THEN
                                    InsertResourceJournalLine2(pDocNo, pNo, TotalTime, pStartingTime, pEndingTime, pDate, '', GetDisplacementWorkTypeCode(pDisplacementType), UOMCode)
                                ELSE //IF pDisplacementType = pDisplacementType::Vehicle THEN
                                    IF UnitofMeasure.GET(UOMCode) THEN
                                        IF UnitofMeasure."Expenses Type" <> '' THEN
                                            InsertDispExpensesSheet(pNo, pDisplacementType, UnitofMeasure."Expenses Type", pDate, pStartingTime, pEndingTime, pKm);

                            END ELSE
                                IF (pDayType IN [pDayType::Holiday, pDayType::LocalHoliday]) AND (pHourType2 = pHourType2::Night) THEN BEGIN
                                    UOMCode := CraneMgtSetup."Nighttraveltime Holiday UOM";
                                    IF pDisplacementType = pDisplacementType::ServItem THEN
                                        InsertResourceJournalLine2(pDocNo, pNo, TotalTime, pStartingTime, pEndingTime, pDate, '', GetDisplacementWorkTypeCode(pDisplacementType), UOMCode)
                                    ELSE //IF pDisplacementType = pDisplacementType::Vehicle THEN
                                        IF UnitofMeasure.GET(UOMCode) THEN
                                            IF UnitofMeasure."Expenses Type" <> '' THEN
                                                InsertDispExpensesSheet(pNo, pDisplacementType, UnitofMeasure."Expenses Type", pDate, pStartingTime, pEndingTime, pKm);
                                END;
    end;

    /// <summary>
    /// InsertDispExpensesSheet()
    /// </summary>
    procedure InsertDispExpensesSheet(pResourceNo: Code[20]; pDisplacementType: Option ServItem,Vehicle,"Self/Others"; pExpensesCode: Code[10]; var pExpensesDate: Date; pExpInitialTime: Time; pExtEndingTime: Time; pKm: Integer)
    var
        EmplExpensesTypes: Record "Empl. Expenses Types_LDR";
        Employee: Record "Employee";
        EmplExpensesJustification: Record "Empl. Expenses Justificat_LDR";
    begin
        //Coger el empleado desde el recurso
        CLEAR(Employee);
        Employee.SETRANGE("Resource No.", pResourceNo);
        IF NOT Employee.FINDFIRST THEN
            ERROR(Text001, pResourceNo);

        //Coger el tipo de gasto con la opcion + empleado
        CLEAR(EmplExpensesTypes);
        EmplExpensesTypes.SETRANGE("Employee No.", Employee."No.");
        EmplExpensesTypes.SETRANGE(Code, pExpensesCode);
        IF NOT EmplExpensesTypes.FINDFIRST THEN
            ERROR(Text003, Employee."No.", pExpensesCode);

        //grabar datos en la tabla de gastos.
        CLEAR(EmplExpensesJustification);
        EmplExpensesJustification.INIT;
        EmplExpensesJustification.VALIDATE("Employee No.", Employee."No.");
        EmplExpensesJustification.VALIDATE(Date, pExpensesDate);
        EmplExpensesJustification.VALIDATE("Expense Type", EmplExpensesTypes.Code);
        EmplExpensesJustification.Quantity := ROUND((pExtEndingTime - pExpInitialTime) / 3600000, 0.00001);
        EmplExpensesJustification.VALIDATE("Initial Time", pExpInitialTime);
        EmplExpensesJustification.VALIDATE("Ending Time", pExtEndingTime);
        EmplExpensesJustification.Price := EmplExpensesTypes.Price;
        EmplExpensesJustification.Amount := EmplExpensesTypes.Price * EmplExpensesJustification.Quantity;
        EmplExpensesJustification.INSERT(TRUE);
    end;

    /// <summary>
    /// InsertRefillEntry()
    /// </summary>
    procedure InsertRefillEntry(pResourceNo: Code[20]; pTransactionCode: Code[10]; pLoadDate: Text[8]; pLoadTime: Text[6]; pVendorCode: Code[20]; pLiters: Decimal; pUnitPrice: Decimal; pAmount: Decimal; pCounterQty: Integer; pServItemNo: Code[20]; pTerminalCode: Code[10])
    var
        isDistribution: BoolEAN;
        RefillType: Option Internal,External;
    begin
        IF (pVendorCode = '') AND (pUnitPrice = 0) AND (pAmount = 0) THEN
            isDistribution := TRUE;

        IF isDistribution THEN
            RefillType := RefillType::Internal
        ELSE
            RefillType := RefillType::External;

        InsertRefillEntry2(pResourceNo, pTransactionCode, pLoadDate, pLoadTime, pVendorCode, pLiters, pUnitPrice, pAmount, pCounterQty, pServItemNo, pTerminalCode, isDistribution, RefillType);
    end;

    /// <summary>
    /// InsertRefillEntry2()
    /// </summary>
    procedure InsertRefillEntry2(pResourceNo: Code[20]; pTransactionCode: Code[10]; pLoadDate: Text[8]; pLoadTime: Text[6]; pVendorCode: Code[20]; pLiters: Decimal; pUnitPrice: Decimal; pAmount: Decimal; pCounterQty: Integer; pServItemNo: Code[20]; pTerminalCode: Code[10]; pDistribution: BoolEAN; pRefillType: Option Internal,External)
    var
        ServiceItemRefillsReg: Record "Service Item Refills Reg_LDR";
        ServItem: Record "Service Item";
        lLoadDate: Date;
        lLoadTime: Time;
        ServItemCounter: Record "Service Item Counter_LDR";
    begin

        ServItem.GET(pServItemNo);

        //Evaluamos las variables de texto en variables correctas.
        EVALUATE(lLoadDate, pLoadDate);
        EVALUATE(lLoadTime, pLoadTime);

        ServiceItemRefillsReg."Transaction Type" := '01';
        ServiceItemRefillsReg."Transaction Code" := pTransactionCode;
        ServiceItemRefillsReg."Terminal Code" := pTerminalCode;
        ServiceItemRefillsReg."Transaction Date" := lLoadDate;
        ServiceItemRefillsReg."Transaction Time" := lLoadTime;
        ServiceItemRefillsReg."Refill Type" := '';
        ServiceItemRefillsReg."Vehicle No" := ServItem."Refueling Vehicle ID";
        ServiceItemRefillsReg."Service Item Code" := pServItemNo;
        ServiceItemRefillsReg."Driver No." := pResourceNo;

        CLEAR(ServItemCounter);
        ServItemCounter.SETRANGE(Code, pServItemNo);
        ServItemCounter.SETRANGE("Terminal Code", pTerminalCode);
        IF NOT ServItemCounter.FINDFIRST THEN
            ERROR(Text004, pTerminalCode, pServItemNo);

        IF (ServItemCounter."Unit Measure" = ServItemCounter."Unit Measure"::Hours) THEN BEGIN
            ServiceItemRefillsReg."Before Value" := ServItemCounter."KM/H Actual";
            ServiceItemRefillsReg."Actual Value" := pCounterQty;
            ServiceItemRefillsReg."Cont Type" := 1;
        END ELSE BEGIN
            ServiceItemRefillsReg."Before Value" := ServItemCounter."KM/H Actual";
            ServiceItemRefillsReg."Actual Value" := pCounterQty;
            ServiceItemRefillsReg."Cont Type" := 2;
        END;

        ServiceItemRefillsReg."Item Type" := '01';
        ServiceItemRefillsReg."Transaction Volume" := pLiters;
        ServiceItemRefillsReg."Vendor No." := pVendorCode;
        ServiceItemRefillsReg."Unit Price" := pUnitPrice;
        ServiceItemRefillsReg.Amount := pAmount;
        ServiceItemRefillsReg."Distribution Refill" := pDistribution;
        ServiceItemRefillsReg."Refill Type I/E" := pRefillType;
        ServiceItemRefillsReg.INSERT;
    end;

    /// <summary>
    /// SetExported()
    /// </summary>
    procedure SetExported(pType: Option vendor,ServItem,Vehicle,WorkType,AllocLog; pNo: Code[20])
    var
        Vendor: Record "Vendor";
        ServItem: Record "Service Item";
        VehicleResource: Record "Resource";
        WorkType: Record "Work Type";
        ServOrderAllocLog: Record "ServOrderAllocLog_LDR";
        ExptoMobilityRelation: Record "Exp. to Mobility Relation_LDR";
    begin
        CASE pType OF
            pType::vendor:
                BEGIN
                    Vendor.GET(pNo);
                    Vendor."Exported to Mobility" := TRUE;
                    Vendor.MODIFY;
                END;
            pType::ServItem:
                BEGIN
                    //      ServItem.GET(pNo);
                    //      ServItem."Exported to Mobility" := TRUE;
                    //      ServItem.MODIFY;
                    IF ExptoMobilityRelation.GET(5940, pNo, 0) THEN BEGIN
                        ExptoMobilityRelation."Exported to Mobility" := TRUE;
                        ExptoMobilityRelation.MODIFY;
                    END ELSE BEGIN
                        ExptoMobilityRelation."Table Id" := 5940;
                        ExptoMobilityRelation.Code := pNo;
                        ExptoMobilityRelation."Exported to Mobility" := TRUE;
                        ExptoMobilityRelation.INSERT;
                    END;
                END;
            pType::Vehicle:
                BEGIN
                    //      VehicleResource.GET(pNo);
                    //      VehicleResource."Exported to Mobility" := TRUE;
                    //      VehicleResource.MODIFY;
                    IF ExptoMobilityRelation.GET(156, pNo, 0) THEN BEGIN
                        ExptoMobilityRelation."Exported to Mobility" := TRUE;
                        ExptoMobilityRelation.MODIFY;
                    END ELSE BEGIN
                        ExptoMobilityRelation."Table Id" := 156;
                        ExptoMobilityRelation.Code := pNo;
                        ExptoMobilityRelation."Exported to Mobility" := TRUE;
                        ExptoMobilityRelation.INSERT;
                    END;
                END;
            pType::WorkType:
                BEGIN
                    WorkType.GET(pNo);
                    WorkType."Exported to Mobility" := TRUE;
                    WorkType.MODIFY;
                END;
        END;
    end;

    /// <summary>
    /// SetExported2Params()
    /// </summary>
    procedure SetExported2Params(pType: Option counter; pNo: Code[20]; pNo2: Code[20])
    var
        ServiceItemCounter: Record "Service Item Counter_LDR";
        ExptoMobilityRelation: Record "Exp. to Mobility Relation_LDR";
    begin
        CASE pType OF
            pType::counter:
                BEGIN
                    //      ServiceItemCounter.GET(pNo,pNo2);
                    //      ServiceItemCounter."Exported to Mobility" := TRUE;
                    //      ServiceItemCounter.MODIFY;
                    IF ExptoMobilityRelation.GET(50011, pNo, pNo2) THEN BEGIN
                        ExptoMobilityRelation."Exported to Mobility" := TRUE;
                        ExptoMobilityRelation.MODIFY;
                    END ELSE BEGIN
                        ExptoMobilityRelation."Table Id" := 50011;
                        ExptoMobilityRelation.Code := pNo;
                        EVALUATE(ExptoMobilityRelation."Code Int", pNo2);
                        ExptoMobilityRelation."Exported to Mobility" := TRUE;
                        ExptoMobilityRelation.INSERT;
                    END;
                END;
        END;
    end;

    /// <summary>
    /// SetExportedInt()
    /// </summary>
    procedure SetExportedInt(pType: Option AllocLog; pNo: Integer)
    var
        ServOrderAllocLog: Record "ServOrderAllocLog_LDR";
    begin
        CASE pType OF
            pType::AllocLog:
                BEGIN
                    ServOrderAllocLog.GET(pNo);
                    ServOrderAllocLog."Exported to Mobility" := TRUE;
                    ServOrderAllocLog.MODIFY;
                END;
        END;
    end;

    /// <summary>
    /// CreatePDFWorksheet()
    /// </summary>
    procedure CreatePDFWorksheet(pServOrderNo: Code[20]; pDate: Text[8]; pResourceNo: Code[20]; pBlob: BigText)
    var
        OutStream: OutStream;
        Bytes: DotNet Array; //TODO: Error: No existe el Dotnet Array
        Convert: DotNet Convert; //TODO: Error: No existe el Dotnet Convert
        MemoryStream: DotNet MemoryStream; //TODO: Error: No existe el Dotnet MemoryStream
        FullPath: Text;
        FullFileName: Text;
        NewRecordLink: Record "Record Link";
        fileMgt: Codeunit "File Management";
        TempBlob: Record 99008535; //TODO: Error: La tabla "TempBlob" está eliminada
        FileManagement: Codeunit "File Management";
        lDate: Date;
        ServHeader: Record "Service Header";
        ServItemLine: Record "Service Item Line";
        PostedServItemLine: Record "Posted Service Item Line_LDR";
        PostedServHeader: Record "Posted Service Header_LDR";
    begin

        CraneMgtSetup.GET;
        CraneMgtSetup.TESTFIELD("Worksheet PDF Path");

        Bytes := Convert.FromBase64String(pBlob);
        MemoryStream := MemoryStream.MemoryStream(Bytes);

        TempBlob.Blob.CREATEOUTSTREAM(OutStream);
        MemoryStream.WriteTo(OutStream);

        EVALUATE(lDate, pDate);

        CLEAR(ServItemLine);
        ServItemLine.SETRANGE("Document Type", ServItemLine."Document Type"::Order);
        ServItemLine.SETRANGE("Document No.", pServOrderNo);
        //ServItemLine.SETRANGE("Requested Starting Date",lDate);
        IF ServItemLine.FINDFIRST THEN BEGIN

            FullPath := CraneMgtSetup."Worksheet PDF Path" + '\' + ClEANFileName(pServOrderNo) + '_' + FORMAT(ServItemLine."Line No.") + '_Parte' + pDate + '_' + pResourceNo + '.pdf';

            CLEAR(ServHeader);
            ServHeader.GET(ServHeader."Document Type"::Order, pServOrderNo);

            IF BLOBExport(TempBlob, FullPath) <> '' THEN BEGIN
                CLEAR(NewRecordLink);
                NewRecordLink."Record ID" := ServHeader.RECORDID;
                NewRecordLink.URL1 := FullPath;
                NewRecordLink.Description := fileMgt.GetFileName(FullPath);
                NewRecordLink."User ID" := USERID;
                NewRecordLink.Company := COMPANYNAME;
                NewRecordLink.INSERT(TRUE);
            END;
        END ELSE BEGIN
            CLEAR(PostedServItemLine);
            PostedServItemLine.SETRANGE("No.", pServOrderNo);
            //PostedServItemLine.SETRANGE("Requested Starting Date",lDate);
            PostedServItemLine.FINDFIRST;

            FullPath := CraneMgtSetup."Worksheet PDF Path" + '\' + ClEANFileName(pServOrderNo) + '_' + FORMAT(PostedServItemLine."Line No.") + '_Parte' + pDate + '_' + pResourceNo + '.pdf';

            CLEAR(PostedServHeader);
            PostedServHeader.GET(pServOrderNo);

            IF BLOBExport(TempBlob, FullPath) <> '' THEN BEGIN
                CLEAR(NewRecordLink);
                NewRecordLink."Record ID" := PostedServHeader.RECORDID;
                NewRecordLink.URL1 := FullPath;
                NewRecordLink.Description := fileMgt.GetFileName(FullPath);
                NewRecordLink."User ID" := USERID;
                NewRecordLink.Company := COMPANYNAME;
                NewRecordLink.INSERT(TRUE);
            END;


        END;
    end;

    /// <summary>
    /// BLOBExport()
    /// </summary>
    procedure BLOBExport(var BLOBRef: Record 99008535 temporary; Name: Text): Text //TODO: Error: La tabla "TempBlob" está eliminada
    var
        NVInStream: InStream;
        myFile: File;
        OutStream: OutStream;
        Value: Text;
    begin

        BLOBRef.Blob.CREATEINSTREAM(NVInStream);

        myFile.CREATE(Name);
        myFile.CREATEOUTSTREAM(OutStream);
        COPYSTREAM(OutStream, NVInStream);
        myFile.CLOSE;

        EXIT(Name);
    end;

    /// <summary>
    /// ClEANFileName()
    /// </summary>
    procedure ClEANFileName(DocNo: Code[20]) FIleName: Text[1024]
    begin
        FIleName := CONVERTSTR(DocNo, '/\', '__');

        EXIT(FIleName);
    end;

    /// <summary>
    /// SplitResourceJournalLine1_2()
    /// </summary>
    local procedure SplitResourceJournalLine1_2(pDocNo: Code[20]; pNo: Code[20]; pQty: Decimal; pInitialTime: Time; pEndingTime: Time; pDate: Date; pDescription: Text[50]; pWorkTypeCode: Code[10]; pUOM: Code[10]; pDayType: Option Workday,Saturday,Holiday,LocalHoliday; pHourType: Option Day,Night)
    var
        UnitofMeasure: Record "Unit of Measure";
        UOMCode: Code[20];
        TotalTime: Decimal;
        PartialTime: Decimal;
        Emp: Record "Employee";
        lHourType2: Option Day,Night,Extra;
    begin
        //Obtenemos el empleado asociado al recurso.
        CLEAR(Emp);
        Emp.SETRANGE("Resource No.", pNo);
        Emp.FINDFIRST;

        IF pDayType <> pDayType::Workday THEN BEGIN
            //No divido
            IF pDayType = pDayType::Saturday THEN BEGIN
                IF pHourType = pHourType::Day THEN
                    UOMCode := CraneMgtSetup."Daytime Saturday UOM"
                ELSE
                    UOMCode := CraneMgtSetup."Nighttime Saturday UOM";
            END ELSE BEGIN
                IF pHourType = pHourType::Day THEN
                    UOMCode := CraneMgtSetup."Daytime Holiday UOM"
                ELSE
                    UOMCode := CraneMgtSetup."Nighttime Holiday UOM";
            END;

            InsertResourceJournalLine2(pDocNo, pNo, pQty, pInitialTime, pEndingTime, pDate, pDescription, pWorkTypeCode, UOMCode);
        END ELSE BEGIN
            //solo se divide el dia: de 6 a 22 (configurable)
            IF pHourType = pHourType::Day THEN BEGIN
                IF pInitialTime < Emp."Journey Starting Time" THEN BEGIN
                    IF pEndingTime < Emp."Journey Starting Time" THEN BEGIN
                        //Todo HE
                        UOMCode := CraneMgtSetup."Extratime UOM";
                        InsertResourceJournalLine2(pDocNo, pNo, pQty, pInitialTime, pEndingTime, pDate, pDescription, pWorkTypeCode, UOMCode);
                    END ELSE
                        IF pEndingTime < Emp."Journey Ending Time" THEN BEGIN
                            //Parte HE
                            UOMCode := CraneMgtSetup."Extratime UOM";
                            InsertResourceJournalLine2(pDocNo, pNo, pQty, pInitialTime, Emp."Journey Starting Time", pDate, pDescription, pWorkTypeCode, UOMCode);
                            //Parte Diurna
                            UOMCode := CraneMgtSetup."Daytime Workday UOM";
                            InsertResourceJournalLine2(pDocNo, pNo, pQty, Emp."Journey Starting Time", pEndingTime, pDate, pDescription, pWorkTypeCode, UOMCode);
                        END ELSE BEGIN
                            //Parte HE
                            UOMCode := CraneMgtSetup."Extratime UOM";
                            InsertResourceJournalLine2(pDocNo, pNo, pQty, pInitialTime, Emp."Journey Starting Time", pDate, pDescription, pWorkTypeCode, UOMCode);
                            //Parte Diurna
                            UOMCode := CraneMgtSetup."Daytime Workday UOM";
                            InsertResourceJournalLine2(pDocNo, pNo, pQty, Emp."Journey Starting Time", Emp."Journey Ending Time", pDate, pDescription, pWorkTypeCode, UOMCode);
                            //parte HE
                            UOMCode := CraneMgtSetup."Extratime UOM";
                            InsertResourceJournalLine2(pDocNo, pNo, pQty, Emp."Journey Ending Time", pEndingTime, pDate, pDescription, pWorkTypeCode, UOMCode);
                        END;
                END ELSE
                    IF pInitialTime < Emp."Journey Ending Time" THEN BEGIN
                        IF pEndingTime <= Emp."Journey Ending Time" THEN BEGIN
                            //todo Diurno
                            UOMCode := CraneMgtSetup."Daytime Workday UOM";
                            InsertResourceJournalLine2(pDocNo, pNo, pQty, pInitialTime, pEndingTime, pDate, pDescription, pWorkTypeCode, UOMCode);
                        END ELSE BEGIN
                            //parte Diurno
                            UOMCode := CraneMgtSetup."Daytime Workday UOM";
                            InsertResourceJournalLine2(pDocNo, pNo, pQty, pInitialTime, Emp."Journey Ending Time", pDate, pDescription, pWorkTypeCode, UOMCode);
                            //parte HE
                            UOMCode := CraneMgtSetup."Extratime UOM";
                            InsertResourceJournalLine2(pDocNo, pNo, pQty, Emp."Journey Ending Time", pEndingTime, pDate, pDescription, pWorkTypeCode, UOMCode);
                        END;
                    END ELSE BEGIN
                        //Tod0 HE
                        UOMCode := CraneMgtSetup."Extratime UOM";
                        InsertResourceJournalLine2(pDocNo, pNo, pQty, pInitialTime, pEndingTime, pDate, pDescription, pWorkTypeCode, UOMCode);
                    END;
            END ELSE BEGIN
                //Nocturno
                UOMCode := CraneMgtSetup."Nighttime Workday UOM";
                InsertResourceJournalLine2(pDocNo, pNo, pQty, pInitialTime, pEndingTime, pDate, pDescription, pWorkTypeCode, UOMCode);
            END;
        END;
    end;

    /// <summary>
    /// InsertDisplacementKmExpenses()
    /// </summary>
    procedure InsertDisplacementKmExpenses(pResourceNo: Code[20]; pDisplacementType: Option ServItem,Vehicle,"Self/Others"; pExpensesCode: Code[10]; var pExpensesDate: Date; pExpInitialTime: Time; pExtEndingTime: Time; pKm: Integer)
    var
        EmplExpensesTypes: Record "Empl. Expenses Types_LDR";
        Employee: Record "Employee";
        EmplExpensesJustification: Record "Empl. Expenses Justificat_LDR";
    begin
        //Coger el empleado desde el recurso
        CLEAR(Employee);
        Employee.SETRANGE("Resource No.", pResourceNo);
        IF NOT Employee.FINDFIRST THEN
            ERROR(Text001, pResourceNo);

        //Coger el tipo de gasto con la opcion + empleado
        CLEAR(EmplExpensesTypes);
        EmplExpensesTypes.SETRANGE("Employee No.", Employee."No.");
        EmplExpensesTypes.SETRANGE(Code, pExpensesCode);
        IF NOT EmplExpensesTypes.FINDFIRST THEN
            ERROR(Text003, Employee."No.", pExpensesCode);

        //grabar datos en la tabla de gastos.
        CLEAR(EmplExpensesJustification);
        EmplExpensesJustification.INIT;
        EmplExpensesJustification.VALIDATE("Employee No.", Employee."No.");
        EmplExpensesJustification.VALIDATE(Date, pExpensesDate);
        EmplExpensesJustification.VALIDATE("Expense Type", EmplExpensesTypes.Code);
        EmplExpensesJustification.Quantity := pKm;
        EmplExpensesJustification.VALIDATE("Initial Time", pExpInitialTime);
        EmplExpensesJustification.VALIDATE("Ending Time", pExtEndingTime);
        EmplExpensesJustification.Price := EmplExpensesTypes.Price;
        EmplExpensesJustification.Amount := EmplExpensesTypes.Price * EmplExpensesJustification.Quantity;
        EmplExpensesJustification.INSERT(TRUE);
    end;

    /// <summary>
    /// OnResourceInsert()
    /// </summary>
    [EventSubscriber(ObjectType::Table, 156, 'OnAfterInsertEvent', '', false, false)]
    local procedure OnResourceInsert(var Rec: Record "Resource"; RunTrigger: BoolEAN)
    var
        ExptoMobilityRelation: Record "Exp. to Mobility Relation_LDR";
    begin
        ExptoMobilityRelation."Table Id" := 156;
        ExptoMobilityRelation.Code := Rec."No.";
        ExptoMobilityRelation.INSERT;
    end;

    /// <summary>
    /// OnResourceModify()
    /// </summary>
    [EventSubscriber(ObjectType::Table, 156, 'OnAfterModifyEvent', '', false, false)]
    local procedure OnResourceModify(var Rec: Record "Resource"; var xRec: Record "Resource"; RunTrigger: BoolEAN)
    var
        ExptoMobilityRelation: Record "Exp. to Mobility Relation_LDR";
    begin
        IF (Rec.Name <> xRec.Name) THEN BEGIN
            IF ExptoMobilityRelation.GET(156, Rec."No.", 0) THEN BEGIN
                ExptoMobilityRelation."Exported to Mobility" := FALSE;
                ExptoMobilityRelation.MODIFY;
            END ELSE BEGIN
                ExptoMobilityRelation."Table Id" := 156;
                ExptoMobilityRelation.Code := Rec."No.";
                ExptoMobilityRelation.INSERT;
            END;
        END;
    end;

    /// <summary>
    /// OnResourceDelete()
    /// </summary>
    [EventSubscriber(ObjectType::Table, 156, 'OnAfterDeleteEvent', '', false, false)]
    local procedure OnResourceDelete(var Rec: Record "Resource"; RunTrigger: BoolEAN)
    var
        ExptoMobilityRelation: Record "Exp. to Mobility Relation_LDR";
    begin
        ExptoMobilityRelation.GET(156, Rec."No.");
        IF ExptoMobilityRelation.DELETE THEN;
    end;

    /// <summary>
    /// OnServItemInsert()
    /// </summary>
    [EventSubscriber(ObjectType::Table, 5940, 'OnAfterInsertEvent', '', false, false)]
    local procedure OnServItemInsert(var Rec: Record "Service Item"; RunTrigger: BoolEAN)
    var
        ExptoMobilityRelation: Record "Exp. to Mobility Relation_LDR";
    begin
        ExptoMobilityRelation."Table Id" := 5940;
        ExptoMobilityRelation.Code := Rec."No.";
        ExptoMobilityRelation.INSERT;
    end;

    /// <summary>
    /// OnServItemModify()
    /// </summary>
    [EventSubscriber(ObjectType::Table, 5940, 'OnAfterModifyEvent', '', false, false)]
    local procedure OnServItemModify(var Rec: Record "Service Item"; var xRec: Record "Service Item"; RunTrigger: BoolEAN)
    var
        ExptoMobilityRelation: Record "Exp. to Mobility Relation_LDR";
    begin
        IF (Rec.Description <> xRec.Description) OR
           (Rec."Serial No." <> xRec."Serial No.") OR
           (Rec."Manufacturer Code" <> xRec."Manufacturer Code") OR
           (Rec."Model Code" <> xRec."Model Code") OR
           (Rec."Service Item Type Code" <> xRec."Service Item Type Code") OR
           (Rec."Service Item Type Subtype" <> xRec."Service Item Type Subtype") OR
           (Rec."Displacement Vehicle" <> xRec."Displacement Vehicle") THEN BEGIN
            IF ExptoMobilityRelation.GET(5940, Rec."No.", 0) THEN BEGIN
                ExptoMobilityRelation."Exported to Mobility" := FALSE;
                ExptoMobilityRelation.MODIFY;
            END ELSE BEGIN
                ExptoMobilityRelation."Table Id" := 5940;
                ExptoMobilityRelation.Code := Rec."No.";
                ExptoMobilityRelation.INSERT;
            END;
        END;
    end;

    /// <summary>
    /// OnServItemDelete()
    /// </summary>
    [EventSubscriber(ObjectType::Table, 5940, 'OnAfterDeleteEvent', '', false, false)]
    local procedure OnServItemDelete(var Rec: Record "Service Item"; RunTrigger: BoolEAN)
    var
        ExptoMobilityRelation: Record "Exp. to Mobility Relation_LDR";
    begin
        ExptoMobilityRelation.GET(5940, Rec."No.");
        IF ExptoMobilityRelation.DELETE THEN;
    end;

    /// <summary>
    /// OnServItemCounterInsert()
    /// </summary>
    [EventSubscriber(ObjectType::Table, 50011, 'OnAfterInsertEvent', '', false, false)]
    local procedure OnServItemCounterInsert(var Rec: Record "Service Item Counter_LDR"; RunTrigger: BoolEAN)
    var
        ExptoMobilityRelation: Record "Exp. to Mobility Relation_LDR";
    begin
        ExptoMobilityRelation."Table Id" := 50011;
        ExptoMobilityRelation.Code := Rec.Code;
        ExptoMobilityRelation."Code Int" := Rec."Counter No.";
        ExptoMobilityRelation.INSERT;
    end;

    /// <summary>
    /// OnServItemCounterModify()
    /// </summary>
    [EventSubscriber(ObjectType::Table, 50011, 'OnAfterModifyEvent', '', false, false)]
    local procedure OnServItemCounterModify(var Rec: Record "Service Item Counter_LDR"; var xRec: Record "Service Item Counter_LDR"; RunTrigger: BoolEAN)
    var
        ExptoMobilityRelation: Record "Exp. to Mobility Relation_LDR";
    begin
        IF (Rec.Description <> xRec.Description) OR
           (Rec."Terminal Code" <> xRec."Terminal Code") THEN BEGIN
            IF ExptoMobilityRelation.GET(50011, Rec.Code, Rec."Counter No.") THEN BEGIN
                ExptoMobilityRelation."Exported to Mobility" := FALSE;
                ExptoMobilityRelation.MODIFY;
            END ELSE BEGIN
                ExptoMobilityRelation."Table Id" := 50011;
                ExptoMobilityRelation.Code := Rec.Code;
                ExptoMobilityRelation."Code Int" := Rec."Counter No.";
                ExptoMobilityRelation.INSERT;
            END;
        END;
    end;

    /// <summary>
    /// OnServItemCounterDelete()
    /// </summary>
    [EventSubscriber(ObjectType::Table, 50011, 'OnAfterDeleteEvent', '', false, false)]
    local procedure OnServItemCounterDelete(var Rec: Record "Service Item Counter_LDR"; RunTrigger: BoolEAN)
    var
        ExptoMobilityRelation: Record "Exp. to Mobility Relation_LDR";
    begin
        ExptoMobilityRelation.GET(50011, Rec.Code, Rec."Counter No.");
        IF ExptoMobilityRelation.DELETE THEN;
    end;
    */
}