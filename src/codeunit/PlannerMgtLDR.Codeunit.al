/// <summary>
/// Codeunit Planner Mgt._LDR (ID 50008)
/// </summary>
codeunit 50008 "Planner Mgt._LDR"
{
    /*
    trigger OnRun()
    begin
    end;

    var
        PlannerSetup: Record "Order Planner Setup_LDR";
        Resource: Record "Resource";
        Planner: Page "Planner";
        Entry: DotNet PlannerEvent; //TODO: Error: No existe el Dotnet PlannerEvent
        ServHeader: Record "Service Header";
        ServItemLine: Record "Service Item Line";
        ServOrderAllocation: Record "Service Order Allocation";
        LineNoAux: Integer;
        ServiceItem: Record "Service Item";
        RepairStatus: Record "Repair Status";
        ServMgtSetup: Record "Service Mgt. Setup";
        CraneMgtSetup: Record "Crane Mgt. Setup_LDR";
        Text001: Label 'Do you want to assign all lines?';
        Text002: Label 'Do you want to unassign all lines?';
        Text003: Label 'This Serv. Item doesn''t allows a Driver Assignment.';
        SummerTimeTable: Integer;
        Text004: Label 'Deleting a Pickup Platfform Serv. Order assign, will delete completelly the Service Order and it will be necessary to create it again from the beggining. Are you sure you want to continue?';
        Text005: Label 'Process cancelled by the user';
        Text006: Label 'This Service Item still has some Open Pickups. Please, process them prior to planning new Deliveries';
        Text007: Label 'Plattform No. %1 Delivery';
        Text008: Label 'Delivery with order No. %1';
        Text009: Label 'Pickup with order No. %1';

    /// <summary>
    /// ProcessChange()
    /// </summary>
    procedure ProcessChange(Entry2: DotNet PlannerEvent) //TODO: Error: No existe el Dotnet PlannerEvent
    var
        ServOrderAllocation: Record "Service Order Allocation";
        NewServOrderAllocation: Record "Service Order Allocation";
        StartDateTime: DateTime;
        EndDateTime: DateTime;
        ServItemLine: Record "Service Item Line";
        LineNo: Integer;
        ServHeader: Record "Service Header";
        ServOrder: Page "Service Order";
        Str: Text;
        CraneMgtSetup: Record "Crane Mgt. Setup_LDR";
        LineNoAux: Integer;
        ServiceItem: Record "Service Item";
        OrderPlannerSetup: Record "Order Planner Setup_LDR";
        RepairStatus: Record "Repair Status";
        ServAllocationManagement: Codeunit "ServAllocationManagement";
        ResourcePage: Page "Skilled Resource List";
        ResSkill: Record "Resource Skill";
        ServContractLine: Record "Service Contract Line";
    begin
        PlannerSetup.GET;
        Entry := Entry2;

        CASE Entry2.EventType OF
            '1':
                ResizeServiceOrderTask;

            '2':
                AssignCraneTasks;

            '3':
                DeleteOrderAssign;

            '4':
                ShowOrder;

            '5':
                AssignDriver;

            '6':
                AssignExtraResource;

            '7':
                ChangeBinCustomer;

            '8':
                ActiveServItemLineMobility;

            '9':
                BEGIN
                    EVALUATE(LineNoAux, Entry.ServOrderLineNo);
                    AssignTruck(Entry.ServOrderNo, LineNoAux);
                END;

            '10':

                ShowServiceItem;
            ELSE
                MESSAGE('Otros');
        END;
    end;

    /// <summary>
    /// InsertDriver()
    /// </summary>
    local procedure InsertDriver(ServItemLine: Record "Service Item Line"; MainDriver: BoolEAN)
    var
        SkilledResourceList: Page "Skilled Resource List";
        ResSkill: Record "Resource Skill";
        ServOrderAllocation: Record "Service Order Allocation";
        NewServOrderAllocation: Record "Service Order Allocation";
        ServItemLine2: Record "Service Item Line";
    begin
        //Tiene principal
        //Modificar el responsable
        ServMgtSetup.GET;
        CraneMgtSetup.GET;

        CLEAR(ServOrderAllocation);
        ServOrderAllocation.SETRANGE("Document Type", ServItemLine."Document Type");
        ServOrderAllocation.SETRANGE("Document No.", ServItemLine."Document No.");
        ServOrderAllocation.SETRANGE("Service Item Line No.", ServItemLine."Line No.");
        IF ServOrderAllocation.FINDFIRST THEN BEGIN
            CLEAR(SkilledResourceList);
            CLEAR(Resource);
            SkilledResourceList.Initialize(ResSkill.Type::"Service Item Group", ServItemLine."Service Item Group Code", ServItemLine.Description);
            SkilledResourceList.SetServiceOrderAllocation(ServOrderAllocation); //TODO: Error: La Página Skilled Resource List no contiene la definición SetServiceOrderAllocation
            //Resource.SETRANGE("Explotation Customer No.",ServMgtSetup."No. Internal Customer");
            Resource.SETRANGE(Blocked, FALSE);
            Resource.SETRANGE("Resource Group No.", CraneMgtSetup."Driver Resource Group");
            SkilledResourceList.LOOKUPMODE(TRUE);
            SkilledResourceList.SETTABLEVIEW(Resource);
            IF SkilledResourceList.RUNMODAL = ACTION::LookupOK THEN BEGIN

                CLEAR(ServOrderAllocation);
                ServOrderAllocation.SETRANGE("Document Type", ServItemLine."Document Type");
                ServOrderAllocation.SETRANGE("Document No.", ServItemLine."Document No.");
                ServOrderAllocation.SETRANGE("Service Item Line No.", ServItemLine."Line No.");
                ServOrderAllocation.SETFILTER("Resource No.", '%1', '');
                ServOrderAllocation.SETRANGE(Status, ServOrderAllocation.Status::Nonactive);
                IF NOT ServOrderAllocation.FINDFIRST THEN BEGIN
                    CLEAR(NewServOrderAllocation);
                    NewServOrderAllocation.INIT;
                    NewServOrderAllocation."Document Type" := ServItemLine."Document Type";
                    NewServOrderAllocation."Document No." := ServItemLine."Document No.";
                    NewServOrderAllocation."Service Item Line No." := ServItemLine."Line No.";
                    NewServOrderAllocation."Service Item No." := ServItemLine."Service Item No.";
                    NewServOrderAllocation."Service Item Serial No." := ServItemLine."Serial No.";
                    NewServOrderAllocation.INSERT(TRUE);

                    ServOrderAllocation := NewServOrderAllocation;

                    COMMIT;
                END;

                SkilledResourceList.GETRECORD(Resource);
                ServOrderAllocation.SetHideDialog(TRUE);

                ServOrderAllocation.VALIDATE("Resource No.", Resource."No.");
                ServOrderAllocation.VALIDATE("Allocation Date", ServItemLine."Requested Starting Date");
                ServOrderAllocation."Starting Time" := ServItemLine."Requested Starting Time";
                ServOrderAllocation."Finishing Time" := ServItemLine."Requested Ending Time";
                //Pendiente de revisar las horas asignadas, por ahora pongo un 1
                ServOrderAllocation.VALIDATE("Allocated Hours", 1);

                ServOrderAllocation.VALIDATE(Status, ServOrderAllocation.Status::Active);
                ServOrderAllocation.MODIFY(TRUE);

                CLEAR(RepairStatus);
                RepairStatus.SETRANGE(Referred, TRUE);
                RepairStatus.FINDFIRST;
                ServItemLine2.GET(ServItemLine."Document Type", ServItemLine."Document No.", ServItemLine."Line No.");
                ServItemLine2.VALIDATE("Repair Status Code", RepairStatus.Code);
                ServItemLine2.MODIFY(TRUE);
            END;
        END;
    end;

    /// <summary>
    /// ModifyDriver()
    /// </summary>
    local procedure ModifyDriver(ServOrderAllocation: Record "Service Order Allocation"; ServItemLine: Record "Service Item Line")
    var
        SkilledResourceList: Page "Skilled Resource List";
        ResSkill: Record "Resource Skill";
        Resource: Record "Resource";
    begin
        //Tiene principal
        //Modificar el responsable
        ServMgtSetup.GET;
        CraneMgtSetup.GET;

        CLEAR(Resource);
        CLEAR(SkilledResourceList);
        SkilledResourceList.Initialize(ResSkill.Type::"Service Item Group", ServItemLine."Service Item Group Code", ServItemLine.Description);
        SkilledResourceList.SetServiceOrderAllocation(ServOrderAllocation); //TODO: Error: La Página Skilled Resource List no contiene la definición SetServiceOrderAllocation
        //Resource.SETRANGE("Explotation Customer No.",ServMgtSetup."No. Internal Customer");
        Resource.SETRANGE(Blocked, FALSE);
        Resource.SETRANGE("Resource Group No.", CraneMgtSetup."Driver Resource Group");
        SkilledResourceList.LOOKUPMODE(TRUE);
        SkilledResourceList.SETTABLEVIEW(Resource);
        IF SkilledResourceList.RUNMODAL = ACTION::LookupOK THEN BEGIN
            SkilledResourceList.GETRECORD(Resource);
            ServOrderAllocation.SetHideDialog(TRUE);
            ServOrderAllocation.VALIDATE(Status, ServOrderAllocation.Status::Active);
            ServOrderAllocation.VALIDATE("Document Type", ServOrderAllocation."Document Type"::Order);
            ServOrderAllocation.VALIDATE("Document No.", ServItemLine."Document No.");
            ServOrderAllocation.VALIDATE("Service Item Line No.", ServItemLine."Line No.");
            ServOrderAllocation.VALIDATE("Resource No.", Resource."No.");
            ServOrderAllocation.VALIDATE("Allocation Date", ServItemLine."Requested Starting Date");
            ServOrderAllocation.VALIDATE("Starting Time", ServItemLine."Requested Starting Time");
            ServOrderAllocation.VALIDATE("Finishing Time", ServItemLine."Requested Ending Time");
            ServOrderAllocation.MODIFY(TRUE);

            CLEAR(RepairStatus);
            RepairStatus.SETRANGE(Referred, TRUE);
            RepairStatus.FINDFIRST;
            ServItemLine.GET(ServItemLine."Document Type"::Order, Entry.ServOrderNo, LineNoAux);
            ServItemLine.VALIDATE("Repair Status Code", RepairStatus.Code);
            ServItemLine.MODIFY(TRUE);
        END;
    end;

    /// <summary>
    /// InsertExtraResource()
    /// </summary>
    local procedure InsertExtraResource(ServItemLine: Record "Service Item Line")
    var
        Resource: Record "Resource";
        ResourceList: Page "Resource List";
        NewServOrderAllocation: Record "Service Order Allocation";
    begin
        // Abrir recursos no bloqueados
        ServMgtSetup.GET;
        CraneMgtSetup.GET;

        CLEAR(Resource);
        Resource.SETRANGE(Blocked, FALSE);
        Resource.SETRANGE("Explotation Customer No.", ServMgtSetup."No. Internal Customer");
        Resource.SETFILTER("Resource Group No.", '%1|%2|%3', CraneMgtSetup."Driver Resource Group", CraneMgtSetup."Normal Resource Group", CraneMgtSetup."Special Resource Group");
        ResourceList.SETTABLEVIEW(Resource);
        ResourceList.LOOKUPMODE := TRUE;
        IF ResourceList.RUNMODAL = ACTION::LookupOK THEN BEGIN
            ResourceList.GETRECORD(Resource);

            CLEAR(NewServOrderAllocation);
            NewServOrderAllocation.INIT;
            NewServOrderAllocation."Document Type" := ServItemLine."Document Type";
            NewServOrderAllocation."Document No." := ServItemLine."Document No.";
            NewServOrderAllocation."Service Item Line No." := ServItemLine."Line No.";
            NewServOrderAllocation."Service Item No." := ServItemLine."Service Item No.";
            NewServOrderAllocation."Service Item Serial No." := ServItemLine."Serial No.";
            NewServOrderAllocation.INSERT(TRUE);
            NewServOrderAllocation.SetHideDialog(TRUE);

            NewServOrderAllocation.VALIDATE("Resource No.", Resource."No.");
            NewServOrderAllocation.VALIDATE("Allocation Date", ServItemLine."Requested Starting Date");
            //Pendiente de revisar las horas asignadas, por ahora pongo un 1
            NewServOrderAllocation.VALIDATE("Allocated Hours", 1);

            NewServOrderAllocation.VALIDATE(Status, NewServOrderAllocation.Status::Active);
            NewServOrderAllocation.MODIFY(TRUE);

        END;
    end;

    /// <summary>
    /// AssignCraneTasks()
    /// </summary>
    local procedure AssignCraneTasks()
    var
        CraneMgtSetup: Record "Crane Mgt. Setup_LDR";
        OrderPlannerSetup: Record "Order Planner Setup_LDR";
        ServItemEntryJournal: Record "Serv.Item. Entry Journal_LDR";
        tempServItemEntryJournal: Record "Serv.Item. Entry Journal_LDR";
        ServContractLine: Record "Service Contract Line";
        SourceServContractLine: Record "Service Contract Line";
        bContractOpened: BoolEAN;
        servContractHeader: Record "Service Contract Header";
        servContractHeader2: Record "Service Contract Header";
        LockOpenContract: Codeunit "Lock-OpenServContract";
        ServiceContractPlanning: Report "Service Contract Planning";
        JournalBatch: Record "Serv.Item Entr Journ Batch_LDR";
        ServMgtSetup: Record "Service Mgt. Setup";
        SourceCodeSetup: Record "Source Code Setup";
        DocNo: Code[20];
        NoSeriesMgt: Codeunit "NoSeriesManagement";
        DateAvailability: Record "Date";
        ServiceItemLine: Record "Service Item Line";
        lastServContractLineNo: Integer;
        ServItemEntryType: Option "Entrega por Venta","Recogida por Devolucion","Entrega Inicio Contrato Alquiler","Recogida Fin Contrato Alquiler","Entrega Fin Reparacion","Recogida Inicio Reparacion","Movimiento entre Ubicaciones",Compra,"Abono Compra";
    begin
        //CIC AJGONZALEZ Y JLPINEIRO
        //Asignacion de tareas de Grua
        CraneMgtSetup.GET;
        OrderPlannerSetup.GET;

        EVALUATE(LineNoAux, Entry.ServOrderLineNo);

        //Asignamos el numero de producto en la linea de pedido de servicio cuando el tipo de pedido de servicio
        //es grua
        ServHeader.GET(ServHeader."Document Type"::Order, Entry.ServOrderNo);
        ServiceItem.GET(Entry.ServItem);
        IF ServHeader."Service Order Type" = CraneMgtSetup."Serv. Order Type - Crane" THEN BEGIN

            AssignMultipleCraneTaks(Entry.ServOrderNo, LineNoAux, Entry.ServItem, Planner.GetDate(Entry.StartTime), Planner.GetTime(Entry.StartTime), Planner.GetTime(Entry.EndTime)); //TODO: Error: La Página Planner no contiene la definición GetDate y GetTime
            //Si tiene mas de una linea en distintos dias pregunta y si es que si añade el resto menos la que hemos asignado ya.
            CLEAR(ServiceItemLine);
            ServiceItemLine.SETRANGE("Document No.", ServHeader."No.");
            ServiceItemLine.SETFILTER("Line No.", '<>%1', LineNoAux);
            IF ServiceItemLine.FINDSET THEN BEGIN
                IF CONFIRM(Text001, FALSE) THEN BEGIN
                    REPEAT
                        AssignMultipleCraneTaks(Entry.ServOrderNo, ServiceItemLine."Line No.", Entry.ServItem, ServiceItemLine."Allocated Date", ServiceItemLine."Starting Time", ServiceItemLine."Finishing Time");
                    UNTIL ServiceItemLine.NEXT = 0;
                END;
            END;
        END ELSE
            IF ServHeader."Service Order Type" = CraneMgtSetup."Serv. Order Type - Platf. Del." THEN BEGIN
                //NO PERMITIR ASIGNAR ENTREGA SI HAY RECOGIDAS PENDIENTES DE EJECUTAR

                IF ServItemHasOpenPickups(ServiceItem) THEN
                    ERROR(Text006);

                //La linea pertenece a un pedido de tipo "Entrega Plataforma"
                //Se asigna el Nº Producto de Servicio
                //Se cambia el estado al configurado como "Remitido" en "Repair Status"
                CLEAR(ServItemLine);
                ServItemLine.SETRANGE(ServItemLine."Document Type", ServItemLine."Document Type"::Order);
                ServItemLine.SETRANGE(ServItemLine."Document No.", ServHeader."No.");
                ServItemLine.SETRANGE(ServItemLine."Line No.", LineNoAux);
                IF ServItemLine.FINDFIRST THEN BEGIN
                    //Procesamos el contrato
                    AssignServContract(ServHeader, ServItemLine, Entry.ServItem, ServContractLine);

                    //introducimos el nuevo numero de linea en la linea de pedido de servicio si ha cambiado
                    IF ServItemLine."Contract Line No." <> ServContractLine."Line No." THEN BEGIN
                        ServItemLine."Contract Line No." := ServContractLine."Line No.";
                        ServItemLine.MODIFY(TRUE);
                    END;

                    //procesamos la entrega
                    CreateServItemJournal(ServItemEntryType::"Entrega Inicio Contrato Alquiler", ServContractLine, ServiceItem, ServItemLine);

                    //Obtenemos el estado que este marcado como remitido
                    CLEAR(RepairStatus);
                    RepairStatus.SETRANGE(Referred, TRUE);
                    IF RepairStatus.FINDFIRST THEN
                        ServItemLine.VALIDATE("Repair Status Code", RepairStatus.Code);
                    ServItemLine.VALIDATE("Service Item No.", Entry.ServItem);
                    ServItemLine."Exported to Device" := TRUE;
                    ServItemLine.MODIFY(TRUE);
                    ServHeader.Description := STRSUBSTNO(Text007, ServiceItem."Planner No");
                    ServHeader.MODIFY(TRUE);
                    //FIN AJGONZALEZ Y JLPINEIRO

                END;
            END ELSE
                IF ServHeader."Service Order Type" = CraneMgtSetup."Serv. Order Type - Platf. Pick" THEN BEGIN
                    //La linea pertenece a un pedido de tipo "Recogida Plataforma"
                    //Se asigna el Nº Producto de Servicio
                    //Se cambia el estado al configurado como "Remitido" en "Repair Status"

                    CLEAR(ServItemLine);
                    ServItemLine.SETRANGE(ServItemLine."Document Type", ServItemLine."Document Type"::Order);
                    ServItemLine.SETRANGE(ServItemLine."Document No.", ServHeader."No.");
                    ServItemLine.SETRANGE(ServItemLine."Line No.", LineNoAux);
                    IF ServItemLine.FINDFIRST THEN BEGIN
                        AssignServContractPickup(ServHeader, ServItemLine, ServContractLine);

                        //procesamos la recogida
                        CreateServItemJournal(ServItemEntryType::"Recogida Fin Contrato Alquiler", ServContractLine, ServiceItem, ServItemLine);

                        //Obtenemos el estado que este marcado como remitido
                        CLEAR(RepairStatus);
                        RepairStatus.SETRANGE(Referred, TRUE);
                        IF RepairStatus.FINDFIRST THEN
                            ServItemLine.VALIDATE("Repair Status Code", RepairStatus.Code);
                        ServItemLine.VALIDATE("Service Item No.", Entry.ServItem);
                        ServItemLine."Exported to Device" := TRUE;
                        ServItemLine.MODIFY(TRUE);
                        //FIN AJGONZALEZ Y JLPINEIRO

                    END;
                END;
    end;

    /// <summary>
    /// AssignMultipleCraneTaks()
    /// </summary>
    local procedure AssignMultipleCraneTaks(pServOrderNo: Code[20]; pServOrderLineNo: Integer; pServItemNo: Code[20]; pDate: Date; pStartingTime: Time; pEndingTime: Time)
    var
        OrderPlannerSetup: Record "Order Planner Setup_LDR";
    begin
        //Asignamos el numero de producto en la linea de pedido de servicio cuando el tipo de pedido de servicio
        //es grua
        OrderPlannerSetup.GET;
        ServHeader.GET(ServHeader."Document Type"::Order, pServOrderNo);
        ServiceItem.GET(pServItemNo);
        CLEAR(ServItemLine);
        ServItemLine.SETRANGE(ServItemLine."Document Type", ServItemLine."Document Type"::Order);
        ServItemLine.SETRANGE(ServItemLine."Document No.", ServHeader."No.");
        ServItemLine.SETRANGE(ServItemLine."Line No.", pServOrderLineNo);

        IF ServItemLine.FINDFIRST THEN BEGIN
            ServItemLine.SetHideDialogBox(TRUE);
            ServItemLine.VALIDATE("Service Item No.", pServItemNo);
            //Si tiene recurso preferido igualamos ese recurso en la asignacion
            ServOrderAllocation.SetHideDialog(TRUE);
            ServOrderAllocation.SETRANGE("Document Type", ServOrderAllocation."Document Type"::Order);
            ServOrderAllocation.SETRANGE("Document No.", ServItemLine."Document No.");
            ServOrderAllocation.SETRANGE("Service Item Line No.", ServItemLine."Line No.");
            //Se completan la asignacion de "Service Order Allocation"
            IF ServiceItem."Preferred Resource" <> '' THEN BEGIN
                IF ServOrderAllocation.FINDFIRST THEN BEGIN
                    ServOrderAllocation.VALIDATE("Resource No.", ServiceItem."Preferred Resource");
                    ServOrderAllocation.Responsible := TRUE;
                    ServOrderAllocation.VALIDATE(Status, ServOrderAllocation.Status::Active);
                    MESSAGE(FORMAT(pDate) + ' ' + FORMAT(pStartingTime) + ' -> ' + FORMAT(pEndingTime));
                    ServOrderAllocation.VALIDATE("Allocation Date", pDate);
                    ServOrderAllocation.VALIDATE("Starting Time", pStartingTime);
                    ServOrderAllocation.VALIDATE("Finishing Time", pEndingTime);
                    ServOrderAllocation.VALIDATE(ServOrderAllocation."Allocated Hours",
                                          (ServOrderAllocation."Finishing Time" - ServOrderAllocation."Starting Time") / 3600000);
                    //ServOrderAllocation.VALIDATE(ServOrderAllocation."Starting Time",ServOrderAllocation."Starting Time" + 7200000);
                    //ServOrderAllocation.VALIDATE(ServOrderAllocation."Finishing Time",ServOrderAllocation."Finishing Time" + 7200000);
                    ServOrderAllocation.VALIDATE(ServOrderAllocation."Starting Time", ServOrderAllocation."Starting Time");
                    ServOrderAllocation.VALIDATE(ServOrderAllocation."Finishing Time", ServOrderAllocation."Finishing Time");
                    ServOrderAllocation.MODIFY(TRUE);

                    CLEAR(RepairStatus);
                    RepairStatus.SETRANGE(Referred, TRUE);
                    IF RepairStatus.FINDFIRST THEN
                        ServItemLine.VALIDATE("Repair Status Code", RepairStatus.Code);
                END;
            END ELSE BEGIN //Si no tiene se inicia la linea de asignacion vacia y se pone el estado a pendiente recurso.
                IF ServOrderAllocation.FINDFIRST THEN
                    ServOrderAllocation.INIT;

                CLEAR(RepairStatus);
                RepairStatus.SETRANGE(Referred, TRUE);
                IF RepairStatus.FINDFIRST THEN
                    ServItemLine.VALIDATE("Repair Status Code", OrderPlannerSetup."Pending Res. Rep. Status Code");
            END;
            //Si el producto de servicio no tiene "Cod. Recurso Preferido", se cambia el estado al configurado como
            //"Cod Estado Reparacion Recurso Pendiente"
            ServItemLine.MODIFY(TRUE);
        END;
    end;

    /// <summary>
    /// AssignServContract()
    /// </summary>
    local procedure AssignServContract(pServHeader: Record "Service Header"; pServItemLine: Record "Service Item Line"; pServItemNo: Code[20]; var pServContractLine: Record "Service Contract Line")
    var
        SourceServContractLine222: Record "Service Contract Line";
        bContractOpened: BoolEAN;
        servContractHeader: Record "Service Contract Header";
        servContractHeader2: Record "Service Contract Header";
        servContractHeader3: Record "Service Contract Header";
        LockOpenContract: Codeunit "Lock-OpenServContract";
        ServiceContractPlanning: Report "Service Contract Planning";
        lastServContractLineNo: Integer;
        lEndingDate: Date;
    begin
        CraneMgtSetup.GET;

        //Buscamos el contrato
        servContractHeader.GET(servContractHeader."Contract Type"::Contract, pServItemLine."Contract No.");
        //abrimos el contrato
        bContractOpened := servContractHeader."Change Status" = servContractHeader."Change Status"::Locked;
        IF bContractOpened THEN
            LockOpenContract.OpenServContract(servContractHeader);


        // IF pServItemLine."Requested Starting Date" <> pServItemLine."Requested Ending Date" THEN
        //  lEndingDate := pServItemLine."Requested Ending Date";
        // ELSE
        //  lEndingDate := servContractHeader."Expiration Date";


        //SourceServContractLine.GET(SourceServContractLine."Contract Type"::Contract,pServItemLine."Contract No.",pServItemLine."Contract Line No.");


        pServContractLine.GET(pServContractLine."Contract Type"::Contract, pServItemLine."Contract No.", pServItemLine."Contract Line No.");

        //// HAY QUE GESTIONAR QUE SI HAY QUE MODIFICAR LA FECHA DE CABECERA, SI SOLO HAY UNA LINEA Y TAL...
        IF CheckServContractHeaderDateChange(pServItemLine."Contract No.", pServContractLine, pServItemLine."Requested Starting Date", 0) THEN BEGIN
            CLEAR(servContractHeader3);
            servContractHeader3.GET(servContractHeader."Contract Type", servContractHeader."Contract No.");
            servContractHeader3.VALIDATE("Starting Date", pServItemLine."Requested Starting Date");
            servContractHeader3.MODIFY(TRUE);
        END;

        //En el caso de la fecha final, se comprueba si alguna otra linea, tiene la fecha de fin del contrato
        IF CheckServContractHeaderDateChange(pServItemLine."Contract No.", pServContractLine, pServItemLine."Requested Ending Date", 1) THEN BEGIN
            CLEAR(servContractHeader3);
            servContractHeader3.GET(servContractHeader."Contract Type", servContractHeader."Contract No.");
            servContractHeader3.VALIDATE("Expiration Date", pServItemLine."Requested Ending Date");
            servContractHeader3.MODIFY(TRUE);
        END;

        pServContractLine.VALIDATE("Starting Date", pServItemLine."Requested Starting Date");
        IF pServItemLine."Requested Ending Date" <> pServItemLine."Requested Starting Date" THEN
            pServContractLine."Contract Expiration Date" := pServItemLine."Requested Ending Date" // CAS-19598-V3Z3 -Se corrige, sustituyendo lEndingDate por pServItemLine."Requested Ending Date"
        ELSE
            pServContractLine."Contract Expiration Date" := servContractHeader."Expiration Date";

        ServiceContractPlanning.DeleteAllReservation(pServContractLine."Contract Type", pServContractLine."Contract No.", pServContractLine."Line No.", '', 5964, '');

        pServContractLine.VALIDATE("Service Item No.", pServItemNo);
        pServContractLine.VALIDATE("Delivery Planified", TRUE);
        pServContractLine.MODIFY(TRUE);


        ServiceContractPlanning.GenerateForWeekReservation(pServContractLine."Starting Date", //InitialDate
                                                          pServContractLine."Contract Expiration Date", //EndDate
                                                          1, //NWeeks
                                                          pServContractLine."Contract Type", //Contracttype
                                                          pServContractLine."Contract No.", //ContractNo
                                                          pServContractLine."Line No.", //LineNo
                                                          pServContractLine."Service Item No.", //ServiceitemNo
                                                          5964, //SourceTable
                                                          FALSE, //bOmitirCompletos
                                                          TRUE, //bLunes
                                                          TRUE, //bMartes
                                                          TRUE, //bMiercoles
                                                          TRUE, //bJueves
                                                          TRUE, //bViernes
                                                          pServContractLine."Use Saturdays", //bSabado
                                                          pServContractLine."Use Sundays"); //bDomingo

        // //Planificar Horas todas a 1500 horas/año
        // pServContractLine.CALCFIELDS("Contracted Hours");
        // IF pServContractLine."Contracted Hours" = 0 THEN BEGIN
        //  CreateHoursPlanification(pServContractLine,1500);
        //  pServContractLine.MODIFY(TRUE);
        // END;

        // Actualizamos la Siguiente Fecha Factura (para que calcule el importe por periodo ahora que tenemos la reserva de dias)
        CLEAR(servContractHeader3);
        servContractHeader3.GET(servContractHeader."Contract Type", servContractHeader."Contract No.");
        servContractHeader3.VALIDATE("Next Invoice Date");
        servContractHeader3.MODIFY(TRUE);


        //Cerramos el contrato
        CLEAR(servContractHeader2);
        servContractHeader2.GET(servContractHeader."Contract Type", servContractHeader."Contract No.");
        IF bContractOpened THEN
            LockOpenContract.LockServContract(servContractHeader2);
    end;

    /// <summary>
    /// AssignServContractPickup()
    /// </summary>
    procedure AssignServContractPickup(pServHeader: Record "Service Header"; pServItemLine: Record "Service Item Line"; var pServContracLine: Record "Service Contract Line")
    var
        ServContractLine: Record "Service Contract Line";
        bContractOpened: BoolEAN;
        servContractHeader: Record "Service Contract Header";
        servContractHeader2: Record "Service Contract Header";
        LockOpenContract: Codeunit "Lock-OpenServContract";
        LineCounter: Integer;
    begin
        CraneMgtSetup.GET;

        //Buscamos el contrato
        servContractHeader.GET(servContractHeader."Contract Type"::Contract, pServItemLine."Contract No.");

        //abrimos el contrato
        bContractOpened := servContractHeader."Change Status" = servContractHeader."Change Status"::Locked;
        IF bContractOpened THEN
            LockOpenContract.OpenServContract(servContractHeader);

        //Obtenemos el contrato de nuevo para recogerle "Abierto"
        servContractHeader.GET(servContractHeader."Contract Type"::Contract, pServItemLine."Contract No.");

        //buscamos la linea del contrato.
        CLEAR(pServContracLine);
        pServContracLine.SETRANGE("Contract Type", servContractHeader."Contract Type");
        pServContracLine.SETRANGE("Contract No.", servContractHeader."Contract No.");
        LineCounter := pServContracLine.COUNT;

        //hay que comprobar si hay solo una linea. Porque en ese caso hay que modificar la fecha de la cabecera tambien.
        IF LineCounter = 1 THEN BEGIN
            servContractHeader."Expiration Date" := pServItemLine."Requested Ending Date";
            servContractHeader.MODIFY(TRUE);
        END;

        //al modificar la fecha fin, NAV controla la eliminacion de reservas.
        //DateAvailability.SETRANGE("Period Start",ServContractLine."Starting Date",ServContractLine."Contract Expiration Date");
        //ServContractLine.CALCFIELDS("No of Days");
        pServContracLine.SETRANGE("Line No.", pServItemLine."Contract Line No.");
        pServContracLine.FINDFIRST;

        //Modificamos la fecha fin y modificamos la reserva
        pServContracLine.VALIDATE("Contract Expiration Date", pServItemLine."Requested Ending Date");
        pServContracLine.VALIDATE("Collection Planified", TRUE);
        pServContracLine.MODIFY(TRUE);

        // //Agregar el concepto de entrega/recogida
        // CreateContractConcepts(pServContracLine,pServHeader,CraneMgtSetup."Platform Pickup Concept");

        //Cerramos el contrato
        CLEAR(servContractHeader2);
        servContractHeader2.GET(servContractHeader."Contract Type", servContractHeader."Contract No.");
        IF bContractOpened THEN
            LockOpenContract.LockServContract(servContractHeader2);
    end;

    /// <summary>
    /// CreateContractConcepts()
    /// </summary>
    local procedure CreateContractConcepts(pServContractLine: Record "Service Contract Line"; pServHeader: Record "Service Header"; pConceptCode: Code[20])
    var
        ContractConcepts: Record "Contract Concepts_LDR";
        LastConceptLine: Integer;
        ServiceContractLine: Record "Service Contract Line";
    begin
        CraneMgtSetup.GET;
        ServiceContractLine.GET(pServContractLine."Contract Type", pServContractLine."Contract No.", pServContractLine."Line No.");

        CLEAR(ContractConcepts);
        ContractConcepts.SETRANGE("Source Table", 5964);
        ContractConcepts.SETRANGE("Contract No.", pServContractLine."Contract No.");
        ContractConcepts.SETRANGE("Contract Type", pServContractLine."Contract Type");
        ContractConcepts.SETRANGE("Contract Line No.", pServContractLine."Line No.");
        IF ContractConcepts.FINDLAST THEN
            LastConceptLine := ContractConcepts."Line No."
        ELSE
            LastConceptLine := 0;

        CLEAR(ContractConcepts);
        ContractConcepts."Source Table" := 5964;
        ContractConcepts."Contract Type" := ContractConcepts."Contract Type"::Contract;
        ContractConcepts."Contract No." := pServContractLine."Contract No.";
        ContractConcepts."Contract Line No." := pServContractLine."Line No.";
        ContractConcepts."Line No." := LastConceptLine + 10000;
        ContractConcepts.INSERT(TRUE);
        ContractConcepts.VALIDATE("Concept No.", pConceptCode);

        IF pServHeader."Service Order Type" = CraneMgtSetup."Serv. Order Type - Platf. Del." THEN
            ContractConcepts.Description := COPYSTR(STRSUBSTNO(Text008, pServHeader."No."), 1, 50)
        ELSE
            IF pServHeader."Service Order Type" = CraneMgtSetup."Serv. Order Type - Platf. Pick" THEN
                ContractConcepts.Description := COPYSTR(STRSUBSTNO(Text009, pServHeader."No."), 1, 50);

        ContractConcepts.Date := pServHeader."Order Date";
        ContractConcepts.Periodicity := ContractConcepts.Periodicity::"Date expecific";
        ContractConcepts.VALIDATE("Service Order No.", pServHeader."No."); // DPGARCIA - RQ19.21.297 - Validar el Ped.Servicio para que se rellene Cliente Explotacion
        //Si tiene precio de entrega y recogida distinto de 0 se hereda.
        IF ServiceContractLine."Deliver/Pickup Price" <> 0 THEN BEGIN
            ContractConcepts.Amount := ServiceContractLine."Deliver/Pickup Price";
            ContractConcepts."Cost Amount" := ServiceContractLine."Deliver/Pickup Price";
        END;
        ContractConcepts.MODIFY(TRUE);
    end;

    /// <summary>
    /// CreateServItemJournal()
    /// </summary>
    procedure CreateServItemJournal(pEntryType: Option "Entrega por Venta","Recogida por Devolucion","Entrega Inicio Contrato Alquiler","Recogida Fin Contrato Alquiler","Entrega Fin Reparacion","Recogida Inicio Reparacion","Movimiento entre Ubicaciones",Compra,"Abono Compra"; pServContractLine: Record "Service Contract Line"; pServItem: Record "Service Item"; pServItemLine: Record "Service Item Line")
    var
        ServItemEntryJournal: Record "Serv.Item. Entry Journal_LDR";
        tempServItemEntryJournal: Record "Serv.Item. Entry Journal_LDR";
        JournalBatch: Record "Serv.Item Entr Journ Batch_LDR";
        SourceCodeSetup: Record "Source Code Setup";
        DocNo: Code[20];
        NoSeriesMgt: Codeunit "NoSeriesManagement";
        ServContractHeader: Record "Service Contract Header";
    begin
        ServMgtSetup.GET;

        ServContractHeader.GET(pServContractLine."Contract Type", pServContractLine."Contract No.");

        SourceCodeSetup.GET;
        SourceCodeSetup.TESTFIELD(SourceCodeSetup."Service Item Entry Journal");
        ServMgtSetup.GET;

        CLEAR(tempServItemEntryJournal);
        tempServItemEntryJournal.SETRANGE(tempServItemEntryJournal."Journal Template Name", SourceCodeSetup."Service Item Entry Journal");
        tempServItemEntryJournal.SETRANGE(tempServItemEntryJournal."Journal Batch Name", ServMgtSetup."S.Item Bin Entry Default Batch");
        IF tempServItemEntryJournal.FINDLAST THEN;

        IF JournalBatch."No. Series" = '' THEN BEGIN
            DocNo := pServContractLine."Contract No.";
        END ELSE BEGIN
            CLEAR(NoSeriesMgt);
            DocNo := NoSeriesMgt.TryGetNextNo(JournalBatch."No. Series", pServContractLine."Contract Expiration Date");
        END;

        //Creamos la recogida
        CLEAR(ServItemEntryJournal);
        ServItemEntryJournal.VALIDATE("Journal Template Name", SourceCodeSetup."Service Item Entry Journal");
        ServItemEntryJournal.VALIDATE("Journal Batch Name", ServMgtSetup."S.Item Bin Entry Default Batch");
        ServItemEntryJournal.VALIDATE("Line No.", tempServItemEntryJournal."Line No." + 10000);
        ServItemEntryJournal.INSERT(TRUE);
        ServItemEntryJournal.VALIDATE("Entry Type", pEntryType);
        ServItemEntryJournal.VALIDATE("Posting Date", pServItemLine."Requested Starting Date");
        ServItemEntryJournal.VALIDATE("Document No.", DocNo);
        ServItemEntryJournal.VALIDATE("Service Item No.", pServContractLine."Service Item No.");
        ServItemEntryJournal.VALIDATE(Description, pServContractLine.Description);

        IF pEntryType = pEntryType::"Entrega Inicio Contrato Alquiler" THEN BEGIN
            ServItemEntryJournal.VALIDATE("Originally Customer", pServItem."Customer No.");
            ServItemEntryJournal.VALIDATE("Originally Cust Ship Address", pServItem."Ship-to Code");
            ServItemEntryJournal.VALIDATE("Assignment Customer", ServContractHeader."Customer No.");
            ServItemEntryJournal.VALIDATE("Assignment Cust Ship Address", ServContractHeader."Ship-to Code");
        END ELSE BEGIN
            ServItemEntryJournal.VALIDATE("Originally Customer", pServItem."Customer No.");
            ServItemEntryJournal.VALIDATE("Originally Cust Ship Address", pServItem."Ship-to Code");
            ServItemEntryJournal.VALIDATE("Assignment Customer", ServMgtSetup."No. Internal Customer");
            ServItemEntryJournal.VALIDATE("Assignment Cust Ship Address", '');
        END;

        ServItemEntryJournal.VALIDATE(Printed, FALSE);
        ServItemEntryJournal.VALIDATE("CMR Necessary", FALSE);
        ServItemEntryJournal.VALIDATE("Responsibility Center", ServContractHeader."Responsibility Center");
        ServItemEntryJournal.VALIDATE("User Id", USERID);
        ServItemEntryJournal.VALIDATE("Global Dimension 1 Code", pServContractLine."Shortcut Dimension 1 Code");
        ServItemEntryJournal.VALIDATE("Global Dimension 2 Code", pServContractLine."Shortcut Dimension 2 Code");
        //>> UPG2016_RPB Start
        ServItemEntryJournal."Dimension Set ID" := pServContractLine."Dimension Set ID";
        //<< UPG2016_RPB End
        ServItemEntryJournal.VALIDATE("Source Table Id", DATABASE::"Service Contract Line");
        ServItemEntryJournal.VALIDATE("Source Type", pServContractLine."Contract Type");
        ServItemEntryJournal.VALIDATE("Source Document No.", pServContractLine."Contract No.");
        ServItemEntryJournal.VALIDATE("Source Line No.", pServContractLine."Line No.");
        ServItemEntryJournal.VALIDATE("Shipping Agent Code", ServContractHeader."Shipping Agent Code");
        ServItemEntryJournal.CALCFIELDS("Serial No.", Own);
        ServItemEntryJournal."Fast Register" := TRUE;

        ServItemEntryJournal."Service Order No" := pServItemLine."Document No.";
        ServItemEntryJournal."Service Item Line No" := pServItemLine."Line No.";

        ServItemEntryJournal.MODIFY(TRUE);

        // //registramos el movimiento
        // ServItemEntryJournal.SETRECFILTER;
        // CODEUNIT.RUN(CODEUNIT::"Service Item Entry-Post",ServItemEntryJournal);
    end;

    /// <summary>
    /// PostServItemJournal()
    /// </summary>
    procedure PostServItemJournal(pEntryType: Option "Entrega por Venta","Recogida por Devolucion","Entrega Inicio Contrato Alquiler","Recogida Fin Contrato Alquiler","Entrega Fin Reparacion","Recogida Inicio Reparacion","Movimiento entre Ubicaciones",Compra,"Abono Compra"; pServContractLine: Record "Service Contract Line"; pServItem: Record "Service Item")
    var
        ServItemEntryJournal: Record "Serv.Item. Entry Journal_LDR";
        ServContractHeader: Record "Service Contract Header";
        SourceCodeSetup: Record "Source Code Setup";
    begin
        //registramos el movimiento
        ServMgtSetup.GET;
        ServContractHeader.GET(pServContractLine."Contract Type", pServContractLine."Contract No.");

        SourceCodeSetup.GET;
        SourceCodeSetup.TESTFIELD(SourceCodeSetup."Service Item Entry Journal");

        CLEAR(ServItemEntryJournal);
        ServItemEntryJournal.SETRANGE("Journal Template Name", SourceCodeSetup."Service Item Entry Journal");
        ServItemEntryJournal.SETRANGE("Journal Batch Name", ServMgtSetup."S.Item Bin Entry Default Batch");
        ServItemEntryJournal.SETRANGE("Source Type", pServContractLine."Contract Type");
        ServItemEntryJournal.SETRANGE("Source Document No.", pServContractLine."Contract No.");
        ServItemEntryJournal.SETRANGE("Source Line No.", pServContractLine."Line No.");
        ServItemEntryJournal.SETRANGE("Service Item No.", pServItem."No.");
        IF ServItemEntryJournal.FINDFIRST THEN BEGIN
            ServItemEntryJournal.SETRECFILTER;
            CODEUNIT.RUN(CODEUNIT::"Service Item Entry-Post_LDR", ServItemEntryJournal);
        END;
    end;

    /// <summary>
    /// DeleteOrderAssign()
    /// </summary>
    local procedure DeleteOrderAssign()
    var
        bContractOpened: BoolEAN;
        servContractHeader: Record "Service Contract Header";
        servContractHeader2: Record "Service Contract Header";
        LockOpenContract: Codeunit "Lock-OpenServContract";
        ServiceContractPlanning: Report "Service Contract Planning";
        ContractConcepts: Record "Contract Concepts_LDR";
        LastConceptLine: Integer;
        lastServContractLineNo: Integer;
        ServiceItemInvoiceGroup: Record "Service Item Invoice Group_LDR";
        ServItemNo: Code[20];
        ServItemLine2: Record "Service Item Line";
    begin
        CraneMgtSetup.GET;
        //CIC AJGONZALEZ, JLPINEIRO
        //Cancelar asignacion de pedido de servicio
        ServHeader.GET(ServHeader."Document Type"::Order, Entry.ServOrderNo);
        EVALUATE(LineNoAux, Entry.ServOrderLineNo);
        EVALUATE(ServItemNo, Entry.ResourceNo);

        CLEAR(ServItemLine);
        ServItemLine.SETRANGE("Document Type", ServItemLine."Document Type"::Order);
        ServItemLine.SETRANGE("Document No.", ServHeader."No.");
        ServItemLine.SETRANGE("Service Item No.", ServItemNo); //Para en caso de que tenga otra linea asignada identificar la correcta.
        IF ServHeader."Service Order Type" = CraneMgtSetup."Serv. Order Type - Crane" THEN
            ServItemLine.SETRANGE("Line No.", LineNoAux);
        ServItemLine.FINDSET;

        IF ServHeader."Service Order Type" = CraneMgtSetup."Serv. Order Type - Crane" THEN BEGIN
            DeleteOrderAssignCrane(ServHeader, Entry.ResourceNo, LineNoAux);

            //Si tiene mas de una linea en distintos dias pregunta y si es que si añade el resto menos la que hemos asignado ya.
            CLEAR(ServItemLine2);
            ServItemLine2.SETRANGE("Document No.", ServHeader."No.");
            ServItemLine2.SETFILTER("Line No.", '<>%1', LineNoAux);
            ServItemLine2.SETFILTER("Service Item No.", '<>%1', '');
            IF ServItemLine2.FINDSET THEN BEGIN
                IF CONFIRM(Text002, FALSE) THEN BEGIN
                    REPEAT
                        //AssignMultipleCraneTaks(Entry.ServOrderNo,ServiceItemLine."Line No.",Entry.ServItem,ServiceItemLine."Allocated Date",ServiceItemLine."Starting Time",ServiceItemLine."Finishing Time");
                        DeleteOrderAssignCrane(ServHeader, Entry.ResourceNo, ServItemLine2."Line No.");
                    UNTIL ServItemLine2.NEXT = 0;
                END;
            END;


        END ELSE
            IF ServHeader."Service Order Type" = CraneMgtSetup."Serv. Order Type - Platf. Del." THEN BEGIN
                //comprobar si la linea es de la plataforma o del camion que la lleva
                ServiceItemInvoiceGroup.GET(ServItemLine."Service Inv. Group No.");
                IF ServiceItemInvoiceGroup."Group Type" = ServiceItemInvoiceGroup."Group Type"::Platform THEN BEGIN
                    DeleteOrderAssignPlatform(ServHeader, Entry.ResourceNo, LineNoAux);
                END ELSE BEGIN
                    DeleteOrderAssignTruck(ServHeader, Entry.ResourceNo);
                END;

            END ELSE
                IF ServHeader."Service Order Type" = CraneMgtSetup."Serv. Order Type - Platf. Pick" THEN BEGIN
                    IF NOT CONFIRM(Text004, FALSE) THEN
                        ERROR(Text005);

                    //comprobar si la linea es de la plataforma o del camion que la recoge
                    ServiceItemInvoiceGroup.GET(ServItemLine."Service Inv. Group No.");
                    IF ServiceItemInvoiceGroup."Group Type" = ServiceItemInvoiceGroup."Group Type"::Platform THEN BEGIN
                        DeleteOrderAssignPlatform(ServHeader, Entry.ResourceNo, LineNoAux);
                    END ELSE BEGIN
                        DeleteOrderAssignTruck(ServHeader, Entry.ResourceNo);
                    END;
                END;
    end;

    /// <summary>
    /// DeleteOrderAssignCrane()
    /// </summary>
    local procedure DeleteOrderAssignCrane(pServHeader: Record "Service Header"; pServItemNo: Code[20]; pServItemLineNo: Integer)
    var
        ServAllocationManagement: Codeunit "ServAllocationManagement";
        TempServItemLine: Record "Service Item Line" temporary;
        ServItemLine: Record "Service Item Line";
    begin
        PlannerSetup.GET;

        //Obtenemos la Linea del PS Correspondiente
        CLEAR(ServItemLine);
        ServItemLine.SETRANGE(ServItemLine."Document Type", ServItemLine."Document Type"::Order);
        ServItemLine.SETRANGE(ServItemLine."Document No.", pServHeader."No.");
        ServItemLine.SETRANGE(ServItemLine."Service Item No.", pServItemNo); //Para en caso de que tenga otra linea asignada identificar la correcta.
        ServItemLine.SETRANGE("Line No.", pServItemLineNo); //Filtro para solo la linea seleccionada.
        ServItemLine.FINDSET;

        //Se elimina la linea de asignacion de los recursos asociados a la linea del producto de servicio
        CLEAR(ServOrderAllocation);
        ServOrderAllocation.SetHideDialog(TRUE);
        ServOrderAllocation.SETRANGE("Document Type", ServOrderAllocation."Document Type"::Order);
        ServOrderAllocation.SETRANGE("Document No.", pServHeader."No.");
        ServOrderAllocation.SETRANGE("Service Item Line No.", ServItemLine."Line No."); //Filtrar solo por la linea que queremos borrar.
        ServOrderAllocation.DELETEALL(TRUE);

        //Comprobar que "Sent to device" en la linea del producto de servicio esta a "FALSE"
        TempServItemLine := ServItemLine;
        TempServItemLine.INSERT;

        ServItemLine.DELETE(TRUE);

        CLEAR(ServItemLine);

        WITH ServItemLine DO BEGIN
            INIT;
            bOmitirComprobarFacturarA(TRUE); //TODO: Error: El nombre bOmitirComprobarFacturarA no existe en este contexto
            SetHideDialogBox(TRUE);
            "Document No." := TempServItemLine."Document No.";
            "Document Type" := TempServItemLine."Document Type";
            "Repair Status Code" := PlannerSetup."Unassigned Repair Status Code";
            "Line No." := TempServItemLine."Line No.";
            "Crane Service Quote No." := TempServItemLine."Crane Service Quote No.";
            "Service Item Tariff No." := TempServItemLine."Service Item Tariff No.";
            "Service Inv. Group No." := TempServItemLine."Service Inv. Group No.";
            "Crane Serv. Quote Op. Line No" := TempServItemLine."Crane Serv. Quote Op. Line No";
            "Contract No." := TempServItemLine."Contract No.";
            "Contract Line No." := TempServItemLine."Contract Line No.";

            "Requested Starting Date" := TempServItemLine."Requested Starting Date";
            "Requested Starting Time" := TempServItemLine."Requested Starting Time";
            "Requested Ending Date" := TempServItemLine."Requested Ending Date";
            "Requested Ending Time" := TempServItemLine."Requested Ending Time";

            UpdateResponseTimeHours;
            INSERT(TRUE);
        END;

        // //Se inicializa el movimiento de asignacion de recurso
        // ServAllocationManagement.CreateAllocationEntry(pServItemLine."Document Type",pServItemLine."Document No.",pServItemLine."Line No.",pServItemLine."Service Item No.",pServItemLine."Serial No.");
        // //FIN AJGONZALEZ, JLPINEIRO
    end;

    /// <summary>
    /// DeleteOrderAssignPlatform()
    /// </summary>
    local procedure DeleteOrderAssignPlatform(pServHeader: Record "Service Header"; pServItemNo: Code[20]; pServItemLineNo: Integer)
    var
        ServContractLine: Record "Service Contract Line";
        bContractOpened: BoolEAN;
        servContractHeader: Record "Service Contract Header";
        servContractHeader2: Record "Service Contract Header";
        LockOpenContract: Codeunit "Lock-OpenServContract";
        ServiceContractPlanning: Report "Service Contract Planning";
        Contracttype: Option Quote,Contract;
        TempServItemLine: Record "Service Item Line" temporary;
        ServLine: Record "Service Line";
        PostedServiceItemBinEntry: Record "Posted Serv Item Bin Entr_LDR";
        ContractConcepts: Record "Contract Concepts_LDR";
        ServItemEntryJournal: Record "Serv.Item. Entry Journal_LDR";
        SourceCodeSetup: Record "Source Code Setup";
    begin
        CraneMgtSetup.GET;
        ServMgtSetup.GET;
        SourceCodeSetup.GET;
        SourceCodeSetup.TESTFIELD(SourceCodeSetup."Service Item Entry Journal");

        //Obtenemos la Linea del PS Correspondiente
        CLEAR(ServItemLine);
        ServItemLine.SETRANGE(ServItemLine."Document Type", ServItemLine."Document Type"::Order);
        ServItemLine.SETRANGE(ServItemLine."Document No.", pServHeader."No.");
        ServItemLine.SETRANGE(ServItemLine."Service Item No.", pServItemNo); //Para en caso de que tenga otra linea asignada identificar la correcta.
        ServItemLine.SETRANGE("Line No.", pServItemLineNo); //Filtro para solo la linea seleccionada.
        ServItemLine.FINDSET;

        //el proceso debe diferencias entre una desasignacion de lineas de una oferta de tarifa(de grupo unico), o de una oferta de condiciones generales o de tarida con grupo duplicado.

        //El proceso cdebe deshacer todo lo realizado por el proceso de asignacion: Modificar contrato, eliminar planificacion, eliminar detalle horas,
        //modificar/eliminar linea contrato, eliminar/deshacer movimiento de producto de servicio, cambiar ubicacion de servicio.

        //Buscamos el contrato
        servContractHeader.GET(servContractHeader."Contract Type"::Contract, ServItemLine."Contract No.");
        //abrimos el contrato
        bContractOpened := servContractHeader."Change Status" = servContractHeader."Change Status"::Locked;
        IF bContractOpened THEN
            LockOpenContract.OpenServContract(servContractHeader);

        //Obtenemos la linea del contrato de servicio
        ServContractLine.GET(ServContractLine."Contract Type"::Contract, ServItemLine."Contract No.", ServItemLine."Contract Line No.");

        IF pServHeader."Service Order Type" = CraneMgtSetup."Serv. Order Type - Platf. Del." THEN BEGIN
            //borrar planificacion de dias de la linea de contrato
            ServiceContractPlanning.DeleteAllReservation(Contracttype::Contract,
                                                         ServContractLine."Contract No.",
                                                         ServContractLine."Line No.",
                                                         ServContractLine."Service Item No.",
                                                         5964,
                                                         '');
            //Borrar planificacion de horas
            DeleteHoursPlanification(ServContractLine);

            //Resetear linea de contrato
            ServContractLine.VALIDATE("Service Item No.", '');
            ServContractLine.VALIDATE("Delivery Planified", FALSE);
            ServContractLine.VALIDATE("Starting Date", servContractHeader."Starting Date");
            ServContractLine.VALIDATE("Contract Expiration Date", servContractHeader."Expiration Date");
            ServContractLine.MODIFY(TRUE);

            //borrar conceptos de entrega
            CLEAR(ContractConcepts);
            ContractConcepts.SETRANGE("Source Table", 5964);
            ContractConcepts.SETRANGE("Contract No.", ServContractLine."Contract No.");
            ContractConcepts.SETRANGE("Contract Type", ServContractLine."Contract Type");
            ContractConcepts.SETRANGE("Contract Line No.", ServContractLine."Line No.");
            ContractConcepts.SETRANGE("Concept No.", CraneMgtSetup."Platform Delivery Concept");
            ContractConcepts.SETRANGE("Service Order No.", pServHeader."No.");
            IF ContractConcepts.FINDSET THEN
                ContractConcepts.DELETEALL(TRUE);

            //Eliminar el diario de movimiento de maquina y devolverlo a la ubicacion inicial
            CLEAR(ServItemEntryJournal);
            ServItemEntryJournal.SETRANGE("Journal Template Name", SourceCodeSetup."Service Item Entry Journal");
            ServItemEntryJournal.SETRANGE("Journal Batch Name", ServMgtSetup."S.Item Bin Entry Default Batch");
            ServItemEntryJournal.SETRANGE("Source Type", ServContractLine."Contract Type");
            ServItemEntryJournal.SETRANGE("Source Document No.", ServContractLine."Contract No.");
            ServItemEntryJournal.SETRANGE("Source Line No.", ServContractLine."Line No.");
            ServItemEntryJournal.SETRANGE("Entry Type", ServItemEntryJournal."Entry Type"::"Entrega Inicio Contrato Alquiler");
            IF ServItemEntryJournal.FINDSET THEN
                ServItemEntryJournal.DELETEALL(TRUE);


        END ELSE
            IF pServHeader."Service Order Type" = CraneMgtSetup."Serv. Order Type - Platf. Pick" THEN BEGIN
                //borrar planificacion de dias de la linea de contrato
                ServiceContractPlanning.DeleteAllReservation(Contracttype::Contract,
                                                             ServContractLine."Contract No.",
                                                             ServContractLine."Line No.",
                                                             ServContractLine."Service Item No.",
                                                             5964,
                                                             '');

                //Devolver fecha fin de la linea a la original.
                ServContractLine."Contract Expiration Date" := ServItemLine."Original Pickup Date";
                ServContractLine."Collection Planified" := FALSE;
                ServContractLine.MODIFY(TRUE);

                servContractHeader.GET(servContractHeader."Contract Type"::Contract, ServItemLine."Contract No.");
                servContractHeader."Expiration Date" := ServItemLine."Original Pickup Date";
                servContractHeader.MODIFY(TRUE);
                //planificar los dias tras devlver la fecha a la original
                ServiceContractPlanning.GenerateForWeekReservation(ServContractLine."Starting Date", //InitialDate
                                                                 ServContractLine."Contract Expiration Date", //EndDate
                                                                 1, //NWeeks
                                                                 ServContractLine."Contract Type", //Contracttype
                                                                 ServContractLine."Contract No.", //ContractNo
                                                                 ServContractLine."Line No.", //LineNo
                                                                 ServContractLine."Service Item No.", //ServiceitemNo
                                                                 5964, //SourceTable
                                                                 TRUE, //bOmitirCompletos
                                                                 TRUE, //bLunes
                                                                 TRUE, //bMartes
                                                                 TRUE, //bMiercoles
                                                                 TRUE, //bJueves
                                                                 TRUE, //bViernes
                                                                 ServContractLine."Use Saturdays", //bSabado
                                                                 ServContractLine."Use Sundays"); //bDomingo

                //borrar conceptos de recogida
                CLEAR(ContractConcepts);
                ContractConcepts.SETRANGE("Source Table", 5964);
                ContractConcepts.SETRANGE("Contract No.", ServContractLine."Contract No.");
                ContractConcepts.SETRANGE("Contract Type", ServContractLine."Contract Type");
                ContractConcepts.SETRANGE("Contract Line No.", ServContractLine."Line No.");
                ContractConcepts.SETRANGE("Concept No.", CraneMgtSetup."Platform Pickup Concept");
                ContractConcepts.SETRANGE("Service Order No.", pServHeader."No.");
                IF ContractConcepts.FINDSET THEN
                    ContractConcepts.DELETEALL(TRUE);

                //Eliminar el movimiento de maquina de recogida
                CLEAR(ServItemEntryJournal);
                ServItemEntryJournal.SETRANGE("Journal Template Name", SourceCodeSetup."Service Item Entry Journal");
                ServItemEntryJournal.SETRANGE("Journal Batch Name", ServMgtSetup."S.Item Bin Entry Default Batch");
                ServItemEntryJournal.SETRANGE("Source Type", ServContractLine."Contract Type");
                ServItemEntryJournal.SETRANGE("Source Document No.", ServContractLine."Contract No.");
                ServItemEntryJournal.SETRANGE("Source Line No.", ServContractLine."Line No.");
                ServItemEntryJournal.SETRANGE("Entry Type", ServItemEntryJournal."Entry Type"::"Recogida Fin Contrato Alquiler");
                IF ServItemEntryJournal.FINDSET THEN
                    ServItemEntryJournal.DELETEALL(TRUE);
            END;

        //Cerramos el contrato
        CLEAR(servContractHeader2);
        servContractHeader2.GET(servContractHeader."Contract Type", servContractHeader."Contract No.");
        IF bContractOpened THEN
            LockOpenContract.LockServContract(servContractHeader2);

        IF pServHeader."Service Order Type" = CraneMgtSetup."Serv. Order Type - Platf. Del." THEN BEGIN

            //Comprobar que la linea del producto de servicio esta en estado "inicial"
            //Comprobar que "Sent to device" en la linea del producto de servicio esta a "FALSE"
            TempServItemLine := ServItemLine;
            TempServItemLine.INSERT;

            ServItemLine.DELETE(TRUE);

            CLEAR(ServItemLine);

            WITH ServItemLine DO BEGIN
                INIT;
                bOmitirComprobarFacturarA(TRUE); //TODO: Error: El nombre bOmitirComprobarFacturarA no existe en este contexto
                SetHideDialogBox(TRUE);
                "Document No." := pServHeader."No.";
                "Document Type" := pServHeader."Document Type";
                "Repair Status Code" := PlannerSetup."Unassigned Repair Status Code";
                "Line No." := TempServItemLine."Line No.";
                "Crane Service Quote No." := TempServItemLine."Crane Service Quote No.";
                "Service Item Tariff No." := TempServItemLine."Service Item Tariff No.";
                "Service Inv. Group No." := TempServItemLine."Service Inv. Group No.";
                "Crane Serv. Quote Op. Line No" := TempServItemLine."Crane Serv. Quote Op. Line No";
                "Contract No." := TempServItemLine."Contract No.";
                "Contract Line No." := GetContractLineNo(TempServItemLine."Contract No.", TempServItemLine."Service Inv. Group No.");

                "Requested Starting Date" := TempServItemLine."Requested Starting Date";
                "Requested Starting Time" := TempServItemLine."Requested Starting Time";
                "Requested Ending Date" := TempServItemLine."Requested Ending Date";
                "Requested Ending Time" := TempServItemLine."Requested Ending Time";

                UpdateResponseTimeHours;
                INSERT(TRUE);
            END;
        END ELSE
            IF pServHeader."Service Order Type" = CraneMgtSetup."Serv. Order Type - Platf. Pick" THEN BEGIN
                //Si eliminamos una asignacion de recogida, al final elimino el Pedido.
                ServItemLine.DELETE(TRUE);
                ServHeader.GET(pServHeader."Document Type", pServHeader."No.");
                ServHeader.DELETE(TRUE);
            END;
    end;

    /// <summary>
    /// DeleteOrderAssignTruck()
    /// </summary>
    local procedure DeleteOrderAssignTruck(pServHeader: Record "Service Header"; pServItemNo: Code[20])
    var
        ServAllocationManagement: Codeunit "ServAllocationManagement";
        TempServItemLine: Record "Service Item Line" temporary;
        ServItemLine: Record "Service Item Line";
        ContractConcepts: Record "Contract Concepts_LDR";
    begin
        PlannerSetup.GET;

        //Obtenemos la Linea del PS Correspondiente
        CLEAR(ServItemLine);
        ServItemLine.SETRANGE(ServItemLine."Document Type", ServItemLine."Document Type"::Order);
        ServItemLine.SETRANGE(ServItemLine."Document No.", pServHeader."No.");
        ServItemLine.SETRANGE(ServItemLine."Service Item No.", pServItemNo); //Para en caso de que tenga otra linea asignada identificar la correcta.
        ServItemLine.FINDSET;

        //Se elimina la linea de asignacion de los recursos asociados a la linea del producto de servicio
        CLEAR(ServOrderAllocation);
        ServOrderAllocation.SetHideDialog(TRUE);
        ServOrderAllocation.SETRANGE("Document Type", ServOrderAllocation."Document Type"::Order);
        ServOrderAllocation.SETRANGE("Document No.", pServHeader."No.");
        ServOrderAllocation.SETRANGE("Service Item Line No.", ServItemLine."Line No."); //Filtrar solo por la linea que queremos borrar.
        ServOrderAllocation.DELETEALL(TRUE);

        ServItemLine.SetHideDialogBox(TRUE);
        ServItemLine.DELETE(TRUE);

        //Borrar conceptos del contrato si se elimina la asignación del camión/conductor
        CLEAR(ContractConcepts);
        ContractConcepts.SETRANGE("Source Table", 5964);
        ContractConcepts.SETRANGE("Contract No.", ServItemLine."Contract No.");
        ContractConcepts.SETRANGE("Contract Type", ContractConcepts."Contract Type"::Contract);
        //ContractConcepts.SETRANGE("Contract Line No.",ServContractLine."Line No."); //
        ContractConcepts.SETRANGE("Service Order No.", pServHeader."No.");
        IF ContractConcepts.FINDSET THEN
            ContractConcepts.DELETEALL(TRUE);
    end;

    /// <summary>
    /// ShowOrder()
    /// </summary>
    local procedure ShowOrder()
    var
        ServOrder: Page "Service Order";
    begin
        //CIC AJGONZALEZ, JLPINEIRO
        //Ver Pedido
        BEGIN
            ServHeader.GET(ServHeader."Document Type"::Order, Entry.ServOrderNo);
            ServHeader.SETRECFILTER;
            ServOrder.SETTABLEVIEW(ServHeader);
            ServOrder.RUN;
        END;
        //FIN AJGONZALEZ
    end;

    /// <summary>
    /// ChangeBinCustomer()
    /// </summary>
    local procedure ChangeBinCustomer()
    var
        ChangeServItemLocatCust: Report "Change Serv. Item Locat. Cust";
    begin
        //CIC AJGONZALEZ
        //Cambiar ubicacion cliente
        EVALUATE(LineNoAux, Entry.ServOrderLineNo);
        ServHeader.GET(ServHeader."Document Type"::Order, Entry.ServOrderNo);

        CLEAR(ServItemLine);
        ServItemLine.SETRANGE(ServItemLine."Document Type", ServItemLine."Document Type"::Order);
        ServItemLine.SETRANGE(ServItemLine."Document No.", Entry.ServOrderNo);
        ServItemLine.SETRANGE(ServItemLine."Line No.", LineNoAux);
        IF ServItemLine.FINDFIRST THEN BEGIN
            ServiceItem.GET(ServItemLine."Service Item No.");
            ServiceItem.SETRECFILTER;
            ChangeServItemLocatCust.SetData(ServItemLine."Service Item No.", ServHeader."Customer No.", ServHeader."Ship-to Code");
            ChangeServItemLocatCust.SETTABLEVIEW(ServiceItem);
            ChangeServItemLocatCust.RUN;
        END;
        //FIN AJGONZALEZ, JLPINEIRO
    end;

    /// <summary>
    /// ActiveServItemLineMobility()
    /// </summary>
    local procedure ActiveServItemLineMobility()
    var
        ServOrderNo: Code[20];
        LineNo: Integer;
        ServItemNo: Code[20];
    begin
        //CIC AJGONZALEZ
        CraneMgtSetup.GET;

        EVALUATE(ServOrderNo, Entry.ServOrderNo);
        EVALUATE(LineNo, Entry.ServOrderLineNo);
        EVALUATE(ServItemNo, Entry.ResourceNo);

        ServHeader.GET(ServHeader."Document Type"::Order, ServOrderNo);

        IF (ServHeader."Service Order Type" = CraneMgtSetup."Serv. Order Type - Platf. Pick") OR
          (ServHeader."Service Order Type" = CraneMgtSetup."Serv. Order Type - Platf. Del.") THEN BEGIN
            CLEAR(ServItemLine);
            ServItemLine.SETRANGE("Document Type", ServHeader."Document Type");
            ServItemLine.SETRANGE("Document No.", ServHeader."No.");
            ServItemLine.SETRANGE("Service Item No.", ServItemNo);
            ServItemLine.FINDFIRST;
        END ELSE BEGIN
            ServItemLine.GET(ServItemLine."Document Type"::Order, Entry.ServOrderNo, LineNo);
        END;

        //Se comprueba que la linea de producto de servicio esta en estado "Remitido"
        CLEAR(RepairStatus);
        RepairStatus.SETRANGE(Referred, TRUE);
        IF RepairStatus.FINDFIRST THEN
            ServItemLine.TESTFIELD("Repair Status Code", RepairStatus.Code);

        //Se comprueba que la fecha inicial de trabajo del recurso coincide con la de la linea del producto de servicio
        //Se comprueba que el estado del recurso esta "Activo"
        //Se comprueba que la linea del recurso esta marcada como "Responsable"
        ServOrderAllocation.SetHideDialog(TRUE);
        ServOrderAllocation.SETRANGE("Document Type", ServOrderAllocation."Document Type"::Order);
        ServOrderAllocation.SETRANGE("Document No.", ServItemLine."Document No.");
        ServOrderAllocation.SETRANGE("Service Item Line No.", ServItemLine."Line No.");
        ServOrderAllocation.SETRANGE(Status, ServOrderAllocation.Status::Active);
        ServOrderAllocation.SETRANGE(Responsible, TRUE);
        IF ServOrderAllocation.FINDFIRST THEN BEGIN
            IF (ServHeader."Service Order Type" = CraneMgtSetup."Serv. Order Type - Platf. Del.") OR
               (ServHeader."Service Order Type" = CraneMgtSetup."Serv. Order Type - Platf. Pick") THEN BEGIN
                ServItemLine.SETRANGE("Service Item No.");
                ServItemLine.FINDSET;
                ServItemLine.MODIFYALL("Sent to Device", TRUE, TRUE);
                ServItemLine.MODIFYALL("Repair Status Code", CraneMgtSetup."Sent to Device Repair Status");
            END ELSE BEGIN
                ServItemLine.VALIDATE("Sent to Device", TRUE);
                ServItemLine.VALIDATE("Repair Status Code", CraneMgtSetup."Sent to Device Repair Status");
                ServItemLine.MODIFY(TRUE);
            END;
        END;
        //FIN AJGONZALEZ
    end;

    /// <summary>
    /// AssignDriver()
    /// </summary>
    local procedure AssignDriver()
    var
        ServiceItemInvoiceGroup: Record "Service Item Invoice Group_LDR";
        ServItemNoAux: Code[20];
    begin
        //CIC AJGONZALEZ, JLPINEIRO
        //Asignamos conductor
        CraneMgtSetup.GET;

        EVALUATE(LineNoAux, Entry.ServOrderLineNo);
        EVALUATE(ServItemNoAux, Entry.ResourceNo);

        ServHeader.GET(ServHeader."Document Type"::Order, Entry.ServOrderNo);

        IF (ServHeader."Service Order Type" = CraneMgtSetup."Serv. Order Type - Platf. Pick") OR
          (ServHeader."Service Order Type" = CraneMgtSetup."Serv. Order Type - Platf. Del.") THEN BEGIN
            CLEAR(ServItemLine);
            ServItemLine.SETRANGE("Document Type", ServHeader."Document Type");
            ServItemLine.SETRANGE("Document No.", ServHeader."No.");
            ServItemLine.SETRANGE("Service Item No.", ServItemNoAux);
            ServItemLine.FINDFIRST;

            ServiceItemInvoiceGroup.GET(ServItemLine."Service Inv. Group No.");
            IF ServiceItemInvoiceGroup."Group Type" = ServiceItemInvoiceGroup."Group Type"::Platform THEN
                ERROR(Text003);

        END ELSE BEGIN
            ServItemLine.GET(ServItemLine."Document Type"::Order, Entry.ServOrderNo, LineNoAux);
        END;
        CLEAR(ServOrderAllocation);
        ServOrderAllocation.SetHideDialog(TRUE);
        ServOrderAllocation.SETRANGE("Document Type", ServItemLine."Document Type");
        ServOrderAllocation.SETRANGE("Document No.", ServItemLine."Document No.");
        ServOrderAllocation.SETRANGE("Service Item Line No.", ServItemLine."Line No.");
        ServOrderAllocation.SETRANGE(Responsible, TRUE);
        ServOrderAllocation.SETFILTER("Resource No.", '<>%1', '');
        ServOrderAllocation.SETRANGE(Status, ServOrderAllocation.Status::Active);
        IF ServOrderAllocation.FINDFIRST THEN
            ModifyDriver(ServOrderAllocation, ServItemLine)
        ELSE
            InsertDriver(ServItemLine, TRUE);
        //FIN AJGONZALEZ, JLPINEIRO
    end;

    /// <summary>
    /// AssignExtraResource()
    /// </summary>
    local procedure AssignExtraResource()
    begin
        //CIC AJGONZALEZ, JLPINEIRO
        //Asignamos operario secundario
        EVALUATE(LineNoAux, Entry.ServOrderLineNo);

        CLEAR(ServItemLine);
        ServItemLine.GET(ServItemLine."Document Type"::Order, Entry.ServOrderNo, LineNoAux);

        InsertExtraResource(ServItemLine);
    end;

    /// <summary>
    /// ResizeServiceOrderTask()
    /// </summary>
    local procedure ResizeServiceOrderTask()
    begin
        //CIC AJGONZALEZ, JLPINEIRO
        EVALUATE(LineNoAux, Entry.ServOrderLineNo);

        CLEAR(ServItemLine);
        ServItemLine.SETRANGE(ServItemLine."Document Type", ServItemLine."Document Type"::Order);
        ServItemLine.SETRANGE(ServItemLine."Document No.", Entry.ServOrderNo);
        ServItemLine.SETRANGE(ServItemLine."Line No.", LineNoAux);
        IF ServItemLine.FINDFIRST THEN BEGIN
            ServItemLine.VALIDATE("Requested Starting Date", Planner.GetDate(Entry.StartTime)); //TODO: Error: La Página Planner no contiene la definición GetDate
            ServItemLine.VALIDATE("Requested Starting Time", Planner.GetTime(Entry.StartTime)); //TODO: Error: La Página Planner no contiene la definición GetTime
            ServItemLine.VALIDATE("Requested Ending Date", Planner.GetDate(Entry.EndTime)); //TODO: Error: La Página Planner no contiene la definición GetDate
            ServItemLine.VALIDATE("Requested Ending Time", Planner.GetTime(Entry.EndTime)); //TODO: Error: La Página Planner no contiene la definición GetTime
            ServItemLine.MODIFY(TRUE);
        END;
        //FIN AJGONZALEZ
    end;

    /// <summary>
    /// CreateHoursPlanification()
    /// </summary>
    procedure CreateHoursPlanification(TempServContractLine: Record "Service Contract Line"; TempContractedHours: Integer)
    var
        bCompletado: BoolEAN;
        PeriodStart: Date;
        PeriodEnd: Date;
        Contador: Integer;
        Mensaje: Dialog;
        HorasContratadas: Integer;
        TempServContractLineHours: Record "Serv. Contract Line Hours_LDR";
    begin
        //JLPINEIRO
        TempServContractLine.TESTFIELD(TempServContractLine."Starting Date");
        TempServContractLine.TESTFIELD(TempServContractLine."Contract Expiration Date");
        PeriodStart := TempServContractLine."Starting Date";

        CLEAR(TempServContractLineHours);
        TempServContractLineHours.SETRANGE(TempServContractLineHours.Type, TempServContractLineHours.Type::External);
        TempServContractLineHours.SETRANGE(TempServContractLineHours."Contract Type", TempServContractLine."Contract Type");
        TempServContractLineHours.SETRANGE(TempServContractLineHours."Contract No.", TempServContractLine."Contract No.");
        TempServContractLineHours.SETRANGE(TempServContractLineHours."Contract Line No.", TempServContractLine."Line No.");
        IF TempServContractLineHours.FINDLAST THEN BEGIN
            HorasContratadas := TempServContractLineHours."Contracted hours";
            PeriodStart := TempServContractLineHours."End Date" + 1;
            IF PeriodStart > TempServContractLine."Contract Expiration Date" THEN
                EXIT;
        END;

        //Establecemos las horas contratadas pasadas por parametros
        HorasContratadas := TempContractedHours;

        bCompletado := FALSE;
        Contador := 1;

        REPEAT
            CASE TempServContractLine."Hours Period Review" OF
                TempServContractLine."Hours Period Review"::Month:
                    PeriodEnd := CALCDATE('<1M-1D>', PeriodStart);
                TempServContractLine."Hours Period Review"::"Two Months":
                    PeriodEnd := CALCDATE('<2M-1D>', PeriodStart);
                TempServContractLine."Hours Period Review"::Quarter:
                    PeriodEnd := CALCDATE('<3M-1D>', PeriodStart);
                TempServContractLine."Hours Period Review"::"Half Year":
                    PeriodEnd := CALCDATE('<6M-1D>', PeriodStart);
                TempServContractLine."Hours Period Review"::Year:
                    PeriodEnd := CALCDATE('<12M-1D>', PeriodStart);
                TempServContractLine."Hours Period Review"::None:
                    PeriodEnd := TempServContractLine."Contract Expiration Date";

            END;

            IF (PeriodEnd >= TempServContractLine."Contract Expiration Date") THEN BEGIN
                PeriodEnd := TempServContractLine."Contract Expiration Date";
                bCompletado := TRUE;
            END;

            TempServContractLineHours.INIT;
            TempServContractLineHours.VALIDATE(Type, TempServContractLineHours.Type::External);
            TempServContractLineHours.VALIDATE("Contract Type", TempServContractLine."Contract Type");
            TempServContractLineHours.VALIDATE("Contract No.", TempServContractLine."Contract No.");
            TempServContractLineHours.VALIDATE("Contract Line No.", TempServContractLine."Line No.");
            TempServContractLineHours.VALIDATE("Service Item No.", TempServContractLine."Service Item No.");
            TempServContractLineHours.VALIDATE("Starting Date", PeriodStart);
            TempServContractLineHours.VALIDATE("End Date", PeriodEnd);
            TempServContractLineHours.VALIDATE("Contracted hours", HorasContratadas);
            IF TempServContractLineHours."Starting Date" = TempServContractLine."Starting Date" THEN
                TempServContractLineHours.VALIDATE("Beginning hours", TempServContractLine."Exit No. of Hours");
            TempServContractLineHours.INSERT(TRUE);

            PeriodStart := PeriodEnd + 1;

            Contador := Contador + 1;
        UNTIL (bCompletado = TRUE);
        //JLPINEIRO
    end;

    /// <summary>
    /// DeleteHoursPlanification()
    /// </summary>
    procedure DeleteHoursPlanification(TempServContractLine: Record "Service Contract Line")
    var
        bCompletado: BoolEAN;
        PeriodStart: Date;
        PeriodEnd: Date;
        Contador: Integer;
        Mensaje: Dialog;
        HorasContratadas: Integer;
        TempServContractLineHours: Record "Serv. Contract Line Hours_LDR";
    begin
        CLEAR(TempServContractLineHours);
        TempServContractLineHours.SETRANGE(TempServContractLineHours.Type, TempServContractLineHours.Type::External);
        TempServContractLineHours.SETRANGE(TempServContractLineHours."Contract Type", TempServContractLine."Contract Type");
        TempServContractLineHours.SETRANGE(TempServContractLineHours."Contract No.", TempServContractLine."Contract No.");
        TempServContractLineHours.SETRANGE(TempServContractLineHours."Contract Line No.", TempServContractLine."Line No.");
        TempServContractLineHours.DELETEALL(TRUE);
    end;

    /// <summary>
    /// AssignTruck()
    /// </summary>
    procedure AssignTruck(pServOrderNo: Code[20]; pServItemLineNo: Integer)
    var
        NewServOrderAllocation: Record "Service Order Allocation";
        TruckList: Page "TruckList";
        NewServItemLine: Record "Service Item Line";
        OrderPlannerSetup: Record "Order Planner Setup_LDR";
        ServHeader: Record "Service Header";
        ServiceItemInvoiceGroup: Record "Service Item Invoice Group_LDR";
        FullCommentText: Text;
        ServiceOrderMgt: Codeunit "Service Order Mgt._LDR";
        CommentEditorMgt: Report "CommentEditorMgt";
        CommentType: Option General,Fault,Resolution,Accessory,Internal,"Service Item Loaner";
        servContractHeader: Record "Service Contract Header";
        servContractHeader2: Record "Service Contract Header";
        LockOpenContract: Codeunit "Lock-OpenServContract";
        bContractOpened: BoolEAN;
        ServContractLine: Record "Service Contract Line";
    begin
        CraneMgtSetup.GET;
        //JLPINEIRO
        //Mostrar lista de camiones disponibles.
        // EVALUATE(LineNoAux, Entry.ServOrderLineNo);

        // CLEAR(ServItemLine);
        // ServItemLine.GET(ServItemLine."Document Type"::Order,Entry.ServOrderNo,LineNoAux);

        ServItemLine.GET(ServItemLine."Document Type"::Order, pServOrderNo, pServItemLineNo);
        ServHeader.GET(ServItemLine."Document Type", ServItemLine."Document No.");

        //Invocar a la pag para seleccionar los camiones disponibles
        TruckList.LOOKUPMODE(TRUE);
        IF TruckList.RUNMODAL = ACTION::LookupOK THEN BEGIN

            TruckList.GETRECORD(ServiceItem);
            //Insertar linea con el camion seleccionado

            ServiceItemInvoiceGroup.GET(ServiceItem."Invoicing Group Code");

            NewServItemLine.INIT;
            NewServItemLine.bOmitirComprobarFacturarA(TRUE); //TODO: Error: El nombre bOmitirComprobarFacturarA no existe en este contexto
            NewServItemLine.SetHideDialogBox(TRUE);
            NewServItemLine."Document No." := ServItemLine."Document No.";
            NewServItemLine."Document Type" := ServItemLine."Document Type";
            NewServItemLine."Line No." := ServItemLine."Line No." + 10000;
            NewServItemLine."Crane Service Quote No." := ServItemLine."Crane Service Quote No.";

            NewServItemLine."Service Item Tariff No." := ServItemLine."Service Item Tariff No.";
            NewServItemLine."Service Inv. Group No." := ServiceItemInvoiceGroup.Code;
            NewServItemLine."Crane Serv. Quote Op. Line No" := ServItemLine."Crane Serv. Quote Op. Line No";

            IF ServHeader."Service Order Type" = CraneMgtSetup."Serv. Order Type - Platf. Del." THEN BEGIN
                NewServItemLine."Requested Starting Date" := ServItemLine."Requested Starting Date";
                NewServItemLine."Requested Starting Time" := ServItemLine."Requested Starting Time";
                //NewServItemLine."Requested Starting Time" := ServItemLine."Requested Starting Time"-3600000;
                NewServItemLine."Requested Ending Date" := ServItemLine."Requested Starting Date";
                NewServItemLine."Requested Ending Time" := ServItemLine."Requested Starting Time" + 3600000;
            END ELSE
                IF ServHeader."Service Order Type" = CraneMgtSetup."Serv. Order Type - Platf. Pick" THEN BEGIN
                    NewServItemLine."Requested Starting Date" := ServItemLine."Requested Ending Date";
                    NewServItemLine."Requested Starting Time" := ServItemLine."Requested Ending Time" - 3600000;
                    NewServItemLine."Requested Ending Date" := ServItemLine."Requested Ending Date";
                    NewServItemLine."Requested Ending Time" := ServItemLine."Requested Ending Time";
                    //NewServItemLine."Requested Ending Time" := ServItemLine."Requested Ending Time"+3600000;
                END;
            NewServItemLine.INSERT(TRUE);

            NewServItemLine.SetHideDialogBox(TRUE);
            NewServItemLine.VALIDATE("Service Item No.", ServiceItem."No.");
            //Si tiene recurso preferido igualamos ese recurso en la asignacion
            ServOrderAllocation.SetHideDialog(TRUE);
            ServOrderAllocation.SETRANGE("Document Type", ServOrderAllocation."Document Type"::Order);
            ServOrderAllocation.SETRANGE("Document No.", NewServItemLine."Document No.");
            ServOrderAllocation.SETRANGE("Service Item Line No.", NewServItemLine."Line No.");
            //Se completan la asignacion de "Service Order Allocation"
            IF ServiceItem."Preferred Resource" <> '' THEN BEGIN
                IF ServOrderAllocation.FINDFIRST THEN BEGIN
                    ServOrderAllocation.VALIDATE("Resource No.", ServiceItem."Preferred Resource");
                    ServOrderAllocation.Responsible := TRUE;
                    ServOrderAllocation.VALIDATE(Status, ServOrderAllocation.Status::Active);
                    ServOrderAllocation.VALIDATE("Allocation Date", NewServItemLine."Allocated Date");
                    ServOrderAllocation.VALIDATE("Starting Time", NewServItemLine."Requested Starting Time");
                    ServOrderAllocation.VALIDATE("Finishing Time", NewServItemLine."Requested Ending Time");
                    //ServOrderAllocation.VALIDATE("Allocation Date",Planner.GetDate(Entry.StartTime));
                    //ServOrderAllocation.VALIDATE("Starting Time",Planner.GetTime(Entry.StartTime));
                    //ServOrderAllocation.VALIDATE("Finishing Time",Planner.GetTime(Entry.EndTime));
                    ServOrderAllocation.VALIDATE(ServOrderAllocation."Allocated Hours",
                                          (ServOrderAllocation."Finishing Time" - ServOrderAllocation."Starting Time") / 3600000);
                    ServOrderAllocation.VALIDATE(ServOrderAllocation."Starting Time", ServOrderAllocation."Starting Time");
                    ServOrderAllocation.VALIDATE(ServOrderAllocation."Finishing Time", ServOrderAllocation."Finishing Time");
                    //ServOrderAllocation.VALIDATE(ServOrderAllocation."Starting Time",ServOrderAllocation."Starting Time" + 7200000);
                    //ServOrderAllocation.VALIDATE(ServOrderAllocation."Finishing Time",ServOrderAllocation."Finishing Time" + 7200000);
                    ServOrderAllocation.MODIFY(TRUE);

                    CLEAR(RepairStatus);
                    RepairStatus.SETRANGE(Referred, TRUE);
                    IF RepairStatus.FINDFIRST THEN
                        NewServItemLine.VALIDATE("Repair Status Code", RepairStatus.Code);

                END;
            END ELSE BEGIN //Si no tiene se inicia la linea de asignacion vacia y se pone el estado a pendiente recurso.
                OrderPlannerSetup.GET;
                NewServItemLine.VALIDATE("Repair Status Code", OrderPlannerSetup."Pending Res. Rep. Status Code");
            END;
            //Si el producto de servicio no tiene "Cod. Recurso Preferido", se cambia el estado al configurado como
            //"Cod Estado Reparacion Recurso Pendiente"
            NewServItemLine.MODIFY(TRUE);
            //JLPINEIRO

            //Buscamos el contrato
            servContractHeader.GET(servContractHeader."Contract Type"::Contract, ServItemLine."Contract No.");
            //abrimos el contrato
            bContractOpened := servContractHeader."Change Status" = servContractHeader."Change Status"::Locked;
            IF bContractOpened THEN
                LockOpenContract.OpenServContract(servContractHeader);

            ServContractLine.GET(ServContractLine."Contract Type"::Contract, ServItemLine."Contract No.", ServItemLine."Contract Line No.");

            //Agregar el concepto de entrega/recogida
            IF ServHeader."Service Order Type" = CraneMgtSetup."Serv. Order Type - Platf. Del." THEN
                CreateContractConcepts(ServContractLine, ServHeader, CraneMgtSetup."Platform Delivery Concept")
            ELSE
                IF ServHeader."Service Order Type" = CraneMgtSetup."Serv. Order Type - Platf. Pick" THEN
                    CreateContractConcepts(ServContractLine, ServHeader, CraneMgtSetup."Platform Pickup Concept");

            //Cerramos el contrato
            CLEAR(servContractHeader2);
            servContractHeader2.GET(servContractHeader."Contract Type", servContractHeader."Contract No.");
            IF bContractOpened THEN
                LockOpenContract.LockServContract(servContractHeader2);

            //COmentario
            CLEAR(FullCommentText);
            FullCommentText := ServiceOrderMgt.CreatePlatformComments(ServHeader, ServItemLine, 1);
            CommentEditorMgt.InsertComments(DATABASE::"Service Header", NewServItemLine."Document No.", NewServItemLine."Line No.", CommentType::Fault, FullCommentText);
        END;
    end;

    /// <summary>
    /// SetSelfTransport()
    /// </summary>
    procedure SetSelfTransport(pServOrderNo: Code[20]; pServItemLineNo: Integer)
    var
        NewServOrderAllocation: Record "Service Order Allocation";
        TruckList: Page "TruckList";
        NewServItemLine: Record "Service Item Line";
        OrderPlannerSetup: Record "Order Planner Setup_LDR";
        ServHeader: Record "Service Header";
        ServiceItemInvoiceGroup: Record "Service Item Invoice Group_LDR";
        FullCommentText: Text;
        ServiceOrderMgt: Codeunit "Service Order Mgt._LDR";
        CommentEditorMgt: Report "CommentEditorMgt";
        CommentType: Option General,Fault,Resolution,Accessory,Internal,"Service Item Loaner";
        servContractHeader: Record "Service Contract Header";
        servContractHeader2: Record "Service Contract Header";
        LockOpenContract: Codeunit "Lock-OpenServContract";
        bContractOpened: BoolEAN;
        ServContractLine: Record "Service Contract Line";
        ServItem: Record "Service Item";
        ServItemEntryJournal: Record "Serv.Item. Entry Journal_LDR";
    begin
        CraneMgtSetup.GET;

        ServItemLine.GET(ServItemLine."Document Type"::Order, pServOrderNo, pServItemLineNo);
        ServHeader.GET(ServItemLine."Document Type", ServItemLine."Document No.");

        //Buscamos el contrato
        servContractHeader.GET(servContractHeader."Contract Type"::Contract, ServItemLine."Contract No.");
        //abrimos el contrato
        bContractOpened := servContractHeader."Change Status" = servContractHeader."Change Status"::Locked;
        IF bContractOpened THEN
            LockOpenContract.OpenServContract(servContractHeader);

        ServContractLine.GET(ServContractLine."Contract Type"::Contract, ServItemLine."Contract No.", ServItemLine."Contract Line No.");

        IF ServHeader."Service Order Type" = CraneMgtSetup."Serv. Order Type - Platf. Del." THEN
            ServContractLine."Delivery Realiced" := TRUE
        ELSE
            IF ServHeader."Service Order Type" = CraneMgtSetup."Serv. Order Type - Platf. Pick" THEN
                ServContractLine."Collection Realiced" := TRUE;

        //Cerramos el contrato
        CLEAR(servContractHeader2);
        servContractHeader2.GET(servContractHeader."Contract Type", servContractHeader."Contract No.");
        IF bContractOpened THEN
            LockOpenContract.LockServContract(servContractHeader2);

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
                        PostServItemJournal(ServItemEntryJournal."Entry Type"::"Entrega Inicio Contrato Alquiler", ServContractLine, ServItem);
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
                            PostServItemJournal(ServItemEntryJournal."Entry Type"::"Recogida Fin Contrato Alquiler", ServContractLine, ServItem);
                        END;
                    UNTIL ServItemLine.NEXT = 0;
                END;
            END;

        ServItemLine.VALIDATE("Repair Status Code", CraneMgtSetup."Finished Repair Status");
        ServItemLine.MODIFY(TRUE);
    end;

    /// <summary>
    /// ShowServiceItem()
    /// </summary>
    local procedure ShowServiceItem()
    var
        ServiceItem: Page "Service Item Card";
        ServiceItemTable: Record "Service Item";
    begin
        //JLPINEIRO
        //Funcion que muestra la ficha del producto de servicio.
        IF ServiceItemTable.GET(Entry.ResourceNo) THEN BEGIN
            ServiceItemTable.SETRECFILTER;
            ServiceItem.SETTABLEVIEW(ServiceItemTable);
            ServiceItem.RUNMODAL;
        END;
        //JLPINEIRO
    end;

    /// <summary>
    /// CheckServContractHeaderDateChange()
    /// </summary>
    local procedure CheckServContractHeaderDateChange(pServContractNo: Code[20]; pServContractLine: Record "Service Contract Line"; pDate: Date; pDateType: Option Starting,Ending): BoolEAN
    var
        ServContractHeader: Record "Service Contract Header";
        ServContractLine: Record "Service Contract Line";
    begin
        ServContractHeader.GET(ServContractHeader."Contract Type"::Contract, pServContractNo);

        IF pDateType = pDateType::Starting THEN BEGIN
            CLEAR(ServContractLine);

            ServContractLine.SETRANGE("Contract Type", ServContractHeader."Contract Type");
            ServContractLine.SETRANGE("Contract No.", ServContractHeader."Contract No.");
            ServContractLine.SETFILTER("Line No.", '<>%1', pServContractLine."Line No.");
            IF NOT ServContractLine.FINDFIRST THEN //No hay mas lineas que la que estamos procesando.
                EXIT(TRUE);
        END ELSE BEGIN
            CLEAR(ServContractLine);

            ServContractLine.SETRANGE("Contract Type", ServContractHeader."Contract Type");
            ServContractLine.SETRANGE("Contract No.", ServContractHeader."Contract No.");
            ServContractLine.SETFILTER("Line No.", '<>%1', pServContractLine."Line No.");
            IF NOT ServContractLine.FINDSET THEN BEGIN
                REPEAT
                    IF ServContractLine."Contract Expiration Date" = ServContractHeader."Expiration Date" THEN
                        EXIT(TRUE);
                UNTIL ServContractLine.NEXT = 0;
            END;
        END;
    end;

    /// <summary>
    /// ServItemHasOpenPickups()
    /// </summary>
    procedure ServItemHasOpenPickups(pServItem: Record "Service Item"): BoolEAN
    var
        ServContractLine: Record "Service Contract Line";
    begin

        CLEAR(ServContractLine);
        ServContractLine.SETRANGE("Contract Type", ServContractLine."Contract Type"::Contract);
        ServContractLine.SETRANGE("Service Item No.", pServItem."No.");
        ServContractLine.SETRANGE("Collection Planified", TRUE);
        ServContractLine.SETRANGE("Collection Realiced", FALSE);
        ServContractLine.SETRANGE(Historical, FALSE);

        EXIT(ServContractLine.FINDFIRST);
    end;

    /// <summary>
    /// ExistOtherServContractLine()
    /// </summary>
    local procedure ExistOtherServContractLine(pSourceContractLine: Record "Service Contract Line"): BoolEAN
    var
        ServContractLine2: Record "Service Contract Line";
    begin
        CLEAR(ServContractLine2);

        ServContractLine2.SETRANGE("Contract Type", pSourceContractLine."Contract Type");
        ServContractLine2.SETRANGE("Contract No.", pSourceContractLine."Contract No.");
        ServContractLine2.SETFILTER("Line No.", '<>%1', pSourceContractLine."Line No.");
        ServContractLine2.SETRANGE("Serv. Item Invoice Group Code", pSourceContractLine."Serv. Item Invoice Group Code");
        IF ServContractLine2.FINDFIRST THEN
            EXIT(TRUE)
        ELSE
            EXIT(FALSE);
    end;

    /// <summary>
    /// GetContractLineNo()
    /// </summary>
    local procedure GetContractLineNo(pContractNo: Code[20]; pItemGroupNo: Code[10]) LineNo: Integer
    var
        ServiceContractLine: Record "Service Contract Line";
    begin
        ServiceContractLine.SETRANGE("Contract No.", pContractNo);
        ServiceContractLine.SETRANGE("Serv. Item Invoice Group Code", pItemGroupNo);
        ServiceContractLine.SETRANGE("Service Item No.", '');
        IF ServiceContractLine.FINDFIRST THEN
            LineNo := ServiceContractLine."Line No.";
    end;

    /// <summary>
    /// HasServOrders()
    /// </summary>
    procedure HasServOrders(pServItempNo: Code[20]; pDate: Date): BoolEAN
    begin
        CLEAR(ServItemLine);
        ServItemLine.SETRANGE("Document Type", ServItemLine."Document Type"::Order);
        ServItemLine.SETRANGE("Service Item No.", pServItempNo);
        ServItemLine.SETRANGE("Requested Starting Date", pDate);

        EXIT(NOT ServItemLine.ISEMPTY);
    end;
    */
}